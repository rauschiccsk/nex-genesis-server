unit bIPT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';

type
  TIptBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadTxtLin:Str90;          procedure WriteTxtLin (pValue:Str90);
    function  ReadTrmDate:TDatetime;     procedure WriteTrmDate (pValue:TDatetime);
    function  ReadTrmTime:TDatetime;     procedure WriteTrmTime (pValue:TDatetime);
    function  ReadTasUser:Str8;          procedure WriteTasUser (pValue:Str8);
    function  ReadTasName:Str30;         procedure WriteTasName (pValue:Str30);
    function  ReadTasDate:TDatetime;     procedure WriteTasDate (pValue:TDatetime);
    function  ReadTasTime:TDatetime;     procedure WriteTasTime (pValue:TDatetime);
    function  ReadTasSign:Str40;         procedure WriteTasSign (pValue:Str40);
    function  ReadTasStat:Str1;          procedure WriteTasStat (pValue:Str1);
    function  ReadTasNoti:Str90;         procedure WriteTasNoti (pValue:Str90);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property TxtLin:Str90 read ReadTxtLin write WriteTxtLin;
    property TrmDate:TDatetime read ReadTrmDate write WriteTrmDate;
    property TrmTime:TDatetime read ReadTrmTime write WriteTrmTime;
    property TasUser:Str8 read ReadTasUser write WriteTasUser;
    property TasName:Str30 read ReadTasName write WriteTasName;
    property TasDate:TDatetime read ReadTasDate write WriteTasDate;
    property TasTime:TDatetime read ReadTasTime write WriteTasTime;
    property TasSign:Str40 read ReadTasSign write WriteTasSign;
    property TasStat:Str1 read ReadTasStat write WriteTasStat;
    property TasNoti:Str90 read ReadTasNoti write WriteTasNoti;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIptBtr.Create;
begin
  oBtrTable := BtrInit ('IPT',gPath.MgdPath,Self);
end;

constructor TIptBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPT',pPath,Self);
end;

destructor TIptBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIptBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIptBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIptBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIptBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIptBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TIptBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIptBtr.ReadTxtLin:Str90;
begin
  Result := oBtrTable.FieldByName('TxtLin').AsString;
end;

procedure TIptBtr.WriteTxtLin(pValue:Str90);
begin
  oBtrTable.FieldByName('TxtLin').AsString := pValue;
end;

function TIptBtr.ReadTrmDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrmDate').AsDateTime;
end;

procedure TIptBtr.WriteTrmDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrmDate').AsDateTime := pValue;
end;

function TIptBtr.ReadTrmTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrmTime').AsDateTime;
end;

procedure TIptBtr.WriteTrmTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrmTime').AsDateTime := pValue;
end;

function TIptBtr.ReadTasUser:Str8;
begin
  Result := oBtrTable.FieldByName('TasUser').AsString;
end;

procedure TIptBtr.WriteTasUser(pValue:Str8);
begin
  oBtrTable.FieldByName('TasUser').AsString := pValue;
end;

function TIptBtr.ReadTasName:Str30;
begin
  Result := oBtrTable.FieldByName('TasName').AsString;
end;

procedure TIptBtr.WriteTasName(pValue:Str30);
begin
  oBtrTable.FieldByName('TasName').AsString := pValue;
end;

function TIptBtr.ReadTasDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TasDate').AsDateTime;
end;

procedure TIptBtr.WriteTasDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TasDate').AsDateTime := pValue;
end;

function TIptBtr.ReadTasTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('TasTime').AsDateTime;
end;

procedure TIptBtr.WriteTasTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TasTime').AsDateTime := pValue;
end;

function TIptBtr.ReadTasSign:Str40;
begin
  Result := oBtrTable.FieldByName('TasSign').AsString;
end;

procedure TIptBtr.WriteTasSign(pValue:Str40);
begin
  oBtrTable.FieldByName('TasSign').AsString := pValue;
end;

function TIptBtr.ReadTasStat:Str1;
begin
  Result := oBtrTable.FieldByName('TasStat').AsString;
end;

procedure TIptBtr.WriteTasStat(pValue:Str1);
begin
  oBtrTable.FieldByName('TasStat').AsString := pValue;
end;

function TIptBtr.ReadTasNoti:Str90;
begin
  Result := oBtrTable.FieldByName('TasNoti').AsString;
end;

procedure TIptBtr.WriteTasNoti(pValue:Str90);
begin
  oBtrTable.FieldByName('TasNoti').AsString := pValue;
end;

function TIptBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIptBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIptBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIptBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIptBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIptBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIptBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIptBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIptBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIptBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIptBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIptBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIptBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIptBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIptBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIptBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIptBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIptBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIptBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIptBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIptBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIptBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TIptBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIptBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIptBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIptBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIptBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIptBtr.First;
begin
  oBtrTable.First;
end;

procedure TIptBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIptBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIptBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIptBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIptBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIptBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIptBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIptBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIptBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIptBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIptBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
