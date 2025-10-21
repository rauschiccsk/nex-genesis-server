unit dIVMIVD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixSerNum='SerNum';

type
  TIvmivdDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetDocDes:Str50;            procedure SetDocDes(pValue:Str50);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetPgrLst:Str200;           procedure SetPgrLst(pValue:Str200);
    function GetIvfTyp:byte;             procedure SetIvfTyp(pValue:byte);
    function GetIvpTyp:Str1;             procedure SetIvpTyp(pValue:Str1);
    function GetNsiVal:double;           procedure SetNsiVal(pValue:double);
    function GetStkVal:double;           procedure SetStkVal(pValue:double);
    function GetIvdVal:double;           procedure SetIvdVal(pValue:double);
    function GetPozVal:double;           procedure SetPozVal(pValue:double);
    function GetNegVal:double;           procedure SetNegVal(pValue:double);
    function GetDifVal:double;           procedure SetDifVal(pValue:double);
    function GetImdNum:Str12;            procedure SetImdNum(pValue:Str12);
    function GetOmdNum:Str12;            procedure SetOmdNum(pValue:Str12);
    function GetPkdNum:Str12;            procedure SetPkdNum(pValue:Str12);
    function GetClsUsr:Str10;            procedure SetClsUsr(pValue:Str10);
    function GetClsUsn:Str30;            procedure SetClsUsn(pValue:Str30);
    function GetClsDte:TDatetime;        procedure SetClsDte(pValue:TDatetime);
    function GetClsTim:TDatetime;        procedure SetClsTim(pValue:TDatetime);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr(pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn(pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
    function GetMrgUsr:Str10;            procedure SetMrgUsr(pValue:Str10);
    function GetMrgUsn:Str30;            procedure SetMrgUsn(pValue:Str30);
    function GetMrgDte:TDatetime;        procedure SetMrgDte(pValue:TDatetime);
    function GetMrgTim:TDatetime;        procedure SetMrgTim(pValue:TDatetime);
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
    function LocSerNum(pSerNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearSerNum(pSerNum:word):boolean;

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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:word read GetSerNum write SetSerNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property DocDes:Str50 read GetDocDes write SetDocDes;
    property StkNum:word read GetStkNum write SetStkNum;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property PgrLst:Str200 read GetPgrLst write SetPgrLst;
    property IvfTyp:byte read GetIvfTyp write SetIvfTyp;
    property IvpTyp:Str1 read GetIvpTyp write SetIvpTyp;
    property NsiVal:double read GetNsiVal write SetNsiVal;
    property StkVal:double read GetStkVal write SetStkVal;
    property IvdVal:double read GetIvdVal write SetIvdVal;
    property PozVal:double read GetPozVal write SetPozVal;
    property NegVal:double read GetNegVal write SetNegVal;
    property DifVal:double read GetDifVal write SetDifVal;
    property ImdNum:Str12 read GetImdNum write SetImdNum;
    property OmdNum:Str12 read GetOmdNum write SetOmdNum;
    property PkdNum:Str12 read GetPkdNum write SetPkdNum;
    property ClsUsr:Str10 read GetClsUsr write SetClsUsr;
    property ClsUsn:Str30 read GetClsUsn write SetClsUsn;
    property ClsDte:TDatetime read GetClsDte write SetClsDte;
    property ClsTim:TDatetime read GetClsTim write SetClsTim;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str10 read GetModUsr write SetModUsr;
    property ModUsn:Str30 read GetModUsn write SetModUsn;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
    property MrgUsr:Str10 read GetMrgUsr write SetMrgUsr;
    property MrgUsn:Str30 read GetMrgUsn write SetMrgUsn;
    property MrgDte:TDatetime read GetMrgDte write SetMrgDte;
    property MrgTim:TDatetime read GetMrgTim write SetMrgTim;
  end;

implementation

constructor TIvmivdDat.Create;
begin
  oTable:=DatInit('IVMIVD',gPath.StkPath,Self);
end;

constructor TIvmivdDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('IVMIVD',pPath,Self);
end;

destructor TIvmivdDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TIvmivdDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TIvmivdDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TIvmivdDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TIvmivdDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIvmivdDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TIvmivdDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TIvmivdDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TIvmivdDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TIvmivdDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TIvmivdDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIvmivdDat.GetDocDes:Str50;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TIvmivdDat.SetDocDes(pValue:Str50);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TIvmivdDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TIvmivdDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIvmivdDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TIvmivdDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TIvmivdDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TIvmivdDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TIvmivdDat.GetPgrLst:Str200;
begin
  Result:=oTable.FieldByName('PgrLst').AsString;
end;

procedure TIvmivdDat.SetPgrLst(pValue:Str200);
begin
  oTable.FieldByName('PgrLst').AsString:=pValue;
end;

function TIvmivdDat.GetIvfTyp:byte;
begin
  Result:=oTable.FieldByName('IvfTyp').AsInteger;
end;

procedure TIvmivdDat.SetIvfTyp(pValue:byte);
begin
  oTable.FieldByName('IvfTyp').AsInteger:=pValue;
end;

function TIvmivdDat.GetIvpTyp:Str1;
begin
  Result:=oTable.FieldByName('IvpTyp').AsString;
end;

procedure TIvmivdDat.SetIvpTyp(pValue:Str1);
begin
  oTable.FieldByName('IvpTyp').AsString:=pValue;
end;

function TIvmivdDat.GetNsiVal:double;
begin
  Result:=oTable.FieldByName('NsiVal').AsFloat;
end;

procedure TIvmivdDat.SetNsiVal(pValue:double);
begin
  oTable.FieldByName('NsiVal').AsFloat:=pValue;
end;

function TIvmivdDat.GetStkVal:double;
begin
  Result:=oTable.FieldByName('StkVal').AsFloat;
end;

procedure TIvmivdDat.SetStkVal(pValue:double);
begin
  oTable.FieldByName('StkVal').AsFloat:=pValue;
end;

function TIvmivdDat.GetIvdVal:double;
begin
  Result:=oTable.FieldByName('IvdVal').AsFloat;
end;

procedure TIvmivdDat.SetIvdVal(pValue:double);
begin
  oTable.FieldByName('IvdVal').AsFloat:=pValue;
end;

function TIvmivdDat.GetPozVal:double;
begin
  Result:=oTable.FieldByName('PozVal').AsFloat;
end;

procedure TIvmivdDat.SetPozVal(pValue:double);
begin
  oTable.FieldByName('PozVal').AsFloat:=pValue;
end;

function TIvmivdDat.GetNegVal:double;
begin
  Result:=oTable.FieldByName('NegVal').AsFloat;
end;

procedure TIvmivdDat.SetNegVal(pValue:double);
begin
  oTable.FieldByName('NegVal').AsFloat:=pValue;
end;

function TIvmivdDat.GetDifVal:double;
begin
  Result:=oTable.FieldByName('DifVal').AsFloat;
end;

procedure TIvmivdDat.SetDifVal(pValue:double);
begin
  oTable.FieldByName('DifVal').AsFloat:=pValue;
end;

function TIvmivdDat.GetImdNum:Str12;
begin
  Result:=oTable.FieldByName('ImdNum').AsString;
end;

procedure TIvmivdDat.SetImdNum(pValue:Str12);
begin
  oTable.FieldByName('ImdNum').AsString:=pValue;
end;

function TIvmivdDat.GetOmdNum:Str12;
begin
  Result:=oTable.FieldByName('OmdNum').AsString;
end;

procedure TIvmivdDat.SetOmdNum(pValue:Str12);
begin
  oTable.FieldByName('OmdNum').AsString:=pValue;
end;

function TIvmivdDat.GetPkdNum:Str12;
begin
  Result:=oTable.FieldByName('PkdNum').AsString;
end;

procedure TIvmivdDat.SetPkdNum(pValue:Str12);
begin
  oTable.FieldByName('PkdNum').AsString:=pValue;
end;

function TIvmivdDat.GetClsUsr:Str10;
begin
  Result:=oTable.FieldByName('ClsUsr').AsString;
end;

procedure TIvmivdDat.SetClsUsr(pValue:Str10);
begin
  oTable.FieldByName('ClsUsr').AsString:=pValue;
end;

function TIvmivdDat.GetClsUsn:Str30;
begin
  Result:=oTable.FieldByName('ClsUsn').AsString;
end;

procedure TIvmivdDat.SetClsUsn(pValue:Str30);
begin
  oTable.FieldByName('ClsUsn').AsString:=pValue;
end;

function TIvmivdDat.GetClsDte:TDatetime;
begin
  Result:=oTable.FieldByName('ClsDte').AsDateTime;
end;

procedure TIvmivdDat.SetClsDte(pValue:TDatetime);
begin
  oTable.FieldByName('ClsDte').AsDateTime:=pValue;
end;

function TIvmivdDat.GetClsTim:TDatetime;
begin
  Result:=oTable.FieldByName('ClsTim').AsDateTime;
end;

procedure TIvmivdDat.SetClsTim(pValue:TDatetime);
begin
  oTable.FieldByName('ClsTim').AsDateTime:=pValue;
end;

function TIvmivdDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TIvmivdDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIvmivdDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TIvmivdDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIvmivdDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIvmivdDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIvmivdDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIvmivdDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIvmivdDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TIvmivdDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TIvmivdDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TIvmivdDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TIvmivdDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TIvmivdDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TIvmivdDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TIvmivdDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TIvmivdDat.GetMrgUsr:Str10;
begin
  Result:=oTable.FieldByName('MrgUsr').AsString;
end;

procedure TIvmivdDat.SetMrgUsr(pValue:Str10);
begin
  oTable.FieldByName('MrgUsr').AsString:=pValue;
end;

function TIvmivdDat.GetMrgUsn:Str30;
begin
  Result:=oTable.FieldByName('MrgUsn').AsString;
end;

procedure TIvmivdDat.SetMrgUsn(pValue:Str30);
begin
  oTable.FieldByName('MrgUsn').AsString:=pValue;
end;

function TIvmivdDat.GetMrgDte:TDatetime;
begin
  Result:=oTable.FieldByName('MrgDte').AsDateTime;
end;

procedure TIvmivdDat.SetMrgDte(pValue:TDatetime);
begin
  oTable.FieldByName('MrgDte').AsDateTime:=pValue;
end;

function TIvmivdDat.GetMrgTim:TDatetime;
begin
  Result:=oTable.FieldByName('MrgTim').AsDateTime;
end;

procedure TIvmivdDat.SetMrgTim(pValue:TDatetime);
begin
  oTable.FieldByName('MrgTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvmivdDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TIvmivdDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TIvmivdDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TIvmivdDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TIvmivdDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TIvmivdDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TIvmivdDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TIvmivdDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TIvmivdDat.LocSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindKey([pSerNum]);
end;

function TIvmivdDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TIvmivdDat.NearSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindNearest([pSerNum]);
end;

procedure TIvmivdDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TIvmivdDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TIvmivdDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TIvmivdDat.Prior;
begin
  oTable.Prior;
end;

procedure TIvmivdDat.Next;
begin
  oTable.Next;
end;

procedure TIvmivdDat.First;
begin
  Open;
  oTable.First;
end;

procedure TIvmivdDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TIvmivdDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TIvmivdDat.Edit;
begin
  oTable.Edit;
end;

procedure TIvmivdDat.Post;
begin
  oTable.Post;
end;

procedure TIvmivdDat.Delete;
begin
  oTable.Delete;
end;

procedure TIvmivdDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TIvmivdDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TIvmivdDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TIvmivdDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TIvmivdDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TIvmivdDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
