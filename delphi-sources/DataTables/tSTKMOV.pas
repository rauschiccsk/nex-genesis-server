unit tSTKMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStmNum='';
  ixSmcNum='SmcNum';
  ixDnIn='DnIn';
  ixProNum='ProNum';
  ixPgrNum='PgrNum';
  ixDocDte='DocDte';
  ixFifNum='FifNum';
  ixBpaNum='BpaNum';
  ixBpaNam_='BpaNam_';
  ixParNum='ParNum';
  ixParNam_='ParNam_';
  ixBegSta='BegSta';
  ixIncTyp='IncTyp';

type
  TStkmovTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStmNum:longint;          procedure SetStmNum (pValue:longint);
    function GetSmcNum:longint;          procedure SetSmcNum (pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetMovPrq:double;           procedure SetMovPrq (pValue:double);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetMovCva:double;           procedure SetMovCva (pValue:double);
    function GetMovCpc:double;           procedure SetMovCpc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetFifNum:longint;          procedure SetFifNum (pValue:longint);
    function GetBpaNum:longint;          procedure SetBpaNum (pValue:longint);
    function GetBpaNam:Str60;            procedure SetBpaNam (pValue:Str60);
    function GetBpaNam_:Str60;           procedure SetBpaNam_ (pValue:Str60);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetIncTyp:Str1;             procedure SetIncTyp (pValue:Str1);
    function GetBegSta:Str1;             procedure SetBegSta (pValue:Str1);
    function GetRbaCod:Str30;            procedure SetRbaCod (pValue:Str30);
    function GetRbaDte:TDatetime;        procedure SetRbaDte (pValue:TDatetime);
    function GetRmiStn:word;             procedure SetRmiStn (pValue:word);
    function GetRmoStn:word;             procedure SetRmoStn (pValue:word);
    function GetCrtUsr:str10;            procedure SetCrtUsr (pValue:str10);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocStmNum (pStmNum:longint):boolean;
    function LocSmcNum (pSmcNum:longint):boolean;
    function LocDnIn (pDocNum:Str12;pItmNum:longint):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocPgrNum (pPgrNum:word):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocFifNum (pFifNum:longint):boolean;
    function LocBpaNum (pBpaNum:longint):boolean;
    function LocBpaNam_ (pBpaNam_:Str60):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocBegSta (pBegSta:Str1):boolean;
    function LocIncTyp (pIncTyp:Str1):boolean;

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
    property StmNum:longint read GetStmNum write SetStmNum;
    property SmcNum:longint read GetSmcNum write SetSmcNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property ProNum:longint read GetProNum write SetProNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property ActPrq:double read GetActPrq write SetActPrq;
    property MovCva:double read GetMovCva write SetMovCva;
    property MovCpc:double read GetMovCpc write SetMovCpc;
    property SalAva:double read GetSalAva write SetSalAva;
    property FifNum:longint read GetFifNum write SetFifNum;
    property BpaNum:longint read GetBpaNum write SetBpaNum;
    property BpaNam:Str60 read GetBpaNam write SetBpaNam;
    property BpaNam_:Str60 read GetBpaNam_ write SetBpaNam_;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property IncTyp:Str1 read GetIncTyp write SetIncTyp;
    property BegSta:Str1 read GetBegSta write SetBegSta;
    property RbaCod:Str30 read GetRbaCod write SetRbaCod;
    property RbaDte:TDatetime read GetRbaDte write SetRbaDte;
    property RmiStn:word read GetRmiStn write SetRmiStn;
    property RmoStn:word read GetRmoStn write SetRmoStn;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TStkmovTmp.Create;
begin
  oTmpTable:=TmpInit ('STKMOV',Self);
end;

destructor TStkmovTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkmovTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkmovTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkmovTmp.GetStmNum:longint;
begin
  Result:=oTmpTable.FieldByName('StmNum').AsInteger;
end;

procedure TStkmovTmp.SetStmNum(pValue:longint);
begin
  oTmpTable.FieldByName('StmNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetSmcNum:longint;
begin
  Result:=oTmpTable.FieldByName('SmcNum').AsInteger;
end;

procedure TStkmovTmp.SetSmcNum(pValue:longint);
begin
  oTmpTable.FieldByName('SmcNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStkmovTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkmovTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkmovTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TStkmovTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkmovTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TStkmovTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TStkmovTmp.GetMovPrq:double;
begin
  Result:=oTmpTable.FieldByName('MovPrq').AsFloat;
end;

procedure TStkmovTmp.SetMovPrq(pValue:double);
begin
  oTmpTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TStkmovTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkmovTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkmovTmp.GetMovCva:double;
begin
  Result:=oTmpTable.FieldByName('MovCva').AsFloat;
end;

procedure TStkmovTmp.SetMovCva(pValue:double);
begin
  oTmpTable.FieldByName('MovCva').AsFloat:=pValue;
end;

function TStkmovTmp.GetMovCpc:double;
begin
  Result:=oTmpTable.FieldByName('MovCpc').AsFloat;
end;

procedure TStkmovTmp.SetMovCpc(pValue:double);
begin
  oTmpTable.FieldByName('MovCpc').AsFloat:=pValue;
end;

function TStkmovTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TStkmovTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TStkmovTmp.GetFifNum:longint;
begin
  Result:=oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TStkmovTmp.SetFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetBpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('BpaNum').AsInteger;
end;

procedure TStkmovTmp.SetBpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('BpaNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetBpaNam:Str60;
begin
  Result:=oTmpTable.FieldByName('BpaNam').AsString;
end;

procedure TStkmovTmp.SetBpaNam(pValue:Str60);
begin
  oTmpTable.FieldByName('BpaNam').AsString:=pValue;
end;

function TStkmovTmp.GetBpaNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('BpaNam_').AsString;
end;

procedure TStkmovTmp.SetBpaNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('BpaNam_').AsString:=pValue;
end;

function TStkmovTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TStkmovTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TStkmovTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TStkmovTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TStkmovTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TStkmovTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TStkmovTmp.GetIncTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('IncTyp').AsString;
end;

procedure TStkmovTmp.SetIncTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('IncTyp').AsString:=pValue;
end;

function TStkmovTmp.GetBegSta:Str1;
begin
  Result:=oTmpTable.FieldByName('BegSta').AsString;
end;

procedure TStkmovTmp.SetBegSta(pValue:Str1);
begin
  oTmpTable.FieldByName('BegSta').AsString:=pValue;
end;

function TStkmovTmp.GetRbaCod:Str30;
begin
  Result:=oTmpTable.FieldByName('RbaCod').AsString;
end;

procedure TStkmovTmp.SetRbaCod(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCod').AsString:=pValue;
end;

function TStkmovTmp.GetRbaDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RbaDte').AsDateTime;
end;

procedure TStkmovTmp.SetRbaDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDte').AsDateTime:=pValue;
end;

function TStkmovTmp.GetRmiStn:word;
begin
  Result:=oTmpTable.FieldByName('RmiStn').AsInteger;
end;

procedure TStkmovTmp.SetRmiStn(pValue:word);
begin
  oTmpTable.FieldByName('RmiStn').AsInteger:=pValue;
end;

function TStkmovTmp.GetRmoStn:word;
begin
  Result:=oTmpTable.FieldByName('RmoStn').AsInteger;
end;

procedure TStkmovTmp.SetRmoStn(pValue:word);
begin
  oTmpTable.FieldByName('RmoStn').AsInteger:=pValue;
end;

function TStkmovTmp.GetCrtUsr:str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkmovTmp.SetCrtUsr(pValue:str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkmovTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkmovTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkmovTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkmovTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TStkmovTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkmovTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkmovTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkmovTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkmovTmp.LocStmNum(pStmNum:longint):boolean;
begin
  SetIndex (ixStmNum);
  Result:=oTmpTable.FindKey([pStmNum]);
end;

function TStkmovTmp.LocSmcNum(pSmcNum:longint):boolean;
begin
  SetIndex (ixSmcNum);
  Result:=oTmpTable.FindKey([pSmcNum]);
end;

function TStkmovTmp.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStkmovTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TStkmovTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

function TStkmovTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TStkmovTmp.LocFifNum(pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result:=oTmpTable.FindKey([pFifNum]);
end;

function TStkmovTmp.LocBpaNum(pBpaNum:longint):boolean;
begin
  SetIndex (ixBpaNum);
  Result:=oTmpTable.FindKey([pBpaNum]);
end;

function TStkmovTmp.LocBpaNam_(pBpaNam_:Str60):boolean;
begin
  SetIndex (ixBpaNam_);
  Result:=oTmpTable.FindKey([pBpaNam_]);
end;

function TStkmovTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TStkmovTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TStkmovTmp.LocBegSta(pBegSta:Str1):boolean;
begin
  SetIndex (ixBegSta);
  Result:=oTmpTable.FindKey([pBegSta]);
end;

function TStkmovTmp.LocIncTyp(pIncTyp:Str1):boolean;
begin
  SetIndex (ixIncTyp);
  Result:=oTmpTable.FindKey([pIncTyp]);
end;

procedure TStkmovTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkmovTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkmovTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkmovTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkmovTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkmovTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkmovTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkmovTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkmovTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkmovTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkmovTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkmovTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkmovTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkmovTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkmovTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkmovTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkmovTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
