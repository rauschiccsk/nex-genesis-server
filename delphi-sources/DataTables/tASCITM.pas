unit tASCITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixDocType = 'DocType';
  ixDocDate = 'DocDate';
  ixExpDate = 'ExpDate';
  ixPaName_ = 'PaName_';
  ixExdQnt = 'ExdQnt';

type
  TAscitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocType:Str2;          procedure WriteDocType (pValue:Str2);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadAcValue:double;        procedure WriteAcValue (pValue:double);
    function  ReadFgValue:double;        procedure WriteFgValue (pValue:double);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadBfdQnt:longint;        procedure WriteBfdQnt (pValue:longint);
    function  ReadExdQnt:longint;        procedure WriteExdQnt (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocType (pDocType:Str2):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateExdQnt (pExdQnt:longint):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocType:Str2 read ReadDocType write WriteDocType;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property AcValue:double read ReadAcValue write WriteAcValue;
    property FgValue:double read ReadFgValue write WriteFgValue;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property BfdQnt:longint read ReadBfdQnt write WriteBfdQnt;
    property ExdQnt:longint read ReadExdQnt write WriteExdQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TAscitmTmp.Create;
begin
  oTmpTable := TmpInit ('ASCITM',Self);
end;

destructor TAscitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAscitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAscitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAscitmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAscitmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAscitmTmp.ReadDocType:Str2;
begin
  Result := oTmpTable.FieldByName('DocType').AsString;
end;

procedure TAscitmTmp.WriteDocType(pValue:Str2);
begin
  oTmpTable.FieldByName('DocType').AsString := pValue;
end;

function TAscitmTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAscitmTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAscitmTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAscitmTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAscitmTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAscitmTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAscitmTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAscitmTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TAscitmTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TAscitmTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TAscitmTmp.ReadAcValue:double;
begin
  Result := oTmpTable.FieldByName('AcValue').AsFloat;
end;

procedure TAscitmTmp.WriteAcValue(pValue:double);
begin
  oTmpTable.FieldByName('AcValue').AsFloat := pValue;
end;

function TAscitmTmp.ReadFgValue:double;
begin
  Result := oTmpTable.FieldByName('FgValue').AsFloat;
end;

procedure TAscitmTmp.WriteFgValue(pValue:double);
begin
  oTmpTable.FieldByName('FgValue').AsFloat := pValue;
end;

function TAscitmTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAscitmTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAscitmTmp.ReadBfdQnt:longint;
begin
  Result := oTmpTable.FieldByName('BfdQnt').AsInteger;
end;

procedure TAscitmTmp.WriteBfdQnt(pValue:longint);
begin
  oTmpTable.FieldByName('BfdQnt').AsInteger := pValue;
end;

function TAscitmTmp.ReadExdQnt:longint;
begin
  Result := oTmpTable.FieldByName('ExdQnt').AsInteger;
end;

procedure TAscitmTmp.WriteExdQnt(pValue:longint);
begin
  oTmpTable.FieldByName('ExdQnt').AsInteger := pValue;
end;

function TAscitmTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAscitmTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAscitmTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAscitmTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAscitmTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAscitmTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAscitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAscitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAscitmTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAscitmTmp.LocateDocType (pDocType:Str2):boolean;
begin
  SetIndex (ixDocType);
  Result := oTmpTable.FindKey([pDocType]);
end;

function TAscitmTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TAscitmTmp.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oTmpTable.FindKey([pExpDate]);
end;

function TAscitmTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TAscitmTmp.LocateExdQnt (pExdQnt:longint):boolean;
begin
  SetIndex (ixExdQnt);
  Result := oTmpTable.FindKey([pExdQnt]);
end;

procedure TAscitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAscitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAscitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAscitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAscitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAscitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TAscitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAscitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAscitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAscitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAscitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAscitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAscitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAscitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAscitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAscitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAscitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
