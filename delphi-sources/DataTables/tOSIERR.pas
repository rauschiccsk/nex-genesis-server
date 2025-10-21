unit tOSIERR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';

type
  TOsierrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOsiQnt:double;         procedure WriteOsiQnt (pValue:double);
    function  ReadStoQnt:double;         procedure WriteStoQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;

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
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OsiQnt:double read ReadOsiQnt write WriteOsiQnt;
    property StoQnt:double read ReadStoQnt write WriteStoQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
  end;

implementation

constructor TOsierrTmp.Create;
begin
  oTmpTable := TmpInit ('OSIERR',Self);
end;

destructor TOsierrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsierrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOsierrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsierrTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOsierrTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOsierrTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsierrTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOsierrTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TOsierrTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOsierrTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOsierrTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOsierrTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TOsierrTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TOsierrTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TOsierrTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TOsierrTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TOsierrTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TOsierrTmp.ReadOsiQnt:double;
begin
  Result := oTmpTable.FieldByName('OsiQnt').AsFloat;
end;

procedure TOsierrTmp.WriteOsiQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsiQnt').AsFloat := pValue;
end;

function TOsierrTmp.ReadStoQnt:double;
begin
  Result := oTmpTable.FieldByName('StoQnt').AsFloat;
end;

procedure TOsierrTmp.WriteStoQnt(pValue:double);
begin
  oTmpTable.FieldByName('StoQnt').AsFloat := pValue;
end;

function TOsierrTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TOsierrTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsierrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOsierrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOsierrTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOsierrTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TOsierrTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TOsierrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOsierrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsierrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsierrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsierrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsierrTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsierrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsierrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsierrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsierrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsierrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsierrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsierrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsierrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsierrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsierrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOsierrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
