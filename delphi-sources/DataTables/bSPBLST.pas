unit bSPBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';

type
  TSpblstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:word;           procedure WritePaCode (pValue:word);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadVatPrc6:byte;          procedure WriteVatPrc6 (pValue:byte);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadExpVal:double;         procedure WriteExpVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadIncVal1:double;        procedure WriteIncVal1 (pValue:double);
    function  ReadIncVal2:double;        procedure WriteIncVal2 (pValue:double);
    function  ReadIncVal3:double;        procedure WriteIncVal3 (pValue:double);
    function  ReadIncVal4:double;        procedure WriteIncVal4 (pValue:double);
    function  ReadIncVal5:double;        procedure WriteIncVal5 (pValue:double);
    function  ReadIncVal6:double;        procedure WriteIncVal6 (pValue:double);
    function  ReadExpVal1:double;        procedure WriteExpVal1 (pValue:double);
    function  ReadExpVal2:double;        procedure WriteExpVal2 (pValue:double);
    function  ReadExpVal3:double;        procedure WriteExpVal3 (pValue:double);
    function  ReadExpVal4:double;        procedure WriteExpVal4 (pValue:double);
    function  ReadExpVal5:double;        procedure WriteExpVal5 (pValue:double);
    function  ReadExpVal6:double;        procedure WriteExpVal6 (pValue:double);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfVal1:double;        procedure WritePrfVal1 (pValue:double);
    function  ReadPrfVal2:double;        procedure WritePrfVal2 (pValue:double);
    function  ReadPrfVal3:double;        procedure WritePrfVal3 (pValue:double);
    function  ReadPrfVal4:double;        procedure WritePrfVal4 (pValue:double);
    function  ReadPrfVal5:double;        procedure WritePrfVal5 (pValue:double);
    function  ReadPrfVal6:double;        procedure WritePrfVal6 (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCode (pPaCode:word):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function NearestPaCode (pPaCode:word):boolean;
    function NearestPaName (pPaName_:Str30):boolean;

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
    property PaCode:word read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property VatPrc6:byte read ReadVatPrc6 write WriteVatPrc6;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property ExpVal:double read ReadExpVal write WriteExpVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property IncVal1:double read ReadIncVal1 write WriteIncVal1;
    property IncVal2:double read ReadIncVal2 write WriteIncVal2;
    property IncVal3:double read ReadIncVal3 write WriteIncVal3;
    property IncVal4:double read ReadIncVal4 write WriteIncVal4;
    property IncVal5:double read ReadIncVal5 write WriteIncVal5;
    property IncVal6:double read ReadIncVal6 write WriteIncVal6;
    property ExpVal1:double read ReadExpVal1 write WriteExpVal1;
    property ExpVal2:double read ReadExpVal2 write WriteExpVal2;
    property ExpVal3:double read ReadExpVal3 write WriteExpVal3;
    property ExpVal4:double read ReadExpVal4 write WriteExpVal4;
    property ExpVal5:double read ReadExpVal5 write WriteExpVal5;
    property ExpVal6:double read ReadExpVal6 write WriteExpVal6;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Sended:boolean read ReadSended write WriteSended;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfVal1:double read ReadPrfVal1 write WritePrfVal1;
    property PrfVal2:double read ReadPrfVal2 write WritePrfVal2;
    property PrfVal3:double read ReadPrfVal3 write WritePrfVal3;
    property PrfVal4:double read ReadPrfVal4 write WritePrfVal4;
    property PrfVal5:double read ReadPrfVal5 write WritePrfVal5;
    property PrfVal6:double read ReadPrfVal6 write WritePrfVal6;
  end;

implementation

constructor TSpblstBtr.Create;
begin
  oBtrTable := BtrInit ('SPBLST',gPath.LdgPath,Self);
end;

constructor TSpblstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SPBLST',pPath,Self);
end;

destructor TSpblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSpblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSpblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSpblstBtr.ReadPaCode:word;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSpblstBtr.WritePaCode(pValue:word);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSpblstBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TSpblstBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TSpblstBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TSpblstBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TSpblstBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSpblstBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSpblstBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSpblstBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSpblstBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSpblstBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSpblstBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TSpblstBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TSpblstBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TSpblstBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TSpblstBtr.ReadVatPrc6:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc6').AsInteger;
end;

procedure TSpblstBtr.WriteVatPrc6(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc6').AsInteger := pValue;
end;

function TSpblstBtr.ReadIncVal:double;
begin
  Result := oBtrTable.FieldByName('IncVal').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal(pValue:double);
begin
  oBtrTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal:double;
begin
  Result := oBtrTable.FieldByName('ExpVal').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal').AsFloat := pValue;
end;

function TSpblstBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TSpblstBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TSpblstBtr.ReadIncVal1:double;
begin
  Result := oBtrTable.FieldByName('IncVal1').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal1(pValue:double);
begin
  oBtrTable.FieldByName('IncVal1').AsFloat := pValue;
end;

function TSpblstBtr.ReadIncVal2:double;
begin
  Result := oBtrTable.FieldByName('IncVal2').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal2(pValue:double);
begin
  oBtrTable.FieldByName('IncVal2').AsFloat := pValue;
end;

function TSpblstBtr.ReadIncVal3:double;
begin
  Result := oBtrTable.FieldByName('IncVal3').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal3(pValue:double);
begin
  oBtrTable.FieldByName('IncVal3').AsFloat := pValue;
end;

function TSpblstBtr.ReadIncVal4:double;
begin
  Result := oBtrTable.FieldByName('IncVal4').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal4(pValue:double);
begin
  oBtrTable.FieldByName('IncVal4').AsFloat := pValue;
end;

function TSpblstBtr.ReadIncVal5:double;
begin
  Result := oBtrTable.FieldByName('IncVal5').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal5(pValue:double);
begin
  oBtrTable.FieldByName('IncVal5').AsFloat := pValue;
end;

function TSpblstBtr.ReadIncVal6:double;
begin
  Result := oBtrTable.FieldByName('IncVal6').AsFloat;
end;

procedure TSpblstBtr.WriteIncVal6(pValue:double);
begin
  oBtrTable.FieldByName('IncVal6').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal1:double;
begin
  Result := oBtrTable.FieldByName('ExpVal1').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal1(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal1').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal2:double;
begin
  Result := oBtrTable.FieldByName('ExpVal2').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal2(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal2').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal3:double;
begin
  Result := oBtrTable.FieldByName('ExpVal3').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal3(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal3').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal4:double;
begin
  Result := oBtrTable.FieldByName('ExpVal4').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal4(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal4').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal5:double;
begin
  Result := oBtrTable.FieldByName('ExpVal5').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal5(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal5').AsFloat := pValue;
end;

function TSpblstBtr.ReadExpVal6:double;
begin
  Result := oBtrTable.FieldByName('ExpVal6').AsFloat;
end;

procedure TSpblstBtr.WriteExpVal6(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal6').AsFloat := pValue;
end;

function TSpblstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSpblstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSpblstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSpblstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSpblstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSpblstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSpblstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSpblstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSpblstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TSpblstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSpblstBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSpblstBtr.ReadPrfVal1:double;
begin
  Result := oBtrTable.FieldByName('PrfVal1').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal1(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal1').AsFloat := pValue;
end;

function TSpblstBtr.ReadPrfVal2:double;
begin
  Result := oBtrTable.FieldByName('PrfVal2').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal2(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal2').AsFloat := pValue;
end;

function TSpblstBtr.ReadPrfVal3:double;
begin
  Result := oBtrTable.FieldByName('PrfVal3').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal3(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal3').AsFloat := pValue;
end;

function TSpblstBtr.ReadPrfVal4:double;
begin
  Result := oBtrTable.FieldByName('PrfVal4').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal4(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal4').AsFloat := pValue;
end;

function TSpblstBtr.ReadPrfVal5:double;
begin
  Result := oBtrTable.FieldByName('PrfVal5').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal5(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal5').AsFloat := pValue;
end;

function TSpblstBtr.ReadPrfVal6:double;
begin
  Result := oBtrTable.FieldByName('PrfVal6').AsFloat;
end;

procedure TSpblstBtr.WritePrfVal6(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal6').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpblstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSpblstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSpblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSpblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSpblstBtr.LocatePaCode (pPaCode:word):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TSpblstBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TSpblstBtr.NearestPaCode (pPaCode:word):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TSpblstBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

procedure TSpblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSpblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSpblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSpblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSpblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSpblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSpblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSpblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSpblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSpblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSpblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSpblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSpblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSpblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSpblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSpblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSpblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
