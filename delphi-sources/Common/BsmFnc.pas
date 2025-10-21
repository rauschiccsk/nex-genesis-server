unit BsmFnc;
// =============================================================================
//                           FUNKCIE BANKOV�HO V�PISU
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// BSMDOC.BTR - hlavi�ky bankov�ch v�pisov
// BSMITM.BTR - polo�ky bankov�ch v�pisov
// BSMCAT.BTR - katal�g bankov�ch oper�cii
// PAYJRN.BTR - denn�k �hrady fakt�r
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// NewSerNum - Hodnota funkcie je nasleduj�ce poradov� ��slo dokladu pre dan� rok
//             � pDocYer - rok (yy) do ktor�ho bude zaevidovan� doklad
// CrtDocNum - Hodnota funkcie je intern� ��slo dokladu, ktor� vygeneruje na z�k-
//             lade zadan�ch parametrov.
//             � pDocYer - rok do ktor�ho patr� doklad
//             � pBokNum - ��slo knihy, do ktor�ho bude zaevidovan� doklad
//             � pSerNum - poradov� ��slo dokladu
// NewItmNum - Hodnota funkcie je nasleduj�ce ��slo polo�ky bankov�ho v�pisu
//             � pDocNum - ��slo doklau bankov�ho v�pisu
// TmpItmRef - Obnov� �daje aktu�lnej polo�ky docasn�ho suboru z BTR
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[28.02.2019] - Nov� funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, Prp, BasFnc, Cnt, eBSMDOC, eBSMITM, tBSMITM, tBSMCIT, eBSMCAT, ePAYJRN,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TBsmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oActBok:Str3;         // Aktu�lna kniha dokladov
    oxBSMDOC:TBsmdocHne;
    oxBSMITM:TBsmitmHne;
    ohBSMDOC:TBsmdocHne;
    ohBSMITM:TBsmitmHne;
    ohBSMCAT:TBsmcatHne;
    ohPAYJRN:TPayjrnHne;
    otBSMITM:TBsmitmTmp;
    otBSMCIT:TBsmcitTmp;
    function NewSerNum(pDocYer:Str2):longint;
    function GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
    function NewItmNum(pDocNum:Str12):longint;
    procedure TmpItmRef;  // Obnov� �daje aktu�lnej polo�ky docasn�ho suboru
  published
    property ActBok:Str3 read oActBok write oActBok;     // Aktu�lna kniha dokladov
  end;

implementation

// ********************************** OBJECT ***********************************

constructor TBsmFnc.Create;
begin
  oxBSMDOC:=TBsmdocHne.Create;
  oxBSMITM:=TBsmitmHne.Create;
  ohBSMDOC:=TBsmdocHne.Create;
  ohBSMITM:=TBsmitmHne.Create;
  ohBSMCAT:=TBsmcatHne.Create;
  ohPAYJRN:=TPayjrnHne.Create;
  otBSMITM:=TBsmitmTmp.Create;
  otBSMCIT:=TBsmcitTmp.Create;
end;

destructor TBsmFnc.Destroy;
begin
  FreeAndNil(otBSMCIT);
  FreeAndNil(otBSMITM);
  FreeAndNil(ohPAYJRN);
  FreeAndNil(ohBSMCAT);
  FreeAndNil(ohBSMITM);
  FreeAndNil(ohBSMDOC);
  FreeAndNil(oxBSMITM);
  FreeAndNil(oxBSMDOC);
end;

// ******************************** PRIVATE ************************************

// ******************************** PUBLIC *************************************

function TBsmFnc.NewSerNum(pDocYer:Str2):longint;
var mBokNum,mDocYer:ShortString;
begin
  If not oxBSMDOC.Active then oxBSMDOC.Open;
  mBokNum:='['+oxBSMDOC.FieldNum('BokNum')+']={'+ActBok+'}';
  mDocYer:='['+oxBSMDOC.FieldNum('DocYer')+']={'+pDocYer+'}';
  oxBSMDOC.SwapIndex;
  oxBSMDOC.SetIndex('DyBnSn');
  oxBSMDOC.Table.ClearFilter;
  oxBSMDOC.Table.Filter:=mBokNum+'^'+mDocYer;
  oxBSMDOC.Table.Filtered:=TRUE;
  oxBSMDOC.Last;
  Result:=oxBSMDOC.SerNum+1;
end;

function TBsmFnc.GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:='BV'+pDocYer+ActBok+StrIntZero(pSerNum,5);
end;

function TBsmFnc.NewItmNum(pDocNum:Str12):longint;
begin
  Result:=1;
  If ohBSMITM.LocDocNum(pDocNum) then begin
    Repeat
      If ohBSMITM.ItmNum>Result then Result:=ohBSMITM.ItmNum;
      ohBSMITM.Next;
    until ohBSMITM.Eof or (ohBSMITM.DocNum<>pDocNum);
    Result:=Result+1;
  end;
end;

procedure TBsmFnc.TmpItmRef;
begin
  If ohBSMITM.GotoPos(otBSMITM.ActPos) then begin
    otBSMITM.Edit;
    BtrCpyTmp(ohBSMITM.Table,otBSMITM.TmpTable);
    otBSMITM.Post;
  end;
end;

end.


