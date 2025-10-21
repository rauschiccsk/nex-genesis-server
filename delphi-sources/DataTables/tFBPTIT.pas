unit tFBPTIT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrtDte='';

type
  TFbptitTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetAbeDte:TDatetime;        procedure SetAbeDte (pValue:TDatetime);
    function GetAenDte:TDatetime;        procedure SetAenDte (pValue:TDatetime);
    function GetPbeDte:TDatetime;        procedure SetPbeDte (pValue:TDatetime);
    function GetPenDte:TDatetime;        procedure SetPenDte (pValue:TDatetime);
    function GetRegNam:Str60;            procedure SetRegNam (pValue:Str60);
    function GetRegIno:Str10;            procedure SetRegIno (pValue:Str10);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetSkNace:Str10;            procedure SetSkNace (pValue:Str10);
    function GetRegAdr:Str30;            procedure SetRegAdr (pValue:Str30);
    function GetRegAdn:Str10;            procedure SetRegAdn (pValue:Str10);
    function GetRegZip:Str10;            procedure SetRegZip (pValue:Str10);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegTel:Str20;            procedure SetRegTel (pValue:Str20);
    function GetRegFax:Str20;            procedure SetRegFax (pValue:Str20);
    function GetRegEml:Str30;            procedure SetRegEml (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocCrtDte (pCrtDte:TDatetime):boolean;

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
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property AbeDte:TDatetime read GetAbeDte write SetAbeDte;
    property AenDte:TDatetime read GetAenDte write SetAenDte;
    property PbeDte:TDatetime read GetPbeDte write SetPbeDte;
    property PenDte:TDatetime read GetPenDte write SetPenDte;
    property RegNam:Str60 read GetRegNam write SetRegNam;
    property RegIno:Str10 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property SkNace:Str10 read GetSkNace write SetSkNace;
    property RegAdr:Str30 read GetRegAdr write SetRegAdr;
    property RegAdn:Str10 read GetRegAdn write SetRegAdn;
    property RegZip:Str10 read GetRegZip write SetRegZip;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegTel:Str20 read GetRegTel write SetRegTel;
    property RegFax:Str20 read GetRegFax write SetRegFax;
    property RegEml:Str30 read GetRegEml write SetRegEml;
  end;

implementation

constructor TFbptitTmp.Create;
begin
  oTmpTable:=TmpInit ('FBPTIT',Self);
end;

destructor TFbptitTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFbptitTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TFbptitTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TFbptitTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TFbptitTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TFbptitTmp.GetAbeDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('AbeDte').AsDateTime;
end;

procedure TFbptitTmp.SetAbeDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AbeDte').AsDateTime:=pValue;
end;

function TFbptitTmp.GetAenDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('AenDte').AsDateTime;
end;

procedure TFbptitTmp.SetAenDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AenDte').AsDateTime:=pValue;
end;

function TFbptitTmp.GetPbeDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PbeDte').AsDateTime;
end;

procedure TFbptitTmp.SetPbeDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PbeDte').AsDateTime:=pValue;
end;

function TFbptitTmp.GetPenDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PenDte').AsDateTime;
end;

procedure TFbptitTmp.SetPenDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PenDte').AsDateTime:=pValue;
end;

function TFbptitTmp.GetRegNam:Str60;
begin
  Result:=oTmpTable.FieldByName('RegNam').AsString;
end;

procedure TFbptitTmp.SetRegNam(pValue:Str60);
begin
  oTmpTable.FieldByName('RegNam').AsString:=pValue;
end;

function TFbptitTmp.GetRegIno:Str10;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TFbptitTmp.SetRegIno(pValue:Str10);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TFbptitTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TFbptitTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TFbptitTmp.GetSkNace:Str10;
begin
  Result:=oTmpTable.FieldByName('SkNace').AsString;
end;

procedure TFbptitTmp.SetSkNace(pValue:Str10);
begin
  oTmpTable.FieldByName('SkNace').AsString:=pValue;
end;

function TFbptitTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TFbptitTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TFbptitTmp.GetRegAdn:Str10;
begin
  Result:=oTmpTable.FieldByName('RegAdn').AsString;
end;

procedure TFbptitTmp.SetRegAdn(pValue:Str10);
begin
  oTmpTable.FieldByName('RegAdn').AsString:=pValue;
end;

function TFbptitTmp.GetRegZip:Str10;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TFbptitTmp.SetRegZip(pValue:Str10);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TFbptitTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TFbptitTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TFbptitTmp.GetRegTel:Str20;
begin
  Result:=oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TFbptitTmp.SetRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString:=pValue;
end;

function TFbptitTmp.GetRegFax:Str20;
begin
  Result:=oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TFbptitTmp.SetRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString:=pValue;
end;

function TFbptitTmp.GetRegEml:Str30;
begin
  Result:=oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TFbptitTmp.SetRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TFbptitTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TFbptitTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TFbptitTmp.LocCrtDte(pCrtDte:TDatetime):boolean;
begin
  SetIndex (ixCrtDte);
  Result:=oTmpTable.FindKey([pCrtDte]);
end;

procedure TFbptitTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TFbptitTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFbptitTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFbptitTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFbptitTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFbptitTmp.First;
begin
  oTmpTable.First;
end;

procedure TFbptitTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFbptitTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFbptitTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFbptitTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFbptitTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFbptitTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFbptitTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFbptitTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFbptitTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFbptitTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TFbptitTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
