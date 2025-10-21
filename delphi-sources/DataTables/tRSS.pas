unit tRSS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixResNum = 'ResNum';
  ixReVi = 'ReVi';

type
  TRssTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateResNum (pResNum:longint):boolean;
    function LocateReVi (pResNum:longint;pVisNum:longint):boolean;

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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRssTmp.Create;
begin
  oTmpTable := TmpInit ('RSS',Self);
end;

destructor TRssTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRssTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRssTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRssTmp.ReadSernum:longint;
begin
  Result := oTmpTable.FieldByName('Sernum').AsInteger;
end;

procedure TRssTmp.WriteSernum(pValue:longint);
begin
  oTmpTable.FieldByName('Sernum').AsInteger := pValue;
end;

function TRssTmp.ReadResNum:longint;
begin
  Result := oTmpTable.FieldByName('ResNum').AsInteger;
end;

procedure TRssTmp.WriteResNum(pValue:longint);
begin
  oTmpTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRssTmp.ReadVisNum:longint;
begin
  Result := oTmpTable.FieldByName('VisNum').AsInteger;
end;

procedure TRssTmp.WriteVisNum(pValue:longint);
begin
  oTmpTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TRssTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TRssTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRssTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TRssTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TRssTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TRssTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TRssTmp.ReadGsName_:Str15;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TRssTmp.WriteGsName_(pValue:Str15);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TRssTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TRssTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TRssTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TRssTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TRssTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TRssTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TRssTmp.ReadDaily:Str1;
begin
  Result := oTmpTable.FieldByName('Daily').AsString;
end;

procedure TRssTmp.WriteDaily(pValue:Str1);
begin
  oTmpTable.FieldByName('Daily').AsString := pValue;
end;

function TRssTmp.ReadQuant:double;
begin
  Result := oTmpTable.FieldByName('Quant').AsFloat;
end;

procedure TRssTmp.WriteQuant(pValue:double);
begin
  oTmpTable.FieldByName('Quant').AsFloat := pValue;
end;

function TRssTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TRssTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TRssTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TRssTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TRssTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRssTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRssTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRssTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRssTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRssTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRssTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRssTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRssTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRssTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRssTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRssTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRssTmp.ReadSrvCode:longint;
begin
  Result := oTmpTable.FieldByName('SrvCode').AsInteger;
end;

procedure TRssTmp.WriteSrvCode(pValue:longint);
begin
  oTmpTable.FieldByName('SrvCode').AsInteger := pValue;
end;

function TRssTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TRssTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TRssTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRssTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRssTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRssTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRssTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TRssTmp.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oTmpTable.FindKey([pResNum]);
end;

function TRssTmp.LocateReVi (pResNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixReVi);
  Result := oTmpTable.FindKey([pResNum,pVisNum]);
end;

procedure TRssTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRssTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRssTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRssTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRssTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRssTmp.First;
begin
  oTmpTable.First;
end;

procedure TRssTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRssTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRssTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRssTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRssTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRssTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRssTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRssTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRssTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRssTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRssTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
