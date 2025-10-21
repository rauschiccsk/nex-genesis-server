unit bSTU;  

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixGsPa = 'GsPa';

type
  TStuBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadOtmDat:TDatetime;      procedure WriteOtmDat (pValue:TDatetime);
    function  ReadCtmDat:TDatetime;      procedure WriteCtmDat (pValue:TDatetime);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadDlvDat:TDatetime;      procedure WriteDlvDat (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsPa (pGsCode:longint;pPaCode:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsPa (pGsCode:longint;pPaCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:word);
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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property OtmDat:TDatetime read ReadOtmDat write WriteOtmDat;
    property CtmDat:TDatetime read ReadCtmDat write WriteCtmDat;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property DlvDat:TDatetime read ReadDlvDat write WriteDlvDat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TStuBtr.Create;
begin
  oBtrTable := BtrInit ('STU',gPath.StkPath,Self);
end;

constructor TStuBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STU',pPath,Self);
end;

destructor TStuBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStuBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStuBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStuBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TStuBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TStuBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStuBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStuBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStuBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStuBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TStuBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStuBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TStuBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TStuBtr.ReadResQnt:double;
begin
  Result := oBtrTable.FieldByName('ResQnt').AsFloat;
end;

procedure TStuBtr.WriteResQnt(pValue:double);
begin
  oBtrTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TStuBtr.ReadOtmDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('OtmDat').AsDateTime;
end;

procedure TStuBtr.WriteOtmDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OtmDat').AsDateTime := pValue;
end;

function TStuBtr.ReadCtmDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('CtmDat').AsDateTime;
end;

procedure TStuBtr.WriteCtmDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CtmDat').AsDateTime := pValue;
end;

function TStuBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TStuBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TStuBtr.ReadDlvDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDat').AsDateTime;
end;

procedure TStuBtr.WriteDlvDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDat').AsDateTime := pValue;
end;

function TStuBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TStuBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStuBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStuBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStuBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStuBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TStuBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStuBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStuBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStuBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStuBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStuBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStuBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStuBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStuBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStuBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStuBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStuBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStuBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TStuBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStuBtr.LocateGsPa (pGsCode:longint;pPaCode:longint):boolean;
begin
  SetIndex (ixGsPa);
  Result := oBtrTable.FindKey([pGsCode,pPaCode]);
end;

function TStuBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TStuBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStuBtr.NearestGsPa (pGsCode:longint;pPaCode:longint):boolean;
begin
  SetIndex (ixGsPa);
  Result := oBtrTable.FindNearest([pGsCode,pPaCode]);
end;

procedure TStuBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStuBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TStuBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStuBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStuBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStuBtr.First;
begin
  oBtrTable.First;
end;

procedure TStuBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStuBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStuBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStuBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStuBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStuBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStuBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStuBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStuBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStuBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStuBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1921001}
