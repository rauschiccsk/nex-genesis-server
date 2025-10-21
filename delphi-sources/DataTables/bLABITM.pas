unit bLabitm;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';

type
  TLabitmBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadPckQnt:word;           procedure WritePckQnt (pValue:word);
    function  ReadLabQnt:word;           procedure WriteLabQnt (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property PckQnt:word read ReadPckQnt write WritePckQnt;
    property LabQnt:word read ReadLabQnt write WriteLabQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TLabitmBtr.Create;
begin
  oBtrTable := BtrInit ('LABITM',gPath.StkPath,Self);
end;

destructor TLabitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TLabitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TLabitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TLabitmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TLabitmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TLabitmBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TLabitmBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TLabitmBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TLabitmBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TLabitmBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TLabitmBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TLabitmBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TLabitmBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TLabitmBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TLabitmBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TLabitmBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TLabitmBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TLabitmBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TLabitmBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TLabitmBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TLabitmBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TLabitmBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TLabitmBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TLabitmBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TLabitmBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TLabitmBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TLabitmBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TLabitmBtr.ReadPckQnt:word;
begin
  Result := oBtrTable.FieldByName('PckQnt').AsInteger;
end;

procedure TLabitmBtr.WritePckQnt(pValue:word);
begin
  oBtrTable.FieldByName('PckQnt').AsInteger := pValue;
end;

function TLabitmBtr.ReadLabQnt:word;
begin
  Result := oBtrTable.FieldByName('LabQnt').AsInteger;
end;

procedure TLabitmBtr.WriteLabQnt(pValue:word);
begin
  oBtrTable.FieldByName('LabQnt').AsInteger := pValue;
end;

function TLabitmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TLabitmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TLabitmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TLabitmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TLabitmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TLabitmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TLabitmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TLabitmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TLabitmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TLabitmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TLabitmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TLabitmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLabitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLabitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TLabitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TLabitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TLabitmBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TLabitmBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([pGsName_]);
end;

function TLabitmBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TLabitmBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

procedure TLabitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TLabitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TLabitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TLabitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TLabitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TLabitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TLabitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TLabitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TLabitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TLabitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TLabitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TLabitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TLabitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TLabitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TLabitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TLabitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TLabitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
