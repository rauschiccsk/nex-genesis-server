unit tOUTSTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStmNum = '';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixFifNum = 'FifNum';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';

type
  TOutstmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStmNum:longint;        procedure WriteStmNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateStmNum (pStmNum:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

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
    property StmNum:longint read ReadStmNum write WriteStmNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TOutstmTmp.Create;
begin
  oTmpTable := TmpInit ('OUTSTM',Self);
end;

destructor TOutstmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOutstmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOutstmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOutstmTmp.ReadStmNum:longint;
begin
  Result := oTmpTable.FieldByName('StmNum').AsInteger;
end;

procedure TOutstmTmp.WriteStmNum(pValue:longint);
begin
  oTmpTable.FieldByName('StmNum').AsInteger := pValue;
end;

function TOutstmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOutstmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOutstmTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOutstmTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOutstmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOutstmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOutstmTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TOutstmTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOutstmTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TOutstmTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TOutstmTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TOutstmTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TOutstmTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOutstmTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOutstmTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TOutstmTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TOutstmTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TOutstmTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TOutstmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TOutstmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TOutstmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOutstmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOutstmTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TOutstmTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TOutstmTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOutstmTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOutstmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOutstmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOutstmTmp.LocateStmNum (pStmNum:longint):boolean;
begin
  SetIndex (ixStmNum);
  Result := oTmpTable.FindKey([pStmNum]);
end;

function TOutstmTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOutstmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TOutstmTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TOutstmTmp.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

function TOutstmTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

function TOutstmTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TOutstmTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TOutstmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOutstmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOutstmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOutstmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOutstmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOutstmTmp.First;
begin
  oTmpTable.First;
end;

procedure TOutstmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOutstmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOutstmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOutstmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOutstmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOutstmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOutstmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOutstmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOutstmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOutstmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOutstmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1908001}
