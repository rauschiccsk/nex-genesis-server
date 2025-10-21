unit tSACCPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnPcCc = '';
  ixDnCc = 'DnCc';
  ixCpCode = 'CpCode';

type
  TSaccpiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadSacSeQnt:double;       procedure WriteSacSeQnt (pValue:double);
    function  ReadSacSuQnt:double;       procedure WriteSacSuQnt (pValue:double);
    function  ReadCpiSeQnt:double;       procedure WriteCpiSeQnt (pValue:double);
    function  ReadCpiSuQnt:double;       procedure WriteCpiSuQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDnPcCc (pDocNum:Str12;pPdCode:longint;pCpCode:longint):boolean;
    function LocateDnCc (pDocNum:Str12;pCpCode:longint):boolean;
    function LocateCpCode (pCpCode:longint):boolean;

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
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property SacSeQnt:double read ReadSacSeQnt write WriteSacSeQnt;
    property SacSuQnt:double read ReadSacSuQnt write WriteSacSuQnt;
    property CpiSeQnt:double read ReadCpiSeQnt write WriteCpiSeQnt;
    property CpiSuQnt:double read ReadCpiSuQnt write WriteCpiSuQnt;
  end;

implementation

constructor TSaccpiTmp.Create;
begin
  oTmpTable := TmpInit ('SACCPI',Self);
end;

destructor TSaccpiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSaccpiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSaccpiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSaccpiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSaccpiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSaccpiTmp.ReadPdCode:longint;
begin
  Result := oTmpTable.FieldByName('PdCode').AsInteger;
end;

procedure TSaccpiTmp.WritePdCode(pValue:longint);
begin
  oTmpTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TSaccpiTmp.ReadCpCode:longint;
begin
  Result := oTmpTable.FieldByName('CpCode').AsInteger;
end;

procedure TSaccpiTmp.WriteCpCode(pValue:longint);
begin
  oTmpTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TSaccpiTmp.ReadCpName:Str30;
begin
  Result := oTmpTable.FieldByName('CpName').AsString;
end;

procedure TSaccpiTmp.WriteCpName(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName').AsString := pValue;
end;

function TSaccpiTmp.ReadSacSeQnt:double;
begin
  Result := oTmpTable.FieldByName('SacSeQnt').AsFloat;
end;

procedure TSaccpiTmp.WriteSacSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('SacSeQnt').AsFloat := pValue;
end;

function TSaccpiTmp.ReadSacSuQnt:double;
begin
  Result := oTmpTable.FieldByName('SacSuQnt').AsFloat;
end;

procedure TSaccpiTmp.WriteSacSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('SacSuQnt').AsFloat := pValue;
end;

function TSaccpiTmp.ReadCpiSeQnt:double;
begin
  Result := oTmpTable.FieldByName('CpiSeQnt').AsFloat;
end;

procedure TSaccpiTmp.WriteCpiSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpiSeQnt').AsFloat := pValue;
end;

function TSaccpiTmp.ReadCpiSuQnt:double;
begin
  Result := oTmpTable.FieldByName('CpiSuQnt').AsFloat;
end;

procedure TSaccpiTmp.WriteCpiSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpiSuQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSaccpiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSaccpiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSaccpiTmp.LocateDnPcCc (pDocNum:Str12;pPdCode:longint;pCpCode:longint):boolean;
begin
  SetIndex (ixDnPcCc);
  Result := oTmpTable.FindKey([pDocNum,pPdCode,pCpCode]);
end;

function TSaccpiTmp.LocateDnCc (pDocNum:Str12;pCpCode:longint):boolean;
begin
  SetIndex (ixDnCc);
  Result := oTmpTable.FindKey([pDocNum,pCpCode]);
end;

function TSaccpiTmp.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oTmpTable.FindKey([pCpCode]);
end;

procedure TSaccpiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSaccpiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSaccpiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSaccpiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSaccpiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSaccpiTmp.First;
begin
  oTmpTable.First;
end;

procedure TSaccpiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSaccpiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSaccpiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSaccpiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSaccpiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSaccpiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSaccpiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSaccpiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSaccpiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSaccpiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSaccpiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
