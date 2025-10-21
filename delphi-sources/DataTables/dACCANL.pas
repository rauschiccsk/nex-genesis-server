unit dACCANL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnAn='SnAn';
  ixAccSnt='AccSnt';
  ixAnlNam='AnlNam';
  ixCrdTrn='CrdTrn';
  ixDebTrn='DebTrn';
  ixDifVal='DifVal';

type
  TAccanlDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetAccSnt:str3;             procedure SetAccSnt(pValue:str3);
    function GetAccAnl:str6;             procedure SetAccAnl(pValue:str6);
    function GetAnlNam:Str30;            procedure SetAnlNam(pValue:Str30);
    function GetAnlNam_:Str30;           procedure SetAnlNam_(pValue:Str30);
    function GetCrdT01:double;           procedure SetCrdT01(pValue:double);
    function GetDebT01:double;           procedure SetDebT01(pValue:double);
    function GetCrdT02:double;           procedure SetCrdT02(pValue:double);
    function GetDebT02:double;           procedure SetDebT02(pValue:double);
    function GetCrdT03:double;           procedure SetCrdT03(pValue:double);
    function GetDebT03:double;           procedure SetDebT03(pValue:double);
    function GetCrdT04:double;           procedure SetCrdT04(pValue:double);
    function GetDebT04:double;           procedure SetDebT04(pValue:double);
    function GetCrdT05:double;           procedure SetCrdT05(pValue:double);
    function GetDebT05:double;           procedure SetDebT05(pValue:double);
    function GetCrdT06:double;           procedure SetCrdT06(pValue:double);
    function GetDebT06:double;           procedure SetDebT06(pValue:double);
    function GetCrdT07:double;           procedure SetCrdT07(pValue:double);
    function GetDebT07:double;           procedure SetDebT07(pValue:double);
    function GetCrdT08:double;           procedure SetCrdT08(pValue:double);
    function GetDebT08:double;           procedure SetDebT08(pValue:double);
    function GetCrdT09:double;           procedure SetCrdT09(pValue:double);
    function GetDebT09:double;           procedure SetDebT09(pValue:double);
    function GetCrdT10:double;           procedure SetCrdT10(pValue:double);
    function GetDebT10:double;           procedure SetDebT10(pValue:double);
    function GetCrdT11:double;           procedure SetCrdT11(pValue:double);
    function GetDebT11:double;           procedure SetDebT11(pValue:double);
    function GetCrdT12:double;           procedure SetCrdT12(pValue:double);
    function GetDebT12:double;           procedure SetDebT12(pValue:double);
    function GetCrdBeg:double;           procedure SetCrdBeg(pValue:double);
    function GetDebBeg:double;           procedure SetDebBeg(pValue:double);
    function GetCrdTrn:double;           procedure SetCrdTrn(pValue:double);
    function GetDebTrn:double;           procedure SetDebTrn(pValue:double);
    function GetCrdEnd:double;           procedure SetCrdEnd(pValue:double);
    function GetDebEnd:double;           procedure SetDebEnd(pValue:double);
    function GetDifVal:double;           procedure SetDifVal(pValue:double);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
    function GetTaxNot:byte;             procedure SetTaxNot(pValue:byte);
    function GetAccTyp:Str1;             procedure SetAccTyp(pValue:Str1);
    function GetBalanc:Str1;             procedure SetBalanc(pValue:Str1);
    function GetFjrRow:Str2;             procedure SetFjrRow(pValue:Str2);
    function Getx_ResText:Str43;         procedure Setx_ResText(pValue:Str43);
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
    function LocSnAn(pAccSnt:str3;pAccAnl:str6):boolean;
    function LocAccSnt(pAccSnt:str3):boolean;
    function LocAnlNam(pAnlNam_:Str30):boolean;
    function LocCrdTrn(pCrdTrn:double):boolean;
    function LocDebTrn(pDebTrn:double):boolean;
    function LocDifVal(pDifVal:double):boolean;
    function NearSnAn(pAccSnt:str3;pAccAnl:str6):boolean;
    function NearAccSnt(pAccSnt:str3):boolean;
    function NearAnlNam(pAnlNam_:Str30):boolean;
    function NearCrdTrn(pCrdTrn:double):boolean;
    function NearDebTrn(pDebTrn:double):boolean;
    function NearDifVal(pDifVal:double):boolean;

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
    property AccSnt:str3 read GetAccSnt write SetAccSnt;
    property AccAnl:str6 read GetAccAnl write SetAccAnl;
    property AnlNam:Str30 read GetAnlNam write SetAnlNam;
    property AnlNam_:Str30 read GetAnlNam_ write SetAnlNam_;
    property CrdT01:double read GetCrdT01 write SetCrdT01;
    property DebT01:double read GetDebT01 write SetDebT01;
    property CrdT02:double read GetCrdT02 write SetCrdT02;
    property DebT02:double read GetDebT02 write SetDebT02;
    property CrdT03:double read GetCrdT03 write SetCrdT03;
    property DebT03:double read GetDebT03 write SetDebT03;
    property CrdT04:double read GetCrdT04 write SetCrdT04;
    property DebT04:double read GetDebT04 write SetDebT04;
    property CrdT05:double read GetCrdT05 write SetCrdT05;
    property DebT05:double read GetDebT05 write SetDebT05;
    property CrdT06:double read GetCrdT06 write SetCrdT06;
    property DebT06:double read GetDebT06 write SetDebT06;
    property CrdT07:double read GetCrdT07 write SetCrdT07;
    property DebT07:double read GetDebT07 write SetDebT07;
    property CrdT08:double read GetCrdT08 write SetCrdT08;
    property DebT08:double read GetDebT08 write SetDebT08;
    property CrdT09:double read GetCrdT09 write SetCrdT09;
    property DebT09:double read GetDebT09 write SetDebT09;
    property CrdT10:double read GetCrdT10 write SetCrdT10;
    property DebT10:double read GetDebT10 write SetDebT10;
    property CrdT11:double read GetCrdT11 write SetCrdT11;
    property DebT11:double read GetDebT11 write SetDebT11;
    property CrdT12:double read GetCrdT12 write SetCrdT12;
    property DebT12:double read GetDebT12 write SetDebT12;
    property CrdBeg:double read GetCrdBeg write SetCrdBeg;
    property DebBeg:double read GetDebBeg write SetDebBeg;
    property CrdTrn:double read GetCrdTrn write SetCrdTrn;
    property DebTrn:double read GetDebTrn write SetDebTrn;
    property CrdEnd:double read GetCrdEnd write SetCrdEnd;
    property DebEnd:double read GetDebEnd write SetDebEnd;
    property DifVal:double read GetDifVal write SetDifVal;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
    property TaxNot:byte read GetTaxNot write SetTaxNot;
    property AccTyp:Str1 read GetAccTyp write SetAccTyp;
    property Balanc:Str1 read GetBalanc write SetBalanc;
    property FjrRow:Str2 read GetFjrRow write SetFjrRow;
    property x_ResText:Str43 read Getx_ResText write Setx_ResText;
  end;

implementation

constructor TAccanlDat.Create;
begin
  oTable:=DatInit('ACCANL',gPath.LdgPath,Self);
end;

constructor TAccanlDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ACCANL',pPath,Self);
end;

destructor TAccanlDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TAccanlDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TAccanlDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TAccanlDat.GetAccSnt:str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TAccanlDat.SetAccSnt(pValue:str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAccanlDat.GetAccAnl:str6;
begin
  Result:=oTable.FieldByName('AccAnl').AsString;
end;

procedure TAccanlDat.SetAccAnl(pValue:str6);
begin
  oTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAccanlDat.GetAnlNam:Str30;
begin
  Result:=oTable.FieldByName('AnlNam').AsString;
end;

procedure TAccanlDat.SetAnlNam(pValue:Str30);
begin
  oTable.FieldByName('AnlNam').AsString:=pValue;
end;

function TAccanlDat.GetAnlNam_:Str30;
begin
  Result:=oTable.FieldByName('AnlNam_').AsString;
end;

procedure TAccanlDat.SetAnlNam_(pValue:Str30);
begin
  oTable.FieldByName('AnlNam_').AsString:=pValue;
end;

function TAccanlDat.GetCrdT01:double;
begin
  Result:=oTable.FieldByName('CrdT01').AsFloat;
end;

procedure TAccanlDat.SetCrdT01(pValue:double);
begin
  oTable.FieldByName('CrdT01').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT01:double;
begin
  Result:=oTable.FieldByName('DebT01').AsFloat;
end;

procedure TAccanlDat.SetDebT01(pValue:double);
begin
  oTable.FieldByName('DebT01').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT02:double;
begin
  Result:=oTable.FieldByName('CrdT02').AsFloat;
end;

procedure TAccanlDat.SetCrdT02(pValue:double);
begin
  oTable.FieldByName('CrdT02').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT02:double;
begin
  Result:=oTable.FieldByName('DebT02').AsFloat;
end;

procedure TAccanlDat.SetDebT02(pValue:double);
begin
  oTable.FieldByName('DebT02').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT03:double;
begin
  Result:=oTable.FieldByName('CrdT03').AsFloat;
end;

procedure TAccanlDat.SetCrdT03(pValue:double);
begin
  oTable.FieldByName('CrdT03').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT03:double;
begin
  Result:=oTable.FieldByName('DebT03').AsFloat;
end;

procedure TAccanlDat.SetDebT03(pValue:double);
begin
  oTable.FieldByName('DebT03').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT04:double;
begin
  Result:=oTable.FieldByName('CrdT04').AsFloat;
end;

procedure TAccanlDat.SetCrdT04(pValue:double);
begin
  oTable.FieldByName('CrdT04').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT04:double;
begin
  Result:=oTable.FieldByName('DebT04').AsFloat;
end;

procedure TAccanlDat.SetDebT04(pValue:double);
begin
  oTable.FieldByName('DebT04').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT05:double;
begin
  Result:=oTable.FieldByName('CrdT05').AsFloat;
end;

procedure TAccanlDat.SetCrdT05(pValue:double);
begin
  oTable.FieldByName('CrdT05').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT05:double;
begin
  Result:=oTable.FieldByName('DebT05').AsFloat;
end;

procedure TAccanlDat.SetDebT05(pValue:double);
begin
  oTable.FieldByName('DebT05').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT06:double;
begin
  Result:=oTable.FieldByName('CrdT06').AsFloat;
end;

procedure TAccanlDat.SetCrdT06(pValue:double);
begin
  oTable.FieldByName('CrdT06').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT06:double;
begin
  Result:=oTable.FieldByName('DebT06').AsFloat;
end;

procedure TAccanlDat.SetDebT06(pValue:double);
begin
  oTable.FieldByName('DebT06').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT07:double;
begin
  Result:=oTable.FieldByName('CrdT07').AsFloat;
end;

procedure TAccanlDat.SetCrdT07(pValue:double);
begin
  oTable.FieldByName('CrdT07').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT07:double;
begin
  Result:=oTable.FieldByName('DebT07').AsFloat;
end;

procedure TAccanlDat.SetDebT07(pValue:double);
begin
  oTable.FieldByName('DebT07').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT08:double;
begin
  Result:=oTable.FieldByName('CrdT08').AsFloat;
end;

procedure TAccanlDat.SetCrdT08(pValue:double);
begin
  oTable.FieldByName('CrdT08').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT08:double;
begin
  Result:=oTable.FieldByName('DebT08').AsFloat;
end;

procedure TAccanlDat.SetDebT08(pValue:double);
begin
  oTable.FieldByName('DebT08').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT09:double;
begin
  Result:=oTable.FieldByName('CrdT09').AsFloat;
end;

procedure TAccanlDat.SetCrdT09(pValue:double);
begin
  oTable.FieldByName('CrdT09').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT09:double;
begin
  Result:=oTable.FieldByName('DebT09').AsFloat;
end;

procedure TAccanlDat.SetDebT09(pValue:double);
begin
  oTable.FieldByName('DebT09').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT10:double;
begin
  Result:=oTable.FieldByName('CrdT10').AsFloat;
end;

procedure TAccanlDat.SetCrdT10(pValue:double);
begin
  oTable.FieldByName('CrdT10').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT10:double;
begin
  Result:=oTable.FieldByName('DebT10').AsFloat;
end;

procedure TAccanlDat.SetDebT10(pValue:double);
begin
  oTable.FieldByName('DebT10').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT11:double;
begin
  Result:=oTable.FieldByName('CrdT11').AsFloat;
end;

procedure TAccanlDat.SetCrdT11(pValue:double);
begin
  oTable.FieldByName('CrdT11').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT11:double;
begin
  Result:=oTable.FieldByName('DebT11').AsFloat;
end;

procedure TAccanlDat.SetDebT11(pValue:double);
begin
  oTable.FieldByName('DebT11').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdT12:double;
begin
  Result:=oTable.FieldByName('CrdT12').AsFloat;
end;

procedure TAccanlDat.SetCrdT12(pValue:double);
begin
  oTable.FieldByName('CrdT12').AsFloat:=pValue;
end;

function TAccanlDat.GetDebT12:double;
begin
  Result:=oTable.FieldByName('DebT12').AsFloat;
end;

procedure TAccanlDat.SetDebT12(pValue:double);
begin
  oTable.FieldByName('DebT12').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdBeg:double;
begin
  Result:=oTable.FieldByName('CrdBeg').AsFloat;
end;

procedure TAccanlDat.SetCrdBeg(pValue:double);
begin
  oTable.FieldByName('CrdBeg').AsFloat:=pValue;
end;

function TAccanlDat.GetDebBeg:double;
begin
  Result:=oTable.FieldByName('DebBeg').AsFloat;
end;

procedure TAccanlDat.SetDebBeg(pValue:double);
begin
  oTable.FieldByName('DebBeg').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdTrn:double;
begin
  Result:=oTable.FieldByName('CrdTrn').AsFloat;
end;

procedure TAccanlDat.SetCrdTrn(pValue:double);
begin
  oTable.FieldByName('CrdTrn').AsFloat:=pValue;
end;

function TAccanlDat.GetDebTrn:double;
begin
  Result:=oTable.FieldByName('DebTrn').AsFloat;
end;

procedure TAccanlDat.SetDebTrn(pValue:double);
begin
  oTable.FieldByName('DebTrn').AsFloat:=pValue;
end;

function TAccanlDat.GetCrdEnd:double;
begin
  Result:=oTable.FieldByName('CrdEnd').AsFloat;
end;

procedure TAccanlDat.SetCrdEnd(pValue:double);
begin
  oTable.FieldByName('CrdEnd').AsFloat:=pValue;
end;

function TAccanlDat.GetDebEnd:double;
begin
  Result:=oTable.FieldByName('DebEnd').AsFloat;
end;

procedure TAccanlDat.SetDebEnd(pValue:double);
begin
  oTable.FieldByName('DebEnd').AsFloat:=pValue;
end;

function TAccanlDat.GetDifVal:double;
begin
  Result:=oTable.FieldByName('DifVal').AsFloat;
end;

procedure TAccanlDat.SetDifVal(pValue:double);
begin
  oTable.FieldByName('DifVal').AsFloat:=pValue;
end;

function TAccanlDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TAccanlDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAccanlDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAccanlDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAccanlDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAccanlDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TAccanlDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TAccanlDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TAccanlDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TAccanlDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TAccanlDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TAccanlDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TAccanlDat.GetTaxNot:byte;
begin
  Result:=oTable.FieldByName('TaxNot').AsInteger;
end;

procedure TAccanlDat.SetTaxNot(pValue:byte);
begin
  oTable.FieldByName('TaxNot').AsInteger:=pValue;
end;

function TAccanlDat.GetAccTyp:Str1;
begin
  Result:=oTable.FieldByName('AccTyp').AsString;
end;

procedure TAccanlDat.SetAccTyp(pValue:Str1);
begin
  oTable.FieldByName('AccTyp').AsString:=pValue;
end;

function TAccanlDat.GetBalanc:Str1;
begin
  Result:=oTable.FieldByName('Balanc').AsString;
end;

procedure TAccanlDat.SetBalanc(pValue:Str1);
begin
  oTable.FieldByName('Balanc').AsString:=pValue;
end;

function TAccanlDat.GetFjrRow:Str2;
begin
  Result:=oTable.FieldByName('FjrRow').AsString;
end;

procedure TAccanlDat.SetFjrRow(pValue:Str2);
begin
  oTable.FieldByName('FjrRow').AsString:=pValue;
end;

function TAccanlDat.Getx_ResText:Str43;
begin
  Result:=oTable.FieldByName('x_ResText').AsString;
end;

procedure TAccanlDat.Setx_ResText(pValue:Str43);
begin
  oTable.FieldByName('x_ResText').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccanlDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TAccanlDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TAccanlDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TAccanlDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TAccanlDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TAccanlDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TAccanlDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TAccanlDat.LocSnAn(pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex(ixSnAn);
  Result:=oTable.FindKey([pAccSnt,pAccAnl]);
end;

function TAccanlDat.LocAccSnt(pAccSnt:str3):boolean;
begin
  SetIndex(ixAccSnt);
  Result:=oTable.FindKey([pAccSnt]);
end;

function TAccanlDat.LocAnlNam(pAnlNam_:Str30):boolean;
begin
  SetIndex(ixAnlNam);
  Result:=oTable.FindKey([StrToAlias(pAnlNam_)]);
end;

function TAccanlDat.LocCrdTrn(pCrdTrn:double):boolean;
begin
  SetIndex(ixCrdTrn);
  Result:=oTable.FindKey([pCrdTrn]);
end;

function TAccanlDat.LocDebTrn(pDebTrn:double):boolean;
begin
  SetIndex(ixDebTrn);
  Result:=oTable.FindKey([pDebTrn]);
end;

function TAccanlDat.LocDifVal(pDifVal:double):boolean;
begin
  SetIndex(ixDifVal);
  Result:=oTable.FindKey([pDifVal]);
end;

function TAccanlDat.NearSnAn(pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex(ixSnAn);
  Result:=oTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TAccanlDat.NearAccSnt(pAccSnt:str3):boolean;
begin
  SetIndex(ixAccSnt);
  Result:=oTable.FindNearest([pAccSnt]);
end;

function TAccanlDat.NearAnlNam(pAnlNam_:Str30):boolean;
begin
  SetIndex(ixAnlNam);
  Result:=oTable.FindNearest([pAnlNam_]);
end;

function TAccanlDat.NearCrdTrn(pCrdTrn:double):boolean;
begin
  SetIndex(ixCrdTrn);
  Result:=oTable.FindNearest([pCrdTrn]);
end;

function TAccanlDat.NearDebTrn(pDebTrn:double):boolean;
begin
  SetIndex(ixDebTrn);
  Result:=oTable.FindNearest([pDebTrn]);
end;

function TAccanlDat.NearDifVal(pDifVal:double):boolean;
begin
  SetIndex(ixDifVal);
  Result:=oTable.FindNearest([pDifVal]);
end;

procedure TAccanlDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TAccanlDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TAccanlDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TAccanlDat.Prior;
begin
  oTable.Prior;
end;

procedure TAccanlDat.Next;
begin
  oTable.Next;
end;

procedure TAccanlDat.First;
begin
  Open;
  oTable.First;
end;

procedure TAccanlDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TAccanlDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TAccanlDat.Edit;
begin
  oTable.Edit;
end;

procedure TAccanlDat.Post;
begin
  oTable.Post;
end;

procedure TAccanlDat.Delete;
begin
  oTable.Delete;
end;

procedure TAccanlDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TAccanlDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TAccanlDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TAccanlDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TAccanlDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TAccanlDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
