unit tSTKFIF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum='';
  ixDnIn='DnIn';
  ixDocDte='DocDte';
  ixParNum='ParNum';
  ixParNam_='ParNam_';
  ixBegSta='BegSta';
  ixIncTyp='IncTyp';
  ixRbaCod='RbaCod';
  ixRbaDte='RbaDte';

type
  TStkfifTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetFifNum:longint;          procedure SetFifNum (pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetIncPrq:double;           procedure SetIncPrq (pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq (pValue:double);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetActSta:Str1;             procedure SetActSta (pValue:Str1);
    function GetIncCpc:double;           procedure SetIncCpc (pValue:double);
    function GetIncCva:double;           procedure SetIncCva (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetIncTyp:Str1;             procedure SetIncTyp (pValue:Str1);
    function GetBegSta:Str1;             procedure SetBegSta (pValue:Str1);
    function GetRbaCod:Str30;            procedure SetRbaCod (pValue:Str30);
    function GetRbaDte:TDatetime;        procedure SetRbaDte (pValue:TDatetime);
    function GetCrtUsr:str10;            procedure SetCrtUsr (pValue:str10);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocFifNum (pFifNum:longint):boolean;
    function LocDnIn (pDocNum:Str12;pItmNum:longint):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocBegSta (pBegSta:Str1):boolean;
    function LocIncTyp (pIncTyp:Str1):boolean;
    function LocRbaCod (pRbaCod:Str30):boolean;
    function LocRbaDte (pRbaDte:TDatetime):boolean;

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
    property FifNum:longint read GetFifNum write SetFifNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property IncPrq:double read GetIncPrq write SetIncPrq;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property ActPrq:double read GetActPrq write SetActPrq;
    property ActSta:Str1 read GetActSta write SetActSta;
    property IncCpc:double read GetIncCpc write SetIncCpc;
    property IncCva:double read GetIncCva write SetIncCva;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property IncTyp:Str1 read GetIncTyp write SetIncTyp;
    property BegSta:Str1 read GetBegSta write SetBegSta;
    property RbaCod:Str30 read GetRbaCod write SetRbaCod;
    property RbaDte:TDatetime read GetRbaDte write SetRbaDte;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TStkfifTmp.Create;
begin
  oTmpTable:=TmpInit ('STKFIF',Self);
end;

destructor TStkfifTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkfifTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkfifTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkfifTmp.GetFifNum:longint;
begin
  Result:=oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TStkfifTmp.SetFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TStkfifTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStkfifTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkfifTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkfifTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkfifTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkfifTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkfifTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TStkfifTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TStkfifTmp.GetIncPrq:double;
begin
  Result:=oTmpTable.FieldByName('IncPrq').AsFloat;
end;

procedure TStkfifTmp.SetIncPrq(pValue:double);
begin
  oTmpTable.FieldByName('IncPrq').AsFloat:=pValue;
end;

function TStkfifTmp.GetOutPrq:double;
begin
  Result:=oTmpTable.FieldByName('OutPrq').AsFloat;
end;

procedure TStkfifTmp.SetOutPrq(pValue:double);
begin
  oTmpTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TStkfifTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkfifTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkfifTmp.GetActSta:Str1;
begin
  Result:=oTmpTable.FieldByName('ActSta').AsString;
end;

procedure TStkfifTmp.SetActSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ActSta').AsString:=pValue;
end;

function TStkfifTmp.GetIncCpc:double;
begin
  Result:=oTmpTable.FieldByName('IncCpc').AsFloat;
end;

procedure TStkfifTmp.SetIncCpc(pValue:double);
begin
  oTmpTable.FieldByName('IncCpc').AsFloat:=pValue;
end;

function TStkfifTmp.GetIncCva:double;
begin
  Result:=oTmpTable.FieldByName('IncCva').AsFloat;
end;

procedure TStkfifTmp.SetIncCva(pValue:double);
begin
  oTmpTable.FieldByName('IncCva').AsFloat:=pValue;
end;

function TStkfifTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TStkfifTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TStkfifTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TStkfifTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TStkfifTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TStkfifTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TStkfifTmp.GetIncTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('IncTyp').AsString;
end;

procedure TStkfifTmp.SetIncTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('IncTyp').AsString:=pValue;
end;

function TStkfifTmp.GetBegSta:Str1;
begin
  Result:=oTmpTable.FieldByName('BegSta').AsString;
end;

procedure TStkfifTmp.SetBegSta(pValue:Str1);
begin
  oTmpTable.FieldByName('BegSta').AsString:=pValue;
end;

function TStkfifTmp.GetRbaCod:Str30;
begin
  Result:=oTmpTable.FieldByName('RbaCod').AsString;
end;

procedure TStkfifTmp.SetRbaCod(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCod').AsString:=pValue;
end;

function TStkfifTmp.GetRbaDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RbaDte').AsDateTime;
end;

procedure TStkfifTmp.SetRbaDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDte').AsDateTime:=pValue;
end;

function TStkfifTmp.GetCrtUsr:str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkfifTmp.SetCrtUsr(pValue:str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkfifTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkfifTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkfifTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkfifTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TStkfifTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkfifTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkfifTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkfifTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkfifTmp.LocFifNum(pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result:=oTmpTable.FindKey([pFifNum]);
end;

function TStkfifTmp.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStkfifTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TStkfifTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TStkfifTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TStkfifTmp.LocBegSta(pBegSta:Str1):boolean;
begin
  SetIndex (ixBegSta);
  Result:=oTmpTable.FindKey([pBegSta]);
end;

function TStkfifTmp.LocIncTyp(pIncTyp:Str1):boolean;
begin
  SetIndex (ixIncTyp);
  Result:=oTmpTable.FindKey([pIncTyp]);
end;

function TStkfifTmp.LocRbaCod(pRbaCod:Str30):boolean;
begin
  SetIndex (ixRbaCod);
  Result:=oTmpTable.FindKey([pRbaCod]);
end;

function TStkfifTmp.LocRbaDte(pRbaDte:TDatetime):boolean;
begin
  SetIndex (ixRbaDte);
  Result:=oTmpTable.FindKey([pRbaDte]);
end;

procedure TStkfifTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkfifTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkfifTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkfifTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkfifTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkfifTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkfifTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkfifTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkfifTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkfifTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkfifTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkfifTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkfifTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkfifTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkfifTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkfifTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkfifTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
