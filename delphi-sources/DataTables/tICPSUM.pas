unit tICPSUM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='';
  ixRegIno='RegIno';
  ixParNam_='ParNam_';
  ixEndBva='EndBva';

type
  TIcpsumTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAdr:Str30;            procedure SetRegAdr (pValue:Str30);
    function GetRegSta:Str2;             procedure SetRegSta (pValue:Str2);
    function GetRegCty:Str3;             procedure SetRegCty (pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetEndDte:TDatetime;        procedure SetEndDte (pValue:TDatetime);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetPayVal:double;           procedure SetPayVal (pValue:double);
    function GetEndVal:double;           procedure SetEndVal (pValue:double);
    function GetDocQnt:word;             procedure SetDocQnt (pValue:word);
    function GetPrnSta:Str1;             procedure SetPrnSta (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocRegIno (pRegIno:Str15):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocEndBva (pEndBva:double):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str30 read GetRegAdr write SetRegAdr;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property RegCty:Str3 read GetRegCty write SetRegCty;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property EndBva:double read GetEndBva write SetEndBva;
    property PayVal:double read GetPayVal write SetPayVal;
    property EndVal:double read GetEndVal write SetEndVal;
    property DocQnt:word read GetDocQnt write SetDocQnt;
    property PrnSta:Str1 read GetPrnSta write SetPrnSta;
  end;

implementation

constructor TIcpsumTmp.Create;
begin
  oTmpTable:=TmpInit ('ICPSUM',Self);
end;

destructor TIcpsumTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIcpsumTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIcpsumTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIcpsumTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TIcpsumTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIcpsumTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TIcpsumTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TIcpsumTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TIcpsumTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TIcpsumTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TIcpsumTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TIcpsumTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TIcpsumTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TIcpsumTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TIcpsumTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TIcpsumTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TIcpsumTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TIcpsumTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TIcpsumTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TIcpsumTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TIcpsumTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TIcpsumTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TIcpsumTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TIcpsumTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TIcpsumTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TIcpsumTmp.GetEndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EndDte').AsDateTime;
end;

procedure TIcpsumTmp.SetEndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TIcpsumTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TIcpsumTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TIcpsumTmp.GetPayVal:double;
begin
  Result:=oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TIcpsumTmp.SetPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TIcpsumTmp.GetEndVal:double;
begin
  Result:=oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TIcpsumTmp.SetEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat:=pValue;
end;

function TIcpsumTmp.GetDocQnt:word;
begin
  Result:=oTmpTable.FieldByName('DocQnt').AsInteger;
end;

procedure TIcpsumTmp.SetDocQnt(pValue:word);
begin
  oTmpTable.FieldByName('DocQnt').AsInteger:=pValue;
end;

function TIcpsumTmp.GetPrnSta:Str1;
begin
  Result:=oTmpTable.FieldByName('PrnSta').AsString;
end;

procedure TIcpsumTmp.SetPrnSta(pValue:Str1);
begin
  oTmpTable.FieldByName('PrnSta').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcpsumTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIcpsumTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIcpsumTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TIcpsumTmp.LocRegIno(pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result:=oTmpTable.FindKey([pRegIno]);
end;

function TIcpsumTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TIcpsumTmp.LocEndBva(pEndBva:double):boolean;
begin
  SetIndex (ixEndBva);
  Result:=oTmpTable.FindKey([pEndBva]);
end;

procedure TIcpsumTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIcpsumTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIcpsumTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIcpsumTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIcpsumTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIcpsumTmp.First;
begin
  oTmpTable.First;
end;

procedure TIcpsumTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIcpsumTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIcpsumTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIcpsumTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIcpsumTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIcpsumTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIcpsumTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIcpsumTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIcpsumTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIcpsumTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIcpsumTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
