unit bRSS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixResNum = 'ResNum';
  ixReVi = 'ReVi';

type
  TRssBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSernum:longint;        procedure WriteSernum (pValue:longint);
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadDaily:Str1;            procedure WriteDaily (pValue:Str1);
    function  ReadQuant:double;          procedure WriteQuant (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSrvCode:longint;       procedure WriteSrvCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
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
    function LocateResNum (pResNum:longint):boolean;
    function LocateReVi (pResNum:longint;pVisNum:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestResNum (pResNum:longint):boolean;
    function NearestReVi (pResNum:longint;pVisNum:longint):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property Sernum:longint read ReadSernum write WriteSernum;
    property ResNum:longint read ReadResNum write WriteResNum;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Daily:Str1 read ReadDaily write WriteDaily;
    property Quant:double read ReadQuant write WriteQuant;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SrvCode:longint read ReadSrvCode write WriteSrvCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property ActPosM:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRssBtr.Create;
begin
  oBtrTable := BtrInit ('RSS',gPath.HtlPath,Self);
end;

constructor TRssBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RSS',pPath,Self);
end;

destructor TRssBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRssBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRssBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRssBtr.ReadSernum:longint;
begin
  Result := oBtrTable.FieldByName('Sernum').AsInteger;
end;

procedure TRssBtr.WriteSernum(pValue:longint);
begin
  oBtrTable.FieldByName('Sernum').AsInteger := pValue;
end;

function TRssBtr.ReadResNum:longint;
begin
  Result := oBtrTable.FieldByName('ResNum').AsInteger;
end;

procedure TRssBtr.WriteResNum(pValue:longint);
begin
  oBtrTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRssBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TRssBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TRssBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TRssBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRssBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TRssBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TRssBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TRssBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TRssBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TRssBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TRssBtr.ReadVatPrc:double;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsFloat;
end;

procedure TRssBtr.WriteVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TRssBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TRssBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TRssBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TRssBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TRssBtr.ReadDaily:Str1;
begin
  Result := oBtrTable.FieldByName('Daily').AsString;
end;

procedure TRssBtr.WriteDaily(pValue:Str1);
begin
  oBtrTable.FieldByName('Daily').AsString := pValue;
end;

function TRssBtr.ReadQuant:double;
begin
  Result := oBtrTable.FieldByName('Quant').AsFloat;
end;

procedure TRssBtr.WriteQuant(pValue:double);
begin
  oBtrTable.FieldByName('Quant').AsFloat := pValue;
end;

function TRssBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TRssBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TRssBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TRssBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TRssBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRssBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRssBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRssBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRssBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRssBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRssBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRssBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRssBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRssBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRssBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRssBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRssBtr.ReadSrvCode:longint;
begin
  Result := oBtrTable.FieldByName('SrvCode').AsInteger;
end;

procedure TRssBtr.WriteSrvCode(pValue:longint);
begin
  oBtrTable.FieldByName('SrvCode').AsInteger := pValue;
end;

function TRssBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TRssBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TRssBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TRssBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRssBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRssBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRssBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRssBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRssBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRssBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRssBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TRssBtr.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindKey([pResNum]);
end;

function TRssBtr.LocateReVi (pResNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixReVi);
  Result := oBtrTable.FindKey([pResNum,pVisNum]);
end;

function TRssBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TRssBtr.NearestResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindNearest([pResNum]);
end;

function TRssBtr.NearestReVi (pResNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixReVi);
  Result := oBtrTable.FindNearest([pResNum,pVisNum]);
end;

procedure TRssBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRssBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRssBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRssBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRssBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRssBtr.First;
begin
  oBtrTable.First;
end;

procedure TRssBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRssBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRssBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRssBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRssBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRssBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRssBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRssBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRssBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRssBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRssBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
