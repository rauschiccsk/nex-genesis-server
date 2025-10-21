unit bPXH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixDocNum = 'DocNum';
  ixDesTxt = 'DesTxt';

type
  TPxhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadPmdCod:Str2;           procedure WritePmdCod (pValue:Str2);
    function  ReadDesTxt:Str60;          procedure WriteDesTxt (pValue:Str60);
    function  ReadDesTxt_:Str60;         procedure WriteDesTxt_ (pValue:Str60);
    function  ReadSysNum:byte;           procedure WriteSysNum (pValue:byte);
    function  ReadTchDoc:Str1;           procedure WriteTchDoc (pValue:Str1);
    function  ReadUsrDoc:Str1;           procedure WriteUsrDoc (pValue:Str1);
    function  ReadImfDoc:Str1;           procedure WriteImfDoc (pValue:Str1);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDesTxt (pDesTxt_:Str60):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDesTxt (pDesTxt_:Str60):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property PmdCod:Str2 read ReadPmdCod write WritePmdCod;
    property DesTxt:Str60 read ReadDesTxt write WriteDesTxt;
    property DesTxt_:Str60 read ReadDesTxt_ write WriteDesTxt_;
    property SysNum:byte read ReadSysNum write WriteSysNum;
    property TchDoc:Str1 read ReadTchDoc write WriteTchDoc;
    property UsrDoc:Str1 read ReadUsrDoc write WriteUsrDoc;
    property ImfDoc:Str1 read ReadImfDoc write WriteImfDoc;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPxhBtr.Create;
begin
  oBtrTable := BtrInit ('PXH',gPath.DlsPath,Self);
end;

constructor TPxhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PXH',pPath,Self);
end;

destructor TPxhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPxhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPxhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPxhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPxhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPxhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPxhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPxhBtr.ReadPmdCod:Str2;
begin
  Result := oBtrTable.FieldByName('PmdCod').AsString;
end;

procedure TPxhBtr.WritePmdCod(pValue:Str2);
begin
  oBtrTable.FieldByName('PmdCod').AsString := pValue;
end;

function TPxhBtr.ReadDesTxt:Str60;
begin
  Result := oBtrTable.FieldByName('DesTxt').AsString;
end;

procedure TPxhBtr.WriteDesTxt(pValue:Str60);
begin
  oBtrTable.FieldByName('DesTxt').AsString := pValue;
end;

function TPxhBtr.ReadDesTxt_:Str60;
begin
  Result := oBtrTable.FieldByName('DesTxt_').AsString;
end;

procedure TPxhBtr.WriteDesTxt_(pValue:Str60);
begin
  oBtrTable.FieldByName('DesTxt_').AsString := pValue;
end;

function TPxhBtr.ReadSysNum:byte;
begin
  Result := oBtrTable.FieldByName('SysNum').AsInteger;
end;

procedure TPxhBtr.WriteSysNum(pValue:byte);
begin
  oBtrTable.FieldByName('SysNum').AsInteger := pValue;
end;

function TPxhBtr.ReadTchDoc:Str1;
begin
  Result := oBtrTable.FieldByName('TchDoc').AsString;
end;

procedure TPxhBtr.WriteTchDoc(pValue:Str1);
begin
  oBtrTable.FieldByName('TchDoc').AsString := pValue;
end;

function TPxhBtr.ReadUsrDoc:Str1;
begin
  Result := oBtrTable.FieldByName('UsrDoc').AsString;
end;

procedure TPxhBtr.WriteUsrDoc(pValue:Str1);
begin
  oBtrTable.FieldByName('UsrDoc').AsString := pValue;
end;

function TPxhBtr.ReadImfDoc:Str1;
begin
  Result := oBtrTable.FieldByName('ImfDoc').AsString;
end;

procedure TPxhBtr.WriteImfDoc(pValue:Str1);
begin
  oBtrTable.FieldByName('ImfDoc').AsString := pValue;
end;

function TPxhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPxhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPxhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPxhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPxhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPxhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPxhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPxhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPxhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPxhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPxhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPxhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPxhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPxhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPxhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPxhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPxhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPxhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPxhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPxhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPxhBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TPxhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPxhBtr.LocateDesTxt (pDesTxt_:Str60):boolean;
begin
  SetIndex (ixDesTxt);
  Result := oBtrTable.FindKey([StrToAlias(pDesTxt_)]);
end;

function TPxhBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TPxhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPxhBtr.NearestDesTxt (pDesTxt_:Str60):boolean;
begin
  SetIndex (ixDesTxt);
  Result := oBtrTable.FindNearest([pDesTxt_]);
end;

procedure TPxhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPxhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPxhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPxhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPxhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPxhBtr.First;
begin
  oBtrTable.First;
end;

procedure TPxhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPxhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPxhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPxhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPxhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPxhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPxhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPxhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPxhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPxhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPxhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1905014}
