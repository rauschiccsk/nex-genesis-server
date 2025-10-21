unit tNOTICE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TNoticeTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadNotice1:Str80;         procedure WriteNotice1 (pValue:Str80);
    function  ReadNotice2:Str80;         procedure WriteNotice2 (pValue:Str80);
    function  ReadNotice3:Str80;         procedure WriteNotice3 (pValue:Str80);
    function  ReadNotice4:Str80;         procedure WriteNotice4 (pValue:Str80);
    function  ReadNotice5:Str80;         procedure WriteNotice5 (pValue:Str80);
    function  ReadNoticeT1:Str80;        procedure WriteNoticeT1 (pValue:Str80);
    function  ReadNoticeT2:Str80;        procedure WriteNoticeT2 (pValue:Str80);
    function  ReadNoticeT3:Str80;        procedure WriteNoticeT3 (pValue:Str80);
    function  ReadNoticeT4:Str80;        procedure WriteNoticeT4 (pValue:Str80);
    function  ReadNoticeT5:Str80;        procedure WriteNoticeT5 (pValue:Str80);
    function  ReadNoticeP1:Str80;        procedure WriteNoticeP1 (pValue:Str80);
    function  ReadNoticeP2:Str80;        procedure WriteNoticeP2 (pValue:Str80);
    function  ReadNoticeP3:Str80;        procedure WriteNoticeP3 (pValue:Str80);
    function  ReadNoticeP4:Str80;        procedure WriteNoticeP4 (pValue:Str80);
    function  ReadNoticeP5:Str80;        procedure WriteNoticeP5 (pValue:Str80);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Notice1:Str80 read ReadNotice1 write WriteNotice1;
    property Notice2:Str80 read ReadNotice2 write WriteNotice2;
    property Notice3:Str80 read ReadNotice3 write WriteNotice3;
    property Notice4:Str80 read ReadNotice4 write WriteNotice4;
    property Notice5:Str80 read ReadNotice5 write WriteNotice5;
    property NoticeT1:Str80 read ReadNoticeT1 write WriteNoticeT1;
    property NoticeT2:Str80 read ReadNoticeT2 write WriteNoticeT2;
    property NoticeT3:Str80 read ReadNoticeT3 write WriteNoticeT3;
    property NoticeT4:Str80 read ReadNoticeT4 write WriteNoticeT4;
    property NoticeT5:Str80 read ReadNoticeT5 write WriteNoticeT5;
    property NoticeP1:Str80 read ReadNoticeP1 write WriteNoticeP1;
    property NoticeP2:Str80 read ReadNoticeP2 write WriteNoticeP2;
    property NoticeP3:Str80 read ReadNoticeP3 write WriteNoticeP3;
    property NoticeP4:Str80 read ReadNoticeP4 write WriteNoticeP4;
    property NoticeP5:Str80 read ReadNoticeP5 write WriteNoticeP5;
  end;

implementation

constructor TNoticeTmp.Create;
begin
  oTmpTable := TmpInit ('NOTICE',Self);
end;

destructor TNoticeTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TNoticeTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TNoticeTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TNoticeTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TNoticeTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TNoticeTmp.ReadNotice1:Str80;
begin
  Result := oTmpTable.FieldByName('Notice1').AsString;
end;

procedure TNoticeTmp.WriteNotice1(pValue:Str80);
begin
  oTmpTable.FieldByName('Notice1').AsString := pValue;
end;

function TNoticeTmp.ReadNotice2:Str80;
begin
  Result := oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TNoticeTmp.WriteNotice2(pValue:Str80);
begin
  oTmpTable.FieldByName('Notice2').AsString := pValue;
end;

function TNoticeTmp.ReadNotice3:Str80;
begin
  Result := oTmpTable.FieldByName('Notice3').AsString;
end;

procedure TNoticeTmp.WriteNotice3(pValue:Str80);
begin
  oTmpTable.FieldByName('Notice3').AsString := pValue;
end;

function TNoticeTmp.ReadNotice4:Str80;
begin
  Result := oTmpTable.FieldByName('Notice4').AsString;
end;

procedure TNoticeTmp.WriteNotice4(pValue:Str80);
begin
  oTmpTable.FieldByName('Notice4').AsString := pValue;
end;

function TNoticeTmp.ReadNotice5:Str80;
begin
  Result := oTmpTable.FieldByName('Notice5').AsString;
end;

procedure TNoticeTmp.WriteNotice5(pValue:Str80);
begin
  oTmpTable.FieldByName('Notice5').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeT1:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeT1').AsString;
end;

procedure TNoticeTmp.WriteNoticeT1(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeT1').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeT2:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeT2').AsString;
end;

procedure TNoticeTmp.WriteNoticeT2(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeT2').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeT3:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeT3').AsString;
end;

procedure TNoticeTmp.WriteNoticeT3(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeT3').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeT4:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeT4').AsString;
end;

procedure TNoticeTmp.WriteNoticeT4(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeT4').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeT5:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeT5').AsString;
end;

procedure TNoticeTmp.WriteNoticeT5(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeT5').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeP1:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeP1').AsString;
end;

procedure TNoticeTmp.WriteNoticeP1(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeP1').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeP2:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeP2').AsString;
end;

procedure TNoticeTmp.WriteNoticeP2(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeP2').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeP3:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeP3').AsString;
end;

procedure TNoticeTmp.WriteNoticeP3(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeP3').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeP4:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeP4').AsString;
end;

procedure TNoticeTmp.WriteNoticeP4(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeP4').AsString := pValue;
end;

function TNoticeTmp.ReadNoticeP5:Str80;
begin
  Result := oTmpTable.FieldByName('NoticeP5').AsString;
end;

procedure TNoticeTmp.WriteNoticeP5(pValue:Str80);
begin
  oTmpTable.FieldByName('NoticeP5').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNoticeTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TNoticeTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TNoticeTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TNoticeTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TNoticeTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TNoticeTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TNoticeTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TNoticeTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TNoticeTmp.First;
begin
  oTmpTable.First;
end;

procedure TNoticeTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TNoticeTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TNoticeTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TNoticeTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TNoticeTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TNoticeTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TNoticeTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TNoticeTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TNoticeTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TNoticeTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TNoticeTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
