unit tKSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixDocDate = 'DocDate';
  ixStkNum = 'StkNum';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';

type
  TKshTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadPaName_:Str60;         procedure WritePaName_ (pValue:Str60);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadTsdNum:Str12;          procedure WriteTsdNum (pValue:Str12);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str60):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
    property PaName_:Str60 read ReadPaName_ write WritePaName_;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property TsdNum:Str12 read ReadTsdNum write WriteTsdNum;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TKshTmp.Create;
begin
  oTmpTable := TmpInit ('KSH',Self);
end;

destructor TKshTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TKshTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TKshTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TKshTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TKshTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TKshTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TKshTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TKshTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TKshTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TKshTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TKshTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TKshTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TKshTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TKshTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TKshTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TKshTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TKshTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TKshTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TKshTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TKshTmp.ReadPaName_:Str60;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TKshTmp.WritePaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TKshTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TKshTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TKshTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TKshTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TKshTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TKshTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TKshTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TKshTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TKshTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TKshTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TKshTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TKshTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TKshTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TKshTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TKshTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TKshTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TKshTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TKshTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TKshTmp.ReadTsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TKshTmp.WriteTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TKshTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TKshTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TKshTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TKshTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TKshTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TKshTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TKshTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TKshTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TKshTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TKshTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TKshTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TKshTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TKshTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TKshTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TKshTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TKshTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TKshTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TKshTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TKshTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TKshTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TKshTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TKshTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TKshTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TKshTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TKshTmp.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oTmpTable.FindKey([pStkNum]);
end;

function TKshTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TKshTmp.LocatePaName (pPaName_:Str60):boolean;
begin
  SetIndex (ixPaName);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TKshTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TKshTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TKshTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TKshTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TKshTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TKshTmp.First;
begin
  oTmpTable.First;
end;

procedure TKshTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TKshTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TKshTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TKshTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TKshTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TKshTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TKshTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TKshTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TKshTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TKshTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TKshTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
