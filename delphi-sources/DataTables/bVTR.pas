unit bVTR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDnVg = 'DnVg';
  ixExtNum = 'ExtNum';
  ixVatDate = 'VatDate';
  ixVatPart = 'VatPart';
  ixVtdSpc = 'VtdSpc';
  ixRtDn = 'RtDn';

type
  TVtrBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadVatGrp:byte;           procedure WriteVatGrp (pValue:byte);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadVatPart:Str1;          procedure WriteVatPart (pValue:Str1);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadCorDoc:byte;           procedure WriteCorDoc (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadVtdSpc:byte;           procedure WriteVtdSpc (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadRowTyp:Str2;           procedure WriteRowTyp (pValue:Str2);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
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
    function LocateDnVg (pDocNum:Str12;pVatGrp:byte):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateVatDate (pVatDate:TDatetime):boolean;
    function LocateVatPart (pVatPart:Str1):boolean;
    function LocateVtdSpc (pVtdSpc:byte):boolean;
    function LocateRtDn (pRowTyp:Str2;pDocNum:Str12):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDnVg (pDocNum:Str12;pVatGrp:byte):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestVatDate (pVatDate:TDatetime):boolean;
    function NearestVatPart (pVatPart:Str1):boolean;
    function NearestVtdSpc (pVtdSpc:byte):boolean;
    function NearestRtDn (pRowTyp:Str2;pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pYear:Str2;pClsNum:integer);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property VatGrp:byte read ReadVatGrp write WriteVatGrp;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property PaName:Str30 read ReadPaName write WritePaName;
    property VatPart:Str1 read ReadVatPart write WriteVatPart;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property AValue:double read ReadAValue write WriteAValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property CorDoc:byte read ReadCorDoc write WriteCorDoc;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property VtdSpc:byte read ReadVtdSpc write WriteVtdSpc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property RowTyp:Str2 read ReadRowTyp write WriteRowTyp;
    property PaCode:longint read ReadPaCode write WritePaCode;
  end;

implementation

constructor TVtrBtr.Create;
begin
  oBtrTable := BtrInit ('VTR',gPath.LdgPath,Self);
end;

constructor TVtrBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VTR',pPath,Self);
end;

destructor TVtrBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVtrBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVtrBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVtrBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TVtrBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TVtrBtr.ReadVatGrp:byte;
begin
  Result := oBtrTable.FieldByName('VatGrp').AsInteger;
end;

procedure TVtrBtr.WriteVatGrp(pValue:byte);
begin
  oBtrTable.FieldByName('VatGrp').AsInteger := pValue;
end;

function TVtrBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TVtrBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TVtrBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TVtrBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TVtrBtr.ReadVatPart:Str1;
begin
  Result := oBtrTable.FieldByName('VatPart').AsString;
end;

procedure TVtrBtr.WriteVatPart(pValue:Str1);
begin
  oBtrTable.FieldByName('VatPart').AsString := pValue;
end;

function TVtrBtr.ReadVatDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('VatDate').AsDateTime;
end;

procedure TVtrBtr.WriteVatDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TVtrBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TVtrBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TVtrBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TVtrBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TVtrBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TVtrBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TVtrBtr.ReadCorDoc:byte;
begin
  Result := oBtrTable.FieldByName('CorDoc').AsInteger;
end;

procedure TVtrBtr.WriteCorDoc(pValue:byte);
begin
  oBtrTable.FieldByName('CorDoc').AsInteger := pValue;
end;

function TVtrBtr.ReadDocSpc:byte;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsInteger;
end;

procedure TVtrBtr.WriteDocSpc(pValue:byte);
begin
  oBtrTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TVtrBtr.ReadVtdSpc:byte;
begin
  Result := oBtrTable.FieldByName('VtdSpc').AsInteger;
end;

procedure TVtrBtr.WriteVtdSpc(pValue:byte);
begin
  oBtrTable.FieldByName('VtdSpc').AsInteger := pValue;
end;

function TVtrBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TVtrBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVtrBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVtrBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVtrBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVtrBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TVtrBtr.ReadRowTyp:Str2;
begin
  Result := oBtrTable.FieldByName('RowTyp').AsString;
end;

procedure TVtrBtr.WriteRowTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('RowTyp').AsString := pValue;
end;

function TVtrBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TVtrBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtrBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtrBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVtrBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtrBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVtrBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVtrBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVtrBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TVtrBtr.LocateDnVg (pDocNum:Str12;pVatGrp:byte):boolean;
begin
  SetIndex (ixDnVg);
  Result := oBtrTable.FindKey([pDocNum,pVatGrp]);
end;

function TVtrBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TVtrBtr.LocateVatDate (pVatDate:TDatetime):boolean;
begin
  SetIndex (ixVatDate);
  Result := oBtrTable.FindKey([pVatDate]);
end;

function TVtrBtr.LocateVatPart (pVatPart:Str1):boolean;
begin
  SetIndex (ixVatPart);
  Result := oBtrTable.FindKey([pVatPart]);
end;

function TVtrBtr.LocateVtdSpc (pVtdSpc:byte):boolean;
begin
  SetIndex (ixVtdSpc);
  Result := oBtrTable.FindKey([pVtdSpc]);
end;

function TVtrBtr.LocateRtDn (pRowTyp:Str2;pDocNum:Str12):boolean;
begin
  SetIndex (ixRtDn);
  Result := oBtrTable.FindKey([pRowTyp,pDocNum]);
end;

function TVtrBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TVtrBtr.NearestDnVg (pDocNum:Str12;pVatGrp:byte):boolean;
begin
  SetIndex (ixDnVg);
  Result := oBtrTable.FindNearest([pDocNum,pVatGrp]);
end;

function TVtrBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TVtrBtr.NearestVatDate (pVatDate:TDatetime):boolean;
begin
  SetIndex (ixVatDate);
  Result := oBtrTable.FindNearest([pVatDate]);
end;

function TVtrBtr.NearestVatPart (pVatPart:Str1):boolean;
begin
  SetIndex (ixVatPart);
  Result := oBtrTable.FindNearest([pVatPart]);
end;

function TVtrBtr.NearestVtdSpc (pVtdSpc:byte):boolean;
begin
  SetIndex (ixVtdSpc);
  Result := oBtrTable.FindNearest([pVtdSpc]);
end;

function TVtrBtr.NearestRtDn (pRowTyp:Str2;pDocNum:Str12):boolean;
begin
  SetIndex (ixRtDn);
  Result := oBtrTable.FindNearest([pRowTyp,pDocNum]);
end;

procedure TVtrBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVtrBtr.Open;
var mYear:Str2;mBookNum:Str5;
begin
  If pYear='' then mYear:='00' else mYear:=pYear;
  mBookNum:=mYear+StrIntZero(pClsNum,3);
  oBtrTable.Open(mBookNum);
end;

procedure TVtrBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVtrBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVtrBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVtrBtr.First;
begin
  oBtrTable.First;
end;

procedure TVtrBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVtrBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVtrBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVtrBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVtrBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVtrBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVtrBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVtrBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVtrBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVtrBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVtrBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
