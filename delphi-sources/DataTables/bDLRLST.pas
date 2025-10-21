unit bDLRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDlrCode = 'DlrCode';
  ixDlrName = 'DlrName';

type
  TDlrlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadDlrName_:Str30;        procedure WriteDlrName_ (pValue:Str30);
    function  ReadIdCode:Str15;          procedure WriteIdCode (pValue:Str15);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadAplNum:word;           procedure WriteAplNum (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadClcType:Str1;          procedure WriteClcType (pValue:Str1);
    function  ReadRewPrc:double;         procedure WriteRewPrc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDlrCode (pDlrCode:word):boolean;
    function LocateDlrName (pDlrName:Str30):boolean;
    function NearestDlrCode (pDlrCode:word):boolean;
    function NearestDlrName (pDlrName:Str30):boolean;

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
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property DlrName_:Str30 read ReadDlrName_ write WriteDlrName_;
    property IdCode:Str15 read ReadIdCode write WriteIdCode;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property AplNum:word read ReadAplNum write WriteAplNum;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ClcType:Str1 read ReadClcType write WriteClcType;
    property RewPrc:double read ReadRewPrc write WriteRewPrc;
  end;

implementation

constructor TDlrlstBtr.Create;
begin
  oBtrTable := BtrInit ('DLRLST',gPath.DlsPath,Self);
end;

constructor TDlrlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DLRLST',pPath,Self);
end;

destructor TDlrlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDlrlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDlrlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDlrlstBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TDlrlstBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TDlrlstBtr.ReadDlrName:Str30;
begin
  Result := oBtrTable.FieldByName('DlrName').AsString;
end;

procedure TDlrlstBtr.WriteDlrName(pValue:Str30);
begin
  oBtrTable.FieldByName('DlrName').AsString := pValue;
end;

function TDlrlstBtr.ReadDlrName_:Str30;
begin
  Result := oBtrTable.FieldByName('DlrName_').AsString;
end;

procedure TDlrlstBtr.WriteDlrName_(pValue:Str30);
begin
  oBtrTable.FieldByName('DlrName_').AsString := pValue;
end;

function TDlrlstBtr.ReadIdCode:Str15;
begin
  Result := oBtrTable.FieldByName('IdCode').AsString;
end;

procedure TDlrlstBtr.WriteIdCode(pValue:Str15);
begin
  oBtrTable.FieldByName('IdCode').AsString := pValue;
end;

function TDlrlstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TDlrlstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TDlrlstBtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TDlrlstBtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TDlrlstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TDlrlstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TDlrlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDlrlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDlrlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDlrlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDlrlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDlrlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDlrlstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TDlrlstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TDlrlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDlrlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDlrlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDlrlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDlrlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDlrlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDlrlstBtr.ReadClcType:Str1;
begin
  Result := oBtrTable.FieldByName('ClcType').AsString;
end;

procedure TDlrlstBtr.WriteClcType(pValue:Str1);
begin
  oBtrTable.FieldByName('ClcType').AsString := pValue;
end;

function TDlrlstBtr.ReadRewPrc:double;
begin
  Result := oBtrTable.FieldByName('RewPrc').AsFloat;
end;

procedure TDlrlstBtr.WriteRewPrc(pValue:double);
begin
  oBtrTable.FieldByName('RewPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDlrlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDlrlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDlrlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDlrlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDlrlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDlrlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDlrlstBtr.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindKey([pDlrCode]);
end;

function TDlrlstBtr.LocateDlrName (pDlrName:Str30):boolean;
begin
  SetIndex (ixDlrName);
  Result := oBtrTable.FindKey([pDlrName]);
end;

function TDlrlstBtr.NearestDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindNearest([pDlrCode]);
end;

function TDlrlstBtr.NearestDlrName (pDlrName:Str30):boolean;
begin
  SetIndex (ixDlrName);
  Result := oBtrTable.FindNearest([pDlrName]);
end;

procedure TDlrlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDlrlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDlrlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDlrlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDlrlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDlrlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TDlrlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDlrlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDlrlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDlrlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDlrlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDlrlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDlrlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDlrlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDlrlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDlrlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDlrlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
