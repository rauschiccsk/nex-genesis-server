unit tDIRTEL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TDirtelTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadTelSpc:Str1;           procedure WriteTelSpc (pValue:Str1);
    function  ReadTelNum:Str20;          procedure WriteTelNum (pValue:Str20);
    function  ReadTelDes:Str60;          procedure WriteTelDes (pValue:Str60);
    function  ReadTelTyp:Str1;           procedure WriteTelTyp (pValue:Str1);
    function  ReadMarker:Str1;           procedure WriteMarker (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property TelSpc:Str1 read ReadTelSpc write WriteTelSpc;
    property TelNum:Str20 read ReadTelNum write WriteTelNum;
    property TelDes:Str60 read ReadTelDes write WriteTelDes;
    property TelTyp:Str1 read ReadTelTyp write WriteTelTyp;
    property Marker:Str1 read ReadMarker write WriteMarker;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDirtelTmp.Create;
begin
  oTmpTable := TmpInit ('DIRTEL',Self);
end;

destructor TDirtelTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirtelTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirtelTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirtelTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TDirtelTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TDirtelTmp.ReadTelSpc:Str1;
begin
  Result := oTmpTable.FieldByName('TelSpc').AsString;
end;

procedure TDirtelTmp.WriteTelSpc(pValue:Str1);
begin
  oTmpTable.FieldByName('TelSpc').AsString := pValue;
end;

function TDirtelTmp.ReadTelNum:Str20;
begin
  Result := oTmpTable.FieldByName('TelNum').AsString;
end;

procedure TDirtelTmp.WriteTelNum(pValue:Str20);
begin
  oTmpTable.FieldByName('TelNum').AsString := pValue;
end;

function TDirtelTmp.ReadTelDes:Str60;
begin
  Result := oTmpTable.FieldByName('TelDes').AsString;
end;

procedure TDirtelTmp.WriteTelDes(pValue:Str60);
begin
  oTmpTable.FieldByName('TelDes').AsString := pValue;
end;

function TDirtelTmp.ReadTelTyp:Str1;
begin
  Result := oTmpTable.FieldByName('TelTyp').AsString;
end;

procedure TDirtelTmp.WriteTelTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('TelTyp').AsString := pValue;
end;

function TDirtelTmp.ReadMarker:Str1;
begin
  Result := oTmpTable.FieldByName('Marker').AsString;
end;

procedure TDirtelTmp.WriteMarker(pValue:Str1);
begin
  oTmpTable.FieldByName('Marker').AsString := pValue;
end;

function TDirtelTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TDirtelTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDirtelTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDirtelTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDirtelTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDirtelTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirtelTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirtelTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirtelTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirtelTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirtelTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDirtelTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirtelTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirtelTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirtelTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirtelTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDirtelTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDirtelTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirtelTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirtelTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirtelTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TDirtelTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirtelTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirtelTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirtelTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirtelTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirtelTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirtelTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirtelTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirtelTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirtelTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirtelTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirtelTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirtelTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirtelTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirtelTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirtelTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirtelTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
