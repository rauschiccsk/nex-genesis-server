unit tFIFDUP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRecNum = '';
  ixFifNum = 'FifNum';

type
  TFifdupTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRecNum:longint;        procedure WriteRecNum (pValue:longint);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadInPrice:double;        procedure WriteInPrice (pValue:double);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadNewFif:longint;        procedure WriteNewFif (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRecNum (pRecNum:longint):boolean;
    function LocateFifNum (pFifNum:longint):boolean;

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
    property RecNum:longint read ReadRecNum write WriteRecNum;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property InPrice:double read ReadInPrice write WriteInPrice;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Sended:boolean read ReadSended write WriteSended;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property NewFif:longint read ReadNewFif write WriteNewFif;
  end;

implementation

constructor TFifdupTmp.Create;
begin
  oTmpTable := TmpInit ('FIFDUP',Self);
end;

destructor TFifdupTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFifdupTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFifdupTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFifdupTmp.ReadRecNum:longint;
begin
  Result := oTmpTable.FieldByName('RecNum').AsInteger;
end;

procedure TFifdupTmp.WriteRecNum(pValue:longint);
begin
  oTmpTable.FieldByName('RecNum').AsInteger := pValue;
end;

function TFifdupTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TFifdupTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TFifdupTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TFifdupTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TFifdupTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFifdupTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFifdupTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TFifdupTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TFifdupTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFifdupTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFifdupTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TFifdupTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TFifdupTmp.ReadInPrice:double;
begin
  Result := oTmpTable.FieldByName('InPrice').AsFloat;
end;

procedure TFifdupTmp.WriteInPrice(pValue:double);
begin
  oTmpTable.FieldByName('InPrice').AsFloat := pValue;
end;

function TFifdupTmp.ReadInQnt:double;
begin
  Result := oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TFifdupTmp.WriteInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TFifdupTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TFifdupTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TFifdupTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TFifdupTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TFifdupTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TFifdupTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TFifdupTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TFifdupTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TFifdupTmp.ReadAcqStat:Str1;
begin
  Result := oTmpTable.FieldByName('AcqStat').AsString;
end;

procedure TFifdupTmp.WriteAcqStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqStat').AsString := pValue;
end;

function TFifdupTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TFifdupTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFifdupTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TFifdupTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TFifdupTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TFifdupTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TFifdupTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TFifdupTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TFifdupTmp.ReadNewFif:longint;
begin
  Result := oTmpTable.FieldByName('NewFif').AsInteger;
end;

procedure TFifdupTmp.WriteNewFif(pValue:longint);
begin
  oTmpTable.FieldByName('NewFif').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFifdupTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFifdupTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFifdupTmp.LocateRecNum (pRecNum:longint):boolean;
begin
  SetIndex (ixRecNum);
  Result := oTmpTable.FindKey([pRecNum]);
end;

function TFifdupTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

procedure TFifdupTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFifdupTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFifdupTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFifdupTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFifdupTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFifdupTmp.First;
begin
  oTmpTable.First;
end;

procedure TFifdupTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFifdupTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFifdupTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFifdupTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFifdupTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFifdupTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFifdupTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFifdupTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFifdupTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFifdupTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFifdupTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1916001}
