unit tSPD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaSn = '';
  ixPaName_ = 'PaName_';
  ixDocDate = 'DocDate';

type
  TSpdTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadIncNum:word;           procedure WriteIncNum (pValue:word);
    function  ReadExpNum:word;           procedure WriteExpNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str20;         procedure WritePaName_ (pValue:Str20);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfVal1:double;        procedure WritePrfVal1 (pValue:double);
    function  ReadPrfVal2:double;        procedure WritePrfVal2 (pValue:double);
    function  ReadPrfVal3:double;        procedure WritePrfVal3 (pValue:double);
    function  ReadPrfVal4:double;        procedure WritePrfVal4 (pValue:double);
    function  ReadPrfVal5:double;        procedure WritePrfVal5 (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadDocVal1:double;        procedure WriteDocVal1 (pValue:double);
    function  ReadDocVal2:double;        procedure WriteDocVal2 (pValue:double);
    function  ReadDocVal3:double;        procedure WriteDocVal3 (pValue:double);
    function  ReadDocVal4:double;        procedure WriteDocVal4 (pValue:double);
    function  ReadDocVal5:double;        procedure WriteDocVal5 (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadExpVal:double;         procedure WriteExpVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadVatDoc:Str12;          procedure WriteVatDoc (pValue:Str12);
    function  ReadPayMode:Str1;          procedure WritePayMode (pValue:Str1);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadPayDoc:Str12;          procedure WritePayDoc (pValue:Str12);
    function  ReadPamCode:longint;       procedure WritePamCode (pValue:longint);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaSn (pPaCode:longint;pSerNum:word):boolean;
    function LocatePaName_ (pPaName_:Str20):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property IncNum:word read ReadIncNum write WriteIncNum;
    property ExpNum:word read ReadExpNum write WriteExpNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str20 read ReadPaName_ write WritePaName_;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfVal1:double read ReadPrfVal1 write WritePrfVal1;
    property PrfVal2:double read ReadPrfVal2 write WritePrfVal2;
    property PrfVal3:double read ReadPrfVal3 write WritePrfVal3;
    property PrfVal4:double read ReadPrfVal4 write WritePrfVal4;
    property PrfVal5:double read ReadPrfVal5 write WritePrfVal5;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property DocVal1:double read ReadDocVal1 write WriteDocVal1;
    property DocVal2:double read ReadDocVal2 write WriteDocVal2;
    property DocVal3:double read ReadDocVal3 write WriteDocVal3;
    property DocVal4:double read ReadDocVal4 write WriteDocVal4;
    property DocVal5:double read ReadDocVal5 write WriteDocVal5;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property ExpVal:double read ReadExpVal write WriteExpVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property VatDoc:Str12 read ReadVatDoc write WriteVatDoc;
    property PayMode:Str1 read ReadPayMode write WritePayMode;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property PayDoc:Str12 read ReadPayDoc write WritePayDoc;
    property PamCode:longint read ReadPamCode write WritePamCode;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSpdTmp.Create;
begin
  oTmpTable := TmpInit ('SPD',Self);
end;

destructor TSpdTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSpdTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSpdTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSpdTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSpdTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSpdTmp.ReadSerNum:word;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TSpdTmp.WriteSerNum(pValue:word);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSpdTmp.ReadIncNum:word;
begin
  Result := oTmpTable.FieldByName('IncNum').AsInteger;
end;

procedure TSpdTmp.WriteIncNum(pValue:word);
begin
  oTmpTable.FieldByName('IncNum').AsInteger := pValue;
end;

function TSpdTmp.ReadExpNum:word;
begin
  Result := oTmpTable.FieldByName('ExpNum').AsInteger;
end;

procedure TSpdTmp.WriteExpNum(pValue:word);
begin
  oTmpTable.FieldByName('ExpNum').AsInteger := pValue;
end;

function TSpdTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSpdTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSpdTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSpdTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSpdTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSpdTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSpdTmp.ReadPaName_:Str20;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TSpdTmp.WritePaName_(pValue:Str20);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TSpdTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TSpdTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TSpdTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSpdTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSpdTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSpdTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSpdTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSpdTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSpdTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TSpdTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TSpdTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TSpdTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TSpdTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSpdTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSpdTmp.ReadPrfVal1:double;
begin
  Result := oTmpTable.FieldByName('PrfVal1').AsFloat;
end;

procedure TSpdTmp.WritePrfVal1(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal1').AsFloat := pValue;
end;

function TSpdTmp.ReadPrfVal2:double;
begin
  Result := oTmpTable.FieldByName('PrfVal2').AsFloat;
end;

procedure TSpdTmp.WritePrfVal2(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal2').AsFloat := pValue;
end;

function TSpdTmp.ReadPrfVal3:double;
begin
  Result := oTmpTable.FieldByName('PrfVal3').AsFloat;
end;

procedure TSpdTmp.WritePrfVal3(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal3').AsFloat := pValue;
end;

function TSpdTmp.ReadPrfVal4:double;
begin
  Result := oTmpTable.FieldByName('PrfVal4').AsFloat;
end;

procedure TSpdTmp.WritePrfVal4(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal4').AsFloat := pValue;
end;

function TSpdTmp.ReadPrfVal5:double;
begin
  Result := oTmpTable.FieldByName('PrfVal5').AsFloat;
end;

procedure TSpdTmp.WritePrfVal5(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal5').AsFloat := pValue;
end;

function TSpdTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TSpdTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TSpdTmp.ReadDocVal1:double;
begin
  Result := oTmpTable.FieldByName('DocVal1').AsFloat;
end;

procedure TSpdTmp.WriteDocVal1(pValue:double);
begin
  oTmpTable.FieldByName('DocVal1').AsFloat := pValue;
end;

function TSpdTmp.ReadDocVal2:double;
begin
  Result := oTmpTable.FieldByName('DocVal2').AsFloat;
end;

procedure TSpdTmp.WriteDocVal2(pValue:double);
begin
  oTmpTable.FieldByName('DocVal2').AsFloat := pValue;
end;

function TSpdTmp.ReadDocVal3:double;
begin
  Result := oTmpTable.FieldByName('DocVal3').AsFloat;
end;

procedure TSpdTmp.WriteDocVal3(pValue:double);
begin
  oTmpTable.FieldByName('DocVal3').AsFloat := pValue;
end;

function TSpdTmp.ReadDocVal4:double;
begin
  Result := oTmpTable.FieldByName('DocVal4').AsFloat;
end;

procedure TSpdTmp.WriteDocVal4(pValue:double);
begin
  oTmpTable.FieldByName('DocVal4').AsFloat := pValue;
end;

function TSpdTmp.ReadDocVal5:double;
begin
  Result := oTmpTable.FieldByName('DocVal5').AsFloat;
end;

procedure TSpdTmp.WriteDocVal5(pValue:double);
begin
  oTmpTable.FieldByName('DocVal5').AsFloat := pValue;
end;

function TSpdTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TSpdTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSpdTmp.ReadExpVal:double;
begin
  Result := oTmpTable.FieldByName('ExpVal').AsFloat;
end;

procedure TSpdTmp.WriteExpVal(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal').AsFloat := pValue;
end;

function TSpdTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TSpdTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TSpdTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TSpdTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TSpdTmp.ReadVatDoc:Str12;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsString;
end;

procedure TSpdTmp.WriteVatDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('VatDoc').AsString := pValue;
end;

function TSpdTmp.ReadPayMode:Str1;
begin
  Result := oTmpTable.FieldByName('PayMode').AsString;
end;

procedure TSpdTmp.WritePayMode(pValue:Str1);
begin
  oTmpTable.FieldByName('PayMode').AsString := pValue;
end;

function TSpdTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TSpdTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TSpdTmp.ReadPayDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TSpdTmp.WritePayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TSpdTmp.ReadPayDoc:Str12;
begin
  Result := oTmpTable.FieldByName('PayDoc').AsString;
end;

procedure TSpdTmp.WritePayDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('PayDoc').AsString := pValue;
end;

function TSpdTmp.ReadPamCode:longint;
begin
  Result := oTmpTable.FieldByName('PamCode').AsInteger;
end;

procedure TSpdTmp.WritePamCode(pValue:longint);
begin
  oTmpTable.FieldByName('PamCode').AsInteger := pValue;
end;

function TSpdTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSpdTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSpdTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSpdTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSpdTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSpdTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSpdTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSpdTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpdTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSpdTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSpdTmp.LocatePaSn (pPaCode:longint;pSerNum:word):boolean;
begin
  SetIndex (ixPaSn);
  Result := oTmpTable.FindKey([pPaCode,pSerNum]);
end;

function TSpdTmp.LocatePaName_ (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TSpdTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

procedure TSpdTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSpdTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSpdTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSpdTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSpdTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSpdTmp.First;
begin
  oTmpTable.First;
end;

procedure TSpdTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSpdTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSpdTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSpdTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSpdTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSpdTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSpdTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSpdTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSpdTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSpdTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSpdTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2209001}
