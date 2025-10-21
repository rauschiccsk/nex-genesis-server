unit bAOI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixStatus = 'Status';

type
  TAoiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadAgAPrice:double;       procedure WriteAgAPrice (pValue:double);
    function  ReadAgBPrice:double;       procedure WriteAgBPrice (pValue:double);
    function  ReadAgAValue:double;       procedure WriteAgAValue (pValue:double);
    function  ReadAgBValue:double;       procedure WriteAgBValue (pValue:double);
    function  ReadAsDPrice:double;       procedure WriteAsDPrice (pValue:double);
    function  ReadAsHPrice:double;       procedure WriteAsHPrice (pValue:double);
    function  ReadAsAPrice:double;       procedure WriteAsAPrice (pValue:double);
    function  ReadAsBPrice:double;       procedure WriteAsBPrice (pValue:double);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBValue:double;       procedure WriteAsBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadAmdNum:Str12;          procedure WriteAmdNum (pValue:Str12);
    function  ReadAmdItm:word;           procedure WriteAmdItm (pValue:word);
    function  ReadAldNum:Str12;          procedure WriteAldNum (pValue:Str12);
    function  ReadAldItm:word;           procedure WriteAldItm (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStatus (pStatus:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property AgAPrice:double read ReadAgAPrice write WriteAgAPrice;
    property AgBPrice:double read ReadAgBPrice write WriteAgBPrice;
    property AgAValue:double read ReadAgAValue write WriteAgAValue;
    property AgBValue:double read ReadAgBValue write WriteAgBValue;
    property AsDPrice:double read ReadAsDPrice write WriteAsDPrice;
    property AsHPrice:double read ReadAsHPrice write WriteAsHPrice;
    property AsAPrice:double read ReadAsAPrice write WriteAsAPrice;
    property AsBPrice:double read ReadAsBPrice write WriteAsBPrice;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBValue:double read ReadAsBValue write WriteAsBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property Notice:Str60 read ReadNotice write WriteNotice;
    property AmdNum:Str12 read ReadAmdNum write WriteAmdNum;
    property AmdItm:word read ReadAmdItm write WriteAmdItm;
    property AldNum:Str12 read ReadAldNum write WriteAldNum;
    property AldItm:word read ReadAldItm write WriteAldItm;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAoiBtr.Create;
begin
  oBtrTable := BtrInit ('AOI',gPath.StkPath,Self);
end;

constructor TAoiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AOI',pPath,Self);
end;

destructor TAoiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAoiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAoiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAoiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAoiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAoiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAoiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAoiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TAoiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAoiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TAoiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TAoiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TAoiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TAoiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TAoiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TAoiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAoiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAoiBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAoiBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAoiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TAoiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TAoiBtr.ReadResQnt:double;
begin
  Result := oBtrTable.FieldByName('ResQnt').AsFloat;
end;

procedure TAoiBtr.WriteResQnt(pValue:double);
begin
  oBtrTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TAoiBtr.ReadAgAPrice:double;
begin
  Result := oBtrTable.FieldByName('AgAPrice').AsFloat;
end;

procedure TAoiBtr.WriteAgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AgAPrice').AsFloat := pValue;
end;

function TAoiBtr.ReadAgBPrice:double;
begin
  Result := oBtrTable.FieldByName('AgBPrice').AsFloat;
end;

procedure TAoiBtr.WriteAgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AgBPrice').AsFloat := pValue;
end;

function TAoiBtr.ReadAgAValue:double;
begin
  Result := oBtrTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAoiBtr.WriteAgAValue(pValue:double);
begin
  oBtrTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAoiBtr.ReadAgBValue:double;
begin
  Result := oBtrTable.FieldByName('AgBValue').AsFloat;
end;

procedure TAoiBtr.WriteAgBValue(pValue:double);
begin
  oBtrTable.FieldByName('AgBValue').AsFloat := pValue;
end;

function TAoiBtr.ReadAsDPrice:double;
begin
  Result := oBtrTable.FieldByName('AsDPrice').AsFloat;
end;

procedure TAoiBtr.WriteAsDPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsDPrice').AsFloat := pValue;
end;

function TAoiBtr.ReadAsHPrice:double;
begin
  Result := oBtrTable.FieldByName('AsHPrice').AsFloat;
end;

procedure TAoiBtr.WriteAsHPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsHPrice').AsFloat := pValue;
end;

function TAoiBtr.ReadAsAPrice:double;
begin
  Result := oBtrTable.FieldByName('AsAPrice').AsFloat;
end;

procedure TAoiBtr.WriteAsAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsAPrice').AsFloat := pValue;
end;

function TAoiBtr.ReadAsBPrice:double;
begin
  Result := oBtrTable.FieldByName('AsBPrice').AsFloat;
end;

procedure TAoiBtr.WriteAsBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsBPrice').AsFloat := pValue;
end;

function TAoiBtr.ReadAsDValue:double;
begin
  Result := oBtrTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAoiBtr.WriteAsDValue(pValue:double);
begin
  oBtrTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAoiBtr.ReadAsHValue:double;
begin
  Result := oBtrTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAoiBtr.WriteAsHValue(pValue:double);
begin
  oBtrTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAoiBtr.ReadAsAValue:double;
begin
  Result := oBtrTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAoiBtr.WriteAsAValue(pValue:double);
begin
  oBtrTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAoiBtr.ReadAsBValue:double;
begin
  Result := oBtrTable.FieldByName('AsBValue').AsFloat;
end;

procedure TAoiBtr.WriteAsBValue(pValue:double);
begin
  oBtrTable.FieldByName('AsBValue').AsFloat := pValue;
end;

function TAoiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAoiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAoiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAoiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAoiBtr.ReadNotice:Str60;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAoiBtr.WriteNotice(pValue:Str60);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TAoiBtr.ReadAmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('AmdNum').AsString;
end;

procedure TAoiBtr.WriteAmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAoiBtr.ReadAmdItm:word;
begin
  Result := oBtrTable.FieldByName('AmdItm').AsInteger;
end;

procedure TAoiBtr.WriteAmdItm(pValue:word);
begin
  oBtrTable.FieldByName('AmdItm').AsInteger := pValue;
end;

function TAoiBtr.ReadAldNum:Str12;
begin
  Result := oBtrTable.FieldByName('AldNum').AsString;
end;

procedure TAoiBtr.WriteAldNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AldNum').AsString := pValue;
end;

function TAoiBtr.ReadAldItm:word;
begin
  Result := oBtrTable.FieldByName('AldItm').AsInteger;
end;

procedure TAoiBtr.WriteAldItm(pValue:word);
begin
  oBtrTable.FieldByName('AldItm').AsInteger := pValue;
end;

function TAoiBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAoiBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAoiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAoiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAoiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAoiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAoiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAoiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAoiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAoiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAoiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAoiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAoiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAoiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAoiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAoiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAoiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAoiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAoiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAoiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAoiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAoiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TAoiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TAoiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TAoiBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TAoiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAoiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TAoiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TAoiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TAoiBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TAoiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAoiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAoiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAoiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAoiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAoiBtr.First;
begin
  oBtrTable.First;
end;

procedure TAoiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAoiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAoiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAoiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAoiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAoiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAoiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAoiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAoiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAoiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAoiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
