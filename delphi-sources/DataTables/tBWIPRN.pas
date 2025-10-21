unit tBWIPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='';

type
  TBwiprnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetProSer:Str20;            procedure SetProSer (pValue:Str20);
    function GetProBva:double;           procedure SetProBva (pValue:double);
    function GetBegDte:TDatetime;        procedure SetBegDte (pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte (pValue:TDatetime);
    function GetRetDte:TDatetime;        procedure SetRetDte (pValue:TDatetime);
    function GetDayQnt:word;             procedure SetDayQnt (pValue:word);
    function GetBrwBpc:double;           procedure SetBrwBpc (pValue:double);
    function GetBrwBva:double;           procedure SetBrwBva (pValue:double);
    function GetCauVal:double;           procedure SetCauVal (pValue:double);
    function GetTcdNum:Str12;            procedure SetTcdNum (pValue:Str12);
    function GetTcdItm:word;             procedure SetTcdItm (pValue:word);
    function GetCrtUsr:str15;            procedure SetCrtUsr (pValue:str15);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetNotice:Str250;           procedure SetNotice (pValue:Str250);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDnIn (pDocNum:Str12;pItmNum:word):boolean;

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
    property ItmNum:word read GetItmNum write SetItmNum;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property ProSer:Str20 read GetProSer write SetProSer;
    property ProBva:double read GetProBva write SetProBva;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property RetDte:TDatetime read GetRetDte write SetRetDte;
    property DayQnt:word read GetDayQnt write SetDayQnt;
    property BrwBpc:double read GetBrwBpc write SetBrwBpc;
    property BrwBva:double read GetBrwBva write SetBrwBva;
    property CauVal:double read GetCauVal write SetCauVal;
    property TcdNum:Str12 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property CrtUsr:str15 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ParNum:longint read GetParNum write SetParNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property Notice:Str250 read GetNotice write SetNotice;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TBwiprnTmp.Create;
begin
  oTmpTable:=TmpInit ('BWIPRN',Self);
end;

destructor TBwiprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBwiprnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TBwiprnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TBwiprnTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TBwiprnTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TBwiprnTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TBwiprnTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TBwiprnTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TBwiprnTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBwiprnTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TBwiprnTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TBwiprnTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TBwiprnTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TBwiprnTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TBwiprnTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TBwiprnTmp.GetProSer:Str20;
begin
  Result:=oTmpTable.FieldByName('ProSer').AsString;
end;

procedure TBwiprnTmp.SetProSer(pValue:Str20);
begin
  oTmpTable.FieldByName('ProSer').AsString:=pValue;
end;

function TBwiprnTmp.GetProBva:double;
begin
  Result:=oTmpTable.FieldByName('ProBva').AsFloat;
end;

procedure TBwiprnTmp.SetProBva(pValue:double);
begin
  oTmpTable.FieldByName('ProBva').AsFloat:=pValue;
end;

function TBwiprnTmp.GetBegDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('BegDte').AsDateTime;
end;

procedure TBwiprnTmp.SetBegDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TBwiprnTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TBwiprnTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TBwiprnTmp.GetRetDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RetDte').AsDateTime;
end;

procedure TBwiprnTmp.SetRetDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RetDte').AsDateTime:=pValue;
end;

function TBwiprnTmp.GetDayQnt:word;
begin
  Result:=oTmpTable.FieldByName('DayQnt').AsInteger;
end;

procedure TBwiprnTmp.SetDayQnt(pValue:word);
begin
  oTmpTable.FieldByName('DayQnt').AsInteger:=pValue;
end;

function TBwiprnTmp.GetBrwBpc:double;
begin
  Result:=oTmpTable.FieldByName('BrwBpc').AsFloat;
end;

procedure TBwiprnTmp.SetBrwBpc(pValue:double);
begin
  oTmpTable.FieldByName('BrwBpc').AsFloat:=pValue;
end;

function TBwiprnTmp.GetBrwBva:double;
begin
  Result:=oTmpTable.FieldByName('BrwBva').AsFloat;
end;

procedure TBwiprnTmp.SetBrwBva(pValue:double);
begin
  oTmpTable.FieldByName('BrwBva').AsFloat:=pValue;
end;

function TBwiprnTmp.GetCauVal:double;
begin
  Result:=oTmpTable.FieldByName('CauVal').AsFloat;
end;

procedure TBwiprnTmp.SetCauVal(pValue:double);
begin
  oTmpTable.FieldByName('CauVal').AsFloat:=pValue;
end;

function TBwiprnTmp.GetTcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TBwiprnTmp.SetTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TBwiprnTmp.GetTcdItm:word;
begin
  Result:=oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TBwiprnTmp.SetTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TBwiprnTmp.GetCrtUsr:str15;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TBwiprnTmp.SetCrtUsr(pValue:str15);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBwiprnTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBwiprnTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBwiprnTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBwiprnTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBwiprnTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TBwiprnTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBwiprnTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TBwiprnTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TBwiprnTmp.GetNotice:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TBwiprnTmp.SetNotice(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TBwiprnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TBwiprnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBwiprnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TBwiprnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TBwiprnTmp.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

procedure TBwiprnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TBwiprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBwiprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBwiprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBwiprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBwiprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TBwiprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBwiprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBwiprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBwiprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBwiprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBwiprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBwiprnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBwiprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBwiprnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBwiprnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TBwiprnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
