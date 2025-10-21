unit bDIRCNT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCntNum = 'CntNum';
  ixOwnUser = 'OwnUser';
  ixCnName = 'CnName';
  ixCntIdc = 'CntIdc';
  ixWrkTel = 'WrkTel';
  ixWrkEml = 'WrkEml';
  ixPriTel = 'PriTel';
  ixEmpPac = 'EmpPac';
  ixEmpPan = 'EmpPan';
  ixLogName = 'LogName';

type
  TDircntBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadAccost:Str10;          procedure WriteAccost (pValue:Str10);
    function  ReadTitBef:Str10;          procedure WriteTitBef (pValue:Str10);
    function  ReadFiName:Str20;          procedure WriteFiName (pValue:Str20);
    function  ReadLaName:Str20;          procedure WriteLaName (pValue:Str20);
    function  ReadTitAft:Str10;          procedure WriteTitAft (pValue:Str10);
    function  ReadAcName:Str80;          procedure WriteAcName (pValue:Str80);
    function  ReadAcnFrm:Str6;           procedure WriteAcnFrm (pValue:Str6);
    function  ReadPerSex:Str5;           procedure WritePerSex (pValue:Str5);
    function  ReadCnName:Str40;          procedure WriteCnName (pValue:Str40);
    function  ReadCnName_:Str40;         procedure WriteCnName_ (pValue:Str40);
    function  ReadCntIdc:Str10;          procedure WriteCntIdc (pValue:Str10);
    function  ReadOwnNum:word;           procedure WriteOwnNum (pValue:word);
    function  ReadOwnUser:Str8;          procedure WriteOwnUser (pValue:Str8);
    function  ReadOwnName:Str30;         procedure WriteOwnName (pValue:Str30);
    function  ReadExcUser:Str8;          procedure WriteExcUser (pValue:Str8);
    function  ReadCrdLev:byte;           procedure WriteCrdLev (pValue:byte);
    function  ReadPamGrp:word;           procedure WritePamGrp (pValue:word);
    function  ReadPamDes:Str30;          procedure WritePamDes (pValue:Str30);
    function  ReadRelGrp:word;           procedure WriteRelGrp (pValue:word);
    function  ReadRelDes:Str30;          procedure WriteRelDes (pValue:Str30);
    function  ReadWacGrp:word;           procedure WriteWacGrp (pValue:word);
    function  ReadWacDes:Str30;          procedure WriteWacDes (pValue:Str30);
    function  ReadFocGrp:word;           procedure WriteFocGrp (pValue:word);
    function  ReadFocDes:Str30;          procedure WriteFocDes (pValue:Str30);
    function  ReadLocGrp:word;           procedure WriteLocGrp (pValue:word);
    function  ReadLocDes:Str30;          procedure WriteLocDes (pValue:Str30);
    function  ReadWrkFnc:Str30;          procedure WriteWrkFnc (pValue:Str30);
    function  ReadWrkTel:Str20;          procedure WriteWrkTel (pValue:Str20);
    function  ReadWrkEml:Str30;          procedure WriteWrkEml (pValue:Str30);
    function  ReadEmpPac:longint;        procedure WriteEmpPac (pValue:longint);
    function  ReadEmpPan:Str60;          procedure WriteEmpPan (pValue:Str60);
    function  ReadEmpPan_:Str60;         procedure WriteEmpPan_ (pValue:Str60);
    function  ReadWrkLng:Str30;          procedure WriteWrkLng (pValue:Str30);
    function  ReadWrkLev:byte;           procedure WriteWrkLev (pValue:byte);
    function  ReadPriTel:Str20;          procedure WritePriTel (pValue:Str20);
    function  ReadPriEml:Str30;          procedure WritePriEml (pValue:Str30);
    function  ReadPriLev:byte;           procedure WritePriLev (pValue:byte);
    function  ReadPriOth:Str60;          procedure WritePriOth (pValue:Str60);
    function  ReadBirDay:byte;           procedure WriteBirDay (pValue:byte);
    function  ReadBirMth:byte;           procedure WriteBirMth (pValue:byte);
    function  ReadBirYear:word;          procedure WriteBirYear (pValue:word);
    function  ReadDisCrd:byte;           procedure WriteDisCrd (pValue:byte);
    function  ReadNotPub:byte;           procedure WriteNotPub (pValue:byte);
    function  ReadWarMar:Str1;           procedure WriteWarMar (pValue:Str1);
    function  ReadPerRel:Str30;          procedure WritePerRel (pValue:Str30);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCntNum (pCntNum:word):boolean;
    function LocateOwnUser (pOwnUser:Str8):boolean;
    function LocateCnName (pCnName_:Str40):boolean;
    function LocateCntIdc (pCntIdc:Str10):boolean;
    function LocateWrkTel (pWrkTel:Str20):boolean;
    function LocateWrkEml (pWrkEml:Str30):boolean;
    function LocatePriTel (pPriTel:Str20):boolean;
    function LocateEmpPac (pEmpPac:longint):boolean;
    function LocateEmpPan (pEmpPan_:Str60):boolean;
    function LocateLogName (pLogName:Str8):boolean;
    function NearestCntNum (pCntNum:word):boolean;
    function NearestOwnUser (pOwnUser:Str8):boolean;
    function NearestCnName (pCnName_:Str40):boolean;
    function NearestCntIdc (pCntIdc:Str10):boolean;
    function NearestWrkTel (pWrkTel:Str20):boolean;
    function NearestWrkEml (pWrkEml:Str30):boolean;
    function NearestPriTel (pPriTel:Str20):boolean;
    function NearestEmpPac (pEmpPac:longint):boolean;
    function NearestEmpPan (pEmpPan_:Str60):boolean;
    function NearestLogName (pLogName:Str8):boolean;

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
    property CntNum:word read ReadCntNum write WriteCntNum;
    property Accost:Str10 read ReadAccost write WriteAccost;
    property TitBef:Str10 read ReadTitBef write WriteTitBef;
    property FiName:Str20 read ReadFiName write WriteFiName;
    property LaName:Str20 read ReadLaName write WriteLaName;
    property TitAft:Str10 read ReadTitAft write WriteTitAft;
    property AcName:Str80 read ReadAcName write WriteAcName;
    property AcnFrm:Str6 read ReadAcnFrm write WriteAcnFrm;
    property PerSex:Str5 read ReadPerSex write WritePerSex;
    property CnName:Str40 read ReadCnName write WriteCnName;
    property CnName_:Str40 read ReadCnName_ write WriteCnName_;
    property CntIdc:Str10 read ReadCntIdc write WriteCntIdc;
    property OwnNum:word read ReadOwnNum write WriteOwnNum;
    property OwnUser:Str8 read ReadOwnUser write WriteOwnUser;
    property OwnName:Str30 read ReadOwnName write WriteOwnName;
    property ExcUser:Str8 read ReadExcUser write WriteExcUser;
    property CrdLev:byte read ReadCrdLev write WriteCrdLev;
    property PamGrp:word read ReadPamGrp write WritePamGrp;
    property PamDes:Str30 read ReadPamDes write WritePamDes;
    property RelGrp:word read ReadRelGrp write WriteRelGrp;
    property RelDes:Str30 read ReadRelDes write WriteRelDes;
    property WacGrp:word read ReadWacGrp write WriteWacGrp;
    property WacDes:Str30 read ReadWacDes write WriteWacDes;
    property FocGrp:word read ReadFocGrp write WriteFocGrp;
    property FocDes:Str30 read ReadFocDes write WriteFocDes;
    property LocGrp:word read ReadLocGrp write WriteLocGrp;
    property LocDes:Str30 read ReadLocDes write WriteLocDes;
    property WrkFnc:Str30 read ReadWrkFnc write WriteWrkFnc;
    property WrkTel:Str20 read ReadWrkTel write WriteWrkTel;
    property WrkEml:Str30 read ReadWrkEml write WriteWrkEml;
    property EmpPac:longint read ReadEmpPac write WriteEmpPac;
    property EmpPan:Str60 read ReadEmpPan write WriteEmpPan;
    property EmpPan_:Str60 read ReadEmpPan_ write WriteEmpPan_;
    property WrkLng:Str30 read ReadWrkLng write WriteWrkLng;
    property WrkLev:byte read ReadWrkLev write WriteWrkLev;
    property PriTel:Str20 read ReadPriTel write WritePriTel;
    property PriEml:Str30 read ReadPriEml write WritePriEml;
    property PriLev:byte read ReadPriLev write WritePriLev;
    property PriOth:Str60 read ReadPriOth write WritePriOth;
    property BirDay:byte read ReadBirDay write WriteBirDay;
    property BirMth:byte read ReadBirMth write WriteBirMth;
    property BirYear:word read ReadBirYear write WriteBirYear;
    property DisCrd:byte read ReadDisCrd write WriteDisCrd;
    property NotPub:byte read ReadNotPub write WriteNotPub;
    property WarMar:Str1 read ReadWarMar write WriteWarMar;
    property PerRel:Str30 read ReadPerRel write WritePerRel;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
  end;

implementation

constructor TDircntBtr.Create;
begin
  oBtrTable := BtrInit ('DIRCNT',gPath.DlsPath,Self);
end;

constructor TDircntBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRCNT',pPath,Self);
end;

destructor TDircntBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDircntBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDircntBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDircntBtr.ReadCntNum:word;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDircntBtr.WriteCntNum(pValue:word);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDircntBtr.ReadAccost:Str10;
begin
  Result := oBtrTable.FieldByName('Accost').AsString;
end;

procedure TDircntBtr.WriteAccost(pValue:Str10);
begin
  oBtrTable.FieldByName('Accost').AsString := pValue;
end;

function TDircntBtr.ReadTitBef:Str10;
begin
  Result := oBtrTable.FieldByName('TitBef').AsString;
end;

procedure TDircntBtr.WriteTitBef(pValue:Str10);
begin
  oBtrTable.FieldByName('TitBef').AsString := pValue;
end;

function TDircntBtr.ReadFiName:Str20;
begin
  Result := oBtrTable.FieldByName('FiName').AsString;
end;

procedure TDircntBtr.WriteFiName(pValue:Str20);
begin
  oBtrTable.FieldByName('FiName').AsString := pValue;
end;

function TDircntBtr.ReadLaName:Str20;
begin
  Result := oBtrTable.FieldByName('LaName').AsString;
end;

procedure TDircntBtr.WriteLaName(pValue:Str20);
begin
  oBtrTable.FieldByName('LaName').AsString := pValue;
end;

function TDircntBtr.ReadTitAft:Str10;
begin
  Result := oBtrTable.FieldByName('TitAft').AsString;
end;

procedure TDircntBtr.WriteTitAft(pValue:Str10);
begin
  oBtrTable.FieldByName('TitAft').AsString := pValue;
end;

function TDircntBtr.ReadAcName:Str80;
begin
  Result := oBtrTable.FieldByName('AcName').AsString;
end;

procedure TDircntBtr.WriteAcName(pValue:Str80);
begin
  oBtrTable.FieldByName('AcName').AsString := pValue;
end;

function TDircntBtr.ReadAcnFrm:Str6;
begin
  Result := oBtrTable.FieldByName('AcnFrm').AsString;
end;

procedure TDircntBtr.WriteAcnFrm(pValue:Str6);
begin
  oBtrTable.FieldByName('AcnFrm').AsString := pValue;
end;

function TDircntBtr.ReadPerSex:Str5;
begin
  Result := oBtrTable.FieldByName('PerSex').AsString;
end;

procedure TDircntBtr.WritePerSex(pValue:Str5);
begin
  oBtrTable.FieldByName('PerSex').AsString := pValue;
end;

function TDircntBtr.ReadCnName:Str40;
begin
  Result := oBtrTable.FieldByName('CnName').AsString;
end;

procedure TDircntBtr.WriteCnName(pValue:Str40);
begin
  oBtrTable.FieldByName('CnName').AsString := pValue;
end;

function TDircntBtr.ReadCnName_:Str40;
begin
  Result := oBtrTable.FieldByName('CnName_').AsString;
end;

procedure TDircntBtr.WriteCnName_(pValue:Str40);
begin
  oBtrTable.FieldByName('CnName_').AsString := pValue;
end;

function TDircntBtr.ReadCntIdc:Str10;
begin
  Result := oBtrTable.FieldByName('CntIdc').AsString;
end;

procedure TDircntBtr.WriteCntIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('CntIdc').AsString := pValue;
end;

function TDircntBtr.ReadOwnNum:word;
begin
  Result := oBtrTable.FieldByName('OwnNum').AsInteger;
end;

procedure TDircntBtr.WriteOwnNum(pValue:word);
begin
  oBtrTable.FieldByName('OwnNum').AsInteger := pValue;
end;

function TDircntBtr.ReadOwnUser:Str8;
begin
  Result := oBtrTable.FieldByName('OwnUser').AsString;
end;

procedure TDircntBtr.WriteOwnUser(pValue:Str8);
begin
  oBtrTable.FieldByName('OwnUser').AsString := pValue;
end;

function TDircntBtr.ReadOwnName:Str30;
begin
  Result := oBtrTable.FieldByName('OwnName').AsString;
end;

procedure TDircntBtr.WriteOwnName(pValue:Str30);
begin
  oBtrTable.FieldByName('OwnName').AsString := pValue;
end;

function TDircntBtr.ReadExcUser:Str8;
begin
  Result := oBtrTable.FieldByName('ExcUser').AsString;
end;

procedure TDircntBtr.WriteExcUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ExcUser').AsString := pValue;
end;

function TDircntBtr.ReadCrdLev:byte;
begin
  Result := oBtrTable.FieldByName('CrdLev').AsInteger;
end;

procedure TDircntBtr.WriteCrdLev(pValue:byte);
begin
  oBtrTable.FieldByName('CrdLev').AsInteger := pValue;
end;

function TDircntBtr.ReadPamGrp:word;
begin
  Result := oBtrTable.FieldByName('PamGrp').AsInteger;
end;

procedure TDircntBtr.WritePamGrp(pValue:word);
begin
  oBtrTable.FieldByName('PamGrp').AsInteger := pValue;
end;

function TDircntBtr.ReadPamDes:Str30;
begin
  Result := oBtrTable.FieldByName('PamDes').AsString;
end;

procedure TDircntBtr.WritePamDes(pValue:Str30);
begin
  oBtrTable.FieldByName('PamDes').AsString := pValue;
end;

function TDircntBtr.ReadRelGrp:word;
begin
  Result := oBtrTable.FieldByName('RelGrp').AsInteger;
end;

procedure TDircntBtr.WriteRelGrp(pValue:word);
begin
  oBtrTable.FieldByName('RelGrp').AsInteger := pValue;
end;

function TDircntBtr.ReadRelDes:Str30;
begin
  Result := oBtrTable.FieldByName('RelDes').AsString;
end;

procedure TDircntBtr.WriteRelDes(pValue:Str30);
begin
  oBtrTable.FieldByName('RelDes').AsString := pValue;
end;

function TDircntBtr.ReadWacGrp:word;
begin
  Result := oBtrTable.FieldByName('WacGrp').AsInteger;
end;

procedure TDircntBtr.WriteWacGrp(pValue:word);
begin
  oBtrTable.FieldByName('WacGrp').AsInteger := pValue;
end;

function TDircntBtr.ReadWacDes:Str30;
begin
  Result := oBtrTable.FieldByName('WacDes').AsString;
end;

procedure TDircntBtr.WriteWacDes(pValue:Str30);
begin
  oBtrTable.FieldByName('WacDes').AsString := pValue;
end;

function TDircntBtr.ReadFocGrp:word;
begin
  Result := oBtrTable.FieldByName('FocGrp').AsInteger;
end;

procedure TDircntBtr.WriteFocGrp(pValue:word);
begin
  oBtrTable.FieldByName('FocGrp').AsInteger := pValue;
end;

function TDircntBtr.ReadFocDes:Str30;
begin
  Result := oBtrTable.FieldByName('FocDes').AsString;
end;

procedure TDircntBtr.WriteFocDes(pValue:Str30);
begin
  oBtrTable.FieldByName('FocDes').AsString := pValue;
end;

function TDircntBtr.ReadLocGrp:word;
begin
  Result := oBtrTable.FieldByName('LocGrp').AsInteger;
end;

procedure TDircntBtr.WriteLocGrp(pValue:word);
begin
  oBtrTable.FieldByName('LocGrp').AsInteger := pValue;
end;

function TDircntBtr.ReadLocDes:Str30;
begin
  Result := oBtrTable.FieldByName('LocDes').AsString;
end;

procedure TDircntBtr.WriteLocDes(pValue:Str30);
begin
  oBtrTable.FieldByName('LocDes').AsString := pValue;
end;

function TDircntBtr.ReadWrkFnc:Str30;
begin
  Result := oBtrTable.FieldByName('WrkFnc').AsString;
end;

procedure TDircntBtr.WriteWrkFnc(pValue:Str30);
begin
  oBtrTable.FieldByName('WrkFnc').AsString := pValue;
end;

function TDircntBtr.ReadWrkTel:Str20;
begin
  Result := oBtrTable.FieldByName('WrkTel').AsString;
end;

procedure TDircntBtr.WriteWrkTel(pValue:Str20);
begin
  oBtrTable.FieldByName('WrkTel').AsString := pValue;
end;

function TDircntBtr.ReadWrkEml:Str30;
begin
  Result := oBtrTable.FieldByName('WrkEml').AsString;
end;

procedure TDircntBtr.WriteWrkEml(pValue:Str30);
begin
  oBtrTable.FieldByName('WrkEml').AsString := pValue;
end;

function TDircntBtr.ReadEmpPac:longint;
begin
  Result := oBtrTable.FieldByName('EmpPac').AsInteger;
end;

procedure TDircntBtr.WriteEmpPac(pValue:longint);
begin
  oBtrTable.FieldByName('EmpPac').AsInteger := pValue;
end;

function TDircntBtr.ReadEmpPan:Str60;
begin
  Result := oBtrTable.FieldByName('EmpPan').AsString;
end;

procedure TDircntBtr.WriteEmpPan(pValue:Str60);
begin
  oBtrTable.FieldByName('EmpPan').AsString := pValue;
end;

function TDircntBtr.ReadEmpPan_:Str60;
begin
  Result := oBtrTable.FieldByName('EmpPan_').AsString;
end;

procedure TDircntBtr.WriteEmpPan_(pValue:Str60);
begin
  oBtrTable.FieldByName('EmpPan_').AsString := pValue;
end;

function TDircntBtr.ReadWrkLng:Str30;
begin
  Result := oBtrTable.FieldByName('WrkLng').AsString;
end;

procedure TDircntBtr.WriteWrkLng(pValue:Str30);
begin
  oBtrTable.FieldByName('WrkLng').AsString := pValue;
end;

function TDircntBtr.ReadWrkLev:byte;
begin
  Result := oBtrTable.FieldByName('WrkLev').AsInteger;
end;

procedure TDircntBtr.WriteWrkLev(pValue:byte);
begin
  oBtrTable.FieldByName('WrkLev').AsInteger := pValue;
end;

function TDircntBtr.ReadPriTel:Str20;
begin
  Result := oBtrTable.FieldByName('PriTel').AsString;
end;

procedure TDircntBtr.WritePriTel(pValue:Str20);
begin
  oBtrTable.FieldByName('PriTel').AsString := pValue;
end;

function TDircntBtr.ReadPriEml:Str30;
begin
  Result := oBtrTable.FieldByName('PriEml').AsString;
end;

procedure TDircntBtr.WritePriEml(pValue:Str30);
begin
  oBtrTable.FieldByName('PriEml').AsString := pValue;
end;

function TDircntBtr.ReadPriLev:byte;
begin
  Result := oBtrTable.FieldByName('PriLev').AsInteger;
end;

procedure TDircntBtr.WritePriLev(pValue:byte);
begin
  oBtrTable.FieldByName('PriLev').AsInteger := pValue;
end;

function TDircntBtr.ReadPriOth:Str60;
begin
  Result := oBtrTable.FieldByName('PriOth').AsString;
end;

procedure TDircntBtr.WritePriOth(pValue:Str60);
begin
  oBtrTable.FieldByName('PriOth').AsString := pValue;
end;

function TDircntBtr.ReadBirDay:byte;
begin
  Result := oBtrTable.FieldByName('BirDay').AsInteger;
end;

procedure TDircntBtr.WriteBirDay(pValue:byte);
begin
  oBtrTable.FieldByName('BirDay').AsInteger := pValue;
end;

function TDircntBtr.ReadBirMth:byte;
begin
  Result := oBtrTable.FieldByName('BirMth').AsInteger;
end;

procedure TDircntBtr.WriteBirMth(pValue:byte);
begin
  oBtrTable.FieldByName('BirMth').AsInteger := pValue;
end;

function TDircntBtr.ReadBirYear:word;
begin
  Result := oBtrTable.FieldByName('BirYear').AsInteger;
end;

procedure TDircntBtr.WriteBirYear(pValue:word);
begin
  oBtrTable.FieldByName('BirYear').AsInteger := pValue;
end;

function TDircntBtr.ReadDisCrd:byte;
begin
  Result := oBtrTable.FieldByName('DisCrd').AsInteger;
end;

procedure TDircntBtr.WriteDisCrd(pValue:byte);
begin
  oBtrTable.FieldByName('DisCrd').AsInteger := pValue;
end;

function TDircntBtr.ReadNotPub:byte;
begin
  Result := oBtrTable.FieldByName('NotPub').AsInteger;
end;

procedure TDircntBtr.WriteNotPub(pValue:byte);
begin
  oBtrTable.FieldByName('NotPub').AsInteger := pValue;
end;

function TDircntBtr.ReadWarMar:Str1;
begin
  Result := oBtrTable.FieldByName('WarMar').AsString;
end;

procedure TDircntBtr.WriteWarMar(pValue:Str1);
begin
  oBtrTable.FieldByName('WarMar').AsString := pValue;
end;

function TDircntBtr.ReadPerRel:Str30;
begin
  Result := oBtrTable.FieldByName('PerRel').AsString;
end;

procedure TDircntBtr.WritePerRel(pValue:Str30);
begin
  oBtrTable.FieldByName('PerRel').AsString := pValue;
end;

function TDircntBtr.ReadLogName:Str8;
begin
  Result := oBtrTable.FieldByName('LogName').AsString;
end;

procedure TDircntBtr.WriteLogName(pValue:Str8);
begin
  oBtrTable.FieldByName('LogName').AsString := pValue;
end;

function TDircntBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDircntBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDircntBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDircntBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDircntBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDircntBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDircntBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TDircntBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDircntBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDircntBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDircntBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDircntBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDircntBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDircntBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDircntBtr.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDircntBtr.LocateOwnUser (pOwnUser:Str8):boolean;
begin
  SetIndex (ixOwnUser);
  Result := oBtrTable.FindKey([pOwnUser]);
end;

function TDircntBtr.LocateCnName (pCnName_:Str40):boolean;
begin
  SetIndex (ixCnName);
  Result := oBtrTable.FindKey([StrToAlias(pCnName_)]);
end;

function TDircntBtr.LocateCntIdc (pCntIdc:Str10):boolean;
begin
  SetIndex (ixCntIdc);
  Result := oBtrTable.FindKey([pCntIdc]);
end;

function TDircntBtr.LocateWrkTel (pWrkTel:Str20):boolean;
begin
  SetIndex (ixWrkTel);
  Result := oBtrTable.FindKey([pWrkTel]);
end;

function TDircntBtr.LocateWrkEml (pWrkEml:Str30):boolean;
begin
  SetIndex (ixWrkEml);
  Result := oBtrTable.FindKey([pWrkEml]);
end;

function TDircntBtr.LocatePriTel (pPriTel:Str20):boolean;
begin
  SetIndex (ixPriTel);
  Result := oBtrTable.FindKey([pPriTel]);
end;

function TDircntBtr.LocateEmpPac (pEmpPac:longint):boolean;
begin
  SetIndex (ixEmpPac);
  Result := oBtrTable.FindKey([pEmpPac]);
end;

function TDircntBtr.LocateEmpPan (pEmpPan_:Str60):boolean;
begin
  SetIndex (ixEmpPan);
  Result := oBtrTable.FindKey([StrToAlias(pEmpPan_)]);
end;

function TDircntBtr.LocateLogName (pLogName:Str8):boolean;
begin
  SetIndex (ixLogName);
  Result := oBtrTable.FindKey([pLogName]);
end;

function TDircntBtr.NearestCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

function TDircntBtr.NearestOwnUser (pOwnUser:Str8):boolean;
begin
  SetIndex (ixOwnUser);
  Result := oBtrTable.FindNearest([pOwnUser]);
end;

function TDircntBtr.NearestCnName (pCnName_:Str40):boolean;
begin
  SetIndex (ixCnName);
  Result := oBtrTable.FindNearest([pCnName_]);
end;

function TDircntBtr.NearestCntIdc (pCntIdc:Str10):boolean;
begin
  SetIndex (ixCntIdc);
  Result := oBtrTable.FindNearest([pCntIdc]);
end;

function TDircntBtr.NearestWrkTel (pWrkTel:Str20):boolean;
begin
  SetIndex (ixWrkTel);
  Result := oBtrTable.FindNearest([pWrkTel]);
end;

function TDircntBtr.NearestWrkEml (pWrkEml:Str30):boolean;
begin
  SetIndex (ixWrkEml);
  Result := oBtrTable.FindNearest([pWrkEml]);
end;

function TDircntBtr.NearestPriTel (pPriTel:Str20):boolean;
begin
  SetIndex (ixPriTel);
  Result := oBtrTable.FindNearest([pPriTel]);
end;

function TDircntBtr.NearestEmpPac (pEmpPac:longint):boolean;
begin
  SetIndex (ixEmpPac);
  Result := oBtrTable.FindNearest([pEmpPac]);
end;

function TDircntBtr.NearestEmpPan (pEmpPan_:Str60):boolean;
begin
  SetIndex (ixEmpPan);
  Result := oBtrTable.FindNearest([pEmpPan_]);
end;

function TDircntBtr.NearestLogName (pLogName:Str8):boolean;
begin
  SetIndex (ixLogName);
  Result := oBtrTable.FindNearest([pLogName]);
end;

procedure TDircntBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDircntBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDircntBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDircntBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDircntBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDircntBtr.First;
begin
  oBtrTable.First;
end;

procedure TDircntBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDircntBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDircntBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDircntBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDircntBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDircntBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDircntBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDircntBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDircntBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDircntBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDircntBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
