unit bSRSTA_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixSnGs = 'SnGs';
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';

type
  TSrsta_cBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadIncQnt:double;         procedure WriteIncQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadEndQnt:double;         procedure WriteEndQnt (pValue:double);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadPrcVol:double;         procedure WritePrcVol (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateSnGs (pSerNum:longint;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestSnGs (pSerNum:longint;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgCode (pMgCode:word):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property IncQnt:double read ReadIncQnt write WriteIncQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property EndQnt:double read ReadEndQnt write WriteEndQnt;
    property Volume:double read ReadVolume write WriteVolume;
    property PrcVol:double read ReadPrcVol write WritePrcVol;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSrsta_cBtr.Create;
begin
  oBtrTable := BtrInit ('SRSTA_C',gPath.LdgPath,Self);
end;

constructor TSrsta_cBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SRSTA_C',pPath,Self);
end;

destructor TSrsta_cBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSrsta_cBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSrsta_cBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSrsta_cBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSrsta_cBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSrsta_cBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrsta_cBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrsta_cBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrsta_cBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrsta_cBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSrsta_cBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSrsta_cBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSrsta_cBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrsta_cBtr.ReadBegQnt:double;
begin
  Result := oBtrTable.FieldByName('BegQnt').AsFloat;
end;

procedure TSrsta_cBtr.WriteBegQnt(pValue:double);
begin
  oBtrTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TSrsta_cBtr.ReadIncQnt:double;
begin
  Result := oBtrTable.FieldByName('IncQnt').AsFloat;
end;

procedure TSrsta_cBtr.WriteIncQnt(pValue:double);
begin
  oBtrTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TSrsta_cBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TSrsta_cBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TSrsta_cBtr.ReadEndQnt:double;
begin
  Result := oBtrTable.FieldByName('EndQnt').AsFloat;
end;

procedure TSrsta_cBtr.WriteEndQnt(pValue:double);
begin
  oBtrTable.FieldByName('EndQnt').AsFloat := pValue;
end;

function TSrsta_cBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TSrsta_cBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrsta_cBtr.ReadPrcVol:double;
begin
  Result := oBtrTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrsta_cBtr.WritePrcVol(pValue:double);
begin
  oBtrTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrsta_cBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSrsta_cBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrsta_cBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrsta_cBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrsta_cBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrsta_cBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrsta_cBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSrsta_cBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSrsta_cBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSrsta_cBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrsta_cBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrsta_cBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrsta_cBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrsta_cBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrsta_cBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrsta_cBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSrsta_cBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrsta_cBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSrsta_cBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSrsta_cBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSrsta_cBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TSrsta_cBtr.LocateSnGs (pSerNum:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixSnGs);
  Result := oBtrTable.FindKey([pSerNum,pGsCode]);
end;

function TSrsta_cBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSrsta_cBtr.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TSrsta_cBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TSrsta_cBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TSrsta_cBtr.NearestSnGs (pSerNum:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixSnGs);
  Result := oBtrTable.FindNearest([pSerNum,pGsCode]);
end;

function TSrsta_cBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSrsta_cBtr.NearestMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TSrsta_cBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

procedure TSrsta_cBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSrsta_cBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSrsta_cBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSrsta_cBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSrsta_cBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSrsta_cBtr.First;
begin
  oBtrTable.First;
end;

procedure TSrsta_cBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSrsta_cBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSrsta_cBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSrsta_cBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSrsta_cBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSrsta_cBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSrsta_cBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSrsta_cBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSrsta_cBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSrsta_cBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSrsta_cBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
