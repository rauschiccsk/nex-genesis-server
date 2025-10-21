unit tMCRSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixGsCode = 'GsCode';

type
  TMcrstkTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadOsdQnt:double;         procedure WriteOsdQnt (pValue:double);
    function  ReadOsrQnt:double;         procedure WriteOsrQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadAvgPrice:double;       procedure WriteAvgPrice (pValue:double);
    function  ReadAcqPrice:double;       procedure WriteAcqPrice (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property OsdQnt:double read ReadOsdQnt write WriteOsdQnt;
    property OsrQnt:double read ReadOsrQnt write WriteOsrQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property AvgPrice:double read ReadAvgPrice write WriteAvgPrice;
    property AcqPrice:double read ReadAcqPrice write WriteAcqPrice;
  end;

implementation

constructor TMcrstkTmp.Create;
begin
  oTmpTable := TmpInit ('MCRSTK',Self);
end;

destructor TMcrstkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMcrstkTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TMcrstkTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TMcrstkTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TMcrstkTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TMcrstkTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TMcrstkTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TMcrstkTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TMcrstkTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TMcrstkTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TMcrstkTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TMcrstkTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TMcrstkTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TMcrstkTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TMcrstkTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TMcrstkTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TMcrstkTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TMcrstkTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TMcrstkTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TMcrstkTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TMcrstkTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TMcrstkTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TMcrstkTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TMcrstkTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TMcrstkTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TMcrstkTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TMcrstkTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TMcrstkTmp.ReadOsdQnt:double;
begin
  Result := oTmpTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TMcrstkTmp.WriteOsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TMcrstkTmp.ReadOsrQnt:double;
begin
  Result := oTmpTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TMcrstkTmp.WriteOsrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsrQnt').AsFloat := pValue;
end;

function TMcrstkTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TMcrstkTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TMcrstkTmp.ReadAvgPrice:double;
begin
  Result := oTmpTable.FieldByName('AvgPrice').AsFloat;
end;

procedure TMcrstkTmp.WriteAvgPrice(pValue:double);
begin
  oTmpTable.FieldByName('AvgPrice').AsFloat := pValue;
end;

function TMcrstkTmp.ReadAcqPrice:double;
begin
  Result := oTmpTable.FieldByName('AcqPrice').AsFloat;
end;

procedure TMcrstkTmp.WriteAcqPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcqPrice').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMcrstkTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TMcrstkTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TMcrstkTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TMcrstkTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TMcrstkTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TMcrstkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMcrstkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMcrstkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMcrstkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMcrstkTmp.First;
begin
  oTmpTable.First;
end;

procedure TMcrstkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMcrstkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMcrstkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMcrstkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMcrstkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMcrstkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMcrstkTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMcrstkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMcrstkTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMcrstkTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TMcrstkTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1804002}
