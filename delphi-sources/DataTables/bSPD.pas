unit bSPD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixIncNum = 'IncNum';
  ixExpNum = 'ExpNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixDescribe = 'Describe';
  ixPayMode = 'PayMode';
  ixConDoc = 'ConDoc';
  ixVatDoc = 'VatDoc';
  ixPayDoc = 'PayDoc';

type
  TSpdBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadIncNum:word;           procedure WriteIncNum (pValue:word);
    function  ReadExpNum:word;           procedure WriteExpNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str20;       procedure WriteDescribe_ (pValue:Str20);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadDocVal1:double;        procedure WriteDocVal1 (pValue:double);
    function  ReadDocVal2:double;        procedure WriteDocVal2 (pValue:double);
    function  ReadDocVal3:double;        procedure WriteDocVal3 (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadExpVal:double;         procedure WriteExpVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadVatDoc:Str12;          procedure WriteVatDoc (pValue:Str12);
    function  ReadPayMode:Str1;          procedure WritePayMode (pValue:Str1);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadPayDoc:Str12;          procedure WritePayDoc (pValue:Str12);
    function  ReadPamCode:longint;       procedure WritePamCode (pValue:longint);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfVal1:double;        procedure WritePrfVal1 (pValue:double);
    function  ReadPrfVal2:double;        procedure WritePrfVal2 (pValue:double);
    function  ReadPrfVal3:double;        procedure WritePrfVal3 (pValue:double);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadDocVal4:double;        procedure WriteDocVal4 (pValue:double);
    function  ReadDocVal5:double;        procedure WriteDocVal5 (pValue:double);
    function  ReadPrfVal4:double;        procedure WritePrfVal4 (pValue:double);
    function  ReadPrfVal5:double;        procedure WritePrfVal5 (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateIncNum (pIncNum:word):boolean;
    function LocateExpNum (pExpNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDescribe (pDescribe_:Str20):boolean;
    function LocatePayMode (pPayMode:Str1):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocateVatDoc (pVatDoc:Str12):boolean;
    function LocatePayDoc (pPayDoc:Str12):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestIncNum (pIncNum:word):boolean;
    function NearestExpNum (pExpNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDescribe (pDescribe_:Str20):boolean;
    function NearestPayMode (pPayMode:Str1):boolean;
    function NearestConDoc (pConDoc:Str12):boolean;
    function NearestVatDoc (pVatDoc:Str12):boolean;
    function NearestPayDoc (pPayDoc:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pLstNum:longint);
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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property IncNum:word read ReadIncNum write WriteIncNum;
    property ExpNum:word read ReadExpNum write WriteExpNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str20 read ReadDescribe_ write WriteDescribe_;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property DocVal1:double read ReadDocVal1 write WriteDocVal1;
    property DocVal2:double read ReadDocVal2 write WriteDocVal2;
    property DocVal3:double read ReadDocVal3 write WriteDocVal3;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property ExpVal:double read ReadExpVal write WriteExpVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property VatDoc:Str12 read ReadVatDoc write WriteVatDoc;
    property PayMode:Str1 read ReadPayMode write WritePayMode;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Sended:boolean read ReadSended write WriteSended;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property PayDoc:Str12 read ReadPayDoc write WritePayDoc;
    property PamCode:longint read ReadPamCode write WritePamCode;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfVal1:double read ReadPrfVal1 write WritePrfVal1;
    property PrfVal2:double read ReadPrfVal2 write WritePrfVal2;
    property PrfVal3:double read ReadPrfVal3 write WritePrfVal3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property DocVal4:double read ReadDocVal4 write WriteDocVal4;
    property DocVal5:double read ReadDocVal5 write WriteDocVal5;
    property PrfVal4:double read ReadPrfVal4 write WritePrfVal4;
    property PrfVal5:double read ReadPrfVal5 write WritePrfVal5;
  end;

implementation

constructor TSpdBtr.Create;
begin
  oBtrTable := BtrInit ('SPD',gPath.LdgPath,Self);
end;

constructor TSpdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SPD',pPath,Self);
end;

destructor TSpdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSpdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSpdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSpdBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSpdBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSpdBtr.ReadIncNum:word;
begin
  Result := oBtrTable.FieldByName('IncNum').AsInteger;
end;

procedure TSpdBtr.WriteIncNum(pValue:word);
begin
  oBtrTable.FieldByName('IncNum').AsInteger := pValue;
end;

function TSpdBtr.ReadExpNum:word;
begin
  Result := oBtrTable.FieldByName('ExpNum').AsInteger;
end;

procedure TSpdBtr.WriteExpNum(pValue:word);
begin
  oBtrTable.FieldByName('ExpNum').AsInteger := pValue;
end;

function TSpdBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSpdBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSpdBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSpdBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSpdBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TSpdBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TSpdBtr.ReadDescribe_:Str20;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TSpdBtr.WriteDescribe_(pValue:Str20);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TSpdBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSpdBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSpdBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSpdBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSpdBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSpdBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSpdBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TSpdBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TSpdBtr.ReadDocVal1:double;
begin
  Result := oBtrTable.FieldByName('DocVal1').AsFloat;
end;

procedure TSpdBtr.WriteDocVal1(pValue:double);
begin
  oBtrTable.FieldByName('DocVal1').AsFloat := pValue;
end;

function TSpdBtr.ReadDocVal2:double;
begin
  Result := oBtrTable.FieldByName('DocVal2').AsFloat;
end;

procedure TSpdBtr.WriteDocVal2(pValue:double);
begin
  oBtrTable.FieldByName('DocVal2').AsFloat := pValue;
end;

function TSpdBtr.ReadDocVal3:double;
begin
  Result := oBtrTable.FieldByName('DocVal3').AsFloat;
end;

procedure TSpdBtr.WriteDocVal3(pValue:double);
begin
  oBtrTable.FieldByName('DocVal3').AsFloat := pValue;
end;

function TSpdBtr.ReadIncVal:double;
begin
  Result := oBtrTable.FieldByName('IncVal').AsFloat;
end;

procedure TSpdBtr.WriteIncVal(pValue:double);
begin
  oBtrTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSpdBtr.ReadExpVal:double;
begin
  Result := oBtrTable.FieldByName('ExpVal').AsFloat;
end;

procedure TSpdBtr.WriteExpVal(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal').AsFloat := pValue;
end;

function TSpdBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TSpdBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TSpdBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TSpdBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TSpdBtr.ReadVatDoc:Str12;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsString;
end;

procedure TSpdBtr.WriteVatDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('VatDoc').AsString := pValue;
end;

function TSpdBtr.ReadPayMode:Str1;
begin
  Result := oBtrTable.FieldByName('PayMode').AsString;
end;

procedure TSpdBtr.WritePayMode(pValue:Str1);
begin
  oBtrTable.FieldByName('PayMode').AsString := pValue;
end;

function TSpdBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TSpdBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TSpdBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSpdBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSpdBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSpdBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSpdBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSpdBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSpdBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSpdBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSpdBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TSpdBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSpdBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TSpdBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TSpdBtr.ReadPayDoc:Str12;
begin
  Result := oBtrTable.FieldByName('PayDoc').AsString;
end;

procedure TSpdBtr.WritePayDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('PayDoc').AsString := pValue;
end;

function TSpdBtr.ReadPamCode:longint;
begin
  Result := oBtrTable.FieldByName('PamCode').AsInteger;
end;

procedure TSpdBtr.WritePamCode(pValue:longint);
begin
  oBtrTable.FieldByName('PamCode').AsInteger := pValue;
end;

function TSpdBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSpdBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSpdBtr.ReadPrfVal1:double;
begin
  Result := oBtrTable.FieldByName('PrfVal1').AsFloat;
end;

procedure TSpdBtr.WritePrfVal1(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal1').AsFloat := pValue;
end;

function TSpdBtr.ReadPrfVal2:double;
begin
  Result := oBtrTable.FieldByName('PrfVal2').AsFloat;
end;

procedure TSpdBtr.WritePrfVal2(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal2').AsFloat := pValue;
end;

function TSpdBtr.ReadPrfVal3:double;
begin
  Result := oBtrTable.FieldByName('PrfVal3').AsFloat;
end;

procedure TSpdBtr.WritePrfVal3(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal3').AsFloat := pValue;
end;

function TSpdBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TSpdBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TSpdBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TSpdBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TSpdBtr.ReadDocVal4:double;
begin
  Result := oBtrTable.FieldByName('DocVal4').AsFloat;
end;

procedure TSpdBtr.WriteDocVal4(pValue:double);
begin
  oBtrTable.FieldByName('DocVal4').AsFloat := pValue;
end;

function TSpdBtr.ReadDocVal5:double;
begin
  Result := oBtrTable.FieldByName('DocVal5').AsFloat;
end;

procedure TSpdBtr.WriteDocVal5(pValue:double);
begin
  oBtrTable.FieldByName('DocVal5').AsFloat := pValue;
end;

function TSpdBtr.ReadPrfVal4:double;
begin
  Result := oBtrTable.FieldByName('PrfVal4').AsFloat;
end;

procedure TSpdBtr.WritePrfVal4(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal4').AsFloat := pValue;
end;

function TSpdBtr.ReadPrfVal5:double;
begin
  Result := oBtrTable.FieldByName('PrfVal5').AsFloat;
end;

procedure TSpdBtr.WritePrfVal5(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSpdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSpdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSpdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSpdBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TSpdBtr.LocateIncNum (pIncNum:word):boolean;
begin
  SetIndex (ixIncNum);
  Result := oBtrTable.FindKey([pIncNum]);
end;

function TSpdBtr.LocateExpNum (pExpNum:word):boolean;
begin
  SetIndex (ixExpNum);
  Result := oBtrTable.FindKey([pExpNum]);
end;

function TSpdBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSpdBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSpdBtr.LocateDescribe (pDescribe_:Str20):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TSpdBtr.LocatePayMode (pPayMode:Str1):boolean;
begin
  SetIndex (ixPayMode);
  Result := oBtrTable.FindKey([pPayMode]);
end;

function TSpdBtr.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindKey([pConDoc]);
end;

function TSpdBtr.LocateVatDoc (pVatDoc:Str12):boolean;
begin
  SetIndex (ixVatDoc);
  Result := oBtrTable.FindKey([pVatDoc]);
end;

function TSpdBtr.LocatePayDoc (pPayDoc:Str12):boolean;
begin
  SetIndex (ixPayDoc);
  Result := oBtrTable.FindKey([pPayDoc]);
end;

function TSpdBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TSpdBtr.NearestIncNum (pIncNum:word):boolean;
begin
  SetIndex (ixIncNum);
  Result := oBtrTable.FindNearest([pIncNum]);
end;

function TSpdBtr.NearestExpNum (pExpNum:word):boolean;
begin
  SetIndex (ixExpNum);
  Result := oBtrTable.FindNearest([pExpNum]);
end;

function TSpdBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSpdBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSpdBtr.NearestDescribe (pDescribe_:Str20):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

function TSpdBtr.NearestPayMode (pPayMode:Str1):boolean;
begin
  SetIndex (ixPayMode);
  Result := oBtrTable.FindNearest([pPayMode]);
end;

function TSpdBtr.NearestConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindNearest([pConDoc]);
end;

function TSpdBtr.NearestVatDoc (pVatDoc:Str12):boolean;
begin
  SetIndex (ixVatDoc);
  Result := oBtrTable.FindNearest([pVatDoc]);
end;

function TSpdBtr.NearestPayDoc (pPayDoc:Str12):boolean;
begin
  SetIndex (ixPayDoc);
  Result := oBtrTable.FindNearest([pPayDoc]);
end;

procedure TSpdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSpdBtr.Open(pLstNum:longint);
begin
  oBtrTable.Open(pLstNum);
end;

procedure TSpdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSpdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSpdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSpdBtr.First;
begin
  oBtrTable.First;
end;

procedure TSpdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSpdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSpdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSpdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSpdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSpdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSpdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSpdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSpdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSpdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSpdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2209001}
