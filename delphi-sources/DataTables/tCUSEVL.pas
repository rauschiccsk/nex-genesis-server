unit tCUSEVL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCn = '';
  ixPaCode = 'PaCode';
  ixCrdName_ = 'CrdName_';
  ixAValue = 'AValue';
  ixBValue = 'BValue';
  ixDscVal = 'DscVal';

type
  TCusevlTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadCrdName:Str30;         procedure WriteCrdName (pValue:Str30);
    function  ReadCrdName_:Str30;        procedure WriteCrdName_ (pValue:Str30);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCn (pPaCode:longint;pCrdNum:Str20):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property CrdName:Str30 read ReadCrdName write WriteCrdName;
    property CrdName_:Str30 read ReadCrdName_ write WriteCrdName_;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DscVal:double read ReadDscVal write WriteDscVal;
  end;

implementation

constructor TCusevlTmp.Create;
begin
  oTmpTable := TmpInit ('CUSEVL',Self);
end;

destructor TCusevlTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCusevlTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCusevlTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCusevlTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCusevlTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCusevlTmp.ReadCrdNum:Str20;
begin
  Result := oTmpTable.FieldByName('CrdNum').AsString;
end;

procedure TCusevlTmp.WriteCrdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCusevlTmp.ReadCrdName:Str30;
begin
  Result := oTmpTable.FieldByName('CrdName').AsString;
end;

procedure TCusevlTmp.WriteCrdName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdName').AsString := pValue;
end;

function TCusevlTmp.ReadCrdName_:Str30;
begin
  Result := oTmpTable.FieldByName('CrdName_').AsString;
end;

procedure TCusevlTmp.WriteCrdName_(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdName_').AsString := pValue;
end;

function TCusevlTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TCusevlTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCusevlTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCusevlTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCusevlTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TCusevlTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCusevlTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCusevlTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCusevlTmp.LocatePaCn (pPaCode:longint;pCrdNum:Str20):boolean;
begin
  SetIndex (ixPaCn);
  Result := oTmpTable.FindKey([pPaCode,pCrdNum]);
end;

function TCusevlTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TCusevlTmp.LocateCrdName_ (pCrdName_:Str30):boolean;
begin
  SetIndex (ixCrdName_);
  Result := oTmpTable.FindKey([pCrdName_]);
end;

function TCusevlTmp.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oTmpTable.FindKey([pAValue]);
end;

function TCusevlTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TCusevlTmp.LocateDscVal (pDscVal:double):boolean;
begin
  SetIndex (ixDscVal);
  Result := oTmpTable.FindKey([pDscVal]);
end;

procedure TCusevlTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCusevlTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCusevlTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCusevlTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCusevlTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCusevlTmp.First;
begin
  oTmpTable.First;
end;

procedure TCusevlTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCusevlTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCusevlTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCusevlTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCusevlTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCusevlTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCusevlTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCusevlTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCusevlTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCusevlTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCusevlTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
