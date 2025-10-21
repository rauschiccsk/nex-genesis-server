unit bFXT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYear = 'Year';
  ixDocNum = 'DocNum';
  ixDoYe = 'DoYe';

type
  TFxtBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadYear:word;             procedure WriteYear (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadChgVal:double;         procedure WriteChgVal (pValue:double);
    function  ReadModVal:double;         procedure WriteModVal (pValue:double);
    function  ReadSuPrc:double;          procedure WriteSuPrc (pValue:double);
    function  ReadSuVal:double;          procedure WriteSuVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadFxaGrp:longint;        procedure WriteFxaGrp (pValue:longint);
    function  ReadAccDoc:Str12;          procedure WriteAccDoc (pValue:Str12);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
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
    function LocateYear (pYear:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoYe (pDocNum:Str12;pYear:word):boolean;
    function NearestYear (pYear:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoYe (pDocNum:Str12;pYear:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property Year:word read ReadYear write WriteYear;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property ChgVal:double read ReadChgVal write WriteChgVal;
    property ModVal:double read ReadModVal write WriteModVal;
    property SuPrc:double read ReadSuPrc write WriteSuPrc;
    property SuVal:double read ReadSuVal write WriteSuVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property Status:Str1 read ReadStatus write WriteStatus;
    property FxaGrp:longint read ReadFxaGrp write WriteFxaGrp;
    property AccDoc:Str12 read ReadAccDoc write WriteAccDoc;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TFxtBtr.Create;
begin
  oBtrTable := BtrInit ('FXT',gPath.LdgPath,Self);
end;

constructor TFxtBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FXT',pPath,Self);
end;

destructor TFxtBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFxtBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFxtBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFxtBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFxtBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFxtBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFxtBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFxtBtr.ReadYear:word;
begin
  Result := oBtrTable.FieldByName('Year').AsInteger;
end;

procedure TFxtBtr.WriteYear(pValue:word);
begin
  oBtrTable.FieldByName('Year').AsInteger := pValue;
end;

function TFxtBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TFxtBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFxtBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TFxtBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFxtBtr.ReadChgVal:double;
begin
  Result := oBtrTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxtBtr.WriteChgVal(pValue:double);
begin
  oBtrTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxtBtr.ReadModVal:double;
begin
  Result := oBtrTable.FieldByName('ModVal').AsFloat;
end;

procedure TFxtBtr.WriteModVal(pValue:double);
begin
  oBtrTable.FieldByName('ModVal').AsFloat := pValue;
end;

function TFxtBtr.ReadSuPrc:double;
begin
  Result := oBtrTable.FieldByName('SuPrc').AsFloat;
end;

procedure TFxtBtr.WriteSuPrc(pValue:double);
begin
  oBtrTable.FieldByName('SuPrc').AsFloat := pValue;
end;

function TFxtBtr.ReadSuVal:double;
begin
  Result := oBtrTable.FieldByName('SuVal').AsFloat;
end;

procedure TFxtBtr.WriteSuVal(pValue:double);
begin
  oBtrTable.FieldByName('SuVal').AsFloat := pValue;
end;

function TFxtBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TFxtBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFxtBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TFxtBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TFxtBtr.ReadFxaGrp:longint;
begin
  Result := oBtrTable.FieldByName('FxaGrp').AsInteger;
end;

procedure TFxtBtr.WriteFxaGrp(pValue:longint);
begin
  oBtrTable.FieldByName('FxaGrp').AsInteger := pValue;
end;

function TFxtBtr.ReadAccDoc:Str12;
begin
  Result := oBtrTable.FieldByName('AccDoc').AsString;
end;

procedure TFxtBtr.WriteAccDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('AccDoc').AsString := pValue;
end;

function TFxtBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFxtBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxtBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxtBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxtBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxtBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxtBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFxtBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxtBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxtBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxtBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxtBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxtBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxtBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFxtBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxtBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFxtBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFxtBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFxtBtr.LocateYear (pYear:word):boolean;
begin
  SetIndex (ixYear);
  Result := oBtrTable.FindKey([pYear]);
end;

function TFxtBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TFxtBtr.LocateDoYe (pDocNum:Str12;pYear:word):boolean;
begin
  SetIndex (ixDoYe);
  Result := oBtrTable.FindKey([pDocNum,pYear]);
end;

function TFxtBtr.NearestYear (pYear:word):boolean;
begin
  SetIndex (ixYear);
  Result := oBtrTable.FindNearest([pYear]);
end;

function TFxtBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TFxtBtr.NearestDoYe (pDocNum:Str12;pYear:word):boolean;
begin
  SetIndex (ixDoYe);
  Result := oBtrTable.FindNearest([pDocNum,pYear]);
end;

procedure TFxtBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFxtBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TFxtBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFxtBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFxtBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFxtBtr.First;
begin
  oBtrTable.First;
end;

procedure TFxtBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFxtBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFxtBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFxtBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFxtBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFxtBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFxtBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFxtBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFxtBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFxtBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFxtBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
