unit hTCH;

interface

uses
  IcTypes, IcConv, IcTools, IcValue, IcVariab, NexPath, NexGlob, NexIni, NexText, bTCH, hTCI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTchHnd = class (TTchBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    function GetBokNum:Str5; // Cislo otvorenej knihy

    procedure Insert; overload;
    procedure Del(pDocNum:Str12);
    procedure Clc(phTCI:TTciHnd);   // prepocita hlavicku podla jeho poloziek
    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Urs(pYear:Str2;pSerNum:longint); // Odrezervuje doklad so zadanym poradovym cislom
    procedure New(pYear:Str2); // Zarezervuje novy nasledujuco doklad

    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    function  IsMyRes: boolean;
    function  IsRes: boolean;

    property BokNum:Str5 read GetBokNum;
    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

function TTchHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TTchHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenTcDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TTchHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result := 0;
  case pVatGrp of
    1: Result := VatPrc1;
    2: Result := VatPrc2;
    3: Result := VatPrc3;
    4: Result := VatPrc4;
    5: Result := VatPrc5;
  end;
end;

function TTchHnd.GetBokNum:Str5; // Cislo otvorenej knihy
begin
  Result := BtrTable.BookNum;
end;

procedure TTchHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
  VatPrc4 := gIni.GetVatPrc(4);
  VatPrc5 := gIni.GetVatPrc(5);
end;

procedure TTchHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TTchHnd.Clc (phTCI:TTciHnd);
var mItmQnt,mCntOut,mCntExp:longint; mDstPair:Str1; mBonNum,mVatQnt,I:byte;
    mAcCValue,mAcDValue,mAcDscVal,mAcRndVal:double; mVolume,mWeight:double;
    mFgCValue,mFgDValue,mFgDBValue,mFgDscVal,mFgDscBVal,mFgHdsVal,mFgRndVal:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;  mSpMark:Str10;  mIcdNum:Str14; mOcdNum:Str14;
begin
  mVolume := 0;  mWeight := 0;  mSpMark := '';
  mItmQnt := 0;  mCntOut := 0;  mCntExp := 0;
  mAcCValue := 0;  mAcDValue := 0;  mAcDscVal := 0;  mAcRndVal := 0;
  mFgCValue := 0;  mFgDValue := 0;  mFgDscVal := 0;  mFgRndVal := 0;
  mFgDBValue := 0; mFgDscBVal := 0; mFgHdsVal := 0;
  mAcAValue := TValue8.Create;  mAcAValue.Clear;
  mAcBValue := TValue8.Create;  mAcBValue.Clear;
  mFgAValue := TValue8.Create;  mFgAValue.Clear;
  mFgBValue := TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I] := VatPrc[I];
    mAcBValue.VatPrc[I] := VatPrc[I];
    mFgAValue.VatPrc[I] := VatPrc[I];
    mFgBValue.VatPrc[I] := VatPrc[I];
  end;
  phTCI.SwapIndex;
  mDstPair := 'N';  mIcdNum := ''; mOcdNum := '';
  If phTCI.LocateDocNum (DocNum) then begin
    mDstPair := 'Q';
    Repeat
      Inc (mItmQnt);
      If mIcdNum<>'' then begin
        If copy(mIcdNum,1,12)<>phTCI.IcdNum then mIcdNum := mIcdNum+'>>';
      end
      else mIcdNum := phTCI.IcdNum;
      If mOcdNum<>'' then begin
        If copy(mOcdNum,1,12)<>phTCI.OcdNum then mOcdNum := mOcdNum+'>>';
      end
      else mOcdNum := phTCI.OcdNum;
      mVolume := mVolume+phTCI.Volume;
      mWeight := mWeight+phTCI.Weight;
      // Uctovna mena
      mAcCValue := mAcCValue+phTCI.AcCValue;
      mAcDValue := mAcDValue+phTCI.AcDValue;
      mAcDscVal := mAcDscVal+phTCI.AcDscVal;
      mAcRndVal := mAcRndVal+phTCI.AcRndVal;
      // Vyuctovacia mena
      mFgCValue := mFgCValue+phTCI.FgCValue;
      mFgDValue := mFgDValue+phTCI.FgDValue;
      mFgDscVal := mFgDscVal+phTCI.FgDscVal;
      mFgHdsVal := mFgHdsVal+phTCI.FgHdsVal;
      mFgRndVal := mFgRndVal+phTCI.FgRndVal;
      mFgDBValue := mFgDBValue+Rd2(phTCI.FgDValue*(1+phTCI.VatPrc/100));
      mFgDscBVal := mFgDscBVal+Rd2(phTCI.FgDscVal*(1+phTCI.VatPrc/100));
      If mAcAValue.VatGrp(phTCI.VatPrc)=0 then begin // Neexistujuca sadzba DPH
        mVatQnt := mAcAValue.VatQnt;
        If mVatQnt<3 then begin
          mAcAValue.VatPrc[mVatQnt+1] := phTCI.VatPrc;
          mAcBValue.VatPrc[mVatQnt+1] := phTCI.VatPrc;
          mFgAValue.VatPrc[mVatQnt+1] := phTCI.VatPrc;
          mFgBValue.VatPrc[mVatQnt+1] := phTCI.VatPrc;
        end;
      end;
      mFgAValue.Add (phTCI.VatPrc,phTCI.FgAValue+phTCI.FgRndVal-phTCI.FgRndVat);
      mFgBValue.Add (phTCI.VatPrc,phTCI.FgBValue+phTCI.FgRndVal);
      If (phTCI.StkStat='S') or (phTCI.StkStat='E') or (phTCI.StkStat='C') or (phTCI.StkStat='X') then Inc (mCntOut);
      If (phTCI.StkStat='E') then Inc (mCntExp);
      If (phTCI.FinStat='') then mDstPair := 'N';
      If (phTCI.SpMark<>'') then mSpMark := phTCI.SpMark;
      If (phTCI.BonNum<>0) then mBonNum := phTCI.BonNum;
      phTCI.Next;
    until (phTCI.Eof) or (phTCI.DocNum<>DocNum);
  end;
  phTCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(VatDoc));
  Edit;
  IcdNum := mIcdNum;
  If OcdNum='' then OcdNum := mOcdNum;
  Volume := mVolume;
  Weight := mWeight;
  VatPrc1 := mAcAValue.VatPrc[1];
  VatPrc2 := mAcAValue.VatPrc[2];
  VatPrc3 := mAcAValue.VatPrc[3];
  If FgCourse=1 then begin
    If IsNotNul (mAcDValue)
      then DscPrc := Rd2 ((mAcDscVal/mAcDValue)*100)
      else DscPrc := 0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then DscPrc := Rd2 ((mFgDscVal/mFgDValue)*100)
      else DscPrc := 0;
  end;
  AcCValue := mAcCValue;
  AcDValue := Rd2(mFgDValue*FgCourse);
  AcDscVal := Rd2(mFgDscVal*FgCourse);
  AcAValue := Rd2(mFgAValue.Value[0]*FgCourse);
  AcVatVal := Rd2((mFgBValue.Value[0]-mFgAValue.Value[0])*FgCourse);
  AcBValue := Rd2(mFgBValue.Value[0]*FgCourse);
  AcAValue1 := Rd2(mFgAValue.Value[1]*FgCourse);
  AcAValue2 := Rd2(mFgAValue.Value[2]*FgCourse);
  AcAValue3 := Rd2(mFgAValue.Value[3]*FgCourse);
  AcAValue4 := Rd2(mFgAValue.Value[4]*FgCourse);
  AcAValue5 := Rd2(mFgAValue.Value[5]*FgCourse);

  AcBValue1 := Rd2(mFgBValue.Value[1]*FgCourse);
  AcBValue2 := Rd2(mFgBValue.Value[2]*FgCourse);
  AcBValue3 := Rd2(mFgBValue.Value[3]*FgCourse);
  AcBValue4 := Rd2(mFgBValue.Value[4]*FgCourse);
  AcBValue5 := Rd2(mFgBValue.Value[5]*FgCourse);

  AcRndVal := mAcRndVal;
  FgCValue := mFgCValue;
  FgDValue := mFgDValue;
  FgDBValue := mFgDBValue;
  FgDscBVal := mFgDscBVal;
  FgDscVal := mFgDscVal;
  FgHdsVal := mFgHdsVal;
  FgAValue := mFgAValue.Value[0];
  FgVatVal := mFgBValue.Value[0]-mFgAValue.Value[0];
  FgBValue := mFgBValue.Value[0];
  FgAValue1 := mFgAValue.Value[1];
  FgAValue2 := mFgAValue.Value[2];
  FgAValue3 := mFgAValue.Value[3];
  FgAValue4 := mFgAValue.Value[4];
  FgAValue5 := mFgAValue.Value[5];

  FgBValue1 := mFgBValue.Value[1];
  FgBValue2 := mFgBValue.Value[2];
  FgBValue3 := mFgBValue.Value[3];
  FgBValue4 := mFgBValue.Value[4];
  FgBValue5 := mFgBValue.Value[5];

  FgRndVal := mFgRndVal;
  If IsNotNul(mFgAValue.Value[0])
    then HdsPrc := Rd2 ((mFgHdsVal/(mFgHdsVal+mFgAValue.Value[0]))*100)
    else HdsPrc := 0;
  ItmQnt := mItmQnt;
  CntOut := mCntOut;
  CntExp := mCntExp;
  DstPair := mDstPair;
  SpMark := mSpMark;
  BonNum := mBonNum;
  Post;
  FreeAndNil (mAcAValue);  FreeAndNil (mFgAValue);
  FreeAndNil (mAcBValue);  FreeAndNil (mFgBValue);
end;

procedure TTchHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  Insert;
  Year := pYear;
  SerNum := pSerNum;
  DocNum := GenDocNum(pYear,pSerNum);
  DocDate := Date;
  DstLck := 9;
  PaName := gNt.GetSecText('STATUS','Reserve','Rezervovane pre: ')+gvSys.LoginName;
  Post;
end;

procedure TTchHnd.Urs(pYear:Str2;pSerNum:longint); // Odrezervuje doklad so zadanym poradovym cislom
begin
  If LocateYearSerNum(pYear,pSerNum) then begin
    If (DstLck=9) and (CrtUser=gvSys.LoginName) then Delete;
  end;
end;

procedure TTchHnd.New; // Zarezervuje novy nasledujuco doklad
begin
  Res(pYear,NextSerNum(pYear));
end;

function TTchHnd.IsMyRes: boolean;
begin
  Result:= (DstLck=9) and (CrtUser=gvSys.LoginName);
end;

function TTchHnd.IsRes: boolean;
begin
  Result:= (DstLck=9);
end;

procedure TTchHnd.ResVer;
begin
  If DstLck=9 then Delete;
end;

end.
