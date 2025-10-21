unit tEBAIMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum='';
  ixBacNum='BacNum';
  ixConSym='ConSym';
  ixVarSym='VarSym';
  ixSpcSym='SpcSym';
  ixStatus='Status';

type
  TEbaimpTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetRowNum:word;             procedure SetRowNum (pValue:word);
    function GetPayDte:TDatetime;        procedure SetPayDte (pValue:TDatetime);
    function GetBacNum:Str30;            procedure SetBacNum (pValue:Str30);
    function GetPayVal:double;           procedure SetPayVal (pValue:double);
    function GetPdfVal:double;           procedure SetPdfVal (pValue:double);
    function GetConSym:Str4;             procedure SetConSym (pValue:Str4);
    function GetVarSym:Str15;            procedure SetVarSym (pValue:Str15);
    function GetSpcSym:Str15;            procedure SetSpcSym (pValue:Str15);
    function GetNotice:Str60;            procedure SetNotice (pValue:Str60);
    function GetItmDes:Str60;            procedure SetItmDes (pValue:Str60);
    function GetBokNum:Str5;             procedure SetBokNum (pValue:Str5);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetConDoc:Str12;            procedure SetConDoc (pValue:Str12);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetCntNum:word;             procedure SetCntNum (pValue:word);
    function GetDocSnt:Str3;             procedure SetDocSnt (pValue:Str3);
    function GetDocAnl:Str6;             procedure SetDocAnl (pValue:Str6);
    function GetStatus:Str1;             procedure SetStatus (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocRowNum (pRowNum:word):boolean;
    function LocBacNum (pBacNum:Str30):boolean;
    function LocConSym (pConSym:Str4):boolean;
    function LocVarSym (pVarSym:Str15):boolean;
    function LocSpcSym (pSpcSym:Str15):boolean;
    function LocStatus (pStatus:Str1):boolean;

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
    property RowNum:word read GetRowNum write SetRowNum;
    property PayDte:TDatetime read GetPayDte write SetPayDte;
    property BacNum:Str30 read GetBacNum write SetBacNum;
    property PayVal:double read GetPayVal write SetPayVal;
    property PdfVal:double read GetPdfVal write SetPdfVal;
    property ConSym:Str4 read GetConSym write SetConSym;
    property VarSym:Str15 read GetVarSym write SetVarSym;
    property SpcSym:Str15 read GetSpcSym write SetSpcSym;
    property Notice:Str60 read GetNotice write SetNotice;
    property ItmDes:Str60 read GetItmDes write SetItmDes;
    property BokNum:Str5 read GetBokNum write SetBokNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property ConDoc:Str12 read GetConDoc write SetConDoc;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property WriNum:word read GetWriNum write SetWriNum;
    property CntNum:word read GetCntNum write SetCntNum;
    property DocSnt:Str3 read GetDocSnt write SetDocSnt;
    property DocAnl:Str6 read GetDocAnl write SetDocAnl;
    property Status:Str1 read GetStatus write SetStatus;
  end;

implementation

constructor TEbaimpTmp.Create;
begin
  oTmpTable:=TmpInit ('EBAIMP',Self);
end;

destructor TEbaimpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEbaimpTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TEbaimpTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TEbaimpTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TEbaimpTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TEbaimpTmp.GetPayDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayDte').AsDateTime;
end;

procedure TEbaimpTmp.SetPayDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TEbaimpTmp.GetBacNum:Str30;
begin
  Result:=oTmpTable.FieldByName('BacNum').AsString;
end;

procedure TEbaimpTmp.SetBacNum(pValue:Str30);
begin
  oTmpTable.FieldByName('BacNum').AsString:=pValue;
end;

function TEbaimpTmp.GetPayVal:double;
begin
  Result:=oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TEbaimpTmp.SetPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TEbaimpTmp.GetPdfVal:double;
begin
  Result:=oTmpTable.FieldByName('PdfVal').AsFloat;
end;

procedure TEbaimpTmp.SetPdfVal(pValue:double);
begin
  oTmpTable.FieldByName('PdfVal').AsFloat:=pValue;
end;

function TEbaimpTmp.GetConSym:Str4;
begin
  Result:=oTmpTable.FieldByName('ConSym').AsString;
end;

procedure TEbaimpTmp.SetConSym(pValue:Str4);
begin
  oTmpTable.FieldByName('ConSym').AsString:=pValue;
end;

function TEbaimpTmp.GetVarSym:Str15;
begin
  Result:=oTmpTable.FieldByName('VarSym').AsString;
end;

procedure TEbaimpTmp.SetVarSym(pValue:Str15);
begin
  oTmpTable.FieldByName('VarSym').AsString:=pValue;
end;

function TEbaimpTmp.GetSpcSym:Str15;
begin
  Result:=oTmpTable.FieldByName('SpcSym').AsString;
end;

procedure TEbaimpTmp.SetSpcSym(pValue:Str15);
begin
  oTmpTable.FieldByName('SpcSym').AsString:=pValue;
end;

function TEbaimpTmp.GetNotice:Str60;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TEbaimpTmp.SetNotice(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TEbaimpTmp.GetItmDes:Str60;
begin
  Result:=oTmpTable.FieldByName('ItmDes').AsString;
end;

procedure TEbaimpTmp.SetItmDes(pValue:Str60);
begin
  oTmpTable.FieldByName('ItmDes').AsString:=pValue;
end;

function TEbaimpTmp.GetBokNum:Str5;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TEbaimpTmp.SetBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TEbaimpTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TEbaimpTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TEbaimpTmp.GetConDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TEbaimpTmp.SetConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString:=pValue;
end;

function TEbaimpTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TEbaimpTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TEbaimpTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TEbaimpTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TEbaimpTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TEbaimpTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TEbaimpTmp.GetCntNum:word;
begin
  Result:=oTmpTable.FieldByName('CntNum').AsInteger;
end;

procedure TEbaimpTmp.SetCntNum(pValue:word);
begin
  oTmpTable.FieldByName('CntNum').AsInteger:=pValue;
end;

function TEbaimpTmp.GetDocSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TEbaimpTmp.SetDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString:=pValue;
end;

function TEbaimpTmp.GetDocAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TEbaimpTmp.SetDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString:=pValue;
end;

function TEbaimpTmp.GetStatus:Str1;
begin
  Result:=oTmpTable.FieldByName('Status').AsString;
end;

procedure TEbaimpTmp.SetStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEbaimpTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TEbaimpTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TEbaimpTmp.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result:=oTmpTable.FindKey([pRowNum]);
end;

function TEbaimpTmp.LocBacNum(pBacNum:Str30):boolean;
begin
  SetIndex (ixBacNum);
  Result:=oTmpTable.FindKey([pBacNum]);
end;

function TEbaimpTmp.LocConSym(pConSym:Str4):boolean;
begin
  SetIndex (ixConSym);
  Result:=oTmpTable.FindKey([pConSym]);
end;

function TEbaimpTmp.LocVarSym(pVarSym:Str15):boolean;
begin
  SetIndex (ixVarSym);
  Result:=oTmpTable.FindKey([pVarSym]);
end;

function TEbaimpTmp.LocSpcSym(pSpcSym:Str15):boolean;
begin
  SetIndex (ixSpcSym);
  Result:=oTmpTable.FindKey([pSpcSym]);
end;

function TEbaimpTmp.LocStatus(pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result:=oTmpTable.FindKey([pStatus]);
end;

procedure TEbaimpTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TEbaimpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEbaimpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEbaimpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEbaimpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEbaimpTmp.First;
begin
  oTmpTable.First;
end;

procedure TEbaimpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEbaimpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEbaimpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEbaimpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEbaimpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEbaimpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEbaimpTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEbaimpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEbaimpTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEbaimpTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TEbaimpTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
