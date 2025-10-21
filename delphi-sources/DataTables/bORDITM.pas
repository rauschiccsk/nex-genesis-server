unit bORDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCuDnOnIn = 'CuDnOnIn';
  ixCuDnOn = 'CuDnOn';
  ixDnOn = 'DnOn';
  ixItmNum = 'ItmNum';
  ixCuDnOnGc = 'CuDnOnGc';
  ixDskName = 'DskName';
  ixOrdName = 'OrdName';

type
  TOrditmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCasUsi:Str20;          procedure WriteCasUsi (pValue:Str20);
    function  ReadDskName:Str15;         procedure WriteDskName (pValue:Str15);
    function  ReadOrdName:Str15;         procedure WriteOrdName (pValue:Str15);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:word;           procedure WriteFgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadProdNum:Str30;         procedure WriteProdNum (pValue:Str30);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadOrdPrn:byte;           procedure WriteOrdPrn (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCuDnOnIn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pItmNum:word):boolean;
    function LocateCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
    function LocateDnOn (pDskname:Str15;pOrdName:Str15):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateCuDnOnGc (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pGsCode:longint):boolean;
    function LocateDskName (pDskName:Str15):boolean;
    function LocateOrdName (pOrdName:Str15):boolean;
    function NearestCuDnOnIn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pItmNum:word):boolean;
    function NearestCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
    function NearestDnOn (pDskname:Str15;pOrdName:Str15):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestCuDnOnGc (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pGsCode:longint):boolean;
    function NearestDskName (pDskName:Str15):boolean;
    function NearestOrdName (pOrdName:Str15):boolean;

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
    property CasUsi:Str20 read ReadCasUsi write WriteCasUsi;
    property DskName:Str15 read ReadDskName write WriteDskName;
    property OrdName:Str15 read ReadOrdName write WriteOrdName;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:word read ReadFgCode write WriteFgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property CValue:double read ReadCValue write WriteCValue;
    property Profit:double read ReadProfit write WriteProfit;
    property HValue:double read ReadHValue write WriteHValue;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property BValue:double read ReadBValue write WriteBValue;
    property ProdNum:Str30 read ReadProdNum write WriteProdNum;
    property Action:Str1 read ReadAction write WriteAction;
    property OrdPrn:byte read ReadOrdPrn write WriteOrdPrn;
  end;

implementation

constructor TOrditmBtr.Create;
begin
  oBtrTable := BtrInit ('ORDITM',gPath.CabPath,Self);
end;

constructor TOrditmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ORDITM',pPath,Self);
end;

destructor TOrditmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOrditmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOrditmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOrditmBtr.ReadCasUsi:Str20;
begin
  Result := oBtrTable.FieldByName('CasUsi').AsString;
end;

procedure TOrditmBtr.WriteCasUsi(pValue:Str20);
begin
  oBtrTable.FieldByName('CasUsi').AsString := pValue;
end;

function TOrditmBtr.ReadDskName:Str15;
begin
  Result := oBtrTable.FieldByName('DskName').AsString;
end;

procedure TOrditmBtr.WriteDskName(pValue:Str15);
begin
  oBtrTable.FieldByName('DskName').AsString := pValue;
end;

function TOrditmBtr.ReadOrdName:Str15;
begin
  Result := oBtrTable.FieldByName('OrdName').AsString;
end;

procedure TOrditmBtr.WriteOrdName(pValue:Str15);
begin
  oBtrTable.FieldByName('OrdName').AsString := pValue;
end;

function TOrditmBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOrditmBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOrditmBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TOrditmBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOrditmBtr.ReadFgCode:word;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TOrditmBtr.WriteFgCode(pValue:word);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TOrditmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOrditmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOrditmBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TOrditmBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TOrditmBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TOrditmBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TOrditmBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TOrditmBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOrditmBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TOrditmBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TOrditmBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TOrditmBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TOrditmBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TOrditmBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TOrditmBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOrditmBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TOrditmBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TOrditmBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TOrditmBtr.ReadProfit:double;
begin
  Result := oBtrTable.FieldByName('Profit').AsFloat;
end;

procedure TOrditmBtr.WriteProfit(pValue:double);
begin
  oBtrTable.FieldByName('Profit').AsFloat := pValue;
end;

function TOrditmBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TOrditmBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TOrditmBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOrditmBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOrditmBtr.ReadDscVal:double;
begin
  Result := oBtrTable.FieldByName('DscVal').AsFloat;
end;

procedure TOrditmBtr.WriteDscVal(pValue:double);
begin
  oBtrTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TOrditmBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TOrditmBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TOrditmBtr.ReadProdNum:Str30;
begin
  Result := oBtrTable.FieldByName('ProdNum').AsString;
end;

procedure TOrditmBtr.WriteProdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ProdNum').AsString := pValue;
end;

function TOrditmBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TOrditmBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TOrditmBtr.ReadOrdPrn:byte;
begin
  Result := oBtrTable.FieldByName('OrdPrn').AsInteger;
end;

procedure TOrditmBtr.WriteOrdPrn(pValue:byte);
begin
  oBtrTable.FieldByName('OrdPrn').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOrditmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOrditmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOrditmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOrditmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOrditmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOrditmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOrditmBtr.LocateCuDnOnIn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pItmNum:word):boolean;
begin
  SetIndex (ixCuDnOnIn);
  Result := oBtrTable.FindKey([pCasUsi,pDskname,pOrdName,pItmNum]);
end;

function TOrditmBtr.LocateCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixCuDnOn);
  Result := oBtrTable.FindKey([pCasUsi,pDskname,pOrdName]);
end;

function TOrditmBtr.LocateDnOn (pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixDnOn);
  Result := oBtrTable.FindKey([pDskname,pOrdName]);
end;

function TOrditmBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TOrditmBtr.LocateCuDnOnGc (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixCuDnOnGc);
  Result := oBtrTable.FindKey([pCasUsi,pDskname,pOrdName,pGsCode]);
end;

function TOrditmBtr.LocateDskName (pDskName:Str15):boolean;
begin
  SetIndex (ixDskName);
  Result := oBtrTable.FindKey([pDskName]);
end;

function TOrditmBtr.LocateOrdName (pOrdName:Str15):boolean;
begin
  SetIndex (ixOrdName);
  Result := oBtrTable.FindKey([pOrdName]);
end;

function TOrditmBtr.NearestCuDnOnIn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pItmNum:word):boolean;
begin
  SetIndex (ixCuDnOnIn);
  Result := oBtrTable.FindNearest([pCasUsi,pDskname,pOrdName,pItmNum]);
end;

function TOrditmBtr.NearestCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixCuDnOn);
  Result := oBtrTable.FindNearest([pCasUsi,pDskname,pOrdName]);
end;

function TOrditmBtr.NearestDnOn (pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixDnOn);
  Result := oBtrTable.FindNearest([pDskname,pOrdName]);
end;

function TOrditmBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TOrditmBtr.NearestCuDnOnGc (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixCuDnOnGc);
  Result := oBtrTable.FindNearest([pCasUsi,pDskname,pOrdName,pGsCode]);
end;

function TOrditmBtr.NearestDskName (pDskName:Str15):boolean;
begin
  SetIndex (ixDskName);
  Result := oBtrTable.FindNearest([pDskName]);
end;

function TOrditmBtr.NearestOrdName (pOrdName:Str15):boolean;
begin
  SetIndex (ixOrdName);
  Result := oBtrTable.FindNearest([pOrdName]);
end;

procedure TOrditmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOrditmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TOrditmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOrditmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOrditmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOrditmBtr.First;
begin
  oBtrTable.First;
end;

procedure TOrditmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOrditmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOrditmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOrditmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOrditmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOrditmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOrditmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOrditmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOrditmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOrditmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOrditmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
