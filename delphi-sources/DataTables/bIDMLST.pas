unit bIDMLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIdmNum = 'IdmNum';
  ixIdmName = 'IdmName';
  ixSntAnl = 'SntAnl';

type
  TIdmlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadIdmNum:word;           procedure WriteIdmNum (pValue:word);
    function  ReadIdmName:Str30;         procedure WriteIdmName (pValue:Str30);
    function  ReadIdmName_:Str30;        procedure WriteIdmName_ (pValue:Str30);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadAccSide:Str1;          procedure WriteAccSide (pValue:Str1);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateIdmNum (pIdmNum:word):boolean;
    function LocateIdmName (pIdmName_:Str30):boolean;
    function LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearestIdmNum (pIdmNum:word):boolean;
    function NearestIdmName (pIdmName_:Str30):boolean;
    function NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property IdmNum:word read ReadIdmNum write WriteIdmNum;
    property IdmName:Str30 read ReadIdmName write WriteIdmName;
    property IdmName_:Str30 read ReadIdmName_ write WriteIdmName_;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property AccSide:Str1 read ReadAccSide write WriteAccSide;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIdmlstBtr.Create;
begin
  oBtrTable := BtrInit ('IDMLST',gPath.LdgPath,Self);
end;

constructor TIdmlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IDMLST',pPath,Self);
end;

destructor TIdmlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIdmlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIdmlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIdmlstBtr.ReadIdmNum:word;
begin
  Result := oBtrTable.FieldByName('IdmNum').AsInteger;
end;

procedure TIdmlstBtr.WriteIdmNum(pValue:word);
begin
  oBtrTable.FieldByName('IdmNum').AsInteger := pValue;
end;

function TIdmlstBtr.ReadIdmName:Str30;
begin
  Result := oBtrTable.FieldByName('IdmName').AsString;
end;

procedure TIdmlstBtr.WriteIdmName(pValue:Str30);
begin
  oBtrTable.FieldByName('IdmName').AsString := pValue;
end;

function TIdmlstBtr.ReadIdmName_:Str30;
begin
  Result := oBtrTable.FieldByName('IdmName_').AsString;
end;

procedure TIdmlstBtr.WriteIdmName_(pValue:Str30);
begin
  oBtrTable.FieldByName('IdmName_').AsString := pValue;
end;

function TIdmlstBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TIdmlstBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIdmlstBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TIdmlstBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIdmlstBtr.ReadAccSide:Str1;
begin
  Result := oBtrTable.FieldByName('AccSide').AsString;
end;

procedure TIdmlstBtr.WriteAccSide(pValue:Str1);
begin
  oBtrTable.FieldByName('AccSide').AsString := pValue;
end;

function TIdmlstBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIdmlstBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIdmlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIdmlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIdmlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIdmlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIdmlstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIdmlstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIdmlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIdmlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIdmlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIdmlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIdmlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIdmlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdmlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdmlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIdmlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdmlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIdmlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIdmlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIdmlstBtr.LocateIdmNum (pIdmNum:word):boolean;
begin
  SetIndex (ixIdmNum);
  Result := oBtrTable.FindKey([pIdmNum]);
end;

function TIdmlstBtr.LocateIdmName (pIdmName_:Str30):boolean;
begin
  SetIndex (ixIdmName);
  Result := oBtrTable.FindKey([StrToAlias(pIdmName_)]);
end;

function TIdmlstBtr.LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TIdmlstBtr.NearestIdmNum (pIdmNum:word):boolean;
begin
  SetIndex (ixIdmNum);
  Result := oBtrTable.FindNearest([pIdmNum]);
end;

function TIdmlstBtr.NearestIdmName (pIdmName_:Str30):boolean;
begin
  SetIndex (ixIdmName);
  Result := oBtrTable.FindNearest([pIdmName_]);
end;

function TIdmlstBtr.NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

procedure TIdmlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIdmlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TIdmlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIdmlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIdmlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIdmlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TIdmlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIdmlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIdmlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIdmlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIdmlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIdmlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIdmlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIdmlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIdmlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIdmlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIdmlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
