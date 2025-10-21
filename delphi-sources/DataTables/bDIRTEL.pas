unit bDIRTEL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnTsTn = 'CnTsTn';
  ixCnTs = 'CnTs';
  ixCntNum = 'CntNum';

type
  TDirtelBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:longint;        procedure WriteCntNum (pValue:longint);
    function  ReadTelSpc:Str1;           procedure WriteTelSpc (pValue:Str1);
    function  ReadTelNum:Str20;          procedure WriteTelNum (pValue:Str20);
    function  ReadTelDes:Str60;          procedure WriteTelDes (pValue:Str60);
    function  ReadTelTyp:Str1;           procedure WriteTelTyp (pValue:Str1);
    function  ReadMarker:Str1;           procedure WriteMarker (pValue:Str1);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
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
    function LocateCnTsTn (pCntNum:longint;pTelSpc:Str1;pTelNum:Str20):boolean;
    function LocateCnTs (pCntNum:longint;pTelSpc:Str1):boolean;
    function LocateCntNum (pCntNum:longint):boolean;
    function NearestCnTsTn (pCntNum:longint;pTelSpc:Str1;pTelNum:Str20):boolean;
    function NearestCnTs (pCntNum:longint;pTelSpc:Str1):boolean;
    function NearestCntNum (pCntNum:longint):boolean;

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
    property CntNum:longint read ReadCntNum write WriteCntNum;
    property TelSpc:Str1 read ReadTelSpc write WriteTelSpc;
    property TelNum:Str20 read ReadTelNum write WriteTelNum;
    property TelDes:Str60 read ReadTelDes write WriteTelDes;
    property TelTyp:Str1 read ReadTelTyp write WriteTelTyp;
    property Marker:Str1 read ReadMarker write WriteMarker;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDirtelBtr.Create;
begin
  oBtrTable := BtrInit ('DIRTEL',gPath.DlsPath,Self);
end;

constructor TDirtelBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRTEL',pPath,Self);
end;

destructor TDirtelBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirtelBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirtelBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirtelBtr.ReadCntNum:longint;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDirtelBtr.WriteCntNum(pValue:longint);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDirtelBtr.ReadTelSpc:Str1;
begin
  Result := oBtrTable.FieldByName('TelSpc').AsString;
end;

procedure TDirtelBtr.WriteTelSpc(pValue:Str1);
begin
  oBtrTable.FieldByName('TelSpc').AsString := pValue;
end;

function TDirtelBtr.ReadTelNum:Str20;
begin
  Result := oBtrTable.FieldByName('TelNum').AsString;
end;

procedure TDirtelBtr.WriteTelNum(pValue:Str20);
begin
  oBtrTable.FieldByName('TelNum').AsString := pValue;
end;

function TDirtelBtr.ReadTelDes:Str60;
begin
  Result := oBtrTable.FieldByName('TelDes').AsString;
end;

procedure TDirtelBtr.WriteTelDes(pValue:Str60);
begin
  oBtrTable.FieldByName('TelDes').AsString := pValue;
end;

function TDirtelBtr.ReadTelTyp:Str1;
begin
  Result := oBtrTable.FieldByName('TelTyp').AsString;
end;

procedure TDirtelBtr.WriteTelTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('TelTyp').AsString := pValue;
end;

function TDirtelBtr.ReadMarker:Str1;
begin
  Result := oBtrTable.FieldByName('Marker').AsString;
end;

procedure TDirtelBtr.WriteMarker(pValue:Str1);
begin
  oBtrTable.FieldByName('Marker').AsString := pValue;
end;

function TDirtelBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDirtelBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDirtelBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDirtelBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirtelBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirtelBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirtelBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirtelBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirtelBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDirtelBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirtelBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirtelBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirtelBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirtelBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirtelBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirtelBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirtelBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirtelBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirtelBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirtelBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirtelBtr.LocateCnTsTn (pCntNum:longint;pTelSpc:Str1;pTelNum:Str20):boolean;
begin
  SetIndex (ixCnTsTn);
  Result := oBtrTable.FindKey([pCntNum,pTelSpc,pTelNum]);
end;

function TDirtelBtr.LocateCnTs (pCntNum:longint;pTelSpc:Str1):boolean;
begin
  SetIndex (ixCnTs);
  Result := oBtrTable.FindKey([pCntNum,pTelSpc]);
end;

function TDirtelBtr.LocateCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDirtelBtr.NearestCnTsTn (pCntNum:longint;pTelSpc:Str1;pTelNum:Str20):boolean;
begin
  SetIndex (ixCnTsTn);
  Result := oBtrTable.FindNearest([pCntNum,pTelSpc,pTelNum]);
end;

function TDirtelBtr.NearestCnTs (pCntNum:longint;pTelSpc:Str1):boolean;
begin
  SetIndex (ixCnTs);
  Result := oBtrTable.FindNearest([pCntNum,pTelSpc]);
end;

function TDirtelBtr.NearestCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

procedure TDirtelBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirtelBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirtelBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirtelBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirtelBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirtelBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirtelBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirtelBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirtelBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirtelBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirtelBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirtelBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirtelBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirtelBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirtelBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirtelBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirtelBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
