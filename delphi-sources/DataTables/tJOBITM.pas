unit tJOBITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixSubject_ = 'Subject_';

type
  TJobitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateSubject_ (pSubject_:Str90):boolean;

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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TJobitmTmp.Create;
begin
  oTmpTable := TmpInit ('JOBITM',Self);
end;

destructor TJobitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TJobitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TJobitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TJobitmTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJobitmTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJobitmTmp.ReadSubject:Str90;
begin
  Result := oTmpTable.FieldByName('Subject').AsString;
end;

procedure TJobitmTmp.WriteSubject(pValue:Str90);
begin
  oTmpTable.FieldByName('Subject').AsString := pValue;
end;

function TJobitmTmp.ReadSubject_:Str90;
begin
  Result := oTmpTable.FieldByName('Subject_').AsString;
end;

procedure TJobitmTmp.WriteSubject_(pValue:Str90);
begin
  oTmpTable.FieldByName('Subject_').AsString := pValue;
end;

function TJobitmTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJobitmTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJobitmTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJobitmTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJobitmTmp.ReadTrmDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TrmDate').AsDateTime;
end;

procedure TJobitmTmp.WriteTrmDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrmDate').AsDateTime := pValue;
end;

function TJobitmTmp.ReadTrmTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TrmTime').AsDateTime;
end;

procedure TJobitmTmp.WriteTrmTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrmTime').AsDateTime := pValue;
end;

function TJobitmTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TJobitmTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TJobitmTmp.ReadBegTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegTime').AsDateTime;
end;

procedure TJobitmTmp.WriteBegTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TJobitmTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TJobitmTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TJobitmTmp.ReadEndTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndTime').AsDateTime;
end;

procedure TJobitmTmp.WriteEndTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TJobitmTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TJobitmTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TJobitmTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TJobitmTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TJobitmTmp.ReadRspNum:word;
begin
  Result := oTmpTable.FieldByName('RspNum').AsInteger;
end;

procedure TJobitmTmp.WriteRspNum(pValue:word);
begin
  oTmpTable.FieldByName('RspNum').AsInteger := pValue;
end;

function TJobitmTmp.ReadRspUser:Str8;
begin
  Result := oTmpTable.FieldByName('RspUser').AsString;
end;

procedure TJobitmTmp.WriteRspUser(pValue:Str8);
begin
  oTmpTable.FieldByName('RspUser').AsString := pValue;
end;

function TJobitmTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TJobitmTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TJobitmTmp.ReadJobStat:Str1;
begin
  Result := oTmpTable.FieldByName('JobStat').AsString;
end;

procedure TJobitmTmp.WriteJobStat(pValue:Str1);
begin
  oTmpTable.FieldByName('JobStat').AsString := pValue;
end;

function TJobitmTmp.ReadResStat:Str1;
begin
  Result := oTmpTable.FieldByName('ResStat').AsString;
end;

procedure TJobitmTmp.WriteResStat(pValue:Str1);
begin
  oTmpTable.FieldByName('ResStat').AsString := pValue;
end;

function TJobitmTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TJobitmTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TJobitmTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJobitmTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJobitmTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJobitmTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJobitmTmp.ReadWaValue:double;
begin
  Result := oTmpTable.FieldByName('WaValue').AsFloat;
end;

procedure TJobitmTmp.WriteWaValue(pValue:double);
begin
  oTmpTable.FieldByName('WaValue').AsFloat := pValue;
end;

function TJobitmTmp.ReadOwValue:double;
begin
  Result := oTmpTable.FieldByName('OwValue').AsFloat;
end;

procedure TJobitmTmp.WriteOwValue(pValue:double);
begin
  oTmpTable.FieldByName('OwValue').AsFloat := pValue;
end;

function TJobitmTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TJobitmTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TJobitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TJobitmTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TJobitmTmp.LocateSubject_ (pSubject_:Str90):boolean;
begin
  SetIndex (ixSubject_);
  Result := oTmpTable.FindKey([pSubject_]);
end;

procedure TJobitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TJobitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TJobitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TJobitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TJobitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TJobitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TJobitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TJobitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TJobitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TJobitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TJobitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TJobitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TJobitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TJobitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TJobitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TJobitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TJobitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
