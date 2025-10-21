unit tSTS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';
  ixGsCode = 'GsCode';
  ixSalDate = 'SalDate';
  ixDoIt = 'DoIt';
  ixGcSdCn = 'GcSdCn';
  ixGcCn = 'GcCn';

type
  TStsTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function Locate (pGsCode:longint;pSalDate:TDatetime;pCasNum:word;pSalQnt:double):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSalDate (pSalDate:TDatetime):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGcSdCn (pGsCode:longint;pSalDate:TDatetime;pCasNum:word):boolean;
    function LocateGcCn (pGsCode:longint;pCasNum:word):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TStsTmp.Create;
begin
  oTmpTable := TmpInit ('STS',Self);
end;

destructor TStsTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStsTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStsTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStsTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStsTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStsTmp.ReadSalDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SalDate').AsDateTime;
end;

procedure TStsTmp.WriteSalDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TStsTmp.ReadCasNum:word;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TStsTmp.WriteCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TStsTmp.ReadSalQnt:double;
begin
  Result := oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStsTmp.WriteSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TStsTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStsTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TStsTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStsTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStsTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TStsTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStsTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStsTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStsTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStsTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStsTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStsTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStsTmp.Locate (pGsCode:longint;pSalDate:TDatetime;pCasNum:word;pSalQnt:double):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([pGsCode,pSalDate,pCasNum,pSalQnt]);
end;

function TStsTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStsTmp.LocateSalDate (pSalDate:TDatetime):boolean;
begin
  SetIndex (ixSalDate);
  Result := oTmpTable.FindKey([pSalDate]);
end;

function TStsTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStsTmp.LocateGcSdCn (pGsCode:longint;pSalDate:TDatetime;pCasNum:word):boolean;
begin
  SetIndex (ixGcSdCn);
  Result := oTmpTable.FindKey([pGsCode,pSalDate,pCasNum]);
end;

function TStsTmp.LocateGcCn (pGsCode:longint;pCasNum:word):boolean;
begin
  SetIndex (ixGcCn);
  Result := oTmpTable.FindKey([pGsCode,pCasNum]);
end;

procedure TStsTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStsTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStsTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStsTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStsTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStsTmp.First;
begin
  oTmpTable.First;
end;

procedure TStsTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStsTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStsTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStsTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStsTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStsTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStsTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStsTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStsTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStsTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStsTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
