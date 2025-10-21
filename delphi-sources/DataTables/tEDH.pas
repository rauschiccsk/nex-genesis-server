unit tEDH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExtNum = '';

type
  TEdhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadTaxDate:TDatetime;     procedure WriteTaxDate (pValue:TDatetime);
    function  ReadRegIno:Str10;          procedure WriteRegIno (pValue:Str10);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateExtNum (pExtNum:Str12):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property TaxDate:TDatetime read ReadTaxDate write WriteTaxDate;
    property RegIno:Str10 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
  end;

implementation

constructor TEdhTmp.Create;
begin
  oTmpTable := TmpInit ('EDH',Self);
end;

destructor TEdhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEdhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TEdhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TEdhTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TEdhTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TEdhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TEdhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TEdhTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TEdhTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TEdhTmp.ReadTaxDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TaxDate').AsDateTime;
end;

procedure TEdhTmp.WriteTaxDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TaxDate').AsDateTime := pValue;
end;

function TEdhTmp.ReadRegIno:Str10;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TEdhTmp.WriteRegIno(pValue:Str10);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TEdhTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TEdhTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TEdhTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TEdhTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TEdhTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TEdhTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TEdhTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TEdhTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TEdhTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TEdhTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TEdhTmp.ReadContoNum:Str30;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TEdhTmp.WriteContoNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TEdhTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TEdhTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TEdhTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TEdhTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TEdhTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TEdhTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TEdhTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TEdhTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TEdhTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TEdhTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TEdhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TEdhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TEdhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TEdhTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

procedure TEdhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TEdhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEdhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEdhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEdhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEdhTmp.First;
begin
  oTmpTable.First;
end;

procedure TEdhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEdhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEdhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEdhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEdhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEdhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEdhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEdhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEdhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEdhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TEdhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
