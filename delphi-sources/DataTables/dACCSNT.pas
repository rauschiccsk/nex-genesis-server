unit dACCSNT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAccSnt='AccSnt';
  ixSntNam='SntNam';

type
  TAccsntDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetAccSnt:Str3;             procedure SetAccSnt(pValue:Str3);
    function GetSntNam:Str30;            procedure SetSntNam(pValue:Str30);
    function GetSntNam_:Str30;           procedure SetSntNam_(pValue:Str30);
    function GetSntTyp:Str1;             procedure SetSntTyp(pValue:Str1);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModNum:word;             procedure SetModNum(pValue:word);
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
    function LocAccSnt(pAccSnt:Str3):boolean;
    function LocSntNam(pSntNam_:Str30):boolean;
    function NearAccSnt(pAccSnt:Str3):boolean;
    function NearSntNam(pSntNam_:Str30):boolean;

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
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property SntNam:Str30 read GetSntNam write SetSntNam;
    property SntNam_:Str30 read GetSntNam_ write SetSntNam_;
    property SntTyp:Str1 read GetSntTyp write SetSntTyp;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModNum:word read GetModNum write SetModNum;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TAccsntDat.Create;
begin
  oTable:=DatInit('ACCSNT',gPath.LdgPath,Self);
end;

constructor TAccsntDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ACCSNT',pPath,Self);
end;

destructor TAccsntDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TAccsntDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TAccsntDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TAccsntDat.GetAccSnt:Str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TAccsntDat.SetAccSnt(pValue:Str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAccsntDat.GetSntNam:Str30;
begin
  Result:=oTable.FieldByName('SntNam').AsString;
end;

procedure TAccsntDat.SetSntNam(pValue:Str30);
begin
  oTable.FieldByName('SntNam').AsString:=pValue;
end;

function TAccsntDat.GetSntNam_:Str30;
begin
  Result:=oTable.FieldByName('SntNam_').AsString;
end;

procedure TAccsntDat.SetSntNam_(pValue:Str30);
begin
  oTable.FieldByName('SntNam_').AsString:=pValue;
end;

function TAccsntDat.GetSntTyp:Str1;
begin
  Result:=oTable.FieldByName('SntTyp').AsString;
end;

procedure TAccsntDat.SetSntTyp(pValue:Str1);
begin
  oTable.FieldByName('SntTyp').AsString:=pValue;
end;

function TAccsntDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TAccsntDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAccsntDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAccsntDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAccsntDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAccsntDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TAccsntDat.GetModNum:word;
begin
  Result:=oTable.FieldByName('ModNum').AsInteger;
end;

procedure TAccsntDat.SetModNum(pValue:word);
begin
  oTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TAccsntDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TAccsntDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TAccsntDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TAccsntDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TAccsntDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TAccsntDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccsntDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TAccsntDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TAccsntDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TAccsntDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TAccsntDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TAccsntDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TAccsntDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TAccsntDat.LocAccSnt(pAccSnt:Str3):boolean;
begin
  SetIndex(ixAccSnt);
  Result:=oTable.FindKey([pAccSnt]);
end;

function TAccsntDat.LocSntNam(pSntNam_:Str30):boolean;
begin
  SetIndex(ixSntNam);
  Result:=oTable.FindKey([StrToAlias(pSntNam_)]);
end;

function TAccsntDat.NearAccSnt(pAccSnt:Str3):boolean;
begin
  SetIndex(ixAccSnt);
  Result:=oTable.FindNearest([pAccSnt]);
end;

function TAccsntDat.NearSntNam(pSntNam_:Str30):boolean;
begin
  SetIndex(ixSntNam);
  Result:=oTable.FindNearest([pSntNam_]);
end;

procedure TAccsntDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TAccsntDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TAccsntDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TAccsntDat.Prior;
begin
  oTable.Prior;
end;

procedure TAccsntDat.Next;
begin
  oTable.Next;
end;

procedure TAccsntDat.First;
begin
  Open;
  oTable.First;
end;

procedure TAccsntDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TAccsntDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TAccsntDat.Edit;
begin
  oTable.Edit;
end;

procedure TAccsntDat.Post;
begin
  oTable.Post;
end;

procedure TAccsntDat.Delete;
begin
  oTable.Delete;
end;

procedure TAccsntDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TAccsntDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TAccsntDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TAccsntDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TAccsntDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TAccsntDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
