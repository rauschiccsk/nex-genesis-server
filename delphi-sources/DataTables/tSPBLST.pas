unit tSPBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';

type
  TSpblstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:word;           procedure WritePaCode (pValue:word);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadExpVal:double;         procedure WriteExpVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadSubVal:double;         procedure WriteSubVal (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadOwnPac:word;           procedure WriteOwnPac (pValue:word);
    function  ReadOwnPan:Str30;          procedure WriteOwnPan (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadVatPrc6:byte;          procedure WriteVatPrc6 (pValue:byte);
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
    function  ReadEndVal1:double;        procedure WriteEndVal1 (pValue:double);
    function  ReadEndVal2:double;        procedure WriteEndVal2 (pValue:double);
    function  ReadEndVal3:double;        procedure WriteEndVal3 (pValue:double);
    function  ReadEndVal4:double;        procedure WriteEndVal4 (pValue:double);
    function  ReadEndVal5:double;        procedure WriteEndVal5 (pValue:double);
    function  ReadEndVal6:double;        procedure WriteEndVal6 (pValue:double);
    function  ReadSubVal1:double;        procedure WriteSubVal1 (pValue:double);
    function  ReadSubVal2:double;        procedure WriteSubVal2 (pValue:double);
    function  ReadSubVal3:double;        procedure WriteSubVal3 (pValue:double);
    function  ReadSubVal4:double;        procedure WriteSubVal4 (pValue:double);
    function  ReadSubVal5:double;        procedure WriteSubVal5 (pValue:double);
    function  ReadSubVal6:double;        procedure WriteSubVal6 (pValue:double);
    function  ReadPrfVal1:double;        procedure WritePrfVal1 (pValue:double);
    function  ReadPrfVal2:double;        procedure WritePrfVal2 (pValue:double);
    function  ReadPrfVal3:double;        procedure WritePrfVal3 (pValue:double);
    function  ReadPrfVal4:double;        procedure WritePrfVal4 (pValue:double);
    function  ReadPrfVal5:double;        procedure WritePrfVal5 (pValue:double);
    function  ReadPrfVal6:double;        procedure WritePrfVal6 (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPayMode:Str1;          procedure WritePayMode (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:word):boolean;

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
    property PaCode:word read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property ExpVal:double read ReadExpVal write WriteExpVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property SubVal:double read ReadSubVal write WriteSubVal;
    property ActPos:longint read ReadActPos write WriteActPos;
    property OwnPac:word read ReadOwnPac write WriteOwnPac;
    property OwnPan:Str30 read ReadOwnPan write WriteOwnPan;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property VatPrc6:byte read ReadVatPrc6 write WriteVatPrc6;
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
    property EndVal1:double read ReadEndVal1 write WriteEndVal1;
    property EndVal2:double read ReadEndVal2 write WriteEndVal2;
    property EndVal3:double read ReadEndVal3 write WriteEndVal3;
    property EndVal4:double read ReadEndVal4 write WriteEndVal4;
    property EndVal5:double read ReadEndVal5 write WriteEndVal5;
    property EndVal6:double read ReadEndVal6 write WriteEndVal6;
    property SubVal1:double read ReadSubVal1 write WriteSubVal1;
    property SubVal2:double read ReadSubVal2 write WriteSubVal2;
    property SubVal3:double read ReadSubVal3 write WriteSubVal3;
    property SubVal4:double read ReadSubVal4 write WriteSubVal4;
    property SubVal5:double read ReadSubVal5 write WriteSubVal5;
    property SubVal6:double read ReadSubVal6 write WriteSubVal6;
    property PrfVal1:double read ReadPrfVal1 write WritePrfVal1;
    property PrfVal2:double read ReadPrfVal2 write WritePrfVal2;
    property PrfVal3:double read ReadPrfVal3 write WritePrfVal3;
    property PrfVal4:double read ReadPrfVal4 write WritePrfVal4;
    property PrfVal5:double read ReadPrfVal5 write WritePrfVal5;
    property PrfVal6:double read ReadPrfVal6 write WritePrfVal6;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PayMode:Str1 read ReadPayMode write WritePayMode;
  end;

implementation

constructor TSpblstTmp.Create;
begin
  oTmpTable := TmpInit ('SPBLST',Self);
end;

destructor TSpblstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSpblstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSpblstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSpblstTmp.ReadPaCode:word;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSpblstTmp.WritePaCode(pValue:word);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSpblstTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSpblstTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSpblstTmp.ReadBegVal:double;
begin
  Result := oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TSpblstTmp.WriteBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TSpblstTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal:double;
begin
  Result := oTmpTable.FieldByName('ExpVal').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal:double;
begin
  Result := oTmpTable.FieldByName('SubVal').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal(pValue:double);
begin
  oTmpTable.FieldByName('SubVal').AsFloat := pValue;
end;

function TSpblstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSpblstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TSpblstTmp.ReadOwnPac:word;
begin
  Result := oTmpTable.FieldByName('OwnPac').AsInteger;
end;

procedure TSpblstTmp.WriteOwnPac(pValue:word);
begin
  oTmpTable.FieldByName('OwnPac').AsInteger := pValue;
end;

function TSpblstTmp.ReadOwnPan:Str30;
begin
  Result := oTmpTable.FieldByName('OwnPan').AsString;
end;

procedure TSpblstTmp.WriteOwnPan(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnPan').AsString := pValue;
end;

function TSpblstTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSpblstTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSpblstTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSpblstTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSpblstTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSpblstTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSpblstTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TSpblstTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TSpblstTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TSpblstTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TSpblstTmp.ReadVatPrc6:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc6').AsInteger;
end;

procedure TSpblstTmp.WriteVatPrc6(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc6').AsInteger := pValue;
end;

function TSpblstTmp.ReadIncVal1:double;
begin
  Result := oTmpTable.FieldByName('IncVal1').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal1(pValue:double);
begin
  oTmpTable.FieldByName('IncVal1').AsFloat := pValue;
end;

function TSpblstTmp.ReadIncVal2:double;
begin
  Result := oTmpTable.FieldByName('IncVal2').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal2(pValue:double);
begin
  oTmpTable.FieldByName('IncVal2').AsFloat := pValue;
end;

function TSpblstTmp.ReadIncVal3:double;
begin
  Result := oTmpTable.FieldByName('IncVal3').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal3(pValue:double);
begin
  oTmpTable.FieldByName('IncVal3').AsFloat := pValue;
end;

function TSpblstTmp.ReadIncVal4:double;
begin
  Result := oTmpTable.FieldByName('IncVal4').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal4(pValue:double);
begin
  oTmpTable.FieldByName('IncVal4').AsFloat := pValue;
end;

function TSpblstTmp.ReadIncVal5:double;
begin
  Result := oTmpTable.FieldByName('IncVal5').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal5(pValue:double);
begin
  oTmpTable.FieldByName('IncVal5').AsFloat := pValue;
end;

function TSpblstTmp.ReadIncVal6:double;
begin
  Result := oTmpTable.FieldByName('IncVal6').AsFloat;
end;

procedure TSpblstTmp.WriteIncVal6(pValue:double);
begin
  oTmpTable.FieldByName('IncVal6').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal1:double;
begin
  Result := oTmpTable.FieldByName('ExpVal1').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal1(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal1').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal2:double;
begin
  Result := oTmpTable.FieldByName('ExpVal2').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal2(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal2').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal3:double;
begin
  Result := oTmpTable.FieldByName('ExpVal3').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal3(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal3').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal4:double;
begin
  Result := oTmpTable.FieldByName('ExpVal4').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal4(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal4').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal5:double;
begin
  Result := oTmpTable.FieldByName('ExpVal5').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal5(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal5').AsFloat := pValue;
end;

function TSpblstTmp.ReadExpVal6:double;
begin
  Result := oTmpTable.FieldByName('ExpVal6').AsFloat;
end;

procedure TSpblstTmp.WriteExpVal6(pValue:double);
begin
  oTmpTable.FieldByName('ExpVal6').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal1:double;
begin
  Result := oTmpTable.FieldByName('EndVal1').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal1(pValue:double);
begin
  oTmpTable.FieldByName('EndVal1').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal2:double;
begin
  Result := oTmpTable.FieldByName('EndVal2').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal2(pValue:double);
begin
  oTmpTable.FieldByName('EndVal2').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal3:double;
begin
  Result := oTmpTable.FieldByName('EndVal3').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal3(pValue:double);
begin
  oTmpTable.FieldByName('EndVal3').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal4:double;
begin
  Result := oTmpTable.FieldByName('EndVal4').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal4(pValue:double);
begin
  oTmpTable.FieldByName('EndVal4').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal5:double;
begin
  Result := oTmpTable.FieldByName('EndVal5').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal5(pValue:double);
begin
  oTmpTable.FieldByName('EndVal5').AsFloat := pValue;
end;

function TSpblstTmp.ReadEndVal6:double;
begin
  Result := oTmpTable.FieldByName('EndVal6').AsFloat;
end;

procedure TSpblstTmp.WriteEndVal6(pValue:double);
begin
  oTmpTable.FieldByName('EndVal6').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal1:double;
begin
  Result := oTmpTable.FieldByName('SubVal1').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal1(pValue:double);
begin
  oTmpTable.FieldByName('SubVal1').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal2:double;
begin
  Result := oTmpTable.FieldByName('SubVal2').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal2(pValue:double);
begin
  oTmpTable.FieldByName('SubVal2').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal3:double;
begin
  Result := oTmpTable.FieldByName('SubVal3').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal3(pValue:double);
begin
  oTmpTable.FieldByName('SubVal3').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal4:double;
begin
  Result := oTmpTable.FieldByName('SubVal4').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal4(pValue:double);
begin
  oTmpTable.FieldByName('SubVal4').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal5:double;
begin
  Result := oTmpTable.FieldByName('SubVal5').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal5(pValue:double);
begin
  oTmpTable.FieldByName('SubVal5').AsFloat := pValue;
end;

function TSpblstTmp.ReadSubVal6:double;
begin
  Result := oTmpTable.FieldByName('SubVal6').AsFloat;
end;

procedure TSpblstTmp.WriteSubVal6(pValue:double);
begin
  oTmpTable.FieldByName('SubVal6').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal1:double;
begin
  Result := oTmpTable.FieldByName('PrfVal1').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal1(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal1').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal2:double;
begin
  Result := oTmpTable.FieldByName('PrfVal2').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal2(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal2').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal3:double;
begin
  Result := oTmpTable.FieldByName('PrfVal3').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal3(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal3').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal4:double;
begin
  Result := oTmpTable.FieldByName('PrfVal4').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal4(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal4').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal5:double;
begin
  Result := oTmpTable.FieldByName('PrfVal5').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal5(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal5').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal6:double;
begin
  Result := oTmpTable.FieldByName('PrfVal6').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal6(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal6').AsFloat := pValue;
end;

function TSpblstTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSpblstTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSpblstTmp.ReadPayMode:Str1;
begin
  Result := oTmpTable.FieldByName('PayMode').AsString;
end;

procedure TSpblstTmp.WritePayMode(pValue:Str1);
begin
  oTmpTable.FieldByName('PayMode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpblstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSpblstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSpblstTmp.LocatePaCode (pPaCode:word):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

procedure TSpblstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSpblstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSpblstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSpblstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSpblstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSpblstTmp.First;
begin
  oTmpTable.First;
end;

procedure TSpblstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSpblstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSpblstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSpblstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSpblstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSpblstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSpblstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSpblstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSpblstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSpblstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSpblstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
