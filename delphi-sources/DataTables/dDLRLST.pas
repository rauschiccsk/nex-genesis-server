unit dDLRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDlrNum='DlrNum';
  ixDlrNam='DlrNam';

type
  TDlrlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDlrNum:word;             procedure SetDlrNum(pValue:word);
    function GetDlrNam:Str30;            procedure SetDlrNam(pValue:Str30);
    function GetDlrNam_:Str30;           procedure SetDlrNam_(pValue:Str30);
    function GetIdcCod:Str15;            procedure SetIdcCod(pValue:Str15);
    function GetPlsNum:word;             procedure SetPlsNum(pValue:word);
    function GetAplNum:word;             procedure SetAplNum(pValue:word);
    function GetSended:boolean;          procedure SetSended(pValue:boolean);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModNum:word;             procedure SetModNum(pValue:word);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
    function GetClcTyp:Str1;             procedure SetClcTyp(pValue:Str1);
    function GetRewPrc:double;           procedure SetRewPrc(pValue:double);
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
    function LocDlrNum(pDlrNum:word):boolean;
    function LocDlrNam(pDlrNam:Str30):boolean;
    function NearDlrNum(pDlrNum:word):boolean;
    function NearDlrNam(pDlrNam:Str30):boolean;

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
    property DlrNum:word read GetDlrNum write SetDlrNum;
    property DlrNam:Str30 read GetDlrNam write SetDlrNam;
    property DlrNam_:Str30 read GetDlrNam_ write SetDlrNam_;
    property IdcCod:Str15 read GetIdcCod write SetIdcCod;
    property PlsNum:word read GetPlsNum write SetPlsNum;
    property AplNum:word read GetAplNum write SetAplNum;
    property Sended:boolean read GetSended write SetSended;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModNum:word read GetModNum write SetModNum;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
    property ClcTyp:Str1 read GetClcTyp write SetClcTyp;
    property RewPrc:double read GetRewPrc write SetRewPrc;
  end;

implementation

constructor TDlrlstDat.Create;
begin
  oTable:=DatInit('DLRLST',gPath.DlsPath,Self);
end;

constructor TDlrlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('DLRLST',pPath,Self);
end;

destructor TDlrlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TDlrlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TDlrlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TDlrlstDat.GetDlrNum:word;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TDlrlstDat.SetDlrNum(pValue:word);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TDlrlstDat.GetDlrNam:Str30;
begin
  Result:=oTable.FieldByName('DlrNam').AsString;
end;

procedure TDlrlstDat.SetDlrNam(pValue:Str30);
begin
  oTable.FieldByName('DlrNam').AsString:=pValue;
end;

function TDlrlstDat.GetDlrNam_:Str30;
begin
  Result:=oTable.FieldByName('DlrNam_').AsString;
end;

procedure TDlrlstDat.SetDlrNam_(pValue:Str30);
begin
  oTable.FieldByName('DlrNam_').AsString:=pValue;
end;

function TDlrlstDat.GetIdcCod:Str15;
begin
  Result:=oTable.FieldByName('IdcCod').AsString;
end;

procedure TDlrlstDat.SetIdcCod(pValue:Str15);
begin
  oTable.FieldByName('IdcCod').AsString:=pValue;
end;

function TDlrlstDat.GetPlsNum:word;
begin
  Result:=oTable.FieldByName('PlsNum').AsInteger;
end;

procedure TDlrlstDat.SetPlsNum(pValue:word);
begin
  oTable.FieldByName('PlsNum').AsInteger:=pValue;
end;

function TDlrlstDat.GetAplNum:word;
begin
  Result:=oTable.FieldByName('AplNum').AsInteger;
end;

procedure TDlrlstDat.SetAplNum(pValue:word);
begin
  oTable.FieldByName('AplNum').AsInteger:=pValue;
end;

function TDlrlstDat.GetSended:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('Sended').AsInteger);
end;

procedure TDlrlstDat.SetSended(pValue:boolean);
begin
  oTable.FieldByName('Sended').AsInteger:=BoolToByte(pValue);
end;

function TDlrlstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TDlrlstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TDlrlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TDlrlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TDlrlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TDlrlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TDlrlstDat.GetModNum:word;
begin
  Result:=oTable.FieldByName('ModNum').AsInteger;
end;

procedure TDlrlstDat.SetModNum(pValue:word);
begin
  oTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TDlrlstDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TDlrlstDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TDlrlstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TDlrlstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TDlrlstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TDlrlstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TDlrlstDat.GetClcTyp:Str1;
begin
  Result:=oTable.FieldByName('ClcTyp').AsString;
end;

procedure TDlrlstDat.SetClcTyp(pValue:Str1);
begin
  oTable.FieldByName('ClcTyp').AsString:=pValue;
end;

function TDlrlstDat.GetRewPrc:double;
begin
  Result:=oTable.FieldByName('RewPrc').AsFloat;
end;

procedure TDlrlstDat.SetRewPrc(pValue:double);
begin
  oTable.FieldByName('RewPrc').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDlrlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TDlrlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TDlrlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TDlrlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TDlrlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TDlrlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TDlrlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TDlrlstDat.LocDlrNum(pDlrNum:word):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindKey([pDlrNum]);
end;

function TDlrlstDat.LocDlrNam(pDlrNam:Str30):boolean;
begin
  SetIndex(ixDlrNam);
  Result:=oTable.FindKey([pDlrNam]);
end;

function TDlrlstDat.NearDlrNum(pDlrNum:word):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindNearest([pDlrNum]);
end;

function TDlrlstDat.NearDlrNam(pDlrNam:Str30):boolean;
begin
  SetIndex(ixDlrNam);
  Result:=oTable.FindNearest([pDlrNam]);
end;

procedure TDlrlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TDlrlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TDlrlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TDlrlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TDlrlstDat.Next;
begin
  oTable.Next;
end;

procedure TDlrlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TDlrlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TDlrlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TDlrlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TDlrlstDat.Post;
begin
  oTable.Post;
end;

procedure TDlrlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TDlrlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TDlrlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TDlrlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TDlrlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TDlrlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TDlrlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
