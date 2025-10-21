unit dIVMSHD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDnIs='DnIs';
  ixIvsNum='IvsNum';
  ixIvsCod='IvsCod';
  ixMrgSta='MrgSta';

type
  TIvmshdDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetIvsNum:word;             procedure SetIvsNum(pValue:word);
    function GetIvsCod:Str10;            procedure SetIvsCod(pValue:Str10);
    function GetSecNam:Str50;            procedure SetSecNam(pValue:Str50);
    function GetIvdFas:byte;             procedure SetIvdFas(pValue:byte);
    function GetNamFa1:Str100;           procedure SetNamFa1(pValue:Str100);
    function GetNamFa2:Str100;           procedure SetNamFa2(pValue:Str100);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetDifCnt:word;             procedure SetDifCnt(pValue:word);
    function GetMrgSta:Str1;             procedure SetMrgSta(pValue:Str1);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr(pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn(pValue:Str30);
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
    function LocDocNum(pDocNum:Str12):boolean;
    function LocDnIs(pDocNum:Str12;pIvsNum:word):boolean;
    function LocIvsNum(pIvsNum:word):boolean;
    function LocIvsCod(pIvsCod:Str10):boolean;
    function LocMrgSta(pMrgSta:Str1):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnIs(pDocNum:Str12;pIvsNum:word):boolean;
    function NearIvsNum(pIvsNum:word):boolean;
    function NearIvsCod(pIvsCod:Str10):boolean;
    function NearMrgSta(pMrgSta:Str1):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property IvsNum:word read GetIvsNum write SetIvsNum;
    property IvsCod:Str10 read GetIvsCod write SetIvsCod;
    property SecNam:Str50 read GetSecNam write SetSecNam;
    property IvdFas:byte read GetIvdFas write SetIvdFas;
    property NamFa1:Str100 read GetNamFa1 write SetNamFa1;
    property NamFa2:Str100 read GetNamFa2 write SetNamFa2;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property DifCnt:word read GetDifCnt write SetDifCnt;
    property MrgSta:Str1 read GetMrgSta write SetMrgSta;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str10 read GetModUsr write SetModUsr;
    property ModUsn:Str30 read GetModUsn write SetModUsn;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TIvmshdDat.Create;
begin
  oTable:=DatInit('IVMSHD',gPath.StkPath,Self);
end;

constructor TIvmshdDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('IVMSHD',pPath,Self);
end;

destructor TIvmshdDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TIvmshdDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TIvmshdDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TIvmshdDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TIvmshdDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIvmshdDat.GetIvsNum:word;
begin
  Result:=oTable.FieldByName('IvsNum').AsInteger;
end;

procedure TIvmshdDat.SetIvsNum(pValue:word);
begin
  oTable.FieldByName('IvsNum').AsInteger:=pValue;
end;

function TIvmshdDat.GetIvsCod:Str10;
begin
  Result:=oTable.FieldByName('IvsCod').AsString;
end;

procedure TIvmshdDat.SetIvsCod(pValue:Str10);
begin
  oTable.FieldByName('IvsCod').AsString:=pValue;
end;

function TIvmshdDat.GetSecNam:Str50;
begin
  Result:=oTable.FieldByName('SecNam').AsString;
end;

procedure TIvmshdDat.SetSecNam(pValue:Str50);
begin
  oTable.FieldByName('SecNam').AsString:=pValue;
end;

function TIvmshdDat.GetIvdFas:byte;
begin
  Result:=oTable.FieldByName('IvdFas').AsInteger;
end;

procedure TIvmshdDat.SetIvdFas(pValue:byte);
begin
  oTable.FieldByName('IvdFas').AsInteger:=pValue;
end;

function TIvmshdDat.GetNamFa1:Str100;
begin
  Result:=oTable.FieldByName('NamFa1').AsString;
end;

procedure TIvmshdDat.SetNamFa1(pValue:Str100);
begin
  oTable.FieldByName('NamFa1').AsString:=pValue;
end;

function TIvmshdDat.GetNamFa2:Str100;
begin
  Result:=oTable.FieldByName('NamFa2').AsString;
end;

procedure TIvmshdDat.SetNamFa2(pValue:Str100);
begin
  oTable.FieldByName('NamFa2').AsString:=pValue;
end;

function TIvmshdDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIvmshdDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TIvmshdDat.GetDifCnt:word;
begin
  Result:=oTable.FieldByName('DifCnt').AsInteger;
end;

procedure TIvmshdDat.SetDifCnt(pValue:word);
begin
  oTable.FieldByName('DifCnt').AsInteger:=pValue;
end;

function TIvmshdDat.GetMrgSta:Str1;
begin
  Result:=oTable.FieldByName('MrgSta').AsString;
end;

procedure TIvmshdDat.SetMrgSta(pValue:Str1);
begin
  oTable.FieldByName('MrgSta').AsString:=pValue;
end;

function TIvmshdDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TIvmshdDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIvmshdDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TIvmshdDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIvmshdDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIvmshdDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIvmshdDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIvmshdDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIvmshdDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TIvmshdDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TIvmshdDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TIvmshdDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TIvmshdDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TIvmshdDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TIvmshdDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TIvmshdDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvmshdDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TIvmshdDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TIvmshdDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TIvmshdDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TIvmshdDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TIvmshdDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TIvmshdDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TIvmshdDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TIvmshdDat.LocDnIs(pDocNum:Str12;pIvsNum:word):boolean;
begin
  SetIndex(ixDnIs);
  Result:=oTable.FindKey([pDocNum,pIvsNum]);
end;

function TIvmshdDat.LocIvsNum(pIvsNum:word):boolean;
begin
  SetIndex(ixIvsNum);
  Result:=oTable.FindKey([pIvsNum]);
end;

function TIvmshdDat.LocIvsCod(pIvsCod:Str10):boolean;
begin
  SetIndex(ixIvsCod);
  Result:=oTable.FindKey([pIvsCod]);
end;

function TIvmshdDat.LocMrgSta(pMrgSta:Str1):boolean;
begin
  SetIndex(ixMrgSta);
  Result:=oTable.FindKey([pMrgSta]);
end;

function TIvmshdDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TIvmshdDat.NearDnIs(pDocNum:Str12;pIvsNum:word):boolean;
begin
  SetIndex(ixDnIs);
  Result:=oTable.FindNearest([pDocNum,pIvsNum]);
end;

function TIvmshdDat.NearIvsNum(pIvsNum:word):boolean;
begin
  SetIndex(ixIvsNum);
  Result:=oTable.FindNearest([pIvsNum]);
end;

function TIvmshdDat.NearIvsCod(pIvsCod:Str10):boolean;
begin
  SetIndex(ixIvsCod);
  Result:=oTable.FindNearest([pIvsCod]);
end;

function TIvmshdDat.NearMrgSta(pMrgSta:Str1):boolean;
begin
  SetIndex(ixMrgSta);
  Result:=oTable.FindNearest([pMrgSta]);
end;

procedure TIvmshdDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TIvmshdDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TIvmshdDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TIvmshdDat.Prior;
begin
  oTable.Prior;
end;

procedure TIvmshdDat.Next;
begin
  oTable.Next;
end;

procedure TIvmshdDat.First;
begin
  Open;
  oTable.First;
end;

procedure TIvmshdDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TIvmshdDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TIvmshdDat.Edit;
begin
  oTable.Edit;
end;

procedure TIvmshdDat.Post;
begin
  oTable.Post;
end;

procedure TIvmshdDat.Delete;
begin
  oTable.Delete;
end;

procedure TIvmshdDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TIvmshdDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TIvmshdDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TIvmshdDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TIvmshdDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TIvmshdDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
