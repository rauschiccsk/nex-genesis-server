unit bSAP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIe = 'DnIe';
  ixDocNum = 'DocNum';
  ixIceNum = 'IceNum';
  ixDocDate = 'DocDate';
  ixDnPc = 'DnPc';

type
  TSapBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadIceNum:Str20;          procedure WriteIceNum (pValue:Str20);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDnIe (pDocNum:Str12;pIceNum:Str20):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateIceNum (pIceNum:Str20):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDnPc (pDocNum:Str12;pPaCode:longint):boolean;
    function NearestDnIe (pDocNum:Str12;pIceNum:Str20):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestIceNum (pIceNum:Str20):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDnPc (pDocNum:Str12;pPaCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property IceNum:Str20 read ReadIceNum write WriteIceNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PayVal:double read ReadPayVal write WritePayVal;
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
  end;

implementation

constructor TSapBtr.Create;
begin
  oBtrTable := BtrInit ('SAP',gPath.CabPath,Self);
end;

constructor TSapBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SAP',pPath,Self);
end;

destructor TSapBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSapBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSapBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSapBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSapBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSapBtr.ReadIceNum:Str20;
begin
  Result := oBtrTable.FieldByName('IceNum').AsString;
end;

procedure TSapBtr.WriteIceNum(pValue:Str20);
begin
  oBtrTable.FieldByName('IceNum').AsString := pValue;
end;

function TSapBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TSapBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TSapBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSapBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSapBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSapBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSapBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TSapBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TSapBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TSapBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TSapBtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TSapBtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSapBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSapBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSapBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSapBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSapBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSapBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSapBtr.LocateDnIe (pDocNum:Str12;pIceNum:Str20):boolean;
begin
  SetIndex (ixDnIe);
  Result := oBtrTable.FindKey([pDocNum,pIceNum]);
end;

function TSapBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSapBtr.LocateIceNum (pIceNum:Str20):boolean;
begin
  SetIndex (ixIceNum);
  Result := oBtrTable.FindKey([pIceNum]);
end;

function TSapBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSapBtr.LocateDnPc (pDocNum:Str12;pPaCode:longint):boolean;
begin
  SetIndex (ixDnPc);
  Result := oBtrTable.FindKey([pDocNum,pPaCode]);
end;

function TSapBtr.NearestDnIe (pDocNum:Str12;pIceNum:Str20):boolean;
begin
  SetIndex (ixDnIe);
  Result := oBtrTable.FindNearest([pDocNum,pIceNum]);
end;

function TSapBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSapBtr.NearestIceNum (pIceNum:Str20):boolean;
begin
  SetIndex (ixIceNum);
  Result := oBtrTable.FindNearest([pIceNum]);
end;

function TSapBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSapBtr.NearestDnPc (pDocNum:Str12;pPaCode:longint):boolean;
begin
  SetIndex (ixDnPc);
  Result := oBtrTable.FindNearest([pDocNum,pPaCode]);
end;

procedure TSapBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSapBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSapBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSapBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSapBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSapBtr.First;
begin
  oBtrTable.First;
end;

procedure TSapBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSapBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSapBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSapBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSapBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSapBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSapBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSapBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSapBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSapBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSapBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
