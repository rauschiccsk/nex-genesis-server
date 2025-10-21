unit bFXL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYear = 'Year';
  ixYeMo = 'YeMo';
  ixDocNum = 'DocNum';
  ixYeMoDo = 'YeMoDo';
  ixDoYeMo = 'DoYeMo';

type
  TFxlBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:word;             procedure WriteYear (pValue:word);
    function  ReadMounth:byte;           procedure WriteMounth (pValue:byte);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
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
    function LocateYeMo (pYear:word;pMounth:byte):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateYeMoDo (pYear:word;pMounth:byte;pDocNum:Str12):boolean;
    function LocateDoYeMo (pDocNum:Str12;pYear:word;pMounth:byte):boolean;
    function NearestYear (pYear:word):boolean;
    function NearestYeMo (pYear:word;pMounth:byte):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestYeMoDo (pYear:word;pMounth:byte;pDocNum:Str12):boolean;
    function NearestDoYeMo (pDocNum:Str12;pYear:word;pMounth:byte):boolean;

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
    property Year:word read ReadYear write WriteYear;
    property Mounth:byte read ReadMounth write WriteMounth;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
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

constructor TFxlBtr.Create;
begin
  oBtrTable := BtrInit ('FXL',gPath.LdgPath,Self);
end;

constructor TFxlBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FXL',pPath,Self);
end;

destructor TFxlBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFxlBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFxlBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFxlBtr.ReadYear:word;
begin
  Result := oBtrTable.FieldByName('Year').AsInteger;
end;

procedure TFxlBtr.WriteYear(pValue:word);
begin
  oBtrTable.FieldByName('Year').AsInteger := pValue;
end;

function TFxlBtr.ReadMounth:byte;
begin
  Result := oBtrTable.FieldByName('Mounth').AsInteger;
end;

procedure TFxlBtr.WriteMounth(pValue:byte);
begin
  oBtrTable.FieldByName('Mounth').AsInteger := pValue;
end;

function TFxlBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFxlBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFxlBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TFxlBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFxlBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TFxlBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFxlBtr.ReadChgVal:double;
begin
  Result := oBtrTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxlBtr.WriteChgVal(pValue:double);
begin
  oBtrTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxlBtr.ReadModVal:double;
begin
  Result := oBtrTable.FieldByName('ModVal').AsFloat;
end;

procedure TFxlBtr.WriteModVal(pValue:double);
begin
  oBtrTable.FieldByName('ModVal').AsFloat := pValue;
end;

function TFxlBtr.ReadSuPrc:double;
begin
  Result := oBtrTable.FieldByName('SuPrc').AsFloat;
end;

procedure TFxlBtr.WriteSuPrc(pValue:double);
begin
  oBtrTable.FieldByName('SuPrc').AsFloat := pValue;
end;

function TFxlBtr.ReadSuVal:double;
begin
  Result := oBtrTable.FieldByName('SuVal').AsFloat;
end;

procedure TFxlBtr.WriteSuVal(pValue:double);
begin
  oBtrTable.FieldByName('SuVal').AsFloat := pValue;
end;

function TFxlBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TFxlBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFxlBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TFxlBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TFxlBtr.ReadFxaGrp:longint;
begin
  Result := oBtrTable.FieldByName('FxaGrp').AsInteger;
end;

procedure TFxlBtr.WriteFxaGrp(pValue:longint);
begin
  oBtrTable.FieldByName('FxaGrp').AsInteger := pValue;
end;

function TFxlBtr.ReadAccDoc:Str12;
begin
  Result := oBtrTable.FieldByName('AccDoc').AsString;
end;

procedure TFxlBtr.WriteAccDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('AccDoc').AsString := pValue;
end;

function TFxlBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFxlBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxlBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxlBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxlBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxlBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxlBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFxlBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxlBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxlBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxlBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxlBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxlBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxlBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFxlBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxlBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFxlBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFxlBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFxlBtr.LocateYear (pYear:word):boolean;
begin
  SetIndex (ixYear);
  Result := oBtrTable.FindKey([pYear]);
end;

function TFxlBtr.LocateYeMo (pYear:word;pMounth:byte):boolean;
begin
  SetIndex (ixYeMo);
  Result := oBtrTable.FindKey([pYear,pMounth]);
end;

function TFxlBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TFxlBtr.LocateYeMoDo (pYear:word;pMounth:byte;pDocNum:Str12):boolean;
begin
  SetIndex (ixYeMoDo);
  Result := oBtrTable.FindKey([pYear,pMounth,pDocNum]);
end;

function TFxlBtr.LocateDoYeMo (pDocNum:Str12;pYear:word;pMounth:byte):boolean;
begin
  SetIndex (ixDoYeMo);
  Result := oBtrTable.FindKey([pDocNum,pYear,pMounth]);
end;

function TFxlBtr.NearestYear (pYear:word):boolean;
begin
  SetIndex (ixYear);
  Result := oBtrTable.FindNearest([pYear]);
end;

function TFxlBtr.NearestYeMo (pYear:word;pMounth:byte):boolean;
begin
  SetIndex (ixYeMo);
  Result := oBtrTable.FindNearest([pYear,pMounth]);
end;

function TFxlBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TFxlBtr.NearestYeMoDo (pYear:word;pMounth:byte;pDocNum:Str12):boolean;
begin
  SetIndex (ixYeMoDo);
  Result := oBtrTable.FindNearest([pYear,pMounth,pDocNum]);
end;

function TFxlBtr.NearestDoYeMo (pDocNum:Str12;pYear:word;pMounth:byte):boolean;
begin
  SetIndex (ixDoYeMo);
  Result := oBtrTable.FindNearest([pDocNum,pYear,pMounth]);
end;

procedure TFxlBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFxlBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TFxlBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFxlBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFxlBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFxlBtr.First;
begin
  oBtrTable.First;
end;

procedure TFxlBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFxlBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFxlBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFxlBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFxlBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFxlBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFxlBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFxlBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFxlBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFxlBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFxlBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
