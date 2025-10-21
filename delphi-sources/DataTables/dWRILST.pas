unit dWRILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWriNum='WriNum';
  ixWriNam='WriNam';

type
  TWrilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetWriNam:Str30;            procedure SetWriNam(pValue:Str30);
    function GetWriNam_:Str30;           procedure SetWriNam_(pValue:Str30);
    function GetWriAdd:Str30;            procedure SetWriAdd(pValue:Str30);
    function GetWriSta:Str2;             procedure SetWriSta(pValue:Str2);
    function GetWriCty:Str3;             procedure SetWriCty(pValue:Str3);
    function GetWriZip:Str15;            procedure SetWriZip(pValue:Str15);
    function GetEcuNum:word;             procedure SetEcuNum(pValue:word);
    function GetModNum:word;             procedure SetModNum(pValue:word);
    function GetRemote:Str1;             procedure SetRemote(pValue:Str1);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function LocWriNum(pWriNum:word):boolean;
    function LocWriNam(pWriNam_:Str30):boolean;
    function NearWriNum(pWriNum:word):boolean;
    function NearWriNam(pWriNam_:Str30):boolean;

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
    property WriNum:word read GetWriNum write SetWriNum;
    property WriNam:Str30 read GetWriNam write SetWriNam;
    property WriNam_:Str30 read GetWriNam_ write SetWriNam_;
    property WriAdd:Str30 read GetWriAdd write SetWriAdd;
    property WriSta:Str2 read GetWriSta write SetWriSta;
    property WriCty:Str3 read GetWriCty write SetWriCty;
    property WriZip:Str15 read GetWriZip write SetWriZip;
    property EcuNum:word read GetEcuNum write SetEcuNum;
    property ModNum:word read GetModNum write SetModNum;
    property Remote:Str1 read GetRemote write SetRemote;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TWrilstDat.Create;
begin
  oTable:=DatInit('WRILST',gPath.DlsPath,Self);
end;

constructor TWrilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('WRILST',pPath,Self);
end;

destructor TWrilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TWrilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TWrilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TWrilstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TWrilstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TWrilstDat.GetWriNam:Str30;
begin
  Result:=oTable.FieldByName('WriNam').AsString;
end;

procedure TWrilstDat.SetWriNam(pValue:Str30);
begin
  oTable.FieldByName('WriNam').AsString:=pValue;
end;

function TWrilstDat.GetWriNam_:Str30;
begin
  Result:=oTable.FieldByName('WriNam_').AsString;
end;

procedure TWrilstDat.SetWriNam_(pValue:Str30);
begin
  oTable.FieldByName('WriNam_').AsString:=pValue;
end;

function TWrilstDat.GetWriAdd:Str30;
begin
  Result:=oTable.FieldByName('WriAdd').AsString;
end;

procedure TWrilstDat.SetWriAdd(pValue:Str30);
begin
  oTable.FieldByName('WriAdd').AsString:=pValue;
end;

function TWrilstDat.GetWriSta:Str2;
begin
  Result:=oTable.FieldByName('WriSta').AsString;
end;

procedure TWrilstDat.SetWriSta(pValue:Str2);
begin
  oTable.FieldByName('WriSta').AsString:=pValue;
end;

function TWrilstDat.GetWriCty:Str3;
begin
  Result:=oTable.FieldByName('WriCty').AsString;
end;

procedure TWrilstDat.SetWriCty(pValue:Str3);
begin
  oTable.FieldByName('WriCty').AsString:=pValue;
end;

function TWrilstDat.GetWriZip:Str15;
begin
  Result:=oTable.FieldByName('WriZip').AsString;
end;

procedure TWrilstDat.SetWriZip(pValue:Str15);
begin
  oTable.FieldByName('WriZip').AsString:=pValue;
end;

function TWrilstDat.GetEcuNum:word;
begin
  Result:=oTable.FieldByName('EcuNum').AsInteger;
end;

procedure TWrilstDat.SetEcuNum(pValue:word);
begin
  oTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TWrilstDat.GetModNum:word;
begin
  Result:=oTable.FieldByName('ModNum').AsInteger;
end;

procedure TWrilstDat.SetModNum(pValue:word);
begin
  oTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TWrilstDat.GetRemote:Str1;
begin
  Result:=oTable.FieldByName('Remote').AsString;
end;

procedure TWrilstDat.SetRemote(pValue:Str1);
begin
  oTable.FieldByName('Remote').AsString:=pValue;
end;

function TWrilstDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TWrilstDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TWrilstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TWrilstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TWrilstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TWrilstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TWrilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TWrilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TWrilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TWrilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TWrilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TWrilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TWrilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TWrilstDat.LocWriNum(pWriNum:word):boolean;
begin
  SetIndex(ixWriNum);
  Result:=oTable.FindKey([pWriNum]);
end;

function TWrilstDat.LocWriNam(pWriNam_:Str30):boolean;
begin
  SetIndex(ixWriNam);
  Result:=oTable.FindKey([StrToAlias(pWriNam_)]);
end;

function TWrilstDat.NearWriNum(pWriNum:word):boolean;
begin
  SetIndex(ixWriNum);
  Result:=oTable.FindNearest([pWriNum]);
end;

function TWrilstDat.NearWriNam(pWriNam_:Str30):boolean;
begin
  SetIndex(ixWriNam);
  Result:=oTable.FindNearest([pWriNam_]);
end;

procedure TWrilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TWrilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TWrilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TWrilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TWrilstDat.Next;
begin
  oTable.Next;
end;

procedure TWrilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TWrilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TWrilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TWrilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TWrilstDat.Post;
begin
  oTable.Post;
end;

procedure TWrilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TWrilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TWrilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TWrilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TWrilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TWrilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TWrilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
