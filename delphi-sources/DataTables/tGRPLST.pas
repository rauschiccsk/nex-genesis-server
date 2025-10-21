unit tGRPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = '';
  ixGrpName_ = 'GrpName_';

type
  TGrplstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str30;         procedure WriteGrpName (pValue:Str30);
    function  ReadGrpName_:Str30;        procedure WriteGrpName_ (pValue:Str30);
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
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateGrpName_ (pGrpName_:Str30):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str30 read ReadGrpName write WriteGrpName;
    property GrpName_:Str30 read ReadGrpName_ write WriteGrpName_;
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

constructor TGrplstTmp.Create;
begin
  oTmpTable := TmpInit ('GRPLST',Self);
end;

destructor TGrplstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGrplstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGrplstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGrplstTmp.ReadGrpNum:word;
begin
  Result := oTmpTable.FieldByName('GrpNum').AsInteger;
end;

procedure TGrplstTmp.WriteGrpNum(pValue:word);
begin
  oTmpTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TGrplstTmp.ReadGrpName:Str30;
begin
  Result := oTmpTable.FieldByName('GrpName').AsString;
end;

procedure TGrplstTmp.WriteGrpName(pValue:Str30);
begin
  oTmpTable.FieldByName('GrpName').AsString := pValue;
end;

function TGrplstTmp.ReadGrpName_:Str30;
begin
  Result := oTmpTable.FieldByName('GrpName_').AsString;
end;

procedure TGrplstTmp.WriteGrpName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GrpName_').AsString := pValue;
end;

function TGrplstTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TGrplstTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGrplstTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TGrplstTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TGrplstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGrplstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGrplstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGrplstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGrplstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TGrplstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TGrplstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TGrplstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TGrplstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TGrplstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TGrplstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TGrplstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGrplstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGrplstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGrplstTmp.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oTmpTable.FindKey([pGrpNum]);
end;

function TGrplstTmp.LocateGrpName_ (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName_);
  Result := oTmpTable.FindKey([pGrpName_]);
end;

procedure TGrplstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGrplstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGrplstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGrplstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGrplstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGrplstTmp.First;
begin
  oTmpTable.First;
end;

procedure TGrplstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGrplstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGrplstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGrplstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGrplstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGrplstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGrplstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGrplstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGrplstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGrplstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGrplstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
