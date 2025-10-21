unit bPASUBC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixPaWp = 'PaWp';

type
  TPasubcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str60;         procedure WriteWpaName (pValue:Str60);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadWpaTel:Str20;          procedure WriteWpaTel (pValue:Str20);
    function  ReadWpaFax:Str20;          procedure WriteWpaFax (pValue:Str20);
    function  ReadWpaEml:Str30;          procedure WriteWpaEml (pValue:Str30);
    function  ReadTrsCode:Str3;          procedure WriteTrsCode (pValue:Str3);
    function  ReadTrsName:Str20;         procedure WriteTrsName (pValue:Str20);
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
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaWp (pPaCode:longint;pWpaCode:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaWp (pPaCode:longint;pWpaCode:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str60 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property WpaTel:Str20 read ReadWpaTel write WriteWpaTel;
    property WpaFax:Str20 read ReadWpaFax write WriteWpaFax;
    property WpaEml:Str30 read ReadWpaEml write WriteWpaEml;
    property TrsCode:Str3 read ReadTrsCode write WriteTrsCode;
    property TrsName:Str20 read ReadTrsName write WriteTrsName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPasubcBtr.Create;
begin
  oBtrTable := BtrInit ('PASUBC',gPath.DlsPath,Self);
end;

constructor TPasubcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PASUBC',pPath,Self);
end;

destructor TPasubcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPasubcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPasubcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPasubcBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPasubcBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPasubcBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TPasubcBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TPasubcBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TPasubcBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TPasubcBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TPasubcBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TPasubcBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TPasubcBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TPasubcBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TPasubcBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TPasubcBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TPasubcBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TPasubcBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TPasubcBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TPasubcBtr.ReadWpaTel:Str20;
begin
  Result := oBtrTable.FieldByName('WpaTel').AsString;
end;

procedure TPasubcBtr.WriteWpaTel(pValue:Str20);
begin
  oBtrTable.FieldByName('WpaTel').AsString := pValue;
end;

function TPasubcBtr.ReadWpaFax:Str20;
begin
  Result := oBtrTable.FieldByName('WpaFax').AsString;
end;

procedure TPasubcBtr.WriteWpaFax(pValue:Str20);
begin
  oBtrTable.FieldByName('WpaFax').AsString := pValue;
end;

function TPasubcBtr.ReadWpaEml:Str30;
begin
  Result := oBtrTable.FieldByName('WpaEml').AsString;
end;

procedure TPasubcBtr.WriteWpaEml(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaEml').AsString := pValue;
end;

function TPasubcBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TPasubcBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TPasubcBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TPasubcBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TPasubcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPasubcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPasubcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPasubcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPasubcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPasubcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPasubcBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPasubcBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPasubcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPasubcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPasubcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPasubcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPasubcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPasubcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPasubcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPasubcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPasubcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPasubcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPasubcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPasubcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPasubcBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPasubcBtr.LocatePaWp (pPaCode:longint;pWpaCode:word):boolean;
begin
  SetIndex (ixPaWp);
  Result := oBtrTable.FindKey([pPaCode,pWpaCode]);
end;

function TPasubcBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TPasubcBtr.NearestPaWp (pPaCode:longint;pWpaCode:word):boolean;
begin
  SetIndex (ixPaWp);
  Result := oBtrTable.FindNearest([pPaCode,pWpaCode]);
end;

procedure TPasubcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPasubcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPasubcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPasubcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPasubcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPasubcBtr.First;
begin
  oBtrTable.First;
end;

procedure TPasubcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPasubcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPasubcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPasubcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPasubcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPasubcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPasubcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPasubcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPasubcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPasubcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPasubcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
