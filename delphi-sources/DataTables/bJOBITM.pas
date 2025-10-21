unit bJOBITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn = 'DnIn';
  ixDocNum = 'DocNum';
  ixSubject = 'Subject';

type
  TJobitmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadSubject:Str90;         procedure WriteSubject (pValue:Str90);
    function  ReadSubject_:Str90;        procedure WriteSubject_ (pValue:Str90);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadTrmDate:TDatetime;     procedure WriteTrmDate (pValue:TDatetime);
    function  ReadTrmTime:TDatetime;     procedure WriteTrmTime (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadRspNum:word;           procedure WriteRspNum (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadJobStat:Str1;          procedure WriteJobStat (pValue:Str1);
    function  ReadResStat:Str1;          procedure WriteResStat (pValue:Str1);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadWaValue:double;        procedure WriteWaValue (pValue:double);
    function  ReadOwValue:double;        procedure WriteOwValue (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSubject (pSubject_:Str90):boolean;
    function NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestSubject (pSubject_:Str90):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property Subject:Str90 read ReadSubject write WriteSubject;
    property Subject_:Str90 read ReadSubject_ write WriteSubject_;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property TrmDate:TDatetime read ReadTrmDate write WriteTrmDate;
    property TrmTime:TDatetime read ReadTrmTime write WriteTrmTime;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property RspNum:word read ReadRspNum write WriteRspNum;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property JobStat:Str1 read ReadJobStat write WriteJobStat;
    property ResStat:Str1 read ReadResStat write WriteResStat;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property WaValue:double read ReadWaValue write WriteWaValue;
    property OwValue:double read ReadOwValue write WriteOwValue;
  end;

implementation

constructor TJobitmBtr.Create;
begin
  oBtrTable := BtrInit ('JOBITM',gPath.DlsPath,Self);
end;

constructor TJobitmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('JOBITM',pPath,Self);
end;

destructor TJobitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TJobitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TJobitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TJobitmBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TJobitmBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TJobitmBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJobitmBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJobitmBtr.ReadSubject:Str90;
begin
  Result := oBtrTable.FieldByName('Subject').AsString;
end;

procedure TJobitmBtr.WriteSubject(pValue:Str90);
begin
  oBtrTable.FieldByName('Subject').AsString := pValue;
end;

function TJobitmBtr.ReadSubject_:Str90;
begin
  Result := oBtrTable.FieldByName('Subject_').AsString;
end;

procedure TJobitmBtr.WriteSubject_(pValue:Str90);
begin
  oBtrTable.FieldByName('Subject_').AsString := pValue;
end;

function TJobitmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJobitmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJobitmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJobitmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJobitmBtr.ReadTrmDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrmDate').AsDateTime;
end;

procedure TJobitmBtr.WriteTrmDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrmDate').AsDateTime := pValue;
end;

function TJobitmBtr.ReadTrmTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrmTime').AsDateTime;
end;

procedure TJobitmBtr.WriteTrmTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrmTime').AsDateTime := pValue;
end;

function TJobitmBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TJobitmBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TJobitmBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TJobitmBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TJobitmBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TJobitmBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TJobitmBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TJobitmBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TJobitmBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TJobitmBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TJobitmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TJobitmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TJobitmBtr.ReadRspNum:word;
begin
  Result := oBtrTable.FieldByName('RspNum').AsInteger;
end;

procedure TJobitmBtr.WriteRspNum(pValue:word);
begin
  oBtrTable.FieldByName('RspNum').AsInteger := pValue;
end;

function TJobitmBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TJobitmBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TJobitmBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TJobitmBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TJobitmBtr.ReadJobStat:Str1;
begin
  Result := oBtrTable.FieldByName('JobStat').AsString;
end;

procedure TJobitmBtr.WriteJobStat(pValue:Str1);
begin
  oBtrTable.FieldByName('JobStat').AsString := pValue;
end;

function TJobitmBtr.ReadResStat:Str1;
begin
  Result := oBtrTable.FieldByName('ResStat').AsString;
end;

procedure TJobitmBtr.WriteResStat(pValue:Str1);
begin
  oBtrTable.FieldByName('ResStat').AsString := pValue;
end;

function TJobitmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TJobitmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TJobitmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJobitmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJobitmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJobitmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJobitmBtr.ReadWaValue:double;
begin
  Result := oBtrTable.FieldByName('WaValue').AsFloat;
end;

procedure TJobitmBtr.WriteWaValue(pValue:double);
begin
  oBtrTable.FieldByName('WaValue').AsFloat := pValue;
end;

function TJobitmBtr.ReadOwValue:double;
begin
  Result := oBtrTable.FieldByName('OwValue').AsFloat;
end;

procedure TJobitmBtr.WriteOwValue(pValue:double);
begin
  oBtrTable.FieldByName('OwValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobitmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TJobitmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TJobitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TJobitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TJobitmBtr.LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TJobitmBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TJobitmBtr.LocateSubject (pSubject_:Str90):boolean;
begin
  SetIndex (ixSubject);
  Result := oBtrTable.FindKey([StrToAlias(pSubject_)]);
end;

function TJobitmBtr.NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TJobitmBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TJobitmBtr.NearestSubject (pSubject_:Str90):boolean;
begin
  SetIndex (ixSubject);
  Result := oBtrTable.FindNearest([pSubject_]);
end;

procedure TJobitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TJobitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TJobitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TJobitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TJobitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TJobitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TJobitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TJobitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TJobitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TJobitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TJobitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TJobitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TJobitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TJobitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TJobitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TJobitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TJobitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
