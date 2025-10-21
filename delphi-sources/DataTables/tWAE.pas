unit tWAE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixEpcName_ = 'EpcName_';

type
  TWaeTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadEpcName:Str30;         procedure WriteEpcName (pValue:Str30);
    function  ReadEpcName_:Str30;        procedure WriteEpcName_ (pValue:Str30);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadWcgNum:word;           procedure WriteWcgNum (pValue:word);
    function  ReadBasVal:double;         procedure WriteBasVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadPrmVal:double;         procedure WritePrmVal (pValue:double);
    function  ReadAddVal:double;         procedure WriteAddVal (pValue:double);
    function  ReadPenVal:double;         procedure WritePenVal (pValue:double);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateEpcName_ (pEpcName_:Str30):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property EpcName:Str30 read ReadEpcName write WriteEpcName;
    property EpcName_:Str30 read ReadEpcName_ write WriteEpcName_;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property WcgNum:word read ReadWcgNum write WriteWcgNum;
    property BasVal:double read ReadBasVal write WriteBasVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property PrmVal:double read ReadPrmVal write WritePrmVal;
    property AddVal:double read ReadAddVal write WriteAddVal;
    property PenVal:double read ReadPenVal write WritePenVal;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TWaeTmp.Create;
begin
  oTmpTable := TmpInit ('WAE',Self);
end;

destructor TWaeTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TWaeTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TWaeTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TWaeTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TWaeTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TWaeTmp.ReadEpcNum:word;
begin
  Result := oTmpTable.FieldByName('EpcNum').AsInteger;
end;

procedure TWaeTmp.WriteEpcNum(pValue:word);
begin
  oTmpTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TWaeTmp.ReadEpcName:Str30;
begin
  Result := oTmpTable.FieldByName('EpcName').AsString;
end;

procedure TWaeTmp.WriteEpcName(pValue:Str30);
begin
  oTmpTable.FieldByName('EpcName').AsString := pValue;
end;

function TWaeTmp.ReadEpcName_:Str30;
begin
  Result := oTmpTable.FieldByName('EpcName_').AsString;
end;

procedure TWaeTmp.WriteEpcName_(pValue:Str30);
begin
  oTmpTable.FieldByName('EpcName_').AsString := pValue;
end;

function TWaeTmp.ReadLogName:Str8;
begin
  Result := oTmpTable.FieldByName('LogName').AsString;
end;

procedure TWaeTmp.WriteLogName(pValue:Str8);
begin
  oTmpTable.FieldByName('LogName').AsString := pValue;
end;

function TWaeTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TWaeTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TWaeTmp.ReadTrmNum:word;
begin
  Result := oTmpTable.FieldByName('TrmNum').AsInteger;
end;

procedure TWaeTmp.WriteTrmNum(pValue:word);
begin
  oTmpTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TWaeTmp.ReadWcgNum:word;
begin
  Result := oTmpTable.FieldByName('WcgNum').AsInteger;
end;

procedure TWaeTmp.WriteWcgNum(pValue:word);
begin
  oTmpTable.FieldByName('WcgNum').AsInteger := pValue;
end;

function TWaeTmp.ReadBasVal:double;
begin
  Result := oTmpTable.FieldByName('BasVal').AsFloat;
end;

procedure TWaeTmp.WriteBasVal(pValue:double);
begin
  oTmpTable.FieldByName('BasVal').AsFloat := pValue;
end;

function TWaeTmp.ReadTrnVal:double;
begin
  Result := oTmpTable.FieldByName('TrnVal').AsFloat;
end;

procedure TWaeTmp.WriteTrnVal(pValue:double);
begin
  oTmpTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TWaeTmp.ReadPrmVal:double;
begin
  Result := oTmpTable.FieldByName('PrmVal').AsFloat;
end;

procedure TWaeTmp.WritePrmVal(pValue:double);
begin
  oTmpTable.FieldByName('PrmVal').AsFloat := pValue;
end;

function TWaeTmp.ReadAddVal:double;
begin
  Result := oTmpTable.FieldByName('AddVal').AsFloat;
end;

procedure TWaeTmp.WriteAddVal(pValue:double);
begin
  oTmpTable.FieldByName('AddVal').AsFloat := pValue;
end;

function TWaeTmp.ReadPenVal:double;
begin
  Result := oTmpTable.FieldByName('PenVal').AsFloat;
end;

procedure TWaeTmp.WritePenVal(pValue:double);
begin
  oTmpTable.FieldByName('PenVal').AsFloat := pValue;
end;

function TWaeTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TWaeTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TWaeTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TWaeTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TWaeTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TWaeTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWaeTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWaeTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWaeTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWaeTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWaeTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TWaeTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TWaeTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWaeTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWaeTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWaeTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWaeTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TWaeTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWaeTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TWaeTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TWaeTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TWaeTmp.LocateEpcName_ (pEpcName_:Str30):boolean;
begin
  SetIndex (ixEpcName_);
  Result := oTmpTable.FindKey([pEpcName_]);
end;

procedure TWaeTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TWaeTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TWaeTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TWaeTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TWaeTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TWaeTmp.First;
begin
  oTmpTable.First;
end;

procedure TWaeTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TWaeTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TWaeTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TWaeTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TWaeTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TWaeTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TWaeTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TWaeTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TWaeTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TWaeTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TWaeTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
