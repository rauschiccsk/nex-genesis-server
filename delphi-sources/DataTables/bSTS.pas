unit bSTS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixSalDate = 'SalDate';
  ixDoIt = 'DoIt';
  ixGcSdCn = 'GcSdCn';
  ixGcCn = 'GcCn';

type
  TStsBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
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
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSalDate (pSalDate:TDatetime):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGcSdCn (pGsCode:longint;pSalDate:TDatetime;pCasNum:word):boolean;
    function LocateGcCn (pGsCode:longint;pCasNum:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestSalDate (pSalDate:TDatetime):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestGcSdCn (pGsCode:longint;pSalDate:TDatetime;pCasNum:word):boolean;
    function NearestGcCn (pGsCode:longint;pCasNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:word);            
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
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

constructor TStsBtr.Create;
begin
  oBtrTable := BtrInit ('STS',gPath.StkPath,Self);
end;

constructor TStsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STS',pPath,Self);
end;

destructor TStsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStsBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStsBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStsBtr.ReadSalDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SalDate').AsDateTime;
end;

procedure TStsBtr.WriteSalDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TStsBtr.ReadCasNum:word;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TStsBtr.WriteCasNum(pValue:word);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TStsBtr.ReadSalQnt:double;
begin
  Result := oBtrTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStsBtr.WriteSalQnt(pValue:double);
begin
  oBtrTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TStsBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TStsBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TStsBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStsBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStsBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TStsBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStsBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStsBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStsBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStsBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStsBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStsBtr.LocateSalDate (pSalDate:TDatetime):boolean;
begin
  SetIndex (ixSalDate);
  Result := oBtrTable.FindKey([pSalDate]);
end;

function TStsBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TStsBtr.LocateGcSdCn (pGsCode:longint;pSalDate:TDatetime;pCasNum:word):boolean;
begin
  SetIndex (ixGcSdCn);
  Result := oBtrTable.FindKey([pGsCode,pSalDate,pCasNum]);
end;

function TStsBtr.LocateGcCn (pGsCode:longint;pCasNum:word):boolean;
begin
  SetIndex (ixGcCn);
  Result := oBtrTable.FindKey([pGsCode,pCasNum]);
end;

function TStsBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStsBtr.NearestSalDate (pSalDate:TDatetime):boolean;
begin
  SetIndex (ixSalDate);
  Result := oBtrTable.FindNearest([pSalDate]);
end;

function TStsBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TStsBtr.NearestGcSdCn (pGsCode:longint;pSalDate:TDatetime;pCasNum:word):boolean;
begin
  SetIndex (ixGcSdCn);
  Result := oBtrTable.FindNearest([pGsCode,pSalDate,pCasNum]);
end;

function TStsBtr.NearestGcCn (pGsCode:longint;pCasNum:word):boolean;
begin
  SetIndex (ixGcCn);
  Result := oBtrTable.FindNearest([pGsCode,pCasNum]);
end;

procedure TStsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStsBtr.Open;
begin
  oBtrTable.Open(pStkNum);
end;

procedure TStsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStsBtr.First;
begin
  oBtrTable.First;
end;

procedure TStsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
