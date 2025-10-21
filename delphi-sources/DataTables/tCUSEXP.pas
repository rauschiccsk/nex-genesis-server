unit tCUSEXP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixDdCn = 'DdCn';
  ixCrdnum = 'Crdnum';
  ixPaCode = 'PaCode';
  ixPcCn = 'PcCn';
  ixCrdName_ = 'CrdName_';
  ixAValue = 'AValue';
  ixBValue = 'BValue';
  ixDscVal = 'DscVal';

type
  TCusexpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocdate:TDatetime;     procedure WriteDocdate (pValue:TDatetime);
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadCrdName:Str30;         procedure WriteCrdName (pValue:Str30);
    function  ReadCrdName_:Str30;        procedure WriteCrdName_ (pValue:Str30);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadCasNum:longint;        procedure WriteCasNum (pValue:longint);
    function  ReadCashier:longint;       procedure WriteCashier (pValue:longint);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadIntBlkNum:longint;     procedure WriteIntBlkNum (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDdCn (pDocDate:TDatetime;pCrdNum:Str20):boolean;
    function LocateCrdnum (pCrdNum:Str20):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePcCn (pPaCode:longint;pCrdNum:Str20):boolean;
    function LocateCrdName_ (pCrdName_:Str30):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateDscVal (pDscVal:double):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property Docdate:TDatetime read ReadDocdate write WriteDocdate;
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property CrdName:Str30 read ReadCrdName write WriteCrdName;
    property CrdName_:Str30 read ReadCrdName_ write WriteCrdName_;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property CasNum:longint read ReadCasNum write WriteCasNum;
    property Cashier:longint read ReadCashier write WriteCashier;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property IntBlkNum:longint read ReadIntBlkNum write WriteIntBlkNum;
  end;

implementation

constructor TCusexpTmp.Create;
begin
  oTmpTable := TmpInit ('CUSEXP',Self);
end;

destructor TCusexpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCusexpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCusexpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCusexpTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TCusexpTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCusexpTmp.ReadDocdate:TDatetime;
begin
  Result := oTmpTable.FieldByName('Docdate').AsDateTime;
end;

procedure TCusexpTmp.WriteDocdate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('Docdate').AsDateTime := pValue;
end;

function TCusexpTmp.ReadCrdNum:Str20;
begin
  Result := oTmpTable.FieldByName('CrdNum').AsString;
end;

procedure TCusexpTmp.WriteCrdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCusexpTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCusexpTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCusexpTmp.ReadCrdName:Str30;
begin
  Result := oTmpTable.FieldByName('CrdName').AsString;
end;

procedure TCusexpTmp.WriteCrdName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdName').AsString := pValue;
end;

function TCusexpTmp.ReadCrdName_:Str30;
begin
  Result := oTmpTable.FieldByName('CrdName_').AsString;
end;

procedure TCusexpTmp.WriteCrdName_(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdName_').AsString := pValue;
end;

function TCusexpTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TCusexpTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCusexpTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCusexpTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCusexpTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TCusexpTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TCusexpTmp.ReadCasNum:longint;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TCusexpTmp.WriteCasNum(pValue:longint);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TCusexpTmp.ReadCashier:longint;
begin
  Result := oTmpTable.FieldByName('Cashier').AsInteger;
end;

procedure TCusexpTmp.WriteCashier(pValue:longint);
begin
  oTmpTable.FieldByName('Cashier').AsInteger := pValue;
end;

function TCusexpTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TCusexpTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TCusexpTmp.ReadIntBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('IntBlkNum').AsInteger;
end;

procedure TCusexpTmp.WriteIntBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('IntBlkNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCusexpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCusexpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCusexpTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TCusexpTmp.LocateDdCn (pDocDate:TDatetime;pCrdNum:Str20):boolean;
begin
  SetIndex (ixDdCn);
  Result := oTmpTable.FindKey([pDocDate,pCrdNum]);
end;

function TCusexpTmp.LocateCrdnum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdnum);
  Result := oTmpTable.FindKey([pCrdNum]);
end;

function TCusexpTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TCusexpTmp.LocatePcCn (pPaCode:longint;pCrdNum:Str20):boolean;
begin
  SetIndex (ixPcCn);
  Result := oTmpTable.FindKey([pPaCode,pCrdNum]);
end;

function TCusexpTmp.LocateCrdName_ (pCrdName_:Str30):boolean;
begin
  SetIndex (ixCrdName_);
  Result := oTmpTable.FindKey([pCrdName_]);
end;

function TCusexpTmp.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oTmpTable.FindKey([pAValue]);
end;

function TCusexpTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TCusexpTmp.LocateDscVal (pDscVal:double):boolean;
begin
  SetIndex (ixDscVal);
  Result := oTmpTable.FindKey([pDscVal]);
end;

procedure TCusexpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCusexpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCusexpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCusexpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCusexpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCusexpTmp.First;
begin
  oTmpTable.First;
end;

procedure TCusexpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCusexpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCusexpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCusexpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCusexpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCusexpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCusexpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCusexpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCusexpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCusexpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCusexpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
