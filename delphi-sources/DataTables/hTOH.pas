unit hTOH;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, DocHand, bTOH, hTOI, hTOP, Key,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTohHnd = class (TTohBtr)
  private
  public
    function NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum(pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    procedure Clc(phTOI:TToiHnd);
    procedure ClcTOP(phTOP:TTopHnd);
  published
  end;

implementation

function TTohHnd.NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
begin
  Result:=gKey.TobSerNum[BtrTable.BookNum]+1;
  gKey.TobSerNum[BtrTable.BookNum]:=Result;
end;

function TTohHnd.GenDocNum(pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result:=GenToDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TTohHnd.Clc (phTOI:TToiHnd);
var mCValue,mDValue,mHValue,mAValue,mBValue:double;  mLiqItmQnt,mItmQnt,mZeroItmQnt,mCasNum:word;
    mCadNum,mTcdNum,mIcdNum,mOcdNum:Str12;  mGsQnt,mDlvQnt:double;
begin
  mCValue := 0;  mDValue := 0;   mHValue := 0;   mAValue := 0;   mBValue := 0;  mItmQnt := 0; mLiqItmQnt := 0;
  mCasNum := 0;  mCadNum := '';  mOcdNum := '';  mTcdNum := '';  mIcdNum := ''; mZeroItmQnt := 0;
  mDlvQnt := 0;  mGsQnt := 0;
  phTOI.SwapIndex;
  If phTOI.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mItmQnt);
      If phTOI.CasNum<>0  then mCasNum := phTOI.CasNum;
      If phTOI.CadNum<>'' then mCadNum := phTOI.CadNum;
      If phTOI.OcdNum<>'' then mOcdNum := phTOI.OcdNum;
      If phTOI.TcdNum<>'' then mTcdNum := phTOI.TcdNum;
      If phTOI.IcdNum<>'' then mIcdNum := phTOI.IcdNum;
      If (phTOI.CadNum<>'')or(phTOI.TcdNum<>'') then Inc(mLiqItmQnt);
      If IsNul(phTOI.GsQnt) then Inc(mZeroItmQnt);
      mGsQnt := mGsQnt+phTOI.GsQnt;
      mDlvQnt := mDlvQnt+phTOI.DlvQnt;
      mCValue := mCValue+phTOI.CValue;
      mDValue := mDValue+phTOI.DValue;
      mHValue := mHValue+phTOI.HValue;
      mAValue := mAValue+phTOI.AValue;
      mBValue := mBValue+phTOI.BValue;
      phTOI.Next;
    until (phTOI.Eof) or (phTOI.DocNum<>DocNum);
  end;
  phTOI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  Edit;
  CValue := Rd2(mCValue);
  DValue := Rd2(mDValue);
  HValue := Rd2(mHValue);
  AValue := Rd2(mAValue);
  BValue := Rd2(mBValue);
//  CasNum := mCasNum;
  CadNum := mCadNum;
  TcdNum := mTcdNum;
  IcdNum := mIcdNum;
  OcdNum := mOcdNum;
  ItmQnt := mItmQnt;
  If mItmQnt>0 then begin
    case gKey.TobSadGen[BtrTable.BookNum] of
         0: begin // Klasicke - pre Solidstav
              If (mItmQnt=mZeroItmQnt) then Status := 'E'
              else If (mItmQnt=mLiqItmQnt+mZeroItmQnt)
                then Status := 'A'
                else If Status='A' then Status := 'E';
            end;
         1: begin // Pozicne - pre Inspiro
              If IsNul(mGsQnt-mDlvQnt)
                then Status := 'A'
                else If Status='A' then Status := 'E';
            end;
    end;
  end;
  Post;
end;

procedure TTohHnd.ClcTop(phTOP:TTopHnd);
var mTopCnt,mOutCnt:word;
begin
  mTopCnt := 0;  mOutCnt := 0;
  phTOP.SwapIndex;
  If phTOP.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mTopCnt);
      If (phTOP.OutQnt>0)or(phTOP.ReoNum>0) then Inc (mOutCnt);
      phTOP.Next;
    until (phTOP.Eof) or (phTOP.DocNum<>DocNum);
  end;
  phTOP.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  Edit;
  TopCnt := mTopCnt;
  OutCnt := mOutCnt;
  Post;
end;

end.
