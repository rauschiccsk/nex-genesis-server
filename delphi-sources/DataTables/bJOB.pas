unit bJOB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixSubject = 'Subject';
  ixDocStat = 'DocStat';

type
  TJobBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSubject:Str90;         procedure WriteSubject (pValue:Str90);
    function  ReadSubject_:Str90;        procedure WriteSubject_ (pValue:Str90);
    function  ReadRegEpcn:word;          procedure WriteRegEpcn (pValue:word);
    function  ReadRegUser:Str8;          procedure WriteRegUser (pValue:Str8);
    function  ReadRegName:Str30;         procedure WriteRegName (pValue:Str30);
    function  ReadRegDate:TDatetime;     procedure WriteRegDate (pValue:TDatetime);
    function  ReadRegTime:TDatetime;     procedure WriteRegTime (pValue:TDatetime);
    function  ReadTrmDate:TDatetime;     procedure WriteTrmDate (pValue:TDatetime);
    function  ReadTrmTime:TDatetime;     procedure WriteTrmTime (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadRspEpcn:word;          procedure WriteRspEpcn (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadPriorit:byte;          procedure WritePriorit (pValue:byte);
    function  ReadDocStat:Str1;          procedure WriteDocStat (pValue:Str1);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSubject (pSubject_:Str90):boolean;
    function LocateDocStat (pDocStat:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestSubject (pSubject_:Str90):boolean;
    function NearestDocStat (pDocStat:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property Subject:Str90 read ReadSubject write WriteSubject;
    property Subject_:Str90 read ReadSubject_ write WriteSubject_;
    property RegEpcn:word read ReadRegEpcn write WriteRegEpcn;
    property RegUser:Str8 read ReadRegUser write WriteRegUser;
    property RegName:Str30 read ReadRegName write WriteRegName;
    property RegDate:TDatetime read ReadRegDate write WriteRegDate;
    property RegTime:TDatetime read ReadRegTime write WriteRegTime;
    property TrmDate:TDatetime read ReadTrmDate write WriteTrmDate;
    property TrmTime:TDatetime read ReadTrmTime write WriteTrmTime;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property RspEpcn:word read ReadRspEpcn write WriteRspEpcn;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property Priorit:byte read ReadPriorit write WritePriorit;
    property DocStat:Str1 read ReadDocStat write WriteDocStat;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property WaValue:double read ReadWaValue write WriteWaValue;
    property OwValue:double read ReadOwValue write WriteOwValue;
  end;

implementation

constructor TJobBtr.Create;
begin
  oBtrTable := BtrInit ('JOB',gPath.DlsPath,Self);
end;

constructor TJobBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('JOB',pPath,Self);
end;

destructor TJobBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TJobBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TJobBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TJobBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TJobBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TJobBtr.ReadSubject:Str90;
begin
  Result := oBtrTable.FieldByName('Subject').AsString;
end;

procedure TJobBtr.WriteSubject(pValue:Str90);
begin
  oBtrTable.FieldByName('Subject').AsString := pValue;
end;

function TJobBtr.ReadSubject_:Str90;
begin
  Result := oBtrTable.FieldByName('Subject_').AsString;
end;

procedure TJobBtr.WriteSubject_(pValue:Str90);
begin
  oBtrTable.FieldByName('Subject_').AsString := pValue;
end;

function TJobBtr.ReadRegEpcn:word;
begin
  Result := oBtrTable.FieldByName('RegEpcn').AsInteger;
end;

procedure TJobBtr.WriteRegEpcn(pValue:word);
begin
  oBtrTable.FieldByName('RegEpcn').AsInteger := pValue;
end;

function TJobBtr.ReadRegUser:Str8;
begin
  Result := oBtrTable.FieldByName('RegUser').AsString;
end;

procedure TJobBtr.WriteRegUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RegUser').AsString := pValue;
end;

function TJobBtr.ReadRegName:Str30;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TJobBtr.WriteRegName(pValue:Str30);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TJobBtr.ReadRegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RegDate').AsDateTime;
end;

procedure TJobBtr.WriteRegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RegDate').AsDateTime := pValue;
end;

function TJobBtr.ReadRegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('RegTime').AsDateTime;
end;

procedure TJobBtr.WriteRegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RegTime').AsDateTime := pValue;
end;

function TJobBtr.ReadTrmDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrmDate').AsDateTime;
end;

procedure TJobBtr.WriteTrmDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrmDate').AsDateTime := pValue;
end;

function TJobBtr.ReadTrmTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrmTime').AsDateTime;
end;

procedure TJobBtr.WriteTrmTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrmTime').AsDateTime := pValue;
end;

function TJobBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TJobBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TJobBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TJobBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TJobBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TJobBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TJobBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TJobBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TJobBtr.ReadRspEpcn:word;
begin
  Result := oBtrTable.FieldByName('RspEpcn').AsInteger;
end;

procedure TJobBtr.WriteRspEpcn(pValue:word);
begin
  oBtrTable.FieldByName('RspEpcn').AsInteger := pValue;
end;

function TJobBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TJobBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TJobBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TJobBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TJobBtr.ReadPriorit:byte;
begin
  Result := oBtrTable.FieldByName('Priorit').AsInteger;
end;

procedure TJobBtr.WritePriorit(pValue:byte);
begin
  oBtrTable.FieldByName('Priorit').AsInteger := pValue;
end;

function TJobBtr.ReadDocStat:Str1;
begin
  Result := oBtrTable.FieldByName('DocStat').AsString;
end;

procedure TJobBtr.WriteDocStat(pValue:Str1);
begin
  oBtrTable.FieldByName('DocStat').AsString := pValue;
end;

function TJobBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TJobBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TJobBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJobBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJobBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJobBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJobBtr.ReadWaValue:double;
begin
  Result := oBtrTable.FieldByName('WaValue').AsFloat;
end;

procedure TJobBtr.WriteWaValue(pValue:double);
begin
  oBtrTable.FieldByName('WaValue').AsFloat := pValue;
end;

function TJobBtr.ReadOwValue:double;
begin
  Result := oBtrTable.FieldByName('OwValue').AsFloat;
end;

procedure TJobBtr.WriteOwValue(pValue:double);
begin
  oBtrTable.FieldByName('OwValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TJobBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TJobBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TJobBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TJobBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TJobBtr.LocateSubject (pSubject_:Str90):boolean;
begin
  SetIndex (ixSubject);
  Result := oBtrTable.FindKey([StrToAlias(pSubject_)]);
end;

function TJobBtr.LocateDocStat (pDocStat:Str1):boolean;
begin
  SetIndex (ixDocStat);
  Result := oBtrTable.FindKey([pDocStat]);
end;

function TJobBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TJobBtr.NearestSubject (pSubject_:Str90):boolean;
begin
  SetIndex (ixSubject);
  Result := oBtrTable.FindNearest([pSubject_]);
end;

function TJobBtr.NearestDocStat (pDocStat:Str1):boolean;
begin
  SetIndex (ixDocStat);
  Result := oBtrTable.FindNearest([pDocStat]);
end;

procedure TJobBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TJobBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TJobBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TJobBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TJobBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TJobBtr.First;
begin
  oBtrTable.First;
end;

procedure TJobBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TJobBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TJobBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TJobBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TJobBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TJobBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TJobBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TJobBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TJobBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TJobBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TJobBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
