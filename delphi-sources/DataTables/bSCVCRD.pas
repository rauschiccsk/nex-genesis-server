unit bSCVCRD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEquNum = 'EquNum';
  ixEquDes = 'EquDes';
  ixCrnNum = 'CrnNum';
  ixMotNum = 'MotNum';
  ixParCod = 'ParCod';
  ixParNam = 'ParNam';
  ixDocQnt = 'DocQnt';
  ixOpdQnt = 'OpdQnt';

type
  TScvcrdBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEquNum:Str20;          procedure WriteEquNum (pValue:Str20);
    function  ReadEquDes:Str100;         procedure WriteEquDes (pValue:Str100);
    function  ReadEquDes_:Str100;        procedure WriteEquDes_ (pValue:Str100);
    function  ReadMotNum:Str20;          procedure WriteMotNum (pValue:Str20);
    function  ReadCrnNum:Str10;          procedure WriteCrnNum (pValue:Str10);
    function  ReadParTyp:Str1;           procedure WriteParTyp (pValue:Str1);
    function  ReadParCod:longint;        procedure WriteParCod (pValue:longint);
    function  ReadParNam:Str100;         procedure WriteParNam (pValue:Str100);
    function  ReadParNam_:Str100;        procedure WriteParNam_ (pValue:Str100);
    function  ReadParIno:Str15;          procedure WriteParIno (pValue:Str15);
    function  ReadParTin:Str15;          procedure WriteParTin (pValue:Str15);
    function  ReadParVin:Str15;          procedure WriteParVin (pValue:Str15);
    function  ReadRegAdr:Str30;          procedure WriteRegAdr (pValue:Str30);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegStn:Str30;          procedure WriteRegStn (pValue:Str30);
    function  ReadCntNam:Str30;          procedure WriteCntNam (pValue:Str30);
    function  ReadCntTel:Str20;          procedure WriteCntTel (pValue:Str20);
    function  ReadCntMob:Str20;          procedure WriteCntMob (pValue:Str20);
    function  ReadCntEml:Str30;          procedure WriteCntEml (pValue:Str30);
    function  ReadCarClr:Str30;          procedure WriteCarClr (pValue:Str30);
    function  ReadCarCln:Str30;          procedure WriteCarCln (pValue:Str30);
    function  ReadCarReg:TDatetime;      procedure WriteCarReg (pValue:TDatetime);
    function  ReadCarTac:longint;        procedure WriteCarTac (pValue:longint);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDocQnt:word;           procedure WriteDocQnt (pValue:word);
    function  ReadCrtUsr:Str8;           procedure WriteCrtUsr (pValue:Str8);
    function  ReadCrtDat:TDatetime;      procedure WriteCrtDat (pValue:TDatetime);
    function  ReadCrtTim:TDatetime;      procedure WriteCrtTim (pValue:TDatetime);
    function  ReadOpdQnt:word;           procedure WriteOpdQnt (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEquNum (pEquNum:Str20):boolean;
    function LocateEquDes (pEquDes_:Str100):boolean;
    function LocateCrnNum (pCrnNum:Str10):boolean;
    function LocateMotNum (pMotNum:Str20):boolean;
    function LocateParCod (pParCod:longint):boolean;
    function LocateParNam (pParNam_:Str100):boolean;
    function LocateDocQnt (pDocQnt:word):boolean;
    function LocateOpdQnt (pOpdQnt:word):boolean;
    function NearestEquNum (pEquNum:Str20):boolean;
    function NearestEquDes (pEquDes_:Str100):boolean;
    function NearestCrnNum (pCrnNum:Str10):boolean;
    function NearestMotNum (pMotNum:Str20):boolean;
    function NearestParCod (pParCod:longint):boolean;
    function NearestParNam (pParNam_:Str100):boolean;
    function NearestDocQnt (pDocQnt:word):boolean;
    function NearestOpdQnt (pOpdQnt:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property EquNum:Str20 read ReadEquNum write WriteEquNum;
    property EquDes:Str100 read ReadEquDes write WriteEquDes;
    property EquDes_:Str100 read ReadEquDes_ write WriteEquDes_;
    property MotNum:Str20 read ReadMotNum write WriteMotNum;
    property CrnNum:Str10 read ReadCrnNum write WriteCrnNum;
    property ParTyp:Str1 read ReadParTyp write WriteParTyp;
    property ParCod:longint read ReadParCod write WriteParCod;
    property ParNam:Str100 read ReadParNam write WriteParNam;
    property ParNam_:Str100 read ReadParNam_ write WriteParNam_;
    property ParIno:Str15 read ReadParIno write WriteParIno;
    property ParTin:Str15 read ReadParTin write WriteParTin;
    property ParVin:Str15 read ReadParVin write WriteParVin;
    property RegAdr:Str30 read ReadRegAdr write WriteRegAdr;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegStn:Str30 read ReadRegStn write WriteRegStn;
    property CntNam:Str30 read ReadCntNam write WriteCntNam;
    property CntTel:Str20 read ReadCntTel write WriteCntTel;
    property CntMob:Str20 read ReadCntMob write WriteCntMob;
    property CntEml:Str30 read ReadCntEml write WriteCntEml;
    property CarClr:Str30 read ReadCarClr write WriteCarClr;
    property CarCln:Str30 read ReadCarCln write WriteCarCln;
    property CarReg:TDatetime read ReadCarReg write WriteCarReg;
    property CarTac:longint read ReadCarTac write WriteCarTac;
    property CValue:double read ReadCValue write WriteCValue;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DocQnt:word read ReadDocQnt write WriteDocQnt;
    property CrtUsr:Str8 read ReadCrtUsr write WriteCrtUsr;
    property CrtDat:TDatetime read ReadCrtDat write WriteCrtDat;
    property CrtTim:TDatetime read ReadCrtTim write WriteCrtTim;
    property OpdQnt:word read ReadOpdQnt write WriteOpdQnt;
  end;

implementation

constructor TScvcrdBtr.Create;
begin
  oBtrTable := BtrInit ('SCVCRD',gPath.StkPath,Self);
end;

constructor TScvcrdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCVCRD',pPath,Self);
end;

destructor TScvcrdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TScvcrdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TScvcrdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TScvcrdBtr.ReadEquNum:Str20;
begin
  Result := oBtrTable.FieldByName('EquNum').AsString;
end;

procedure TScvcrdBtr.WriteEquNum(pValue:Str20);
begin
  oBtrTable.FieldByName('EquNum').AsString := pValue;
end;

function TScvcrdBtr.ReadEquDes:Str100;
begin
  Result := oBtrTable.FieldByName('EquDes').AsString;
end;

procedure TScvcrdBtr.WriteEquDes(pValue:Str100);
begin
  oBtrTable.FieldByName('EquDes').AsString := pValue;
end;

function TScvcrdBtr.ReadEquDes_:Str100;
begin
  Result := oBtrTable.FieldByName('EquDes_').AsString;
end;

procedure TScvcrdBtr.WriteEquDes_(pValue:Str100);
begin
  oBtrTable.FieldByName('EquDes_').AsString := pValue;
end;

function TScvcrdBtr.ReadMotNum:Str20;
begin
  Result := oBtrTable.FieldByName('MotNum').AsString;
end;

procedure TScvcrdBtr.WriteMotNum(pValue:Str20);
begin
  oBtrTable.FieldByName('MotNum').AsString := pValue;
end;

function TScvcrdBtr.ReadCrnNum:Str10;
begin
  Result := oBtrTable.FieldByName('CrnNum').AsString;
end;

procedure TScvcrdBtr.WriteCrnNum(pValue:Str10);
begin
  oBtrTable.FieldByName('CrnNum').AsString := pValue;
end;

function TScvcrdBtr.ReadParTyp:Str1;
begin
  Result := oBtrTable.FieldByName('ParTyp').AsString;
end;

procedure TScvcrdBtr.WriteParTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('ParTyp').AsString := pValue;
end;

function TScvcrdBtr.ReadParCod:longint;
begin
  Result := oBtrTable.FieldByName('ParCod').AsInteger;
end;

procedure TScvcrdBtr.WriteParCod(pValue:longint);
begin
  oBtrTable.FieldByName('ParCod').AsInteger := pValue;
end;

function TScvcrdBtr.ReadParNam:Str100;
begin
  Result := oBtrTable.FieldByName('ParNam').AsString;
end;

procedure TScvcrdBtr.WriteParNam(pValue:Str100);
begin
  oBtrTable.FieldByName('ParNam').AsString := pValue;
end;

function TScvcrdBtr.ReadParNam_:Str100;
begin
  Result := oBtrTable.FieldByName('ParNam_').AsString;
end;

procedure TScvcrdBtr.WriteParNam_(pValue:Str100);
begin
  oBtrTable.FieldByName('ParNam_').AsString := pValue;
end;

function TScvcrdBtr.ReadParIno:Str15;
begin
  Result := oBtrTable.FieldByName('ParIno').AsString;
end;

procedure TScvcrdBtr.WriteParIno(pValue:Str15);
begin
  oBtrTable.FieldByName('ParIno').AsString := pValue;
end;

function TScvcrdBtr.ReadParTin:Str15;
begin
  Result := oBtrTable.FieldByName('ParTin').AsString;
end;

procedure TScvcrdBtr.WriteParTin(pValue:Str15);
begin
  oBtrTable.FieldByName('ParTin').AsString := pValue;
end;

function TScvcrdBtr.ReadParVin:Str15;
begin
  Result := oBtrTable.FieldByName('ParVin').AsString;
end;

procedure TScvcrdBtr.WriteParVin(pValue:Str15);
begin
  oBtrTable.FieldByName('ParVin').AsString := pValue;
end;

function TScvcrdBtr.ReadRegAdr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAdr').AsString;
end;

procedure TScvcrdBtr.WriteRegAdr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAdr').AsString := pValue;
end;

function TScvcrdBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TScvcrdBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TScvcrdBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TScvcrdBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TScvcrdBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TScvcrdBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TScvcrdBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TScvcrdBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TScvcrdBtr.ReadRegStn:Str30;
begin
  Result := oBtrTable.FieldByName('RegStn').AsString;
end;

procedure TScvcrdBtr.WriteRegStn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegStn').AsString := pValue;
end;

function TScvcrdBtr.ReadCntNam:Str30;
begin
  Result := oBtrTable.FieldByName('CntNam').AsString;
end;

procedure TScvcrdBtr.WriteCntNam(pValue:Str30);
begin
  oBtrTable.FieldByName('CntNam').AsString := pValue;
end;

function TScvcrdBtr.ReadCntTel:Str20;
begin
  Result := oBtrTable.FieldByName('CntTel').AsString;
end;

procedure TScvcrdBtr.WriteCntTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CntTel').AsString := pValue;
end;

function TScvcrdBtr.ReadCntMob:Str20;
begin
  Result := oBtrTable.FieldByName('CntMob').AsString;
end;

procedure TScvcrdBtr.WriteCntMob(pValue:Str20);
begin
  oBtrTable.FieldByName('CntMob').AsString := pValue;
end;

function TScvcrdBtr.ReadCntEml:Str30;
begin
  Result := oBtrTable.FieldByName('CntEml').AsString;
end;

procedure TScvcrdBtr.WriteCntEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CntEml').AsString := pValue;
end;

function TScvcrdBtr.ReadCarClr:Str30;
begin
  Result := oBtrTable.FieldByName('CarClr').AsString;
end;

procedure TScvcrdBtr.WriteCarClr(pValue:Str30);
begin
  oBtrTable.FieldByName('CarClr').AsString := pValue;
end;

function TScvcrdBtr.ReadCarCln:Str30;
begin
  Result := oBtrTable.FieldByName('CarCln').AsString;
end;

procedure TScvcrdBtr.WriteCarCln(pValue:Str30);
begin
  oBtrTable.FieldByName('CarCln').AsString := pValue;
end;

function TScvcrdBtr.ReadCarReg:TDatetime;
begin
  Result := oBtrTable.FieldByName('CarReg').AsDateTime;
end;

procedure TScvcrdBtr.WriteCarReg(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CarReg').AsDateTime := pValue;
end;

function TScvcrdBtr.ReadCarTac:longint;
begin
  Result := oBtrTable.FieldByName('CarTac').AsInteger;
end;

procedure TScvcrdBtr.WriteCarTac(pValue:longint);
begin
  oBtrTable.FieldByName('CarTac').AsInteger := pValue;
end;

function TScvcrdBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TScvcrdBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TScvcrdBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TScvcrdBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TScvcrdBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TScvcrdBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TScvcrdBtr.ReadDocQnt:word;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsInteger;
end;

procedure TScvcrdBtr.WriteDocQnt(pValue:word);
begin
  oBtrTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TScvcrdBtr.ReadCrtUsr:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUsr').AsString;
end;

procedure TScvcrdBtr.WriteCrtUsr(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUsr').AsString := pValue;
end;

function TScvcrdBtr.ReadCrtDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDat').AsDateTime;
end;

procedure TScvcrdBtr.WriteCrtDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDat').AsDateTime := pValue;
end;

function TScvcrdBtr.ReadCrtTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TScvcrdBtr.WriteCrtTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTim').AsDateTime := pValue;
end;

function TScvcrdBtr.ReadOpdQnt:word;
begin
  Result := oBtrTable.FieldByName('OpdQnt').AsInteger;
end;

procedure TScvcrdBtr.WriteOpdQnt(pValue:word);
begin
  oBtrTable.FieldByName('OpdQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScvcrdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvcrdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TScvcrdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvcrdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TScvcrdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TScvcrdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TScvcrdBtr.LocateEquNum (pEquNum:Str20):boolean;
begin
  SetIndex (ixEquNum);
  Result := oBtrTable.FindKey([pEquNum]);
end;

function TScvcrdBtr.LocateEquDes (pEquDes_:Str100):boolean;
begin
  SetIndex (ixEquDes);
  Result := oBtrTable.FindKey([StrToAlias(pEquDes_)]);
end;

function TScvcrdBtr.LocateCrnNum (pCrnNum:Str10):boolean;
begin
  SetIndex (ixCrnNum);
  Result := oBtrTable.FindKey([pCrnNum]);
end;

function TScvcrdBtr.LocateMotNum (pMotNum:Str20):boolean;
begin
  SetIndex (ixMotNum);
  Result := oBtrTable.FindKey([pMotNum]);
end;

function TScvcrdBtr.LocateParCod (pParCod:longint):boolean;
begin
  SetIndex (ixParCod);
  Result := oBtrTable.FindKey([pParCod]);
end;

function TScvcrdBtr.LocateParNam (pParNam_:Str100):boolean;
begin
  SetIndex (ixParNam);
  Result := oBtrTable.FindKey([StrToAlias(pParNam_)]);
end;

function TScvcrdBtr.LocateDocQnt (pDocQnt:word):boolean;
begin
  SetIndex (ixDocQnt);
  Result := oBtrTable.FindKey([pDocQnt]);
end;

function TScvcrdBtr.LocateOpdQnt (pOpdQnt:word):boolean;
begin
  SetIndex (ixOpdQnt);
  Result := oBtrTable.FindKey([pOpdQnt]);
end;

function TScvcrdBtr.NearestEquNum (pEquNum:Str20):boolean;
begin
  SetIndex (ixEquNum);
  Result := oBtrTable.FindNearest([pEquNum]);
end;

function TScvcrdBtr.NearestEquDes (pEquDes_:Str100):boolean;
begin
  SetIndex (ixEquDes);
  Result := oBtrTable.FindNearest([pEquDes_]);
end;

function TScvcrdBtr.NearestCrnNum (pCrnNum:Str10):boolean;
begin
  SetIndex (ixCrnNum);
  Result := oBtrTable.FindNearest([pCrnNum]);
end;

function TScvcrdBtr.NearestMotNum (pMotNum:Str20):boolean;
begin
  SetIndex (ixMotNum);
  Result := oBtrTable.FindNearest([pMotNum]);
end;

function TScvcrdBtr.NearestParCod (pParCod:longint):boolean;
begin
  SetIndex (ixParCod);
  Result := oBtrTable.FindNearest([pParCod]);
end;

function TScvcrdBtr.NearestParNam (pParNam_:Str100):boolean;
begin
  SetIndex (ixParNam);
  Result := oBtrTable.FindNearest([pParNam_]);
end;

function TScvcrdBtr.NearestDocQnt (pDocQnt:word):boolean;
begin
  SetIndex (ixDocQnt);
  Result := oBtrTable.FindNearest([pDocQnt]);
end;

function TScvcrdBtr.NearestOpdQnt (pOpdQnt:word):boolean;
begin
  SetIndex (ixOpdQnt);
  Result := oBtrTable.FindNearest([pOpdQnt]);
end;

procedure TScvcrdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TScvcrdBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TScvcrdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TScvcrdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TScvcrdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TScvcrdBtr.First;
begin
  oBtrTable.First;
end;

procedure TScvcrdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TScvcrdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TScvcrdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TScvcrdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TScvcrdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TScvcrdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TScvcrdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TScvcrdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TScvcrdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TScvcrdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TScvcrdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
