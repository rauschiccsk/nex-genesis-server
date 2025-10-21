unit bCAH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocDate = 'DocDate';

type
  TCahBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPayName0:Str20;        procedure WritePayName0 (pValue:Str20);
    function  ReadPayName1:Str20;        procedure WritePayName1 (pValue:Str20);
    function  ReadPayName2:Str20;        procedure WritePayName2 (pValue:Str20);
    function  ReadPayName3:Str20;        procedure WritePayName3 (pValue:Str20);
    function  ReadPayName4:Str20;        procedure WritePayName4 (pValue:Str20);
    function  ReadPayName5:Str20;        procedure WritePayName5 (pValue:Str20);
    function  ReadPayName6:Str20;        procedure WritePayName6 (pValue:Str20);
    function  ReadPayName7:Str20;        procedure WritePayName7 (pValue:Str20);
    function  ReadPayName8:Str20;        procedure WritePayName8 (pValue:Str20);
    function  ReadPayName9:Str20;        procedure WritePayName9 (pValue:Str20);
    function  ReadBegVal0:double;        procedure WriteBegVal0 (pValue:double);
    function  ReadBegVal1:double;        procedure WriteBegVal1 (pValue:double);
    function  ReadBegVal2:double;        procedure WriteBegVal2 (pValue:double);
    function  ReadBegVal3:double;        procedure WriteBegVal3 (pValue:double);
    function  ReadBegVal4:double;        procedure WriteBegVal4 (pValue:double);
    function  ReadBegVal5:double;        procedure WriteBegVal5 (pValue:double);
    function  ReadBegVal6:double;        procedure WriteBegVal6 (pValue:double);
    function  ReadBegVal7:double;        procedure WriteBegVal7 (pValue:double);
    function  ReadBegVal8:double;        procedure WriteBegVal8 (pValue:double);
    function  ReadBegVal9:double;        procedure WriteBegVal9 (pValue:double);
    function  ReadTrnVal0:double;        procedure WriteTrnVal0 (pValue:double);
    function  ReadTrnVal1:double;        procedure WriteTrnVal1 (pValue:double);
    function  ReadTrnVal2:double;        procedure WriteTrnVal2 (pValue:double);
    function  ReadTrnVal3:double;        procedure WriteTrnVal3 (pValue:double);
    function  ReadTrnVal4:double;        procedure WriteTrnVal4 (pValue:double);
    function  ReadTrnVal5:double;        procedure WriteTrnVal5 (pValue:double);
    function  ReadTrnVal6:double;        procedure WriteTrnVal6 (pValue:double);
    function  ReadTrnVal7:double;        procedure WriteTrnVal7 (pValue:double);
    function  ReadTrnVal8:double;        procedure WriteTrnVal8 (pValue:double);
    function  ReadTrnVal9:double;        procedure WriteTrnVal9 (pValue:double);
    function  ReadIncVal0:double;        procedure WriteIncVal0 (pValue:double);
    function  ReadIncVal1:double;        procedure WriteIncVal1 (pValue:double);
    function  ReadIncVal2:double;        procedure WriteIncVal2 (pValue:double);
    function  ReadIncVal3:double;        procedure WriteIncVal3 (pValue:double);
    function  ReadIncVal4:double;        procedure WriteIncVal4 (pValue:double);
    function  ReadIncVal5:double;        procedure WriteIncVal5 (pValue:double);
    function  ReadIncVal6:double;        procedure WriteIncVal6 (pValue:double);
    function  ReadIncVal7:double;        procedure WriteIncVal7 (pValue:double);
    function  ReadIncVal8:double;        procedure WriteIncVal8 (pValue:double);
    function  ReadIncVal9:double;        procedure WriteIncVal9 (pValue:double);
    function  ReadExpVal0:double;        procedure WriteExpVal0 (pValue:double);
    function  ReadExpVal1:double;        procedure WriteExpVal1 (pValue:double);
    function  ReadExpVal2:double;        procedure WriteExpVal2 (pValue:double);
    function  ReadExpVal3:double;        procedure WriteExpVal3 (pValue:double);
    function  ReadExpVal4:double;        procedure WriteExpVal4 (pValue:double);
    function  ReadExpVal5:double;        procedure WriteExpVal5 (pValue:double);
    function  ReadExpVal6:double;        procedure WriteExpVal6 (pValue:double);
    function  ReadExpVal7:double;        procedure WriteExpVal7 (pValue:double);
    function  ReadExpVal8:double;        procedure WriteExpVal8 (pValue:double);
    function  ReadExpVal9:double;        procedure WriteExpVal9 (pValue:double);
    function  ReadGT1Val:double;         procedure WriteGT1Val (pValue:double);
    function  ReadGT2Val:double;         procedure WriteGT2Val (pValue:double);
    function  ReadGT3Val:double;         procedure WriteGT3Val (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadBValue1:double;        procedure WriteBValue1 (pValue:double);
    function  ReadBValue2:double;        procedure WriteBValue2 (pValue:double);
    function  ReadBValue3:double;        procedure WriteBValue3 (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadClmVal:double;         procedure WriteClmVal (pValue:double);
    function  ReadNegVal:double;         procedure WriteNegVal (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadCncVal:double;         procedure WriteCncVal (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadExpVal:double;         procedure WriteExpVal (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadChIVal0:double;        procedure WriteChIVal0 (pValue:double);
    function  ReadChIVal1:double;        procedure WriteChIVal1 (pValue:double);
    function  ReadChIVal2:double;        procedure WriteChIVal2 (pValue:double);
    function  ReadChIVal3:double;        procedure WriteChIVal3 (pValue:double);
    function  ReadChIVal4:double;        procedure WriteChIVal4 (pValue:double);
    function  ReadChIVal5:double;        procedure WriteChIVal5 (pValue:double);
    function  ReadChIVal6:double;        procedure WriteChIVal6 (pValue:double);
    function  ReadChIVal7:double;        procedure WriteChIVal7 (pValue:double);
    function  ReadChIVal8:double;        procedure WriteChIVal8 (pValue:double);
    function  ReadChIVal9:double;        procedure WriteChIVal9 (pValue:double);
    function  ReadChEVal0:double;        procedure WriteChEVal0 (pValue:double);
    function  ReadChEVal1:double;        procedure WriteChEVal1 (pValue:double);
    function  ReadChEVal2:double;        procedure WriteChEVal2 (pValue:double);
    function  ReadChEVal3:double;        procedure WriteChEVal3 (pValue:double);
    function  ReadChEVal4:double;        procedure WriteChEVal4 (pValue:double);
    function  ReadChEVal5:double;        procedure WriteChEVal5 (pValue:double);
    function  ReadChEVal6:double;        procedure WriteChEVal6 (pValue:double);
    function  ReadChEVal7:double;        procedure WriteChEVal7 (pValue:double);
    function  ReadChEVal8:double;        procedure WriteChEVal8 (pValue:double);
    function  ReadChEVal9:double;        procedure WriteChEVal9 (pValue:double);
    function  ReadChEVal:double;         procedure WriteChEVal (pValue:double);
    function  ReadChIVal:double;         procedure WriteChIVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pCasNum:integer);
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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PayName0:Str20 read ReadPayName0 write WritePayName0;
    property PayName1:Str20 read ReadPayName1 write WritePayName1;
    property PayName2:Str20 read ReadPayName2 write WritePayName2;
    property PayName3:Str20 read ReadPayName3 write WritePayName3;
    property PayName4:Str20 read ReadPayName4 write WritePayName4;
    property PayName5:Str20 read ReadPayName5 write WritePayName5;
    property PayName6:Str20 read ReadPayName6 write WritePayName6;
    property PayName7:Str20 read ReadPayName7 write WritePayName7;
    property PayName8:Str20 read ReadPayName8 write WritePayName8;
    property PayName9:Str20 read ReadPayName9 write WritePayName9;
    property BegVal0:double read ReadBegVal0 write WriteBegVal0;
    property BegVal1:double read ReadBegVal1 write WriteBegVal1;
    property BegVal2:double read ReadBegVal2 write WriteBegVal2;
    property BegVal3:double read ReadBegVal3 write WriteBegVal3;
    property BegVal4:double read ReadBegVal4 write WriteBegVal4;
    property BegVal5:double read ReadBegVal5 write WriteBegVal5;
    property BegVal6:double read ReadBegVal6 write WriteBegVal6;
    property BegVal7:double read ReadBegVal7 write WriteBegVal7;
    property BegVal8:double read ReadBegVal8 write WriteBegVal8;
    property BegVal9:double read ReadBegVal9 write WriteBegVal9;
    property TrnVal0:double read ReadTrnVal0 write WriteTrnVal0;
    property TrnVal1:double read ReadTrnVal1 write WriteTrnVal1;
    property TrnVal2:double read ReadTrnVal2 write WriteTrnVal2;
    property TrnVal3:double read ReadTrnVal3 write WriteTrnVal3;
    property TrnVal4:double read ReadTrnVal4 write WriteTrnVal4;
    property TrnVal5:double read ReadTrnVal5 write WriteTrnVal5;
    property TrnVal6:double read ReadTrnVal6 write WriteTrnVal6;
    property TrnVal7:double read ReadTrnVal7 write WriteTrnVal7;
    property TrnVal8:double read ReadTrnVal8 write WriteTrnVal8;
    property TrnVal9:double read ReadTrnVal9 write WriteTrnVal9;
    property IncVal0:double read ReadIncVal0 write WriteIncVal0;
    property IncVal1:double read ReadIncVal1 write WriteIncVal1;
    property IncVal2:double read ReadIncVal2 write WriteIncVal2;
    property IncVal3:double read ReadIncVal3 write WriteIncVal3;
    property IncVal4:double read ReadIncVal4 write WriteIncVal4;
    property IncVal5:double read ReadIncVal5 write WriteIncVal5;
    property IncVal6:double read ReadIncVal6 write WriteIncVal6;
    property IncVal7:double read ReadIncVal7 write WriteIncVal7;
    property IncVal8:double read ReadIncVal8 write WriteIncVal8;
    property IncVal9:double read ReadIncVal9 write WriteIncVal9;
    property ExpVal0:double read ReadExpVal0 write WriteExpVal0;
    property ExpVal1:double read ReadExpVal1 write WriteExpVal1;
    property ExpVal2:double read ReadExpVal2 write WriteExpVal2;
    property ExpVal3:double read ReadExpVal3 write WriteExpVal3;
    property ExpVal4:double read ReadExpVal4 write WriteExpVal4;
    property ExpVal5:double read ReadExpVal5 write WriteExpVal5;
    property ExpVal6:double read ReadExpVal6 write WriteExpVal6;
    property ExpVal7:double read ReadExpVal7 write WriteExpVal7;
    property ExpVal8:double read ReadExpVal8 write WriteExpVal8;
    property ExpVal9:double read ReadExpVal9 write WriteExpVal9;
    property GT1Val:double read ReadGT1Val write WriteGT1Val;
    property GT2Val:double read ReadGT2Val write WriteGT2Val;
    property GT3Val:double read ReadGT3Val write WriteGT3Val;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property BValue1:double read ReadBValue1 write WriteBValue1;
    property BValue2:double read ReadBValue2 write WriteBValue2;
    property BValue3:double read ReadBValue3 write WriteBValue3;
    property AValue:double read ReadAValue write WriteAValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property BValue:double read ReadBValue write WriteBValue;
    property ClmVal:double read ReadClmVal write WriteClmVal;
    property NegVal:double read ReadNegVal write WriteNegVal;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property CncVal:double read ReadCncVal write WriteCncVal;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property ExpVal:double read ReadExpVal write WriteExpVal;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ChIVal0:double read ReadChIVal0 write WriteChIVal0;
    property ChIVal1:double read ReadChIVal1 write WriteChIVal1;
    property ChIVal2:double read ReadChIVal2 write WriteChIVal2;
    property ChIVal3:double read ReadChIVal3 write WriteChIVal3;
    property ChIVal4:double read ReadChIVal4 write WriteChIVal4;
    property ChIVal5:double read ReadChIVal5 write WriteChIVal5;
    property ChIVal6:double read ReadChIVal6 write WriteChIVal6;
    property ChIVal7:double read ReadChIVal7 write WriteChIVal7;
    property ChIVal8:double read ReadChIVal8 write WriteChIVal8;
    property ChIVal9:double read ReadChIVal9 write WriteChIVal9;
    property ChEVal0:double read ReadChEVal0 write WriteChEVal0;
    property ChEVal1:double read ReadChEVal1 write WriteChEVal1;
    property ChEVal2:double read ReadChEVal2 write WriteChEVal2;
    property ChEVal3:double read ReadChEVal3 write WriteChEVal3;
    property ChEVal4:double read ReadChEVal4 write WriteChEVal4;
    property ChEVal5:double read ReadChEVal5 write WriteChEVal5;
    property ChEVal6:double read ReadChEVal6 write WriteChEVal6;
    property ChEVal7:double read ReadChEVal7 write WriteChEVal7;
    property ChEVal8:double read ReadChEVal8 write WriteChEVal8;
    property ChEVal9:double read ReadChEVal9 write WriteChEVal9;
    property ChEVal:double read ReadChEVal write WriteChEVal;
    property ChIVal:double read ReadChIVal write WriteChIVal;
  end;

implementation

constructor TCahBtr.Create;
begin
  oBtrTable := BtrInit ('CAH',gPath.CabPath,Self);
end;

constructor TCahBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CAH',pPath,Self);
end;

destructor TCahBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCahBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCahBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCahBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCahBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCahBtr.ReadPayName0:Str20;
begin
  Result := oBtrTable.FieldByName('PayName0').AsString;
end;

procedure TCahBtr.WritePayName0(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName0').AsString := pValue;
end;

function TCahBtr.ReadPayName1:Str20;
begin
  Result := oBtrTable.FieldByName('PayName1').AsString;
end;

procedure TCahBtr.WritePayName1(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName1').AsString := pValue;
end;

function TCahBtr.ReadPayName2:Str20;
begin
  Result := oBtrTable.FieldByName('PayName2').AsString;
end;

procedure TCahBtr.WritePayName2(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName2').AsString := pValue;
end;

function TCahBtr.ReadPayName3:Str20;
begin
  Result := oBtrTable.FieldByName('PayName3').AsString;
end;

procedure TCahBtr.WritePayName3(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName3').AsString := pValue;
end;

function TCahBtr.ReadPayName4:Str20;
begin
  Result := oBtrTable.FieldByName('PayName4').AsString;
end;

procedure TCahBtr.WritePayName4(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName4').AsString := pValue;
end;

function TCahBtr.ReadPayName5:Str20;
begin
  Result := oBtrTable.FieldByName('PayName5').AsString;
end;

procedure TCahBtr.WritePayName5(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName5').AsString := pValue;
end;

function TCahBtr.ReadPayName6:Str20;
begin
  Result := oBtrTable.FieldByName('PayName6').AsString;
end;

procedure TCahBtr.WritePayName6(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName6').AsString := pValue;
end;

function TCahBtr.ReadPayName7:Str20;
begin
  Result := oBtrTable.FieldByName('PayName7').AsString;
end;

procedure TCahBtr.WritePayName7(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName7').AsString := pValue;
end;

function TCahBtr.ReadPayName8:Str20;
begin
  Result := oBtrTable.FieldByName('PayName8').AsString;
end;

procedure TCahBtr.WritePayName8(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName8').AsString := pValue;
end;

function TCahBtr.ReadPayName9:Str20;
begin
  Result := oBtrTable.FieldByName('PayName9').AsString;
end;

procedure TCahBtr.WritePayName9(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName9').AsString := pValue;
end;

function TCahBtr.ReadBegVal0:double;
begin
  Result := oBtrTable.FieldByName('BegVal0').AsFloat;
end;

procedure TCahBtr.WriteBegVal0(pValue:double);
begin
  oBtrTable.FieldByName('BegVal0').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal1:double;
begin
  Result := oBtrTable.FieldByName('BegVal1').AsFloat;
end;

procedure TCahBtr.WriteBegVal1(pValue:double);
begin
  oBtrTable.FieldByName('BegVal1').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal2:double;
begin
  Result := oBtrTable.FieldByName('BegVal2').AsFloat;
end;

procedure TCahBtr.WriteBegVal2(pValue:double);
begin
  oBtrTable.FieldByName('BegVal2').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal3:double;
begin
  Result := oBtrTable.FieldByName('BegVal3').AsFloat;
end;

procedure TCahBtr.WriteBegVal3(pValue:double);
begin
  oBtrTable.FieldByName('BegVal3').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal4:double;
begin
  Result := oBtrTable.FieldByName('BegVal4').AsFloat;
end;

procedure TCahBtr.WriteBegVal4(pValue:double);
begin
  oBtrTable.FieldByName('BegVal4').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal5:double;
begin
  Result := oBtrTable.FieldByName('BegVal5').AsFloat;
end;

procedure TCahBtr.WriteBegVal5(pValue:double);
begin
  oBtrTable.FieldByName('BegVal5').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal6:double;
begin
  Result := oBtrTable.FieldByName('BegVal6').AsFloat;
end;

procedure TCahBtr.WriteBegVal6(pValue:double);
begin
  oBtrTable.FieldByName('BegVal6').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal7:double;
begin
  Result := oBtrTable.FieldByName('BegVal7').AsFloat;
end;

procedure TCahBtr.WriteBegVal7(pValue:double);
begin
  oBtrTable.FieldByName('BegVal7').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal8:double;
begin
  Result := oBtrTable.FieldByName('BegVal8').AsFloat;
end;

procedure TCahBtr.WriteBegVal8(pValue:double);
begin
  oBtrTable.FieldByName('BegVal8').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal9:double;
begin
  Result := oBtrTable.FieldByName('BegVal9').AsFloat;
end;

procedure TCahBtr.WriteBegVal9(pValue:double);
begin
  oBtrTable.FieldByName('BegVal9').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal0:double;
begin
  Result := oBtrTable.FieldByName('TrnVal0').AsFloat;
end;

procedure TCahBtr.WriteTrnVal0(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal0').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal1:double;
begin
  Result := oBtrTable.FieldByName('TrnVal1').AsFloat;
end;

procedure TCahBtr.WriteTrnVal1(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal1').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal2:double;
begin
  Result := oBtrTable.FieldByName('TrnVal2').AsFloat;
end;

procedure TCahBtr.WriteTrnVal2(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal2').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal3:double;
begin
  Result := oBtrTable.FieldByName('TrnVal3').AsFloat;
end;

procedure TCahBtr.WriteTrnVal3(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal3').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal4:double;
begin
  Result := oBtrTable.FieldByName('TrnVal4').AsFloat;
end;

procedure TCahBtr.WriteTrnVal4(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal4').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal5:double;
begin
  Result := oBtrTable.FieldByName('TrnVal5').AsFloat;
end;

procedure TCahBtr.WriteTrnVal5(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal5').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal6:double;
begin
  Result := oBtrTable.FieldByName('TrnVal6').AsFloat;
end;

procedure TCahBtr.WriteTrnVal6(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal6').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal7:double;
begin
  Result := oBtrTable.FieldByName('TrnVal7').AsFloat;
end;

procedure TCahBtr.WriteTrnVal7(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal7').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal8:double;
begin
  Result := oBtrTable.FieldByName('TrnVal8').AsFloat;
end;

procedure TCahBtr.WriteTrnVal8(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal8').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal9:double;
begin
  Result := oBtrTable.FieldByName('TrnVal9').AsFloat;
end;

procedure TCahBtr.WriteTrnVal9(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal9').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal0:double;
begin
  Result := oBtrTable.FieldByName('IncVal0').AsFloat;
end;

procedure TCahBtr.WriteIncVal0(pValue:double);
begin
  oBtrTable.FieldByName('IncVal0').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal1:double;
begin
  Result := oBtrTable.FieldByName('IncVal1').AsFloat;
end;

procedure TCahBtr.WriteIncVal1(pValue:double);
begin
  oBtrTable.FieldByName('IncVal1').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal2:double;
begin
  Result := oBtrTable.FieldByName('IncVal2').AsFloat;
end;

procedure TCahBtr.WriteIncVal2(pValue:double);
begin
  oBtrTable.FieldByName('IncVal2').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal3:double;
begin
  Result := oBtrTable.FieldByName('IncVal3').AsFloat;
end;

procedure TCahBtr.WriteIncVal3(pValue:double);
begin
  oBtrTable.FieldByName('IncVal3').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal4:double;
begin
  Result := oBtrTable.FieldByName('IncVal4').AsFloat;
end;

procedure TCahBtr.WriteIncVal4(pValue:double);
begin
  oBtrTable.FieldByName('IncVal4').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal5:double;
begin
  Result := oBtrTable.FieldByName('IncVal5').AsFloat;
end;

procedure TCahBtr.WriteIncVal5(pValue:double);
begin
  oBtrTable.FieldByName('IncVal5').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal6:double;
begin
  Result := oBtrTable.FieldByName('IncVal6').AsFloat;
end;

procedure TCahBtr.WriteIncVal6(pValue:double);
begin
  oBtrTable.FieldByName('IncVal6').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal7:double;
begin
  Result := oBtrTable.FieldByName('IncVal7').AsFloat;
end;

procedure TCahBtr.WriteIncVal7(pValue:double);
begin
  oBtrTable.FieldByName('IncVal7').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal8:double;
begin
  Result := oBtrTable.FieldByName('IncVal8').AsFloat;
end;

procedure TCahBtr.WriteIncVal8(pValue:double);
begin
  oBtrTable.FieldByName('IncVal8').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal9:double;
begin
  Result := oBtrTable.FieldByName('IncVal9').AsFloat;
end;

procedure TCahBtr.WriteIncVal9(pValue:double);
begin
  oBtrTable.FieldByName('IncVal9').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal0:double;
begin
  Result := oBtrTable.FieldByName('ExpVal0').AsFloat;
end;

procedure TCahBtr.WriteExpVal0(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal0').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal1:double;
begin
  Result := oBtrTable.FieldByName('ExpVal1').AsFloat;
end;

procedure TCahBtr.WriteExpVal1(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal1').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal2:double;
begin
  Result := oBtrTable.FieldByName('ExpVal2').AsFloat;
end;

procedure TCahBtr.WriteExpVal2(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal2').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal3:double;
begin
  Result := oBtrTable.FieldByName('ExpVal3').AsFloat;
end;

procedure TCahBtr.WriteExpVal3(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal3').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal4:double;
begin
  Result := oBtrTable.FieldByName('ExpVal4').AsFloat;
end;

procedure TCahBtr.WriteExpVal4(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal4').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal5:double;
begin
  Result := oBtrTable.FieldByName('ExpVal5').AsFloat;
end;

procedure TCahBtr.WriteExpVal5(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal5').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal6:double;
begin
  Result := oBtrTable.FieldByName('ExpVal6').AsFloat;
end;

procedure TCahBtr.WriteExpVal6(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal6').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal7:double;
begin
  Result := oBtrTable.FieldByName('ExpVal7').AsFloat;
end;

procedure TCahBtr.WriteExpVal7(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal7').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal8:double;
begin
  Result := oBtrTable.FieldByName('ExpVal8').AsFloat;
end;

procedure TCahBtr.WriteExpVal8(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal8').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal9:double;
begin
  Result := oBtrTable.FieldByName('ExpVal9').AsFloat;
end;

procedure TCahBtr.WriteExpVal9(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal9').AsFloat := pValue;
end;

function TCahBtr.ReadGT1Val:double;
begin
  Result := oBtrTable.FieldByName('GT1Val').AsFloat;
end;

procedure TCahBtr.WriteGT1Val(pValue:double);
begin
  oBtrTable.FieldByName('GT1Val').AsFloat := pValue;
end;

function TCahBtr.ReadGT2Val:double;
begin
  Result := oBtrTable.FieldByName('GT2Val').AsFloat;
end;

procedure TCahBtr.WriteGT2Val(pValue:double);
begin
  oBtrTable.FieldByName('GT2Val').AsFloat := pValue;
end;

function TCahBtr.ReadGT3Val:double;
begin
  Result := oBtrTable.FieldByName('GT3Val').AsFloat;
end;

procedure TCahBtr.WriteGT3Val(pValue:double);
begin
  oBtrTable.FieldByName('GT3Val').AsFloat := pValue;
end;

function TCahBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TCahBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TCahBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TCahBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TCahBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TCahBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TCahBtr.ReadVatVal1:double;
begin
  Result := oBtrTable.FieldByName('VatVal1').AsFloat;
end;

procedure TCahBtr.WriteVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TCahBtr.ReadVatVal2:double;
begin
  Result := oBtrTable.FieldByName('VatVal2').AsFloat;
end;

procedure TCahBtr.WriteVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TCahBtr.ReadVatVal3:double;
begin
  Result := oBtrTable.FieldByName('VatVal3').AsFloat;
end;

procedure TCahBtr.WriteVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TCahBtr.ReadBValue1:double;
begin
  Result := oBtrTable.FieldByName('BValue1').AsFloat;
end;

procedure TCahBtr.WriteBValue1(pValue:double);
begin
  oBtrTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TCahBtr.ReadBValue2:double;
begin
  Result := oBtrTable.FieldByName('BValue2').AsFloat;
end;

procedure TCahBtr.WriteBValue2(pValue:double);
begin
  oBtrTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TCahBtr.ReadBValue3:double;
begin
  Result := oBtrTable.FieldByName('BValue3').AsFloat;
end;

procedure TCahBtr.WriteBValue3(pValue:double);
begin
  oBtrTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TCahBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TCahBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCahBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TCahBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TCahBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TCahBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCahBtr.ReadClmVal:double;
begin
  Result := oBtrTable.FieldByName('ClmVal').AsFloat;
end;

procedure TCahBtr.WriteClmVal(pValue:double);
begin
  oBtrTable.FieldByName('ClmVal').AsFloat := pValue;
end;

function TCahBtr.ReadNegVal:double;
begin
  Result := oBtrTable.FieldByName('NegVal').AsFloat;
end;

procedure TCahBtr.WriteNegVal(pValue:double);
begin
  oBtrTable.FieldByName('NegVal').AsFloat := pValue;
end;

function TCahBtr.ReadDscVal:double;
begin
  Result := oBtrTable.FieldByName('DscVal').AsFloat;
end;

procedure TCahBtr.WriteDscVal(pValue:double);
begin
  oBtrTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TCahBtr.ReadCncVal:double;
begin
  Result := oBtrTable.FieldByName('CncVal').AsFloat;
end;

procedure TCahBtr.WriteCncVal(pValue:double);
begin
  oBtrTable.FieldByName('CncVal').AsFloat := pValue;
end;

function TCahBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TCahBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TCahBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TCahBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TCahBtr.ReadExpVal:double;
begin
  Result := oBtrTable.FieldByName('ExpVal').AsFloat;
end;

procedure TCahBtr.WriteExpVal(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal').AsFloat := pValue;
end;

function TCahBtr.ReadIncVal:double;
begin
  Result := oBtrTable.FieldByName('IncVal').AsFloat;
end;

procedure TCahBtr.WriteIncVal(pValue:double);
begin
  oBtrTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TCahBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TCahBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TCahBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCahBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCahBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCahBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCahBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCahBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCahBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCahBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCahBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCahBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCahBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCahBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCahBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCahBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCahBtr.ReadChIVal0:double;
begin
  Result := oBtrTable.FieldByName('ChIVal0').AsFloat;
end;

procedure TCahBtr.WriteChIVal0(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal0').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal1:double;
begin
  Result := oBtrTable.FieldByName('ChIVal1').AsFloat;
end;

procedure TCahBtr.WriteChIVal1(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal1').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal2:double;
begin
  Result := oBtrTable.FieldByName('ChIVal2').AsFloat;
end;

procedure TCahBtr.WriteChIVal2(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal2').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal3:double;
begin
  Result := oBtrTable.FieldByName('ChIVal3').AsFloat;
end;

procedure TCahBtr.WriteChIVal3(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal3').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal4:double;
begin
  Result := oBtrTable.FieldByName('ChIVal4').AsFloat;
end;

procedure TCahBtr.WriteChIVal4(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal4').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal5:double;
begin
  Result := oBtrTable.FieldByName('ChIVal5').AsFloat;
end;

procedure TCahBtr.WriteChIVal5(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal5').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal6:double;
begin
  Result := oBtrTable.FieldByName('ChIVal6').AsFloat;
end;

procedure TCahBtr.WriteChIVal6(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal6').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal7:double;
begin
  Result := oBtrTable.FieldByName('ChIVal7').AsFloat;
end;

procedure TCahBtr.WriteChIVal7(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal7').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal8:double;
begin
  Result := oBtrTable.FieldByName('ChIVal8').AsFloat;
end;

procedure TCahBtr.WriteChIVal8(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal8').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal9:double;
begin
  Result := oBtrTable.FieldByName('ChIVal9').AsFloat;
end;

procedure TCahBtr.WriteChIVal9(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal9').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal0:double;
begin
  Result := oBtrTable.FieldByName('ChEVal0').AsFloat;
end;

procedure TCahBtr.WriteChEVal0(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal0').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal1:double;
begin
  Result := oBtrTable.FieldByName('ChEVal1').AsFloat;
end;

procedure TCahBtr.WriteChEVal1(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal1').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal2:double;
begin
  Result := oBtrTable.FieldByName('ChEVal2').AsFloat;
end;

procedure TCahBtr.WriteChEVal2(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal2').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal3:double;
begin
  Result := oBtrTable.FieldByName('ChEVal3').AsFloat;
end;

procedure TCahBtr.WriteChEVal3(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal3').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal4:double;
begin
  Result := oBtrTable.FieldByName('ChEVal4').AsFloat;
end;

procedure TCahBtr.WriteChEVal4(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal4').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal5:double;
begin
  Result := oBtrTable.FieldByName('ChEVal5').AsFloat;
end;

procedure TCahBtr.WriteChEVal5(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal5').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal6:double;
begin
  Result := oBtrTable.FieldByName('ChEVal6').AsFloat;
end;

procedure TCahBtr.WriteChEVal6(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal6').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal7:double;
begin
  Result := oBtrTable.FieldByName('ChEVal7').AsFloat;
end;

procedure TCahBtr.WriteChEVal7(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal7').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal8:double;
begin
  Result := oBtrTable.FieldByName('ChEVal8').AsFloat;
end;

procedure TCahBtr.WriteChEVal8(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal8').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal9:double;
begin
  Result := oBtrTable.FieldByName('ChEVal9').AsFloat;
end;

procedure TCahBtr.WriteChEVal9(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal9').AsFloat := pValue;
end;

function TCahBtr.ReadChEVal:double;
begin
  Result := oBtrTable.FieldByName('ChEVal').AsFloat;
end;

procedure TCahBtr.WriteChEVal(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal').AsFloat := pValue;
end;

function TCahBtr.ReadChIVal:double;
begin
  Result := oBtrTable.FieldByName('ChIVal').AsFloat;
end;

procedure TCahBtr.WriteChIVal(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCahBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCahBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCahBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCahBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCahBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCahBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCahBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TCahBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

procedure TCahBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCahBtr.Open(pCasNum:integer);
begin
  oBookNum := StrIntZero(pCasNum,5);
  oBtrTable.Open(oBookNum);
end;

procedure TCahBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCahBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCahBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCahBtr.First;
begin
  oBtrTable.First;
end;

procedure TCahBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCahBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCahBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCahBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCahBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCahBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCahBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCahBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCahBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCahBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCahBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
