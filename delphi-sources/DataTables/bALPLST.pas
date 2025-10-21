unit bALPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';

type
  TAlplstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAgAPrice:double;       procedure WriteAgAPrice (pValue:double);
    function  ReadAgBPrice:double;       procedure WriteAgBPrice (pValue:double);
    function  ReadAsGsCode:longint;      procedure WriteAsGsCode (pValue:longint);
    function  ReadAsGsName:Str30;        procedure WriteAsGsName (pValue:Str30);
    function  ReadAsBarCode:Str15;       procedure WriteAsBarCode (pValue:Str15);
    function  ReadAsAPrice:double;       procedure WriteAsAPrice (pValue:double);
    function  ReadAsBPrice:double;       procedure WriteAsBPrice (pValue:double);
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
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str30):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property AgAPrice:double read ReadAgAPrice write WriteAgAPrice;
    property AgBPrice:double read ReadAgBPrice write WriteAgBPrice;
    property AsGsCode:longint read ReadAsGsCode write WriteAsGsCode;
    property AsGsName:Str30 read ReadAsGsName write WriteAsGsName;
    property AsBarCode:Str15 read ReadAsBarCode write WriteAsBarCode;
    property AsAPrice:double read ReadAsAPrice write WriteAsAPrice;
    property AsBPrice:double read ReadAsBPrice write WriteAsBPrice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAlplstBtr.Create;
begin
  oBtrTable := BtrInit ('ALPLST',gPath.StkPath,Self);
end;

constructor TAlplstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ALPLST',pPath,Self);
end;

destructor TAlplstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAlplstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAlplstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAlplstBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TAlplstBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAlplstBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TAlplstBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TAlplstBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TAlplstBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TAlplstBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TAlplstBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TAlplstBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TAlplstBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TAlplstBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAlplstBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAlplstBtr.ReadAgAPrice:double;
begin
  Result := oBtrTable.FieldByName('AgAPrice').AsFloat;
end;

procedure TAlplstBtr.WriteAgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AgAPrice').AsFloat := pValue;
end;

function TAlplstBtr.ReadAgBPrice:double;
begin
  Result := oBtrTable.FieldByName('AgBPrice').AsFloat;
end;

procedure TAlplstBtr.WriteAgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AgBPrice').AsFloat := pValue;
end;

function TAlplstBtr.ReadAsGsCode:longint;
begin
  Result := oBtrTable.FieldByName('AsGsCode').AsInteger;
end;

procedure TAlplstBtr.WriteAsGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('AsGsCode').AsInteger := pValue;
end;

function TAlplstBtr.ReadAsGsName:Str30;
begin
  Result := oBtrTable.FieldByName('AsGsName').AsString;
end;

procedure TAlplstBtr.WriteAsGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('AsGsName').AsString := pValue;
end;

function TAlplstBtr.ReadAsBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('AsBarCode').AsString;
end;

procedure TAlplstBtr.WriteAsBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('AsBarCode').AsString := pValue;
end;

function TAlplstBtr.ReadAsAPrice:double;
begin
  Result := oBtrTable.FieldByName('AsAPrice').AsFloat;
end;

procedure TAlplstBtr.WriteAsAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsAPrice').AsFloat := pValue;
end;

function TAlplstBtr.ReadAsBPrice:double;
begin
  Result := oBtrTable.FieldByName('AsBPrice').AsFloat;
end;

procedure TAlplstBtr.WriteAsBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsBPrice').AsFloat := pValue;
end;

function TAlplstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAlplstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAlplstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAlplstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAlplstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAlplstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAlplstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAlplstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAlplstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAlplstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAlplstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAlplstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAlplstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlplstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAlplstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlplstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAlplstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAlplstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAlplstBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TAlplstBtr.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TAlplstBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TAlplstBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TAlplstBtr.NearestGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TAlplstBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

procedure TAlplstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAlplstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAlplstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAlplstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAlplstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAlplstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAlplstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAlplstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAlplstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAlplstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAlplstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAlplstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAlplstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAlplstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAlplstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAlplstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAlplstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
