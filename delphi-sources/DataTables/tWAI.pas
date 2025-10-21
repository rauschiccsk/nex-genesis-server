unit tWAI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixEcEg = 'EcEg';

type
  TWaiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadEpgNum:word;           procedure WriteEpgNum (pValue:word);
    function  ReadWpsCode:word;          procedure WriteWpsCode (pValue:word);
    function  ReadWpsName:Str120;        procedure WriteWpsName (pValue:Str120);
    function  ReadWpsPrc:double;         procedure WriteWpsPrc (pValue:double);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadValType:Str1;          procedure WriteValType (pValue:Str1);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadItmSrc:Str2;           procedure WriteItmSrc (pValue:Str2);
    function  ReadBasVal:double;         procedure WriteBasVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadPrmVal:double;         procedure WritePrmVal (pValue:double);
    function  ReadAddVal:double;         procedure WriteAddVal (pValue:double);
    function  ReadPenVal:double;         procedure WritePenVal (pValue:double);
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
    function LocateEcEg (pEpcNum:word;pEpgNum:word):boolean;

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
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property EpgNum:word read ReadEpgNum write WriteEpgNum;
    property WpsCode:word read ReadWpsCode write WriteWpsCode;
    property WpsName:Str120 read ReadWpsName write WriteWpsName;
    property WpsPrc:double read ReadWpsPrc write WriteWpsPrc;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property ValType:Str1 read ReadValType write WriteValType;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property ItmSrc:Str2 read ReadItmSrc write WriteItmSrc;
    property BasVal:double read ReadBasVal write WriteBasVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property PrmVal:double read ReadPrmVal write WritePrmVal;
    property AddVal:double read ReadAddVal write WriteAddVal;
    property PenVal:double read ReadPenVal write WritePenVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TWaiTmp.Create;
begin
  oTmpTable := TmpInit ('WAI',Self);
end;

destructor TWaiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TWaiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TWaiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TWaiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TWaiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TWaiTmp.ReadEpcNum:word;
begin
  Result := oTmpTable.FieldByName('EpcNum').AsInteger;
end;

procedure TWaiTmp.WriteEpcNum(pValue:word);
begin
  oTmpTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TWaiTmp.ReadEpgNum:word;
begin
  Result := oTmpTable.FieldByName('EpgNum').AsInteger;
end;

procedure TWaiTmp.WriteEpgNum(pValue:word);
begin
  oTmpTable.FieldByName('EpgNum').AsInteger := pValue;
end;

function TWaiTmp.ReadWpsCode:word;
begin
  Result := oTmpTable.FieldByName('WpsCode').AsInteger;
end;

procedure TWaiTmp.WriteWpsCode(pValue:word);
begin
  oTmpTable.FieldByName('WpsCode').AsInteger := pValue;
end;

function TWaiTmp.ReadWpsName:Str120;
begin
  Result := oTmpTable.FieldByName('WpsName').AsString;
end;

procedure TWaiTmp.WriteWpsName(pValue:Str120);
begin
  oTmpTable.FieldByName('WpsName').AsString := pValue;
end;

function TWaiTmp.ReadWpsPrc:double;
begin
  Result := oTmpTable.FieldByName('WpsPrc').AsFloat;
end;

procedure TWaiTmp.WriteWpsPrc(pValue:double);
begin
  oTmpTable.FieldByName('WpsPrc').AsFloat := pValue;
end;

function TWaiTmp.ReadItmType:Str1;
begin
  Result := oTmpTable.FieldByName('ItmType').AsString;
end;

procedure TWaiTmp.WriteItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmType').AsString := pValue;
end;

function TWaiTmp.ReadValType:Str1;
begin
  Result := oTmpTable.FieldByName('ValType').AsString;
end;

procedure TWaiTmp.WriteValType(pValue:Str1);
begin
  oTmpTable.FieldByName('ValType').AsString := pValue;
end;

function TWaiTmp.ReadLogName:Str8;
begin
  Result := oTmpTable.FieldByName('LogName').AsString;
end;

procedure TWaiTmp.WriteLogName(pValue:Str8);
begin
  oTmpTable.FieldByName('LogName').AsString := pValue;
end;

function TWaiTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TWaiTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TWaiTmp.ReadTrmNum:word;
begin
  Result := oTmpTable.FieldByName('TrmNum').AsInteger;
end;

procedure TWaiTmp.WriteTrmNum(pValue:word);
begin
  oTmpTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TWaiTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TWaiTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TWaiTmp.ReadItmSrc:Str2;
begin
  Result := oTmpTable.FieldByName('ItmSrc').AsString;
end;

procedure TWaiTmp.WriteItmSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('ItmSrc').AsString := pValue;
end;

function TWaiTmp.ReadBasVal:double;
begin
  Result := oTmpTable.FieldByName('BasVal').AsFloat;
end;

procedure TWaiTmp.WriteBasVal(pValue:double);
begin
  oTmpTable.FieldByName('BasVal').AsFloat := pValue;
end;

function TWaiTmp.ReadTrnVal:double;
begin
  Result := oTmpTable.FieldByName('TrnVal').AsFloat;
end;

procedure TWaiTmp.WriteTrnVal(pValue:double);
begin
  oTmpTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TWaiTmp.ReadPrmVal:double;
begin
  Result := oTmpTable.FieldByName('PrmVal').AsFloat;
end;

procedure TWaiTmp.WritePrmVal(pValue:double);
begin
  oTmpTable.FieldByName('PrmVal').AsFloat := pValue;
end;

function TWaiTmp.ReadAddVal:double;
begin
  Result := oTmpTable.FieldByName('AddVal').AsFloat;
end;

procedure TWaiTmp.WriteAddVal(pValue:double);
begin
  oTmpTable.FieldByName('AddVal').AsFloat := pValue;
end;

function TWaiTmp.ReadPenVal:double;
begin
  Result := oTmpTable.FieldByName('PenVal').AsFloat;
end;

procedure TWaiTmp.WritePenVal(pValue:double);
begin
  oTmpTable.FieldByName('PenVal').AsFloat := pValue;
end;

function TWaiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TWaiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWaiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWaiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWaiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWaiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWaiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TWaiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TWaiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWaiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWaiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWaiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWaiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TWaiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWaiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TWaiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TWaiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TWaiTmp.LocateEcEg (pEpcNum:word;pEpgNum:word):boolean;
begin
  SetIndex (ixEcEg);
  Result := oTmpTable.FindKey([pEpcNum,pEpgNum]);
end;

procedure TWaiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TWaiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TWaiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TWaiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TWaiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TWaiTmp.First;
begin
  oTmpTable.First;
end;

procedure TWaiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TWaiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TWaiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TWaiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TWaiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TWaiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TWaiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TWaiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TWaiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TWaiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TWaiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
