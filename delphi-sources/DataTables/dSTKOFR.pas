unit dSTKOFR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='StkNum';
  ixSnGc='SnGc';
  ixSnPa='SnPa';
  ixSnGcPa='SnGcPa';
  ixStatus='Status';

type
  TStkofrDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetGsCode:longint;          procedure SetGsCode(pValue:longint);
    function GetPaCode:longint;          procedure SetPaCode(pValue:longint);
    function GetOfrQnt:double;           procedure SetOfrQnt(pValue:double);
    function GetStatus:Str1;             procedure SetStatus(pValue:Str1);
    function GetModUser:Str10;           procedure SetModUser(pValue:Str10);
    function GetModDate:TDatetime;       procedure SetModDate(pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime(pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocStkNum(pStkNum:word):boolean;
    function LocSnGc(pStkNum:word;pGsCode:longint):boolean;
    function LocSnPa(pStkNum:word;pPaCode:longint):boolean;
    function LocSnGcPa(pStkNum:word;pGsCode:longint;pPaCode:longint):boolean;
    function LocStatus(pStatus:Str1):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearSnGc(pStkNum:word;pGsCode:longint):boolean;
    function NearSnPa(pStkNum:word;pPaCode:longint):boolean;
    function NearSnGcPa(pStkNum:word;pGsCode:longint;pPaCode:longint):boolean;
    function NearStatus(pStatus:Str1):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property StkNum:word read GetStkNum write SetStkNum;
    property GsCode:longint read GetGsCode write SetGsCode;
    property PaCode:longint read GetPaCode write SetPaCode;
    property OfrQnt:double read GetOfrQnt write SetOfrQnt;
    property Status:Str1 read GetStatus write SetStatus;
    property ModUser:Str10 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
  end;

implementation

constructor TStkofrDat.Create;
begin
  oTable:=DatInit('STKOFR',gPath.StkPath,Self);
end;

constructor TStkofrDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKOFR',pPath,Self);
end;

destructor TStkofrDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStkofrDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStkofrDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStkofrDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkofrDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkofrDat.GetGsCode:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TStkofrDat.SetGsCode(pValue:longint);
begin
  oTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TStkofrDat.GetPaCode:longint;
begin
  Result:=oTable.FieldByName('PaCode').AsInteger;
end;

procedure TStkofrDat.SetPaCode(pValue:longint);
begin
  oTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TStkofrDat.GetOfrQnt:double;
begin
  Result:=oTable.FieldByName('OfrQnt').AsFloat;
end;

procedure TStkofrDat.SetOfrQnt(pValue:double);
begin
  oTable.FieldByName('OfrQnt').AsFloat:=pValue;
end;

function TStkofrDat.GetStatus:Str1;
begin
  Result:=oTable.FieldByName('Status').AsString;
end;

procedure TStkofrDat.SetStatus(pValue:Str1);
begin
  oTable.FieldByName('Status').AsString:=pValue;
end;

function TStkofrDat.GetModUser:Str10;
begin
  Result:=oTable.FieldByName('ModUser').AsString;
end;

procedure TStkofrDat.SetModUser(pValue:Str10);
begin
  oTable.FieldByName('ModUser').AsString:=pValue;
end;

function TStkofrDat.GetModDate:TDatetime;
begin
  Result:=oTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStkofrDat.SetModDate(pValue:TDatetime);
begin
  oTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TStkofrDat.GetModTime:TDatetime;
begin
  Result:=oTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStkofrDat.SetModTime(pValue:TDatetime);
begin
  oTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkofrDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStkofrDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStkofrDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStkofrDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStkofrDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStkofrDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TStkofrDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStkofrDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStkofrDat.LocSnGc(pStkNum:word;pGsCode:longint):boolean;
begin
  SetIndex(ixSnGc);
  Result:=oTable.FindKey([pStkNum,pGsCode]);
end;

function TStkofrDat.LocSnPa(pStkNum:word;pPaCode:longint):boolean;
begin
  SetIndex(ixSnPa);
  Result:=oTable.FindKey([pStkNum,pPaCode]);
end;

function TStkofrDat.LocSnGcPa(pStkNum:word;pGsCode:longint;pPaCode:longint):boolean;
begin
  SetIndex(ixSnGcPa);
  Result:=oTable.FindKey([pStkNum,pGsCode,pPaCode]);
end;

function TStkofrDat.LocStatus(pStatus:Str1):boolean;
begin
  SetIndex(ixStatus);
  Result:=oTable.FindKey([pStatus]);
end;

function TStkofrDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStkofrDat.NearSnGc(pStkNum:word;pGsCode:longint):boolean;
begin
  SetIndex(ixSnGc);
  Result:=oTable.FindNearest([pStkNum,pGsCode]);
end;

function TStkofrDat.NearSnPa(pStkNum:word;pPaCode:longint):boolean;
begin
  SetIndex(ixSnPa);
  Result:=oTable.FindNearest([pStkNum,pPaCode]);
end;

function TStkofrDat.NearSnGcPa(pStkNum:word;pGsCode:longint;pPaCode:longint):boolean;
begin
  SetIndex(ixSnGcPa);
  Result:=oTable.FindNearest([pStkNum,pGsCode,pPaCode]);
end;

function TStkofrDat.NearStatus(pStatus:Str1):boolean;
begin
  SetIndex(ixStatus);
  Result:=oTable.FindNearest([pStatus]);
end;

procedure TStkofrDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStkofrDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStkofrDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStkofrDat.Prior;
begin
  oTable.Prior;
end;

procedure TStkofrDat.Next;
begin
  oTable.Next;
end;

procedure TStkofrDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStkofrDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStkofrDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStkofrDat.Edit;
begin
  oTable.Edit;
end;

procedure TStkofrDat.Post;
begin
  oTable.Post;
end;

procedure TStkofrDat.Delete;
begin
  oTable.Delete;
end;

procedure TStkofrDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStkofrDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStkofrDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStkofrDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStkofrDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStkofrDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2202001}
