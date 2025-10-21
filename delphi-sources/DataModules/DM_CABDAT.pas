unit DM_CABDAT;

interface

uses
  IcVariab,
  IcConv, IcTypes, NexPath, NexBtrTable, PxTmpTable, NexText,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, BtrTable, NexTmpTable, IBCustomDataSet, IBTable, IBDatabase,
  LinkBtrTable, DBTables, PxTable, NexPxTable, ExtCtrls;

type
  TdmCAB = class(TDataModule)
    btCABLST: TNexBtrTable;
    ptCAI: TNexPxTable;
    btCAP: TNexBtrTable;
    btTBHx: TNexBtrTable;
    btTBIx: TNexBtrTable;
    ptTBIx: TNexPxTable;
    btCASSAS: TNexBtrTable;
    ptCDYEVL: TNexPxTable;
    ptCMGEVL: TNexPxTable;
    btCAH: TNexBtrTable;
    T_CabDat: TTimer;
    xbtSABLST: TNexBtrTable;
    btSAH: TNexBtrTable;
    btSAI: TNexBtrTable;
    ptSAI: TNexPxTable;
    ptSAG: TNexPxTable;
    btSAG: TNexBtrTable;
    ptCHEAD: TNexPxTable;
    ptCADVER: TNexPxTable;
    ptCASPAY: TNexPxTable;
    btCASPAY: TNexBtrTable;
    ptNSISUM: TNexPxTable;
    ptCGSEVL: TNexPxTable;
    btSADMOD: TNexBtrTable;
    ptNSISUM_S: TNexPxTable;
    ptSAH: TNexPxTable;
    ptCUSEVL: TNexPxTable;
    ptCUSEVA: TNexPxTable;
    ptCUREVL: TNexPxTable;
    btCASUSR: TNexBtrTable;
    btBLKLST: TNexBtrTable;
    btBLKITM: TNexBtrTable;
    btSAC: TNexBtrTable;
    ptCSDLST: TNexPxTable;
    ptCSDITM: TNexPxTable;
    ptSabVer: TNexPxTable;
    ptSabVerW: TNexPxTable;
    btCASORD: TLinkBtrTable;
    ptSAC: TNexPxTable;
    ptNSCSUM: TNexPxTable;
    ptNSCSum_S: TNexPxTable;
    ptCACITM: TNexPxTable;
    ptCACUSR: TNexPxTable;
    ptPAYEVL: TNexPxTable;
    btCASLST: TNexBtrTable;
    btCAPADV: TNexBtrTable;
    btCRDTRN: TNexBtrTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure T_CabDatTimer(Sender: TObject);
  private
    oActCasNum: word;
  public
    procedure LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
    procedure OpenBase (var pTable:TNexBtrTable);
    procedure OpenList (var pTable:TNexBtrTable; pListNum:longint);
    procedure OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);

    procedure OpenCAP  (pCasNum:word);

    procedure CBI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSH do ptTSH
    procedure SAI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSH do ptTSH
    procedure SAC_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSH do ptTSH

    function GetActCasNum: longint;
  end;

var
  dmCAB: TdmCAB;

implementation

{$R *.DFM}

procedure TdmCAB.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName := gPath.CabPath;
      (Components[I] as TNexBtrTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName := gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName := gPath.SubPrivPath;
  end;
end;

procedure TdmCAB.LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
var mTable:TNexBtrTable;
begin
  mTable := (FindComponent (pTable.Name)) as TNexBtrTable;
  If mTable<>nil then begin // Nasli sme databazu
    pTable.DefName := mTable.DefName;
    pTable.FixedName := mTable.FixedName;
    pTable.TableName := mTable.TableName;
  end;
end;

procedure TdmCAB.OpenBase (var pTable:TNexBtrTable);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.CabPath;
  pTable.Open;
end;

procedure TdmCAB.OpenList (var pTable:TNexBtrTable; pListNum:longint);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := StrIntZero(pListNum,5);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.CabPath;
  pTable.TableName := pTable.FixedName+pTable.BookNum;
  pTable.Open;
end;

procedure TdmCAB.OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);
begin
  If pTable.Active and (pTable.BookNum=pBookNum) then Exit;
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := pBookNum;
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.CabPath;
  pTable.TableName := pTable.FixedName+pBookNum;
  pTable.Open;
end;

procedure TdmCAB.OpenCAP(pCasNum:word);
begin
  oActCasNum := pCasNum;
  If btCAP.Active then btCAP.Close;
  btCAP.TableName := btCAP.FixedName+StrIntZero(pCasNum,5);
  btCAP.Open;
end;

procedure TdmCAB.CBI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSH do ptTSH
begin
  pPxTable.FieldByName('DocNum').AsString := pBtTable.FieldByName('DocNum').AsString;
  pPxTable.FieldByName('GsCode').AsInteger := pBtTable.FieldByName('GsCode').AsInteger;
  pPxTable.FieldByName('MgCode').AsInteger := pBtTable.FieldByName('MgCode').AsInteger;
  pPxTable.FieldByName('GsName').AsString := pBtTable.FieldByName('GsName').AsString;
  pPxTable.FieldByName('BarCode').AsString := pBtTable.FieldByName('BarCode').AsString;
  pPxTable.FieldByName('StkCode').AsString := pBtTable.FieldByName('StkCode').AsString;
  pPxTable.FieldByName('SeQnt').AsFloat := pBtTable.FieldByName('SeQnt').AsFloat;
  pPxTable.FieldByName('VatPrc').AsFloat := pBtTable.FieldByName('VatPrc').AsFloat;
  pPxTable.FieldByName('DscVal').AsFloat := pBtTable.FieldByName('DscVal').AsFloat;
  pPxTable.FieldByName('AValue').AsFloat := pBtTable.FieldByName('AValue').AsFloat;
  pPxTable.FieldByName('BValue').AsFloat := pBtTable.FieldByName('BValue').AsFloat;
  pPxTable.FieldByName('Status').AsString := pBtTable.FieldByName('Status').AsString;
  pPxTable.FieldByName('CrtUser').AsString := pBtTable.FieldByName('CrtUser').AsString;
  pPxTable.FieldByName('CrtDate').AsDateTime := pBtTable.FieldByName('CrtDate').AsDateTime;
  pPxTable.FieldByName('CrtTime').AsDateTime := pBtTable.FieldByName('CrtTime').AsDateTime;
  pPxTable.FieldByName('ModNum').AsInteger := pBtTable.FieldByName('ModNum').AsInteger;
  pPxTable.FieldByName('ModUser').AsString := pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime := pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime := pBtTable.FieldByName('ModTime').AsDateTime;
end;

procedure TdmCAB.SAI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSH do ptTSH
begin
  pPxTable.FieldByName('DocNum').AsString      := pBtTable.FieldByName('DocNum').AsString;
  pPxTable.FieldByName('DocDate').AsDateTime   := pBtTable.FieldByName('DocDate').AsDateTime;
  pPxTable.FieldByName('StkNum').AsInteger     := pBtTable.FieldByName('StkNum').AsInteger;
  pPxTable.FieldByName('GsCode').AsInteger     := pBtTable.FieldByName('GsCode').AsInteger;
  pPxTable.FieldByName('MgCode').AsInteger     := pBtTable.FieldByName('MgCode').AsInteger;
  pPxTable.FieldByName('GsName').AsString      := pBtTable.FieldByName('GsName').AsString;
  pPxTable.FieldByName('BarCode').AsString     := pBtTable.FieldByName('BarCode').AsString;
  pPxTable.FieldByName('StkCode').AsString     := pBtTable.FieldByName('StkCode').AsString;
  pPxTable.FieldByName('SeQnt').AsFloat        := pBtTable.FieldByName('SeQnt').AsFloat;
  pPxTable.FieldByName('SuQnt').AsFloat        := pBtTable.FieldByName('SuQnt').AsFloat;
  pPxTable.FieldByName('CpSeQnt').AsFloat      := pBtTable.FieldByName('CpSeQnt').AsFloat;
  pPxTable.FieldByName('CpSuQnt').AsFloat      := pBtTable.FieldByName('CpSuQnt').AsFloat;
  If pBtTable.FieldByName('StkStat').AsString <>'C'
    then pPxTable.FieldByName('NsQnt').AsFloat := pBtTable.FieldByName('SeQnt').AsFloat  -pBtTable.FieldByName('SuQnt').AsFloat
    else pPxTable.FieldByName('NsQnt').AsFloat := pBtTable.FieldByName('CpSeQnt').AsFloat-pBtTable.FieldByName('CpSuQnt').AsFloat;
  pPxTable.FieldByName('CValue').AsFloat       := pBtTable.FieldByName('CValue').AsFloat;
  pPxTable.FieldByName('CPrice').AsFloat       := pBtTable.FieldByName('CPrice').AsFloat;
  pPxTable.FieldByName('VatPrc').AsInteger     := pBtTable.FieldByName('VatPrc').AsInteger;
  pPxTable.FieldByName('DscVal').AsFloat       := pBtTable.FieldByName('DscVal').AsFloat;
  pPxTable.FieldByName('AValue').AsFloat       := pBtTable.FieldByName('AValue').AsFloat;
  pPxTable.FieldByName('BValue').AsFloat       := pBtTable.FieldByName('BValue').AsFloat;
  pPxTable.FieldByName('StkStat').AsString     := pBtTable.FieldByName('StkStat').AsString;
  pPxTable.FieldByName('CrtUser').AsString     := pBtTable.FieldByName('CrtUser').AsString;
  pPxTable.FieldByName('CrtDate').AsDateTime   := pBtTable.FieldByName('CrtDate').AsDateTime;
  pPxTable.FieldByName('CrtTime').AsDateTime   := pBtTable.FieldByName('CrtTime').AsDateTime;
  pPxTable.FieldByName('ModNum').AsInteger     := pBtTable.FieldByName('ModNum').AsInteger;
  pPxTable.FieldByName('ModUser').AsString     := pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime   := pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime   := pBtTable.FieldByName('ModTime').AsDateTime;
end;

procedure TdmCAB.SAC_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSH do ptTSH
var mI:integer;
begin
  for mI:=1 to pBtTable.FieldDefs.Count do begin
    If pPxTable.FindField(pBtTable.FieldDefs[mI-1].Name)<>NIL
      then pPxTable.FindField(pBtTable.FieldDefs[mI-1].Name).AsString:=pBtTable.Fields[mI-1].AsString;
  end;
  If pBtTable.FieldByName('ItmType').AsString<>'W'
    then pPxTable.FieldByName('NsQnt').AsFloat := pBtTable.FieldByName('CpSeQnt').AsFloat-pBtTable.FieldByName('CpSuQnt').AsFloat
    else pPxTable.FieldByName('NsQnt').AsFloat := 0;
end;


function TdmCAB.GetActCasNum: longint;
begin
  Result := oActCasNum;
end;

procedure TdmCAB.T_CabDatTimer(Sender: TObject);
var I: integer;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TBtrieveTable) then begin
      If (Components[I] as TBtrieveTable).Active and ((Components[I] as TBtrieveTable).State = dsBrowse) then begin
        (Components[I] as TBtrieveTable).Refresh;
      end;
    end;
  end;
end;

end.
