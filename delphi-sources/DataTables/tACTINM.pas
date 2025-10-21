unit tACTINM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum = '';
  ixStmNum = 'StmNum';
  ixSmCode = 'SmCode';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixActQnt = 'ActQnt';

type
  TActinmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadStmNum:longint;        procedure WriteStmNum (pValue:longint);
    function  ReadSmCode:longint;        procedure WriteSmCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadIncQnt:double;         procedure WriteIncQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocateStmNum (pStmNum:longint):boolean;
    function LocateSmCode (pSmCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateActQnt (pActQnt:double):boolean;

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
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property StmNum:longint read ReadStmNum write WriteStmNum;
    property SmCode:longint read ReadSmCode write WriteSmCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property IncQnt:double read ReadIncQnt write WriteIncQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property ActVal:double read ReadActVal write WriteActVal;
  end;

implementation

constructor TActinmTmp.Create;
begin
  oTmpTable := TmpInit ('ACTINM',Self);
end;

destructor TActinmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TActinmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TActinmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TActinmTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TActinmTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TActinmTmp.ReadStmNum:longint;
begin
  Result := oTmpTable.FieldByName('StmNum').AsInteger;
end;

procedure TActinmTmp.WriteStmNum(pValue:longint);
begin
  oTmpTable.FieldByName('StmNum').AsInteger := pValue;
end;

function TActinmTmp.ReadSmCode:longint;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TActinmTmp.WriteSmCode(pValue:longint);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TActinmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TActinmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TActinmTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TActinmTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TActinmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TActinmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TActinmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TActinmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TActinmTmp.ReadIncQnt:double;
begin
  Result := oTmpTable.FieldByName('IncQnt').AsFloat;
end;

procedure TActinmTmp.WriteIncQnt(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TActinmTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TActinmTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TActinmTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TActinmTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TActinmTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TActinmTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TActinmTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TActinmTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TActinmTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TActinmTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TActinmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TActinmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TActinmTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

function TActinmTmp.LocateStmNum (pStmNum:longint):boolean;
begin
  SetIndex (ixStmNum);
  Result := oTmpTable.FindKey([pStmNum]);
end;

function TActinmTmp.LocateSmCode (pSmCode:longint):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

function TActinmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TActinmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TActinmTmp.LocateActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oTmpTable.FindKey([pActQnt]);
end;

procedure TActinmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TActinmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TActinmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TActinmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TActinmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TActinmTmp.First;
begin
  oTmpTable.First;
end;

procedure TActinmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TActinmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TActinmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TActinmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TActinmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TActinmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TActinmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TActinmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TActinmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TActinmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TActinmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1926001}
