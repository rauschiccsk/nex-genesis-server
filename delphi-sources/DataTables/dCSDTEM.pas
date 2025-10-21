unit dCSDTEM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum='SerNum';

type
  TCsdtemDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetSerNum:longint;          procedure SetSerNum(pValue:longint);
    function GetDocTyp:Str1;             procedure SetDocTyp(pValue:Str1);
    function GetPerNam:Str50;            procedure SetPerNam(pValue:Str50);
    function GetCorCan:longint;          procedure SetCorCan(pValue:longint);
    function GetCorNam:Str100;           procedure SetCorNam(pValue:Str100);
    function GetCorAdr:Str100;           procedure SetCorAdr(pValue:Str100);
    function GetCorIno:Str10;            procedure SetCorIno(pValue:Str10);
    function GetCorTin:Str12;            procedure SetCorTin(pValue:Str12);
    function GetCorVin:Str15;            procedure SetCorVin(pValue:Str15);
    function GetVatPrc:byte;             procedure SetVatPrc(pValue:byte);
    function GetPayVal:double;           procedure SetPayVal(pValue:double);
    function GetPayTxt:Str100;           procedure SetPayTxt(pValue:Str100);
    function GetPayDes:Str100;           procedure SetPayDes(pValue:Str100);
    function GetAccSnt:Str3;             procedure SetAccSnt(pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl(pValue:Str6);
    function GetHotKey:Str10;            procedure SetHotKey(pValue:Str10);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
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
    function LocSerNum(pSerNum:longint):boolean;
    function NearSerNum(pSerNum:longint):boolean;

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
    property SerNum:longint read GetSerNum write SetSerNum;
    property DocTyp:Str1 read GetDocTyp write SetDocTyp;
    property PerNam:Str50 read GetPerNam write SetPerNam;
    property CorCan:longint read GetCorCan write SetCorCan;
    property CorNam:Str100 read GetCorNam write SetCorNam;
    property CorAdr:Str100 read GetCorAdr write SetCorAdr;
    property CorIno:Str10 read GetCorIno write SetCorIno;
    property CorTin:Str12 read GetCorTin write SetCorTin;
    property CorVin:Str15 read GetCorVin write SetCorVin;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property PayVal:double read GetPayVal write SetPayVal;
    property PayTxt:Str100 read GetPayTxt write SetPayTxt;
    property PayDes:Str100 read GetPayDes write SetPayDes;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property HotKey:Str10 read GetHotKey write SetHotKey;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TCsdtemDat.Create;
begin
  oTable:=DatInit('CSDTEM',gPath.StkPath,Self);
end;

constructor TCsdtemDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CSDTEM',pPath,Self);
end;

destructor TCsdtemDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCsdtemDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCsdtemDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCsdtemDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TCsdtemDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TCsdtemDat.GetDocTyp:Str1;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TCsdtemDat.SetDocTyp(pValue:Str1);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TCsdtemDat.GetPerNam:Str50;
begin
  Result:=oTable.FieldByName('PerNam').AsString;
end;

procedure TCsdtemDat.SetPerNam(pValue:Str50);
begin
  oTable.FieldByName('PerNam').AsString:=pValue;
end;

function TCsdtemDat.GetCorCan:longint;
begin
  Result:=oTable.FieldByName('CorCan').AsInteger;
end;

procedure TCsdtemDat.SetCorCan(pValue:longint);
begin
  oTable.FieldByName('CorCan').AsInteger:=pValue;
end;

function TCsdtemDat.GetCorNam:Str100;
begin
  Result:=oTable.FieldByName('CorNam').AsString;
end;

procedure TCsdtemDat.SetCorNam(pValue:Str100);
begin
  oTable.FieldByName('CorNam').AsString:=pValue;
end;

function TCsdtemDat.GetCorAdr:Str100;
begin
  Result:=oTable.FieldByName('CorAdr').AsString;
end;

procedure TCsdtemDat.SetCorAdr(pValue:Str100);
begin
  oTable.FieldByName('CorAdr').AsString:=pValue;
end;

function TCsdtemDat.GetCorIno:Str10;
begin
  Result:=oTable.FieldByName('CorIno').AsString;
end;

procedure TCsdtemDat.SetCorIno(pValue:Str10);
begin
  oTable.FieldByName('CorIno').AsString:=pValue;
end;

function TCsdtemDat.GetCorTin:Str12;
begin
  Result:=oTable.FieldByName('CorTin').AsString;
end;

procedure TCsdtemDat.SetCorTin(pValue:Str12);
begin
  oTable.FieldByName('CorTin').AsString:=pValue;
end;

function TCsdtemDat.GetCorVin:Str15;
begin
  Result:=oTable.FieldByName('CorVin').AsString;
end;

procedure TCsdtemDat.SetCorVin(pValue:Str15);
begin
  oTable.FieldByName('CorVin').AsString:=pValue;
end;

function TCsdtemDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCsdtemDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TCsdtemDat.GetPayVal:double;
begin
  Result:=oTable.FieldByName('PayVal').AsFloat;
end;

procedure TCsdtemDat.SetPayVal(pValue:double);
begin
  oTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TCsdtemDat.GetPayTxt:Str100;
begin
  Result:=oTable.FieldByName('PayTxt').AsString;
end;

procedure TCsdtemDat.SetPayTxt(pValue:Str100);
begin
  oTable.FieldByName('PayTxt').AsString:=pValue;
end;

function TCsdtemDat.GetPayDes:Str100;
begin
  Result:=oTable.FieldByName('PayDes').AsString;
end;

procedure TCsdtemDat.SetPayDes(pValue:Str100);
begin
  oTable.FieldByName('PayDes').AsString:=pValue;
end;

function TCsdtemDat.GetAccSnt:Str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TCsdtemDat.SetAccSnt(pValue:Str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TCsdtemDat.GetAccAnl:Str6;
begin
  Result:=oTable.FieldByName('AccAnl').AsString;
end;

procedure TCsdtemDat.SetAccAnl(pValue:Str6);
begin
  oTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TCsdtemDat.GetHotKey:Str10;
begin
  Result:=oTable.FieldByName('HotKey').AsString;
end;

procedure TCsdtemDat.SetHotKey(pValue:Str10);
begin
  oTable.FieldByName('HotKey').AsString:=pValue;
end;

function TCsdtemDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TCsdtemDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TCsdtemDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TCsdtemDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TCsdtemDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TCsdtemDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TCsdtemDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TCsdtemDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsdtemDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCsdtemDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCsdtemDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCsdtemDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCsdtemDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCsdtemDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCsdtemDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCsdtemDat.LocSerNum(pSerNum:longint):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindKey([pSerNum]);
end;

function TCsdtemDat.NearSerNum(pSerNum:longint):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindNearest([pSerNum]);
end;

procedure TCsdtemDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCsdtemDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCsdtemDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCsdtemDat.Prior;
begin
  oTable.Prior;
end;

procedure TCsdtemDat.Next;
begin
  oTable.Next;
end;

procedure TCsdtemDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCsdtemDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCsdtemDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCsdtemDat.Edit;
begin
  oTable.Edit;
end;

procedure TCsdtemDat.Post;
begin
  oTable.Post;
end;

procedure TCsdtemDat.Delete;
begin
  oTable.Delete;
end;

procedure TCsdtemDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCsdtemDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCsdtemDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCsdtemDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCsdtemDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCsdtemDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
