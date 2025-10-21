unit hCSH;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexText, NexIni, IcValue, Dochand, bCSH, hCSI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCshHnd = class (TCshBtr)
  private
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
  public
    procedure Insert; overload;

    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne chronologicke cislo dokladu
    function NextTypNum(pYear:Str2;pDocType:Str1):longint; // Najde nasledujuce volne typove cislo dokladu
    function GetBegVal:double; // Urci pociatocny stav pred novym dokladom
    function GenDocNum (pYear:Str2;pSerNum:longint;pDocType:Str1):Str12; // Vygeneruje interne cislo dokladu

    procedure Clc(phCSI:TCsiHnd);

    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

// ********************************* PRIVATE ***********************************

function TCshHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
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

// ********************************* PUBLIC ************************************

procedure TCshHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
  VatPrc4 := gIni.GetVatPrc(4);
  VatPrc5 := gIni.GetVatPrc(5);
end;

procedure TCshHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

function TCshHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TCshHnd.NextTypNum(pYear:Str2;pDocType:Str1):longint; // Najde nasledujuce volne typove cislo dokladu
begin
  SwapStatus;
  SetIndex (ixYearSerNum);
  //First;
  NearestYearSerNum(pYear,0);
  Result:=1;
  while not Eof do begin
    If (Year=pYear)and(DocType=pDocType)and(DocCnt>=Result) then Result:=DocCnt+1;
    Next;
  end;
  RestoreStatus;
end;

function TCshHnd.GetBegVal:double; // Urci pociatocny stav pred novym dokladom
begin
  SwapStatus;
  SetIndex (ixYearSerNum);
  Last;
  Result := PyEndVal;
  RestoreStatus;
end;

function TCshHnd.GenDocNum; // Vygeneruje interne cislo dokladu
begin
  Result:=GenCsDocNum(pYear,BtrTable.BookNum,pSerNum,pDocType);
end;

procedure TCshHnd.Clc(phCSI:TCsiHnd);
var I:byte; mItmQnt,mPaCode:longint;  mNotice:Str30;  mOcdNum:Str12;
    mPyIncVal,mPyExpVal:double; mAcAValue,mAcBValue,mPyAValue,mPyBValue:TValue8;
begin
  mItmQnt := 0;  mPaCode := 0;  mOcdNum := '';  mNotice := '';
  mPyIncVal := 0;  mPyExpVal := 0;
  mAcAValue := TValue8.Create;  mAcAValue.Clear;
  mAcBValue := TValue8.Create;  mAcBValue.Clear;
  mPyAValue := TValue8.Create;  mPyAValue.Clear;
  mPyBValue := TValue8.Create;  mPyBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I] := VatPrc[I];
    mAcBValue.VatPrc[I] := VatPrc[I];
    mPyAValue.VatPrc[I] := VatPrc[I];
    mPyBValue.VatPrc[I] := VatPrc[I];
  end;
  phCSI.SwapIndex;
  If phCSI.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAcAValue.Add (phCSI.VatPrc,phCSI.AcAValue);
      mAcBValue.Add (phCSI.VatPrc,phCSI.AcBValue);
      mPyAValue.Add (phCSI.VatPrc,phCSI.PyAValue);
      mPyBValue.Add (phCSI.VatPrc,phCSI.PyBValue);
      If mNotice='' then mNotice := phCSI.Describe;
      If mOcdNum='' then mOcdNum := phCSI.OcdNum;
      If (mPaCode=0) and (phCSI.PaCode<>0) then mPaCode := phCSI.PaCode;
      phCSI.Next;
    until (phCSI.Eof) or (phCSI.DocNum<>DocNum);
    If DocType='I'
      then mPyIncVal := mPyBValue.Value[0]
      else mPyExpVal := mPyBValue.Value[0];
  end;
  phCSI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  AcAValue := mAcAValue.Value[0];
  AcVatVal := mAcBValue.Value[0]-mAcAValue.Value[0];
  AcBValue := mAcBValue.Value[0];
  PyAValue := mPyAValue.Value[0];
  PyVatVal := mPyBValue.Value[0]-mPyAValue.Value[0];
  PyBValue := mPyBValue.Value[0];
  PyIncVal := mPyIncVal;
  PyExpVal := mPyExpVal;
  PyEndVal := PyBegVal+PyIncVal-PyExpVal;
  AcAValue1 := mAcAValue.Value[1];
  AcAValue2 := mAcAValue.Value[2];
  AcAValue3 := mAcAValue.Value[3];
  AcAValue4 := mAcAValue.Value[4];
  AcAValue5 := mAcAValue.Value[5];

  AcBValue1 := mAcBValue.Value[1];
  AcBValue2 := mAcBValue.Value[2];
  AcBValue3 := mAcBValue.Value[3];
  AcBValue4 := mAcBValue.Value[4];
  AcBValue5 := mAcBValue.Value[5];

  PyAValue1 := mPyAValue.Value[1];
  PyAValue2 := mPyAValue.Value[2];
  PyAValue3 := mPyAValue.Value[3];
  PyAValue4 := mPyAValue.Value[4];
  PyAValue5 := mPyAValue.Value[5];

  PyBValue1 := mPyBValue.Value[1];
  PyBValue2 := mPyBValue.Value[2];
  PyBValue3 := mPyBValue.Value[3];
  PyBValue4 := mPyBValue.Value[4];
  PyBValue5 := mPyBValue.Value[5];

  If Notice='' then Notice := mNotice;
  OcdNum := mOcdNum;
  ItmQnt := mItmQnt;
  Post;
end;


end.
