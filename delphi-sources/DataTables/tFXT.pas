unit tFXT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYear = '';

type
  TFxtTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:word;             procedure WriteYear (pValue:word);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadChgVal:double;         procedure WriteChgVal (pValue:double);
    function  ReadModVal:double;         procedure WriteModVal (pValue:double);
    function  ReadSuPrc:double;          procedure WriteSuPrc (pValue:double);
    function  ReadSuVal:double;          procedure WriteSuVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadFxaGrp:longint;        procedure WriteFxaGrp (pValue:longint);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateYear (pYear:word):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property Year:word read ReadYear write WriteYear;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property ChgVal:double read ReadChgVal write WriteChgVal;
    property ModVal:double read ReadModVal write WriteModVal;
    property SuPrc:double read ReadSuPrc write WriteSuPrc;
    property SuVal:double read ReadSuVal write WriteSuVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property Status:Str1 read ReadStatus write WriteStatus;
    property FxaGrp:longint read ReadFxaGrp write WriteFxaGrp;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TFxtTmp.Create;
begin
  oTmpTable := TmpInit ('FXT',Self);
end;

destructor TFxtTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFxtTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFxtTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFxtTmp.ReadYear:word;
begin
  Result := oTmpTable.FieldByName('Year').AsInteger;
end;

procedure TFxtTmp.WriteYear(pValue:word);
begin
  oTmpTable.FieldByName('Year').AsInteger := pValue;
end;

function TFxtTmp.ReadBegVal:double;
begin
  Result := oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TFxtTmp.WriteBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFxtTmp.ReadChgVal:double;
begin
  Result := oTmpTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxtTmp.WriteChgVal(pValue:double);
begin
  oTmpTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxtTmp.ReadModVal:double;
begin
  Result := oTmpTable.FieldByName('ModVal').AsFloat;
end;

procedure TFxtTmp.WriteModVal(pValue:double);
begin
  oTmpTable.FieldByName('ModVal').AsFloat := pValue;
end;

function TFxtTmp.ReadSuPrc:double;
begin
  Result := oTmpTable.FieldByName('SuPrc').AsFloat;
end;

procedure TFxtTmp.WriteSuPrc(pValue:double);
begin
  oTmpTable.FieldByName('SuPrc').AsFloat := pValue;
end;

function TFxtTmp.ReadSuVal:double;
begin
  Result := oTmpTable.FieldByName('SuVal').AsFloat;
end;

procedure TFxtTmp.WriteSuVal(pValue:double);
begin
  oTmpTable.FieldByName('SuVal').AsFloat := pValue;
end;

function TFxtTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TFxtTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFxtTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TFxtTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TFxtTmp.ReadFxaGrp:longint;
begin
  Result := oTmpTable.FieldByName('FxaGrp').AsInteger;
end;

procedure TFxtTmp.WriteFxaGrp(pValue:longint);
begin
  oTmpTable.FieldByName('FxaGrp').AsInteger := pValue;
end;

function TFxtTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TFxtTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxtTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxtTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxtTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxtTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TFxtTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TFxtTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxtTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFxtTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFxtTmp.LocateYear (pYear:word):boolean;
begin
  SetIndex (ixYear);
  Result := oTmpTable.FindKey([pYear]);
end;

procedure TFxtTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFxtTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFxtTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFxtTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFxtTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFxtTmp.First;
begin
  oTmpTable.First;
end;

procedure TFxtTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFxtTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFxtTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFxtTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFxtTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFxtTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFxtTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFxtTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFxtTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFxtTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFxtTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
