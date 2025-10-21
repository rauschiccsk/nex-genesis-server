unit bSRSTA;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMthNum = 'MthNum';
  ixMtGs = 'MtGs';
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';

type
  TSrstaBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMthNum:byte;           procedure WriteMthNum (pValue:byte);
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
    function LocateMthNum (pMthNum:byte):boolean;
    function LocateMtGs (pMthNum:byte;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function NearestMthNum (pMthNum:byte):boolean;
    function NearestMtGs (pMthNum:byte;pGsCode:longint):boolean;
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
    property MthNum:byte read ReadMthNum write WriteMthNum;
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

constructor TSrstaBtr.Create;
begin
  oBtrTable := BtrInit ('SRSTA',gPath.StkPath,Self);
end;

constructor TSrstaBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SRSTA',pPath,Self);
end;

destructor TSrstaBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSrstaBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSrstaBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSrstaBtr.ReadMthNum:byte;
begin
  Result := oBtrTable.FieldByName('MthNum').AsInteger;
end;

procedure TSrstaBtr.WriteMthNum(pValue:byte);
begin
  oBtrTable.FieldByName('MthNum').AsInteger := pValue;
end;

function TSrstaBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrstaBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrstaBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrstaBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrstaBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSrstaBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSrstaBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSrstaBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrstaBtr.ReadBegQnt:double;
begin
  Result := oBtrTable.FieldByName('BegQnt').AsFloat;
end;

procedure TSrstaBtr.WriteBegQnt(pValue:double);
begin
  oBtrTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TSrstaBtr.ReadIncQnt:double;
begin
  Result := oBtrTable.FieldByName('IncQnt').AsFloat;
end;

procedure TSrstaBtr.WriteIncQnt(pValue:double);
begin
  oBtrTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TSrstaBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TSrstaBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TSrstaBtr.ReadEndQnt:double;
begin
  Result := oBtrTable.FieldByName('EndQnt').AsFloat;
end;

procedure TSrstaBtr.WriteEndQnt(pValue:double);
begin
  oBtrTable.FieldByName('EndQnt').AsFloat := pValue;
end;

function TSrstaBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TSrstaBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrstaBtr.ReadPrcVol:double;
begin
  Result := oBtrTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrstaBtr.WritePrcVol(pValue:double);
begin
  oBtrTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrstaBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSrstaBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrstaBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrstaBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrstaBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrstaBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrstaBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSrstaBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSrstaBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSrstaBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrstaBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrstaBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrstaBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrstaBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrstaBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrstaBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSrstaBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrstaBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSrstaBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSrstaBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSrstaBtr.LocateMthNum (pMthNum:byte):boolean;
begin
  SetIndex (ixMthNum);
  Result := oBtrTable.FindKey([pMthNum]);
end;

function TSrstaBtr.LocateMtGs (pMthNum:byte;pGsCode:longint):boolean;
begin
  SetIndex (ixMtGs);
  Result := oBtrTable.FindKey([pMthNum,pGsCode]);
end;

function TSrstaBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSrstaBtr.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TSrstaBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TSrstaBtr.NearestMthNum (pMthNum:byte):boolean;
begin
  SetIndex (ixMthNum);
  Result := oBtrTable.FindNearest([pMthNum]);
end;

function TSrstaBtr.NearestMtGs (pMthNum:byte;pGsCode:longint):boolean;
begin
  SetIndex (ixMtGs);
  Result := oBtrTable.FindNearest([pMthNum,pGsCode]);
end;

function TSrstaBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSrstaBtr.NearestMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TSrstaBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

procedure TSrstaBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSrstaBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSrstaBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSrstaBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSrstaBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSrstaBtr.First;
begin
  oBtrTable.First;
end;

procedure TSrstaBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSrstaBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSrstaBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSrstaBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSrstaBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSrstaBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSrstaBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSrstaBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSrstaBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSrstaBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSrstaBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
