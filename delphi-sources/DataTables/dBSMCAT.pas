unit dBSMCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOprNum='OprNum';
  ixOprCod='OprCod';
  ixOprTyp='OprTyp';
  ixVarSym='VarSym';
  ixPayDes='PayDes';
  ixSnAn='SnAn';

type
  TBsmcatDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetOprNum:word;             procedure SetOprNum(pValue:word);
    function GetOprCod:Str15;            procedure SetOprCod(pValue:Str15);
    function GetOprTyp:Str1;             procedure SetOprTyp(pValue:Str1);
    function GetVarSym:Str12;            procedure SetVarSym(pValue:Str12);
    function GetSpcSym:Str12;            procedure SetSpcSym(pValue:Str12);
    function GetConSym:Str4;             procedure SetConSym(pValue:Str4);
    function GetPayDes:Str60;            procedure SetPayDes(pValue:Str60);
    function GetPayDes_:Str60;           procedure SetPayDes_(pValue:Str60);
    function GetPayVal:double;           procedure SetPayVal(pValue:double);
    function GetAccSnt:Str3;             procedure SetAccSnt(pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl(pValue:Str6);
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
    function LocOprNum(pOprNum:word):boolean;
    function LocOprCod(pOprCod:Str15):boolean;
    function LocOprTyp(pOprTyp:Str1):boolean;
    function LocVarSym(pVarSym:Str12):boolean;
    function LocPayDes(pPayDes_:Str60):boolean;
    function LocSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearOprNum(pOprNum:word):boolean;
    function NearOprCod(pOprCod:Str15):boolean;
    function NearOprTyp(pOprTyp:Str1):boolean;
    function NearVarSym(pVarSym:Str12):boolean;
    function NearPayDes(pPayDes_:Str60):boolean;
    function NearSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property OprNum:word read GetOprNum write SetOprNum;
    property OprCod:Str15 read GetOprCod write SetOprCod;
    property OprTyp:Str1 read GetOprTyp write SetOprTyp;
    property VarSym:Str12 read GetVarSym write SetVarSym;
    property SpcSym:Str12 read GetSpcSym write SetSpcSym;
    property ConSym:Str4 read GetConSym write SetConSym;
    property PayDes:Str60 read GetPayDes write SetPayDes;
    property PayDes_:Str60 read GetPayDes_ write SetPayDes_;
    property PayVal:double read GetPayVal write SetPayVal;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
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

constructor TBsmcatDat.Create;
begin
  oTable:=DatInit('BSMCAT',gPath.LdgPath,Self);
end;

constructor TBsmcatDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BSMCAT',pPath,Self);
end;

destructor TBsmcatDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBsmcatDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBsmcatDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBsmcatDat.GetOprNum:word;
begin
  Result:=oTable.FieldByName('OprNum').AsInteger;
end;

procedure TBsmcatDat.SetOprNum(pValue:word);
begin
  oTable.FieldByName('OprNum').AsInteger:=pValue;
end;

function TBsmcatDat.GetOprCod:Str15;
begin
  Result:=oTable.FieldByName('OprCod').AsString;
end;

procedure TBsmcatDat.SetOprCod(pValue:Str15);
begin
  oTable.FieldByName('OprCod').AsString:=pValue;
end;

function TBsmcatDat.GetOprTyp:Str1;
begin
  Result:=oTable.FieldByName('OprTyp').AsString;
end;

procedure TBsmcatDat.SetOprTyp(pValue:Str1);
begin
  oTable.FieldByName('OprTyp').AsString:=pValue;
end;

function TBsmcatDat.GetVarSym:Str12;
begin
  Result:=oTable.FieldByName('VarSym').AsString;
end;

procedure TBsmcatDat.SetVarSym(pValue:Str12);
begin
  oTable.FieldByName('VarSym').AsString:=pValue;
end;

function TBsmcatDat.GetSpcSym:Str12;
begin
  Result:=oTable.FieldByName('SpcSym').AsString;
end;

procedure TBsmcatDat.SetSpcSym(pValue:Str12);
begin
  oTable.FieldByName('SpcSym').AsString:=pValue;
end;

function TBsmcatDat.GetConSym:Str4;
begin
  Result:=oTable.FieldByName('ConSym').AsString;
end;

procedure TBsmcatDat.SetConSym(pValue:Str4);
begin
  oTable.FieldByName('ConSym').AsString:=pValue;
end;

function TBsmcatDat.GetPayDes:Str60;
begin
  Result:=oTable.FieldByName('PayDes').AsString;
end;

procedure TBsmcatDat.SetPayDes(pValue:Str60);
begin
  oTable.FieldByName('PayDes').AsString:=pValue;
end;

function TBsmcatDat.GetPayDes_:Str60;
begin
  Result:=oTable.FieldByName('PayDes_').AsString;
end;

procedure TBsmcatDat.SetPayDes_(pValue:Str60);
begin
  oTable.FieldByName('PayDes_').AsString:=pValue;
end;

function TBsmcatDat.GetPayVal:double;
begin
  Result:=oTable.FieldByName('PayVal').AsFloat;
end;

procedure TBsmcatDat.SetPayVal(pValue:double);
begin
  oTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TBsmcatDat.GetAccSnt:Str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TBsmcatDat.SetAccSnt(pValue:Str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TBsmcatDat.GetAccAnl:Str6;
begin
  Result:=oTable.FieldByName('AccAnl').AsString;
end;

procedure TBsmcatDat.SetAccAnl(pValue:Str6);
begin
  oTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TBsmcatDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBsmcatDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBsmcatDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TBsmcatDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBsmcatDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBsmcatDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBsmcatDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBsmcatDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBsmcatDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TBsmcatDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TBsmcatDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TBsmcatDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TBsmcatDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TBsmcatDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TBsmcatDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TBsmcatDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBsmcatDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBsmcatDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBsmcatDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBsmcatDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBsmcatDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBsmcatDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBsmcatDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBsmcatDat.LocOprNum(pOprNum:word):boolean;
begin
  SetIndex(ixOprNum);
  Result:=oTable.FindKey([pOprNum]);
end;

function TBsmcatDat.LocOprCod(pOprCod:Str15):boolean;
begin
  SetIndex(ixOprCod);
  Result:=oTable.FindKey([pOprCod]);
end;

function TBsmcatDat.LocOprTyp(pOprTyp:Str1):boolean;
begin
  SetIndex(ixOprTyp);
  Result:=oTable.FindKey([pOprTyp]);
end;

function TBsmcatDat.LocVarSym(pVarSym:Str12):boolean;
begin
  SetIndex(ixVarSym);
  Result:=oTable.FindKey([pVarSym]);
end;

function TBsmcatDat.LocPayDes(pPayDes_:Str60):boolean;
begin
  SetIndex(ixPayDes);
  Result:=oTable.FindKey([StrToAlias(pPayDes_)]);
end;

function TBsmcatDat.LocSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex(ixSnAn);
  Result:=oTable.FindKey([pAccSnt,pAccAnl]);
end;

function TBsmcatDat.NearOprNum(pOprNum:word):boolean;
begin
  SetIndex(ixOprNum);
  Result:=oTable.FindNearest([pOprNum]);
end;

function TBsmcatDat.NearOprCod(pOprCod:Str15):boolean;
begin
  SetIndex(ixOprCod);
  Result:=oTable.FindNearest([pOprCod]);
end;

function TBsmcatDat.NearOprTyp(pOprTyp:Str1):boolean;
begin
  SetIndex(ixOprTyp);
  Result:=oTable.FindNearest([pOprTyp]);
end;

function TBsmcatDat.NearVarSym(pVarSym:Str12):boolean;
begin
  SetIndex(ixVarSym);
  Result:=oTable.FindNearest([pVarSym]);
end;

function TBsmcatDat.NearPayDes(pPayDes_:Str60):boolean;
begin
  SetIndex(ixPayDes);
  Result:=oTable.FindNearest([pPayDes_]);
end;

function TBsmcatDat.NearSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex(ixSnAn);
  Result:=oTable.FindNearest([pAccSnt,pAccAnl]);
end;

procedure TBsmcatDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBsmcatDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBsmcatDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBsmcatDat.Prior;
begin
  oTable.Prior;
end;

procedure TBsmcatDat.Next;
begin
  oTable.Next;
end;

procedure TBsmcatDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBsmcatDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBsmcatDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBsmcatDat.Edit;
begin
  oTable.Edit;
end;

procedure TBsmcatDat.Post;
begin
  oTable.Post;
end;

procedure TBsmcatDat.Delete;
begin
  oTable.Delete;
end;

procedure TBsmcatDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBsmcatDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBsmcatDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBsmcatDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBsmcatDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBsmcatDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
