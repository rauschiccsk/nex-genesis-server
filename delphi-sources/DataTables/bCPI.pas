unit bCPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPdCp = 'PdCp';
  ixPdCode = 'PdCode';

type
  TCpiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadRcGsQnt:double;        procedure WriteRcGsQnt (pValue:double);
    function  ReadLosPrc:double;         procedure WriteLosPrc (pValue:double);
    function  ReadCpGsQnt:double;        procedure WriteCpGsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDPrice:double;         procedure WriteDPrice (pValue:double);
    function  ReadHPrice:double;         procedure WriteHPrice (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadNotice:Str80;          procedure WriteNotice (pValue:Str80);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadPdGsQntu:double;       procedure WritePdGsQntu (pValue:double);
    function  ReadRcGsQntu:double;       procedure WriteRcGsQntu (pValue:double);
    function  ReadCpGsQntu:double;       procedure WriteCpGsQntu (pValue:double);
    function  ReadMsuName:Str10;         procedure WriteMsuName (pValue:Str10);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePdCp (pPdCode:longint;pCpCode:longint):boolean;
    function LocatePdCode (pPdCode:longint):boolean;
    function NearestPdCp (pPdCode:longint;pCpCode:longint):boolean;
    function NearestPdCode (pPdCode:longint):boolean;

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
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property RcGsQnt:double read ReadRcGsQnt write WriteRcGsQnt;
    property LosPrc:double read ReadLosPrc write WriteLosPrc;
    property CpGsQnt:double read ReadCpGsQnt write WriteCpGsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DPrice:double read ReadDPrice write WriteDPrice;
    property HPrice:double read ReadHPrice write WriteHPrice;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscType:Str1 read ReadDscType write WriteDscType;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Notice:Str80 read ReadNotice write WriteNotice;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property PdGsQntu:double read ReadPdGsQntu write WritePdGsQntu;
    property RcGsQntu:double read ReadRcGsQntu write WriteRcGsQntu;
    property CpGsQntu:double read ReadCpGsQntu write WriteCpGsQntu;
    property MsuName:Str10 read ReadMsuName write WriteMsuName;
  end;

implementation

constructor TCpiBtr.Create;
begin
  oBtrTable := BtrInit ('CPI',gPath.StkPath,Self);
end;

constructor TCpiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CPI',pPath,Self);
end;

destructor TCpiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCpiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCpiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCpiBtr.ReadPdCode:longint;
begin
  Result := oBtrTable.FieldByName('PdCode').AsInteger;
end;

procedure TCpiBtr.WritePdCode(pValue:longint);
begin
  oBtrTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TCpiBtr.ReadCpCode:longint;
begin
  Result := oBtrTable.FieldByName('CpCode').AsInteger;
end;

procedure TCpiBtr.WriteCpCode(pValue:longint);
begin
  oBtrTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TCpiBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TCpiBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TCpiBtr.ReadCpName:Str30;
begin
  Result := oBtrTable.FieldByName('CpName').AsString;
end;

procedure TCpiBtr.WriteCpName(pValue:Str30);
begin
  oBtrTable.FieldByName('CpName').AsString := pValue;
end;

function TCpiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TCpiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TCpiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCpiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCpiBtr.ReadPdGsQnt:double;
begin
  Result := oBtrTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TCpiBtr.WritePdGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TCpiBtr.ReadRcGsQnt:double;
begin
  Result := oBtrTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TCpiBtr.WriteRcGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TCpiBtr.ReadLosPrc:double;
begin
  Result := oBtrTable.FieldByName('LosPrc').AsFloat;
end;

procedure TCpiBtr.WriteLosPrc(pValue:double);
begin
  oBtrTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TCpiBtr.ReadCpGsQnt:double;
begin
  Result := oBtrTable.FieldByName('CpGsQnt').AsFloat;
end;

procedure TCpiBtr.WriteCpGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpGsQnt').AsFloat := pValue;
end;

function TCpiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TCpiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TCpiBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TCpiBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TCpiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TCpiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCpiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCpiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCpiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCpiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCpiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCpiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCpiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCpiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCpiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCpiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCpiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCpiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCpiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCpiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCpiBtr.ReadDPrice:double;
begin
  Result := oBtrTable.FieldByName('DPrice').AsFloat;
end;

procedure TCpiBtr.WriteDPrice(pValue:double);
begin
  oBtrTable.FieldByName('DPrice').AsFloat := pValue;
end;

function TCpiBtr.ReadHPrice:double;
begin
  Result := oBtrTable.FieldByName('HPrice').AsFloat;
end;

procedure TCpiBtr.WriteHPrice(pValue:double);
begin
  oBtrTable.FieldByName('HPrice').AsFloat := pValue;
end;

function TCpiBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCpiBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCpiBtr.ReadDscType:Str1;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TCpiBtr.WriteDscType(pValue:Str1);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;

function TCpiBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TCpiBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TCpiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TCpiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCpiBtr.ReadNotice:Str80;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TCpiBtr.WriteNotice(pValue:Str80);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TCpiBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TCpiBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

function TCpiBtr.ReadPdGsQntu:double;
begin
  Result := oBtrTable.FieldByName('PdGsQntu').AsFloat;
end;

procedure TCpiBtr.WritePdGsQntu(pValue:double);
begin
  oBtrTable.FieldByName('PdGsQntu').AsFloat := pValue;
end;

function TCpiBtr.ReadRcGsQntu:double;
begin
  Result := oBtrTable.FieldByName('RcGsQntu').AsFloat;
end;

procedure TCpiBtr.WriteRcGsQntu(pValue:double);
begin
  oBtrTable.FieldByName('RcGsQntu').AsFloat := pValue;
end;

function TCpiBtr.ReadCpGsQntu:double;
begin
  Result := oBtrTable.FieldByName('CpGsQntu').AsFloat;
end;

procedure TCpiBtr.WriteCpGsQntu(pValue:double);
begin
  oBtrTable.FieldByName('CpGsQntu').AsFloat := pValue;
end;

function TCpiBtr.ReadMsuName:Str10;
begin
  Result := oBtrTable.FieldByName('MsuName').AsString;
end;

procedure TCpiBtr.WriteMsuName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsuName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCpiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCpiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCpiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCpiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCpiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCpiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCpiBtr.LocatePdCp (pPdCode:longint;pCpCode:longint):boolean;
begin
  SetIndex (ixPdCp);
  Result := oBtrTable.FindKey([pPdCode,pCpCode]);
end;

function TCpiBtr.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindKey([pPdCode]);
end;

function TCpiBtr.NearestPdCp (pPdCode:longint;pCpCode:longint):boolean;
begin
  SetIndex (ixPdCp);
  Result := oBtrTable.FindNearest([pPdCode,pCpCode]);
end;

function TCpiBtr.NearestPdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindNearest([pPdCode]);
end;

procedure TCpiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCpiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCpiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCpiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCpiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCpiBtr.First;
begin
  oBtrTable.First;
end;

procedure TCpiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCpiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCpiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCpiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCpiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCpiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCpiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCpiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCpiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCpiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCpiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
