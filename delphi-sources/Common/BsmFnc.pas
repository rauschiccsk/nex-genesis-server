unit BsmFnc;
// =============================================================================
//                           FUNKCIE BANKOVÉHO VÝPISU
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// BSMDOC.BTR - hlavièky bankových výpisov
// BSMITM.BTR - položky bankových výpisov
// BSMCAT.BTR - katalóg bankových operácii
// PAYJRN.BTR - denník úhrady faktúr
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// NewSerNum - Hodnota funkcie je nasledujúce poradové èíslo dokladu pre daný rok
//             › pDocYer - rok (yy) do ktorého bude zaevidovaný doklad
// CrtDocNum - Hodnota funkcie je interné èíslo dokladu, ktoré vygeneruje na zák-
//             lade zadaných parametrov.
//             › pDocYer - rok do ktorého patrí doklad
//             › pBokNum - èíslo knihy, do ktorého bude zaevidovaný doklad
//             › pSerNum - poradové èíslo dokladu
// NewItmNum - Hodnota funkcie je nasledujúce èíslo položky bankového výpisu
//             › pDocNum - èíslo doklau bankového výpisu
// TmpItmRef - Obnoví údaje aktuálnej položky docasného suboru z BTR
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[28.02.2019] - Nová funkcia (RZ)
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
    oActBok:Str3;         // Aktuálna kniha dokladov
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
    procedure TmpItmRef;  // Obnoví údaje aktuálnej položky docasného suboru
  published
    property ActBok:Str3 read oActBok write oActBok;     // Aktuálna kniha dokladov
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


