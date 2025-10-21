unit tFSABUF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTrnIdc = '';
  ixSymbol = 'Symbol';
  ixTrnDate = 'TrnDate';
  ixUsrIdc = 'UsrIdc';

type
  TFsabufTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTrnIdc:Str10;          procedure WriteTrnIdc (pValue:Str10);
    function  ReadSymbol:Str6;           procedure WriteSymbol (pValue:Str6);
    function  ReadActQnt:longint;        procedure WriteActQnt (pValue:longint);
    function  ReadTrnDir:Str1;           procedure WriteTrnDir (pValue:Str1);
    function  ReadTrnDate:TDatetime;     procedure WriteTrnDate (pValue:TDatetime);
    function  ReadTrnTime:TDatetime;     procedure WriteTrnTime (pValue:TDatetime);
    function  ReadTrnPce:double;         procedure WriteTrnPce (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadTrnOvr:double;         procedure WriteTrnOvr (pValue:double);
    function  ReadUsrIdc:Str20;          procedure WriteUsrIdc (pValue:Str20);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTrnIdc (pTrnIdc:Str10):boolean;
    function LocateSymbol (pSymbol:Str6):boolean;
    function LocateTrnDate (pTrnDate:TDatetime):boolean;
    function LocateUsrIdc (pUsrIdc:Str20):boolean;

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
    property TrnIdc:Str10 read ReadTrnIdc write WriteTrnIdc;
    property Symbol:Str6 read ReadSymbol write WriteSymbol;
    property ActQnt:longint read ReadActQnt write WriteActQnt;
    property TrnDir:Str1 read ReadTrnDir write WriteTrnDir;
    property TrnDate:TDatetime read ReadTrnDate write WriteTrnDate;
    property TrnTime:TDatetime read ReadTrnTime write WriteTrnTime;
    property TrnPce:double read ReadTrnPce write WriteTrnPce;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property TrnOvr:double read ReadTrnOvr write WriteTrnOvr;
    property UsrIdc:Str20 read ReadUsrIdc write WriteUsrIdc;
  end;

implementation

constructor TFsabufTmp.Create;
begin
  oTmpTable := TmpInit ('FSABUF',Self);
end;

destructor TFsabufTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFsabufTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFsabufTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFsabufTmp.ReadTrnIdc:Str10;
begin
  Result := oTmpTable.FieldByName('TrnIdc').AsString;
end;

procedure TFsabufTmp.WriteTrnIdc(pValue:Str10);
begin
  oTmpTable.FieldByName('TrnIdc').AsString := pValue;
end;

function TFsabufTmp.ReadSymbol:Str6;
begin
  Result := oTmpTable.FieldByName('Symbol').AsString;
end;

procedure TFsabufTmp.WriteSymbol(pValue:Str6);
begin
  oTmpTable.FieldByName('Symbol').AsString := pValue;
end;

function TFsabufTmp.ReadActQnt:longint;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsInteger;
end;

procedure TFsabufTmp.WriteActQnt(pValue:longint);
begin
  oTmpTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TFsabufTmp.ReadTrnDir:Str1;
begin
  Result := oTmpTable.FieldByName('TrnDir').AsString;
end;

procedure TFsabufTmp.WriteTrnDir(pValue:Str1);
begin
  oTmpTable.FieldByName('TrnDir').AsString := pValue;
end;

function TFsabufTmp.ReadTrnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TrnDate').AsDateTime;
end;

procedure TFsabufTmp.WriteTrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrnDate').AsDateTime := pValue;
end;

function TFsabufTmp.ReadTrnTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TrnTime').AsDateTime;
end;

procedure TFsabufTmp.WriteTrnTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrnTime').AsDateTime := pValue;
end;

function TFsabufTmp.ReadTrnPce:double;
begin
  Result := oTmpTable.FieldByName('TrnPce').AsFloat;
end;

procedure TFsabufTmp.WriteTrnPce(pValue:double);
begin
  oTmpTable.FieldByName('TrnPce').AsFloat := pValue;
end;

function TFsabufTmp.ReadTrnVal:double;
begin
  Result := oTmpTable.FieldByName('TrnVal').AsFloat;
end;

procedure TFsabufTmp.WriteTrnVal(pValue:double);
begin
  oTmpTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TFsabufTmp.ReadTrnOvr:double;
begin
  Result := oTmpTable.FieldByName('TrnOvr').AsFloat;
end;

procedure TFsabufTmp.WriteTrnOvr(pValue:double);
begin
  oTmpTable.FieldByName('TrnOvr').AsFloat := pValue;
end;

function TFsabufTmp.ReadUsrIdc:Str20;
begin
  Result := oTmpTable.FieldByName('UsrIdc').AsString;
end;

procedure TFsabufTmp.WriteUsrIdc(pValue:Str20);
begin
  oTmpTable.FieldByName('UsrIdc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsabufTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFsabufTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFsabufTmp.LocateTrnIdc (pTrnIdc:Str10):boolean;
begin
  SetIndex (ixTrnIdc);
  Result := oTmpTable.FindKey([pTrnIdc]);
end;

function TFsabufTmp.LocateSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oTmpTable.FindKey([pSymbol]);
end;

function TFsabufTmp.LocateTrnDate (pTrnDate:TDatetime):boolean;
begin
  SetIndex (ixTrnDate);
  Result := oTmpTable.FindKey([pTrnDate]);
end;

function TFsabufTmp.LocateUsrIdc (pUsrIdc:Str20):boolean;
begin
  SetIndex (ixUsrIdc);
  Result := oTmpTable.FindKey([pUsrIdc]);
end;

procedure TFsabufTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFsabufTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFsabufTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFsabufTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFsabufTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFsabufTmp.First;
begin
  oTmpTable.First;
end;

procedure TFsabufTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFsabufTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFsabufTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFsabufTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFsabufTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFsabufTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFsabufTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFsabufTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFsabufTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFsabufTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFsabufTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
