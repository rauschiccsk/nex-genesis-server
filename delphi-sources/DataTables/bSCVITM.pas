unit bSCVITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGscCod = 'GscCod';
  ixParCod = 'ParCod';
  ixStkSta = 'StkSta';
  ixFinSta = 'FinSta';

type
  TScvitmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgcCod:word;           procedure WriteMgcCod (pValue:word);
    function  ReadGscCod:longint;        procedure WriteGscCod (pValue:longint);
    function  ReadGscNam:Str30;          procedure WriteGscNam (pValue:Str30);
    function  ReadBarCod:Str15;          procedure WriteBarCod (pValue:Str15);
    function  ReadStkCod:Str15;          procedure WriteStkCod (pValue:Str15);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadCsType:Str1;           procedure WriteCsType (pValue:Str1);
    function  ReadItmNot:Str100;         procedure WriteItmNot (pValue:Str100);
    function  ReadItmTyp:Str1;           procedure WriteItmTyp (pValue:Str1);
    function  ReadMsuNam:Str10;          procedure WriteMsuNam (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadSrvTyp:Str1;           procedure WriteSrvTyp (pValue:Str1);
    function  ReadDlrCod:word;           procedure WriteDlrCod (pValue:word);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadParCod:longint;        procedure WriteParCod (pValue:longint);
    function  ReadGrtTyp:Str1;           procedure WriteGrtTyp (pValue:Str1);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadStkSta:Str1;           procedure WriteStkSta (pValue:Str1);
    function  ReadFinSta:Str1;           procedure WriteFinSta (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGscCod (pGscCod:longint):boolean;
    function LocateParCod (pParCod:longint):boolean;
    function LocateStkSta (pStkSta:Str1):boolean;
    function LocateFinSta (pFinSta:Str1):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGscCod (pGscCod:longint):boolean;
    function NearestParCod (pParCod:longint):boolean;
    function NearestStkSta (pStkSta:Str1):boolean;
    function NearestFinSta (pFinSta:Str1):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgcCod:word read ReadMgcCod write WriteMgcCod;
    property GscCod:longint read ReadGscCod write WriteGscCod;
    property GscNam:Str30 read ReadGscNam write WriteGscNam;
    property BarCod:Str15 read ReadBarCod write WriteBarCod;
    property StkCod:Str15 read ReadStkCod write WriteStkCod;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property CsType:Str1 read ReadCsType write WriteCsType;
    property ItmNot:Str100 read ReadItmNot write WriteItmNot;
    property ItmTyp:Str1 read ReadItmTyp write WriteItmTyp;
    property MsuNam:Str10 read ReadMsuNam write WriteMsuNam;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property CValue:double read ReadCValue write WriteCValue;
    property DValue:double read ReadDValue write WriteDValue;
    property HValue:double read ReadHValue write WriteHValue;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property SrvTyp:Str1 read ReadSrvTyp write WriteSrvTyp;
    property DlrCod:word read ReadDlrCod write WriteDlrCod;
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property ParCod:longint read ReadParCod write WriteParCod;
    property GrtTyp:Str1 read ReadGrtTyp write WriteGrtTyp;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property StkSta:Str1 read ReadStkSta write WriteStkSta;
    property FinSta:Str1 read ReadFinSta write WriteFinSta;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TScvitmBtr.Create;
begin
  oBtrTable := BtrInit ('SCVITM',gPath.StkPath,Self);
end;

constructor TScvitmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCVITM',pPath,Self);
end;

destructor TScvitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TScvitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TScvitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TScvitmBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TScvitmBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TScvitmBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TScvitmBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TScvitmBtr.ReadMgcCod:word;
begin
  Result := oBtrTable.FieldByName('MgcCod').AsInteger;
end;

procedure TScvitmBtr.WriteMgcCod(pValue:word);
begin
  oBtrTable.FieldByName('MgcCod').AsInteger := pValue;
end;

function TScvitmBtr.ReadGscCod:longint;
begin
  Result := oBtrTable.FieldByName('GscCod').AsInteger;
end;

procedure TScvitmBtr.WriteGscCod(pValue:longint);
begin
  oBtrTable.FieldByName('GscCod').AsInteger := pValue;
end;

function TScvitmBtr.ReadGscNam:Str30;
begin
  Result := oBtrTable.FieldByName('GscNam').AsString;
end;

procedure TScvitmBtr.WriteGscNam(pValue:Str30);
begin
  oBtrTable.FieldByName('GscNam').AsString := pValue;
end;

function TScvitmBtr.ReadBarCod:Str15;
begin
  Result := oBtrTable.FieldByName('BarCod').AsString;
end;

procedure TScvitmBtr.WriteBarCod(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCod').AsString := pValue;
end;

function TScvitmBtr.ReadStkCod:Str15;
begin
  Result := oBtrTable.FieldByName('StkCod').AsString;
end;

procedure TScvitmBtr.WriteStkCod(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCod').AsString := pValue;
end;

function TScvitmBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TScvitmBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TScvitmBtr.ReadCsType:Str1;
begin
  Result := oBtrTable.FieldByName('CsType').AsString;
end;

procedure TScvitmBtr.WriteCsType(pValue:Str1);
begin
  oBtrTable.FieldByName('CsType').AsString := pValue;
end;

function TScvitmBtr.ReadItmNot:Str100;
begin
  Result := oBtrTable.FieldByName('ItmNot').AsString;
end;

procedure TScvitmBtr.WriteItmNot(pValue:Str100);
begin
  oBtrTable.FieldByName('ItmNot').AsString := pValue;
end;

function TScvitmBtr.ReadItmTyp:Str1;
begin
  Result := oBtrTable.FieldByName('ItmTyp').AsString;
end;

procedure TScvitmBtr.WriteItmTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmTyp').AsString := pValue;
end;

function TScvitmBtr.ReadMsuNam:Str10;
begin
  Result := oBtrTable.FieldByName('MsuNam').AsString;
end;

procedure TScvitmBtr.WriteMsuNam(pValue:Str10);
begin
  oBtrTable.FieldByName('MsuNam').AsString := pValue;
end;

function TScvitmBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TScvitmBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TScvitmBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TScvitmBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TScvitmBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TScvitmBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TScvitmBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TScvitmBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TScvitmBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TScvitmBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TScvitmBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TScvitmBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TScvitmBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TScvitmBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TScvitmBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TScvitmBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TScvitmBtr.ReadSrvTyp:Str1;
begin
  Result := oBtrTable.FieldByName('SrvTyp').AsString;
end;

procedure TScvitmBtr.WriteSrvTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('SrvTyp').AsString := pValue;
end;

function TScvitmBtr.ReadDlrCod:word;
begin
  Result := oBtrTable.FieldByName('DlrCod').AsInteger;
end;

procedure TScvitmBtr.WriteDlrCod(pValue:word);
begin
  oBtrTable.FieldByName('DlrCod').AsInteger := pValue;
end;

function TScvitmBtr.ReadDocDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDat').AsDateTime;
end;

procedure TScvitmBtr.WriteDocDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TScvitmBtr.ReadParCod:longint;
begin
  Result := oBtrTable.FieldByName('ParCod').AsInteger;
end;

procedure TScvitmBtr.WriteParCod(pValue:longint);
begin
  oBtrTable.FieldByName('ParCod').AsInteger := pValue;
end;

function TScvitmBtr.ReadGrtTyp:Str1;
begin
  Result := oBtrTable.FieldByName('GrtTyp').AsString;
end;

procedure TScvitmBtr.WriteGrtTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('GrtTyp').AsString := pValue;
end;

function TScvitmBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TScvitmBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TScvitmBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TScvitmBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TScvitmBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TScvitmBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TScvitmBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TScvitmBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TScvitmBtr.ReadStkSta:Str1;
begin
  Result := oBtrTable.FieldByName('StkSta').AsString;
end;

procedure TScvitmBtr.WriteStkSta(pValue:Str1);
begin
  oBtrTable.FieldByName('StkSta').AsString := pValue;
end;

function TScvitmBtr.ReadFinSta:Str1;
begin
  Result := oBtrTable.FieldByName('FinSta').AsString;
end;

procedure TScvitmBtr.WriteFinSta(pValue:Str1);
begin
  oBtrTable.FieldByName('FinSta').AsString := pValue;
end;

function TScvitmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TScvitmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TScvitmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TScvitmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TScvitmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TScvitmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TScvitmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TScvitmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TScvitmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TScvitmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TScvitmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TScvitmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScvitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvitmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TScvitmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TScvitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TScvitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TScvitmBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TScvitmBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TScvitmBtr.LocateGscCod (pGscCod:longint):boolean;
begin
  SetIndex (ixGscCod);
  Result := oBtrTable.FindKey([pGscCod]);
end;

function TScvitmBtr.LocateParCod (pParCod:longint):boolean;
begin
  SetIndex (ixParCod);
  Result := oBtrTable.FindKey([pParCod]);
end;

function TScvitmBtr.LocateStkSta (pStkSta:Str1):boolean;
begin
  SetIndex (ixStkSta);
  Result := oBtrTable.FindKey([pStkSta]);
end;

function TScvitmBtr.LocateFinSta (pFinSta:Str1):boolean;
begin
  SetIndex (ixFinSta);
  Result := oBtrTable.FindKey([pFinSta]);
end;

function TScvitmBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TScvitmBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TScvitmBtr.NearestGscCod (pGscCod:longint):boolean;
begin
  SetIndex (ixGscCod);
  Result := oBtrTable.FindNearest([pGscCod]);
end;

function TScvitmBtr.NearestParCod (pParCod:longint):boolean;
begin
  SetIndex (ixParCod);
  Result := oBtrTable.FindNearest([pParCod]);
end;

function TScvitmBtr.NearestStkSta (pStkSta:Str1):boolean;
begin
  SetIndex (ixStkSta);
  Result := oBtrTable.FindNearest([pStkSta]);
end;

function TScvitmBtr.NearestFinSta (pFinSta:Str1):boolean;
begin
  SetIndex (ixFinSta);
  Result := oBtrTable.FindNearest([pFinSta]);
end;

procedure TScvitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TScvitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TScvitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TScvitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TScvitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TScvitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TScvitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TScvitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TScvitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TScvitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TScvitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TScvitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TScvitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TScvitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TScvitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TScvitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TScvitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1916001}
