unit dEBADAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEtUl='EtUl';

type
  TEbadatDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetEbaTyp:Str10;            procedure SetEbaTyp(pValue:Str10);
    function GetUsrLog:Str10;            procedure SetUsrLog(pValue:Str10);
    function GetUsrNam:Str30;            procedure SetUsrNam(pValue:Str30);
    function GetUsrNam_:Str30;           procedure SetUsrNam_(pValue:Str30);
    function GetUsrIdc:Str20;            procedure SetUsrIdc(pValue:Str20);
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
    function LocEtUl(pEbaTyp:Str10;pUsrLog:Str10):boolean;
    function NearEtUl(pEbaTyp:Str10;pUsrLog:Str10):boolean;

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
    property EbaTyp:Str10 read GetEbaTyp write SetEbaTyp;
    property UsrLog:Str10 read GetUsrLog write SetUsrLog;
    property UsrNam:Str30 read GetUsrNam write SetUsrNam;
    property UsrNam_:Str30 read GetUsrNam_ write SetUsrNam_;
    property UsrIdc:Str20 read GetUsrIdc write SetUsrIdc;
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

constructor TEbadatDat.Create;
begin
  oTable:=DatInit('EBADAT',gPath.LdgPath,Self);
end;

constructor TEbadatDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EBADAT',pPath,Self);
end;

destructor TEbadatDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEbadatDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEbadatDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEbadatDat.GetEbaTyp:Str10;
begin
  Result:=oTable.FieldByName('EbaTyp').AsString;
end;

procedure TEbadatDat.SetEbaTyp(pValue:Str10);
begin
  oTable.FieldByName('EbaTyp').AsString:=pValue;
end;

function TEbadatDat.GetUsrLog:Str10;
begin
  Result:=oTable.FieldByName('UsrLog').AsString;
end;

procedure TEbadatDat.SetUsrLog(pValue:Str10);
begin
  oTable.FieldByName('UsrLog').AsString:=pValue;
end;

function TEbadatDat.GetUsrNam:Str30;
begin
  Result:=oTable.FieldByName('UsrNam').AsString;
end;

procedure TEbadatDat.SetUsrNam(pValue:Str30);
begin
  oTable.FieldByName('UsrNam').AsString:=pValue;
end;

function TEbadatDat.GetUsrNam_:Str30;
begin
  Result:=oTable.FieldByName('UsrNam_').AsString;
end;

procedure TEbadatDat.SetUsrNam_(pValue:Str30);
begin
  oTable.FieldByName('UsrNam_').AsString:=pValue;
end;

function TEbadatDat.GetUsrIdc:Str20;
begin
  Result:=oTable.FieldByName('UsrIdc').AsString;
end;

procedure TEbadatDat.SetUsrIdc(pValue:Str20);
begin
  oTable.FieldByName('UsrIdc').AsString:=pValue;
end;

function TEbadatDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TEbadatDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TEbadatDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TEbadatDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TEbadatDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TEbadatDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TEbadatDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TEbadatDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TEbadatDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TEbadatDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TEbadatDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TEbadatDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TEbadatDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TEbadatDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TEbadatDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TEbadatDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEbadatDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEbadatDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEbadatDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEbadatDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEbadatDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEbadatDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEbadatDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEbadatDat.LocEtUl(pEbaTyp:Str10;pUsrLog:Str10):boolean;
begin
  SetIndex(ixEtUl);
  Result:=oTable.FindKey([pEbaTyp,pUsrLog]);
end;

function TEbadatDat.NearEtUl(pEbaTyp:Str10;pUsrLog:Str10):boolean;
begin
  SetIndex(ixEtUl);
  Result:=oTable.FindNearest([pEbaTyp,pUsrLog]);
end;

procedure TEbadatDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEbadatDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEbadatDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEbadatDat.Prior;
begin
  oTable.Prior;
end;

procedure TEbadatDat.Next;
begin
  oTable.Next;
end;

procedure TEbadatDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEbadatDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEbadatDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEbadatDat.Edit;
begin
  oTable.Edit;
end;

procedure TEbadatDat.Post;
begin
  oTable.Post;
end;

procedure TEbadatDat.Delete;
begin
  oTable.Delete;
end;

procedure TEbadatDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEbadatDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEbadatDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEbadatDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEbadatDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEbadatDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
