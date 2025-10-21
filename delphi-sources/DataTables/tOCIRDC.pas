unit tOCIRDC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixProNum='ProNum';
  ixProNam_='ProNam_';

type
  TOcirdcTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetReqPrq1:double;          procedure SetReqPrq1 (pValue:double);
    function GetRstPrq1:double;          procedure SetRstPrq1 (pValue:double);
    function GetRosPrq1:double;          procedure SetRosPrq1 (pValue:double);
    function GetRatDte1:TDatetime;       procedure SetRatDte1 (pValue:TDatetime);
    function GetReqPrq2:double;          procedure SetReqPrq2 (pValue:double);
    function GetRstPrq2:double;          procedure SetRstPrq2 (pValue:double);
    function GetRosPrq2:double;          procedure SetRosPrq2 (pValue:double);
    function GetRatDte2:TDatetime;       procedure SetRatDte2 (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
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
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property ReqPrq1:double read GetReqPrq1 write SetReqPrq1;
    property RstPrq1:double read GetRstPrq1 write SetRstPrq1;
    property RosPrq1:double read GetRosPrq1 write SetRosPrq1;
    property RatDte1:TDatetime read GetRatDte1 write SetRatDte1;
    property ReqPrq2:double read GetReqPrq2 write SetReqPrq2;
    property RstPrq2:double read GetRstPrq2 write SetRstPrq2;
    property RosPrq2:double read GetRosPrq2 write SetRosPrq2;
    property RatDte2:TDatetime read GetRatDte2 write SetRatDte2;
  end;

implementation

constructor TOcirdcTmp.Create;
begin
  oTmpTable:=TmpInit ('OCIRDC',Self);
end;

destructor TOcirdcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOcirdcTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOcirdcTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOcirdcTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOcirdcTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOcirdcTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcirdcTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcirdcTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcirdcTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcirdcTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOcirdcTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcirdcTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOcirdcTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOcirdcTmp.GetReqPrq1:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq1').AsFloat;
end;

procedure TOcirdcTmp.SetReqPrq1(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq1').AsFloat:=pValue;
end;

function TOcirdcTmp.GetRstPrq1:double;
begin
  Result:=oTmpTable.FieldByName('RstPrq1').AsFloat;
end;

procedure TOcirdcTmp.SetRstPrq1(pValue:double);
begin
  oTmpTable.FieldByName('RstPrq1').AsFloat:=pValue;
end;

function TOcirdcTmp.GetRosPrq1:double;
begin
  Result:=oTmpTable.FieldByName('RosPrq1').AsFloat;
end;

procedure TOcirdcTmp.SetRosPrq1(pValue:double);
begin
  oTmpTable.FieldByName('RosPrq1').AsFloat:=pValue;
end;

function TOcirdcTmp.GetRatDte1:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte1').AsDateTime;
end;

procedure TOcirdcTmp.SetRatDte1(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte1').AsDateTime:=pValue;
end;

function TOcirdcTmp.GetReqPrq2:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq2').AsFloat;
end;

procedure TOcirdcTmp.SetReqPrq2(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq2').AsFloat:=pValue;
end;

function TOcirdcTmp.GetRstPrq2:double;
begin
  Result:=oTmpTable.FieldByName('RstPrq2').AsFloat;
end;

procedure TOcirdcTmp.SetRstPrq2(pValue:double);
begin
  oTmpTable.FieldByName('RstPrq2').AsFloat:=pValue;
end;

function TOcirdcTmp.GetRosPrq2:double;
begin
  Result:=oTmpTable.FieldByName('RosPrq2').AsFloat;
end;

procedure TOcirdcTmp.SetRosPrq2(pValue:double);
begin
  oTmpTable.FieldByName('RosPrq2').AsFloat:=pValue;
end;

function TOcirdcTmp.GetRatDte2:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte2').AsDateTime;
end;

procedure TOcirdcTmp.SetRatDte2(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte2').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcirdcTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOcirdcTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOcirdcTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TOcirdcTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOcirdcTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TOcirdcTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOcirdcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOcirdcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOcirdcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOcirdcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOcirdcTmp.First;
begin
  oTmpTable.First;
end;

procedure TOcirdcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOcirdcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOcirdcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOcirdcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOcirdcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOcirdcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOcirdcTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOcirdcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOcirdcTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOcirdcTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOcirdcTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
