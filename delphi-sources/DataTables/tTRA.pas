unit tTRA;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoRn='';

type
  TTraTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetRecNum:word;             procedure SetRecNum (pValue:word);
    function GetSerNum:longint;          procedure SetSerNum (pValue:longint);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetRegName:Str60;           procedure SetRegName (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegAddr:Str30;           procedure SetRegAddr (pValue:Str30);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetRegSta:Str2;             procedure SetRegSta (pValue:Str2);
    function GetPckQnt:word;             procedure SetPckQnt (pValue:word);
    function GetWeight:double;           procedure SetWeight (pValue:double);
    function GetWeightLst:Str200;        procedure SetWeightLst (pValue:Str200);
    function GetPckNote:Str250;          procedure SetPckNote (pValue:Str250);
    function GetFgBValue:double;         procedure SetFgBValue (pValue:double);
    function GetRegTel:Str20;            procedure SetRegTel (pValue:Str20);
    function GetWpaCode:word;            procedure SetWpaCode (pValue:word);
    function GetWpaName:Str60;           procedure SetWpaName (pValue:Str60);
    function GetWpaAddr:Str30;           procedure SetWpaAddr (pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta (pValue:Str2);
    function GetWpaCty:Str3;             procedure SetWpaCty (pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn (pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip (pValue:Str15);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDoRn (pDocNum:Str12;pRecNum:word):boolean;

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
    property RecNum:word read GetRecNum write SetRecNum;
    property SerNum:longint read GetSerNum write SetSerNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property RegName:Str60 read GetRegName write SetRegName;
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegAddr:Str30 read GetRegAddr write SetRegAddr;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property PckQnt:word read GetPckQnt write SetPckQnt;
    property Weight:double read GetWeight write SetWeight;
    property WeightLst:Str200 read GetWeightLst write SetWeightLst;
    property PckNote:Str250 read GetPckNote write SetPckNote;
    property FgBValue:double read GetFgBValue write SetFgBValue;
    property RegTel:Str20 read GetRegTel write SetRegTel;
    property WpaCode:word read GetWpaCode write SetWpaCode;
    property WpaName:Str60 read GetWpaName write SetWpaName;
    property WpaAddr:Str30 read GetWpaAddr write SetWpaAddr;
    property WpaSta:Str2 read GetWpaSta write SetWpaSta;
    property WpaCty:Str3 read GetWpaCty write SetWpaCty;
    property WpaCtn:Str30 read GetWpaCtn write SetWpaCtn;
    property WpaZip:Str15 read GetWpaZip write SetWpaZip;
  end;

implementation

constructor TTraTmp.Create;
begin
  oTmpTable:=TmpInit ('TRA',Self);
end;

destructor TTraTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTraTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TTraTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TTraTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTraTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TTraTmp.GetRecNum:word;
begin
  Result:=oTmpTable.FieldByName('RecNum').AsInteger;
end;

procedure TTraTmp.SetRecNum(pValue:word);
begin
  oTmpTable.FieldByName('RecNum').AsInteger:=pValue;
end;

function TTraTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TTraTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TTraTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TTraTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TTraTmp.GetRegName:Str60;
begin
  Result:=oTmpTable.FieldByName('RegName').AsString;
end;

procedure TTraTmp.SetRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString:=pValue;
end;

function TTraTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TTraTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TTraTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TTraTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TTraTmp.GetRegAddr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TTraTmp.SetRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString:=pValue;
end;

function TTraTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TTraTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TTraTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TTraTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TTraTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TTraTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TTraTmp.GetPckQnt:word;
begin
  Result:=oTmpTable.FieldByName('PckQnt').AsInteger;
end;

procedure TTraTmp.SetPckQnt(pValue:word);
begin
  oTmpTable.FieldByName('PckQnt').AsInteger:=pValue;
end;

function TTraTmp.GetWeight:double;
begin
  Result:=oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TTraTmp.SetWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat:=pValue;
end;

function TTraTmp.GetWeightLst:Str200;
begin
  Result:=oTmpTable.FieldByName('WeightLst').AsString;
end;

procedure TTraTmp.SetWeightLst(pValue:Str200);
begin
  oTmpTable.FieldByName('WeightLst').AsString:=pValue;
end;

function TTraTmp.GetPckNote:Str250;
begin
  Result:=oTmpTable.FieldByName('PckNote').AsString;
end;

procedure TTraTmp.SetPckNote(pValue:Str250);
begin
  oTmpTable.FieldByName('PckNote').AsString:=pValue;
end;

function TTraTmp.GetFgBValue:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TTraTmp.SetFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat:=pValue;
end;

function TTraTmp.GetRegTel:Str20;
begin
  Result:=oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TTraTmp.SetRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString:=pValue;
end;

function TTraTmp.GetWpaCode:word;
begin
  Result:=oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TTraTmp.SetWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger:=pValue;
end;

function TTraTmp.GetWpaName:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TTraTmp.SetWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString:=pValue;
end;

function TTraTmp.GetWpaAddr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TTraTmp.SetWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString:=pValue;
end;

function TTraTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TTraTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TTraTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TTraTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TTraTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TTraTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TTraTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TTraTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TTraTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TTraTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TTraTmp.LocDoRn(pDocNum:Str12;pRecNum:word):boolean;
begin
  SetIndex (ixDoRn);
  Result:=oTmpTable.FindKey([pDocNum,pRecNum]);
end;

procedure TTraTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TTraTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTraTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTraTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTraTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTraTmp.First;
begin
  oTmpTable.First;
end;

procedure TTraTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTraTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTraTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTraTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTraTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTraTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTraTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTraTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTraTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTraTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TTraTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
