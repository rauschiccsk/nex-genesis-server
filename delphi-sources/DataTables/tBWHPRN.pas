unit tBWHPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';

type
  TBwhprnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer (pValue:Str2);
    function GetSerNum:longint;          procedure SetSerNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetBegDte:TDatetime;        procedure SetBegDte (pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte (pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAdr:Str30;            procedure SetRegAdr (pValue:Str30);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetRegStn:Str30;            procedure SetRegStn (pValue:Str30);
    function GetCtpNam:Str30;            procedure SetCtpNam (pValue:Str30);
    function GetCtpTel:Str20;            procedure SetCtpTel (pValue:Str20);
    function GetCtpEml:Str30;            procedure SetCtpEml (pValue:Str30);
    function GetProBva:double;           procedure SetProBva (pValue:double);
    function GetBwrAva:double;           procedure SetBwrAva (pValue:double);
    function GetBwrBva:double;           procedure SetBwrBva (pValue:double);
    function GetCauVal:double;           procedure SetCauVal (pValue:double);
    function GetItmQnt:word;             procedure SetItmQnt (pValue:word);
    function GetOutQnt:word;             procedure SetOutQnt (pValue:word);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetTcdNum:Str13;            procedure SetTcdNum (pValue:Str13);
    function GetPrnCnt:byte;             procedure SetPrnCnt (pValue:byte);
    function GetPrnUsr:Str15;            procedure SetPrnUsr (pValue:Str15);
    function GetPrnDte:TDatetime;        procedure SetPrnDte (pValue:TDatetime);
    function GetPrnTim:TDatetime;        procedure SetPrnTim (pValue:TDatetime);
    function GetDocDes:Str100;           procedure SetDocDes (pValue:Str100);
    function GetWarNum:byte;             procedure SetWarNum (pValue:byte);
    function GetWarDte:TDatetime;        procedure SetWarDte (pValue:TDatetime);
    function GetEdiUsr:Str15;            procedure SetEdiUsr (pValue:Str15);
    function GetEdiDte:TDatetime;        procedure SetEdiDte (pValue:TDatetime);
    function GetEdiTim:TDatetime;        procedure SetEdiTim (pValue:TDatetime);
    function GetCrtUsr:Str15;            procedure SetCrtUsr (pValue:Str15);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetNotice1:Str250;          procedure SetNotice1 (pValue:Str250);
    function GetNotice2:Str250;          procedure SetNotice2 (pValue:Str250);
    function GetNotice3:Str250;          procedure SetNotice3 (pValue:Str250);
    function GetNotice4:Str250;          procedure SetNotice4 (pValue:Str250);
    function GetNotice5:Str250;          procedure SetNotice5 (pValue:Str250);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDocNum (pDocNum:Str12):boolean;

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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:longint read GetSerNum write SetSerNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str30 read GetRegAdr write SetRegAdr;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property RegStn:Str30 read GetRegStn write SetRegStn;
    property CtpNam:Str30 read GetCtpNam write SetCtpNam;
    property CtpTel:Str20 read GetCtpTel write SetCtpTel;
    property CtpEml:Str30 read GetCtpEml write SetCtpEml;
    property ProBva:double read GetProBva write SetProBva;
    property BwrAva:double read GetBwrAva write SetBwrAva;
    property BwrBva:double read GetBwrBva write SetBwrBva;
    property CauVal:double read GetCauVal write SetCauVal;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property OutQnt:word read GetOutQnt write SetOutQnt;
    property ItmNum:word read GetItmNum write SetItmNum;
    property TcdNum:Str13 read GetTcdNum write SetTcdNum;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property PrnUsr:Str15 read GetPrnUsr write SetPrnUsr;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property PrnTim:TDatetime read GetPrnTim write SetPrnTim;
    property DocDes:Str100 read GetDocDes write SetDocDes;
    property WarNum:byte read GetWarNum write SetWarNum;
    property WarDte:TDatetime read GetWarDte write SetWarDte;
    property EdiUsr:Str15 read GetEdiUsr write SetEdiUsr;
    property EdiDte:TDatetime read GetEdiDte write SetEdiDte;
    property EdiTim:TDatetime read GetEdiTim write SetEdiTim;
    property CrtUsr:Str15 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property Notice1:Str250 read GetNotice1 write SetNotice1;
    property Notice2:Str250 read GetNotice2 write SetNotice2;
    property Notice3:Str250 read GetNotice3 write SetNotice3;
    property Notice4:Str250 read GetNotice4 write SetNotice4;
    property Notice5:Str250 read GetNotice5 write SetNotice5;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TBwhprnTmp.Create;
begin
  oTmpTable:=TmpInit ('BWHPRN',Self);
end;

destructor TBwhprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBwhprnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TBwhprnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TBwhprnTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TBwhprnTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TBwhprnTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TBwhprnTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBwhprnTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TBwhprnTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TBwhprnTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TBwhprnTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TBwhprnTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TBwhprnTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetBegDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('BegDte').AsDateTime;
end;

procedure TBwhprnTmp.SetBegDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetEndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EndDte').AsDateTime;
end;

procedure TBwhprnTmp.SetEndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TBwhprnTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBwhprnTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TBwhprnTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TBwhprnTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TBwhprnTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TBwhprnTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TBwhprnTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TBwhprnTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TBwhprnTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TBwhprnTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TBwhprnTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TBwhprnTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TBwhprnTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TBwhprnTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TBwhprnTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TBwhprnTmp.GetRegStn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TBwhprnTmp.SetRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString:=pValue;
end;

function TBwhprnTmp.GetCtpNam:Str30;
begin
  Result:=oTmpTable.FieldByName('CtpNam').AsString;
end;

procedure TBwhprnTmp.SetCtpNam(pValue:Str30);
begin
  oTmpTable.FieldByName('CtpNam').AsString:=pValue;
end;

function TBwhprnTmp.GetCtpTel:Str20;
begin
  Result:=oTmpTable.FieldByName('CtpTel').AsString;
end;

procedure TBwhprnTmp.SetCtpTel(pValue:Str20);
begin
  oTmpTable.FieldByName('CtpTel').AsString:=pValue;
end;

function TBwhprnTmp.GetCtpEml:Str30;
begin
  Result:=oTmpTable.FieldByName('CtpEml').AsString;
end;

procedure TBwhprnTmp.SetCtpEml(pValue:Str30);
begin
  oTmpTable.FieldByName('CtpEml').AsString:=pValue;
end;

function TBwhprnTmp.GetProBva:double;
begin
  Result:=oTmpTable.FieldByName('ProBva').AsFloat;
end;

procedure TBwhprnTmp.SetProBva(pValue:double);
begin
  oTmpTable.FieldByName('ProBva').AsFloat:=pValue;
end;

function TBwhprnTmp.GetBwrAva:double;
begin
  Result:=oTmpTable.FieldByName('BwrAva').AsFloat;
end;

procedure TBwhprnTmp.SetBwrAva(pValue:double);
begin
  oTmpTable.FieldByName('BwrAva').AsFloat:=pValue;
end;

function TBwhprnTmp.GetBwrBva:double;
begin
  Result:=oTmpTable.FieldByName('BwrBva').AsFloat;
end;

procedure TBwhprnTmp.SetBwrBva(pValue:double);
begin
  oTmpTable.FieldByName('BwrBva').AsFloat:=pValue;
end;

function TBwhprnTmp.GetCauVal:double;
begin
  Result:=oTmpTable.FieldByName('CauVal').AsFloat;
end;

procedure TBwhprnTmp.SetCauVal(pValue:double);
begin
  oTmpTable.FieldByName('CauVal').AsFloat:=pValue;
end;

function TBwhprnTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TBwhprnTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TBwhprnTmp.GetOutQnt:word;
begin
  Result:=oTmpTable.FieldByName('OutQnt').AsInteger;
end;

procedure TBwhprnTmp.SetOutQnt(pValue:word);
begin
  oTmpTable.FieldByName('OutQnt').AsInteger:=pValue;
end;

function TBwhprnTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TBwhprnTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TBwhprnTmp.GetTcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TBwhprnTmp.SetTcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TBwhprnTmp.GetPrnCnt:byte;
begin
  Result:=oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TBwhprnTmp.SetPrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TBwhprnTmp.GetPrnUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('PrnUsr').AsString;
end;

procedure TBwhprnTmp.SetPrnUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('PrnUsr').AsString:=pValue;
end;

function TBwhprnTmp.GetPrnDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TBwhprnTmp.SetPrnDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetPrnTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnTim').AsDateTime;
end;

procedure TBwhprnTmp.SetPrnTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnTim').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetDocDes:Str100;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TBwhprnTmp.SetDocDes(pValue:Str100);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TBwhprnTmp.GetWarNum:byte;
begin
  Result:=oTmpTable.FieldByName('WarNum').AsInteger;
end;

procedure TBwhprnTmp.SetWarNum(pValue:byte);
begin
  oTmpTable.FieldByName('WarNum').AsInteger:=pValue;
end;

function TBwhprnTmp.GetWarDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('WarDte').AsDateTime;
end;

procedure TBwhprnTmp.SetWarDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WarDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetEdiUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('EdiUsr').AsString;
end;

procedure TBwhprnTmp.SetEdiUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TBwhprnTmp.GetEdiDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TBwhprnTmp.SetEdiDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetEdiTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TBwhprnTmp.SetEdiTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetCrtUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TBwhprnTmp.SetCrtUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBwhprnTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TBwhprnTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBwhprnTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBwhprnTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBwhprnTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBwhprnTmp.GetNotice1:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice1').AsString;
end;

procedure TBwhprnTmp.SetNotice1(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice1').AsString:=pValue;
end;

function TBwhprnTmp.GetNotice2:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TBwhprnTmp.SetNotice2(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice2').AsString:=pValue;
end;

function TBwhprnTmp.GetNotice3:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice3').AsString;
end;

procedure TBwhprnTmp.SetNotice3(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice3').AsString:=pValue;
end;

function TBwhprnTmp.GetNotice4:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice4').AsString;
end;

procedure TBwhprnTmp.SetNotice4(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice4').AsString:=pValue;
end;

function TBwhprnTmp.GetNotice5:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice5').AsString;
end;

procedure TBwhprnTmp.SetNotice5(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice5').AsString:=pValue;
end;

function TBwhprnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TBwhprnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBwhprnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TBwhprnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TBwhprnTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

procedure TBwhprnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TBwhprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBwhprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBwhprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBwhprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBwhprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TBwhprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBwhprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBwhprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBwhprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBwhprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBwhprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBwhprnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBwhprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBwhprnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBwhprnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TBwhprnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
