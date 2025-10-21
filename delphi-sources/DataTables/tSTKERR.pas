unit tSTKERR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItPn='';
  ixDoIt='DoIt';
  ixProNum='ProNum';
  ixProNam_='ProNam_';

type
  TStkerrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetDocQnt:double;           procedure SetDocQnt (pValue:double);
    function GetStmQnt:double;           procedure SetStmQnt (pValue:double);
    function GetFifQnt:double;           procedure SetFifQnt (pValue:double);
    function GetStcQnt:double;           procedure SetStcQnt (pValue:double);
    function GetDifQnt:double;           procedure SetDifQnt (pValue:double);
    function GetDocVal:double;           procedure SetDocVal (pValue:double);
    function GetStmVal:double;           procedure SetStmVal (pValue:double);
    function GetFifVal:double;           procedure SetFifVal (pValue:double);
    function GetStcVal:double;           procedure SetStcVal (pValue:double);
    function GetDifVal:double;           procedure SetDifVal (pValue:double);
    function GetErrCod:Str100;           procedure SetErrCod (pValue:Str100);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDoItPn (pDocNum:Str12;pItmNum:longint;pProNum:longint):boolean;
    function LocDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property DocQnt:double read GetDocQnt write SetDocQnt;
    property StmQnt:double read GetStmQnt write SetStmQnt;
    property FifQnt:double read GetFifQnt write SetFifQnt;
    property StcQnt:double read GetStcQnt write SetStcQnt;
    property DifQnt:double read GetDifQnt write SetDifQnt;
    property DocVal:double read GetDocVal write SetDocVal;
    property StmVal:double read GetStmVal write SetStmVal;
    property FifVal:double read GetFifVal write SetFifVal;
    property StcVal:double read GetStcVal write SetStcVal;
    property DifVal:double read GetDifVal write SetDifVal;
    property ErrCod:Str100 read GetErrCod write SetErrCod;
  end;

implementation

constructor TStkerrTmp.Create;
begin
  oTmpTable:=TmpInit ('STKERR',Self);
end;

destructor TStkerrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkerrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkerrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkerrTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStkerrTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkerrTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkerrTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkerrTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkerrTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkerrTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TStkerrTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TStkerrTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TStkerrTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TStkerrTmp.GetDocQnt:double;
begin
  Result:=oTmpTable.FieldByName('DocQnt').AsFloat;
end;

procedure TStkerrTmp.SetDocQnt(pValue:double);
begin
  oTmpTable.FieldByName('DocQnt').AsFloat:=pValue;
end;

function TStkerrTmp.GetStmQnt:double;
begin
  Result:=oTmpTable.FieldByName('StmQnt').AsFloat;
end;

procedure TStkerrTmp.SetStmQnt(pValue:double);
begin
  oTmpTable.FieldByName('StmQnt').AsFloat:=pValue;
end;

function TStkerrTmp.GetFifQnt:double;
begin
  Result:=oTmpTable.FieldByName('FifQnt').AsFloat;
end;

procedure TStkerrTmp.SetFifQnt(pValue:double);
begin
  oTmpTable.FieldByName('FifQnt').AsFloat:=pValue;
end;

function TStkerrTmp.GetStcQnt:double;
begin
  Result:=oTmpTable.FieldByName('StcQnt').AsFloat;
end;

procedure TStkerrTmp.SetStcQnt(pValue:double);
begin
  oTmpTable.FieldByName('StcQnt').AsFloat:=pValue;
end;

function TStkerrTmp.GetDifQnt:double;
begin
  Result:=oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TStkerrTmp.SetDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat:=pValue;
end;

function TStkerrTmp.GetDocVal:double;
begin
  Result:=oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TStkerrTmp.SetDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat:=pValue;
end;

function TStkerrTmp.GetStmVal:double;
begin
  Result:=oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TStkerrTmp.SetStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat:=pValue;
end;

function TStkerrTmp.GetFifVal:double;
begin
  Result:=oTmpTable.FieldByName('FifVal').AsFloat;
end;

procedure TStkerrTmp.SetFifVal(pValue:double);
begin
  oTmpTable.FieldByName('FifVal').AsFloat:=pValue;
end;

function TStkerrTmp.GetStcVal:double;
begin
  Result:=oTmpTable.FieldByName('StcVal').AsFloat;
end;

procedure TStkerrTmp.SetStcVal(pValue:double);
begin
  oTmpTable.FieldByName('StcVal').AsFloat:=pValue;
end;

function TStkerrTmp.GetDifVal:double;
begin
  Result:=oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TStkerrTmp.SetDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat:=pValue;
end;

function TStkerrTmp.GetErrCod:Str100;
begin
  Result:=oTmpTable.FieldByName('ErrCod').AsString;
end;

procedure TStkerrTmp.SetErrCod(pValue:Str100);
begin
  oTmpTable.FieldByName('ErrCod').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkerrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkerrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkerrTmp.LocDoItPn(pDocNum:Str12;pItmNum:longint;pProNum:longint):boolean;
begin
  SetIndex (ixDoItPn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum,pProNum]);
end;

function TStkerrTmp.LocDoIt(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStkerrTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TStkerrTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TStkerrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkerrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkerrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkerrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkerrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkerrTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkerrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkerrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkerrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkerrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkerrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkerrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkerrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkerrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkerrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkerrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkerrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
