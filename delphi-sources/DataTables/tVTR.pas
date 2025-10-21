unit tVTR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnVg = '';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixVatDate = 'VatDate';
  ixVatPart = 'VatPart';
  ixVtdSpc = 'VtdSpc';
  ixRtDn = 'RtDn';

type
  TVtrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadVatGrp:byte;           procedure WriteVatGrp (pValue:byte);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadVatPart:Str1;          procedure WriteVatPart (pValue:Str1);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadCorDoc:byte;           procedure WriteCorDoc (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadVtdSpc:byte;           procedure WriteVtdSpc (pValue:byte);
    function  ReadRowTyp:Str2;           procedure WriteRowTyp (pValue:Str2);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDnVg (pDocNum:Str12;pVatGrp:byte):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateVatDate (pVatDate:TDatetime):boolean;
    function LocateVatPart (pVatPart:Str1):boolean;
    function LocateVtdSpc (pVtdSpc:byte):boolean;
    function LocateRtDn (pRowTyp:Str2;pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property VatGrp:byte read ReadVatGrp write WriteVatGrp;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property VatPart:Str1 read ReadVatPart write WriteVatPart;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property AValue:double read ReadAValue write WriteAValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property CorDoc:byte read ReadCorDoc write WriteCorDoc;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property VtdSpc:byte read ReadVtdSpc write WriteVtdSpc;
    property RowTyp:Str2 read ReadRowTyp write WriteRowTyp;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TVtrTmp.Create;
begin
  oTmpTable := TmpInit ('VTR',Self);
end;

destructor TVtrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TVtrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TVtrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TVtrTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TVtrTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TVtrTmp.ReadVatGrp:byte;
begin
  Result := oTmpTable.FieldByName('VatGrp').AsInteger;
end;

procedure TVtrTmp.WriteVatGrp(pValue:byte);
begin
  oTmpTable.FieldByName('VatGrp').AsInteger := pValue;
end;

function TVtrTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TVtrTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TVtrTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TVtrTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TVtrTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TVtrTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TVtrTmp.ReadVatPart:Str1;
begin
  Result := oTmpTable.FieldByName('VatPart').AsString;
end;

procedure TVtrTmp.WriteVatPart(pValue:Str1);
begin
  oTmpTable.FieldByName('VatPart').AsString := pValue;
end;

function TVtrTmp.ReadVatDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('VatDate').AsDateTime;
end;

procedure TVtrTmp.WriteVatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TVtrTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TVtrTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TVtrTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TVtrTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TVtrTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TVtrTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TVtrTmp.ReadCorDoc:byte;
begin
  Result := oTmpTable.FieldByName('CorDoc').AsInteger;
end;

procedure TVtrTmp.WriteCorDoc(pValue:byte);
begin
  oTmpTable.FieldByName('CorDoc').AsInteger := pValue;
end;

function TVtrTmp.ReadDocSpc:byte;
begin
  Result := oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TVtrTmp.WriteDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TVtrTmp.ReadVtdSpc:byte;
begin
  Result := oTmpTable.FieldByName('VtdSpc').AsInteger;
end;

procedure TVtrTmp.WriteVtdSpc(pValue:byte);
begin
  oTmpTable.FieldByName('VtdSpc').AsInteger := pValue;
end;

function TVtrTmp.ReadRowTyp:Str2;
begin
  Result := oTmpTable.FieldByName('RowTyp').AsString;
end;

procedure TVtrTmp.WriteRowTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('RowTyp').AsString := pValue;
end;

function TVtrTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TVtrTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVtrTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVtrTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVtrTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVtrTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TVtrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TVtrTmp.LocateDnVg (pDocNum:Str12;pVatGrp:byte):boolean;
begin
  SetIndex (ixDnVg);
  Result := oTmpTable.FindKey([pDocNum,pVatGrp]);
end;

function TVtrTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TVtrTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TVtrTmp.LocateVatDate (pVatDate:TDatetime):boolean;
begin
  SetIndex (ixVatDate);
  Result := oTmpTable.FindKey([pVatDate]);
end;

function TVtrTmp.LocateVatPart (pVatPart:Str1):boolean;
begin
  SetIndex (ixVatPart);
  Result := oTmpTable.FindKey([pVatPart]);
end;

function TVtrTmp.LocateVtdSpc (pVtdSpc:byte):boolean;
begin
  SetIndex (ixVtdSpc);
  Result := oTmpTable.FindKey([pVtdSpc]);
end;

function TVtrTmp.LocateRtDn (pRowTyp:Str2;pDocNum:Str12):boolean;
begin
  SetIndex (ixRtDn);
  Result := oTmpTable.FindKey([pRowTyp,pDocNum]);
end;

procedure TVtrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TVtrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TVtrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TVtrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TVtrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TVtrTmp.First;
begin
  oTmpTable.First;
end;

procedure TVtrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TVtrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TVtrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TVtrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TVtrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TVtrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TVtrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TVtrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TVtrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TVtrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TVtrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1919001}
