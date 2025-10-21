unit tDIRMOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixModNum = '';

type
  TDirmohTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModName:Str30;         procedure WriteModName (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateModNum (pModNum:word):boolean;

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
    property ModNum:word read ReadModNum write WriteModNum;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModName:Str30 read ReadModName write WriteModName;
  end;

implementation

constructor TDirmohTmp.Create;
begin
  oTmpTable := TmpInit ('DIRMOH',Self);
end;

destructor TDirmohTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirmohTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirmohTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirmohTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TDirmohTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TDirmohTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirmohTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirmohTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirmohTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDirmohTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDirmohTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirmohTmp.ReadModName:Str30;
begin
  Result := oTmpTable.FieldByName('ModName').AsString;
end;

procedure TDirmohTmp.WriteModName(pValue:Str30);
begin
  oTmpTable.FieldByName('ModName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirmohTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirmohTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirmohTmp.LocateModNum (pModNum:word):boolean;
begin
  SetIndex (ixModNum);
  Result := oTmpTable.FindKey([pModNum]);
end;

procedure TDirmohTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirmohTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirmohTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirmohTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirmohTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirmohTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirmohTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirmohTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirmohTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirmohTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirmohTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirmohTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirmohTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirmohTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirmohTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirmohTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirmohTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
