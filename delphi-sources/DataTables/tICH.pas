unit tICH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnAsAa='';
  ixDocNum='DocNum';
  ixSerNum='SerNum';
  ixAsDn='AsDn';
  ixExtNum='ExtNum';
  ixDocDate='DocDate';
  ixPaCode='PaCode';
  ixPaName_='PaName_';
  ixOcdNum='OcdNum';
  ixSndDate='SndDate';
  ixExpDate='ExpDate';
  ixAcBValue='AcBValue';
  ixFgBValue='FgBValue';
  ixFgPayVal='FgPayVal';
  ixFgEndVal='FgEndVal';
  ixDstPair='DstPair';
  ixPaDp='PaDp';
  ixSended='Sended';
  ixDstAcc='DstAcc';
  ixSpMark='SpMark';
  ixFgDvzName='FgDvzName';
  ixIodNum='IodNum';

type
  TIchTmp=class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMyConto:Str30;         procedure WriteMyConto (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegStn:Str30;          procedure WriteRegStn (pValue:Str30);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadPayMode:byte;          procedure WritePayMode (pValue:byte);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str60;         procedure WriteWpaName (pValue:Str60);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaStn:Str30;          procedure WriteWpaStn (pValue:Str30);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadTrsCode:Str3;          procedure WriteTrsCode (pValue:Str3);
    function  ReadTrsName:Str20;         procedure WriteTrsName (pValue:Str20);
    function  ReadRspName:Str20;         procedure WriteRspName (pValue:Str20);
    function  ReadIcFacDay:word;         procedure WriteIcFacDay (pValue:word);
    function  ReadIcFacPrc:double;       procedure WriteIcFacPrc (pValue:double);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPValue:double;       procedure WriteAcPValue (pValue:double);
    function  ReadAcPrvPay:double;       procedure WriteAcPrvPay (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcApyVal:double;       procedure WriteAcApyVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadAcAenVal:double;       procedure WriteAcAenVal (pValue:double);
    function  ReadAcAValue1:double;      procedure WriteAcAValue1 (pValue:double);
    function  ReadAcAValue2:double;      procedure WriteAcAValue2 (pValue:double);
    function  ReadAcAValue3:double;      procedure WriteAcAValue3 (pValue:double);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcBValue1:double;      procedure WriteAcBValue1 (pValue:double);
    function  ReadAcBValue2:double;      procedure WriteAcBValue2 (pValue:double);
    function  ReadAcBValue3:double;      procedure WriteAcBValue3 (pValue:double);
    function  ReadAcBValue4:double;      procedure WriteAcBValue4 (pValue:double);
    function  ReadAcBValue5:double;      procedure WriteAcBValue5 (pValue:double);
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDBValue:double;      procedure WriteFgDBValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgDscBVal:double;      procedure WriteFgDscBVal (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgPValue:double;       procedure WriteFgPValue (pValue:double);
    function  ReadFgPrvPay:double;       procedure WriteFgPrvPay (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgApyVal:double;       procedure WriteFgApyVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgAenVal:double;       procedure WriteFgAenVal (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgAValue4:double;      procedure WriteFgAValue4 (pValue:double);
    function  ReadFgAValue5:double;      procedure WriteFgAValue5 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadFgBValue4:double;      procedure WriteFgBValue4 (pValue:double);
    function  ReadFgBValue5:double;      procedure WriteFgBValue5 (pValue:double);
    function  ReadFgVatVal1:double;      procedure WriteFgVatVal1 (pValue:double);
    function  ReadFgVatVal2:double;      procedure WriteFgVatVal2 (pValue:double);
    function  ReadFgVatVal3:double;      procedure WriteFgVatVal3 (pValue:double);
    function  ReadFgVatVal4:double;      procedure WriteFgVatVal4 (pValue:double);
    function  ReadFgVatVal5:double;      procedure WriteFgVatVal5 (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgDuoInf:Str100;       procedure WriteFgDuoInf (pValue:Str100);
    function  ReadExpDay:word;           procedure WriteExpDay (pValue:word);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
    function  ReadRcvName:Str30;         procedure WriteRcvName (pValue:Str30);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadTcdNum:Str15;          procedure WriteTcdNum (pValue:Str15);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstPair:Str1;          procedure WriteDstPair (pValue:Str1);
    function  ReadDstPay:byte;           procedure WriteDstPay (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadVatDis:byte;           procedure WriteVatDis (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadDocSnt:Str3;           procedure WriteDocSnt (pValue:Str3);
    function  ReadDocAnl:Str6;           procedure WriteDocAnl (pValue:Str6);
    function  ReadCrcVal:double;         procedure WriteCrcVal (pValue:double);
    function  ReadCrCard:Str20;          procedure WriteCrCard (pValue:Str20);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadCsgNum:Str15;          procedure WriteCsgNum (pValue:Str15);
    function  ReadEmlDate:TDatetime;     procedure WriteEmlDate (pValue:TDatetime);
    function  ReadEmlAddr:Str30;         procedure WriteEmlAddr (pValue:Str30);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadIodNum:Str12;          procedure WriteIodNum (pValue:Str12);
    function  ReadIoeNum:Str12;          procedure WriteIoeNum (pValue:Str12);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadQntSum:double;         procedure WriteQntSum (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDnAsAa (pDocNum:Str12;pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateAsDn (pAccSnt:Str3;pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateSndDate (pSndDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateFgPayVal (pFgPayVal:double):boolean;
    function LocateFgEndVal (pFgEndVal:double):boolean;
    function LocateDstPair (pDstPair:Str1):boolean;
    function LocatePaDp (pPaCode:longint;pDstPay:byte):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateSpMark (pSpMark:Str10):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateIodNum (pIodNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MyConto:Str30 read ReadMyConto write WriteMyConto;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegStn:Str30 read ReadRegStn write WriteRegStn;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property PayMode:byte read ReadPayMode write WritePayMode;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str60 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaStn:Str30 read ReadWpaStn write WriteWpaStn;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property TrsCode:Str3 read ReadTrsCode write WriteTrsCode;
    property TrsName:Str20 read ReadTrsName write WriteTrsName;
    property RspName:Str20 read ReadRspName write WriteRspName;
    property IcFacDay:word read ReadIcFacDay write WriteIcFacDay;
    property IcFacPrc:double read ReadIcFacPrc write WriteIcFacPrc;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPValue:double read ReadAcPValue write WriteAcPValue;
    property AcPrvPay:double read ReadAcPrvPay write WriteAcPrvPay;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcApyVal:double read ReadAcApyVal write WriteAcApyVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property AcAenVal:double read ReadAcAenVal write WriteAcAenVal;
    property AcAValue1:double read ReadAcAValue1 write WriteAcAValue1;
    property AcAValue2:double read ReadAcAValue2 write WriteAcAValue2;
    property AcAValue3:double read ReadAcAValue3 write WriteAcAValue3;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcBValue1:double read ReadAcBValue1 write WriteAcBValue1;
    property AcBValue2:double read ReadAcBValue2 write WriteAcBValue2;
    property AcBValue3:double read ReadAcBValue3 write WriteAcBValue3;
    property AcBValue4:double read ReadAcBValue4 write WriteAcBValue4;
    property AcBValue5:double read ReadAcBValue5 write WriteAcBValue5;
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDBValue:double read ReadFgDBValue write WriteFgDBValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgDscBVal:double read ReadFgDscBVal write WriteFgDscBVal;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgPValue:double read ReadFgPValue write WriteFgPValue;
    property FgPrvPay:double read ReadFgPrvPay write WriteFgPrvPay;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgApyVal:double read ReadFgApyVal write WriteFgApyVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgAenVal:double read ReadFgAenVal write WriteFgAenVal;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgAValue4:double read ReadFgAValue4 write WriteFgAValue4;
    property FgAValue5:double read ReadFgAValue5 write WriteFgAValue5;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property FgBValue4:double read ReadFgBValue4 write WriteFgBValue4;
    property FgBValue5:double read ReadFgBValue5 write WriteFgBValue5;
    property FgVatVal1:double read ReadFgVatVal1 write WriteFgVatVal1;
    property FgVatVal2:double read ReadFgVatVal2 write WriteFgVatVal2;
    property FgVatVal3:double read ReadFgVatVal3 write WriteFgVatVal3;
    property FgVatVal4:double read ReadFgVatVal4 write WriteFgVatVal4;
    property FgVatVal5:double read ReadFgVatVal5 write WriteFgVatVal5;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgDuoInf:Str100 read ReadFgDuoInf write WriteFgDuoInf;
    property ExpDay:word read ReadExpDay write WriteExpDay;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property RcvName:Str30 read ReadRcvName write WriteRcvName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property TcdNum:Str15 read ReadTcdNum write WriteTcdNum;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstPair:Str1 read ReadDstPair write WriteDstPair;
    property DstPay:byte read ReadDstPay write WriteDstPay;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property VatDis:byte read ReadVatDis write WriteVatDis;
    property Sended:boolean read ReadSended write WriteSended;
    property DocSnt:Str3 read ReadDocSnt write WriteDocSnt;
    property DocAnl:Str6 read ReadDocAnl write WriteDocAnl;
    property CrcVal:double read ReadCrcVal write WriteCrcVal;
    property CrCard:Str20 read ReadCrCard write WriteCrCard;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property CsgNum:Str15 read ReadCsgNum write WriteCsgNum;
    property EmlDate:TDatetime read ReadEmlDate write WriteEmlDate;
    property EmlAddr:Str30 read ReadEmlAddr write WriteEmlAddr;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property IodNum:Str12 read ReadIodNum write WriteIodNum;
    property IoeNum:Str12 read ReadIoeNum write WriteIoeNum;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property QntSum:double read ReadQntSum write WriteQntSum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIchTmp.Create;
begin
  oTmpTable := TmpInit ('ICH',Self);
end;

destructor TIchTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIchTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIchTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIchTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIchTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TIchTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TIchTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIchTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TIchTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIchTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TIchTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TIchTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TIchTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIchTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIchTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIchTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TIchTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TIchTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIchTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIchTmp.ReadSndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SndDate').AsDateTime;
end;

procedure TIchTmp.WriteSndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TIchTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TIchTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TIchTmp.ReadVatDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('VatDate').AsDateTime;
end;

procedure TIchTmp.WriteVatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TIchTmp.ReadPayDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TIchTmp.WritePayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TIchTmp.ReadCsyCode:Str4;
begin
  Result := oTmpTable.FieldByName('CsyCode').AsString;
end;

procedure TIchTmp.WriteCsyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('CsyCode').AsString := pValue;
end;

function TIchTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIchTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIchTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIchTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIchTmp.ReadMyConto:Str30;
begin
  Result := oTmpTable.FieldByName('MyConto').AsString;
end;

procedure TIchTmp.WriteMyConto(pValue:Str30);
begin
  oTmpTable.FieldByName('MyConto').AsString := pValue;
end;

function TIchTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIchTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIchTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TIchTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TIchTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TIchTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TIchTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TIchTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TIchTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TIchTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TIchTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TIchTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TIchTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TIchTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TIchTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TIchTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TIchTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TIchTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TIchTmp.ReadRegStn:Str30;
begin
  Result := oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TIchTmp.WriteRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString := pValue;
end;

function TIchTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TIchTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TIchTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TIchTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TIchTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TIchTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TIchTmp.ReadPayMode:byte;
begin
  Result := oTmpTable.FieldByName('PayMode').AsInteger;
end;

procedure TIchTmp.WritePayMode(pValue:byte);
begin
  oTmpTable.FieldByName('PayMode').AsInteger := pValue;
end;

function TIchTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TIchTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TIchTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TIchTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TIchTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TIchTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TIchTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TIchTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TIchTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TIchTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TIchTmp.ReadWpaStn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaStn').AsString;
end;

procedure TIchTmp.WriteWpaStn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaStn').AsString := pValue;
end;

function TIchTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TIchTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TIchTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TIchTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TIchTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TIchTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TIchTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TIchTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TIchTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TIchTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TIchTmp.ReadRspName:Str20;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TIchTmp.WriteRspName(pValue:Str20);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TIchTmp.ReadIcFacDay:word;
begin
  Result := oTmpTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TIchTmp.WriteIcFacDay(pValue:word);
begin
  oTmpTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TIchTmp.ReadIcFacPrc:double;
begin
  Result := oTmpTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TIchTmp.WriteIcFacPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TIchTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TIchTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TIchTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TIchTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TIchTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIchTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TIchTmp.ReadHdsPrc:double;
begin
  Result := oTmpTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TIchTmp.WriteHdsPrc(pValue:double);
begin
  oTmpTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TIchTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIchTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TIchTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIchTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TIchTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIchTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TIchTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIchTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TIchTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIchTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TIchTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TIchTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TIchTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIchTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TIchTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIchTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TIchTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIchTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TIchTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIchTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIchTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIchTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIchTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIchTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIchTmp.ReadAcPValue:double;
begin
  Result := oTmpTable.FieldByName('AcPValue').AsFloat;
end;

procedure TIchTmp.WriteAcPValue(pValue:double);
begin
  oTmpTable.FieldByName('AcPValue').AsFloat := pValue;
end;

function TIchTmp.ReadAcPrvPay:double;
begin
  Result := oTmpTable.FieldByName('AcPrvPay').AsFloat;
end;

procedure TIchTmp.WriteAcPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('AcPrvPay').AsFloat := pValue;
end;

function TIchTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TIchTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TIchTmp.ReadAcApyVal:double;
begin
  Result := oTmpTable.FieldByName('AcApyVal').AsFloat;
end;

procedure TIchTmp.WriteAcApyVal(pValue:double);
begin
  oTmpTable.FieldByName('AcApyVal').AsFloat := pValue;
end;

function TIchTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TIchTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TIchTmp.ReadAcAenVal:double;
begin
  Result := oTmpTable.FieldByName('AcAenVal').AsFloat;
end;

procedure TIchTmp.WriteAcAenVal(pValue:double);
begin
  oTmpTable.FieldByName('AcAenVal').AsFloat := pValue;
end;

function TIchTmp.ReadAcAValue1:double;
begin
  Result := oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TIchTmp.WriteAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TIchTmp.ReadAcAValue2:double;
begin
  Result := oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TIchTmp.WriteAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TIchTmp.ReadAcAValue3:double;
begin
  Result := oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TIchTmp.WriteAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TIchTmp.ReadAcAValue4:double;
begin
  Result := oTmpTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TIchTmp.WriteAcAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TIchTmp.ReadAcAValue5:double;
begin
  Result := oTmpTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TIchTmp.WriteAcAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TIchTmp.ReadAcBValue1:double;
begin
  Result := oTmpTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TIchTmp.WriteAcBValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TIchTmp.ReadAcBValue2:double;
begin
  Result := oTmpTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TIchTmp.WriteAcBValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TIchTmp.ReadAcBValue3:double;
begin
  Result := oTmpTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TIchTmp.WriteAcBValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TIchTmp.ReadAcBValue4:double;
begin
  Result := oTmpTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TIchTmp.WriteAcBValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TIchTmp.ReadAcBValue5:double;
begin
  Result := oTmpTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TIchTmp.WriteAcBValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TIchTmp.ReadAcRndVat:double;
begin
  Result := oTmpTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TIchTmp.WriteAcRndVat(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TIchTmp.ReadAcRndVal:double;
begin
  Result := oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TIchTmp.WriteAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TIchTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TIchTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIchTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIchTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIchTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TIchTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIchTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TIchTmp.ReadFgDBValue:double;
begin
  Result := oTmpTable.FieldByName('FgDBValue').AsFloat;
end;

procedure TIchTmp.WriteFgDBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDBValue').AsFloat := pValue;
end;

function TIchTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIchTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgDscBVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TIchTmp.WriteFgDscBVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscBVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgHdsVal:double;
begin
  Result := oTmpTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TIchTmp.WriteFgHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TIchTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TIchTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TIchTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TIchTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TIchTmp.ReadFgPValue:double;
begin
  Result := oTmpTable.FieldByName('FgPValue').AsFloat;
end;

procedure TIchTmp.WriteFgPValue(pValue:double);
begin
  oTmpTable.FieldByName('FgPValue').AsFloat := pValue;
end;

function TIchTmp.ReadFgPrvPay:double;
begin
  Result := oTmpTable.FieldByName('FgPrvPay').AsFloat;
end;

procedure TIchTmp.WriteFgPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('FgPrvPay').AsFloat := pValue;
end;

function TIchTmp.ReadFgPayVal:double;
begin
  Result := oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TIchTmp.WriteFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgApyVal:double;
begin
  Result := oTmpTable.FieldByName('FgApyVal').AsFloat;
end;

procedure TIchTmp.WriteFgApyVal(pValue:double);
begin
  oTmpTable.FieldByName('FgApyVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgEndVal:double;
begin
  Result := oTmpTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TIchTmp.WriteFgEndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgAenVal:double;
begin
  Result := oTmpTable.FieldByName('FgAenVal').AsFloat;
end;

procedure TIchTmp.WriteFgAenVal(pValue:double);
begin
  oTmpTable.FieldByName('FgAenVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgAValue1:double;
begin
  Result := oTmpTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TIchTmp.WriteFgAValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TIchTmp.ReadFgAValue2:double;
begin
  Result := oTmpTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TIchTmp.WriteFgAValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TIchTmp.ReadFgAValue3:double;
begin
  Result := oTmpTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TIchTmp.WriteFgAValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TIchTmp.ReadFgAValue4:double;
begin
  Result := oTmpTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TIchTmp.WriteFgAValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue4').AsFloat := pValue;
end;

function TIchTmp.ReadFgAValue5:double;
begin
  Result := oTmpTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TIchTmp.WriteFgAValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue5').AsFloat := pValue;
end;

function TIchTmp.ReadFgBValue1:double;
begin
  Result := oTmpTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TIchTmp.WriteFgBValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TIchTmp.ReadFgBValue2:double;
begin
  Result := oTmpTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TIchTmp.WriteFgBValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TIchTmp.ReadFgBValue3:double;
begin
  Result := oTmpTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TIchTmp.WriteFgBValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TIchTmp.ReadFgBValue4:double;
begin
  Result := oTmpTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TIchTmp.WriteFgBValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TIchTmp.ReadFgBValue5:double;
begin
  Result := oTmpTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TIchTmp.WriteFgBValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

function TIchTmp.ReadFgVatVal1:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal1').AsFloat;
end;

procedure TIchTmp.WriteFgVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal1').AsFloat := pValue;
end;

function TIchTmp.ReadFgVatVal2:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal2').AsFloat;
end;

procedure TIchTmp.WriteFgVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal2').AsFloat := pValue;
end;

function TIchTmp.ReadFgVatVal3:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal3').AsFloat;
end;

procedure TIchTmp.WriteFgVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal3').AsFloat := pValue;
end;

function TIchTmp.ReadFgVatVal4:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal4').AsFloat;
end;

procedure TIchTmp.WriteFgVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal4').AsFloat := pValue;
end;

function TIchTmp.ReadFgVatVal5:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal5').AsFloat;
end;

procedure TIchTmp.WriteFgVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal5').AsFloat := pValue;
end;

function TIchTmp.ReadFgRndVat:double;
begin
  Result := oTmpTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TIchTmp.WriteFgRndVat(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TIchTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TIchTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TIchTmp.ReadFgDuoInf:Str100;
begin
  Result := oTmpTable.FieldByName('FgDuoInf').AsString;
end;

procedure TIchTmp.WriteFgDuoInf(pValue:Str100);
begin
  oTmpTable.FieldByName('FgDuoInf').AsString := pValue;
end;

function TIchTmp.ReadExpDay:word;
begin
  Result := oTmpTable.FieldByName('ExpDay').AsInteger;
end;

procedure TIchTmp.WriteExpDay(pValue:word);
begin
  oTmpTable.FieldByName('ExpDay').AsInteger := pValue;
end;

function TIchTmp.ReadEyCourse:double;
begin
  Result := oTmpTable.FieldByName('EyCourse').AsFloat;
end;

procedure TIchTmp.WriteEyCourse(pValue:double);
begin
  oTmpTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TIchTmp.ReadEyCrdVal:double;
begin
  Result := oTmpTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TIchTmp.WriteEyCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TIchTmp.ReadRcvName:Str30;
begin
  Result := oTmpTable.FieldByName('RcvName').AsString;
end;

procedure TIchTmp.WriteRcvName(pValue:Str30);
begin
  oTmpTable.FieldByName('RcvName').AsString := pValue;
end;

function TIchTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TIchTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TIchTmp.ReadSteCode:word;
begin
  Result := oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TIchTmp.WriteSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TIchTmp.ReadCusCard:Str20;
begin
  Result := oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TIchTmp.WriteCusCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCard').AsString := pValue;
end;

function TIchTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIchTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TIchTmp.ReadVatCls:byte;
begin
  Result := oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TIchTmp.WriteVatCls(pValue:byte);
begin
  oTmpTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TIchTmp.ReadDocSpc:byte;
begin
  Result := oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIchTmp.WriteDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TIchTmp.ReadTcdNum:Str15;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TIchTmp.WriteTcdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TIchTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIchTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TIchTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIchTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TIchTmp.ReadDstPair:Str1;
begin
  Result := oTmpTable.FieldByName('DstPair').AsString;
end;

procedure TIchTmp.WriteDstPair(pValue:Str1);
begin
  oTmpTable.FieldByName('DstPair').AsString := pValue;
end;

function TIchTmp.ReadDstPay:byte;
begin
  Result := oTmpTable.FieldByName('DstPay').AsInteger;
end;

procedure TIchTmp.WriteDstPay(pValue:byte);
begin
  oTmpTable.FieldByName('DstPay').AsInteger := pValue;
end;

function TIchTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TIchTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TIchTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TIchTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TIchTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TIchTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TIchTmp.ReadVatDis:byte;
begin
  Result := oTmpTable.FieldByName('VatDis').AsInteger;
end;

procedure TIchTmp.WriteVatDis(pValue:byte);
begin
  oTmpTable.FieldByName('VatDis').AsInteger := pValue;
end;

function TIchTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TIchTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TIchTmp.ReadDocSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TIchTmp.WriteDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString := pValue;
end;

function TIchTmp.ReadDocAnl:Str6;
begin
  Result := oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TIchTmp.WriteDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString := pValue;
end;

function TIchTmp.ReadCrcVal:double;
begin
  Result := oTmpTable.FieldByName('CrcVal').AsFloat;
end;

procedure TIchTmp.WriteCrcVal(pValue:double);
begin
  oTmpTable.FieldByName('CrcVal').AsFloat := pValue;
end;

function TIchTmp.ReadCrCard:Str20;
begin
  Result := oTmpTable.FieldByName('CrCard').AsString;
end;

procedure TIchTmp.WriteCrCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CrCard').AsString := pValue;
end;

function TIchTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TIchTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TIchTmp.ReadBonNum:byte;
begin
  Result := oTmpTable.FieldByName('BonNum').AsInteger;
end;

procedure TIchTmp.WriteBonNum(pValue:byte);
begin
  oTmpTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TIchTmp.ReadSndNum:word;
begin
  Result := oTmpTable.FieldByName('SndNum').AsInteger;
end;

procedure TIchTmp.WriteSndNum(pValue:word);
begin
  oTmpTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TIchTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIchTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIchTmp.ReadWrnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIchTmp.WriteWrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIchTmp.ReadCsgNum:Str15;
begin
  Result := oTmpTable.FieldByName('CsgNum').AsString;
end;

procedure TIchTmp.WriteCsgNum(pValue:Str15);
begin
  oTmpTable.FieldByName('CsgNum').AsString := pValue;
end;

function TIchTmp.ReadEmlDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmlDate').AsDateTime;
end;

procedure TIchTmp.WriteEmlDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmlDate').AsDateTime := pValue;
end;

function TIchTmp.ReadEmlAddr:Str30;
begin
  Result := oTmpTable.FieldByName('EmlAddr').AsString;
end;

procedure TIchTmp.WriteEmlAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('EmlAddr').AsString := pValue;
end;

function TIchTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TIchTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TIchTmp.ReadPrjCode:Str12;
begin
  Result := oTmpTable.FieldByName('PrjCode').AsString;
end;

procedure TIchTmp.WritePrjCode(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjCode').AsString := pValue;
end;

function TIchTmp.ReadIodNum:Str12;
begin
  Result := oTmpTable.FieldByName('IodNum').AsString;
end;

procedure TIchTmp.WriteIodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IodNum').AsString := pValue;
end;

function TIchTmp.ReadIoeNum:Str12;
begin
  Result := oTmpTable.FieldByName('IoeNum').AsString;
end;

procedure TIchTmp.WriteIoeNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IoeNum').AsString := pValue;
end;

function TIchTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TIchTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
end;

function TIchTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TIchTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TIchTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TIchTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TIchTmp.ReadQntSum:double;
begin
  Result := oTmpTable.FieldByName('QntSum').AsFloat;
end;

procedure TIchTmp.WriteQntSum(pValue:double);
begin
  oTmpTable.FieldByName('QntSum').AsFloat := pValue;
end;

function TIchTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIchTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIchTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIchTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIchTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIchTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIchTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIchTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIchTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIchTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIchTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIchTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIchTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIchTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIchTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIchTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIchTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIchTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIchTmp.LocateDnAsAa (pDocNum:Str12;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixDnAsAa);
  Result := oTmpTable.FindKey([pDocNum,pAccSnt,pAccAnl]);
end;

function TIchTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TIchTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TIchTmp.LocateAsDn (pAccSnt:Str3;pDocNum:Str12):boolean;
begin
  SetIndex (ixAsDn);
  Result := oTmpTable.FindKey([pAccSnt,pDocNum]);
end;

function TIchTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TIchTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TIchTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex(ixPaCode);
  Result:=oTmpTable.FindKey([pPaCode]);
end;

function TIchTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TIchTmp.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oTmpTable.FindKey([pOcdNum]);
end;

function TIchTmp.LocateSndDate (pSndDate:TDatetime):boolean;
begin
  SetIndex (ixSndDate);
  Result := oTmpTable.FindKey([pSndDate]);
end;

function TIchTmp.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oTmpTable.FindKey([pExpDate]);
end;

function TIchTmp.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oTmpTable.FindKey([pAcBValue]);
end;

function TIchTmp.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oTmpTable.FindKey([pFgBValue]);
end;

function TIchTmp.LocateFgPayVal (pFgPayVal:double):boolean;
begin
  SetIndex (ixFgPayVal);
  Result := oTmpTable.FindKey([pFgPayVal]);
end;

function TIchTmp.LocateFgEndVal (pFgEndVal:double):boolean;
begin
  SetIndex (ixFgEndVal);
  Result := oTmpTable.FindKey([pFgEndVal]);
end;

function TIchTmp.LocateDstPair (pDstPair:Str1):boolean;
begin
  SetIndex (ixDstPair);
  Result := oTmpTable.FindKey([pDstPair]);
end;

function TIchTmp.LocatePaDp (pPaCode:longint;pDstPay:byte):boolean;
begin
  SetIndex (ixPaDp);
  Result := oTmpTable.FindKey([pPaCode,pDstPay]);
end;

function TIchTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

function TIchTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

function TIchTmp.LocateSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oTmpTable.FindKey([pSpMark]);
end;

function TIchTmp.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oTmpTable.FindKey([pFgDvzName]);
end;

function TIchTmp.LocateIodNum (pIodNum:Str12):boolean;
begin
  SetIndex (ixIodNum);
  Result := oTmpTable.FindKey([pIodNum]);
end;

procedure TIchTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIchTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIchTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIchTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIchTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIchTmp.First;
begin
  oTmpTable.First;
end;

procedure TIchTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIchTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIchTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIchTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIchTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIchTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIchTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIchTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIchTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIchTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIchTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
