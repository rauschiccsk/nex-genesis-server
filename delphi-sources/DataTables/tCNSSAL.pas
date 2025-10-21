unit tCNSSAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum = '';
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';

type
  TCnssalTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadInPrice:double;        procedure WriteInPrice (pValue:double);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadPrvQnt:double;         procedure WritePrvQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadBPrice_0001:double;    procedure WriteBPrice_0001 (pValue:double);
    function  ReadBPrice_0010:double;    procedure WriteBPrice_0010 (pValue:double);
    function  ReadBPrice_0100:double;    procedure WriteBPrice_0100 (pValue:double);
    function  ReadDscPrc_15:double;      procedure WriteDscPrc_15 (pValue:double);
    function  ReadDscPrc_30:double;      procedure WriteDscPrc_30 (pValue:double);
    function  ReadDscPrc_50:double;      procedure WriteDscPrc_50 (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open; virtual;
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
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property InPrice:double read ReadInPrice write WriteInPrice;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property PrvQnt:double read ReadPrvQnt write WritePrvQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property BPrice_0001:double read ReadBPrice_0001 write WriteBPrice_0001;
    property BPrice_0010:double read ReadBPrice_0010 write WriteBPrice_0010;
    property BPrice_0100:double read ReadBPrice_0100 write WriteBPrice_0100;
    property DscPrc_15:double read ReadDscPrc_15 write WriteDscPrc_15;
    property DscPrc_30:double read ReadDscPrc_30 write WriteDscPrc_30;
    property DscPrc_50:double read ReadDscPrc_50 write WriteDscPrc_50;
    property BPrice:double read ReadBPrice write WriteBPrice;
  end;

implementation

constructor TCnssalTmp.Create;
begin
  oTmpTable := TmpInit ('CNSSAL',Self);
end;

destructor TCnssalTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCnssalTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCnssalTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCnssalTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TCnssalTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TCnssalTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TCnssalTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TCnssalTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCnssalTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCnssalTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TCnssalTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCnssalTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TCnssalTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TCnssalTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TCnssalTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TCnssalTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TCnssalTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TCnssalTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCnssalTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCnssalTmp.ReadInPrice:double;
begin
  Result := oTmpTable.FieldByName('InPrice').AsFloat;
end;

procedure TCnssalTmp.WriteInPrice(pValue:double);
begin
  oTmpTable.FieldByName('InPrice').AsFloat := pValue;
end;

function TCnssalTmp.ReadInQnt:double;
begin
  Result := oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TCnssalTmp.WriteInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TCnssalTmp.ReadPrvQnt:double;
begin
  Result := oTmpTable.FieldByName('PrvQnt').AsFloat;
end;

procedure TCnssalTmp.WritePrvQnt(pValue:double);
begin
  oTmpTable.FieldByName('PrvQnt').AsFloat := pValue;
end;

function TCnssalTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TCnssalTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TCnssalTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TCnssalTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TCnssalTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TCnssalTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TCnssalTmp.ReadBPrice_0001:double;
begin
  Result := oTmpTable.FieldByName('BPrice_0001').AsFloat;
end;

procedure TCnssalTmp.WriteBPrice_0001(pValue:double);
begin
  oTmpTable.FieldByName('BPrice_0001').AsFloat := pValue;
end;

function TCnssalTmp.ReadBPrice_0010:double;
begin
  Result := oTmpTable.FieldByName('BPrice_0010').AsFloat;
end;

procedure TCnssalTmp.WriteBPrice_0010(pValue:double);
begin
  oTmpTable.FieldByName('BPrice_0010').AsFloat := pValue;
end;

function TCnssalTmp.ReadBPrice_0100:double;
begin
  Result := oTmpTable.FieldByName('BPrice_0100').AsFloat;
end;

procedure TCnssalTmp.WriteBPrice_0100(pValue:double);
begin
  oTmpTable.FieldByName('BPrice_0100').AsFloat := pValue;
end;

function TCnssalTmp.ReadDscPrc_15:double;
begin
  Result := oTmpTable.FieldByName('DscPrc_15').AsFloat;
end;

procedure TCnssalTmp.WriteDscPrc_15(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc_15').AsFloat := pValue;
end;

function TCnssalTmp.ReadDscPrc_30:double;
begin
  Result := oTmpTable.FieldByName('DscPrc_30').AsFloat;
end;

procedure TCnssalTmp.WriteDscPrc_30(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc_30').AsFloat := pValue;
end;

function TCnssalTmp.ReadDscPrc_50:double;
begin
  Result := oTmpTable.FieldByName('DscPrc_50').AsFloat;
end;

procedure TCnssalTmp.WriteDscPrc_50(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc_50').AsFloat := pValue;
end;

function TCnssalTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCnssalTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCnssalTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCnssalTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCnssalTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

function TCnssalTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TCnssalTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TCnssalTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TCnssalTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TCnssalTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TCnssalTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCnssalTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCnssalTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCnssalTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCnssalTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCnssalTmp.First;
begin
  oTmpTable.First;
end;

procedure TCnssalTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCnssalTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCnssalTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCnssalTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCnssalTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCnssalTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCnssalTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCnssalTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCnssalTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCnssalTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCnssalTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
