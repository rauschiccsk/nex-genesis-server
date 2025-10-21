unit bFXBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = 'BookNum';
  ixBookName = 'BookName';

type
  TFxblstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadBookName_:Str30;       procedure WriteBookName_ (pValue:Str30);
    function  ReadBookSymb:Str2;         procedure WriteBookSymb (pValue:Str2);
    function  ReadBookYear:word;         procedure WriteBookYear (pValue:word);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadModNum:byte;           procedure WriteModNum (pValue:byte);
    function  ReadBegNum:longint;        procedure WriteBegNum (pValue:longint);
    function  ReadLSuCalc:byte;          procedure WriteLSuCalc (pValue:byte);
    function  ReadReserve:Str80;         procedure WriteReserve (pValue:Str80);
    function  ReadActYear:Str4;          procedure WriteActYear (pValue:Str4);
    function  ReadDocQnt:longint;        procedure WriteDocQnt (pValue:longint);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMark:Str1;             procedure WriteMark (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBookNum (pBookNum:Str5):boolean;
    function LocateBookName (pBookName_:Str30):boolean;
    function NearestBookNum (pBookNum:Str5):boolean;
    function NearestBookName (pBookName_:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property BookName_:Str30 read ReadBookName_ write WriteBookName_;
    property BookSymb:Str2 read ReadBookSymb write WriteBookSymb;
    property BookYear:word read ReadBookYear write WriteBookYear;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property ModNum:byte read ReadModNum write WriteModNum;
    property BegNum:longint read ReadBegNum write WriteBegNum;
    property LSuCalc:byte read ReadLSuCalc write WriteLSuCalc;
    property Reserve:Str80 read ReadReserve write WriteReserve;
    property ActYear:Str4 read ReadActYear write WriteActYear;
    property DocQnt:longint read ReadDocQnt write WriteDocQnt;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Mark:Str1 read ReadMark write WriteMark;
  end;

implementation

constructor TFxblstBtr.Create;
begin
  oBtrTable := BtrInit ('FXBLST',gPath.LdgPath,Self);
end;

constructor TFxblstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FXBLST',pPath,Self);
end;

destructor TFxblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFxblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFxblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFxblstBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TFxblstBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TFxblstBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TFxblstBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TFxblstBtr.ReadBookName_:Str30;
begin
  Result := oBtrTable.FieldByName('BookName_').AsString;
end;

procedure TFxblstBtr.WriteBookName_(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName_').AsString := pValue;
end;

function TFxblstBtr.ReadBookSymb:Str2;
begin
  Result := oBtrTable.FieldByName('BookSymb').AsString;
end;

procedure TFxblstBtr.WriteBookSymb(pValue:Str2);
begin
  oBtrTable.FieldByName('BookSymb').AsString := pValue;
end;

function TFxblstBtr.ReadBookYear:word;
begin
  Result := oBtrTable.FieldByName('BookYear').AsInteger;
end;

procedure TFxblstBtr.WriteBookYear(pValue:word);
begin
  oBtrTable.FieldByName('BookYear').AsInteger := pValue;
end;

function TFxblstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TFxblstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFxblstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TFxblstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFxblstBtr.ReadModNum:byte;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TFxblstBtr.WriteModNum(pValue:byte);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TFxblstBtr.ReadBegNum:longint;
begin
  Result := oBtrTable.FieldByName('BegNum').AsInteger;
end;

procedure TFxblstBtr.WriteBegNum(pValue:longint);
begin
  oBtrTable.FieldByName('BegNum').AsInteger := pValue;
end;

function TFxblstBtr.ReadLSuCalc:byte;
begin
  Result := oBtrTable.FieldByName('LSuCalc').AsInteger;
end;

procedure TFxblstBtr.WriteLSuCalc(pValue:byte);
begin
  oBtrTable.FieldByName('LSuCalc').AsInteger := pValue;
end;

function TFxblstBtr.ReadReserve:Str80;
begin
  Result := oBtrTable.FieldByName('Reserve').AsString;
end;

procedure TFxblstBtr.WriteReserve(pValue:Str80);
begin
  oBtrTable.FieldByName('Reserve').AsString := pValue;
end;

function TFxblstBtr.ReadActYear:Str4;
begin
  Result := oBtrTable.FieldByName('ActYear').AsString;
end;

procedure TFxblstBtr.WriteActYear(pValue:Str4);
begin
  oBtrTable.FieldByName('ActYear').AsString := pValue;
end;

function TFxblstBtr.ReadDocQnt:longint;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsInteger;
end;

procedure TFxblstBtr.WriteDocQnt(pValue:longint);
begin
  oBtrTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TFxblstBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFxblstBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxblstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxblstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxblstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxblstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxblstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFxblstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxblstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxblstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxblstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxblstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TFxblstBtr.ReadMark:Str1;
begin
  Result := oBtrTable.FieldByName('Mark').AsString;
end;

procedure TFxblstBtr.WriteMark(pValue:Str1);
begin
  oBtrTable.FieldByName('Mark').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxblstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFxblstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFxblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFxblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFxblstBtr.LocateBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindKey([pBookNum]);
end;

function TFxblstBtr.LocateBookName (pBookName_:Str30):boolean;
begin
  SetIndex (ixBookName);
  Result := oBtrTable.FindKey([StrToAlias(pBookName_)]);
end;

function TFxblstBtr.NearestBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindNearest([pBookNum]);
end;

function TFxblstBtr.NearestBookName (pBookName_:Str30):boolean;
begin
  SetIndex (ixBookName);
  Result := oBtrTable.FindNearest([pBookName_]);
end;

procedure TFxblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFxblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFxblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFxblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFxblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFxblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TFxblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFxblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFxblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFxblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFxblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFxblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFxblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFxblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFxblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFxblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFxblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
