unit dTRSPLN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTyTmTl='TyTmTl';

type
  TTrsplnDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetTrsYer:word;             procedure SetTrsYer(pValue:word);
    function GetTrsMth:word;             procedure SetTrsMth(pValue:word);
    function GetTrsLin:byte;             procedure SetTrsLin(pValue:byte);
    function GetTrsD01:Str1;             procedure SetTrsD01(pValue:Str1);
    function GetTrsD02:Str1;             procedure SetTrsD02(pValue:Str1);
    function GetTrsD03:Str1;             procedure SetTrsD03(pValue:Str1);
    function GetTrsD04:Str1;             procedure SetTrsD04(pValue:Str1);
    function GetTrsD05:Str1;             procedure SetTrsD05(pValue:Str1);
    function GetTrsD06:Str1;             procedure SetTrsD06(pValue:Str1);
    function GetTrsD07:Str1;             procedure SetTrsD07(pValue:Str1);
    function GetTrsD08:Str1;             procedure SetTrsD08(pValue:Str1);
    function GetTrsD09:Str1;             procedure SetTrsD09(pValue:Str1);
    function GetTrsD10:Str1;             procedure SetTrsD10(pValue:Str1);
    function GetTrsD11:Str1;             procedure SetTrsD11(pValue:Str1);
    function GetTrsD12:Str1;             procedure SetTrsD12(pValue:Str1);
    function GetTrsD13:Str1;             procedure SetTrsD13(pValue:Str1);
    function GetTrsD14:Str1;             procedure SetTrsD14(pValue:Str1);
    function GetTrsD15:Str1;             procedure SetTrsD15(pValue:Str1);
    function GetTrsD16:Str1;             procedure SetTrsD16(pValue:Str1);
    function GetTrsD17:Str1;             procedure SetTrsD17(pValue:Str1);
    function GetTrsD18:Str1;             procedure SetTrsD18(pValue:Str1);
    function GetTrsD19:Str1;             procedure SetTrsD19(pValue:Str1);
    function GetTrsD20:Str1;             procedure SetTrsD20(pValue:Str1);
    function GetTrsD21:Str1;             procedure SetTrsD21(pValue:Str1);
    function GetTrsD22:Str1;             procedure SetTrsD22(pValue:Str1);
    function GetTrsD23:Str1;             procedure SetTrsD23(pValue:Str1);
    function GetTrsD24:Str1;             procedure SetTrsD24(pValue:Str1);
    function GetTrsD25:Str1;             procedure SetTrsD25(pValue:Str1);
    function GetTrsD26:Str1;             procedure SetTrsD26(pValue:Str1);
    function GetTrsD27:Str1;             procedure SetTrsD27(pValue:Str1);
    function GetTrsD28:Str1;             procedure SetTrsD28(pValue:Str1);
    function GetTrsD29:Str1;             procedure SetTrsD29(pValue:Str1);
    function GetTrsD30:Str1;             procedure SetTrsD30(pValue:Str1);
    function GetTrsD31:Str1;             procedure SetTrsD31(pValue:Str1);
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
    function LocTyTmTl(pTrsYer:word;pTrsMth:word;pTrsLin:byte):boolean;
    function NearTyTmTl(pTrsYer:word;pTrsMth:word;pTrsLin:byte):boolean;

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
    property TrsYer:word read GetTrsYer write SetTrsYer;
    property TrsMth:word read GetTrsMth write SetTrsMth;
    property TrsLin:byte read GetTrsLin write SetTrsLin;
    property TrsD01:Str1 read GetTrsD01 write SetTrsD01;
    property TrsD02:Str1 read GetTrsD02 write SetTrsD02;
    property TrsD03:Str1 read GetTrsD03 write SetTrsD03;
    property TrsD04:Str1 read GetTrsD04 write SetTrsD04;
    property TrsD05:Str1 read GetTrsD05 write SetTrsD05;
    property TrsD06:Str1 read GetTrsD06 write SetTrsD06;
    property TrsD07:Str1 read GetTrsD07 write SetTrsD07;
    property TrsD08:Str1 read GetTrsD08 write SetTrsD08;
    property TrsD09:Str1 read GetTrsD09 write SetTrsD09;
    property TrsD10:Str1 read GetTrsD10 write SetTrsD10;
    property TrsD11:Str1 read GetTrsD11 write SetTrsD11;
    property TrsD12:Str1 read GetTrsD12 write SetTrsD12;
    property TrsD13:Str1 read GetTrsD13 write SetTrsD13;
    property TrsD14:Str1 read GetTrsD14 write SetTrsD14;
    property TrsD15:Str1 read GetTrsD15 write SetTrsD15;
    property TrsD16:Str1 read GetTrsD16 write SetTrsD16;
    property TrsD17:Str1 read GetTrsD17 write SetTrsD17;
    property TrsD18:Str1 read GetTrsD18 write SetTrsD18;
    property TrsD19:Str1 read GetTrsD19 write SetTrsD19;
    property TrsD20:Str1 read GetTrsD20 write SetTrsD20;
    property TrsD21:Str1 read GetTrsD21 write SetTrsD21;
    property TrsD22:Str1 read GetTrsD22 write SetTrsD22;
    property TrsD23:Str1 read GetTrsD23 write SetTrsD23;
    property TrsD24:Str1 read GetTrsD24 write SetTrsD24;
    property TrsD25:Str1 read GetTrsD25 write SetTrsD25;
    property TrsD26:Str1 read GetTrsD26 write SetTrsD26;
    property TrsD27:Str1 read GetTrsD27 write SetTrsD27;
    property TrsD28:Str1 read GetTrsD28 write SetTrsD28;
    property TrsD29:Str1 read GetTrsD29 write SetTrsD29;
    property TrsD30:Str1 read GetTrsD30 write SetTrsD30;
    property TrsD31:Str1 read GetTrsD31 write SetTrsD31;
  end;

implementation

constructor TTrsplnDat.Create;
begin
  oTable:=DatInit('TRSPLN',gPath.DlsPath,Self);
end;

constructor TTrsplnDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('TRSPLN',pPath,Self);
end;

destructor TTrsplnDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TTrsplnDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TTrsplnDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TTrsplnDat.GetTrsYer:word;
begin
  Result:=oTable.FieldByName('TrsYer').AsInteger;
end;

procedure TTrsplnDat.SetTrsYer(pValue:word);
begin
  oTable.FieldByName('TrsYer').AsInteger:=pValue;
end;

function TTrsplnDat.GetTrsMth:word;
begin
  Result:=oTable.FieldByName('TrsMth').AsInteger;
end;

procedure TTrsplnDat.SetTrsMth(pValue:word);
begin
  oTable.FieldByName('TrsMth').AsInteger:=pValue;
end;

function TTrsplnDat.GetTrsLin:byte;
begin
  Result:=oTable.FieldByName('TrsLin').AsInteger;
end;

procedure TTrsplnDat.SetTrsLin(pValue:byte);
begin
  oTable.FieldByName('TrsLin').AsInteger:=pValue;
end;

function TTrsplnDat.GetTrsD01:Str1;
begin
  Result:=oTable.FieldByName('TrsD01').AsString;
end;

procedure TTrsplnDat.SetTrsD01(pValue:Str1);
begin
  oTable.FieldByName('TrsD01').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD02:Str1;
begin
  Result:=oTable.FieldByName('TrsD02').AsString;
end;

procedure TTrsplnDat.SetTrsD02(pValue:Str1);
begin
  oTable.FieldByName('TrsD02').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD03:Str1;
begin
  Result:=oTable.FieldByName('TrsD03').AsString;
end;

procedure TTrsplnDat.SetTrsD03(pValue:Str1);
begin
  oTable.FieldByName('TrsD03').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD04:Str1;
begin
  Result:=oTable.FieldByName('TrsD04').AsString;
end;

procedure TTrsplnDat.SetTrsD04(pValue:Str1);
begin
  oTable.FieldByName('TrsD04').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD05:Str1;
begin
  Result:=oTable.FieldByName('TrsD05').AsString;
end;

procedure TTrsplnDat.SetTrsD05(pValue:Str1);
begin
  oTable.FieldByName('TrsD05').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD06:Str1;
begin
  Result:=oTable.FieldByName('TrsD06').AsString;
end;

procedure TTrsplnDat.SetTrsD06(pValue:Str1);
begin
  oTable.FieldByName('TrsD06').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD07:Str1;
begin
  Result:=oTable.FieldByName('TrsD07').AsString;
end;

procedure TTrsplnDat.SetTrsD07(pValue:Str1);
begin
  oTable.FieldByName('TrsD07').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD08:Str1;
begin
  Result:=oTable.FieldByName('TrsD08').AsString;
end;

procedure TTrsplnDat.SetTrsD08(pValue:Str1);
begin
  oTable.FieldByName('TrsD08').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD09:Str1;
begin
  Result:=oTable.FieldByName('TrsD09').AsString;
end;

procedure TTrsplnDat.SetTrsD09(pValue:Str1);
begin
  oTable.FieldByName('TrsD09').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD10:Str1;
begin
  Result:=oTable.FieldByName('TrsD10').AsString;
end;

procedure TTrsplnDat.SetTrsD10(pValue:Str1);
begin
  oTable.FieldByName('TrsD10').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD11:Str1;
begin
  Result:=oTable.FieldByName('TrsD11').AsString;
end;

procedure TTrsplnDat.SetTrsD11(pValue:Str1);
begin
  oTable.FieldByName('TrsD11').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD12:Str1;
begin
  Result:=oTable.FieldByName('TrsD12').AsString;
end;

procedure TTrsplnDat.SetTrsD12(pValue:Str1);
begin
  oTable.FieldByName('TrsD12').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD13:Str1;
begin
  Result:=oTable.FieldByName('TrsD13').AsString;
end;

procedure TTrsplnDat.SetTrsD13(pValue:Str1);
begin
  oTable.FieldByName('TrsD13').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD14:Str1;
begin
  Result:=oTable.FieldByName('TrsD14').AsString;
end;

procedure TTrsplnDat.SetTrsD14(pValue:Str1);
begin
  oTable.FieldByName('TrsD14').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD15:Str1;
begin
  Result:=oTable.FieldByName('TrsD15').AsString;
end;

procedure TTrsplnDat.SetTrsD15(pValue:Str1);
begin
  oTable.FieldByName('TrsD15').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD16:Str1;
begin
  Result:=oTable.FieldByName('TrsD16').AsString;
end;

procedure TTrsplnDat.SetTrsD16(pValue:Str1);
begin
  oTable.FieldByName('TrsD16').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD17:Str1;
begin
  Result:=oTable.FieldByName('TrsD17').AsString;
end;

procedure TTrsplnDat.SetTrsD17(pValue:Str1);
begin
  oTable.FieldByName('TrsD17').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD18:Str1;
begin
  Result:=oTable.FieldByName('TrsD18').AsString;
end;

procedure TTrsplnDat.SetTrsD18(pValue:Str1);
begin
  oTable.FieldByName('TrsD18').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD19:Str1;
begin
  Result:=oTable.FieldByName('TrsD19').AsString;
end;

procedure TTrsplnDat.SetTrsD19(pValue:Str1);
begin
  oTable.FieldByName('TrsD19').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD20:Str1;
begin
  Result:=oTable.FieldByName('TrsD20').AsString;
end;

procedure TTrsplnDat.SetTrsD20(pValue:Str1);
begin
  oTable.FieldByName('TrsD20').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD21:Str1;
begin
  Result:=oTable.FieldByName('TrsD21').AsString;
end;

procedure TTrsplnDat.SetTrsD21(pValue:Str1);
begin
  oTable.FieldByName('TrsD21').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD22:Str1;
begin
  Result:=oTable.FieldByName('TrsD22').AsString;
end;

procedure TTrsplnDat.SetTrsD22(pValue:Str1);
begin
  oTable.FieldByName('TrsD22').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD23:Str1;
begin
  Result:=oTable.FieldByName('TrsD23').AsString;
end;

procedure TTrsplnDat.SetTrsD23(pValue:Str1);
begin
  oTable.FieldByName('TrsD23').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD24:Str1;
begin
  Result:=oTable.FieldByName('TrsD24').AsString;
end;

procedure TTrsplnDat.SetTrsD24(pValue:Str1);
begin
  oTable.FieldByName('TrsD24').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD25:Str1;
begin
  Result:=oTable.FieldByName('TrsD25').AsString;
end;

procedure TTrsplnDat.SetTrsD25(pValue:Str1);
begin
  oTable.FieldByName('TrsD25').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD26:Str1;
begin
  Result:=oTable.FieldByName('TrsD26').AsString;
end;

procedure TTrsplnDat.SetTrsD26(pValue:Str1);
begin
  oTable.FieldByName('TrsD26').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD27:Str1;
begin
  Result:=oTable.FieldByName('TrsD27').AsString;
end;

procedure TTrsplnDat.SetTrsD27(pValue:Str1);
begin
  oTable.FieldByName('TrsD27').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD28:Str1;
begin
  Result:=oTable.FieldByName('TrsD28').AsString;
end;

procedure TTrsplnDat.SetTrsD28(pValue:Str1);
begin
  oTable.FieldByName('TrsD28').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD29:Str1;
begin
  Result:=oTable.FieldByName('TrsD29').AsString;
end;

procedure TTrsplnDat.SetTrsD29(pValue:Str1);
begin
  oTable.FieldByName('TrsD29').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD30:Str1;
begin
  Result:=oTable.FieldByName('TrsD30').AsString;
end;

procedure TTrsplnDat.SetTrsD30(pValue:Str1);
begin
  oTable.FieldByName('TrsD30').AsString:=pValue;
end;

function TTrsplnDat.GetTrsD31:Str1;
begin
  Result:=oTable.FieldByName('TrsD31').AsString;
end;

procedure TTrsplnDat.SetTrsD31(pValue:Str1);
begin
  oTable.FieldByName('TrsD31').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrsplnDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TTrsplnDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TTrsplnDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TTrsplnDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TTrsplnDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TTrsplnDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TTrsplnDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TTrsplnDat.LocTyTmTl(pTrsYer:word;pTrsMth:word;pTrsLin:byte):boolean;
begin
  SetIndex(ixTyTmTl);
  Result:=oTable.FindKey([pTrsYer,pTrsMth,pTrsLin]);
end;

function TTrsplnDat.NearTyTmTl(pTrsYer:word;pTrsMth:word;pTrsLin:byte):boolean;
begin
  SetIndex(ixTyTmTl);
  Result:=oTable.FindNearest([pTrsYer,pTrsMth,pTrsLin]);
end;

procedure TTrsplnDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TTrsplnDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TTrsplnDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TTrsplnDat.Prior;
begin
  oTable.Prior;
end;

procedure TTrsplnDat.Next;
begin
  oTable.Next;
end;

procedure TTrsplnDat.First;
begin
  Open;
  oTable.First;
end;

procedure TTrsplnDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TTrsplnDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TTrsplnDat.Edit;
begin
  oTable.Edit;
end;

procedure TTrsplnDat.Post;
begin
  oTable.Post;
end;

procedure TTrsplnDat.Delete;
begin
  oTable.Delete;
end;

procedure TTrsplnDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TTrsplnDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TTrsplnDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TTrsplnDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TTrsplnDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TTrsplnDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
