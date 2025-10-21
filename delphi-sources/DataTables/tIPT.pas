unit tIPT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TIptTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIptTmp.Create;
begin
  oTmpTable := TmpInit ('IPT',Self);
end;

destructor TIptTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIptTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIptTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIptTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TIptTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIptTmp.ReadTxtLin:Str90;
begin
  Result := oTmpTable.FieldByName('TxtLin').AsString;
end;

procedure TIptTmp.WriteTxtLin(pValue:Str90);
begin
  oTmpTable.FieldByName('TxtLin').AsString := pValue;
end;

function TIptTmp.ReadTrmDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TrmDate').AsDateTime;
end;

procedure TIptTmp.WriteTrmDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrmDate').AsDateTime := pValue;
end;

function TIptTmp.ReadTrmTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TrmTime').AsDateTime;
end;

procedure TIptTmp.WriteTrmTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrmTime').AsDateTime := pValue;
end;

function TIptTmp.ReadTasUser:Str8;
begin
  Result := oTmpTable.FieldByName('TasUser').AsString;
end;

procedure TIptTmp.WriteTasUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TasUser').AsString := pValue;
end;

function TIptTmp.ReadTasName:Str30;
begin
  Result := oTmpTable.FieldByName('TasName').AsString;
end;

procedure TIptTmp.WriteTasName(pValue:Str30);
begin
  oTmpTable.FieldByName('TasName').AsString := pValue;
end;

function TIptTmp.ReadTasDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TasDate').AsDateTime;
end;

procedure TIptTmp.WriteTasDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TasDate').AsDateTime := pValue;
end;

function TIptTmp.ReadTasTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TasTime').AsDateTime;
end;

procedure TIptTmp.WriteTasTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TasTime').AsDateTime := pValue;
end;

function TIptTmp.ReadTasSign:Str40;
begin
  Result := oTmpTable.FieldByName('TasSign').AsString;
end;

procedure TIptTmp.WriteTasSign(pValue:Str40);
begin
  oTmpTable.FieldByName('TasSign').AsString := pValue;
end;

function TIptTmp.ReadTasStat:Str1;
begin
  Result := oTmpTable.FieldByName('TasStat').AsString;
end;

procedure TIptTmp.WriteTasStat(pValue:Str1);
begin
  oTmpTable.FieldByName('TasStat').AsString := pValue;
end;

function TIptTmp.ReadTasNoti:Str90;
begin
  Result := oTmpTable.FieldByName('TasNoti').AsString;
end;

procedure TIptTmp.WriteTasNoti(pValue:Str90);
begin
  oTmpTable.FieldByName('TasNoti').AsString := pValue;
end;

function TIptTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIptTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIptTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TIptTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TIptTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIptTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIptTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIptTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIptTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIptTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIptTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIptTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIptTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIptTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIptTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIptTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIptTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIptTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIptTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TIptTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIptTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIptTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIptTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIptTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIptTmp.First;
begin
  oTmpTable.First;
end;

procedure TIptTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIptTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIptTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIptTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIptTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIptTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIptTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIptTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIptTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIptTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIptTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
