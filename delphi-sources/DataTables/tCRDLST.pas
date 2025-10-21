unit tCRDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrdNum = '';
  ixCrdName_ = 'CrdName_';
  ixCrdType = 'CrdType';
  ixCrdGrp = 'CrdGrp';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixDscType = 'DscType';
  ixBonNew = 'BonNew';

type
  TCrdlstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadCrdName:Str30;         procedure WriteCrdName (pValue:Str30);
    function  ReadCrdName_:Str30;        procedure WriteCrdName_ (pValue:Str30);
    function  ReadCrdType:Str1;          procedure WriteCrdType (pValue:Str1);
    function  ReadCrdGrp:word;           procedure WriteCrdGrp (pValue:word);
    function  ReadCrdGrn:Str30;          procedure WriteCrdGrn (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadPaAdrc:Str60;          procedure WritePaAdrc (pValue:Str60);
    function  ReadDscType:Str5;          procedure WriteDscType (pValue:Str5);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadTrnSum:double;         procedure WriteTrnSum (pValue:double);
    function  ReadTrnPer:double;         procedure WriteTrnPer (pValue:double);
    function  ReadTrnBon:double;         procedure WriteTrnBon (pValue:double);
    function  ReadTrnNeb:double;         procedure WriteTrnNeb (pValue:double);
    function  ReadBonQnt:word;           procedure WriteBonQnt (pValue:word);
    function  ReadBonOut:word;           procedure WriteBonOut (pValue:word);
    function  ReadBonNew:word;           procedure WriteBonNew (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegRec:Str60;          procedure WriteRegRec (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateCrdNum (pCrdNum:Str20):boolean;
    function LocateCrdName_ (pCrdName_:Str30):boolean;
    function LocateCrdType (pCrdType:Str1):boolean;
    function LocateCrdGrp (pCrdGrp:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateDscType (pDscType:Str5):boolean;
    function LocateBonNew (pBonNew:word):boolean;

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
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property CrdName:Str30 read ReadCrdName write WriteCrdName;
    property CrdName_:Str30 read ReadCrdName_ write WriteCrdName_;
    property CrdType:Str1 read ReadCrdType write WriteCrdType;
    property CrdGrp:word read ReadCrdGrp write WriteCrdGrp;
    property CrdGrn:Str30 read ReadCrdGrn write WriteCrdGrn;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property PaAdrc:Str60 read ReadPaAdrc write WritePaAdrc;
    property DscType:Str5 read ReadDscType write WriteDscType;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property TrnSum:double read ReadTrnSum write WriteTrnSum;
    property TrnPer:double read ReadTrnPer write WriteTrnPer;
    property TrnBon:double read ReadTrnBon write WriteTrnBon;
    property TrnNeb:double read ReadTrnNeb write WriteTrnNeb;
    property BonQnt:word read ReadBonQnt write WriteBonQnt;
    property BonOut:word read ReadBonOut write WriteBonOut;
    property BonNew:word read ReadBonNew write WriteBonNew;
    property Sended:boolean read ReadSended write WriteSended;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegRec:Str60 read ReadRegRec write WriteRegRec;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TCrdlstTmp.Create;
begin
  oTmpTable := TmpInit ('CRDLST',Self);
end;

destructor TCrdlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdlstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCrdlstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCrdlstTmp.ReadCrdNum:Str20;
begin
  Result := oTmpTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdlstTmp.WriteCrdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCrdlstTmp.ReadCrdName:Str30;
begin
  Result := oTmpTable.FieldByName('CrdName').AsString;
end;

procedure TCrdlstTmp.WriteCrdName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdName').AsString := pValue;
end;

function TCrdlstTmp.ReadCrdName_:Str30;
begin
  Result := oTmpTable.FieldByName('CrdName_').AsString;
end;

procedure TCrdlstTmp.WriteCrdName_(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdName_').AsString := pValue;
end;

function TCrdlstTmp.ReadCrdType:Str1;
begin
  Result := oTmpTable.FieldByName('CrdType').AsString;
end;

procedure TCrdlstTmp.WriteCrdType(pValue:Str1);
begin
  oTmpTable.FieldByName('CrdType').AsString := pValue;
end;

function TCrdlstTmp.ReadCrdGrp:word;
begin
  Result := oTmpTable.FieldByName('CrdGrp').AsInteger;
end;

procedure TCrdlstTmp.WriteCrdGrp(pValue:word);
begin
  oTmpTable.FieldByName('CrdGrp').AsInteger := pValue;
end;

function TCrdlstTmp.ReadCrdGrn:Str30;
begin
  Result := oTmpTable.FieldByName('CrdGrn').AsString;
end;

procedure TCrdlstTmp.WriteCrdGrn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrdGrn').AsString := pValue;
end;

function TCrdlstTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCrdlstTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCrdlstTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TCrdlstTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TCrdlstTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TCrdlstTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TCrdlstTmp.ReadPaAdrc:Str60;
begin
  Result := oTmpTable.FieldByName('PaAdrc').AsString;
end;

procedure TCrdlstTmp.WritePaAdrc(pValue:Str60);
begin
  oTmpTable.FieldByName('PaAdrc').AsString := pValue;
end;

function TCrdlstTmp.ReadDscType:Str5;
begin
  Result := oTmpTable.FieldByName('DscType').AsString;
end;

procedure TCrdlstTmp.WriteDscType(pValue:Str5);
begin
  oTmpTable.FieldByName('DscType').AsString := pValue;
end;

function TCrdlstTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCrdlstTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCrdlstTmp.ReadTrnSum:double;
begin
  Result := oTmpTable.FieldByName('TrnSum').AsFloat;
end;

procedure TCrdlstTmp.WriteTrnSum(pValue:double);
begin
  oTmpTable.FieldByName('TrnSum').AsFloat := pValue;
end;

function TCrdlstTmp.ReadTrnPer:double;
begin
  Result := oTmpTable.FieldByName('TrnPer').AsFloat;
end;

procedure TCrdlstTmp.WriteTrnPer(pValue:double);
begin
  oTmpTable.FieldByName('TrnPer').AsFloat := pValue;
end;

function TCrdlstTmp.ReadTrnBon:double;
begin
  Result := oTmpTable.FieldByName('TrnBon').AsFloat;
end;

procedure TCrdlstTmp.WriteTrnBon(pValue:double);
begin
  oTmpTable.FieldByName('TrnBon').AsFloat := pValue;
end;

function TCrdlstTmp.ReadTrnNeb:double;
begin
  Result := oTmpTable.FieldByName('TrnNeb').AsFloat;
end;

procedure TCrdlstTmp.WriteTrnNeb(pValue:double);
begin
  oTmpTable.FieldByName('TrnNeb').AsFloat := pValue;
end;

function TCrdlstTmp.ReadBonQnt:word;
begin
  Result := oTmpTable.FieldByName('BonQnt').AsInteger;
end;

procedure TCrdlstTmp.WriteBonQnt(pValue:word);
begin
  oTmpTable.FieldByName('BonQnt').AsInteger := pValue;
end;

function TCrdlstTmp.ReadBonOut:word;
begin
  Result := oTmpTable.FieldByName('BonOut').AsInteger;
end;

procedure TCrdlstTmp.WriteBonOut(pValue:word);
begin
  oTmpTable.FieldByName('BonOut').AsInteger := pValue;
end;

function TCrdlstTmp.ReadBonNew:word;
begin
  Result := oTmpTable.FieldByName('BonNew').AsInteger;
end;

procedure TCrdlstTmp.WriteBonNew(pValue:word);
begin
  oTmpTable.FieldByName('BonNew').AsInteger := pValue;
end;

function TCrdlstTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TCrdlstTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCrdlstTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TCrdlstTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TCrdlstTmp.ReadRegRec:Str60;
begin
  Result := oTmpTable.FieldByName('RegRec').AsString;
end;

procedure TCrdlstTmp.WriteRegRec(pValue:Str60);
begin
  oTmpTable.FieldByName('RegRec').AsString := pValue;
end;

function TCrdlstTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TCrdlstTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TCrdlstTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TCrdlstTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TCrdlstTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TCrdlstTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TCrdlstTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TCrdlstTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TCrdlstTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TCrdlstTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TCrdlstTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TCrdlstTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TCrdlstTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TCrdlstTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TCrdlstTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TCrdlstTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TCrdlstTmp.ReadRegTel:Str20;
begin
  Result := oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TCrdlstTmp.WriteRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString := pValue;
end;

function TCrdlstTmp.ReadRegFax:Str20;
begin
  Result := oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TCrdlstTmp.WriteRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString := pValue;
end;

function TCrdlstTmp.ReadRegEml:Str30;
begin
  Result := oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TCrdlstTmp.WriteRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString := pValue;
end;

function TCrdlstTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdlstTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdlstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdlstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdlstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdlstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrdlstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TCrdlstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TCrdlstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCrdlstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCrdlstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCrdlstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdlstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCrdlstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCrdlstTmp.LocateCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oTmpTable.FindKey([pCrdNum]);
end;

function TCrdlstTmp.LocateCrdName_ (pCrdName_:Str30):boolean;
begin
  SetIndex (ixCrdName_);
  Result := oTmpTable.FindKey([pCrdName_]);
end;

function TCrdlstTmp.LocateCrdType (pCrdType:Str1):boolean;
begin
  SetIndex (ixCrdType);
  Result := oTmpTable.FindKey([pCrdType]);
end;

function TCrdlstTmp.LocateCrdGrp (pCrdGrp:word):boolean;
begin
  SetIndex (ixCrdGrp);
  Result := oTmpTable.FindKey([pCrdGrp]);
end;

function TCrdlstTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TCrdlstTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TCrdlstTmp.LocateDscType (pDscType:Str5):boolean;
begin
  SetIndex (ixDscType);
  Result := oTmpTable.FindKey([pDscType]);
end;

function TCrdlstTmp.LocateBonNew (pBonNew:word):boolean;
begin
  SetIndex (ixBonNew);
  Result := oTmpTable.FindKey([pBonNew]);
end;

procedure TCrdlstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCrdlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCrdlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCrdlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCrdlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCrdlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TCrdlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCrdlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCrdlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCrdlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCrdlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCrdlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCrdlstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCrdlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCrdlstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCrdlstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCrdlstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
