unit bDSPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixPaCode = 'PaCode';
  ixPaSt = 'PaSt';
  ixExpDate = 'ExpDate';
  ixAppDoc = 'AppDoc';

type
  TDsplstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadAsgUser:Str8;          procedure WriteAsgUser (pValue:Str8);
    function  ReadNayIcd:Str1;           procedure WriteNayIcd (pValue:Str1);
    function  ReadLimAdd:Str1;           procedure WriteLimAdd (pValue:Str1);
    function  ReadAddVal:double;         procedure WriteAddVal (pValue:double);
    function  ReadAppDoc:Str12;          procedure WriteAppDoc (pValue:Str12);
    function  ReadAppUser:Str8;          procedure WriteAppUser (pValue:Str8);
    function  ReadAppDate:TDatetime;     procedure WriteAppDate (pValue:TDatetime);
    function  ReadAppTime:TDatetime;     procedure WriteAppTime (pValue:TDatetime);
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
    function LocateSerNum (pSerNum:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaSt (pPaCode:longint;pStatus:Str1):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocateAppDoc (pAppDoc:Str12):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaSt (pPaCode:longint;pStatus:Str1):boolean;
    function NearestExpDate (pExpDate:TDatetime):boolean;
    function NearestAppDoc (pAppDoc:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property Status:Str1 read ReadStatus write WriteStatus;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property AsgUser:Str8 read ReadAsgUser write WriteAsgUser;
    property NayIcd:Str1 read ReadNayIcd write WriteNayIcd;
    property LimAdd:Str1 read ReadLimAdd write WriteLimAdd;
    property AddVal:double read ReadAddVal write WriteAddVal;
    property AppDoc:Str12 read ReadAppDoc write WriteAppDoc;
    property AppUser:Str8 read ReadAppUser write WriteAppUser;
    property AppDate:TDatetime read ReadAppDate write WriteAppDate;
    property AppTime:TDatetime read ReadAppTime write WriteAppTime;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDsplstBtr.Create;
begin
  oBtrTable := BtrInit ('DSPLST',gPath.DlsPath,Self);
end;

constructor TDsplstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DSPLST',pPath,Self);
end;

destructor TDsplstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDsplstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDsplstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDsplstBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TDsplstBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TDsplstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TDsplstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDsplstBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TDsplstBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TDsplstBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TDsplstBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TDsplstBtr.ReadAsgUser:Str8;
begin
  Result := oBtrTable.FieldByName('AsgUser').AsString;
end;

procedure TDsplstBtr.WriteAsgUser(pValue:Str8);
begin
  oBtrTable.FieldByName('AsgUser').AsString := pValue;
end;

function TDsplstBtr.ReadNayIcd:Str1;
begin
  Result := oBtrTable.FieldByName('NayIcd').AsString;
end;

procedure TDsplstBtr.WriteNayIcd(pValue:Str1);
begin
  oBtrTable.FieldByName('NayIcd').AsString := pValue;
end;

function TDsplstBtr.ReadLimAdd:Str1;
begin
  Result := oBtrTable.FieldByName('LimAdd').AsString;
end;

procedure TDsplstBtr.WriteLimAdd(pValue:Str1);
begin
  oBtrTable.FieldByName('LimAdd').AsString := pValue;
end;

function TDsplstBtr.ReadAddVal:double;
begin
  Result := oBtrTable.FieldByName('AddVal').AsFloat;
end;

procedure TDsplstBtr.WriteAddVal(pValue:double);
begin
  oBtrTable.FieldByName('AddVal').AsFloat := pValue;
end;

function TDsplstBtr.ReadAppDoc:Str12;
begin
  Result := oBtrTable.FieldByName('AppDoc').AsString;
end;

procedure TDsplstBtr.WriteAppDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('AppDoc').AsString := pValue;
end;

function TDsplstBtr.ReadAppUser:Str8;
begin
  Result := oBtrTable.FieldByName('AppUser').AsString;
end;

procedure TDsplstBtr.WriteAppUser(pValue:Str8);
begin
  oBtrTable.FieldByName('AppUser').AsString := pValue;
end;

function TDsplstBtr.ReadAppDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AppDate').AsDateTime;
end;

procedure TDsplstBtr.WriteAppDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AppDate').AsDateTime := pValue;
end;

function TDsplstBtr.ReadAppTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('AppTime').AsDateTime;
end;

procedure TDsplstBtr.WriteAppTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AppTime').AsDateTime := pValue;
end;

function TDsplstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDsplstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDsplstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDsplstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDsplstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDsplstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDsplstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDsplstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDsplstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDsplstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDsplstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDsplstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDsplstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDsplstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDsplstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDsplstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDsplstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDsplstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDsplstBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TDsplstBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TDsplstBtr.LocatePaSt (pPaCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixPaSt);
  Result := oBtrTable.FindKey([pPaCode,pStatus]);
end;

function TDsplstBtr.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindKey([pExpDate]);
end;

function TDsplstBtr.LocateAppDoc (pAppDoc:Str12):boolean;
begin
  SetIndex (ixAppDoc);
  Result := oBtrTable.FindKey([pAppDoc]);
end;

function TDsplstBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TDsplstBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TDsplstBtr.NearestPaSt (pPaCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixPaSt);
  Result := oBtrTable.FindNearest([pPaCode,pStatus]);
end;

function TDsplstBtr.NearestExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindNearest([pExpDate]);
end;

function TDsplstBtr.NearestAppDoc (pAppDoc:Str12):boolean;
begin
  SetIndex (ixAppDoc);
  Result := oBtrTable.FindNearest([pAppDoc]);
end;

procedure TDsplstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDsplstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDsplstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDsplstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDsplstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDsplstBtr.First;
begin
  oBtrTable.First;
end;

procedure TDsplstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDsplstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDsplstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDsplstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDsplstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDsplstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDsplstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDsplstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDsplstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDsplstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDsplstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
