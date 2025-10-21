unit bDIRCRS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnPa = 'CnPa';
  ixCntNum = 'CntNum';

type
  TDircrsBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadCrsDes:Str60;          procedure WriteCrsDes (pValue:Str60);
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
    function LocateCnPa (pCntNum:word;pPaCode:longint):boolean;
    function LocateCntNum (pCntNum:word):boolean;
    function NearestCnPa (pCntNum:word;pPaCode:longint):boolean;
    function NearestCntNum (pCntNum:word):boolean;

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
    property CntNum:word read ReadCntNum write WriteCntNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property CrsDes:Str60 read ReadCrsDes write WriteCrsDes;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDircrsBtr.Create;
begin
  oBtrTable := BtrInit ('DIRCRS',gPath.DlsPath,Self);
end;

constructor TDircrsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRCRS',pPath,Self);
end;

destructor TDircrsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDircrsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDircrsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDircrsBtr.ReadCntNum:word;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDircrsBtr.WriteCntNum(pValue:word);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDircrsBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TDircrsBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDircrsBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TDircrsBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TDircrsBtr.ReadCrsDes:Str60;
begin
  Result := oBtrTable.FieldByName('CrsDes').AsString;
end;

procedure TDircrsBtr.WriteCrsDes(pValue:Str60);
begin
  oBtrTable.FieldByName('CrsDes').AsString := pValue;
end;

function TDircrsBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDircrsBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDircrsBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDircrsBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDircrsBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDircrsBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDircrsBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDircrsBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDircrsBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDircrsBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDircrsBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDircrsBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDircrsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDircrsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDircrsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDircrsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDircrsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDircrsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDircrsBtr.LocateCnPa (pCntNum:word;pPaCode:longint):boolean;
begin
  SetIndex (ixCnPa);
  Result := oBtrTable.FindKey([pCntNum,pPaCode]);
end;

function TDircrsBtr.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDircrsBtr.NearestCnPa (pCntNum:word;pPaCode:longint):boolean;
begin
  SetIndex (ixCnPa);
  Result := oBtrTable.FindNearest([pCntNum,pPaCode]);
end;

function TDircrsBtr.NearestCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

procedure TDircrsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDircrsBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDircrsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDircrsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDircrsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDircrsBtr.First;
begin
  oBtrTable.First;
end;

procedure TDircrsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDircrsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDircrsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDircrsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDircrsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDircrsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDircrsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDircrsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDircrsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDircrsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDircrsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
