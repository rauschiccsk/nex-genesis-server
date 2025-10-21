unit bSTR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixResSta = 'ResSta';

type
  TStrBtr = class (TComponent)
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
    function  ReadResDoc:Str12;          procedure WriteResDoc (pValue:Str12);
    function  ReadResItm:longint;        procedure WriteResItm (pValue:longint);
    function  ReadResSta:Str1;           procedure WriteResSta (pValue:Str1);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadReqDat:TDatetime;      procedure WriteReqDat (pValue:TDatetime);
    function  ReadCtmDat:TDatetime;      procedure WriteCtmDat (pValue:TDatetime);
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
    function LocateResSta (pResSta:Str1):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestResSta (pResSta:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:longint);
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
    property ResDoc:Str12 read ReadResDoc write WriteResDoc;
    property ResItm:longint read ReadResItm write WriteResItm;
    property ResSta:Str1 read ReadResSta write WriteResSta;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property ReqDat:TDatetime read ReadReqDat write WriteReqDat;
    property CtmDat:TDatetime read ReadCtmDat write WriteCtmDat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TStrBtr.Create;
begin
  oBtrTable := BtrInit ('STR',gPath.StkPath,Self);
end;

constructor TStrBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STR',pPath,Self);
end;

destructor TStrBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStrBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStrBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStrBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TStrBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TStrBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStrBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStrBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStrBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStrBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TStrBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStrBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TStrBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TStrBtr.ReadResQnt:double;
begin
  Result := oBtrTable.FieldByName('ResQnt').AsFloat;
end;

procedure TStrBtr.WriteResQnt(pValue:double);
begin
  oBtrTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TStrBtr.ReadResDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ResDoc').AsString;
end;

procedure TStrBtr.WriteResDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ResDoc').AsString := pValue;
end;

function TStrBtr.ReadResItm:longint;
begin
  Result := oBtrTable.FieldByName('ResItm').AsInteger;
end;

procedure TStrBtr.WriteResItm(pValue:longint);
begin
  oBtrTable.FieldByName('ResItm').AsInteger := pValue;
end;

function TStrBtr.ReadResSta:Str1;
begin
  Result := oBtrTable.FieldByName('ResSta').AsString;
end;

procedure TStrBtr.WriteResSta(pValue:Str1);
begin
  oBtrTable.FieldByName('ResSta').AsString := pValue;
end;

function TStrBtr.ReadFifNum:longint;
begin
  Result := oBtrTable.FieldByName('FifNum').AsInteger;
end;

procedure TStrBtr.WriteFifNum(pValue:longint);
begin
  oBtrTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TStrBtr.ReadReqDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ReqDat').AsDateTime;
end;

procedure TStrBtr.WriteReqDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ReqDat').AsDateTime := pValue;
end;

function TStrBtr.ReadCtmDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('CtmDat').AsDateTime;
end;

procedure TStrBtr.WriteCtmDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CtmDat').AsDateTime := pValue;
end;

function TStrBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TStrBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStrBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStrBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStrBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStrBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TStrBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStrBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStrBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStrBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStrBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStrBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStrBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStrBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStrBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStrBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStrBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStrBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStrBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TStrBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStrBtr.LocateResSta (pResSta:Str1):boolean;
begin
  SetIndex (ixResSta);
  Result := oBtrTable.FindKey([pResSta]);
end;

function TStrBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TStrBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStrBtr.NearestResSta (pResSta:Str1):boolean;
begin
  SetIndex (ixResSta);
  Result := oBtrTable.FindNearest([pResSta]);
end;

procedure TStrBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStrBtr.Open(pStkNum:longint);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TStrBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStrBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStrBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStrBtr.First;
begin
  oBtrTable.First;
end;

procedure TStrBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStrBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStrBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStrBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStrBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStrBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStrBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStrBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStrBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStrBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStrBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1921001}
