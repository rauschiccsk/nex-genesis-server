unit tPARCNT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCntNum = '';
  ixCnName = 'CnName';
  ixCntIdc = 'CntIdc';
  ixWrkTel = 'WrkTel';
  ixWrkEml = 'WrkEml';

type
  TParcntTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadAcName:Str80;          procedure WriteAcName (pValue:Str80);
    function  ReadPerSex:Str5;           procedure WritePerSex (pValue:Str5);
    function  ReadCnName:Str40;          procedure WriteCnName (pValue:Str40);
    function  ReadCnName_:Str40;         procedure WriteCnName_ (pValue:Str40);
    function  ReadCntIdc:Str10;          procedure WriteCntIdc (pValue:Str10);
    function  ReadOwnName:Str30;         procedure WriteOwnName (pValue:Str30);
    function  ReadRelGrp:word;           procedure WriteRelGrp (pValue:word);
    function  ReadRelDes:Str30;          procedure WriteRelDes (pValue:Str30);
    function  ReadWacDes:Str30;          procedure WriteWacDes (pValue:Str30);
    function  ReadFocDes:Str30;          procedure WriteFocDes (pValue:Str30);
    function  ReadLocDes:Str30;          procedure WriteLocDes (pValue:Str30);
    function  ReadWrkFnc:Str30;          procedure WriteWrkFnc (pValue:Str30);
    function  ReadWrkTel:Str20;          procedure WriteWrkTel (pValue:Str20);
    function  ReadWrkEml:Str30;          procedure WriteWrkEml (pValue:Str30);
    function  ReadWrkLng:Str30;          procedure WriteWrkLng (pValue:Str30);
    function  ReadBirDay:byte;           procedure WriteBirDay (pValue:byte);
    function  ReadBirMth:byte;           procedure WriteBirMth (pValue:byte);
    function  ReadBirYear:word;          procedure WriteBirYear (pValue:word);
    function  ReadWarMar:Str1;           procedure WriteWarMar (pValue:Str1);
    function  ReadPerRel:Str30;          procedure WritePerRel (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateCntNum (pCntNum:word):boolean;
    function LocateCnName (pCnName_:Str40):boolean;
    function LocateCntIdc (pCntIdc:Str10):boolean;
    function LocateWrkTel (pWrkTel:Str20):boolean;
    function LocateWrkEml (pWrkEml:Str30):boolean;

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
    property AcName:Str80 read ReadAcName write WriteAcName;
    property PerSex:Str5 read ReadPerSex write WritePerSex;
    property CnName:Str40 read ReadCnName write WriteCnName;
    property CnName_:Str40 read ReadCnName_ write WriteCnName_;
    property CntIdc:Str10 read ReadCntIdc write WriteCntIdc;
    property OwnName:Str30 read ReadOwnName write WriteOwnName;
    property RelGrp:word read ReadRelGrp write WriteRelGrp;
    property RelDes:Str30 read ReadRelDes write WriteRelDes;
    property WacDes:Str30 read ReadWacDes write WriteWacDes;
    property FocDes:Str30 read ReadFocDes write WriteFocDes;
    property LocDes:Str30 read ReadLocDes write WriteLocDes;
    property WrkFnc:Str30 read ReadWrkFnc write WriteWrkFnc;
    property WrkTel:Str20 read ReadWrkTel write WriteWrkTel;
    property WrkEml:Str30 read ReadWrkEml write WriteWrkEml;
    property WrkLng:Str30 read ReadWrkLng write WriteWrkLng;
    property BirDay:byte read ReadBirDay write WriteBirDay;
    property BirMth:byte read ReadBirMth write WriteBirMth;
    property BirYear:word read ReadBirYear write WriteBirYear;
    property WarMar:Str1 read ReadWarMar write WriteWarMar;
    property PerRel:Str30 read ReadPerRel write WritePerRel;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TParcntTmp.Create;
begin
  oTmpTable := TmpInit ('PARCNT',Self);
end;

destructor TParcntTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TParcntTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TParcntTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TParcntTmp.ReadCntNum:word;
begin
  Result := oTmpTable.FieldByName('CntNum').AsInteger;
end;

procedure TParcntTmp.WriteCntNum(pValue:word);
begin
  oTmpTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TParcntTmp.ReadAcName:Str80;
begin
  Result := oTmpTable.FieldByName('AcName').AsString;
end;

procedure TParcntTmp.WriteAcName(pValue:Str80);
begin
  oTmpTable.FieldByName('AcName').AsString := pValue;
end;

function TParcntTmp.ReadPerSex:Str5;
begin
  Result := oTmpTable.FieldByName('PerSex').AsString;
end;

procedure TParcntTmp.WritePerSex(pValue:Str5);
begin
  oTmpTable.FieldByName('PerSex').AsString := pValue;
end;

function TParcntTmp.ReadCnName:Str40;
begin
  Result := oTmpTable.FieldByName('CnName').AsString;
end;

procedure TParcntTmp.WriteCnName(pValue:Str40);
begin
  oTmpTable.FieldByName('CnName').AsString := pValue;
end;

function TParcntTmp.ReadCnName_:Str40;
begin
  Result := oTmpTable.FieldByName('CnName_').AsString;
end;

procedure TParcntTmp.WriteCnName_(pValue:Str40);
begin
  oTmpTable.FieldByName('CnName_').AsString := pValue;
end;

function TParcntTmp.ReadCntIdc:Str10;
begin
  Result := oTmpTable.FieldByName('CntIdc').AsString;
end;

procedure TParcntTmp.WriteCntIdc(pValue:Str10);
begin
  oTmpTable.FieldByName('CntIdc').AsString := pValue;
end;

function TParcntTmp.ReadOwnName:Str30;
begin
  Result := oTmpTable.FieldByName('OwnName').AsString;
end;

procedure TParcntTmp.WriteOwnName(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnName').AsString := pValue;
end;

function TParcntTmp.ReadRelGrp:word;
begin
  Result := oTmpTable.FieldByName('RelGrp').AsInteger;
end;

procedure TParcntTmp.WriteRelGrp(pValue:word);
begin
  oTmpTable.FieldByName('RelGrp').AsInteger := pValue;
end;

function TParcntTmp.ReadRelDes:Str30;
begin
  Result := oTmpTable.FieldByName('RelDes').AsString;
end;

procedure TParcntTmp.WriteRelDes(pValue:Str30);
begin
  oTmpTable.FieldByName('RelDes').AsString := pValue;
end;

function TParcntTmp.ReadWacDes:Str30;
begin
  Result := oTmpTable.FieldByName('WacDes').AsString;
end;

procedure TParcntTmp.WriteWacDes(pValue:Str30);
begin
  oTmpTable.FieldByName('WacDes').AsString := pValue;
end;

function TParcntTmp.ReadFocDes:Str30;
begin
  Result := oTmpTable.FieldByName('FocDes').AsString;
end;

procedure TParcntTmp.WriteFocDes(pValue:Str30);
begin
  oTmpTable.FieldByName('FocDes').AsString := pValue;
end;

function TParcntTmp.ReadLocDes:Str30;
begin
  Result := oTmpTable.FieldByName('LocDes').AsString;
end;

procedure TParcntTmp.WriteLocDes(pValue:Str30);
begin
  oTmpTable.FieldByName('LocDes').AsString := pValue;
end;

function TParcntTmp.ReadWrkFnc:Str30;
begin
  Result := oTmpTable.FieldByName('WrkFnc').AsString;
end;

procedure TParcntTmp.WriteWrkFnc(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkFnc').AsString := pValue;
end;

function TParcntTmp.ReadWrkTel:Str20;
begin
  Result := oTmpTable.FieldByName('WrkTel').AsString;
end;

procedure TParcntTmp.WriteWrkTel(pValue:Str20);
begin
  oTmpTable.FieldByName('WrkTel').AsString := pValue;
end;

function TParcntTmp.ReadWrkEml:Str30;
begin
  Result := oTmpTable.FieldByName('WrkEml').AsString;
end;

procedure TParcntTmp.WriteWrkEml(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkEml').AsString := pValue;
end;

function TParcntTmp.ReadWrkLng:Str30;
begin
  Result := oTmpTable.FieldByName('WrkLng').AsString;
end;

procedure TParcntTmp.WriteWrkLng(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkLng').AsString := pValue;
end;

function TParcntTmp.ReadBirDay:byte;
begin
  Result := oTmpTable.FieldByName('BirDay').AsInteger;
end;

procedure TParcntTmp.WriteBirDay(pValue:byte);
begin
  oTmpTable.FieldByName('BirDay').AsInteger := pValue;
end;

function TParcntTmp.ReadBirMth:byte;
begin
  Result := oTmpTable.FieldByName('BirMth').AsInteger;
end;

procedure TParcntTmp.WriteBirMth(pValue:byte);
begin
  oTmpTable.FieldByName('BirMth').AsInteger := pValue;
end;

function TParcntTmp.ReadBirYear:word;
begin
  Result := oTmpTable.FieldByName('BirYear').AsInteger;
end;

procedure TParcntTmp.WriteBirYear(pValue:word);
begin
  oTmpTable.FieldByName('BirYear').AsInteger := pValue;
end;

function TParcntTmp.ReadWarMar:Str1;
begin
  Result := oTmpTable.FieldByName('WarMar').AsString;
end;

procedure TParcntTmp.WriteWarMar(pValue:Str1);
begin
  oTmpTable.FieldByName('WarMar').AsString := pValue;
end;

function TParcntTmp.ReadPerRel:Str30;
begin
  Result := oTmpTable.FieldByName('PerRel').AsString;
end;

procedure TParcntTmp.WritePerRel(pValue:Str30);
begin
  oTmpTable.FieldByName('PerRel').AsString := pValue;
end;

function TParcntTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TParcntTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TParcntTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TParcntTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TParcntTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TParcntTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TParcntTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TParcntTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TParcntTmp.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oTmpTable.FindKey([pCntNum]);
end;

function TParcntTmp.LocateCnName (pCnName_:Str40):boolean;
begin
  SetIndex (ixCnName);
  Result := oTmpTable.FindKey([pCnName_]);
end;

function TParcntTmp.LocateCntIdc (pCntIdc:Str10):boolean;
begin
  SetIndex (ixCntIdc);
  Result := oTmpTable.FindKey([pCntIdc]);
end;

function TParcntTmp.LocateWrkTel (pWrkTel:Str20):boolean;
begin
  SetIndex (ixWrkTel);
  Result := oTmpTable.FindKey([pWrkTel]);
end;

function TParcntTmp.LocateWrkEml (pWrkEml:Str30):boolean;
begin
  SetIndex (ixWrkEml);
  Result := oTmpTable.FindKey([pWrkEml]);
end;

procedure TParcntTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TParcntTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TParcntTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TParcntTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TParcntTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TParcntTmp.First;
begin
  oTmpTable.First;
end;

procedure TParcntTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TParcntTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TParcntTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TParcntTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TParcntTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TParcntTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TParcntTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TParcntTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TParcntTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TParcntTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TParcntTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1920001}
