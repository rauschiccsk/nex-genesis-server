unit DM_MNGDAT;

interface

uses
  IcTypes, IcConv, IcTools, IcDate, NexIni, NexPath,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Db, DBTables, PxTable, DbfTable, BtrTable, NexBtrTable,
  NexTmpTable, PxTmpTable, NexPxTable;

type
  TdmMNG = class(TDataModule)
    btNPCONC: TNexBtrTable;
    btNPSEND: TNexBtrTable;
    btNPPROC: TNexBtrTable;
    btNPSOLV: TNexBtrTable;
    btNPDESC: TNexBtrTable;
    btNPPACL: TNexBtrTable;
    btNPPRGL: TNexBtrTable;
    btNPRSNG: TNexBtrTable;
    btMFKGSL: TNexBtrTable;
    ptROTSUM: TNexPxTable;
    ptDSCSUM: TNexPxTable;
    ptROTEVL: TNexPxTable;
    ptDSCEVL: TNexPxTable;
    ptMFKGSL: TNexPxTable;
    btNPBLST: TNexBtrTable;
    btNPD: TNexBtrTable;
    ptCLMSUM: TNexPxTable;
    ptMFKUDS: TNexPxTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
    procedure OpenBase (var pTable:TNexBtrTable);
    procedure OpenList (var pTable:TNexBtrTable; pListNum:longint);
    procedure OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);
  end;

var
  dmMNG: TdmMNG;

implementation

{$R *.DFM}

procedure TdmMNG.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName := gPath.MgdPath;
      (Components[I] as TNexBtrTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName := gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName := gPath.SubPrivPath;
  end;
end;

procedure TdmMNG.LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
var mTable:TNexBtrTable;
begin
  mTable := (FindComponent (pTable.Name)) as TNexBtrTable;
  If mTable<>nil then begin // Nasli sme databazu
    pTable.DefName := mTable.DefName;
    pTable.FixedName := mTable.FixedName;
    pTable.TableName := mTable.TableName;
  end;
end;

procedure TdmMNG.OpenBase (var pTable:TNexBtrTable);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.MgdPath;
  pTable.Open;
end;

procedure TdmMNG.OpenList (var pTable:TNexBtrTable; pListNum:longint);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := StrIntZero(pListNum,5);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.MgdPath;
  pTable.TableName := pTable.FixedName+pTable.BookNum;
  pTable.Open;
end;

procedure TdmMNG.OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := pBookNum;
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.MgdPath;
  pTable.TableName := pTable.FixedName+pBookNum;
  pTable.Open;
end;

end.
