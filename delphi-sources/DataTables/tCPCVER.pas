unit tCPCVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixGsCode = 'GsCode';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixFifNum = 'FifNum';

type
  TCpcverTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadFifPce:double;         procedure WriteFifPce (pValue:double);
    function  ReadStmPce:double;         procedure WriteStmPce (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocateFifNum (pFifNum:longint):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property FifPce:double read ReadFifPce write WriteFifPce;
    property StmPce:double read ReadStmPce write WriteStmPce;
  end;

implementation

constructor TCpcverTmp.Create;
begin
  oTmpTable := TmpInit ('CPCVER',Self);
end;

destructor TCpcverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCpcverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCpcverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCpcverTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TCpcverTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TCpcverTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCpcverTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCpcverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TCpcverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCpcverTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TCpcverTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TCpcverTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCpcverTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCpcverTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TCpcverTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TCpcverTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TCpcverTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TCpcverTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TCpcverTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TCpcverTmp.ReadFifPce:double;
begin
  Result := oTmpTable.FieldByName('FifPce').AsFloat;
end;

procedure TCpcverTmp.WriteFifPce(pValue:double);
begin
  oTmpTable.FieldByName('FifPce').AsFloat := pValue;
end;

function TCpcverTmp.ReadStmPce:double;
begin
  Result := oTmpTable.FieldByName('StmPce').AsFloat;
end;

procedure TCpcverTmp.WriteStmPce(pValue:double);
begin
  oTmpTable.FieldByName('StmPce').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCpcverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCpcverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCpcverTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TCpcverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TCpcverTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TCpcverTmp.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

function TCpcverTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

procedure TCpcverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCpcverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCpcverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCpcverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCpcverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCpcverTmp.First;
begin
  oTmpTable.First;
end;

procedure TCpcverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCpcverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCpcverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCpcverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCpcverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCpcverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCpcverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCpcverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCpcverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCpcverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCpcverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
