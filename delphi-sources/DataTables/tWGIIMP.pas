unit tWGIIMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixGsQnt = 'GsQnt';
  ixBValue = 'BValue';

type
  TWgiimpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateGsQnt (pGsQnt:double):boolean;
    function LocateBValue (pBValue:double):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TWgiimpTmp.Create;
begin
  oTmpTable := TmpInit ('WGIIMP',Self);
end;

destructor TWgiimpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TWgiimpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TWgiimpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TWgiimpTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TWgiimpTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TWgiimpTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TWgiimpTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TWgiimpTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TWgiimpTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TWgiimpTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TWgiimpTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TWgiimpTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TWgiimpTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TWgiimpTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TWgiimpTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TWgiimpTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TWgiimpTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TWgiimpTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TWgiimpTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TWgiimpTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TWgiimpTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TWgiimpTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TWgiimpTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TWgiimpTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TWgiimpTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TWgiimpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TWgiimpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWgiimpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TWgiimpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TWgiimpTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TWgiimpTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TWgiimpTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TWgiimpTmp.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TWgiimpTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TWgiimpTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TWgiimpTmp.LocateGsQnt (pGsQnt:double):boolean;
begin
  SetIndex (ixGsQnt);
  Result := oTmpTable.FindKey([pGsQnt]);
end;

function TWgiimpTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

procedure TWgiimpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TWgiimpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TWgiimpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TWgiimpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TWgiimpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TWgiimpTmp.First;
begin
  oTmpTable.First;
end;

procedure TWgiimpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TWgiimpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TWgiimpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TWgiimpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TWgiimpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TWgiimpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TWgiimpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TWgiimpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TWgiimpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TWgiimpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TWgiimpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
