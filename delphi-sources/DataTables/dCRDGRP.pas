unit dCRDGRP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum='GrpNum';
  ixGrpNam='GrpNam';

type
  TCrdgrpDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetGrpNum:longint;          procedure SetGrpNum(pValue:longint);
    function GetGrpNam:Str30;            procedure SetGrpNam(pValue:Str30);
    function GetGrpNam_:Str30;           procedure SetGrpNam_(pValue:Str30);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
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
    function LocGrpNum(pGrpNum:longint):boolean;
    function LocGrpNam(pGrpNam_:Str30):boolean;
    function NearGrpNum(pGrpNum:longint):boolean;
    function NearGrpNam(pGrpNam_:Str30):boolean;

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
    property GrpNum:longint read GetGrpNum write SetGrpNum;
    property GrpNam:Str30 read GetGrpNam write SetGrpNam;
    property GrpNam_:Str30 read GetGrpNam_ write SetGrpNam_;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TCrdgrpDat.Create;
begin
  oTable:=DatInit('CRDGRP',gPath.DlsPath,Self);
end;

constructor TCrdgrpDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CRDGRP',pPath,Self);
end;

destructor TCrdgrpDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdgrpDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCrdgrpDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCrdgrpDat.GetGrpNum:longint;
begin
  Result:=oTable.FieldByName('GrpNum').AsInteger;
end;

procedure TCrdgrpDat.SetGrpNum(pValue:longint);
begin
  oTable.FieldByName('GrpNum').AsInteger:=pValue;
end;

function TCrdgrpDat.GetGrpNam:Str30;
begin
  Result:=oTable.FieldByName('GrpNam').AsString;
end;

procedure TCrdgrpDat.SetGrpNam(pValue:Str30);
begin
  oTable.FieldByName('GrpNam').AsString:=pValue;
end;

function TCrdgrpDat.GetGrpNam_:Str30;
begin
  Result:=oTable.FieldByName('GrpNam_').AsString;
end;

procedure TCrdgrpDat.SetGrpNam_(pValue:Str30);
begin
  oTable.FieldByName('GrpNam_').AsString:=pValue;
end;

function TCrdgrpDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TCrdgrpDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TCrdgrpDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TCrdgrpDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TCrdgrpDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TCrdgrpDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TCrdgrpDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TCrdgrpDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TCrdgrpDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TCrdgrpDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TCrdgrpDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TCrdgrpDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdgrpDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCrdgrpDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCrdgrpDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCrdgrpDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCrdgrpDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCrdgrpDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCrdgrpDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCrdgrpDat.LocGrpNum(pGrpNum:longint):boolean;
begin
  SetIndex(ixGrpNum);
  Result:=oTable.FindKey([pGrpNum]);
end;

function TCrdgrpDat.LocGrpNam(pGrpNam_:Str30):boolean;
begin
  SetIndex(ixGrpNam);
  Result:=oTable.FindKey([StrToAlias(pGrpNam_)]);
end;

function TCrdgrpDat.NearGrpNum(pGrpNum:longint):boolean;
begin
  SetIndex(ixGrpNum);
  Result:=oTable.FindNearest([pGrpNum]);
end;

function TCrdgrpDat.NearGrpNam(pGrpNam_:Str30):boolean;
begin
  SetIndex(ixGrpNam);
  Result:=oTable.FindNearest([pGrpNam_]);
end;

procedure TCrdgrpDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCrdgrpDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCrdgrpDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCrdgrpDat.Prior;
begin
  oTable.Prior;
end;

procedure TCrdgrpDat.Next;
begin
  oTable.Next;
end;

procedure TCrdgrpDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCrdgrpDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCrdgrpDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCrdgrpDat.Edit;
begin
  oTable.Edit;
end;

procedure TCrdgrpDat.Post;
begin
  oTable.Post;
end;

procedure TCrdgrpDat.Delete;
begin
  oTable.Delete;
end;

procedure TCrdgrpDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCrdgrpDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCrdgrpDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCrdgrpDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCrdgrpDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCrdgrpDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
