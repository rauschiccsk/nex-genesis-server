unit bREH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixDescribe = 'Describe';
  ixDstRev = 'DstRev';
  ixSended = 'Sended';

type
  TRehBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str20;       procedure WriteDescribe_ (pValue:Str20);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadOValue:double;         procedure WriteOValue (pValue:double);
    function  ReadNValue:double;         procedure WriteNValue (pValue:double);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadOValue1:double;        procedure WriteOValue1 (pValue:double);
    function  ReadOValue2:double;        procedure WriteOValue2 (pValue:double);
    function  ReadOValue3:double;        procedure WriteOValue3 (pValue:double);
    function  ReadNValue1:double;        procedure WriteNValue1 (pValue:double);
    function  ReadNValue2:double;        procedure WriteNValue2 (pValue:double);
    function  ReadNValue3:double;        procedure WriteNValue3 (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadRevDate:TDatetime;     procedure WriteRevDate (pValue:TDatetime);
    function  ReadRevTime:TDatetime;     procedure WriteRevTime (pValue:TDatetime);
    function  ReadDstRev:byte;           procedure WriteDstRev (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDescribe (pDescribe_:Str20):boolean;
    function LocateDstRev (pDstRev:byte):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDescribe (pDescribe_:Str20):boolean;
    function NearestDstRev (pDstRev:byte):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str20 read ReadDescribe_ write WriteDescribe_;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property CValue:double read ReadCValue write WriteCValue;
    property OValue:double read ReadOValue write WriteOValue;
    property NValue:double read ReadNValue write WriteNValue;
    property DValue:double read ReadDValue write WriteDValue;
    property OValue1:double read ReadOValue1 write WriteOValue1;
    property OValue2:double read ReadOValue2 write WriteOValue2;
    property OValue3:double read ReadOValue3 write WriteOValue3;
    property NValue1:double read ReadNValue1 write WriteNValue1;
    property NValue2:double read ReadNValue2 write WriteNValue2;
    property NValue3:double read ReadNValue3 write WriteNValue3;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property RevDate:TDatetime read ReadRevDate write WriteRevDate;
    property RevTime:TDatetime read ReadRevTime write WriteRevTime;
    property DstRev:byte read ReadDstRev write WriteDstRev;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TRehBtr.Create;
begin
  oBtrTable := BtrInit ('REH',gPath.LdgPath,Self);
end;

constructor TRehBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('REH',pPath,Self);
end;

destructor TRehBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRehBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRehBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRehBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TRehBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TRehBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TRehBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TRehBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TRehBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TRehBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TRehBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TRehBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TRehBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TRehBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TRehBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TRehBtr.ReadDescribe_:Str20;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TRehBtr.WriteDescribe_(pValue:Str20);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TRehBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TRehBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TRehBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TRehBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TRehBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TRehBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TRehBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TRehBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TRehBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TRehBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TRehBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TRehBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRehBtr.ReadOValue:double;
begin
  Result := oBtrTable.FieldByName('OValue').AsFloat;
end;

procedure TRehBtr.WriteOValue(pValue:double);
begin
  oBtrTable.FieldByName('OValue').AsFloat := pValue;
end;

function TRehBtr.ReadNValue:double;
begin
  Result := oBtrTable.FieldByName('NValue').AsFloat;
end;

procedure TRehBtr.WriteNValue(pValue:double);
begin
  oBtrTable.FieldByName('NValue').AsFloat := pValue;
end;

function TRehBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TRehBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TRehBtr.ReadOValue1:double;
begin
  Result := oBtrTable.FieldByName('OValue1').AsFloat;
end;

procedure TRehBtr.WriteOValue1(pValue:double);
begin
  oBtrTable.FieldByName('OValue1').AsFloat := pValue;
end;

function TRehBtr.ReadOValue2:double;
begin
  Result := oBtrTable.FieldByName('OValue2').AsFloat;
end;

procedure TRehBtr.WriteOValue2(pValue:double);
begin
  oBtrTable.FieldByName('OValue2').AsFloat := pValue;
end;

function TRehBtr.ReadOValue3:double;
begin
  Result := oBtrTable.FieldByName('OValue3').AsFloat;
end;

procedure TRehBtr.WriteOValue3(pValue:double);
begin
  oBtrTable.FieldByName('OValue3').AsFloat := pValue;
end;

function TRehBtr.ReadNValue1:double;
begin
  Result := oBtrTable.FieldByName('NValue1').AsFloat;
end;

procedure TRehBtr.WriteNValue1(pValue:double);
begin
  oBtrTable.FieldByName('NValue1').AsFloat := pValue;
end;

function TRehBtr.ReadNValue2:double;
begin
  Result := oBtrTable.FieldByName('NValue2').AsFloat;
end;

procedure TRehBtr.WriteNValue2(pValue:double);
begin
  oBtrTable.FieldByName('NValue2').AsFloat := pValue;
end;

function TRehBtr.ReadNValue3:double;
begin
  Result := oBtrTable.FieldByName('NValue3').AsFloat;
end;

procedure TRehBtr.WriteNValue3(pValue:double);
begin
  oBtrTable.FieldByName('NValue3').AsFloat := pValue;
end;

function TRehBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TRehBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TRehBtr.ReadRevDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RevDate').AsDateTime;
end;

procedure TRehBtr.WriteRevDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RevDate').AsDateTime := pValue;
end;

function TRehBtr.ReadRevTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('RevTime').AsDateTime;
end;

procedure TRehBtr.WriteRevTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RevTime').AsDateTime := pValue;
end;

function TRehBtr.ReadDstRev:byte;
begin
  Result := oBtrTable.FieldByName('DstRev').AsInteger;
end;

procedure TRehBtr.WriteDstRev(pValue:byte);
begin
  oBtrTable.FieldByName('DstRev').AsInteger := pValue;
end;

function TRehBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TRehBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TRehBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRehBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRehBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRehBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRehBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRehBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRehBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TRehBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TRehBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRehBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRehBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRehBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRehBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRehBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRehBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TRehBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TRehBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TRehBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRehBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRehBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRehBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRehBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRehBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRehBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRehBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TRehBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TRehBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TRehBtr.LocateDescribe (pDescribe_:Str20):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TRehBtr.LocateDstRev (pDstRev:byte):boolean;
begin
  SetIndex (ixDstRev);
  Result := oBtrTable.FindKey([pDstRev]);
end;

function TRehBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TRehBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TRehBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TRehBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TRehBtr.NearestDescribe (pDescribe_:Str20):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

function TRehBtr.NearestDstRev (pDstRev:byte):boolean;
begin
  SetIndex (ixDstRev);
  Result := oBtrTable.FindNearest([pDstRev]);
end;

function TRehBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TRehBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRehBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TRehBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRehBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRehBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRehBtr.First;
begin
  oBtrTable.First;
end;

procedure TRehBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRehBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRehBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRehBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRehBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRehBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRehBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRehBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRehBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRehBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRehBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
