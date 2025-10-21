unit dUSRDAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixUsrLog='UsrLog';
  ixDlrNum='DlrNum';
  ixPrsNum='PrsNum';
  ixGrpNum='GrpNum';

type
  TUsrdatDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetUsrLog:Str10;            procedure SetUsrLog(pValue:Str10);
    function GetUsrNam:Str30;            procedure SetUsrNam(pValue:Str30);
    function GetUsrOwn:Str40;            procedure SetUsrOwn(pValue:Str40);
    function GetUsrTyp:byte;             procedure SetUsrTyp(pValue:byte);
    function GetUsrLev:byte;             procedure SetUsrLev(pValue:byte);
    function GetUsrLng:Str2;             procedure SetUsrLng(pValue:Str2);
    function GetAutIdc:Str40;            procedure SetAutIdc(pValue:Str40);
    function GetGrpNum:word;             procedure SetGrpNum(pValue:word);
    function GetDlrNum:word;             procedure SetDlrNum(pValue:word);
    function GetPrsNum:word;             procedure SetPrsNum(pValue:word);
    function GetMaxDsc:byte;             procedure SetMaxDsc(pValue:byte);
    function GetEmlAdr:Str30;            procedure SetEmlAdr(pValue:Str30);
    function GetEmlNam:Str30;            procedure SetEmlNam(pValue:Str30);
    function GetWpcNam:Str40;            procedure SetWpcNam(pValue:Str40);
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
    function LocUsrLog(pUsrLog:Str10):boolean;
    function LocDlrNum(pDlrNum:word):boolean;
    function LocPrsNum(pPrsNum:word):boolean;
    function LocGrpNum(pGrpNum:word):boolean;
    function NearUsrLog(pUsrLog:Str10):boolean;
    function NearDlrNum(pDlrNum:word):boolean;
    function NearPrsNum(pPrsNum:word):boolean;
    function NearGrpNum(pGrpNum:word):boolean;

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
    property UsrLog:Str10 read GetUsrLog write SetUsrLog;
    property UsrNam:Str30 read GetUsrNam write SetUsrNam;
    property UsrOwn:Str40 read GetUsrOwn write SetUsrOwn;
    property UsrTyp:byte read GetUsrTyp write SetUsrTyp;
    property UsrLev:byte read GetUsrLev write SetUsrLev;
    property UsrLng:Str2 read GetUsrLng write SetUsrLng;
    property AutIdc:Str40 read GetAutIdc write SetAutIdc;
    property GrpNum:word read GetGrpNum write SetGrpNum;
    property DlrNum:word read GetDlrNum write SetDlrNum;
    property PrsNum:word read GetPrsNum write SetPrsNum;
    property MaxDsc:byte read GetMaxDsc write SetMaxDsc;
    property EmlAdr:Str30 read GetEmlAdr write SetEmlAdr;
    property EmlNam:Str30 read GetEmlNam write SetEmlNam;
    property WpcNam:Str40 read GetWpcNam write SetWpcNam;
  end;

implementation

constructor TUsrdatDat.Create;
begin
  oTable:=DatInit('USRDAT',gPath.SysPath,Self);
end;

constructor TUsrdatDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('USRDAT',pPath,Self);
end;

destructor TUsrdatDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TUsrdatDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TUsrdatDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TUsrdatDat.GetUsrLog:Str10;
begin
  Result:=oTable.FieldByName('UsrLog').AsString;
end;

procedure TUsrdatDat.SetUsrLog(pValue:Str10);
begin
  oTable.FieldByName('UsrLog').AsString:=pValue;
end;

function TUsrdatDat.GetUsrNam:Str30;
begin
  Result:=oTable.FieldByName('UsrNam').AsString;
end;

procedure TUsrdatDat.SetUsrNam(pValue:Str30);
begin
  oTable.FieldByName('UsrNam').AsString:=pValue;
end;

function TUsrdatDat.GetUsrOwn:Str40;
begin
  Result:=oTable.FieldByName('UsrOwn').AsString;
end;

procedure TUsrdatDat.SetUsrOwn(pValue:Str40);
begin
  oTable.FieldByName('UsrOwn').AsString:=pValue;
end;

function TUsrdatDat.GetUsrTyp:byte;
begin
  Result:=oTable.FieldByName('UsrTyp').AsInteger;
end;

procedure TUsrdatDat.SetUsrTyp(pValue:byte);
begin
  oTable.FieldByName('UsrTyp').AsInteger:=pValue;
end;

function TUsrdatDat.GetUsrLev:byte;
begin
  Result:=oTable.FieldByName('UsrLev').AsInteger;
end;

procedure TUsrdatDat.SetUsrLev(pValue:byte);
begin
  oTable.FieldByName('UsrLev').AsInteger:=pValue;
end;

function TUsrdatDat.GetUsrLng:Str2;
begin
  Result:=oTable.FieldByName('UsrLng').AsString;
end;

procedure TUsrdatDat.SetUsrLng(pValue:Str2);
begin
  oTable.FieldByName('UsrLng').AsString:=pValue;
end;

function TUsrdatDat.GetAutIdc:Str40;
begin
  Result:=oTable.FieldByName('AutIdc').AsString;
end;

procedure TUsrdatDat.SetAutIdc(pValue:Str40);
begin
  oTable.FieldByName('AutIdc').AsString:=pValue;
end;

function TUsrdatDat.GetGrpNum:word;
begin
  Result:=oTable.FieldByName('GrpNum').AsInteger;
end;

procedure TUsrdatDat.SetGrpNum(pValue:word);
begin
  oTable.FieldByName('GrpNum').AsInteger:=pValue;
end;

function TUsrdatDat.GetDlrNum:word;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TUsrdatDat.SetDlrNum(pValue:word);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TUsrdatDat.GetPrsNum:word;
begin
  Result:=oTable.FieldByName('PrsNum').AsInteger;
end;

procedure TUsrdatDat.SetPrsNum(pValue:word);
begin
  oTable.FieldByName('PrsNum').AsInteger:=pValue;
end;

function TUsrdatDat.GetMaxDsc:byte;
begin
  Result:=oTable.FieldByName('MaxDsc').AsInteger;
end;

procedure TUsrdatDat.SetMaxDsc(pValue:byte);
begin
  oTable.FieldByName('MaxDsc').AsInteger:=pValue;
end;

function TUsrdatDat.GetEmlAdr:Str30;
begin
  Result:=oTable.FieldByName('EmlAdr').AsString;
end;

procedure TUsrdatDat.SetEmlAdr(pValue:Str30);
begin
  oTable.FieldByName('EmlAdr').AsString:=pValue;
end;

function TUsrdatDat.GetEmlNam:Str30;
begin
  Result:=oTable.FieldByName('EmlNam').AsString;
end;

procedure TUsrdatDat.SetEmlNam(pValue:Str30);
begin
  oTable.FieldByName('EmlNam').AsString:=pValue;
end;

function TUsrdatDat.GetWpcNam:Str40;
begin
  Result:=oTable.FieldByName('WpcNam').AsString;
end;

procedure TUsrdatDat.SetWpcNam(pValue:Str40);
begin
  oTable.FieldByName('WpcNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TUsrdatDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TUsrdatDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TUsrdatDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TUsrdatDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TUsrdatDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TUsrdatDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TUsrdatDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TUsrdatDat.LocUsrLog(pUsrLog:Str10):boolean;
begin
  SetIndex(ixUsrLog);
  Result:=oTable.FindKey([pUsrLog]);
end;

function TUsrdatDat.LocDlrNum(pDlrNum:word):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindKey([pDlrNum]);
end;

function TUsrdatDat.LocPrsNum(pPrsNum:word):boolean;
begin
  SetIndex(ixPrsNum);
  Result:=oTable.FindKey([pPrsNum]);
end;

function TUsrdatDat.LocGrpNum(pGrpNum:word):boolean;
begin
  SetIndex(ixGrpNum);
  Result:=oTable.FindKey([pGrpNum]);
end;

function TUsrdatDat.NearUsrLog(pUsrLog:Str10):boolean;
begin
  SetIndex(ixUsrLog);
  Result:=oTable.FindNearest([pUsrLog]);
end;

function TUsrdatDat.NearDlrNum(pDlrNum:word):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindNearest([pDlrNum]);
end;

function TUsrdatDat.NearPrsNum(pPrsNum:word):boolean;
begin
  SetIndex(ixPrsNum);
  Result:=oTable.FindNearest([pPrsNum]);
end;

function TUsrdatDat.NearGrpNum(pGrpNum:word):boolean;
begin
  SetIndex(ixGrpNum);
  Result:=oTable.FindNearest([pGrpNum]);
end;

procedure TUsrdatDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TUsrdatDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TUsrdatDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TUsrdatDat.Prior;
begin
  oTable.Prior;
end;

procedure TUsrdatDat.Next;
begin
  oTable.Next;
end;

procedure TUsrdatDat.First;
begin
  Open;
  oTable.First;
end;

procedure TUsrdatDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TUsrdatDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TUsrdatDat.Edit;
begin
  oTable.Edit;
end;

procedure TUsrdatDat.Post;
begin
  oTable.Post;
end;

procedure TUsrdatDat.Delete;
begin
  oTable.Delete;
end;

procedure TUsrdatDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TUsrdatDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TUsrdatDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TUsrdatDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TUsrdatDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TUsrdatDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
