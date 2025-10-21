unit pOSICUM; // Kumulativny zoznam poloziek vybranej doslej objednavky - pre kumulativnu tlac

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, TxtCut, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, DBTables, NexPxTable, NexBtrTable;

const
  ixRowNum = '';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';

type
  TOsiCum = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTable: TNexPxTable;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadGsCode:longint;      procedure WriteGsCode (pValue:longint);
  public
    function Eof: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    procedure LoadItem (pTable:TNexBtrTable;pDocNum:Str12);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property ptOSICUM:TNexPxTable read oTable write oTable;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property GsCode:longint read ReadGsCode write WriteGsCode;
  end;

implementation

constructor TOsiCum.Create;
begin
  oTable := TNexPxTable.Create(Self);
  oTable.FixName := 'OSICUM';
  oTable.TableName := 'OSICUM';
  oTable.DefPath := gPath.DefPath;
  oTable.DefName := 'OSICUM.TDF';
end;

destructor  TOsiCum.Destroy;
begin
  If oTable.Active then oTable.Close;
  FreeAndNil (oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsiCum.ReadCount:integer;
begin
  Result := oTable.RecordCount;
end;

function TOsiCum.ReadGsCode:longint;
begin
  Result := oTable.FieldByname('GsCode').AsInteger;
end;

procedure TOsiCum.WriteGsCode (pValue:longint);
begin
  oTable.FieldByname('GsCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsiCum.Eof: boolean;
begin
  Result := oTable.Eof;
end;

function TOsiCum.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndexName (ixGsCode);
  Result := oTable.FindKey([pGsCode]);
end;

function TOsiCum.GetIndexName:ShortString;
begin
  Result := oTable.IndexName;
end;

procedure TOsiCum.SetIndexName (pIndexName:ShortString);
begin
  If oTable.IndexName<>pIndexName then oTable.IndexName := pIndexName;
end;

procedure TOsiCum.LoadItem (pTable:TNexBtrTable;pDocNum:Str12);
begin
  oTable.SwapIndex;  oTable.IndexName := 'GsCode';
  pTable.SwapIndex;  pTable.IndexName := 'DocNum';
  If pTable.FindKey ([pDocNum]) then begin
    Repeat
      If oTable.FindKey([pTable.FieldByname('GsCode').AsInteger]) then begin
        oTable.Edit;
        oTable.FieldByname('OrdQnt').AsFloat := oTable.FieldByname('OrdQnt').AsFloat+pTable.FieldByname('OrdQnt').AsFloat;
        oTable.FieldByname('DlvQnt').AsFloat := oTable.FieldByname('DlvQnt').AsFloat+pTable.FieldByname('DlvQnt').AsFloat;
        oTable.FieldByname('EndQnt').AsFloat := oTable.FieldByname('OrdQnt').AsFloat-oTable.FieldByname('DlvQnt').AsFloat;
        oTable.FieldByname('AcDValue').AsFloat := oTable.FieldByname('AcDValue').AsFloat+pTable.FieldByname('AcDValue').AsFloat;
        oTable.FieldByname('AcDscVal').AsFloat := oTable.FieldByname('AcDscVal').AsFloat+pTable.FieldByname('AcDscVal').AsFloat;
        oTable.FieldByname('AcCValue').AsFloat := oTable.FieldByname('AcCValue').AsFloat+pTable.FieldByname('AcCValue').AsFloat;
        oTable.FieldByname('AcEValue').AsFloat := oTable.FieldByname('AcEValue').AsFloat+pTable.FieldByname('AcEValue').AsFloat;
        oTable.FieldByname('AcAValue').AsFloat := oTable.FieldByname('AcAValue').AsFloat+pTable.FieldByname('AcAValue').AsFloat;
        oTable.FieldByname('AcBValue').AsFloat := oTable.FieldByname('AcBValue').AsFloat+pTable.FieldByname('AcBValue').AsFloat;
        oTable.FieldByname('FgDValue').AsFloat := oTable.FieldByname('FgDValue').AsFloat+pTable.FieldByname('FgDValue').AsFloat;
        oTable.FieldByname('FgDscVal').AsFloat := oTable.FieldByname('FgDscVal').AsFloat+pTable.FieldByname('FgDscVal').AsFloat;
        oTable.FieldByname('FgRndVal').AsFloat := oTable.FieldByname('FgRndVal').AsFloat+pTable.FieldByname('FgRndVal').AsFloat;
        oTable.FieldByname('FgCValue').AsFloat := oTable.FieldByname('FgCValue').AsFloat+pTable.FieldByname('FgCValue').AsFloat;
        oTable.FieldByname('FgEValue').AsFloat := oTable.FieldByname('FgEValue').AsFloat+pTable.FieldByname('FgEValue').AsFloat;
        oTable.Post;
      end
      else begin
        oTable.Insert;
        BTR_To_PX (pTable,oTable);
        oTable.FieldByname('RowNum').AsInteger := oTable.RecordCount+1;
        oTable.Post;
      end;
      pTable.Next;
    until (pTable.Eof) or (pTable.FieldByName('DocNum').AsString<>pDocNum);
  end;
  pTable.RestoreIndex;
  oTable.RestoreIndex;
end;

procedure TOsiCum.Open;
begin
  oTable.Open;
end;

procedure TOsiCum.Close;
begin
  oTable.Close;
end;

procedure TOsiCum.Prior;
begin
  oTable.Prior;
end;

procedure TOsiCum.Next;
begin
  oTable.Next;
end;

procedure TOsiCum.First;
begin
  oTable.First;
end;

procedure TOsiCum.Last;
begin
  oTable.Last;
end;

procedure TOsiCum.Insert;
begin
  oTable.Insert;
end;

procedure TOsiCum.Edit;
begin
  oTable.Edit;
end;

procedure TOsiCum.Post;
begin
  oTable.Post;
end;

procedure TOsiCum.Delete;
begin
  oTable.Delete;
end;

procedure TOsiCum.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TOsiCum.RestoreIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsiCum.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TOsiCum.RestoreStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsiCum.DisableControls;
begin
  oTable.DisableControls;
end;

procedure TOsiCum.EnableControls;
begin
  oTable.EnableControls;
end;

end.
