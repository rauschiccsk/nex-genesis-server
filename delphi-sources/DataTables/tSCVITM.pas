unit tSCVITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixGscCod = 'GscCod';
  ixGscNam_ = 'GscNam_';
  ixStkSta = 'StkSta';
  ixFinSta = 'FinSta';

type
  TScvitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgcCod:word;           procedure WriteMgcCod (pValue:word);
    function  ReadGscCod:longint;        procedure WriteGscCod (pValue:longint);
    function  ReadGscNam:Str60;          procedure WriteGscNam (pValue:Str60);
    function  ReadGscNam_:Str60;         procedure WriteGscNam_ (pValue:Str60);
    function  ReadBarCod:Str15;          procedure WriteBarCod (pValue:Str15);
    function  ReadStkCod:Str15;          procedure WriteStkCod (pValue:Str15);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadCsType:Str1;           procedure WriteCsType (pValue:Str1);
    function  ReadItmNot:Str100;         procedure WriteItmNot (pValue:Str100);
    function  ReadItType:Str1;           procedure WriteItType (pValue:Str1);
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGscCod (pGscCod:longint):boolean;
    function LocateGscNam_ (pGscNam_:Str60):boolean;
    function LocateStkSta (pStkSta:Str1):boolean;
    function LocateFinSta (pFinSta:Str1):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgcCod:word read ReadMgcCod write WriteMgcCod;
    property GscCod:longint read ReadGscCod write WriteGscCod;
    property GscNam:Str60 read ReadGscNam write WriteGscNam;
    property GscNam_:Str60 read ReadGscNam_ write WriteGscNam_;
    property BarCod:Str15 read ReadBarCod write WriteBarCod;
    property StkCod:Str15 read ReadStkCod write WriteStkCod;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property CsType:Str1 read ReadCsType write WriteCsType;
    property ItmNot:Str100 read ReadItmNot write WriteItmNot;
    property ItType:Str1 read ReadItType write WriteItType;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TScvitmTmp.Create;
begin
  oTmpTable := TmpInit ('SCVITM',Self);
end;

destructor TScvitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TScvitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TScvitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TScvitmTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TScvitmTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TScvitmTmp.ReadMgcCod:word;
begin
  Result := oTmpTable.FieldByName('MgcCod').AsInteger;
end;

procedure TScvitmTmp.WriteMgcCod(pValue:word);
begin
  oTmpTable.FieldByName('MgcCod').AsInteger := pValue;
end;

function TScvitmTmp.ReadGscCod:longint;
begin
  Result := oTmpTable.FieldByName('GscCod').AsInteger;
end;

procedure TScvitmTmp.WriteGscCod(pValue:longint);
begin
  oTmpTable.FieldByName('GscCod').AsInteger := pValue;
end;

function TScvitmTmp.ReadGscNam:Str60;
begin
  Result := oTmpTable.FieldByName('GscNam').AsString;
end;

procedure TScvitmTmp.WriteGscNam(pValue:Str60);
begin
  oTmpTable.FieldByName('GscNam').AsString := pValue;
end;

function TScvitmTmp.ReadGscNam_:Str60;
begin
  Result := oTmpTable.FieldByName('GscNam_').AsString;
end;

procedure TScvitmTmp.WriteGscNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('GscNam_').AsString := pValue;
end;

function TScvitmTmp.ReadBarCod:Str15;
begin
  Result := oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TScvitmTmp.WriteBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString := pValue;
end;

function TScvitmTmp.ReadStkCod:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TScvitmTmp.WriteStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString := pValue;
end;

function TScvitmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TScvitmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TScvitmTmp.ReadCsType:Str1;
begin
  Result := oTmpTable.FieldByName('CsType').AsString;
end;

procedure TScvitmTmp.WriteCsType(pValue:Str1);
begin
  oTmpTable.FieldByName('CsType').AsString := pValue;
end;

function TScvitmTmp.ReadItmNot:Str100;
begin
  Result := oTmpTable.FieldByName('ItmNot').AsString;
end;

procedure TScvitmTmp.WriteItmNot(pValue:Str100);
begin
  oTmpTable.FieldByName('ItmNot').AsString := pValue;
end;

function TScvitmTmp.ReadItType:Str1;
begin
  Result := oTmpTable.FieldByName('ItType').AsString;
end;

procedure TScvitmTmp.WriteItType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItType').AsString := pValue;
end;

function TScvitmTmp.ReadMsuNam:Str10;
begin
  Result := oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TScvitmTmp.WriteMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString := pValue;
end;

function TScvitmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TScvitmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TScvitmTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TScvitmTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TScvitmTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TScvitmTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TScvitmTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TScvitmTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TScvitmTmp.ReadDValue:double;
begin
  Result := oTmpTable.FieldByName('DValue').AsFloat;
end;

procedure TScvitmTmp.WriteDValue(pValue:double);
begin
  oTmpTable.FieldByName('DValue').AsFloat := pValue;
end;

function TScvitmTmp.ReadHValue:double;
begin
  Result := oTmpTable.FieldByName('HValue').AsFloat;
end;

procedure TScvitmTmp.WriteHValue(pValue:double);
begin
  oTmpTable.FieldByName('HValue').AsFloat := pValue;
end;

function TScvitmTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TScvitmTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TScvitmTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TScvitmTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TScvitmTmp.ReadSrvTyp:Str1;
begin
  Result := oTmpTable.FieldByName('SrvTyp').AsString;
end;

procedure TScvitmTmp.WriteSrvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('SrvTyp').AsString := pValue;
end;

function TScvitmTmp.ReadDlrCod:word;
begin
  Result := oTmpTable.FieldByName('DlrCod').AsInteger;
end;

procedure TScvitmTmp.WriteDlrCod(pValue:word);
begin
  oTmpTable.FieldByName('DlrCod').AsInteger := pValue;
end;

function TScvitmTmp.ReadDocDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDat').AsDateTime;
end;

procedure TScvitmTmp.WriteDocDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TScvitmTmp.ReadParCod:longint;
begin
  Result := oTmpTable.FieldByName('ParCod').AsInteger;
end;

procedure TScvitmTmp.WriteParCod(pValue:longint);
begin
  oTmpTable.FieldByName('ParCod').AsInteger := pValue;
end;

function TScvitmTmp.ReadGrtTyp:Str1;
begin
  Result := oTmpTable.FieldByName('GrtTyp').AsString;
end;

procedure TScvitmTmp.WriteGrtTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('GrtTyp').AsString := pValue;
end;

function TScvitmTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TScvitmTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TScvitmTmp.ReadTcdItm:word;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TScvitmTmp.WriteTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TScvitmTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TScvitmTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TScvitmTmp.ReadIcdItm:word;
begin
  Result := oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TScvitmTmp.WriteIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TScvitmTmp.ReadStkSta:Str1;
begin
  Result := oTmpTable.FieldByName('StkSta').AsString;
end;

procedure TScvitmTmp.WriteStkSta(pValue:Str1);
begin
  oTmpTable.FieldByName('StkSta').AsString := pValue;
end;

function TScvitmTmp.ReadFinSta:Str1;
begin
  Result := oTmpTable.FieldByName('FinSta').AsString;
end;

procedure TScvitmTmp.WriteFinSta(pValue:Str1);
begin
  oTmpTable.FieldByName('FinSta').AsString := pValue;
end;

function TScvitmTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TScvitmTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TScvitmTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TScvitmTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TScvitmTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TScvitmTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TScvitmTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TScvitmTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TScvitmTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TScvitmTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TScvitmTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TScvitmTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TScvitmTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TScvitmTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScvitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TScvitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TScvitmTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TScvitmTmp.LocateGscCod (pGscCod:longint):boolean;
begin
  SetIndex (ixGscCod);
  Result := oTmpTable.FindKey([pGscCod]);
end;

function TScvitmTmp.LocateGscNam_ (pGscNam_:Str60):boolean;
begin
  SetIndex (ixGscNam_);
  Result := oTmpTable.FindKey([pGscNam_]);
end;

function TScvitmTmp.LocateStkSta (pStkSta:Str1):boolean;
begin
  SetIndex (ixStkSta);
  Result := oTmpTable.FindKey([pStkSta]);
end;

function TScvitmTmp.LocateFinSta (pFinSta:Str1):boolean;
begin
  SetIndex (ixFinSta);
  Result := oTmpTable.FindKey([pFinSta]);
end;

procedure TScvitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TScvitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TScvitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TScvitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TScvitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TScvitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TScvitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TScvitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TScvitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TScvitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TScvitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TScvitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TScvitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TScvitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TScvitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TScvitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TScvitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1916001}
