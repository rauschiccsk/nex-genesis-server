unit tFXL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYeMt = '';

type
  TFxlTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:word;             procedure WriteYear (pValue:word);
    function  ReadMounth:byte;           procedure WriteMounth (pValue:byte);
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
    function LocateYeMt (pYear:word;pMounth:byte):boolean;

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
    property Mounth:byte read ReadMounth write WriteMounth;
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

constructor TFxlTmp.Create;
begin
  oTmpTable := TmpInit ('FXL',Self);
end;

destructor TFxlTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFxlTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFxlTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFxlTmp.ReadYear:word;
begin
  Result := oTmpTable.FieldByName('Year').AsInteger;
end;

procedure TFxlTmp.WriteYear(pValue:word);
begin
  oTmpTable.FieldByName('Year').AsInteger := pValue;
end;

function TFxlTmp.ReadMounth:byte;
begin
  Result := oTmpTable.FieldByName('Mounth').AsInteger;
end;

procedure TFxlTmp.WriteMounth(pValue:byte);
begin
  oTmpTable.FieldByName('Mounth').AsInteger := pValue;
end;

function TFxlTmp.ReadBegVal:double;
begin
  Result := oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TFxlTmp.WriteBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFxlTmp.ReadChgVal:double;
begin
  Result := oTmpTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxlTmp.WriteChgVal(pValue:double);
begin
  oTmpTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxlTmp.ReadModVal:double;
begin
  Result := oTmpTable.FieldByName('ModVal').AsFloat;
end;

procedure TFxlTmp.WriteModVal(pValue:double);
begin
  oTmpTable.FieldByName('ModVal').AsFloat := pValue;
end;

function TFxlTmp.ReadSuPrc:double;
begin
  Result := oTmpTable.FieldByName('SuPrc').AsFloat;
end;

procedure TFxlTmp.WriteSuPrc(pValue:double);
begin
  oTmpTable.FieldByName('SuPrc').AsFloat := pValue;
end;

function TFxlTmp.ReadSuVal:double;
begin
  Result := oTmpTable.FieldByName('SuVal').AsFloat;
end;

procedure TFxlTmp.WriteSuVal(pValue:double);
begin
  oTmpTable.FieldByName('SuVal').AsFloat := pValue;
end;

function TFxlTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TFxlTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFxlTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TFxlTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TFxlTmp.ReadFxaGrp:longint;
begin
  Result := oTmpTable.FieldByName('FxaGrp').AsInteger;
end;

procedure TFxlTmp.WriteFxaGrp(pValue:longint);
begin
  oTmpTable.FieldByName('FxaGrp').AsInteger := pValue;
end;

function TFxlTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TFxlTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxlTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxlTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxlTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxlTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TFxlTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TFxlTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxlTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFxlTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFxlTmp.LocateYeMt (pYear:word;pMounth:byte):boolean;
begin
  SetIndex (ixYeMt);
  Result := oTmpTable.FindKey([pYear,pMounth]);
end;

procedure TFxlTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFxlTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFxlTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFxlTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFxlTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFxlTmp.First;
begin
  oTmpTable.First;
end;

procedure TFxlTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFxlTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFxlTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFxlTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFxlTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFxlTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFxlTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFxlTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFxlTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFxlTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFxlTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
