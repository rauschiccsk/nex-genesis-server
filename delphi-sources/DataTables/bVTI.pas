unit bVTI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYeCnRn = 'YeCnRn';
  ixYearClsNum = 'YearClsNum';
  ixDnVp = 'DnVp';
  ixEnVp = 'EnVp';
  ixYeCnDnVpRt = 'YeCnDnVpRt';

type
  TVtiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
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
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYeCnRn (pYear:Str2;pClsNum:word;pRowNum:longint):boolean;
    function LocateYearClsNum (pYear:Str2;pClsNum:word):boolean;
    function LocateDnVp (pDocNum:Str12;pVatPrc:byte):boolean;
    function LocateEnVp (pExtNum:Str32;pVatPrc:byte):boolean;
    function LocateYeCnDnVpRt (pYear:Str2;pClsNum:word;pDocNum:Str12;pVatPrc:byte;pRowTyp:Str2):boolean;
    function NearestYeCnRn (pYear:Str2;pClsNum:word;pRowNum:longint):boolean;
    function NearestYearClsNum (pYear:Str2;pClsNum:word):boolean;
    function NearestDnVp (pDocNum:Str12;pVatPrc:byte):boolean;
    function NearestEnVp (pExtNum:Str32;pVatPrc:byte):boolean;
    function NearestYeCnDnVpRt (pYear:Str2;pClsNum:word;pDocNum:Str12;pVatPrc:byte;pRowTyp:Str2):boolean;

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

constructor TVtiBtr.Create;
begin
  oBtrTable := BtrInit ('VTI',gPath.LdgPath,Self);
end;

constructor TVtiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VTI',pPath,Self);
end;

destructor TVtiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVtiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVtiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVtiBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TVtiBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TVtiBtr.ReadClsNum:word;
begin
  Result := oBtrTable.FieldByName('ClsNum').AsInteger;
end;

procedure TVtiBtr.WriteClsNum(pValue:word);
begin
  oBtrTable.FieldByName('ClsNum').AsInteger := pValue;
end;

function TVtiBtr.ReadRowNum:longint;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TVtiBtr.WriteRowNum(pValue:longint);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TVtiBtr.ReadRowTyp:Str2;
begin
  Result := oBtrTable.FieldByName('RowTyp').AsString;
end;

procedure TVtiBtr.WriteRowTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('RowTyp').AsString := pValue;
end;

function TVtiBtr.ReadVIN:Str20;
begin
  Result := oBtrTable.FieldByName('VIN').AsString;
end;

procedure TVtiBtr.WriteVIN(pValue:Str20);
begin
  oBtrTable.FieldByName('VIN').AsString := pValue;
end;

function TVtiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TVtiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TVtiBtr.ReadExtNum:Str32;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TVtiBtr.WriteExtNum(pValue:Str32);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TVtiBtr.ReadVatDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('VatDate').AsDateTime;
end;

procedure TVtiBtr.WriteVatDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TVtiBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TVtiBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TVtiBtr.ReadVValue:double;
begin
  Result := oBtrTable.FieldByName('VValue').AsFloat;
end;

procedure TVtiBtr.WriteVValue(pValue:double);
begin
  oBtrTable.FieldByName('VValue').AsFloat := pValue;
end;

function TVtiBtr.ReadSValue:double;
begin
  Result := oBtrTable.FieldByName('SValue').AsFloat;
end;

procedure TVtiBtr.WriteSValue(pValue:double);
begin
  oBtrTable.FieldByName('SValue').AsFloat := pValue;
end;

function TVtiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TVtiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TVtiBtr.ReadSrbCode:Str4;
begin
  Result := oBtrTable.FieldByName('SrbCode').AsString;
end;

procedure TVtiBtr.WriteSrbCode(pValue:Str4);
begin
  oBtrTable.FieldByName('SrbCode').AsString := pValue;
end;

function TVtiBtr.ReadSrtTyp:Str2;
begin
  Result := oBtrTable.FieldByName('SrtTyp').AsString;
end;

procedure TVtiBtr.WriteSrtTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('SrtTyp').AsString := pValue;
end;

function TVtiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TVtiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TVtiBtr.ReadMsName:Str2;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TVtiBtr.WriteMsName(pValue:Str2);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TVtiBtr.ReadCorNum:Str1;
begin
  Result := oBtrTable.FieldByName('CorNum').AsString;
end;

procedure TVtiBtr.WriteCorNum(pValue:Str1);
begin
  oBtrTable.FieldByName('CorNum').AsString := pValue;
end;

function TVtiBtr.ReadODocNum:Str12;
begin
  Result := oBtrTable.FieldByName('ODocNum').AsString;
end;

procedure TVtiBtr.WriteODocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ODocNum').AsString := pValue;
end;

function TVtiBtr.ReadOExtNum:Str32;
begin
  Result := oBtrTable.FieldByName('OExtNum').AsString;
end;

procedure TVtiBtr.WriteOExtNum(pValue:Str32);
begin
  oBtrTable.FieldByName('OExtNum').AsString := pValue;
end;

function TVtiBtr.ReadAValue1:double;
begin
  Result := oBtrTable.FieldByName('AValue1').AsFloat;
end;

procedure TVtiBtr.WriteAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TVtiBtr.ReadVValue1:double;
begin
  Result := oBtrTable.FieldByName('VValue1').AsFloat;
end;

procedure TVtiBtr.WriteVValue1(pValue:double);
begin
  oBtrTable.FieldByName('VValue1').AsFloat := pValue;
end;

function TVtiBtr.ReadAValue2:double;
begin
  Result := oBtrTable.FieldByName('AValue2').AsFloat;
end;

procedure TVtiBtr.WriteAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TVtiBtr.ReadVValue2:double;
begin
  Result := oBtrTable.FieldByName('VValue2').AsFloat;
end;

procedure TVtiBtr.WriteVValue2(pValue:double);
begin
  oBtrTable.FieldByName('VValue2').AsFloat := pValue;
end;

function TVtiBtr.ReadSumarize:byte;
begin
  Result := oBtrTable.FieldByName('Sumarize').AsInteger;
end;

procedure TVtiBtr.WriteSumarize(pValue:byte);
begin
  oBtrTable.FieldByName('Sumarize').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVtiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVtiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVtiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVtiBtr.LocateYeCnRn (pYear:Str2;pClsNum:word;pRowNum:longint):boolean;
begin
  SetIndex (ixYeCnRn);
  Result := oBtrTable.FindKey([pYear,pClsNum,pRowNum]);
end;

function TVtiBtr.LocateYearClsNum (pYear:Str2;pClsNum:word):boolean;
begin
  SetIndex (ixYearClsNum);
  Result := oBtrTable.FindKey([pYear,pClsNum]);
end;

function TVtiBtr.LocateDnVp (pDocNum:Str12;pVatPrc:byte):boolean;
begin
  SetIndex (ixDnVp);
  Result := oBtrTable.FindKey([pDocNum,pVatPrc]);
end;

function TVtiBtr.LocateEnVp (pExtNum:Str32;pVatPrc:byte):boolean;
begin
  SetIndex (ixEnVp);
  Result := oBtrTable.FindKey([pExtNum,pVatPrc]);
end;

function TVtiBtr.LocateYeCnDnVpRt (pYear:Str2;pClsNum:word;pDocNum:Str12;pVatPrc:byte;pRowTyp:Str2):boolean;
begin
  SetIndex (ixYeCnDnVpRt);
  Result := oBtrTable.FindKey([pYear,pClsNum,pDocNum,pVatPrc,pRowTyp]);
end;

function TVtiBtr.NearestYeCnRn (pYear:Str2;pClsNum:word;pRowNum:longint):boolean;
begin
  SetIndex (ixYeCnRn);
  Result := oBtrTable.FindNearest([pYear,pClsNum,pRowNum]);
end;

function TVtiBtr.NearestYearClsNum (pYear:Str2;pClsNum:word):boolean;
begin
  SetIndex (ixYearClsNum);
  Result := oBtrTable.FindNearest([pYear,pClsNum]);
end;

function TVtiBtr.NearestDnVp (pDocNum:Str12;pVatPrc:byte):boolean;
begin
  SetIndex (ixDnVp);
  Result := oBtrTable.FindNearest([pDocNum,pVatPrc]);
end;

function TVtiBtr.NearestEnVp (pExtNum:Str32;pVatPrc:byte):boolean;
begin
  SetIndex (ixEnVp);
  Result := oBtrTable.FindNearest([pExtNum,pVatPrc]);
end;

function TVtiBtr.NearestYeCnDnVpRt (pYear:Str2;pClsNum:word;pDocNum:Str12;pVatPrc:byte;pRowTyp:Str2):boolean;
begin
  SetIndex (ixYeCnDnVpRt);
  Result := oBtrTable.FindNearest([pYear,pClsNum,pDocNum,pVatPrc,pRowTyp]);
end;

procedure TVtiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVtiBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TVtiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVtiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVtiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVtiBtr.First;
begin
  oBtrTable.First;
end;

procedure TVtiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVtiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVtiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVtiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVtiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVtiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVtiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVtiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVtiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVtiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVtiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1805019}
{MOD 1806003}
