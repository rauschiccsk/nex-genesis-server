unit tDIRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCntNum = '';
  ixCnName = 'CnName';

type
  TDirlstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadWrkFnc:Str30;          procedure WriteWrkFnc (pValue:Str30);
    function  ReadWrkTel:Str20;          procedure WriteWrkTel (pValue:Str20);
    function  ReadWrkEml:Str30;          procedure WriteWrkEml (pValue:Str30);
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
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateCntNum (pCntNum:word):boolean;
    function LocateCnName (pCnName_:Str40):boolean;

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
    property WrkFnc:Str30 read ReadWrkFnc write WriteWrkFnc;
    property WrkTel:Str20 read ReadWrkTel write WriteWrkTel;
    property WrkEml:Str30 read ReadWrkEml write WriteWrkEml;
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
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDirlstTmp.Create;
begin
  oTmpTable := TmpInit ('DIRLST',Self);
end;

destructor TDirlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirlstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirlstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirlstTmp.ReadCntNum:word;
begin
  Result := oTmpTable.FieldByName('CntNum').AsInteger;
end;

procedure TDirlstTmp.WriteCntNum(pValue:word);
begin
  oTmpTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDirlstTmp.ReadAccost:Str10;
begin
  Result := oTmpTable.FieldByName('Accost').AsString;
end;

procedure TDirlstTmp.WriteAccost(pValue:Str10);
begin
  oTmpTable.FieldByName('Accost').AsString := pValue;
end;

function TDirlstTmp.ReadTitBef:Str10;
begin
  Result := oTmpTable.FieldByName('TitBef').AsString;
end;

procedure TDirlstTmp.WriteTitBef(pValue:Str10);
begin
  oTmpTable.FieldByName('TitBef').AsString := pValue;
end;

function TDirlstTmp.ReadFiName:Str20;
begin
  Result := oTmpTable.FieldByName('FiName').AsString;
end;

procedure TDirlstTmp.WriteFiName(pValue:Str20);
begin
  oTmpTable.FieldByName('FiName').AsString := pValue;
end;

function TDirlstTmp.ReadLaName:Str20;
begin
  Result := oTmpTable.FieldByName('LaName').AsString;
end;

procedure TDirlstTmp.WriteLaName(pValue:Str20);
begin
  oTmpTable.FieldByName('LaName').AsString := pValue;
end;

function TDirlstTmp.ReadTitAft:Str10;
begin
  Result := oTmpTable.FieldByName('TitAft').AsString;
end;

procedure TDirlstTmp.WriteTitAft(pValue:Str10);
begin
  oTmpTable.FieldByName('TitAft').AsString := pValue;
end;

function TDirlstTmp.ReadAcName:Str80;
begin
  Result := oTmpTable.FieldByName('AcName').AsString;
end;

procedure TDirlstTmp.WriteAcName(pValue:Str80);
begin
  oTmpTable.FieldByName('AcName').AsString := pValue;
end;

function TDirlstTmp.ReadAcnFrm:Str6;
begin
  Result := oTmpTable.FieldByName('AcnFrm').AsString;
end;

procedure TDirlstTmp.WriteAcnFrm(pValue:Str6);
begin
  oTmpTable.FieldByName('AcnFrm').AsString := pValue;
end;

function TDirlstTmp.ReadPerSex:Str5;
begin
  Result := oTmpTable.FieldByName('PerSex').AsString;
end;

procedure TDirlstTmp.WritePerSex(pValue:Str5);
begin
  oTmpTable.FieldByName('PerSex').AsString := pValue;
end;

function TDirlstTmp.ReadCnName:Str40;
begin
  Result := oTmpTable.FieldByName('CnName').AsString;
end;

procedure TDirlstTmp.WriteCnName(pValue:Str40);
begin
  oTmpTable.FieldByName('CnName').AsString := pValue;
end;

function TDirlstTmp.ReadCnName_:Str40;
begin
  Result := oTmpTable.FieldByName('CnName_').AsString;
end;

procedure TDirlstTmp.WriteCnName_(pValue:Str40);
begin
  oTmpTable.FieldByName('CnName_').AsString := pValue;
end;

function TDirlstTmp.ReadCntIdc:Str10;
begin
  Result := oTmpTable.FieldByName('CntIdc').AsString;
end;

procedure TDirlstTmp.WriteCntIdc(pValue:Str10);
begin
  oTmpTable.FieldByName('CntIdc').AsString := pValue;
end;

function TDirlstTmp.ReadWrkFnc:Str30;
begin
  Result := oTmpTable.FieldByName('WrkFnc').AsString;
end;

procedure TDirlstTmp.WriteWrkFnc(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkFnc').AsString := pValue;
end;

function TDirlstTmp.ReadWrkTel:Str20;
begin
  Result := oTmpTable.FieldByName('WrkTel').AsString;
end;

procedure TDirlstTmp.WriteWrkTel(pValue:Str20);
begin
  oTmpTable.FieldByName('WrkTel').AsString := pValue;
end;

function TDirlstTmp.ReadWrkEml:Str30;
begin
  Result := oTmpTable.FieldByName('WrkEml').AsString;
end;

procedure TDirlstTmp.WriteWrkEml(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkEml').AsString := pValue;
end;

function TDirlstTmp.ReadWrkLng:Str30;
begin
  Result := oTmpTable.FieldByName('WrkLng').AsString;
end;

procedure TDirlstTmp.WriteWrkLng(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkLng').AsString := pValue;
end;

function TDirlstTmp.ReadWrkLev:byte;
begin
  Result := oTmpTable.FieldByName('WrkLev').AsInteger;
end;

procedure TDirlstTmp.WriteWrkLev(pValue:byte);
begin
  oTmpTable.FieldByName('WrkLev').AsInteger := pValue;
end;

function TDirlstTmp.ReadPriTel:Str20;
begin
  Result := oTmpTable.FieldByName('PriTel').AsString;
end;

procedure TDirlstTmp.WritePriTel(pValue:Str20);
begin
  oTmpTable.FieldByName('PriTel').AsString := pValue;
end;

function TDirlstTmp.ReadPriEml:Str30;
begin
  Result := oTmpTable.FieldByName('PriEml').AsString;
end;

procedure TDirlstTmp.WritePriEml(pValue:Str30);
begin
  oTmpTable.FieldByName('PriEml').AsString := pValue;
end;

function TDirlstTmp.ReadPriLev:byte;
begin
  Result := oTmpTable.FieldByName('PriLev').AsInteger;
end;

procedure TDirlstTmp.WritePriLev(pValue:byte);
begin
  oTmpTable.FieldByName('PriLev').AsInteger := pValue;
end;

function TDirlstTmp.ReadPriOth:Str60;
begin
  Result := oTmpTable.FieldByName('PriOth').AsString;
end;

procedure TDirlstTmp.WritePriOth(pValue:Str60);
begin
  oTmpTable.FieldByName('PriOth').AsString := pValue;
end;

function TDirlstTmp.ReadBirDay:byte;
begin
  Result := oTmpTable.FieldByName('BirDay').AsInteger;
end;

procedure TDirlstTmp.WriteBirDay(pValue:byte);
begin
  oTmpTable.FieldByName('BirDay').AsInteger := pValue;
end;

function TDirlstTmp.ReadBirMth:byte;
begin
  Result := oTmpTable.FieldByName('BirMth').AsInteger;
end;

procedure TDirlstTmp.WriteBirMth(pValue:byte);
begin
  oTmpTable.FieldByName('BirMth').AsInteger := pValue;
end;

function TDirlstTmp.ReadBirYear:word;
begin
  Result := oTmpTable.FieldByName('BirYear').AsInteger;
end;

procedure TDirlstTmp.WriteBirYear(pValue:word);
begin
  oTmpTable.FieldByName('BirYear').AsInteger := pValue;
end;

function TDirlstTmp.ReadDisCrd:byte;
begin
  Result := oTmpTable.FieldByName('DisCrd').AsInteger;
end;

procedure TDirlstTmp.WriteDisCrd(pValue:byte);
begin
  oTmpTable.FieldByName('DisCrd').AsInteger := pValue;
end;

function TDirlstTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDirlstTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirlstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirlstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirlstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirlstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirlstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDirlstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirlstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirlstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirlstTmp.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oTmpTable.FindKey([pCntNum]);
end;

function TDirlstTmp.LocateCnName (pCnName_:Str40):boolean;
begin
  SetIndex (ixCnName);
  Result := oTmpTable.FindKey([pCnName_]);
end;

procedure TDirlstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirlstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirlstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirlstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirlstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1907001}
