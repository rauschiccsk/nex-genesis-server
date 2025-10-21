unit tVTI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYeCnRn = '';
  ixYearClsNum = 'YearClsNum';
  ixDnVp = 'DnVp';
  ixEnVp = 'EnVp';
  ixYeCnDnVpRt = 'YeCnDnVpRt';

type
  TVtiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadClsNum:word;           procedure WriteClsNum (pValue:word);
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadRowTyp:Str2;           procedure WriteRowTyp (pValue:Str2);
    function  ReadVIN:Str20;             procedure WriteVIN (pValue:Str20);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str32;          procedure WriteExtNum (pValue:Str32);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadVValue:double;         procedure WriteVValue (pValue:double);
    function  ReadSValue:double;         procedure WriteSValue (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadSrbCode:Str4;          procedure WriteSrbCode (pValue:Str4);
    function  ReadSrtTyp:Str2;           procedure WriteSrtTyp (pValue:Str2);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadMsName:Str2;           procedure WriteMsName (pValue:Str2);
    function  ReadCorNum:Str1;           procedure WriteCorNum (pValue:Str1);
    function  ReadODocNum:Str12;         procedure WriteODocNum (pValue:Str12);
    function  ReadOExtNum:Str32;         procedure WriteOExtNum (pValue:Str32);
    function  ReadAValue1:double;        procedure WriteAValue1 (pValue:double);
    function  ReadVValue1:double;        procedure WriteVValue1 (pValue:double);
    function  ReadAValue2:double;        procedure WriteAValue2 (pValue:double);
    function  ReadVValue2:double;        procedure WriteVValue2 (pValue:double);
    function  ReadSumarize:byte;         procedure WriteSumarize (pValue:byte);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateYeCnRn (pYear:Str2;pClsNum:word;pRowNum:longint):boolean;
    function LocateYearClsNum (pYear:Str2;pClsNum:word):boolean;
    function LocateDnVp (pDocNum:Str12;pVatPrc:byte):boolean;
    function LocateEnVp (pExtNum:Str32;pVatPrc:byte):boolean;
    function LocateYeCnDnVpRt (pYear:Str2;pClsNum:word;pDocNum:Str12;pVatPrc:byte;pRowTyp:Str2):boolean;

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
    property Year:Str2 read ReadYear write WriteYear;
    property ClsNum:word read ReadClsNum write WriteClsNum;
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property RowTyp:Str2 read ReadRowTyp write WriteRowTyp;
    property VIN:Str20 read ReadVIN write WriteVIN;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str32 read ReadExtNum write WriteExtNum;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property AValue:double read ReadAValue write WriteAValue;
    property VValue:double read ReadVValue write WriteVValue;
    property SValue:double read ReadSValue write WriteSValue;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property SrbCode:Str4 read ReadSrbCode write WriteSrbCode;
    property SrtTyp:Str2 read ReadSrtTyp write WriteSrtTyp;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property MsName:Str2 read ReadMsName write WriteMsName;
    property CorNum:Str1 read ReadCorNum write WriteCorNum;
    property ODocNum:Str12 read ReadODocNum write WriteODocNum;
    property OExtNum:Str32 read ReadOExtNum write WriteOExtNum;
    property AValue1:double read ReadAValue1 write WriteAValue1;
    property VValue1:double read ReadVValue1 write WriteVValue1;
    property AValue2:double read ReadAValue2 write WriteAValue2;
    property VValue2:double read ReadVValue2 write WriteVValue2;
    property Sumarize:byte read ReadSumarize write WriteSumarize;
  end;

implementation

constructor TVtiTmp.Create;
begin
  oTmpTable := TmpInit ('VTI',Self);
end;

destructor TVtiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TVtiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TVtiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TVtiTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TVtiTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TVtiTmp.ReadClsNum:word;
begin
  Result := oTmpTable.FieldByName('ClsNum').AsInteger;
end;

procedure TVtiTmp.WriteClsNum(pValue:word);
begin
  oTmpTable.FieldByName('ClsNum').AsInteger := pValue;
end;

function TVtiTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TVtiTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TVtiTmp.ReadRowTyp:Str2;
begin
  Result := oTmpTable.FieldByName('RowTyp').AsString;
end;

procedure TVtiTmp.WriteRowTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('RowTyp').AsString := pValue;
end;

function TVtiTmp.ReadVIN:Str20;
begin
  Result := oTmpTable.FieldByName('VIN').AsString;
end;

procedure TVtiTmp.WriteVIN(pValue:Str20);
begin
  oTmpTable.FieldByName('VIN').AsString := pValue;
end;

function TVtiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TVtiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TVtiTmp.ReadExtNum:Str32;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TVtiTmp.WriteExtNum(pValue:Str32);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TVtiTmp.ReadVatDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('VatDate').AsDateTime;
end;

procedure TVtiTmp.WriteVatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TVtiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TVtiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TVtiTmp.ReadVValue:double;
begin
  Result := oTmpTable.FieldByName('VValue').AsFloat;
end;

procedure TVtiTmp.WriteVValue(pValue:double);
begin
  oTmpTable.FieldByName('VValue').AsFloat := pValue;
end;

function TVtiTmp.ReadSValue:double;
begin
  Result := oTmpTable.FieldByName('SValue').AsFloat;
end;

procedure TVtiTmp.WriteSValue(pValue:double);
begin
  oTmpTable.FieldByName('SValue').AsFloat := pValue;
end;

function TVtiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TVtiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TVtiTmp.ReadSrbCode:Str4;
begin
  Result := oTmpTable.FieldByName('SrbCode').AsString;
end;

procedure TVtiTmp.WriteSrbCode(pValue:Str4);
begin
  oTmpTable.FieldByName('SrbCode').AsString := pValue;
end;

function TVtiTmp.ReadSrtTyp:Str2;
begin
  Result := oTmpTable.FieldByName('SrtTyp').AsString;
end;

procedure TVtiTmp.WriteSrtTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('SrtTyp').AsString := pValue;
end;

function TVtiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TVtiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TVtiTmp.ReadMsName:Str2;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TVtiTmp.WriteMsName(pValue:Str2);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TVtiTmp.ReadCorNum:Str1;
begin
  Result := oTmpTable.FieldByName('CorNum').AsString;
end;

procedure TVtiTmp.WriteCorNum(pValue:Str1);
begin
  oTmpTable.FieldByName('CorNum').AsString := pValue;
end;

function TVtiTmp.ReadODocNum:Str12;
begin
  Result := oTmpTable.FieldByName('ODocNum').AsString;
end;

procedure TVtiTmp.WriteODocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ODocNum').AsString := pValue;
end;

function TVtiTmp.ReadOExtNum:Str32;
begin
  Result := oTmpTable.FieldByName('OExtNum').AsString;
end;

procedure TVtiTmp.WriteOExtNum(pValue:Str32);
begin
  oTmpTable.FieldByName('OExtNum').AsString := pValue;
end;

function TVtiTmp.ReadAValue1:double;
begin
  Result := oTmpTable.FieldByName('AValue1').AsFloat;
end;

procedure TVtiTmp.WriteAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TVtiTmp.ReadVValue1:double;
begin
  Result := oTmpTable.FieldByName('VValue1').AsFloat;
end;

procedure TVtiTmp.WriteVValue1(pValue:double);
begin
  oTmpTable.FieldByName('VValue1').AsFloat := pValue;
end;

function TVtiTmp.ReadAValue2:double;
begin
  Result := oTmpTable.FieldByName('AValue2').AsFloat;
end;

procedure TVtiTmp.WriteAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TVtiTmp.ReadVValue2:double;
begin
  Result := oTmpTable.FieldByName('VValue2').AsFloat;
end;

procedure TVtiTmp.WriteVValue2(pValue:double);
begin
  oTmpTable.FieldByName('VValue2').AsFloat := pValue;
end;

function TVtiTmp.ReadSumarize:byte;
begin
  Result := oTmpTable.FieldByName('Sumarize').AsInteger;
end;

procedure TVtiTmp.WriteSumarize(pValue:byte);
begin
  oTmpTable.FieldByName('Sumarize').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TVtiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TVtiTmp.LocateYeCnRn (pYear:Str2;pClsNum:word;pRowNum:longint):boolean;
begin
  SetIndex (ixYeCnRn);
  Result := oTmpTable.FindKey([pYear,pClsNum,pRowNum]);
end;

function TVtiTmp.LocateYearClsNum (pYear:Str2;pClsNum:word):boolean;
begin
  SetIndex (ixYearClsNum);
  Result := oTmpTable.FindKey([pYear,pClsNum]);
end;

function TVtiTmp.LocateDnVp (pDocNum:Str12;pVatPrc:byte):boolean;
begin
  SetIndex (ixDnVp);
  Result := oTmpTable.FindKey([pDocNum,pVatPrc]);
end;

function TVtiTmp.LocateEnVp (pExtNum:Str32;pVatPrc:byte):boolean;
begin
  SetIndex (ixEnVp);
  Result := oTmpTable.FindKey([pExtNum,pVatPrc]);
end;

function TVtiTmp.LocateYeCnDnVpRt (pYear:Str2;pClsNum:word;pDocNum:Str12;pVatPrc:byte;pRowTyp:Str2):boolean;
begin
  SetIndex (ixYeCnDnVpRt);
  Result := oTmpTable.FindKey([pYear,pClsNum,pDocNum,pVatPrc,pRowTyp]);
end;

procedure TVtiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TVtiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TVtiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TVtiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TVtiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TVtiTmp.First;
begin
  oTmpTable.First;
end;

procedure TVtiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TVtiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TVtiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TVtiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TVtiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TVtiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TVtiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TVtiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TVtiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TVtiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TVtiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1806003}
