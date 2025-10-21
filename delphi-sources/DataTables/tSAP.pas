unit tSAP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDnIe = 'DnIe';
  ixDocNum = 'DocNum';
  ixIceNum = 'IceNum';
  ixDocDate = 'DocDate';
  ixDnPc = 'DnPc';

type
  TSapTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadIceNum:Str20;          procedure WriteIceNum (pValue:Str20);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
    function  ReadActPosL:longint;       procedure WriteActPosL (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateDnIe (pDocNum:Str12;pIceNum:Str20):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateIceNum (pIceNum:Str20):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDnPc (pDocNum:Str12;pPaCode:longint):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property IceNum:Str20 read ReadIceNum write WriteIceNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PayVal:double read ReadPayVal write WritePayVal;
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
    property ActPosL:longint read ReadActPosL write WriteActPosL;
  end;

implementation

constructor TSapTmp.Create;
begin
  oTmpTable := TmpInit ('SAP',Self);
end;

destructor TSapTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSapTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSapTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSapTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TSapTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TSapTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSapTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSapTmp.ReadIceNum:Str20;
begin
  Result := oTmpTable.FieldByName('IceNum').AsString;
end;

procedure TSapTmp.WriteIceNum(pValue:Str20);
begin
  oTmpTable.FieldByName('IceNum').AsString := pValue;
end;

function TSapTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TSapTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TSapTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSapTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSapTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSapTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSapTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSapTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSapTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TSapTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TSapTmp.ReadCsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('CsdNum').AsString;
end;

procedure TSapTmp.WriteCsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CsdNum').AsString := pValue;
end;

function TSapTmp.ReadActPosL:longint;
begin
  Result := oTmpTable.FieldByName('ActPosL').AsInteger;
end;

procedure TSapTmp.WriteActPosL(pValue:longint);
begin
  oTmpTable.FieldByName('ActPosL').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSapTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSapTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSapTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TSapTmp.LocateDnIe (pDocNum:Str12;pIceNum:Str20):boolean;
begin
  SetIndex (ixDnIe);
  Result := oTmpTable.FindKey([pDocNum,pIceNum]);
end;

function TSapTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSapTmp.LocateIceNum (pIceNum:Str20):boolean;
begin
  SetIndex (ixIceNum);
  Result := oTmpTable.FindKey([pIceNum]);
end;

function TSapTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSapTmp.LocateDnPc (pDocNum:Str12;pPaCode:longint):boolean;
begin
  SetIndex (ixDnPc);
  Result := oTmpTable.FindKey([pDocNum,pPaCode]);
end;

procedure TSapTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSapTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSapTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSapTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSapTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSapTmp.First;
begin
  oTmpTable.First;
end;

procedure TSapTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSapTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSapTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSapTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSapTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSapTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSapTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSapTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSapTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSapTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSapTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
