unit bDIRREM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCntNum = 'CntNum';
  ixCnRn = 'CnRn';

type
  TDirremBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadRemNum:word;           procedure WriteRemNum (pValue:word);
    function  ReadRemTxt:Str90;          procedure WriteRemTxt (pValue:Str90);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
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
    function LocateCntNum (pCntNum:word):boolean;
    function LocateCnRn (pCntNum:word;pRemNum:word):boolean;
    function NearestCntNum (pCntNum:word):boolean;
    function NearestCnRn (pCntNum:word;pRemNum:word):boolean;

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
    property RemNum:word read ReadRemNum write WriteRemNum;
    property RemTxt:Str90 read ReadRemTxt write WriteRemTxt;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDirremBtr.Create;
begin
  oBtrTable := BtrInit ('DIRREM',gPath.DlsPath,Self);
end;

constructor TDirremBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRREM',pPath,Self);
end;

destructor TDirremBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirremBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirremBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirremBtr.ReadCntNum:word;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDirremBtr.WriteCntNum(pValue:word);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDirremBtr.ReadRemNum:word;
begin
  Result := oBtrTable.FieldByName('RemNum').AsInteger;
end;

procedure TDirremBtr.WriteRemNum(pValue:word);
begin
  oBtrTable.FieldByName('RemNum').AsInteger := pValue;
end;

function TDirremBtr.ReadRemTxt:Str90;
begin
  Result := oBtrTable.FieldByName('RemTxt').AsString;
end;

procedure TDirremBtr.WriteRemTxt(pValue:Str90);
begin
  oBtrTable.FieldByName('RemTxt').AsString := pValue;
end;

function TDirremBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDirremBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDirremBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDirremBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirremBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TDirremBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TDirremBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirremBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirremBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirremBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirremBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDirremBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirremBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirremBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirremBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirremBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirremBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirremBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirremBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirremBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirremBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirremBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirremBtr.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDirremBtr.LocateCnRn (pCntNum:word;pRemNum:word):boolean;
begin
  SetIndex (ixCnRn);
  Result := oBtrTable.FindKey([pCntNum,pRemNum]);
end;

function TDirremBtr.NearestCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

function TDirremBtr.NearestCnRn (pCntNum:word;pRemNum:word):boolean;
begin
  SetIndex (ixCnRn);
  Result := oBtrTable.FindNearest([pCntNum,pRemNum]);
end;

procedure TDirremBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirremBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirremBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirremBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirremBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirremBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirremBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirremBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirremBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirremBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirremBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirremBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirremBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirremBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirremBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirremBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirremBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
