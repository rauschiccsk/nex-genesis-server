unit tACCJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrimary='';
  ixRowNum='RowNum';
  ixDocDte='DocDte';
  ixSnAn='SnAn';

type
  TAccjrnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetRowNum:word;             procedure SetRowNum (pValue:word);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl (pValue:Str6);
    function GetDocDes:Str60;            procedure SetDocDes (pValue:Str60);
    function GetCrdAcv:double;           procedure SetCrdAcv (pValue:double);
    function GetDebAcv:double;           procedure SetDebAcv (pValue:double);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetBegRec:byte;             procedure SetBegRec (pValue:byte);
    function GetConDoc:Str12;            procedure SetConDoc (pValue:Str12);
    function GetSmcNum:word;             procedure SetSmcNum (pValue:word);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOceNum:Str12;            procedure SetOceNum (pValue:Str12);
    function GetEcuNum:word;             procedure SetEcuNum (pValue:word);
    function GetCrtUsr:Str8;             procedure SetCrtUsr (pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetSpaNum:longint;          procedure SetSpaNum (pValue:longint);
    function GetDocCrs:double;           procedure SetDocCrs (pValue:double);
    function GetDocFgv:double;           procedure SetDocFgv (pValue:double);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPrimary (pDocNum:Str12;pRowNum:word):boolean;
    function LocRowNum (pRowNum:word):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property RowNum:word read GetRowNum write SetRowNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property DocDes:Str60 read GetDocDes write SetDocDes;
    property CrdAcv:double read GetCrdAcv write SetCrdAcv;
    property DebAcv:double read GetDebAcv write SetDebAcv;
    property StkNum:word read GetStkNum write SetStkNum;
    property BegRec:byte read GetBegRec write SetBegRec;
    property ConDoc:Str12 read GetConDoc write SetConDoc;
    property SmcNum:word read GetSmcNum write SetSmcNum;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OceNum:Str12 read GetOceNum write SetOceNum;
    property EcuNum:word read GetEcuNum write SetEcuNum;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SpaNum:longint read GetSpaNum write SetSpaNum;
    property DocCrs:double read GetDocCrs write SetDocCrs;
    property DocFgv:double read GetDocFgv write SetDocFgv;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TAccjrnTmp.Create;
begin
  oTmpTable:=TmpInit ('ACCJRN',Self);
end;

destructor TAccjrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAccjrnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAccjrnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAccjrnTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAccjrnTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TAccjrnTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TAccjrnTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAccjrnTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TAccjrnTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TAccjrnTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TAccjrnTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TAccjrnTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TAccjrnTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAccjrnTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAccjrnTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAccjrnTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAccjrnTmp.GetDocDes:Str60;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TAccjrnTmp.SetDocDes(pValue:Str60);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TAccjrnTmp.GetCrdAcv:double;
begin
  Result:=oTmpTable.FieldByName('CrdAcv').AsFloat;
end;

procedure TAccjrnTmp.SetCrdAcv(pValue:double);
begin
  oTmpTable.FieldByName('CrdAcv').AsFloat:=pValue;
end;

function TAccjrnTmp.GetDebAcv:double;
begin
  Result:=oTmpTable.FieldByName('DebAcv').AsFloat;
end;

procedure TAccjrnTmp.SetDebAcv(pValue:double);
begin
  oTmpTable.FieldByName('DebAcv').AsFloat:=pValue;
end;

function TAccjrnTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAccjrnTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetBegRec:byte;
begin
  Result:=oTmpTable.FieldByName('BegRec').AsInteger;
end;

procedure TAccjrnTmp.SetBegRec(pValue:byte);
begin
  oTmpTable.FieldByName('BegRec').AsInteger:=pValue;
end;

function TAccjrnTmp.GetConDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TAccjrnTmp.SetConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString:=pValue;
end;

function TAccjrnTmp.GetSmcNum:word;
begin
  Result:=oTmpTable.FieldByName('SmcNum').AsInteger;
end;

procedure TAccjrnTmp.SetSmcNum(pValue:word);
begin
  oTmpTable.FieldByName('SmcNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TAccjrnTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TAccjrnTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TAccjrnTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TAccjrnTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TAccjrnTmp.GetOceNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OceNum').AsString;
end;

procedure TAccjrnTmp.SetOceNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OceNum').AsString:=pValue;
end;

function TAccjrnTmp.GetEcuNum:word;
begin
  Result:=oTmpTable.FieldByName('EcuNum').AsInteger;
end;

procedure TAccjrnTmp.SetEcuNum(pValue:word);
begin
  oTmpTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetCrtUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TAccjrnTmp.SetCrtUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAccjrnTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAccjrnTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAccjrnTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAccjrnTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TAccjrnTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TAccjrnTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TAccjrnTmp.GetDocCrs:double;
begin
  Result:=oTmpTable.FieldByName('DocCrs').AsFloat;
end;

procedure TAccjrnTmp.SetDocCrs(pValue:double);
begin
  oTmpTable.FieldByName('DocCrs').AsFloat:=pValue;
end;

function TAccjrnTmp.GetDocFgv:double;
begin
  Result:=oTmpTable.FieldByName('DocFgv').AsFloat;
end;

procedure TAccjrnTmp.SetDocFgv(pValue:double);
begin
  oTmpTable.FieldByName('DocFgv').AsFloat:=pValue;
end;

function TAccjrnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAccjrnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccjrnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAccjrnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAccjrnTmp.LocPrimary(pDocNum:Str12;pRowNum:word):boolean;
begin
  SetIndex (ixPrimary);
  Result:=oTmpTable.FindKey([pDocNum,pRowNum]);
end;

function TAccjrnTmp.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result:=oTmpTable.FindKey([pRowNum]);
end;

function TAccjrnTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TAccjrnTmp.LocSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSnAn);
  Result:=oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

procedure TAccjrnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAccjrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAccjrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAccjrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAccjrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAccjrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TAccjrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAccjrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAccjrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAccjrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAccjrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAccjrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAccjrnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAccjrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAccjrnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAccjrnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAccjrnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
