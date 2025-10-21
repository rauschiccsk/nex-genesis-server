unit tGSCLNK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLnkGsc = '';
  ixLnkGsn_ = 'LnkGsn_';

type
  TGsclnkTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLnkGsc:longint;        procedure WriteLnkGsc (pValue:longint);
    function  ReadLnkGsn:Str60;          procedure WriteLnkGsn (pValue:Str60);
    function  ReadLnkGsn_:Str60;         procedure WriteLnkGsn_ (pValue:Str60);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateLnkGsc (pLnkGsc:longint):boolean;
    function LocateLnkGsn_ (pLnkGsn_:Str60):boolean;

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
    property LnkGsc:longint read ReadLnkGsc write WriteLnkGsc;
    property LnkGsn:Str60 read ReadLnkGsn write WriteLnkGsn;
    property LnkGsn_:Str60 read ReadLnkGsn_ write WriteLnkGsn_;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TGsclnkTmp.Create;
begin
  oTmpTable := TmpInit ('GSCLNK',Self);
end;

destructor TGsclnkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGsclnkTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGsclnkTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGsclnkTmp.ReadLnkGsc:longint;
begin
  Result := oTmpTable.FieldByName('LnkGsc').AsInteger;
end;

procedure TGsclnkTmp.WriteLnkGsc(pValue:longint);
begin
  oTmpTable.FieldByName('LnkGsc').AsInteger := pValue;
end;

function TGsclnkTmp.ReadLnkGsn:Str60;
begin
  Result := oTmpTable.FieldByName('LnkGsn').AsString;
end;

procedure TGsclnkTmp.WriteLnkGsn(pValue:Str60);
begin
  oTmpTable.FieldByName('LnkGsn').AsString := pValue;
end;

function TGsclnkTmp.ReadLnkGsn_:Str60;
begin
  Result := oTmpTable.FieldByName('LnkGsn_').AsString;
end;

procedure TGsclnkTmp.WriteLnkGsn_(pValue:Str60);
begin
  oTmpTable.FieldByName('LnkGsn_').AsString := pValue;
end;

function TGsclnkTmp.ReadMinQnt:double;
begin
  Result := oTmpTable.FieldByName('MinQnt').AsFloat;
end;

procedure TGsclnkTmp.WriteMinQnt(pValue:double);
begin
  oTmpTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TGsclnkTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TGsclnkTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGsclnkTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGsclnkTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGsclnkTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGsclnkTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGsclnkTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TGsclnkTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsclnkTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGsclnkTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGsclnkTmp.LocateLnkGsc (pLnkGsc:longint):boolean;
begin
  SetIndex (ixLnkGsc);
  Result := oTmpTable.FindKey([pLnkGsc]);
end;

function TGsclnkTmp.LocateLnkGsn_ (pLnkGsn_:Str60):boolean;
begin
  SetIndex (ixLnkGsn_);
  Result := oTmpTable.FindKey([pLnkGsn_]);
end;

procedure TGsclnkTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGsclnkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGsclnkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGsclnkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGsclnkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGsclnkTmp.First;
begin
  oTmpTable.First;
end;

procedure TGsclnkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGsclnkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGsclnkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGsclnkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGsclnkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGsclnkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGsclnkTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGsclnkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGsclnkTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGsclnkTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGsclnkTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
