unit tMINACQ;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';

type
  TMinacqTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadOldCPrice:double;      procedure WriteOldCPrice (pValue:double);
    function  ReadOldCValue:double;      procedure WriteOldCValue (pValue:double);
    function  ReadNewCPrice:double;      procedure WriteNewCPrice (pValue:double);
    function  ReadNewCValue:double;      procedure WriteNewCValue (pValue:double);
    function  ReadSrcCprice:Str1;        procedure WriteSrcCprice (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property OldCPrice:double read ReadOldCPrice write WriteOldCPrice;
    property OldCValue:double read ReadOldCValue write WriteOldCValue;
    property NewCPrice:double read ReadNewCPrice write WriteNewCPrice;
    property NewCValue:double read ReadNewCValue write WriteNewCValue;
    property SrcCprice:Str1 read ReadSrcCprice write WriteSrcCprice;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TMinacqTmp.Create;
begin
  oTmpTable := TmpInit ('MINACQ',Self);
end;

destructor TMinacqTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMinacqTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TMinacqTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TMinacqTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TMinacqTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TMinacqTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TMinacqTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TMinacqTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TMinacqTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TMinacqTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TMinacqTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TMinacqTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TMinacqTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TMinacqTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TMinacqTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TMinacqTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TMinacqTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TMinacqTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TMinacqTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TMinacqTmp.ReadOldCPrice:double;
begin
  Result := oTmpTable.FieldByName('OldCPrice').AsFloat;
end;

procedure TMinacqTmp.WriteOldCPrice(pValue:double);
begin
  oTmpTable.FieldByName('OldCPrice').AsFloat := pValue;
end;

function TMinacqTmp.ReadOldCValue:double;
begin
  Result := oTmpTable.FieldByName('OldCValue').AsFloat;
end;

procedure TMinacqTmp.WriteOldCValue(pValue:double);
begin
  oTmpTable.FieldByName('OldCValue').AsFloat := pValue;
end;

function TMinacqTmp.ReadNewCPrice:double;
begin
  Result := oTmpTable.FieldByName('NewCPrice').AsFloat;
end;

procedure TMinacqTmp.WriteNewCPrice(pValue:double);
begin
  oTmpTable.FieldByName('NewCPrice').AsFloat := pValue;
end;

function TMinacqTmp.ReadNewCValue:double;
begin
  Result := oTmpTable.FieldByName('NewCValue').AsFloat;
end;

procedure TMinacqTmp.WriteNewCValue(pValue:double);
begin
  oTmpTable.FieldByName('NewCValue').AsFloat := pValue;
end;

function TMinacqTmp.ReadSrcCprice:Str1;
begin
  Result := oTmpTable.FieldByName('SrcCprice').AsString;
end;

procedure TMinacqTmp.WriteSrcCprice(pValue:Str1);
begin
  oTmpTable.FieldByName('SrcCprice').AsString := pValue;
end;

function TMinacqTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TMinacqTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TMinacqTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TMinacqTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TMinacqTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TMinacqTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMinacqTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TMinacqTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TMinacqTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TMinacqTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

procedure TMinacqTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TMinacqTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMinacqTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMinacqTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMinacqTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMinacqTmp.First;
begin
  oTmpTable.First;
end;

procedure TMinacqTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMinacqTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMinacqTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMinacqTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMinacqTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMinacqTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMinacqTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMinacqTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMinacqTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMinacqTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TMinacqTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1804002}
