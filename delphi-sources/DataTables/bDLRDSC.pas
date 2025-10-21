unit bDLRDSC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDcItIc = 'DcItIc';
  ixItmCode = 'ItmCode';
  ixItmName = 'ItmName';
  ixSended = 'Sended';

type
  TDlrdscBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadItmCode:longint;       procedure WriteItmCode (pValue:longint);
    function  ReadItmName:Str30;         procedure WriteItmName (pValue:Str30);
    function  ReadItmName_:Str30;        procedure WriteItmName_ (pValue:Str30);
    function  ReadComPrc:double;         procedure WriteComPrc (pValue:double);
    function  ReadDefDsc:double;         procedure WriteDefDsc (pValue:double);
    function  ReadMaxDsc:double;         procedure WriteMaxDsc (pValue:double);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateDcItIc (pDlrCode:word;pItmType:Str1;pItmCode:longint):boolean;
    function LocateItmCode (pItmCode:longint):boolean;
    function LocateItmName (pItmName_:Str30):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestDcItIc (pDlrCode:word;pItmType:Str1;pItmCode:longint):boolean;
    function NearestItmCode (pItmCode:longint):boolean;
    function NearestItmName (pItmName_:Str30):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property ItmCode:longint read ReadItmCode write WriteItmCode;
    property ItmName:Str30 read ReadItmName write WriteItmName;
    property ItmName_:Str30 read ReadItmName_ write WriteItmName_;
    property ComPrc:double read ReadComPrc write WriteComPrc;
    property DefDsc:double read ReadDefDsc write WriteDefDsc;
    property MaxDsc:double read ReadMaxDsc write WriteMaxDsc;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDlrdscBtr.Create;
begin
  oBtrTable := BtrInit ('DLRDSC',gPath.DlsPath,Self);
end;

constructor TDlrdscBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DLRDSC',pPath,Self);
end;

destructor TDlrdscBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDlrdscBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDlrdscBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDlrdscBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TDlrdscBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TDlrdscBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TDlrdscBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

function TDlrdscBtr.ReadItmCode:longint;
begin
  Result := oBtrTable.FieldByName('ItmCode').AsInteger;
end;

procedure TDlrdscBtr.WriteItmCode(pValue:longint);
begin
  oBtrTable.FieldByName('ItmCode').AsInteger := pValue;
end;

function TDlrdscBtr.ReadItmName:Str30;
begin
  Result := oBtrTable.FieldByName('ItmName').AsString;
end;

procedure TDlrdscBtr.WriteItmName(pValue:Str30);
begin
  oBtrTable.FieldByName('ItmName').AsString := pValue;
end;

function TDlrdscBtr.ReadItmName_:Str30;
begin
  Result := oBtrTable.FieldByName('ItmName_').AsString;
end;

procedure TDlrdscBtr.WriteItmName_(pValue:Str30);
begin
  oBtrTable.FieldByName('ItmName_').AsString := pValue;
end;

function TDlrdscBtr.ReadComPrc:double;
begin
  Result := oBtrTable.FieldByName('ComPrc').AsFloat;
end;

procedure TDlrdscBtr.WriteComPrc(pValue:double);
begin
  oBtrTable.FieldByName('ComPrc').AsFloat := pValue;
end;

function TDlrdscBtr.ReadDefDsc:double;
begin
  Result := oBtrTable.FieldByName('DefDsc').AsFloat;
end;

procedure TDlrdscBtr.WriteDefDsc(pValue:double);
begin
  oBtrTable.FieldByName('DefDsc').AsFloat := pValue;
end;

function TDlrdscBtr.ReadMaxDsc:double;
begin
  Result := oBtrTable.FieldByName('MaxDsc').AsFloat;
end;

procedure TDlrdscBtr.WriteMaxDsc(pValue:double);
begin
  oBtrTable.FieldByName('MaxDsc').AsFloat := pValue;
end;

function TDlrdscBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TDlrdscBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TDlrdscBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDlrdscBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDlrdscBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDlrdscBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDlrdscBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDlrdscBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDlrdscBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TDlrdscBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TDlrdscBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDlrdscBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDlrdscBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDlrdscBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDlrdscBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDlrdscBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDlrdscBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDlrdscBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDlrdscBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDlrdscBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDlrdscBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDlrdscBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDlrdscBtr.LocateDcItIc (pDlrCode:word;pItmType:Str1;pItmCode:longint):boolean;
begin
  SetIndex (ixDcItIc);
  Result := oBtrTable.FindKey([pDlrCode,pItmType,pItmCode]);
end;

function TDlrdscBtr.LocateItmCode (pItmCode:longint):boolean;
begin
  SetIndex (ixItmCode);
  Result := oBtrTable.FindKey([pItmCode]);
end;

function TDlrdscBtr.LocateItmName (pItmName_:Str30):boolean;
begin
  SetIndex (ixItmName);
  Result := oBtrTable.FindKey([StrToAlias(pItmName_)]);
end;

function TDlrdscBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TDlrdscBtr.NearestDcItIc (pDlrCode:word;pItmType:Str1;pItmCode:longint):boolean;
begin
  SetIndex (ixDcItIc);
  Result := oBtrTable.FindNearest([pDlrCode,pItmType,pItmCode]);
end;

function TDlrdscBtr.NearestItmCode (pItmCode:longint):boolean;
begin
  SetIndex (ixItmCode);
  Result := oBtrTable.FindNearest([pItmCode]);
end;

function TDlrdscBtr.NearestItmName (pItmName_:Str30):boolean;
begin
  SetIndex (ixItmName);
  Result := oBtrTable.FindNearest([pItmName_]);
end;

function TDlrdscBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TDlrdscBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDlrdscBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDlrdscBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDlrdscBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDlrdscBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDlrdscBtr.First;
begin
  oBtrTable.First;
end;

procedure TDlrdscBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDlrdscBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDlrdscBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDlrdscBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDlrdscBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDlrdscBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDlrdscBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDlrdscBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDlrdscBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDlrdscBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDlrdscBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
