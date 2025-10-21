unit eCCTDEF;

interface

uses
  IcTypes, IcConv, NexPath, TxtCut, dCCTDEF,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCctdefHne=class(TCctdefDat)
  private
    procedure ClrCctDef; // Vyma�e obsah datab�zov�ho s�boru CCTDEF.BTR
    procedure ImpCctDef; // Naimportuje polo�ky zo s�boru CCTDEF.CSV
  public
    procedure Open; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

procedure TCctdefHne.ClrCctDef; // Vyma�e obsah datab�zov�ho s�boru CCTDEF.BTR
begin
  If Count>0 then begin
    Repeat
      First;
      Delete;
      Application.ProcessMessages;
    until (Count=0);
  end;
end;

procedure TCctdefHne.ImpCctDef; // Naimportuje polo�ky zo s�boru CCTDEF.CSV
var mCut:TTxtCut;  mTxt:TStrings; mBasCod:Str10;  mCnt:word;
begin
  mCut:=TTxtCut.Create;  mCut.SetSeparator(';');  mCut.SetDelimiter('');
  mTxt:=TStringList.Create;
  mTxt.LoadFromFile(gPath.SysPath+'CCTDEF.CSV');
  If mTxt.Count>0 then begin
    mCnt:=0;
    Repeat
      mCut.SetStr(mTxt.Strings[mCnt]);
      mBasCod:=mCut.GetText(1);
      If (mBasCod<>'') then begin
        Insert;
        BasCod:=mBasCod;
        BasNam:=DosStrToWinStr2(mCut.GetText(2));
        Post;
      end;
      Application.ProcessMessages;
      Inc(mCnt);
    until mCnt=mTxt.Count;
  end;
  FreeAndNil(mTxt);
  FreeAndNil(mCut);
end;

// **************************************** PUBLIC ********************************************

procedure TCctdefHne.Open;
begin
  If FileExists(gPath.SysPath+'CCTDEF.CSV') then begin
    ClrCctDef; // Vyma�e obsah datab�zov�ho s�boru CCTDEF.BTR
    ImpCctDef; // Naimportuje polo�ky zo s�boru CCTDEF.CSV
    DeleteFile(gPath.SysPath+'CCTDEF.CSV');
  end;
  inherited ;
end;

end.
