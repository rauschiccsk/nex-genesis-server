unit tSALNUL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName_ = 'PaName_';

type
  TSalnulTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadBefDate:TDatetime;     procedure WriteBefDate (pValue:TDatetime);
    function  ReadAftDate:TDatetime;     procedure WriteAftDate (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property BefDate:TDatetime read ReadBefDate write WriteBefDate;
    property AftDate:TDatetime read ReadAftDate write WriteAftDate;
  end;

implementation

constructor TSalnulTmp.Create;
begin
  oTmpTable := TmpInit ('SALNUL',Self);
end;

destructor TSalnulTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSalnulTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSalnulTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSalnulTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSalnulTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSalnulTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSalnulTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSalnulTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TSalnulTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TSalnulTmp.ReadBefDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BefDate').AsDateTime;
end;

procedure TSalnulTmp.WriteBefDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BefDate').AsDateTime := pValue;
end;

function TSalnulTmp.ReadAftDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AftDate').AsDateTime;
end;

procedure TSalnulTmp.WriteAftDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AftDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSalnulTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSalnulTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSalnulTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TSalnulTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TSalnulTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSalnulTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSalnulTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSalnulTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSalnulTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSalnulTmp.First;
begin
  oTmpTable.First;
end;

procedure TSalnulTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSalnulTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSalnulTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSalnulTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSalnulTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSalnulTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSalnulTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSalnulTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSalnulTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSalnulTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSalnulTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
