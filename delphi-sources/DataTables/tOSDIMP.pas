unit tOSDIMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';

type
  TOsdimpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGuName:Str90;          procedure WriteGuName (pValue:Str90);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSupCode:Str15;         procedure WriteSupCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadRatDay:word;           procedure WriteRatDay (pValue:word);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadIValue:double;         procedure WriteIValue (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GuName:Str90 read ReadGuName write WriteGuName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SupCode:Str15 read ReadSupCode write WriteSupCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property RatDay:word read ReadRatDay write WriteRatDay;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property IValue:double read ReadIValue write WriteIValue;
    property DifVal:double read ReadDifVal write WriteDifVal;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TOsdimpTmp.Create;
begin
  oTmpTable := TmpInit ('OSDIMP',Self);
end;

destructor TOsdimpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsdimpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOsdimpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsdimpTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsdimpTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOsdimpTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOsdimpTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOsdimpTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TOsdimpTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOsdimpTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TOsdimpTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TOsdimpTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TOsdimpTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TOsdimpTmp.ReadGuName:Str90;
begin
  Result := oTmpTable.FieldByName('GuName').AsString;
end;

procedure TOsdimpTmp.WriteGuName(pValue:Str90);
begin
  oTmpTable.FieldByName('GuName').AsString := pValue;
end;

function TOsdimpTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TOsdimpTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TOsdimpTmp.ReadSupCode:Str15;
begin
  Result := oTmpTable.FieldByName('SupCode').AsString;
end;

procedure TOsdimpTmp.WriteSupCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SupCode').AsString := pValue;
end;

function TOsdimpTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOsdimpTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TOsdimpTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TOsdimpTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TOsdimpTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TOsdimpTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TOsdimpTmp.ReadRatDay:word;
begin
  Result := oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsdimpTmp.WriteRatDay(pValue:word);
begin
  oTmpTable.FieldByName('RatDay').AsInteger := pValue;
end;

function TOsdimpTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TOsdimpTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TOsdimpTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TOsdimpTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TOsdimpTmp.ReadIValue:double;
begin
  Result := oTmpTable.FieldByName('IValue').AsFloat;
end;

procedure TOsdimpTmp.WriteIValue(pValue:double);
begin
  oTmpTable.FieldByName('IValue').AsFloat := pValue;
end;

function TOsdimpTmp.ReadDifVal:double;
begin
  Result := oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TOsdimpTmp.WriteDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat := pValue;
end;

function TOsdimpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOsdimpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsdimpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOsdimpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOsdimpTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TOsdimpTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TOsdimpTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TOsdimpTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TOsdimpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOsdimpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsdimpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsdimpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsdimpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsdimpTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsdimpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsdimpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsdimpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsdimpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsdimpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsdimpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsdimpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsdimpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsdimpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsdimpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOsdimpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
