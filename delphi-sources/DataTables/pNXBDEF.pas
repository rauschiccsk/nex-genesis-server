unit pNXBDEF;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, dNXBDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable, Forms;

const
  ixPmBn = 'PmBn';

type
  TNxbdefTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oPmdMark: Str3;
    oBtrData: Tnxbdef;
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadPmdMark:Str3;          procedure WritePmdMark (pValue:Str3);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str40;        procedure WriteBookName (pValue:Str40);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    procedure LoadToTmp (pPmdMark:Str3); 
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property BtrData:TNxbdef read oBtrData write oBtrData;
    property Count:integer read ReadCount;
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str40 read ReadBookName write WriteBookName;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TNxbdefTmp.Create;
begin
  oTmpTable := TmpInit ('nxbdef',Self);
  oBtrData := Tnxbdef.Create;
end;

destructor  TNxbdefTmp.Destroy;
begin
  oBtrData.Close; FreeAndNil (oBtrData);
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TNxbdefTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TNxbdefTmp.ReadPmdMark:Str3;
begin
  Result := oTmpTable.FieldByName('PmdMark').AsString;
end;

procedure TNxbdefTmp.WritePmdMark(pValue:Str3);
begin
  oTmpTable.FieldByName('PmdMark').AsString := pValue;
end;

function TNxbdefTmp.ReadBookNum:Str5;
begin
  Result := oTmpTable.FieldByName('BookNum').AsString;
end;

procedure TNxbdefTmp.WriteBookNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BookNum').AsString := pValue;
end;

function TNxbdefTmp.ReadBookName:Str40;
begin
  Result := oTmpTable.FieldByName('BookName').AsString;
end;

procedure TNxbdefTmp.WriteBookName(pValue:Str40);
begin
  oTmpTable.FieldByName('BookName').AsString := pValue;
end;

function TNxbdefTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TNxbdefTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TNxbdefTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TNxbdefTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TNxbdefTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TNxbdefTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNxbdefTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TNxbdefTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TNxbdefTmp.LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixPmBn);
  Result := oTmpTable.FindKey([pPmdMark,pBookNum]);
end;

procedure TNxbdefTmp.LoadToTmp (pPmdMark:Str3);
begin
  oPmdMark := pPmdMark;
  If oBtrData.LocatePmdMark (pPmdMark) then begin
    Repeat
      oTmpTable.Insert;
      BTR_To_PX (oBtrData.BtrTable,oTmpTable);
      oTmpTable.Post;
      Application.ProcessMessages;
      oBtrData.Next;
    until oBtrData.Eof or (oBtrData.PmdMark<>pPmdMark);
  end;
end;

procedure TNxbdefTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TNxbdefTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TNxbdefTmp.Close;
begin
  oBtrData.Close;
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TNxbdefTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TNxbdefTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TNxbdefTmp.First;
begin
  oTmpTable.First;
end;

procedure TNxbdefTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TNxbdefTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TNxbdefTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TNxbdefTmp.Post;
var mEdit:boolean;
begin
  mEdit := (oTmpTable.FieldByName('ActPos').AsInteger<>0) and oBtrData.GotoPos(oTmpTable.FieldByName('ActPos').AsInteger);
  If mEdit
    then oBtrData.Edit
    else oBtrData.Insert;
  oBtrData.PmdMark := oPmdMark;
  PX_To_BTR (oTmpTable,oBtrData.BtrTable);
  oBtrData.Post;
  // Ulozime udje do TMP databaze
  oTmpTable.FieldByName('ActPos').AsInteger := oBtrData.ActPos;
  oTmpTable.Post;
end;

procedure TNxbdefTmp.Delete;
begin
  If oBtrData.GotoPos(oTmpTable.FieldByName('ActPos').AsInteger) then begin
    If (oBtrData.PmdMark=oPmdMark) then oBtrData.Delete;
  end;
  oTmpTable.Delete;
end;

procedure TNxbdefTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TNxbdefTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

end.
