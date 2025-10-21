unit bSCVDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixEquNum = 'EquNum';
  ixDocNum = 'DocNum';
  ixEnDn = 'EnDn';
  ixParCod = 'ParCod';
  ixParNam = 'ParNam';

type
  TScvdocBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEquNum:Str20;          procedure WriteEquNum (pValue:Str20);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadPlnDat:TDatetime;      procedure WritePlnDat (pValue:TDatetime);
    function  ReadCarTac:longint;        procedure WriteCarTac (pValue:longint);
    function  ReadDocDes:Str100;         procedure WriteDocDes (pValue:Str100);
    function  ReadParCod:longint;        procedure WriteParCod (pValue:longint);
    function  ReadParNam:Str100;         procedure WriteParNam (pValue:Str100);
    function  ReadParNam_:Str100;        procedure WriteParNam_ (pValue:Str100);
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadCntNam:Str30;          procedure WriteCntNam (pValue:Str30);
    function  ReadCntTel:Str20;          procedure WriteCntTel (pValue:Str20);
    function  ReadCntMob:Str20;          procedure WriteCntMob (pValue:Str20);
    function  ReadCntEml:Str30;          procedure WriteCntEml (pValue:Str30);
    function  ReadGrtTyp:Str1;           procedure WriteGrtTyp (pValue:Str1);
    function  ReadCusClm:byte;           procedure WriteCusClm (pValue:byte);
    function  ReadTkeNam:Str30;          procedure WriteTkeNam (pValue:Str30);
    function  ReadTkeDat:TDatetime;      procedure WriteTkeDat (pValue:TDatetime);
    function  ReadJudTyp:byte;           procedure WriteJudTyp (pValue:byte);
    function  ReadJudNot:Str60;          procedure WriteJudNot (pValue:Str60);
    function  ReadJudNam:Str30;          procedure WriteJudNam (pValue:Str30);
    function  ReadJudDat:TDatetime;      procedure WriteJudDat (pValue:TDatetime);
    function  ReadSolTyp:byte;           procedure WriteSolTyp (pValue:byte);
    function  ReadSolNot:Str60;          procedure WriteSolNot (pValue:Str60);
    function  ReadSolNam:Str30;          procedure WriteSolNam (pValue:Str30);
    function  ReadSolDat:TDatetime;      procedure WriteSolDat (pValue:TDatetime);
    function  ReadRepNam:Str30;          procedure WriteRepNam (pValue:Str30);
    function  ReadBegDat:TDatetime;      procedure WriteBegDat (pValue:TDatetime);
    function  ReadEndDat:TDatetime;      procedure WriteEndDat (pValue:TDatetime);
    function  ReadSndDat:TDatetime;      procedure WriteSndDat (pValue:TDatetime);
    function  ReadRpaCod:longint;        procedure WriteRpaCod (pValue:longint);
    function  ReadMsgNam:Str30;          procedure WriteMsgNam (pValue:Str30);
    function  ReadMsgCod:Str10;          procedure WriteMsgCod (pValue:Str10);
    function  ReadMsgMod:Str20;          procedure WriteMsgMod (pValue:Str20);
    function  ReadMsgDat:TDatetime;      procedure WriteMsgDat (pValue:TDatetime);
    function  ReadRetNam:Str30;          procedure WriteRetNam (pValue:Str30);
    function  ReadRetCus:Str30;          procedure WriteRetCus (pValue:Str30);
    function  ReadRetIdn:Str10;          procedure WriteRetIdn (pValue:Str10);
    function  ReadRetDat:TDatetime;      procedure WriteRetDat (pValue:TDatetime);
    function  ReadRetBad:byte;           procedure WriteRetBad (pValue:byte);
    function  ReadRetTyp:byte;           procedure WriteRetTyp (pValue:byte);
    function  ReadClsNam:Str30;          procedure WriteClsNam (pValue:Str30);
    function  ReadClsDat:TDatetime;      procedure WriteClsDat (pValue:TDatetime);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadDdsVal:double;         procedure WriteDdsVal (pValue:double);
    function  ReadHdsVal:double;         procedure WriteHdsVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDgnVal:double;         procedure WriteDgnVal (pValue:double);
    function  ReadEstVal:double;         procedure WriteEstVal (pValue:double);
    function  ReadMaxVal:double;         procedure WriteMaxVal (pValue:double);
    function  ReadAdvVal:double;         procedure WriteAdvVal (pValue:double);
    function  ReadMatVal:double;         procedure WriteMatVal (pValue:double);
    function  ReadSrvVal:double;         procedure WriteSrvVal (pValue:double);
    function  ReadGrtVal:double;         procedure WriteGrtVal (pValue:double);
    function  ReadAftVal:double;         procedure WriteAftVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadDvzNam:Str3;           procedure WriteDvzNam (pValue:Str3);
    function  ReadCourse:double;         procedure WriteCourse (pValue:double);
    function  ReadFgaVal:double;         procedure WriteFgaVal (pValue:double);
    function  ReadFgbVal:double;         procedure WriteFgbVal (pValue:double);
    function  ReadDlrCod:word;           procedure WriteDlrCod (pValue:word);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadSpvNum:Str12;          procedure WriteSpvNum (pValue:Str12);
    function  ReadCldNum:Str12;          procedure WriteCldNum (pValue:Str12);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadAgiQnt:word;           procedure WriteAgiQnt (pValue:word);
    function  ReadGgiQnt:word;           procedure WriteGgiQnt (pValue:word);
    function  ReadAgsQnt:word;           procedure WriteAgsQnt (pValue:word);
    function  ReadGgsQnt:word;           procedure WriteGgsQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadGrtDoc:Str12;          procedure WriteGrtDoc (pValue:Str12);
    function  ReadMndNam:Str30;          procedure WriteMndNam (pValue:Str30);
    function  ReadIpaCod:longint;        procedure WriteIpaCod (pValue:longint);
    function  ReadSrvTim:TDatetime;      procedure WriteSrvTim (pValue:TDatetime);
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
    function LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function LocateEquNum (pEquNum:Str20):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateEnDn (pEquNum:Str20;pDocNum:Str12):boolean;
    function LocateParCod (pParCod:longint):boolean;
    function LocateParNam (pParNam_:Str100):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function NearestEquNum (pEquNum:Str20):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestEnDn (pEquNum:Str20;pDocNum:Str12):boolean;
    function NearestParCod (pParCod:longint):boolean;
    function NearestParNam (pParNam_:Str100):boolean;

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
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property PlnDat:TDatetime read ReadPlnDat write WritePlnDat;
    property CarTac:longint read ReadCarTac write WriteCarTac;
    property DocDes:Str100 read ReadDocDes write WriteDocDes;
    property ParCod:longint read ReadParCod write WriteParCod;
    property ParNam:Str100 read ReadParNam write WriteParNam;
    property ParNam_:Str100 read ReadParNam_ write WriteParNam_;
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property CntNam:Str30 read ReadCntNam write WriteCntNam;
    property CntTel:Str20 read ReadCntTel write WriteCntTel;
    property CntMob:Str20 read ReadCntMob write WriteCntMob;
    property CntEml:Str30 read ReadCntEml write WriteCntEml;
    property GrtTyp:Str1 read ReadGrtTyp write WriteGrtTyp;
    property CusClm:byte read ReadCusClm write WriteCusClm;
    property TkeNam:Str30 read ReadTkeNam write WriteTkeNam;
    property TkeDat:TDatetime read ReadTkeDat write WriteTkeDat;
    property JudTyp:byte read ReadJudTyp write WriteJudTyp;
    property JudNot:Str60 read ReadJudNot write WriteJudNot;
    property JudNam:Str30 read ReadJudNam write WriteJudNam;
    property JudDat:TDatetime read ReadJudDat write WriteJudDat;
    property SolTyp:byte read ReadSolTyp write WriteSolTyp;
    property SolNot:Str60 read ReadSolNot write WriteSolNot;
    property SolNam:Str30 read ReadSolNam write WriteSolNam;
    property SolDat:TDatetime read ReadSolDat write WriteSolDat;
    property RepNam:Str30 read ReadRepNam write WriteRepNam;
    property BegDat:TDatetime read ReadBegDat write WriteBegDat;
    property EndDat:TDatetime read ReadEndDat write WriteEndDat;
    property SndDat:TDatetime read ReadSndDat write WriteSndDat;
    property RpaCod:longint read ReadRpaCod write WriteRpaCod;
    property MsgNam:Str30 read ReadMsgNam write WriteMsgNam;
    property MsgCod:Str10 read ReadMsgCod write WriteMsgCod;
    property MsgMod:Str20 read ReadMsgMod write WriteMsgMod;
    property MsgDat:TDatetime read ReadMsgDat write WriteMsgDat;
    property RetNam:Str30 read ReadRetNam write WriteRetNam;
    property RetCus:Str30 read ReadRetCus write WriteRetCus;
    property RetIdn:Str10 read ReadRetIdn write WriteRetIdn;
    property RetDat:TDatetime read ReadRetDat write WriteRetDat;
    property RetBad:byte read ReadRetBad write WriteRetBad;
    property RetTyp:byte read ReadRetTyp write WriteRetTyp;
    property ClsNam:Str30 read ReadClsNam write WriteClsNam;
    property ClsDat:TDatetime read ReadClsDat write WriteClsDat;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property CValue:double read ReadCValue write WriteCValue;
    property DValue:double read ReadDValue write WriteDValue;
    property HValue:double read ReadHValue write WriteHValue;
    property DdsVal:double read ReadDdsVal write WriteDdsVal;
    property HdsVal:double read ReadHdsVal write WriteHdsVal;
    property AValue:double read ReadAValue write WriteAValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property BValue:double read ReadBValue write WriteBValue;
    property DgnVal:double read ReadDgnVal write WriteDgnVal;
    property EstVal:double read ReadEstVal write WriteEstVal;
    property MaxVal:double read ReadMaxVal write WriteMaxVal;
    property AdvVal:double read ReadAdvVal write WriteAdvVal;
    property MatVal:double read ReadMatVal write WriteMatVal;
    property SrvVal:double read ReadSrvVal write WriteSrvVal;
    property GrtVal:double read ReadGrtVal write WriteGrtVal;
    property AftVal:double read ReadAftVal write WriteAftVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property DvzNam:Str3 read ReadDvzNam write WriteDvzNam;
    property Course:double read ReadCourse write WriteCourse;
    property FgaVal:double read ReadFgaVal write WriteFgaVal;
    property FgbVal:double read ReadFgbVal write WriteFgbVal;
    property DlrCod:word read ReadDlrCod write WriteDlrCod;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property SpvNum:Str12 read ReadSpvNum write WriteSpvNum;
    property CldNum:Str12 read ReadCldNum write WriteCldNum;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property AgiQnt:word read ReadAgiQnt write WriteAgiQnt;
    property GgiQnt:word read ReadGgiQnt write WriteGgiQnt;
    property AgsQnt:word read ReadAgsQnt write WriteAgsQnt;
    property GgsQnt:word read ReadGgsQnt write WriteGgsQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property GrtDoc:Str12 read ReadGrtDoc write WriteGrtDoc;
    property MndNam:Str30 read ReadMndNam write WriteMndNam;
    property IpaCod:longint read ReadIpaCod write WriteIpaCod;
    property SrvTim:TDatetime read ReadSrvTim write WriteSrvTim;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TScvdocBtr.Create;
begin
  oBtrTable := BtrInit ('SCVDOC',gPath.StkPath,Self);
end;

constructor TScvdocBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCVDOC',pPath,Self);
end;

destructor TScvdocBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TScvdocBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TScvdocBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TScvdocBtr.ReadEquNum:Str20;
begin
  Result := oBtrTable.FieldByName('EquNum').AsString;
end;

procedure TScvdocBtr.WriteEquNum(pValue:Str20);
begin
  oBtrTable.FieldByName('EquNum').AsString := pValue;
end;

function TScvdocBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TScvdocBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TScvdocBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TScvdocBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TScvdocBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TScvdocBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TScvdocBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TScvdocBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TScvdocBtr.ReadDocDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDat').AsDateTime;
end;

procedure TScvdocBtr.WriteDocDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadPlnDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDat').AsDateTime;
end;

procedure TScvdocBtr.WritePlnDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadCarTac:longint;
begin
  Result := oBtrTable.FieldByName('CarTac').AsInteger;
end;

procedure TScvdocBtr.WriteCarTac(pValue:longint);
begin
  oBtrTable.FieldByName('CarTac').AsInteger := pValue;
end;

function TScvdocBtr.ReadDocDes:Str100;
begin
  Result := oBtrTable.FieldByName('DocDes').AsString;
end;

procedure TScvdocBtr.WriteDocDes(pValue:Str100);
begin
  oBtrTable.FieldByName('DocDes').AsString := pValue;
end;

function TScvdocBtr.ReadParCod:longint;
begin
  Result := oBtrTable.FieldByName('ParCod').AsInteger;
end;

procedure TScvdocBtr.WriteParCod(pValue:longint);
begin
  oBtrTable.FieldByName('ParCod').AsInteger := pValue;
end;

function TScvdocBtr.ReadParNam:Str100;
begin
  Result := oBtrTable.FieldByName('ParNam').AsString;
end;

procedure TScvdocBtr.WriteParNam(pValue:Str100);
begin
  oBtrTable.FieldByName('ParNam').AsString := pValue;
end;

function TScvdocBtr.ReadParNam_:Str100;
begin
  Result := oBtrTable.FieldByName('ParNam_').AsString;
end;

procedure TScvdocBtr.WriteParNam_(pValue:Str100);
begin
  oBtrTable.FieldByName('ParNam_').AsString := pValue;
end;

function TScvdocBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TScvdocBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TScvdocBtr.ReadCntNam:Str30;
begin
  Result := oBtrTable.FieldByName('CntNam').AsString;
end;

procedure TScvdocBtr.WriteCntNam(pValue:Str30);
begin
  oBtrTable.FieldByName('CntNam').AsString := pValue;
end;

function TScvdocBtr.ReadCntTel:Str20;
begin
  Result := oBtrTable.FieldByName('CntTel').AsString;
end;

procedure TScvdocBtr.WriteCntTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CntTel').AsString := pValue;
end;

function TScvdocBtr.ReadCntMob:Str20;
begin
  Result := oBtrTable.FieldByName('CntMob').AsString;
end;

procedure TScvdocBtr.WriteCntMob(pValue:Str20);
begin
  oBtrTable.FieldByName('CntMob').AsString := pValue;
end;

function TScvdocBtr.ReadCntEml:Str30;
begin
  Result := oBtrTable.FieldByName('CntEml').AsString;
end;

procedure TScvdocBtr.WriteCntEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CntEml').AsString := pValue;
end;

function TScvdocBtr.ReadGrtTyp:Str1;
begin
  Result := oBtrTable.FieldByName('GrtTyp').AsString;
end;

procedure TScvdocBtr.WriteGrtTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('GrtTyp').AsString := pValue;
end;

function TScvdocBtr.ReadCusClm:byte;
begin
  Result := oBtrTable.FieldByName('CusClm').AsInteger;
end;

procedure TScvdocBtr.WriteCusClm(pValue:byte);
begin
  oBtrTable.FieldByName('CusClm').AsInteger := pValue;
end;

function TScvdocBtr.ReadTkeNam:Str30;
begin
  Result := oBtrTable.FieldByName('TkeNam').AsString;
end;

procedure TScvdocBtr.WriteTkeNam(pValue:Str30);
begin
  oBtrTable.FieldByName('TkeNam').AsString := pValue;
end;

function TScvdocBtr.ReadTkeDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('TkeDat').AsDateTime;
end;

procedure TScvdocBtr.WriteTkeDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TkeDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadJudTyp:byte;
begin
  Result := oBtrTable.FieldByName('JudTyp').AsInteger;
end;

procedure TScvdocBtr.WriteJudTyp(pValue:byte);
begin
  oBtrTable.FieldByName('JudTyp').AsInteger := pValue;
end;

function TScvdocBtr.ReadJudNot:Str60;
begin
  Result := oBtrTable.FieldByName('JudNot').AsString;
end;

procedure TScvdocBtr.WriteJudNot(pValue:Str60);
begin
  oBtrTable.FieldByName('JudNot').AsString := pValue;
end;

function TScvdocBtr.ReadJudNam:Str30;
begin
  Result := oBtrTable.FieldByName('JudNam').AsString;
end;

procedure TScvdocBtr.WriteJudNam(pValue:Str30);
begin
  oBtrTable.FieldByName('JudNam').AsString := pValue;
end;

function TScvdocBtr.ReadJudDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('JudDat').AsDateTime;
end;

procedure TScvdocBtr.WriteJudDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('JudDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadSolTyp:byte;
begin
  Result := oBtrTable.FieldByName('SolTyp').AsInteger;
end;

procedure TScvdocBtr.WriteSolTyp(pValue:byte);
begin
  oBtrTable.FieldByName('SolTyp').AsInteger := pValue;
end;

function TScvdocBtr.ReadSolNot:Str60;
begin
  Result := oBtrTable.FieldByName('SolNot').AsString;
end;

procedure TScvdocBtr.WriteSolNot(pValue:Str60);
begin
  oBtrTable.FieldByName('SolNot').AsString := pValue;
end;

function TScvdocBtr.ReadSolNam:Str30;
begin
  Result := oBtrTable.FieldByName('SolNam').AsString;
end;

procedure TScvdocBtr.WriteSolNam(pValue:Str30);
begin
  oBtrTable.FieldByName('SolNam').AsString := pValue;
end;

function TScvdocBtr.ReadSolDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('SolDat').AsDateTime;
end;

procedure TScvdocBtr.WriteSolDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SolDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadRepNam:Str30;
begin
  Result := oBtrTable.FieldByName('RepNam').AsString;
end;

procedure TScvdocBtr.WriteRepNam(pValue:Str30);
begin
  oBtrTable.FieldByName('RepNam').AsString := pValue;
end;

function TScvdocBtr.ReadBegDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat').AsDateTime;
end;

procedure TScvdocBtr.WriteBegDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadEndDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat').AsDateTime;
end;

procedure TScvdocBtr.WriteEndDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadSndDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndDat').AsDateTime;
end;

procedure TScvdocBtr.WriteSndDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadRpaCod:longint;
begin
  Result := oBtrTable.FieldByName('RpaCod').AsInteger;
end;

procedure TScvdocBtr.WriteRpaCod(pValue:longint);
begin
  oBtrTable.FieldByName('RpaCod').AsInteger := pValue;
end;

function TScvdocBtr.ReadMsgNam:Str30;
begin
  Result := oBtrTable.FieldByName('MsgNam').AsString;
end;

procedure TScvdocBtr.WriteMsgNam(pValue:Str30);
begin
  oBtrTable.FieldByName('MsgNam').AsString := pValue;
end;

function TScvdocBtr.ReadMsgCod:Str10;
begin
  Result := oBtrTable.FieldByName('MsgCod').AsString;
end;

procedure TScvdocBtr.WriteMsgCod(pValue:Str10);
begin
  oBtrTable.FieldByName('MsgCod').AsString := pValue;
end;

function TScvdocBtr.ReadMsgMod:Str20;
begin
  Result := oBtrTable.FieldByName('MsgMod').AsString;
end;

procedure TScvdocBtr.WriteMsgMod(pValue:Str20);
begin
  oBtrTable.FieldByName('MsgMod').AsString := pValue;
end;

function TScvdocBtr.ReadMsgDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('MsgDat').AsDateTime;
end;

procedure TScvdocBtr.WriteMsgDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('MsgDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadRetNam:Str30;
begin
  Result := oBtrTable.FieldByName('RetNam').AsString;
end;

procedure TScvdocBtr.WriteRetNam(pValue:Str30);
begin
  oBtrTable.FieldByName('RetNam').AsString := pValue;
end;

function TScvdocBtr.ReadRetCus:Str30;
begin
  Result := oBtrTable.FieldByName('RetCus').AsString;
end;

procedure TScvdocBtr.WriteRetCus(pValue:Str30);
begin
  oBtrTable.FieldByName('RetCus').AsString := pValue;
end;

function TScvdocBtr.ReadRetIdn:Str10;
begin
  Result := oBtrTable.FieldByName('RetIdn').AsString;
end;

procedure TScvdocBtr.WriteRetIdn(pValue:Str10);
begin
  oBtrTable.FieldByName('RetIdn').AsString := pValue;
end;

function TScvdocBtr.ReadRetDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('RetDat').AsDateTime;
end;

procedure TScvdocBtr.WriteRetDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RetDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadRetBad:byte;
begin
  Result := oBtrTable.FieldByName('RetBad').AsInteger;
end;

procedure TScvdocBtr.WriteRetBad(pValue:byte);
begin
  oBtrTable.FieldByName('RetBad').AsInteger := pValue;
end;

function TScvdocBtr.ReadRetTyp:byte;
begin
  Result := oBtrTable.FieldByName('RetTyp').AsInteger;
end;

procedure TScvdocBtr.WriteRetTyp(pValue:byte);
begin
  oBtrTable.FieldByName('RetTyp').AsInteger := pValue;
end;

function TScvdocBtr.ReadClsNam:Str30;
begin
  Result := oBtrTable.FieldByName('ClsNam').AsString;
end;

procedure TScvdocBtr.WriteClsNam(pValue:Str30);
begin
  oBtrTable.FieldByName('ClsNam').AsString := pValue;
end;

function TScvdocBtr.ReadClsDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ClsDat').AsDateTime;
end;

procedure TScvdocBtr.WriteClsDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ClsDat').AsDateTime := pValue;
end;

function TScvdocBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TScvdocBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TScvdocBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TScvdocBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TScvdocBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TScvdocBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TScvdocBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TScvdocBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TScvdocBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TScvdocBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TScvdocBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TScvdocBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TScvdocBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TScvdocBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TScvdocBtr.ReadDdsVal:double;
begin
  Result := oBtrTable.FieldByName('DdsVal').AsFloat;
end;

procedure TScvdocBtr.WriteDdsVal(pValue:double);
begin
  oBtrTable.FieldByName('DdsVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadHdsVal:double;
begin
  Result := oBtrTable.FieldByName('HdsVal').AsFloat;
end;

procedure TScvdocBtr.WriteHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('HdsVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TScvdocBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TScvdocBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TScvdocBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TScvdocBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TScvdocBtr.ReadDgnVal:double;
begin
  Result := oBtrTable.FieldByName('DgnVal').AsFloat;
end;

procedure TScvdocBtr.WriteDgnVal(pValue:double);
begin
  oBtrTable.FieldByName('DgnVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadEstVal:double;
begin
  Result := oBtrTable.FieldByName('EstVal').AsFloat;
end;

procedure TScvdocBtr.WriteEstVal(pValue:double);
begin
  oBtrTable.FieldByName('EstVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadMaxVal:double;
begin
  Result := oBtrTable.FieldByName('MaxVal').AsFloat;
end;

procedure TScvdocBtr.WriteMaxVal(pValue:double);
begin
  oBtrTable.FieldByName('MaxVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadAdvVal:double;
begin
  Result := oBtrTable.FieldByName('AdvVal').AsFloat;
end;

procedure TScvdocBtr.WriteAdvVal(pValue:double);
begin
  oBtrTable.FieldByName('AdvVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadMatVal:double;
begin
  Result := oBtrTable.FieldByName('MatVal').AsFloat;
end;

procedure TScvdocBtr.WriteMatVal(pValue:double);
begin
  oBtrTable.FieldByName('MatVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadSrvVal:double;
begin
  Result := oBtrTable.FieldByName('SrvVal').AsFloat;
end;

procedure TScvdocBtr.WriteSrvVal(pValue:double);
begin
  oBtrTable.FieldByName('SrvVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadGrtVal:double;
begin
  Result := oBtrTable.FieldByName('GrtVal').AsFloat;
end;

procedure TScvdocBtr.WriteGrtVal(pValue:double);
begin
  oBtrTable.FieldByName('GrtVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadAftVal:double;
begin
  Result := oBtrTable.FieldByName('AftVal').AsFloat;
end;

procedure TScvdocBtr.WriteAftVal(pValue:double);
begin
  oBtrTable.FieldByName('AftVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TScvdocBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadDvzNam:Str3;
begin
  Result := oBtrTable.FieldByName('DvzNam').AsString;
end;

procedure TScvdocBtr.WriteDvzNam(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzNam').AsString := pValue;
end;

function TScvdocBtr.ReadCourse:double;
begin
  Result := oBtrTable.FieldByName('Course').AsFloat;
end;

procedure TScvdocBtr.WriteCourse(pValue:double);
begin
  oBtrTable.FieldByName('Course').AsFloat := pValue;
end;

function TScvdocBtr.ReadFgaVal:double;
begin
  Result := oBtrTable.FieldByName('FgaVal').AsFloat;
end;

procedure TScvdocBtr.WriteFgaVal(pValue:double);
begin
  oBtrTable.FieldByName('FgaVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadFgbVal:double;
begin
  Result := oBtrTable.FieldByName('FgbVal').AsFloat;
end;

procedure TScvdocBtr.WriteFgbVal(pValue:double);
begin
  oBtrTable.FieldByName('FgbVal').AsFloat := pValue;
end;

function TScvdocBtr.ReadDlrCod:word;
begin
  Result := oBtrTable.FieldByName('DlrCod').AsInteger;
end;

procedure TScvdocBtr.WriteDlrCod(pValue:word);
begin
  oBtrTable.FieldByName('DlrCod').AsInteger := pValue;
end;

function TScvdocBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TScvdocBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TScvdocBtr.ReadSpvNum:Str12;
begin
  Result := oBtrTable.FieldByName('SpvNum').AsString;
end;

procedure TScvdocBtr.WriteSpvNum(pValue:Str12);
begin
  oBtrTable.FieldByName('SpvNum').AsString := pValue;
end;

function TScvdocBtr.ReadCldNum:Str12;
begin
  Result := oBtrTable.FieldByName('CldNum').AsString;
end;

procedure TScvdocBtr.WriteCldNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CldNum').AsString := pValue;
end;

function TScvdocBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TScvdocBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TScvdocBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TScvdocBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TScvdocBtr.ReadAgiQnt:word;
begin
  Result := oBtrTable.FieldByName('AgiQnt').AsInteger;
end;

procedure TScvdocBtr.WriteAgiQnt(pValue:word);
begin
  oBtrTable.FieldByName('AgiQnt').AsInteger := pValue;
end;

function TScvdocBtr.ReadGgiQnt:word;
begin
  Result := oBtrTable.FieldByName('GgiQnt').AsInteger;
end;

procedure TScvdocBtr.WriteGgiQnt(pValue:word);
begin
  oBtrTable.FieldByName('GgiQnt').AsInteger := pValue;
end;

function TScvdocBtr.ReadAgsQnt:word;
begin
  Result := oBtrTable.FieldByName('AgsQnt').AsInteger;
end;

procedure TScvdocBtr.WriteAgsQnt(pValue:word);
begin
  oBtrTable.FieldByName('AgsQnt').AsInteger := pValue;
end;

function TScvdocBtr.ReadGgsQnt:word;
begin
  Result := oBtrTable.FieldByName('GgsQnt').AsInteger;
end;

procedure TScvdocBtr.WriteGgsQnt(pValue:word);
begin
  oBtrTable.FieldByName('GgsQnt').AsInteger := pValue;
end;

function TScvdocBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TScvdocBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TScvdocBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TScvdocBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TScvdocBtr.ReadGrtDoc:Str12;
begin
  Result := oBtrTable.FieldByName('GrtDoc').AsString;
end;

procedure TScvdocBtr.WriteGrtDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('GrtDoc').AsString := pValue;
end;

function TScvdocBtr.ReadMndNam:Str30;
begin
  Result := oBtrTable.FieldByName('MndNam').AsString;
end;

procedure TScvdocBtr.WriteMndNam(pValue:Str30);
begin
  oBtrTable.FieldByName('MndNam').AsString := pValue;
end;

function TScvdocBtr.ReadIpaCod:longint;
begin
  Result := oBtrTable.FieldByName('IpaCod').AsInteger;
end;

procedure TScvdocBtr.WriteIpaCod(pValue:longint);
begin
  oBtrTable.FieldByName('IpaCod').AsInteger := pValue;
end;

function TScvdocBtr.ReadSrvTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('SrvTim').AsDateTime;
end;

procedure TScvdocBtr.WriteSrvTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SrvTim').AsDateTime := pValue;
end;

function TScvdocBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TScvdocBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TScvdocBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TScvdocBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TScvdocBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TScvdocBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TScvdocBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TScvdocBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TScvdocBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TScvdocBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TScvdocBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TScvdocBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScvdocBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvdocBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TScvdocBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvdocBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TScvdocBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TScvdocBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TScvdocBtr.LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TScvdocBtr.LocateEquNum (pEquNum:Str20):boolean;
begin
  SetIndex (ixEquNum);
  Result := oBtrTable.FindKey([pEquNum]);
end;

function TScvdocBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TScvdocBtr.LocateEnDn (pEquNum:Str20;pDocNum:Str12):boolean;
begin
  SetIndex (ixEnDn);
  Result := oBtrTable.FindKey([pEquNum,pDocNum]);
end;

function TScvdocBtr.LocateParCod (pParCod:longint):boolean;
begin
  SetIndex (ixParCod);
  Result := oBtrTable.FindKey([pParCod]);
end;

function TScvdocBtr.LocateParNam (pParNam_:Str100):boolean;
begin
  SetIndex (ixParNam);
  Result := oBtrTable.FindKey([StrToAlias(pParNam_)]);
end;

function TScvdocBtr.NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TScvdocBtr.NearestEquNum (pEquNum:Str20):boolean;
begin
  SetIndex (ixEquNum);
  Result := oBtrTable.FindNearest([pEquNum]);
end;

function TScvdocBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TScvdocBtr.NearestEnDn (pEquNum:Str20;pDocNum:Str12):boolean;
begin
  SetIndex (ixEnDn);
  Result := oBtrTable.FindNearest([pEquNum,pDocNum]);
end;

function TScvdocBtr.NearestParCod (pParCod:longint):boolean;
begin
  SetIndex (ixParCod);
  Result := oBtrTable.FindNearest([pParCod]);
end;

function TScvdocBtr.NearestParNam (pParNam_:Str100):boolean;
begin
  SetIndex (ixParNam);
  Result := oBtrTable.FindNearest([pParNam_]);
end;

procedure TScvdocBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TScvdocBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TScvdocBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TScvdocBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TScvdocBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TScvdocBtr.First;
begin
  oBtrTable.First;
end;

procedure TScvdocBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TScvdocBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TScvdocBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TScvdocBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TScvdocBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TScvdocBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TScvdocBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TScvdocBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TScvdocBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TScvdocBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TScvdocBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1916001}
