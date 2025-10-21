unit Key;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  StkKey, TesKey, WhsKey,
  SysKey, NesKey, AplKey, GscKey, OsbKey, OcmKey, EmcKey, IcmKey, DirKey, PrmKey, PrbKey,
  CrmKey, CrbKey, KsbKey, ScmKey, XrmKey,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TKey=class (TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oStk:TStkKey;
    oTes:TTesKey;
    oWhs:TWhsKey;

    oSys:TSysKey;
    oNes:TNesKey;
    oGsc:TGscKey;
    oApl:TAplKey;
    oOsb:TOsbKey;
    oEmc:TEmcKey;
    oOcm:TOcmKey;
    oIcm:TIcmKey;
    oDir:TDirKey;
    oPrm:TPrmKey;
    oPrb:TPrbKey;
    oCrb:TCrbKey;
    oKsb:TKsbKey;
    oScm:TScmKey;
    oXrm:TXrmKey;
    function KeyExist (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30):boolean;
    function ReadString (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:Str200):Str200;
    procedure WriteString (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:Str200);
    // SYS
    function ReadRegName:Str60;        procedure WriteRegName(pValue:Str60);
    function ReadRegAddr:Str30;        procedure WriteRegAddr(pValue:Str30);
    function ReadRegZip:Str15;         procedure WriteRegZip(pValue:Str15);
    function ReadRegCty:Str3;          procedure WriteRegCty(pValue:Str3);
    function ReadRegCtn:Str30;         procedure WriteRegCtn(pValue:Str30);
    function ReadRegSta:Str2;          procedure WriteRegSta(pValue:Str2);
    function ReadRegStn:Str30;         procedure WriteRegStn(pValue:Str30);
    function ReadRegRec:Str80;         procedure WriteRegRec(pValue:Str80);
    function ReadRegWeb:Str50;         procedure WriteRegWeb(pValue:Str50);
    function ReadHedName:Str30;        procedure WriteHedName(pValue:Str30);
    function ReadSysFixCrs:double;     procedure WriteSysFixCrs(pValue:double);
    function ReadSysInfDvz:Str3;       procedure WriteSysInfDvz(pValue:Str3);
    function ReadSysAttPat:Str80;      procedure WriteSysAttPat(pValue:Str80);
    function ReadSysAttCpy:boolean;    procedure WriteSysAttCpy(pValue:boolean);
    function ReadSysAccDvz:Str3;       procedure WriteSysAccDvz(pValue:Str3);
    function ReadSysMsuRnd:byte;       procedure WriteSysMsuRnd(pValue:byte);
    function ReadSysMsuFrc:byte;       procedure WriteSysMsuFrc(pValue:byte);
    function ReadSysGsnSrc:byte;       procedure WriteSysGsnSrc(pValue:byte);
    function ReadSysAcvFrc:byte;       procedure WriteSysAcvFrc(pValue:byte);
    function ReadSysFgpFrc:byte;       procedure WriteSysFgpFrc(pValue:byte);
    function ReadSysFgvFrc:byte;       procedure WriteSysFgvFrc(pValue:byte);
    function ReadSysNrdFrc:byte;       procedure WriteSysNrdFrc(pValue:byte);
    function ReadSysFjrSig:boolean;    procedure WriteSysFjrSig(pValue:boolean);
    function ReadSysSpeLev:boolean;    procedure WriteSysSpeLev(pValue:boolean);
    function ReadSysMaxScr:boolean;    procedure WriteSysMaxScr(pValue:boolean);
    function ReadSysPyeAdd:boolean;    procedure WriteSysPyeAdd(pValue:boolean);
    function ReadSysEdiSpc:boolean;    procedure WriteSysEdiSpc(pValue:boolean);
    function ReadSysEdiPce:boolean;    procedure WriteSysEdiPce(pValue:boolean);
//    function ReadSysAdvGsc(pVatGrp:byte):longint;  procedure WriteSysAdvGsc(pVatGrp:byte;pValue:longint);
    function ReadSysAdvGsc:longint;  procedure WriteSysAdvGsc(pValue:longint);
    function ReadSysAdwGsc(pVatGrp:byte):longint;  procedure WriteSysAdwGsc(pVatGrp:byte;pValue:longint);
    function ReadSysAdoGsc:longint;    procedure WriteSysAdoGsc(pValue:longint);
    function ReadSysAdgGsc:longint;    procedure WriteSysAdgGsc(pValue:longint);
    function ReadSysSinVal:double;     procedure WriteSysSinVal(pValue:double);
    function ReadSysAutReg:boolean;    procedure WriteSysAutReg(pValue:boolean);
    function ReadSysAnlReg:boolean;    procedure WriteSysAnlReg(pValue:boolean);
    // HRS - Hotelovy a rezervacny system
    function ReadHrsCrdPor:Str4;       procedure WriteHrsCrdPor(pValue:Str4);
    function ReadHrsCrdBau:Str6;       procedure WriteHrsCrdBau(pValue:Str6);
    function ReadHrsCrdPar:Str1;       procedure WriteHrsCrdPar(pValue:Str1);
    function ReadHrsCrdDat:Str1;       procedure WriteHrsCrdDat(pValue:Str1);
    function ReadHrsCrdStp:Str1;       procedure WriteHrsCrdStp(pValue:Str1);
    function ReadHrsCrdDev:byte;       procedure WriteHrsCrdDev(pValue:byte);
    function ReadHrsCrdHou:byte;       procedure WriteHrsCrdHou(pValue:byte);
    function ReadHrsHeaLog:boolean;    procedure WriteHrsHeaLog(pValue:boolean);
    function ReadHrsEvnPln:boolean;    procedure WriteHrsEvnPln(pValue:boolean);
    function ReadHrsUseTnr:boolean;    procedure WriteHrsUseTnr(pValue:boolean);
    function ReadHrsCrdPrg:boolean;    procedure WriteHrsCrdPrg(pValue:boolean);
    function ReadHrsIncTime:Str5;      procedure WriteHrsIncTime(pValue:Str5);
    function ReadHrsOnitIp:Str15;      procedure WriteHrsOnitIp(pValue:Str15);
    function ReadHrsHeatIp:Str15;      procedure WriteHrsHeatIp(pValue:Str15);
    function ReadHrsHeatPor:Str5;      procedure WriteHrsHeatPor(pValue:Str5);
    function ReadHrsAutNam(pAutName:byte):Str20;  procedure WriteHrsAutNam(pAutName:byte;pValue:Str20);
    function ReadHrsCadFmd:boolean;    procedure WriteHrsCadFmd(pValue:boolean);
    function ReadHrsTcdGen:boolean;    procedure WriteHrsTcdGen(pValue:boolean);
    function ReadHrsStkNum:integer;    procedure WriteHrsStkNum(pValue:integer);
    function ReadHrsWriNum:integer;    procedure WriteHrsWriNum(pValue:integer);
    function ReadHrsCasNum:integer;    procedure WriteHrsCasNum(pValue:integer);
    function ReadHrsEvbTim:integer;    procedure WriteHrsEvbTim(pValue:integer);
    // SHP - E-Shop
    function ReadShpOrdFrm:byte;       procedure WriteShpOrdFrm(pValue:byte);
    // MAR - pre cely odbyt
    function ReadMarNpyIcb:Str200;     procedure WriteMarNpyIcb(pValue:Str200);
    function ReadMarNpiTcb:Str200;     procedure WriteMarNpiTcb(pValue:Str200);
    function ReadMarAdvGsc:longint;    procedure WriteMarAdvGsc(pValue:longint);
    function ReadMarCmpGsc:longint;    procedure WriteMarCmpGsc(pValue:longint);
    // CRD
    function ReadCrdSerNum:longint;    procedure WriteCrdSerNum(pValue:longint);
    function ReadCrdOutNum:longint;    procedure WriteCrdOutNum(pValue:longint);
    function ReadCrdBacFrm:Str15;      procedure WriteCrdBacFrm(pValue:Str15);
    function ReadCrdPabNum:word;       procedure WriteCrdPabNum(pValue:word);
    function ReadCrdTrnBon:double;     procedure WriteCrdTrnBon(pValue:double);
    function ReadCrdTrnDsc:double;     procedure WriteCrdTrnDsc(pValue:double);
    function ReadCrdTrnBci:double;     procedure WriteCrdTrnBci(pValue:double);
    function ReadCrdBonPay:double;     procedure WriteCrdBonPay(pValue:double);
    function ReadCrdDscPrc:double;     procedure WriteCrdDscPrc(pValue:double);
    function ReadCrdCasRef:boolean;    procedure WriteCrdCasRef(pValue:boolean);
    // WRI
    function ReadWriPaCode(pWriNum:word):longint;  procedure WriteWriPaCode(pWriNum:word;pValue:longint);
    function ReadWriOcbNum(pWriNum:word):Str5;     procedure WriteWriOcbNum(pWriNum:word;pValue:Str5);
    // PAB
    function ReadPabNumIno:boolean;    procedure WritePabNumIno(pValue:boolean);
    function ReadPabSrcLic:Str20;      procedure WritePabSrcLic(pValue:Str20);
    // SRB
    function ReadSrbStmCod:Str60;      procedure WriteSrbStmCod(pValue:Str60);
    // DSC
    function ReadDscFgCode:Str60;      procedure WriteDscFgCode(pValue:Str60);
    function ReadDscRefGen:boolean;    procedure WriteDscRefGen(pValue:boolean);
    // BLC
    function ReadBlcPrvYea:boolean;    procedure WriteBlcPrvYea(pValue:boolean);
    // ACC
    function ReadAccAcYear:Str4;    procedure WriteAccAcYear(pValue:Str4);
    // VTR
    function ReadVtrDocCls:boolean;    procedure WriteVtrDocCls(pValue:boolean);
    function ReadVtrMthQnt:byte;       procedure WriteVtrMthQnt(pValue:byte);
    function ReadVtrTaxOff:Str60;      procedure WriteVtrTaxOff(pValue:Str60);
    function ReadVtrAutNam:Str30;      procedure WriteVtrAutNam(pValue:Str30);
    function ReadVtrAutTel:Str15;      procedure WriteVtrAutTel(pValue:Str15);
    function ReadVtrAutEml:Str30;      procedure WriteVtrAutEml(pValue:Str30);
    function ReadVtrRegStr:Str30;      procedure WriteVtrRegStr(pValue:Str30);
    function ReadVtrRegNum:Str10;      procedure WriteVtrRegNum(pValue:Str10);
    function ReadVtrRegStn:Str30;      procedure WriteVtrRegStn(pValue:Str30);
    function ReadVtrRegCtn:Str30;      procedure WriteVtrRegCtn(pValue:Str30);
    function ReadVtrRegZip:Str5;       procedure WriteVtrRegZip(pValue:Str5);
    function ReadVtrRegTel:Str15;      procedure WriteVtrRegTel(pValue:Str15);
    function ReadVtrRegFax:Str15;      procedure WriteVtrRegFax(pValue:Str15);
    function ReadVtrRegEml:Str60;      procedure WriteVtrRegEml(pValue:Str60);
    // PLS
    function ReadPlsSapFrc(pPlsNum:word):byte;        procedure WritePlsSapFrc(pPlsNum:word;pValue:byte);
    function ReadPlsSapRnd(pPlsNum:word):byte;        procedure WritePlsSapRnd(pPlsNum:word;pValue:byte);
    function ReadPlsRefDia(pPlsNum:word):boolean;     procedure WritePlsRefDia(pPlsNum:word;pValue:boolean);
    // STK
    function ReadStpRndFrc:byte;       procedure WriteStpRndFrc(pValue:byte);
    function ReadStqRndFrc:byte;       procedure WriteStqRndFrc(pValue:byte);
    function ReadStvRndFrc:byte;       procedure WriteStvRndFrc(pValue:byte);
    function ReadStkNulPrc:boolean;    procedure WriteStkNulPrc(pValue:boolean);

    function ReadStkScType(pBookNum:Str5):Str1;       procedure WriteStkScType(pBookNum:Str5;pValue:Str1);
    function ReadStkWriNum(pBookNum:Str5):longint;    procedure WriteStkWriNum(pBookNum:Str5;pValue:longint);
    function ReadStkPlsNum(pBookNum:Str5):longint;    procedure WriteStkPlsNum(pBookNum:Str5;pValue:longint);
    function ReadStkShared(pBookNum:Str5):boolean;    procedure WriteStkShared(pBookNum:Str5;pValue:boolean);
    function ReadStkRsvOcd(pBookNum:Str5):boolean;    procedure WriteStkRsvOcd(pBookNum:Str5;pValue:boolean);
    // CMB
    function ReadCmbOnlSub(pBookNum:Str5):boolean;    procedure WriteCmbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadCmbStkNum(pBookNum:Str5):word;       procedure WriteCmbStkNum(pBookNum:Str5;pValue:word);
    function ReadCmbPlsNum(pBookNum:Str5):word;       procedure WriteCmbPlsNum(pBookNum:Str5;pValue:word);
    function ReadCmbSmCode(pBookNum:Str5):word;       procedure WriteCmbSmCode(pBookNum:Str5;pValue:word);
    // Dmb
    function ReadDmbOnlSub(pBookNum:Str5):boolean;    procedure WriteDmbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadDmbStkNuI(pBookNum:Str5):word;       procedure WriteDmbStkNuI(pBookNum:Str5;pValue:word);
    function ReadDmbStkNuO(pBookNum:Str5):word;       procedure WriteDmbStkNuO(pBookNum:Str5;pValue:word);
    function ReadDmbPlsNum(pBookNum:Str5):word;       procedure WriteDmbPlsNum(pBookNum:Str5;pValue:word);
    function ReadDmbSmCodI(pBookNum:Str5):word;       procedure WriteDmbSmCodI(pBookNum:Str5;pValue:word);
    function ReadDmbSmCodO(pBookNum:Str5):word;       procedure WriteDmbSmCodO(pBookNum:Str5;pValue:word);
    // CDB
    function ReadCdbOnlSub(pBookNum:Str5):boolean;    procedure WriteCdbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadCdbStkNuI(pBookNum:Str5):word;       procedure WriteCdbStkNuI(pBookNum:Str5;pValue:word);
    function ReadCdbStkNuO(pBookNum:Str5):word;       procedure WriteCdbStkNuO(pBookNum:Str5;pValue:word);
    function ReadCdbPlsNum(pBookNum:Str5):word;       procedure WriteCdbPlsNum(pBookNum:Str5;pValue:word);
    function ReadCdbSmCodI(pBookNum:Str5):word;       procedure WriteCdbSmCodI(pBookNum:Str5;pValue:word);
    function ReadCdbSmCodO(pBookNum:Str5):word;       procedure WriteCdbSmCodO(pBookNum:Str5;pValue:word);
    function ReadCdbCpiBok(pBookNum:Str5):word;       procedure WriteCdbCpiBok(pBookNum:Str5;pValue:word);
    // IMB
    function ReadImbOnlSub(pBookNum:Str5):boolean;    procedure WriteImbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadImbBpcMod(pBookNum:Str5):boolean;    procedure WriteImbBpcMod(pBookNum:Str5;pValue:boolean);
    function ReadImbSpcMov(pBookNum:Str5):boolean;    procedure WriteImbSpcMov(pBookNum:Str5;pValue:boolean);
    function ReadImbStkNum(pBookNum:Str5):word;       procedure WriteImbStkNum(pBookNum:Str5;pValue:word);
    function ReadImbPlsNum(pBookNum:Str5):word;       procedure WriteImbPlsNum(pBookNum:Str5;pValue:word);
    function ReadImbSmCode(pBookNum:Str5):word;       procedure WriteImbSmCode(pBookNum:Str5;pValue:word);
    function ReadImbAutAcc(pBookNum:Str5):boolean;    procedure WriteImbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadImbFtpRcv(pBookNum:Str5):boolean;    procedure WriteImbFtpRcv(pBookNum:Str5;pValue:boolean);
    function ReadImbDlvDay(pBookNum:Str5):word;       procedure WriteImbDlvDay(pBookNum:Str5;pValue:word);
    // OMB
    function ReadOmbOnlRwd(pBookNum:Str5):boolean;    procedure WriteOmbOnlRwd(pBookNum:Str5;pValue:boolean);
    function ReadOmbOnlSub(pBookNum:Str5):boolean;    procedure WriteOmbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadOmbBpcMod(pBookNum:Str5):boolean;    procedure WriteOmbBpcMod(pBookNum:Str5;pValue:boolean);
    function ReadOmbSpcMov(pBookNum:Str5):boolean;    procedure WriteOmbSpcMov(pBookNum:Str5;pValue:boolean);
    function ReadOmbStkNum(pBookNum:Str5):word;       procedure WriteOmbStkNum(pBookNum:Str5;pValue:word);
    function ReadOmbPlsNum(pBookNum:Str5):word;       procedure WriteOmbPlsNum(pBookNum:Str5;pValue:word);
    function ReadOmbSmCode(pBookNum:Str5):word;       procedure WriteOmbSmCode(pBookNum:Str5;pValue:word);
    function ReadOmbAutAcc(pBookNum:Str5):boolean;    procedure WriteOmbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadOmbFtpSnd(pBookNum:Str5):boolean;    procedure WriteOmbFtpSnd(pBookNum:Str5;pValue:boolean);
    function ReadOmbImbStk(pBookNum:Str5):word;       procedure WriteOmbImbStk(pBookNum:Str5;pValue:word);
    function ReadOmbImbNum(pBookNum:Str5):str5;       procedure WriteOmbImbNum(pBookNum:Str5;pValue:Str5);
    function ReadOmbImbSmc(pBookNum:Str5):word;       procedure WriteOmbImbSmc(pBookNum:Str5;pValue:word);
    // RMB
    function ReadRmbBoYear(pBookNum:Str5):Str4;       procedure WriteRmbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadRmbWriNum(pBookNum:Str5):word;       procedure WriteRmbWriNum(pBookNum:Str5;pValue:word);
    function ReadRmbOutStn(pBookNum:Str5):word;       procedure WriteRmbOutStn(pBookNum:Str5;pValue:word);
    function ReadRmbIncStn(pBookNum:Str5):word;       procedure WriteRmbIncStn(pBookNum:Str5;pValue:word);
    function ReadRmbOutSmc(pBookNum:Str5):word;       procedure WriteRmbOutSmc(pBookNum:Str5;pValue:word);
    function ReadRmbIncSmc(pBookNum:Str5):word;       procedure WriteRmbIncSmc(pBookNum:Str5;pValue:word);
    function ReadRmbAutAcc(pBookNum:Str5):boolean;    procedure WriteRmbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadRmbOnlSub(pBookNum:Str5):boolean;    procedure WriteRmbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadRmbSpcMov(pBookNum:Str5):boolean;    procedure WriteRmbSpcMov(pBookNum:Str5;pValue:boolean);
    function ReadRmbItmFrm(pBookNum:Str5):byte;       procedure WriteRmbItmFrm(pBookNum:Str5;pValue:byte);
    // PKB
    function ReadPkbStkNum(pBookNum:Str5):word;       procedure WritePkbStkNum(pBookNum:Str5;pValue:word);
    function ReadPkbPlsNum(pBookNum:Str5):word;       procedure WritePkbPlsNum(pBookNum:Str5;pValue:word);
    function ReadPkbSrcSmc(pBookNum:Str5):word;       procedure WritePkbSrcSmc(pBookNum:Str5;pValue:word);
    function ReadPkbTrgSmc(pBookNum:Str5):word;       procedure WritePkbTrgSmc(pBookNum:Str5;pValue:word);
    // TSB
    function ReadTsbBoYear(pBookNum:Str5):Str4;       procedure WriteTsbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadTsbWriNum(pBookNum:Str5):word;       procedure WriteTsbWriNum(pBookNum:Str5;pValue:word);
    function ReadTsbStkNum(pBookNum:Str5):word;       procedure WriteTsbStkNum(pBookNum:Str5;pValue:word);
    function ReadTsbPlsNum(pBookNum:Str5):word;       procedure WriteTsbPlsNum(pBookNum:Str5;pValue:word);
    function ReadTsbTsdRcv(pBookNum:Str5):word;       procedure WriteTsbTsdRcv(pBookNum:Str5;pValue:word);
    function ReadTsbDvName(pBookNum:Str5):Str3;       procedure WriteTsbDvName(pBookNum:Str5;pValue:Str3);
    function ReadTsbPabNum(pBookNum:Str5):word;       procedure WriteTsbPabNum(pBookNum:Str5;pValue:word);
    function ReadTsbDefPac(pBookNum:Str5):longint;    procedure WriteTsbDefPac(pBookNum:Str5;pValue:longint);
    function ReadTsbSmCode(pBookNum:Str5):word;       procedure WriteTsbSmCode(pBookNum:Str5;pValue:word);
    function ReadTsbAutAcc(pBookNum:Str5):boolean;    procedure WriteTsbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadTsbOnlSub(pBookNum:Str5):boolean;    procedure WriteTsbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadTsbBcsVer(pBookNum:Str5):boolean;    procedure WriteTsbBcsVer(pBookNum:Str5;pValue:boolean);
    function ReadTsbRevClc(pBookNum:Str5):boolean;    procedure WriteTsbRevClc(pBookNum:Str5;pValue:boolean);
    function ReadTsbTcdGen(pBookNum:Str5):boolean;    procedure WriteTsbTcdGen(pBookNum:Str5;pValue:boolean);
    function ReadTsbIcdGen(pBookNum:Str5):boolean;    procedure WriteTsbIcdGen(pBookNum:Str5;pValue:boolean);
    function ReadTsbIsbNum(pBookNum:Str5):Str5;       procedure WriteTsbIsbNum(pBookNum:Str5;pValue:Str5);
    function ReadTsbAgnTcb(pBookNum:Str5):Str5;       procedure WriteTsbAgnTcb(pBookNum:Str5;pValue:Str5);
    function ReadTsbAgnIcb(pBookNum:Str5):Str5;       procedure WriteTsbAgnIcb(pBookNum:Str5;pValue:Str5);
    function ReadTsbAgnPac(pBookNum:Str5):longint;    procedure WriteTsbAgnPac(pBookNum:Str5;pValue:longint);
    function ReadTsbAgnPrf(pBookNum:Str5):double;     procedure WriteTsbAgnPrf(pBookNum:Str5;pValue:double);
    function ReadTsbAutPkb(pBookNum:Str5):Str5;       procedure WriteTsbAutPkb(pBookNum:Str5;pValue:Str5);
    function ReadTsbAcqGsc(pBookNum:Str5):boolean;    procedure WriteTsbAcqGsc(pBookNum:Str5;pValue:boolean);
    function ReadTsbPlsMod(pBookNum:Str5):boolean;    procedure WriteTsbPlsMod(pBookNum:Str5;pValue:boolean);
    function ReadTsbPrnCls(pBookNum:Str5):boolean;    procedure WriteTsbPrnCls(pBookNum:Str5;pValue:boolean);
    function ReadTsbPckMgc:Str60;                     procedure WriteTsbPckMgc(pValue:Str60);
    // Psb
    function ReadPsbBoYear(pBookNum:Str5):Str4;       procedure WritePsbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadPsbExnFrm(pBookNum:Str5):Str20;      procedure WritePsbExnFrm(pBookNum:Str5;pValue:Str20);
    function ReadPsbStkNum(pBookNum:Str5):word;       procedure WritePsbStkNum(pBookNum:Str5;pValue:word);
    function ReadPsbWriNum(pBookNum:Str5):word;       procedure WritePsbWriNum(pBookNum:Str5;pValue:word);
    function ReadPsbDvName(pBookNum:Str5):Str3;       procedure WritePsbDvName(pBookNum:Str5;pValue:Str3);
    function ReadPsbPabNum(pBookNum:Str5):word;       procedure WritePsbPabNum(pBookNum:Str5;pValue:word);
    function ReadPsbOsbNum(pBookNum:Str5):Str5;       procedure WritePsbOsbNum(pBookNum:Str5;pValue:Str5);
    function ReadPsbClcTyp(pBookNum:Str5):byte;       procedure WritePsbClcTyp(pBookNum:Str5;pValue:byte);
    // ALB
    function ReadAlbExnFrm(pBookNum:Str5):Str12;      procedure WriteAlbExnFrm(pBookNum:Str5;pValue:Str12);
    function ReadAlbSurPrc(pBookNum:Str5):double;     procedure WriteAlbSurPrc(pBookNum:Str5;pValue:double);
    function ReadAlbPenPrc(pBookNum:Str5):double;     procedure WriteAlbPenPrc(pBookNum:Str5;pValue:double);
    function ReadAlbRdiPrc(pBookNum:Str5):double;     procedure WriteAlbRdiPrc(pBookNum:Str5;pValue:double);
    function ReadAlbRduPrc(pBookNum:Str5):double;     procedure WriteAlbRduPrc(pBookNum:Str5;pValue:double);
    function ReadAlbCsbNum(pBookNum:Str5):Str5;       procedure WriteAlbCsbNum(pBookNum:Str5;pValue:Str5);
    function ReadAlbCsoInc(pBookNum:Str5):word;       procedure WriteAlbCsoInc(pBookNum:Str5;pValue:word);
    function ReadAlbCsoExp(pBookNum:Str5):word;       procedure WriteAlbCsoExp(pBookNum:Str5;pValue:word);
    function ReadAlbTcbNum(pBookNum:Str5):Str5;       procedure WriteAlbTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadAlbIcbNum(pBookNum:Str5):Str5;       procedure WriteAlbIcbNum(pBookNum:Str5;pValue:Str5);
    function ReadAlbRdiGsc(pBookNum:Str5):longint;    procedure WriteAlbRdiGsc(pBookNum:Str5;pValue:longint);
    function ReadAlbRduGsc(pBookNum:Str5):longint;    procedure WriteAlbRduGsc(pBookNum:Str5;pValue:longint);
    function ReadAlbRndBva(pBookNum:Str5):boolean;    procedure WriteAlbRndBva(pBookNum:Str5;pValue:boolean);
    function ReadAlbAgpFrc(pBookNum:Str5):byte;       procedure WriteAlbAgpFrc(pBookNum:Str5;pValue:byte);
    function ReadAlbAgvFrc(pBookNum:Str5):byte;       procedure WriteAlbAgvFrc(pBookNum:Str5;pValue:byte);
    function ReadAlbAspFrc(pBookNum:Str5):byte;       procedure WriteAlbAspFrc(pBookNum:Str5;pValue:byte);
    function ReadAlbAsvFrc(pBookNum:Str5):byte;       procedure WriteAlbAsvFrc(pBookNum:Str5;pValue:byte);
    function ReadAlbLasNit(pBookNum:Str5):boolean;    procedure WriteAlbLasNit(pBookNum:Str5;pValue:boolean);
    function ReadAlbExpDay(pBookNum:Str5):word;       procedure WriteAlbExpDay(pBookNum:Str5;pValue:word);
    function ReadAlbStkNum(pBookNum:Str5):longint;    procedure WriteAlbStkNum(pBookNum:Str5;pValue:longint);
    function ReadAlbIcdSum(pBookNum:Str5):boolean;    procedure WriteAlbIcdSum(pBookNum:Str5;pValue:boolean);
    function ReadAlbRenGsc(pBookNum:Str5):longint;    procedure WriteAlbRenGsc(pBookNum:Str5;pValue:longint);
    function ReadAlbRdnGsc(pBookNum:Str5):longint;    procedure WriteAlbRdnGsc(pBookNum:Str5;pValue:longint);
    function ReadAlbNorGsc(pBookNum:Str5):longint;    procedure WriteAlbNorGsc(pBookNum:Str5;pValue:longint);
    function ReadAlbCasNum(pBookNum:Str5):byte;       procedure WriteAlbCasNum(pBookNum:Str5;pValue:byte);
    // TIB
    function ReadTibImbNum(pBookNum:Str5):Str5;       procedure WriteTibImbNum(pBookNum:Str5;pValue:Str5);
    function ReadTibTsbNum(pBookNum:Str5):Str5;       procedure WriteTibTsbNum(pBookNum:Str5;pValue:Str5);
    function ReadTibOsbLst(pBookNum:Str5):Str200;     procedure WriteTibOsbLst(pBookNum:Str5;pValue:Str200);
    function ReadTibOcbLst(pBookNum:Str5):Str200;     procedure WriteTibOcbLst(pBookNum:Str5;pValue:Str200);
    function ReadTibWrmAut(pBookNum:Str5):boolean;    procedure WriteTibWrmAut(pBookNum:Str5;pValue:boolean);
    function ReadTibOsiPce(pBookNum:Str5):boolean;    procedure WriteTibOsiPce(pBookNum:Str5;pValue:boolean);
    // TOB
    function ReadTobSerNum(pBookNum:Str5):longint;    procedure WriteTobSerNum(pBookNum:Str5;pValue:longint);
    function ReadTobSndFms(pBookNum:Str5):boolean;    procedure WriteTobSndFms(pBookNum:Str5;pValue:boolean);
    function ReadTobTrmSer(pBookNum:Str5):boolean;    procedure WriteTobTrmSer(pBookNum:Str5;pValue:boolean);
    function ReadTobSadGen(pBookNum:Str5):byte;       procedure WriteTobSadGen(pBookNum:Str5;pValue:byte);
    function ReadTobTcbNum(pBookNum:Str5):Str5;       procedure WriteTobTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadTobTcsNum(pBookNum:Str5):Str5;       procedure WriteTobTcsNum(pBookNum:Str5;pValue:Str5);
    function ReadTobIcbNum(pBookNum:Str5):Str5;       procedure WriteTobIcbNum(pBookNum:Str5;pValue:Str5);
    function ReadTobOmbNum(pBookNum:Str5):Str5;       procedure WriteTobOmbNum(pBookNum:Str5;pValue:Str5);
    function ReadTobOcbNum(pBookNum:Str5):Str5;       procedure WriteTobOcbNum(pBookNum:Str5;pValue:Str5);
    function ReadTobCasNum(pBookNum:Str5):word;       procedure WriteTobCasNum(pBookNum:Str5;pValue:word);
    function ReadTobWriNum(pBookNum:Str5):word;       procedure WriteTobWriNum(pBookNum:Str5;pValue:word);
    function ReadTobStkNum(pBookNum:Str5):word;       procedure WriteTobStkNum(pBookNum:Str5;pValue:word);
    function ReadTobIcbVer(pBookNum:Str5):Str200;     procedure WriteTobIcbVer(pBookNum:Str5;pValue:Str200);
    function ReadTobOcuBok(pBookNum:Str5):Str200;     procedure WriteTobOcuBok(pBookNum:Str5;pValue:Str200);
    // POB
    function ReadPobSerNum(pBookNum:Str5):longint;    procedure WritePobSerNum(pBookNum:Str5;pValue:longint);
    function ReadPobSndFms(pBookNum:Str5):boolean;    procedure WritePobSndFms(pBookNum:Str5;pValue:boolean);
    function ReadPobSadGen(pBookNum:Str5):byte;       procedure WritePobSadGen(pBookNum:Str5;pValue:byte);
    function ReadPobTcbNum(pBookNum:Str5):Str5;       procedure WritePobTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadPobIcbNum(pBookNum:Str5):Str5;       procedure WritePobIcbNum(pBookNum:Str5;pValue:Str5);
    function ReadPobCasNum(pBookNum:Str5):word;       procedure WritePobCasNum(pBookNum:Str5;pValue:word);
    function ReadPobWriNum(pBookNum:Str5):word;       procedure WritePobWriNum(pBookNum:Str5;pValue:word);
    function ReadPobStkNum(pBookNum:Str5):word;       procedure WritePobStkNum(pBookNum:Str5;pValue:word);
    function ReadPobIcbVer(pBookNum:Str5):Str200;     procedure WritePobIcbVer(pBookNum:Str5;pValue:Str200);
    function ReadPobOcuBok(pBookNum:Str5):Str200;     procedure WritePobOcuBok(pBookNum:Str5;pValue:Str200);
    // SCB
    function ReadScbCarEdi(pBookNum:Str5):boolean;    procedure WriteScbCarEdi(pBookNum:Str5;pValue:boolean);
    function ReadScbPlsNum(pBookNum:Str5):longint;    procedure WriteScbPlsNum(pBookNum:Str5;pValue:longint);
    function ReadSciPlsNum(pBookNum:Str5):longint;    procedure WriteSciPlsNum(pBookNum:Str5;pValue:longint);
    function ReadScbWriNum(pBookNum:Str5):word;       procedure WriteScbWriNum(pBookNum:Str5;pValue:word);
    function ReadScbImdStk(pBookNum:Str5):word;       procedure WriteScbImdStk(pBookNum:Str5;pValue:word);
    function ReadScbOmdStk(pBookNum:Str5):word;       procedure WriteScbOmdStk(pBookNum:Str5;pValue:word);
    function ReadScbImdSmc(pBookNum:Str5):word;       procedure WriteScbImdSmc(pBookNum:Str5;pValue:word);
    function ReadScbOmdSmc(pBookNum:Str5):word;       procedure WriteScbOmdSmc(pBookNum:Str5;pValue:word);
    function ReadScbImbNum(pBookNum:Str5):Str5;       procedure WriteScbImbNum(pBookNum:Str5;pValue:Str5);
    function ReadScbOmbNum(pBookNum:Str5):Str5;       procedure WriteScbOmbNum(pBookNum:Str5;pValue:Str5);
    function ReadScbTcbNum(pBookNum:Str5):Str5;       procedure WriteScbTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadScbDvName(pBookNum:Str5):Str3;       procedure WriteScbDvName(pBookNum:Str5;pValue:Str3);
    function ReadScbExnFmt(pBookNum:Str5):Str12;      procedure WriteScbExnFmt(pBookNum:Str5;pValue:Str12);
    function ReadScbReqPro(pBookNum:Str5):boolean;    procedure WriteScbReqPro(pBookNum:Str5;pValue:boolean);
    // SPE
    function ReadSpeMcbNum:Str5;                      procedure WriteSpeMcbNum(pValue:Str5);
    // MCB
    function ReadMcbFgvDvz(pBookNum:Str5):Str3;       procedure WriteMcbFgvDvz(pBookNum:Str5;pValue:Str3);
    function ReadMcbItmFrm(pBookNum:Str5):byte;       procedure WriteMcbItmFrm(pBookNum:Str5;pValue:byte);
    function ReadMcbExnFmt(pBookNum:Str5):Str12;      procedure WriteMcbExnFmt(pBookNum:Str5;pValue:Str12);
    function ReadMcbPrnCls(pBookNum:Str5):boolean;    procedure WriteMcbPrnCls(pBookNum:Str5;pValue:boolean);
    function ReadMcbPrjMcd(pBookNum:Str5):boolean;    procedure WriteMcbPrjMcd(pBookNum:Str5;pValue:boolean);
    function ReadMcbDsHide(pBookNum:Str5):boolean;    procedure WriteMcbDsHide(pBookNum:Str5;pValue:boolean);
    function ReadMcbRndBva(pBookNum:Str5):boolean;    procedure WriteMcbRndBva(pBookNum:Str5;pValue:boolean);
    function ReadMcbShwPal(pBookNum:Str5):boolean;    procedure WriteMcbShwPal(pBookNum:Str5;pValue:boolean);
    function ReadMcbVatRnd(pBookNum:Str5):byte;       procedure WriteMcbVatRnd(pBookNum:Str5;pValue:byte);
    function ReadMcbDocRnd(pBookNum:Str5):byte;       procedure WriteMcbDocRnd(pBookNum:Str5;pValue:byte);
    function ReadMcbWriNum(pBookNum:Str5):word;       procedure WriteMcbWriNum(pBookNum:Str5;pValue:word);
    function ReadMcbStkNum(pBookNum:Str5):word;       procedure WriteMcbStkNum(pBookNum:Str5;pValue:word);
    function ReadMcbPabNum(pBookNum:Str5):word;       procedure WriteMcbPabNum(pBookNum:Str5;pValue:word);
    function ReadMcbOcbNum(pBookNum:Str5):Str5;       procedure WriteMcbOcbNum(pBookNum:Str5;pValue:Str5);
    function ReadMcbTcbNum(pBookNum:Str5):Str5;       procedure WriteMcbTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadMcbIcbNum(pBookNum:Str5):Str5;       procedure WriteMcbIcbNum(pBookNum:Str5;pValue:Str5);
    function ReadMcbCdbNum(pBookNum:Str5):Str5;       procedure WriteMcbCdbNum(pBookNum:Str5;pValue:Str5);
    function ReadMcbOciDiv(pBookNum:Str5):byte;       procedure WriteMcbOciDiv(pBookNum:Str5;pValue:byte);
    function ReadMcbPrfPrc(pBookNum:Str5):double;     procedure WriteMcbPrfPrc(pBookNum:Str5;pValue:double);
    function ReadMcbDocSnt(pBookNum:Str5):Str3;       procedure WriteMcbDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadMcbDocAnl(pBookNum:Str5):Str6;       procedure WriteMcbDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadMcbExpDay(pBookNum:Str5):word;       procedure WriteMcbExpDay(pBookNum:Str5;pValue:word);
    // OCB
    function ReadOcbBoYear(pBookNum:Str5):Str4;       procedure WriteOcbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadOcbExnFrm(pBookNum:Str5):Str12;      procedure WriteOcbExnFrm(pBookNum:Str5;pValue:Str12);
    function ReadOcbDvName(pBookNum:Str5):Str3;       procedure WriteOcbDvName(pBookNum:Str5;pValue:Str3);
    function ReadOcbAvtRnd(pBookNum:Str5):byte;       procedure WriteOcbAvtRnd(pBookNum:Str5;pValue:byte);
    function ReadOcbAvlRnd(pBookNum:Str5):byte;       procedure WriteOcbAvlRnd(pBookNum:Str5;pValue:byte);
    function ReadOcbFvtRnd(pBookNum:Str5):byte;       procedure WriteOcbFvtRnd(pBookNum:Str5;pValue:byte);
    function ReadOcbFvlRnd(pBookNum:Str5):byte;       procedure WriteOcbFvlRnd(pBookNum:Str5;pValue:byte);
    function ReadOcbItmEdi(pBookNum:Str5):byte;       procedure WriteOcbItmEdi(pBookNum:Str5;pValue:byte);
    function ReadOcbDocEdi(pBookNum:Str5):byte;       procedure WriteOcbDocEdi(pBookNum:Str5;pValue:byte);
    function ReadOcbIntDoc(pBookNum:Str5):boolean;    procedure WriteOcbIntDoc(pBookNum:Str5;pValue:boolean);
    function ReadOcbNotRes(pBookNum:Str5):boolean;    procedure WriteOcbNotRes(pBookNum:Str5;pValue:boolean);
    function ReadOcbPrnCls(pBookNum:Str5):boolean;    procedure WriteOcbPrnCls(pBookNum:Str5;pValue:boolean);
    function ReadOcbDsHide(pBookNum:Str5):boolean;    procedure WriteOcbDsHide(pBookNum:Str5;pValue:boolean);
    function ReadOcbUlcRsn(pBookNum:Str5):boolean;    procedure WriteOcbUlcRsn(pBookNum:Str5;pValue:boolean);
    function ReadOcbItdRsn(pBookNum:Str5):boolean;    procedure WriteOcbItdRsn(pBookNum:Str5;pValue:boolean);
    function ReadOcbAutSlc(pBookNum:Str5):boolean;    procedure WriteOcbAutSlc(pBookNum:Str5;pValue:boolean);
    function ReadOcbPayVer(pBookNum:Str5):boolean;    procedure WriteOcbPayVer(pBookNum:Str5;pValue:boolean);
    function ReadOcbQntTrn(pBookNum:Str5):boolean;    procedure WriteOcbQntTrn(pBookNum:Str5;pValue:boolean);
    function ReadOcbScmDis(pBookNum:Str5):boolean;    procedure WriteOcbScmDis(pBookNum:Str5;pValue:boolean);
    function ReadOcbBaCont(pBookNum:Str5):Str20;      procedure WriteOcbBaCont(pBookNum:Str5;pValue:Str20);
    function ReadOcbBaName(pBookNum:Str5):Str30;      procedure WriteOcbBaName(pBookNum:Str5;pValue:Str30);
    function ReadOcbBaIban(pBookNum:Str5):Str30;      procedure WriteOcbBaIban(pBookNum:Str5;pValue:Str30);
    function ReadOcbBaSwft(pBookNum:Str5):Str10;      procedure WriteOcbBaSwft(pBookNum:Str5;pValue:Str10);
    function ReadOcbBaAddr(pBookNum:Str5):Str30;      procedure WriteOcbBaAddr(pBookNum:Str5;pValue:Str30);
    function ReadOcbBaCity(pBookNum:Str5):Str30;      procedure WriteOcbBaCity(pBookNum:Str5;pValue:Str30);
    function ReadOcbBaStat(pBookNum:Str5):Str30;      procedure WriteOcbBaStat(pBookNum:Str5;pValue:Str30);
    function ReadOcbWriNum(pBookNum:Str5):word;       procedure WriteOcbWriNum(pBookNum:Str5;pValue:word);
    function ReadOcbStkNum(pBookNum:Str5):word;       procedure WriteOcbStkNum(pBookNum:Str5;pValue:word);
    function ReadOcbPlsNum(pBookNum:Str5):word;       procedure WriteOcbPlsNum(pBookNum:Str5;pValue:word);
    function ReadOcbCasNum(pBookNum:Str5):word;       procedure WriteOcbCasNum(pBookNum:Str5;pValue:word);
    function ReadOcbPabNum(pBookNum:Str5):word;       procedure WriteOcbPabNum(pBookNum:Str5;pValue:word);
    function ReadOcbTcbNum(pBookNum:Str5):Str5;       procedure WriteOcbTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbIcbNum(pBookNum:Str5):Str5;       procedure WriteOcbIcbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbImbNum(pBookNum:Str5):Str5;       procedure WriteOcbImbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbOmbNum(pBookNum:Str5):Str5;       procedure WriteOcbOmbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbRmbNum(pBookNum:Str5):Str5;       procedure WriteOcbRmbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbPcbNum(pBookNum:Str5):Str5;       procedure WriteOcbPcbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbCsbNum(pBookNum:Str5):Str5;       procedure WriteOcbCsbNum(pBookNum:Str5;pValue:Str5);
    function ReadOcbExpDay(pBookNum:Str5):word;       procedure WriteOcbExpDay(pBookNum:Str5;pValue:word);
    function ReadOcbDlvDay(pBookNum:Str5):word;       procedure WriteOcbDlvDay(pBookNum:Str5;pValue:word);
    function ReadOcbMdcImp(pBookNum:Str5):word;       procedure WriteOcbMdcImp(pBookNum:Str5;pValue:word);

    // TCB
    function ReadTcbBoYear(pBookNum:Str5):Str4;       procedure WriteTcbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadTcbWriNum(pBookNum:Str5):word;       procedure WriteTcbWriNum(pBookNum:Str5;pValue:word);
    function ReadTcbStkNum(pBookNum:Str5):word;       procedure WriteTcbStkNum(pBookNum:Str5;pValue:word);
    function ReadTcbPlsNum(pBookNum:Str5):word;       procedure WriteTcbPlsNum(pBookNum:Str5;pValue:word);
    function ReadTcbDvName(pBookNum:Str5):Str3;       procedure WriteTcbDvName(pBookNum:Str5;pValue:Str3);
    function ReadTcbExnFrm(pBookNum:Str5):Str12;      procedure WriteTcbExnFrm(pBookNum:Str5;pValue:Str12);
    function ReadTcbPabNum(pBookNum:Str5):word;       procedure WriteTcbPabNum(pBookNum:Str5;pValue:word);
    function ReadTcbDefPac(pBookNum:Str5):longint;    procedure WriteTcbDefPac(pBookNum:Str5;pValue:longint);
    function ReadTcbSmCode(pBookNum:Str5):word;       procedure WriteTcbSmCode(pBookNum:Str5;pValue:word);
    function ReadTcbFgCalc(pBookNum:Str5):byte;       procedure WriteTcbFgCalc(pBookNum:Str5;pValue:byte);
    function ReadTcbAvtRnd(pBookNum:Str5):byte;       procedure WriteTcbAvtRnd(pBookNum:Str5;pValue:byte);
    function ReadTcbAvlRnd(pBookNum:Str5):byte;       procedure WriteTcbAvlRnd(pBookNum:Str5;pValue:byte);
    function ReadTcbFvtRnd(pBookNum:Str5):byte;       procedure WriteTcbFvtRnd(pBookNum:Str5;pValue:byte);
    function ReadTcbFvlRnd(pBookNum:Str5):byte;       procedure WriteTcbFvlRnd(pBookNum:Str5;pValue:byte);
    function ReadTcbAutAcc(pBookNum:Str5):boolean;    procedure WriteTcbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadTcbOnlSub(pBookNum:Str5):boolean;    procedure WriteTcbOnlSub(pBookNum:Str5;pValue:boolean);
    function ReadTcbDsHide(pBookNum:Str5):boolean;    procedure WriteTcbDsHide(pBookNum:Str5;pValue:boolean);
    function ReadTcbOcnVer(pBookNum:Str5):boolean;    procedure WriteTcbOcnVer(pBookNum:Str5;pValue:boolean);
    function ReadTcbPrnCls(pBookNum:Str5):boolean;    procedure WriteTcbPrnCls(pBookNum:Str5;pValue:boolean);
    function ReadTcbFgbMod(pBookNum:Str5):boolean;    procedure WriteTcbFgbMod(pBookNum:Str5;pValue:boolean);
    function ReadTcbIcbNum(pBookNum:Str5):Str5;       procedure WriteTcbIcbNum(pBookNum:Str5;pValue:Str5);
    function ReadTcbMovTcb(pBookNum:Str5):Str5;       procedure WriteTcbMovTcb(pBookNum:Str5;pValue:Str5);
    function ReadTcbCasNum(pBookNum:Str5):byte;       procedure WriteTcbCasNum(pBookNum:Str5;pValue:byte);
    function ReadTcbFmType(pBookNum:Str5):byte;       procedure WriteTcbFmType(pBookNum:Str5;pValue:byte);
    function ReadTcbFmPort(pBookNum:Str5):Str4;       procedure WriteTcbFmPort(pBookNum:Str5;pValue:Str4);
    function ReadTcbCpiBok(pBookNum:Str5):Str5;       procedure WriteTcbCpiBok(pBookNum:Str5;pValue:Str5);
    // SAB
    function ReadSabWriNum(pBookNum:Str5):word;       procedure WriteSabWriNum(pBookNum:Str5;pValue:word);
    function ReadSabStkNum(pBookNum:Str5):word;       procedure WriteSabStkNum(pBookNum:Str5;pValue:word);
    function ReadSabCenCsb(pBookNum:Str5):Str5;       procedure WriteSabCenCsb(pBookNum:Str5;pValue:Str5);
    function ReadSabEcrCsb(pBookNum:Str5):Str5;       procedure WriteSabEcrCsb(pBookNum:Str5;pValue:Str5);
    function ReadSabIdbNum(pBookNum:Str5):Str5;       procedure WriteSabIdbNum(pBookNum:Str5;pValue:Str5);
    function ReadSabBgsCoi(pBookNum:Str5):word;       procedure WriteSabBgsCoi(pBookNum:Str5;pValue:word);
    function ReadSabBseCoi(pBookNum:Str5):word;       procedure WriteSabBseCoi(pBookNum:Str5;pValue:word);
    function ReadSabSpiCoi(pBookNum:Str5):word;       procedure WriteSabSpiCoi(pBookNum:Str5;pValue:word);
    function ReadSabSpeCoe(pBookNum:Str5):word;       procedure WriteSabSpeCoe(pBookNum:Str5;pValue:word);
    function ReadSabCshCoe(pBookNum:Str5):word;       procedure WriteSabCshCoe(pBookNum:Str5;pValue:word);
    function ReadSabCshCoi(pBookNum:Str5):word;       procedure WriteSabCshCoi(pBookNum:Str5;pValue:word);
    function ReadSabCrdCoe(pBookNum:Str5):word;       procedure WriteSabCrdCoe(pBookNum:Str5;pValue:word);
    function ReadSabSviCrd(pBookNum:Str5):word;       procedure WriteSabSviCrd(pBookNum:Str5;pValue:word);
    function ReadSabSviDeb(pBookNum:Str5):word;       procedure WriteSabSviDeb(pBookNum:Str5;pValue:word);
    function ReadSabSveCrd(pBookNum:Str5):word;       procedure WriteSabSveCrd(pBookNum:Str5;pValue:word);
    function ReadSabSveDeb(pBookNum:Str5):word;       procedure WriteSabSveDeb(pBookNum:Str5;pValue:word);
    function ReadSabStkSub(pBookNum:Str5):boolean;    procedure WriteSabStkSub(pBookNum:Str5;pValue:boolean);
    function ReadSabStkDet(pBookNum:Str5):boolean;    procedure WriteSabStkDet(pBookNum:Str5;pValue:boolean);
    function ReadSabCrdTrn(pBookNum:Str5):boolean;    procedure WriteSabCrdTrn(pBookNum:Str5;pValue:boolean);
    function ReadSabTcbNum(pBookNum:Str5):Str5;       procedure WriteSabTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadSabCpiBok(pBookNum:Str5):Str5;       procedure WriteSabCpiBok(pBookNum:Str5;pValue:Str5);
    function ReadSabIcpCoi(pBookNum:Str5):word;       procedure WriteSabIcpCoi(pBookNum:Str5;pValue:word);
    function ReadSabIcpCsb(pBookNum:Str5):Str5;       procedure WriteSabIcpCsb(pBookNum:Str5;pValue:Str5);
    function ReadSabAccAll(pBookNum:Str5):boolean;    procedure WriteSabAccAll(pBookNum:Str5;pValue:boolean);
    function ReadSabAccDcl(pBookNum:Str5):boolean;    procedure WriteSabAccDcl(pBookNum:Str5;pValue:boolean);
    function ReadSabCshCre(pBookNum:Str5):word;       procedure WriteSabCshCre(pBookNum:Str5;pValue:word);
    function ReadSabCshCri(pBookNum:Str5):word;       procedure WriteSabCshCri(pBookNum:Str5;pValue:word);
    // RPL
    function ReadRplPceBeg(pIntNum:byte;pBookNum:Str5):double;    procedure WriteRplpceBeg(pIntNum:byte;pBookNum:Str5;pValue:double);
    function ReadRplPceEnd(pIntNum:byte;pBookNum:Str5):double;    procedure WriteRplpceEnd(pIntNum:byte;pBookNum:Str5;pValue:double);
    function ReadRplPrfKfc(pIntNum:byte;pBookNum:Str5):double;    procedure WriteRplPrfKfc(pIntNum:byte;pBookNum:Str5;pValue:double);
    function ReadRplExcKfc(pIntNum:byte;pBookNum:Str5):double;    procedure WriteRplExcKfc(pIntNum:byte;pBookNum:Str5;pValue:double);
    function ReadRplImpFile(pBookNum:Str5):Str200;    procedure WriteRplImpFile(pBookNum:Str5;pValue:Str200);
    // JOB
    function ReadJobOwnUsl(pBookNum:Str5):Str8;       procedure WriteJobOwnUsl(pBookNum:Str5;pValue:Str8);
    function ReadJobNdoClr(pBookNum:Str5):integer;    procedure WriteJobNdoClr(pBookNum:Str5;pValue:integer);
    function ReadJobRdoClr(pBookNum:Str5):integer;    procedure WriteJobRdoClr(pBookNum:Str5;pValue:integer);
    function ReadJobSdoClr(pBookNum:Str5):integer;    procedure WriteJobSdoClr(pBookNum:Str5;pValue:integer);
    function ReadJobOdoClr(pBookNum:Str5):integer;    procedure WriteJobOdoClr(pBookNum:Str5;pValue:integer);
    function ReadJobXdoClr(pBookNum:Str5):integer;    procedure WriteJobXdoClr(pBookNum:Str5;pValue:integer);
    function ReadJobDdoClr(pBookNum:Str5):integer;    procedure WriteJobDdoClr(pBookNum:Str5;pValue:integer);
    // ISB
    function ReadIsbBoYear(pBookNum:Str5):Str4;       procedure WriteIsbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadIsbCoSymb(pBookNum:Str5):Str4;       procedure WriteIsbCoSymb(pBookNum:Str5;pValue:str4);
    function ReadIsbDvName(pBookNum:Str5):Str3;       procedure WriteIsbDvName(pBookNum:Str5;pValue:Str3);
    function ReadIsbWriNum(pBookNum:Str5):word;       procedure WriteIsbWriNum(pBookNum:Str5;pValue:word);
    function ReadIsbStkNum(pBookNum:Str5):word;       procedure WriteIsbStkNum(pBookNum:Str5;pValue:word);
    function ReadIsbPlsNum(pBookNum:Str5):word;       procedure WriteIsbPlsNum(pBookNum:Str5;pValue:word);
    function ReadIsbPabNum(pBookNum:Str5):word;       procedure WriteIsbPabNum(pBookNum:Str5;pValue:word);
    function ReadIsbAutAcc(pBookNum:Str5):boolean;    procedure WriteIsbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadIsbSumAcc(pBookNum:Str5):boolean;    procedure WriteIsbSumAcc(pBookNum:Str5;pValue:boolean);
    function ReadIsbTsdAcc(pBookNum:Str5):boolean;    procedure WriteIsbTsdAcc(pBookNum:Str5;pValue:boolean);
    function ReadIsbVatCls(pBookNum:Str5):boolean;    procedure WriteIsbVatCls(pBookNum:Str5;pValue:boolean);
    function ReadIsbNvtDoc(pBookNum:Str5):boolean;    procedure WriteIsbNvtDoc(pBookNum:Str5;pValue:boolean);
    function ReadIsbDocSnt(pBookNum:Str5):Str3;       procedure WriteIsbDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbDocAnl(pBookNum:Str5):Str6;       procedure WriteIsbDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbVatSnt(pBookNum:Str5):Str3;       procedure WriteIsbVatSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbVatAnl(pBookNum:Str5):Str6;       procedure WriteIsbVatAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbNvaSnt(pBookNum:Str5):Str3;       procedure WriteIsbNvaSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbNvaAnl(pBookNum:Str5):Str6;       procedure WriteIsbNvaAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbGscSnt(pBookNum:Str5):Str3;       procedure WriteIsbGscSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbGscAnl(pBookNum:Str5):Str6;       procedure WriteIsbGscAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbGsdSnt(pBookNum:Str5):Str3;       procedure WriteIsbGsdSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbGsdAnl(pBookNum:Str5):Str6;       procedure WriteIsbGsdAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbSecSnt(pBookNum:Str5):Str3;       procedure WriteIsbSecSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbSecAnl(pBookNum:Str5):Str6;       procedure WriteIsbSecAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbSedSnt(pBookNum:Str5):Str3;       procedure WriteIsbSedSnt(pBookNum:Str5;pValue:Str3);
    function ReadIsbSedAnl(pBookNum:Str5):Str6;       procedure WriteIsbSedAnl(pBookNum:Str5;pValue:Str6);
    function ReadIsbTsbNum(pBookNum:Str5):Str5;       procedure WriteIsbTsbNum(pBookNum:Str5;pValue:Str5);
    function ReadIsbCsbNum(pBookNum:Str5):Str5;       procedure WriteIsbCsbNum(pBookNum:Str5;pValue:Str5);
    function ReadIsbDocSpc(pBookNum:Str5):byte;       procedure WriteIsbDocSpc(pBookNum:Str5;pValue:byte);
    function ReadIsbVtdDef(pBookNum:Str5):byte;       procedure WriteIsbVtdDef(pBookNum:Str5;pValue:byte);
    function ReadIsbAcdDef(pBookNum:Str5):byte;       procedure WriteIsbAcdDef(pBookNum:Str5;pValue:byte);
    function ReadIsbItmAcc(pBookNum:Str5):byte;       procedure WriteIsbItmAcc(pBookNum:Str5;pValue:byte);
    function ReadIsbVatRnd(pBookNum:Str5):byte;       procedure WriteIsbVatRnd(pBookNum:Str5;pValue:byte);
    function ReadIsbValRnd(pBookNum:Str5):byte;       procedure WriteIsbValRnd(pBookNum:Str5;pValue:byte);
    function ReadIsbTsbInc(pBookNum:Str5):Str200;     procedure WriteIsbTsbInc(pBookNum:Str5;pValue:Str200);
    function ReadIsbTsbExc(pBookNum:Str5):Str200;     procedure WriteIsbTsbExc(pBookNum:Str5;pValue:Str200);
    // ICB
    function ReadIcbBoYear(pBookNum:Str5):Str4;       procedure WriteIcbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadIcbCoSymb(pBookNum:Str5):Str4;       procedure WriteIcbCoSymb(pBookNum:Str5;pValue:Str4);
    function ReadIcbDvName(pBookNum:Str5):Str3;       procedure WriteIcbDvName(pBookNum:Str5;pValue:Str3);
    function ReadIcbExnFrm(pBookNum:Str5):Str12;      procedure WriteIcbExnFrm(pBookNum:Str5;pValue:Str12);
    function ReadIcbWriNum(pBookNum:Str5):word;       procedure WriteIcbWriNum(pBookNum:Str5;pValue:word);
    function ReadIcbStkNum(pBookNum:Str5):word;       procedure WriteIcbStkNum(pBookNum:Str5;pValue:word);
    function ReadIcbPlsNum(pBookNum:Str5):word;       procedure WriteIcbPlsNum(pBookNum:Str5;pValue:word);
    function ReadIcbPabNum(pBookNum:Str5):word;       procedure WriteIcbPabNum(pBookNum:Str5;pValue:word);
    function ReadIcbAvtRnd(pBookNum:Str5):byte;       procedure WriteIcbAvtRnd(pBookNum:Str5;pValue:byte);
    function ReadIcbAvlRnd(pBookNum:Str5):byte;       procedure WriteIcbAvlRnd(pBookNum:Str5;pValue:byte);
    function ReadIcbFvtRnd(pBookNum:Str5):byte;       procedure WriteIcbFvtRnd(pBookNum:Str5;pValue:byte);
    function ReadIcbFvlRnd(pBookNum:Str5):byte;       procedure WriteIcbFvlRnd(pBookNum:Str5;pValue:byte);
    function ReadIcbAutAcc(pBookNum:Str5):boolean;    procedure WriteIcbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadIcbSumAcc(pBookNum:Str5):boolean;    procedure WriteIcbSumAcc(pBookNum:Str5;pValue:boolean);
    function ReadIcbTcdAcc(pBookNum:Str5):boolean;    procedure WriteIcbTcdAcc(pBookNum:Str5;pValue:boolean);
    function ReadIcbVatCls(pBookNum:Str5):boolean;    procedure WriteIcbVatCls(pBookNum:Str5;pValue:boolean);
    function ReadIcbNvtDoc(pBookNum:Str5):boolean;    procedure WriteIcbNvtDoc(pBookNum:Str5;pValue:boolean);
    function ReadIcbOcnVer(pBookNum:Str5):boolean;    procedure WriteIcbOcnVer(pBookNum:Str5;pValue:boolean);
    function ReadIcbFgbMod(pBookNum:Str5):boolean;    procedure WriteIcbFgbMod(pBookNum:Str5;pValue:boolean);
    function ReadIcbPrnCls(pBookNum:Str5):boolean;    procedure WriteIcbPrnCls(pBookNum:Str5;pValue:boolean);
    function ReadIcbVatClc(pBookNum:Str5):boolean;    procedure WriteIcbVatClc(pBookNum:Str5;pValue:boolean);
    function ReadIcbDocSnt(pBookNum:Str5):Str3;       procedure WriteIcbDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbDocAnl(pBookNum:Str5):Str6;       procedure WriteIcbDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbVatSnt(pBookNum:Str5):Str3;       procedure WriteIcbVatSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbVatAnl(pBookNum:Str5):Str6;       procedure WriteIcbVatAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbGscSnt(pBookNum:Str5):Str3;       procedure WriteIcbGscSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbGscAnl(pBookNum:Str5):Str6;       procedure WriteIcbGscAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbSecSnt(pBookNum:Str5):Str3;       procedure WriteIcbSecSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbSecAnl(pBookNum:Str5):Str6;       procedure WriteIcbSecAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbPcrSnt(pBookNum:Str5):Str3;       procedure WriteIcbPcrSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbPcrAnl(pBookNum:Str5):Str6;       procedure WriteIcbPcrAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbNcrSnt(pBookNum:Str5):Str3;       procedure WriteIcbNcrSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbNcrAnl(pBookNum:Str5):Str6;       procedure WriteIcbNcrAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbPdfSnt(pBookNum:Str5):Str3;       procedure WriteIcbPdfSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbPdfAnl(pBookNum:Str5):Str6;       procedure WriteIcbPdfAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbNdfSnt(pBookNum:Str5):Str3;       procedure WriteIcbNdfSnt(pBookNum:Str5;pValue:Str3);
    function ReadIcbNdfAnl(pBookNum:Str5):Str6;       procedure WriteIcbNdfAnl(pBookNum:Str5;pValue:Str6);
    function ReadIcbTcbNum(pBookNum:Str5):Str5;       procedure WriteIcbTcbNum(pBookNum:Str5;pValue:Str5);
    function ReadIcbCsbNum(pBookNum:Str5):Str5;       procedure WriteIcbCsbNum(pBookNum:Str5;pValue:Str5);
    function ReadIcbNibNum(pBookNum:Str5):Str5;       procedure WriteIcbNibNum(pBookNum:Str5;pValue:Str5);
    function ReadIcbDocSpc(pBookNum:Str5):byte;       procedure WriteIcbDocSpc(pBookNum:Str5;pValue:byte);
    function ReadIcbExCalc(pBookNum:Str5):byte;       procedure WriteIcbExCalc(pBookNum:Str5;pValue:byte);
    function ReadIcbBaCont(pBookNum:Str5):Str30;      procedure WriteIcbBaCont(pBookNum:Str5;pValue:Str30);
    function ReadIcbBaName(pBookNum:Str5):Str30;      procedure WriteIcbBaName(pBookNum:Str5;pValue:Str30);
    function ReadIcbBaIban(pBookNum:Str5):Str30;      procedure WriteIcbBaIban(pBookNum:Str5;pValue:Str30);
    function ReadIcbBaSwft(pBookNum:Str5):Str30;      procedure WriteIcbBaSwft(pBookNum:Str5;pValue:Str30);
    function ReadIcbBaAddr(pBookNum:Str5):Str30;      procedure WriteIcbBaAddr(pBookNum:Str5;pValue:Str30);
    function ReadIcbBaCity(pBookNum:Str5):Str30;      procedure WriteIcbBaCity(pBookNum:Str5;pValue:Str30);
    function ReadIcbBaStat(pBookNum:Str5):Str30;      procedure WriteIcbBaStat(pBookNum:Str5;pValue:Str30);
    function ReadIcbCadEnb:boolean;                   procedure WriteIcbCadEnb(pValue:boolean);
    function ReadIcbPayCoi(pBookNum:Str5):word;       procedure WriteIcbPayCoi(pBookNum:Str5;pValue:word);
    function ReadIcbCadTyp(pBookNum:Str5):byte;       procedure WriteIcbCadTyp(pBookNum:Str5;pValue:byte);
    function ReadIcbItmAcc(pBookNum:Str5):byte;       procedure WriteIcbItmAcc(pBookNum:Str5;pValue:byte);
    function ReadIcbFgCalc(pBookNum:Str5):byte;       procedure WriteIcbFgCalc(pBookNum:Str5;pValue:byte);
    function ReadIcbDsHide(pBookNum:Str5):boolean;    procedure WriteIcbDsHide(pBookNum:Str5;pValue:boolean);
    function ReadIcbRepVtd(pBookNum:Str5):Str30;      procedure WriteIcbRepVtd(pBookNum:Str5;pValue:Str30);
    function ReadIcbRepNvd(pBookNum:Str5):Str30;      procedure WriteIcbRepNvd(pBookNum:Str5;pValue:Str30);
    function ReadIcbRepVtdO(pBookNum:Str5):Str30;     procedure WriteIcbRepVtdO(pBookNum:Str5;pValue:Str30);
    function ReadIcbRepNvdO(pBookNum:Str5):Str30;     procedure WriteIcbRepNvdO(pBookNum:Str5;pValue:Str30);
    // DPB
    function ReadDpbHcrSnt(pBookNum:Str5):Str3;       procedure WriteDpbHcrSnt(pBookNum:Str5;pValue:Str3);
    function ReadDpbHcrAnl(pBookNum:Str5):Str6;       procedure WriteDpbHcrAnl(pBookNum:Str5;pValue:Str6);
    function ReadDpbHdbSnt(pBookNum:Str5):Str3;       procedure WriteDpbHdbSnt(pBookNum:Str5;pValue:Str3);
    function ReadDpbHdbAnl(pBookNum:Str5):Str6;       procedure WriteDpbHdbAnl(pBookNum:Str5;pValue:Str6);
    function ReadDpbIcrSnt(pBookNum:Str5):Str3;       procedure WriteDpbIcrSnt(pBookNum:Str5;pValue:Str3);
    function ReadDpbIcrAnl(pBookNum:Str5):Str6;       procedure WriteDpbIcrAnl(pBookNum:Str5;pValue:Str6);
    function ReadDpbIdbSnt(pBookNum:Str5):Str3;       procedure WriteDpbIdbSnt(pBookNum:Str5;pValue:Str3);
    function ReadDpbIdbAnl(pBookNum:Str5):Str6;       procedure WriteDpbIdbAnl(pBookNum:Str5;pValue:Str6);
    // ASC
    function ReadAscExdBeg(pPerNum:byte):integer;     procedure WriteAscExdBeg(pPerNum:byte;pValue:integer);
    function ReadAscExdEnd(pPerNum:byte):integer;     procedure WriteAscExdEnd(pPerNum:byte;pValue:integer);
    function ReadAscExdTxt(pPerNum:byte):Str30;       procedure WriteAscExdTxt(pPerNum:byte;pValue:Str30);
    // CAS
    function ReadCasClsTyp(pCasNum:word):longint;     procedure WriteCasClsTyp(pCasNum:word;pValue:longint);
    function ReadCasBlkNum(pCasNum:word):longint;     procedure WriteCasBlkNum(pCasNum:word;pValue:longint);
    function ReadCasTrnNeb(pCasNum:word):boolean;     procedure WriteCasTrnNeb(pCasNum:word;pValue:boolean);
    function ReadCasDupMsg(pCasNum:word):boolean;     procedure WriteCasDupMsg(pCasNum:word;pValue:boolean);
    function ReadCasDupSum(pCasNum:word):boolean;     procedure WriteCasDupSum(pCasNum:word;pValue:boolean);
    function ReadCasLanDir(pCasNum:word):Str250;      procedure WriteCasLanDir(pCasNum:word;pValue:Str250);
    function ReadCasTpcNum(pCasNum:word):word;        procedure WriteCasTpcNum(pCasNum:word;pValue:word);
    function ReadCasFmpWay(pCasNum:word):word;        procedure WriteCasFmpWay(pCasNum:word;pValue:word);
    function ReadCasFmiWay(pCasNum:word):word;        procedure WriteCasFmiWay(pCasNum:word;pValue:word);
    function ReadCasPauCnt(pCasNum:word):word;        procedure WriteCasPauCnt(pCasNum:word;pValue:word);
    function ReadCasExdQnt(pCasNum:word):byte;        procedure WriteCasExdQnt(pCasNum:word;pValue:byte);
    function ReadCasMaxItm(pCasNum:word):word;        procedure WriteCasMaxItm(pCasNum:word;pValue:word);
    function ReadCasFmdPrn(pCasNum:word):boolean;     procedure WriteCasFmdPrn(pCasNum:word;pValue:boolean);
    function ReadCasIcpQnt(pCasNum:word):byte;        procedure WriteCasIcpQnt(pCasNum:word;pValue:byte);
    function ReadCasTcdBok(pCasNum:word):Str5;        procedure WriteCasTcdBok(pCasNum:word;pValue:Str5);
    function ReadCasPabBeg:longint;                   procedure WriteCasPabBeg(pValue:longint);
    function ReadCasPabEnd:longint;                   procedure WriteCasPabEnd(pValue:longint);
    // CAI
    function ReadCaiActTrn :boolean;                  procedure WriteCaiActTrn(pValue:boolean);
    // RPC
    function ReadRpcChgNum(pPlsNum:word):word;        procedure WriteRpcChgNum(pPlsNum:word;pValue:word);
    function ReadRpcChgCas(pPlsNum:word):Str250;      procedure WriteRpcChgCas(pPlsNum:word;pValue:Str250);
    function ReadRpcExpRef(pPlsNum:word):boolean;     procedure WriteRpcExpRef(pPlsNum:word;pValue:boolean);
    // CSB
    function ReadCsbBoYear(pBookNum:Str5):Str4;       procedure WriteCsbBoYear(pBookNum:Str5;pValue:Str4);
    function ReadCsbDvName(pBookNum:Str5):Str3;       procedure WriteCsbDvName(pBookNum:Str5;pValue:Str3);
    function ReadCsbWriNum(pBookNum:Str5):word;       procedure WriteCsbWriNum(pBookNum:Str5;pValue:word);
    function ReadCsbPabNum(pBookNum:Str5):word;       procedure WriteCsbPabNum(pBookNum:Str5;pValue:word);
    function ReadCsbPyvBeg(pBookNum:Str5):double;     procedure WriteCsbPyvBeg(pBookNum:Str5;pValue:double);
    function ReadCsbPyvInc(pBookNum:Str5):double;     procedure WriteCsbPyvInc(pBookNum:Str5;pValue:double);
    function ReadCsbPyvExp(pBookNum:Str5):double;     procedure WriteCsbPyvExp(pBookNum:Str5;pValue:double);
    function ReadCsbPyvEnd(pBookNum:Str5):double;     procedure WritePyvEndExp(pBookNum:Str5;pValue:double);
    function ReadCsbMaxPdf(pBookNum:Str5):double;     procedure WritePyvPyvMax(pBookNum:Str5;pValue:double);
    function ReadCsbAcvBeg(pBookNum:Str5):double;     procedure WritePyvAcvBeg(pBookNum:Str5;pValue:double);
    function ReadCsbAcvInc(pBookNum:Str5):double;     procedure WritePyvAcvInc(pBookNum:Str5;pValue:double);
    function ReadCsbAcvExp(pBookNum:Str5):double;     procedure WritePyvAcvExp(pBookNum:Str5;pValue:double);
    function ReadCsbEycCrd(pBookNum:Str5):double;     procedure WritePyvEycCrd(pBookNum:Str5;pValue:double);
    function ReadCsbEyvCrd(pBookNum:Str5):double;     procedure WritePyvEyvCrd(pBookNum:Str5;pValue:double);
    function ReadCsbAcvEnd(pBookNum:Str5):double;     procedure WritePyvAcvEnd(pBookNum:Str5;pValue:double);
    function ReadCsbDocSnt(pBookNum:Str5):Str3;       procedure WriteCsbDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadCsbDocAnl(pBookNum:Str5):Str6;       procedure WriteCsbDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadCsbVaiSnt(pBookNum:Str5):Str3;       procedure WriteCsbVaiSnt(pBookNum:Str5;pValue:Str3);
    function ReadCsbVaiAnl(pBookNum:Str5):Str6;       procedure WriteCsbVaiAnl(pBookNum:Str5;pValue:Str6);
    function ReadCsbVaoSnt(pBookNum:Str5):Str3;       procedure WriteCsbVaoSnt(pBookNum:Str5;pValue:Str3);
    function ReadCsbVaoAnl(pBookNum:Str5):Str6;       procedure WriteCsbVaoAnl(pBookNum:Str5;pValue:Str6);
    function ReadExcVatSnt(pBookNum:Str5):Str3;       procedure WriteExcVatSnt(pBookNum:Str5;pValue:Str3);
    function ReadExcVatAnl(pBookNum:Str5):Str6;       procedure WriteExcVatAnl(pBookNum:Str5;pValue:Str6);
    function ReadExcCosSnt(pBookNum:Str5):Str3;       procedure WriteExcCosSnt(pBookNum:Str5;pValue:Str3);
    function ReadExcCosAnl(pBookNum:Str5):Str6;       procedure WriteExcCosAnl(pBookNum:Str5;pValue:Str6);

    function ReadCsbVatRnd(pBookNum:Str5):byte;       procedure WriteCsbVatRnd(pBookNum:Str5;pValue:byte);
    function ReadCsbValRnd(pBookNum:Str5):byte;       procedure WriteCsbValRnd(pBookNum:Str5;pValue:byte);
    function ReadCsbSpcCse(pBookNum:Str5):word;       procedure WriteCsbSpcCse(pBookNum:Str5;pValue:word);
    function ReadCsbSpcCsi(pBookNum:Str5):word;       procedure WriteCsbSpcCsi(pBookNum:Str5;pValue:word);
    function ReadCsbVatCls(pBookNum:Str5):boolean;    procedure WriteCsbVatCls(pBookNum:Str5;pValue:boolean);
    function ReadCsbAutAcc(pBookNum:Str5):boolean;    procedure WriteCsbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadCsbRndVer(pBookNum:Str5):boolean;    procedure WriteCsbRndVer(pBookNum:Str5;pValue:boolean);
    function ReadCsbSumAcc(pBookNum:Str5):boolean;    procedure WriteCsbSumAcc(pBookNum:Str5;pValue:boolean);
    function ReadCsbWriAdd(pBookNum:Str5):boolean;    procedure WriteCsbWriAdd(pBookNum:Str5;pValue:boolean);
    function ReadCsbDoiQnt(pBookNum:Str5):word;       procedure WriteCsbDoiQnt(pBookNum:Str5;pValue:word);
    function ReadCsbDoeQnt(pBookNum:Str5):word;       procedure WriteCsbDoeQnt(pBookNum:Str5;pValue:word);
    function ReadCsbDocQnt(pBookNum:Str5):word;       procedure WriteCsbDocQnt(pBookNum:Str5;pValue:word);
    // SPB
    function ReadSpbPabNum:word;       procedure WriteSpbPabNum(pValue:word);
    // SOB
    function ReadSobPyvBeg(pBookNum:Str5):double;     procedure WriteSobPyvBeg(pBookNum:Str5;pValue:double);
    function ReadSobPyvCre(pBookNum:Str5):double;     procedure WriteSobPyvCre(pBookNum:Str5;pValue:double);
    function ReadSobPyvDeb(pBookNum:Str5):double;     procedure WriteSobPyvDeb(pBookNum:Str5;pValue:double);
    function ReadSobPyvEnd(pBookNum:Str5):double;     procedure WriteSobPyvEnd(pBookNum:Str5;pValue:double);
    function ReadSobPyvMax(pBookNum:Str5):double;     procedure WriteSobPyvMax(pBookNum:Str5;pValue:double);
    function ReadSobAcvBeg(pBookNum:Str5):double;     procedure WriteSobAcvBeg(pBookNum:Str5;pValue:double);
    function ReadSobAcvCre(pBookNum:Str5):double;     procedure WriteSobAcvCre(pBookNum:Str5;pValue:double);
    function ReadSobAcvDeb(pBookNum:Str5):double;     procedure WriteSobAcvDeb(pBookNum:Str5;pValue:double);
    function ReadSobAcvEnd(pBookNum:Str5):double;     procedure WriteSobAcvEnd(pBookNum:Str5;pValue:double);
    function ReadSobEycCrd(pBookNum:Str5):double;     procedure WriteSobEycCrd(pBookNum:Str5;pValue:double);
    function ReadSobEyvCrd(pBookNum:Str5):double;     procedure WriteSobEyvCrd(pBookNum:Str5;pValue:double);
    function ReadSobPydCrs(pBookNum:Str5):double;     procedure WriteSobPydCrs(pBookNum:Str5;pValue:double);
    function ReadSobPydNam(pBookNum:Str5):Str3;       procedure WriteSobPydNam(pBookNum:Str5;pValue:Str3);
    function ReadSobDocSnt(pBookNum:Str5):Str3;       procedure WriteSobDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadSobDocAnl(pBookNum:Str5):Str6;       procedure WriteSobDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadSobBaCont(pBookNum:Str5):Str20;      procedure WriteSobBaCont(pBookNum:Str5;pValue:Str20);
    function ReadSobBaCode(pBookNum:Str5):Str4;       procedure WriteSobBaCode(pBookNum:Str5;pValue:Str4);
    function ReadSobBaName(pBookNum:Str5):Str30;      procedure WriteSobBaName(pBookNum:Str5;pValue:Str30);
    function ReadSobBaIban(pBookNum:Str5):Str30;      procedure WriteSobBaIban(pBookNum:Str5;pValue:Str30);
    function ReadSobBaSwft(pBookNum:Str5):Str10;      procedure WriteSobBaSwft(pBookNum:Str5;pValue:Str10);
    function ReadSobAboTyp(pBookNum:Str5):byte;       procedure WriteSobAboTyp(pBookNum:Str5;pValue:byte);
    function ReadSobAboPat(pBookNum:Str5):Str80;      procedure WriteSobAboPat(pBookNum:Str5;pValue:Str80);
    function ReadSobAutAcc(pBookNum:Str5):boolean;    procedure WriteSobAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadSobDocQnt(pBookNum:Str5):word;       procedure WriteSobDocQnt(pBookNum:Str5;pValue:word);
    function ReadSobWriNum(pBookNum:Str5):word;       procedure WriteSobWriNum(pBookNum:Str5;pValue:word);
    function ReadSobPabNum(pBookNum:Str5):word;       procedure WriteSobPabNum(pBookNum:Str5;pValue:word);
    // OWB
    function ReadOwbDocSnt(pBookNum:Str5):Str3;       procedure WriteOwbDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadOwbDocAnl(pBookNum:Str5):Str6;       procedure WriteOwbDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadOwbVatSnt(pBookNum:Str5):Str3;       procedure WriteOwbVatSnt(pBookNum:Str5;pValue:Str3);
    function ReadOwbVatAnl(pBookNum:Str5):Str6;       procedure WriteOwbVatAnl(pBookNum:Str5;pValue:Str6);
    function ReadOwbExnFrm(pBookNum:Str5):Str12;      procedure WriteOwbExnFrm(pBookNum:Str5;pValue:Str12);
    function ReadOwbAutAcc(pBookNum:Str5):boolean;    procedure WriteOwbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadOwbVatCls(pBookNum:Str5):boolean;    procedure WriteOwbVatCls(pBookNum:Str5;pValue:boolean);
    function ReadOwbDvzNam(pBookNum:Str5;pNum:byte):Str3;       procedure WriteOwbDvzNam(pBookNum:Str5;pNum:byte;pValue:Str3);
    function ReadOwbCsdBok(pBookNum:Str5;pNum:byte):Str5;       procedure WriteOwbCsdBok(pBookNum:Str5;pNum:byte;pValue:Str5);
    function ReadOwbPabNum(pBookNum:Str5):word;       procedure WriteOwbPabNum(pBookNum:Str5;pValue:word);
    // SVB
    function ReadSvbDocSnt(pBookNum:Str5):Str3;       procedure WriteSvbDocSnt(pBookNum:Str5;pValue:Str3);
    function ReadSvbDocAnl(pBookNum:Str5):Str6;       procedure WriteSvbDocAnl(pBookNum:Str5;pValue:Str6);
    function ReadSvbVatSnt(pBookNum:Str5):Str3;       procedure WriteSvbVatSnt(pBookNum:Str5;pValue:Str3);
    function ReadSvbVatAnl(pBookNum:Str5):Str6;       procedure WriteSvbVatAnl(pBookNum:Str5;pValue:Str6);
    function ReadSvbExnFrm(pBookNum:Str5):Str12;      procedure WriteSvbExnFrm(pBookNum:Str5;pValue:Str12);
    function ReadSvbAutAcc(pBookNum:Str5):boolean;    procedure WriteSvbAutAcc(pBookNum:Str5;pValue:boolean);
    function ReadSvbWriSha(pBookNum:Str5):boolean;    procedure WriteSvbWriSha(pBookNum:Str5;pValue:boolean);
    function ReadSvbAccNeg(pBookNum:Str5):boolean;    procedure WriteSvbAccNeg(pBookNum:Str5;pValue:boolean);
    function ReadSvbDvzNam(pBookNum:Str5):Str3;       procedure WriteSvbDvzNam(pBookNum:Str5;pValue:Str3);
    function ReadSvbWriNum(pBookNum:Str5):word;       procedure WriteSvbWriNum(pBookNum:Str5;pValue:word);
    // IDB
    function ReadIdbWriNum(pBookNum:Str5):word;       procedure WriteIdbWriNum(pBookNum:Str5;pValue:word);
    function ReadIdbWriAdd(pBookNum:Str5):boolean;    procedure WriteIdbWriAdd(pBookNum:Str5;pValue:boolean);
    function ReadIdbAutAcc(pBookNum:Str5):boolean;    procedure WriteIdbAutAcc(pBookNum:Str5;pValue:boolean);
    // ACB
    function ReadAcbPlsNum(pBookNum:Str5):word;       procedure WriteAcbPlsNum(pBookNum:Str5;pValue:word);
    function ReadAcbRndTyp(pBookNum:Str5):integer;    procedure WriteAcbRndTyp(pBookNum:Str5;pValue:integer);
    function ReadAcbPrnMor:boolean;    procedure WriteAcbPrnMor(pValue:boolean);

  public
    ohKEYDEF:TKeydefHnd;
    procedure CopyBokKey(pPmdMark:Str3;pSrcBok,pTrgBok:Str5); // Prekopiruje vsetky vlastnosti zdrojovej knihy do cielovej
    // SYS
    property Sys:TSysKey read oSys write oSys;
    property Nes:TNesKey read oNes write oNes;
    property Stk:TStkKey read oStk write oStk;
    property Tes:TTesKey read oTes write oTes;
    property Whs:TWhsKey read oWhs write oWhs;

    property Gsc:TGscKey read oGsc write oGsc;
    property Apl:TAplKey read oApl write oApl;
    property Osb:TOsbKey read oOsb write oOsb;
    property Emc:TEmcKey read oEmc write oEmc;
    property Ocm:TOcmKey read oOcm write oOcm;
    property Icm:TIcmKey read oIcm write oIcm;
    property Dir:TDirKey read oDir write oDir;
    property Prm:TPrmKey read oPrm write oPrm;
    property Prb:TPrbKey read oPrb write oPrb;
    property Crb:TCrbKey read oCrb write oCrb;
    property Ksb:TKsbKey read oKsb write oKsb;
    property Scm:TScmKey read oScm write oScm;
    property Xrm:TXrmKey read oXrm write oXrm;

    property RegName:Str60 read ReadRegName write WriteRegName;  // Registrovan˝ n·zov vlastnÌka
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;  // Registrovan· adresa vlastnÌka
    property RegZip:Str15 read ReadRegZip write WriteRegZip;     // PS» registrovaej adersy vlastnÌka
    property RegCty:Str3 read ReadRegCty write WriteRegCty;      // KÛd mesta registrovanej adresy vlastnÌka
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;     // N·zov mesta registrovanej adresy vlastnÌka
    property RegSta:Str2 read ReadRegSta write WriteRegSta;      // N·zov öt·tu registrovanej adresy vlastnÌka
    property RegStn:Str30 read ReadRegStn write WriteRegStn;     // N·zov öt·tu registrovanej adresy vlastnÌka
    property RegRec:Str80 read ReadRegRec write WriteRegRec;     // Za·znam vobchodnom registri
    property RegWeb:Str50 read ReadRegWeb write WriteRegWeb;     // Internetov· domov· str·vka vlastnÌka
    property HedName:Str30 read ReadHedName write WriteHedName;  // Konateæ alebo majiteæ spoloùnosti
    property SysFixCrs:double read ReadSysFixCrs write WriteSysFixCrs;  // Konverzny kurz na EUR prechod
    property SysInfDvz:Str3 read ReadSysInfDvz write WriteSysInfDvz;    // INFO mena na EUR prechod
    property SysAttPat:Str80 read ReadSysAttPat write WriteSysAttPat;   // Adresar priloh dokladov
    property SysAttCpy:boolean read ReadSysAttCpy write WriteSysAttCpy; // Kopirovanie priloh dokladov do vlastneho adresara
    property SysAccDvz:Str3 read ReadSysAccDvz write WriteSysAccDvz;    // Uctovna mena
    property SysMsuRnd:byte read ReadSysMsuRnd write WriteSysMsuRnd;    // Sposob zaokruhlenia mernej ceny
    property SysMsuFrc:byte read ReadSysMsuFrc write WriteSysMsuFrc;    // Pocetdesatinnych miest zaokruhlenia mernej ceny
    property SysGsnSrc:byte read ReadSysGsnSrc write WriteSysGsnSrc;    // Vyhladavanie tovaru podla casti nazvu: 0-zrychlene; 1-sekvencialne
    property SysAcvFrc:byte read ReadSysAcvFrc write WriteSysAcvFrc;    // Pocet desatinnych miest zaokruhlenia hodnoty riadku dokladu v uctovnej mene
    property SysFgpFrc:byte read ReadSysFgpFrc write WriteSysFgpFrc;    // Pocet desatinnych miest zaokruhlenia jednotkovej ceny riadku dokladu vo vyuctovnej mene
    property SysFgvFrc:byte read ReadSysFgvFrc write WriteSysFgvFrc;    // Pocet desatinnych miest zaokruhlenia hodnoty  riadku dokladu vo vyuctovnej mene
    property SysNrdFrc:byte read ReadSysNrdFrc write WriteSysNrdFrc;    // Pocet desatinnych miest pre hodnoty, ktore nie su zaokruhlene
    property SysFjrSig:boolean read ReadSysFjrSig write WriteSysFjrSig; // Generovaù peÚaûn˝ dennÌk podæa znamienka ˙hradu (TRUE); podæa typu fakt˙ry (FALSE)
    property SysSpeLev:boolean read ReadSysSpeLev write WriteSysSpeLev; // Povolit pouzitie viacerych cenovych hladin
    property SysMaxScr:boolean read ReadSysMaxScr write WriteSysMaxScr; // Zobazit maximalizovane okno aplikacie
    property SysPyeAdd:boolean read ReadSysPyeAdd write WriteSysPyeAdd; // Povolit pridavanie dokladov do knih predhcadzajucich rokov
    property SysEdiSpc:boolean read ReadSysEdiSpc write WriteSysEdiSpc; // Identifikatorom pre medizfiremnu komunikaciu je öpecifikaËn˝ kÛd
    property SysEdiPce:boolean read ReadSysEdiPce write WriteSysEdiPce; // Prenos doporuËenej (cennÌkovej) predajnej ceny
//    property SysAdvGsc[pVatGrp:byte]:longint read ReadSysAdvGsc write WriteSysAdvGsc; // PLU prijmu zalohovej platby
//    property SysAdvGsc:longint read ReadSysAdvGsc write WriteSysAdvGsc; // PLU prijmu zalohovej platby
//    property SysAdwGsc[pVatGrp:byte]:longint read ReadSysAdwGsc write WriteSysAdwGsc; // PLU cerpania zalohovej platby
//    property SysAdoGsc:longint read ReadSysAdoGsc write WriteSysAdoGsc; // PLU cerpanej zalohy
//    property SysAdgGsc:longint read ReadSysAdgGsc write WriteSysAdgGsc; // PLU tovaru v starej sadzbe zalohy
    property SysSinVal:double  read ReadSysSinVal write WriteSysSinVal; // Maximalna hodnota zjednodusenej faktury
    // ⁄ËtovnÌctvo
    property SysAutReg:boolean read ReadSysAutReg write WriteSysAutReg; // Automaticky zaevidovaù systÈmom vytvorenÈ ˙Ëty do ˙Ëtovnej osnovy analytick˝ch ˙Ëtov
    property SysAnlReg:boolean read ReadSysAnlReg write WriteSysAnlReg; // Neza˙Ëtovaù doklad ak niektor˝ z ˙Ëtov sa nenach·dza v ˙Ëtovnej osnove analytick˝ch ˙Ëtov

    // HRS - Hotelovy a rezervacny system
    property HrsAutNam[pAutName:byte]:Str20 read ReadHrsAutNam write WriteHrsAutNam; //
    property HrsCrdPor:Str4 read ReadHrsCrdPor write WriteHrsCrdPor; //
    property HrsCrdBau:Str6 read ReadHrsCrdBau write WriteHrsCrdBau; //
    property HrsCrdPar:Str1 read ReadHrsCrdPar write WriteHrsCrdPar; //
    property HrsCrdDat:Str1 read ReadHrsCrdDat write WriteHrsCrdDat; //
    property HrsCrdStp:Str1 read ReadHrsCrdStp write WriteHrsCrdStp; //
    property HrsCrdDev:byte read ReadHrsCrdDev write WriteHrsCrdDev; //
    property HrsCrdHou:byte read ReadHrsCrdHou write WriteHrsCrdHou; //
    property HrsOnitIp:Str15 read ReadHrsOnitIp write WriteHrsOnitIp; //
    property HrsHeatIp:Str15 read ReadHrsHeatIp write WriteHrsHeatIp; //
    property HrsHeatPor:Str5 read ReadHrsHeatPor write WriteHrsHeatPor; //
    property HrsIncTime:Str5 read ReadHrsIncTime write WriteHrsIncTime; //
    property HrsHeaLog:boolean read ReadHrsHeaLog write WriteHrsHeaLog; //
    property HrsEvnPln:boolean read ReadHrsEvnPln write WriteHrsEvnPln; // Vykurovanie
    property HrsUseTnr:boolean read ReadHrsUseTnr write WriteHrsUseTnr; // PripomienkovaË
    property HrsCrdPrg:boolean read ReadHrsCrdPrg write WriteHrsCrdPrg; // Programator kariet
    property HrsCadFmd:boolean read ReadHrsCadFmd write WriteHrsCadFmd; // Vyuctovanie dokladu cez FMS
    property HrsTcdGen:boolean read ReadHrsTcdGen write WriteHrsTcdGen; // Vydaj otvaru cez ODL a nie cez SV
    property HrsStkNum:integer read ReadHrsStkNum write WriteHrsStkNum; // Sklad vydaja tovarov a vyrobkov hoteloveho systemu
    property HrsWriNum:integer read ReadHrsWriNum write WriteHrsWriNum; // Prevadzka hoteloveho systemu
    property HrsCasNum:integer read ReadHrsCasNum write WriteHrsCasNum; // Cislo pokladne hoteloveho systemu
    property HrsEvbTim:integer read ReadHrsEvbTim write WriteHrsEvbTim; // Casovac pripomienok
    // SHP - E-Shop
    property ShpOrdFrm:byte read ReadShpOrdFrm write WriteShpOrdFrm;    // Format dokladu elektronickej objednavky z E-Shopu
    // MAR
    property MarNpyIcb:Str200 read ReadMarNpyIcb write WriteMarNpyIcb; // Zoznam knih OF na vypocet neuhradenych FA
    property MarNpiTcb:Str200 read ReadMarNpiTcb write WriteMarNpiTcb; // Zoznam knih OD na vypocet nevyfakturovanych DL
    property MarAdvGsc:longint read ReadMarAdvGsc write WriteMarAdvGsc; // PLU karty prijatej zalohy
    property MarCmpGsc:longint read ReadMarCmpGsc write WriteMarCmpGsc; // PLU komplementarnej doplnkovej polozky
    // CRD
    property CrdSerNum:longint read ReadCrdSerNum write WriteCrdSerNum;// Posledne vydane poradove cislo karty
    property CrdOutNum:longint read ReadCrdOutNum write WriteCrdOutNum;// Posledne vydane poradove cislo v˝dajkovÈho dokladu
    property CrdBacFrm:Str15 read ReadCrdBacFrm write WriteCrdBacFrm;  // Format ciaroveho kodu zakaznickej karty
    property CrdPabNum:word read ReadCrdPabNum write WriteCrdPabNum;   // »Ìslo knihy partnerov
    property CrdTrnBon:double read ReadCrdTrnBon write WriteCrdTrnBon; // Hodnota zakazickeho bonusu pre bonusov˙ kartu
    property CrdTrnDsc:double read ReadCrdTrnDsc write WriteCrdTrnDsc; // Hodnota zakazickeho bonusu pre zæavov˙ kartu
    property CrdTrnBci:double read ReadCrdTrnBci write WriteCrdTrnBci; // Hodnota zakazickeho bonusu pre obchodn˙ kartu
    property CrdBonPay:double read ReadCrdBonPay write WriteCrdBonPay; // Hodnota bonusu pri ËerpanÌ
    property CrdDscPrc:double read ReadCrdDscPrc write WriteCrdDscPrc; // Prednastavena diskontna zlava
    property CrdCasRef:boolean read ReadCrdCasRef write WriteCrdCasRef;// Vytvaranie REF suboru pre pokladne
    // WRI
    property WriPaCode[pWriNum:word]:longint read ReadWriPaCode write WriteWriPaCode; // KÛd partnera, keÔ prev·dzku pouûÌvame ako extern˙ firmu
    property WriOcbNum[pWriNum:word]:Str5 read ReadWriOcbNum write WriteWriOcbNum; // Kniha zakazie pre automaticke ukladanie zakaziek
    // PAB
    property PabNumIno:boolean read ReadPabNumIno write WritePabNumIno; // Ak je zapnuty I»O moze byt len ciselny udaj
    property PabSrcLic:str20   read ReadPabSrcLic write WritePabSrcLic; // Cislo licencie na predaj liehu
    // SRB
    property SrbStmCod:str60   read ReadSrbStmCod write WriteSrbStmCod; // Zoznam sklad. kodov inv. rozdielov
    // DSC
    property DscFgCode:str60   read ReadDscFgCode write WriteDscFgCode; // Zoznam financnych skupin pre tabulkovy zoznam
    property DscRefGen:boolean read ReadDscRefGen write WriteDscRefGen; // Zapisovanie zmien pre pokladne
    // BLC
    property BlcPrvYea:boolean read ReadBlcPrvYea write WriteBlcPrvYea; // Vypocet predosleho roku z aktualneho roka
    // ACC
    property AccAcYear:Str4 read ReadAccAcYear write WriteAccAcYear; // Rok Obratovej predvahy
    // VTR
    property VtrDocCls:boolean read ReadVtrDocCls write WriteVtrDocCls; // Uzatvoriù zapoËÌtanÈ daÚovÈ doklady
    property VtrMthQnt:byte read ReadVtrMthQnt write WriteVtrMthQnt;  // Zdanovacie obdobie - poËet mesiacov
    property VtrTaxOff:Str60 read ReadVtrTaxOff write WriteVtrTaxOff; // Danovy urad
    property VtrAutNam:Str30 read ReadVtrAutNam write WriteVtrAutNam; // Meno a priezvisko konaj˙cej osoby
    property VtrAutTel:Str15 read ReadVtrAutTel write WriteVtrAutTel; // TelefÛnne ËÌslo konaj˙cej osoby
    property VtrAutEml:Str30 read ReadVtrAutEml write WriteVtrAutEml; // Emaiolv· adresa konaj˙cej osoby
    property VtrRegStr:Str30 read ReadVtrRegStr write WriteVtrRegStr; // Adresa - ulica
    property VtrRegNum:Str10 read ReadVtrRegNum write WriteVtrRegNum; // Adresa - ËÌslo domu
    property VtrRegStn:Str30 read ReadVtrRegStn write WriteVtrRegStn; // Adresa - Stat
    property VtrRegCtn:Str30 read ReadVtrRegCtn write WriteVtrRegCtn; // Adresa - obec
    property VtrRegZip:Str5 read ReadVtrRegZip write WriteVtrRegZip;  // Adresa - PS»
    property VtrRegTel:Str15 read ReadVtrRegTel write WriteVtrRegTel; // TelefÛnne ËÌslo
    property VtrRegFax:Str15 read ReadVtrRegFax write WriteVtrRegFax; // FaxovÈ ËÌslo
    property VtrRegEml:Str60 read ReadVtrRegEml write WriteVtrRegEml; // EMail
    // PLS
    property PlsSapFrc[pPlsNum:word]:byte    read ReadPlsSapFrc write WritePlsSapFrc; // Pocet desatinnych miest na ktory bude zaokruhlena predajna cena
    property PlsSapRnd[pPlsNum:word]:byte    read ReadPlsSapRnd write WritePlsSapRnd; // Sposob zaokruhlenia predajnej ceny - 0-matematicke; 1-dole; 2-hore
    property PlsRefDia[pPlsNum:word]:boolean read ReadPlsRefDia write WritePlsRefDia; // Export do REF aj s diakritikou
    // STK
    property StpRndFrc:byte read ReadStpRndFrc write WriteStpRndFrc; // Zaokruhlenie jednotkovej skladovej ceny
    property StqRndFrc:byte read ReadStqRndFrc write WriteStqRndFrc; // Zaokruhlenie skladoveho mnozstva
    property StvRndFrc:byte read ReadStvRndFrc write WriteStvRndFrc; // Zaokruhlenie hodnoty NC
    property StkNulPrc:boolean read ReadStkNulPrc write WriteStkNulPrc; // Ci je povolene prijmat s nulovou NC

    property StkScType[pBookNum:Str5]:Str1 read ReadStkScType write WriteStkScType;    // Typ skladu (T-tovarov˝,M-materi·lov˝,V-v˝robn˝)
    property StkWriNum[pBookNum:Str5]:longint read ReadStkWriNum write WriteStkWriNum;    // »Ìslo prev·dzkovej jednotky, ktorej je priraden˝ sklad
    property StkPlsNum[pBookNum:Str5]:longint read ReadStkPlsNum write WriteStkPlsNum;    // »Ìslo pripojenÈho cennÌka
    property StkShared[pBookNum:Str5]:boolean read ReadStkShared write WriteStkShared; // Priznak zdielania sklad - zmeny su odoslane cez FTP (1-zdileany)
    property StkRsvOcd[pBookNum:Str5]:boolean read ReadStkRsvOcd write WriteStkRsvOcd; // Ci sa maju automaticky rezervovat polozky zakaziek pri prijme tovaru na sklad
    // CMB
    property CmbOnlSub[pBookNum:Str5]:boolean read ReadCmbOnlSub write WriteCmbOnlSub; // Online vydaj komponentov zo skladu
    property CmbStkNum[pBookNum:Str5]:word read ReadCmbStkNum write WriteCmbStkNum; // »islo skladu prÌjmu
    property CmbSmCode[pBookNum:Str5]:word read ReadCmbSmCode write WriteCmbSmCode; // »Ìseln˝ kÛd skladovÈho pohybu
    property CmbPlsNum[pBookNum:Str5]:word read ReadCmbPlsNum write WriteCmbPlsNum; // »Ìslo cennika
    // Dmb
    property DmbOnlSub[pBookNum:Str5]:boolean read ReadDmbOnlSub write WriteDmbOnlSub; // Online vydaj komponentov zo skladu
    property DmbStkNuI[pBookNum:Str5]:word read ReadDmbStkNuI write WriteDmbStkNuI; // »islo skladu prÌjmu
    property DmbStkNuO[pBookNum:Str5]:word read ReadDmbStkNuO write WriteDmbStkNuO; // »Ìslo skladu vydaja
    property DmbPlsNum[pBookNum:Str5]:word read ReadDmbPlsNum write WriteDmbPlsNum; // »Ìslo cennika
    property DmbSmCodI[pBookNum:Str5]:word read ReadDmbSmCodI write WriteDmbSmCodI; // »islo pohybu prÌjmu
    property DmbSmCodO[pBookNum:Str5]:word read ReadDmbSmCodO write WriteDmbSmCodO; // »Ìslo pohybu vydaja
    // CDB
    property CdbOnlSub[pBookNum:Str5]:boolean read ReadCdbOnlSub write WriteCdbOnlSub; // Online vydaj komponentov zo skladu
    property CdbStkNuI[pBookNum:Str5]:word read ReadCdbStkNuI write WriteCdbStkNuI; // »islo skladu prÌjmu
    property CdbStkNuO[pBookNum:Str5]:word read ReadCdbStkNuO write WriteCdbStkNuO; // »Ìslo skladu vydaja
    property CdbPlsNum[pBookNum:Str5]:word read ReadCdbPlsNum write WriteCdbPlsNum; // »Ìslo cennika
    property CdbSmCodI[pBookNum:Str5]:word read ReadCdbSmCodI write WriteCdbSmCodI; // »islo pohybu prÌjmu
    property CdbSmCodO[pBookNum:Str5]:word read ReadCdbSmCodO write WriteCdbSmCodO; // »Ìslo pohybu vydaja
    property CdbCpiBok[pBookNum:Str5]:word read ReadCdbCpiBok write WriteCdbCpiBok; // »Ìslo cennika
    // IMB
    property ImbOnlSub[pBookNum:Str5]:boolean read ReadImbOnlSub write WriteImbOnlSub; // Online vydaj tovaru zo skladu
    property ImbBpcMod[pBookNum:Str5]:boolean read ReadImbBpcMod write WriteImbBpcMod; // Povolenie zmeny predajne ceny polozky
    property ImbSpcMov[pBookNum:Str5]:boolean read ReadImbSpcMov write WriteImbSpcMov; // Povolit pozicny presun
    property ImbStkNum[pBookNum:Str5]:word read ReadImbStkNum write WriteImbStkNum; // »islo skladu prÌjmu
    property ImbSmCode[pBookNum:Str5]:word read ReadImbSmCode write WriteImbSmCode; // »Ìseln˝ kÛd skladovÈho pohybu
    property ImbPlsNum[pBookNum:Str5]:word read ReadImbPlsNum write WriteImbPlsNum; // »Ìslo cennika
    property ImbAutAcc[pBookNum:Str5]:boolean read ReadImbAutAcc write WriteImbAutAcc; // AutomatickÈ roz˙Ëtovanie dokladu (1-zapnute)
    property ImbFtpRcv[pBookNum:Str5]:boolean read ReadImbFtpRcv write WriteImbFtpRcv; // Prijem  dokladu z FTP
    property ImbDlvDay[pBookNum:Str5]:word read ReadImbDlvDay write WriteImbDlvDay; // Pocet dni dodavky od vytvorenia dokladu prijmu TOVAR NA CESTE
    // OMB
    property OmbOnlRwd[pBookNum:Str5]:boolean read ReadOmbOnlRwd write WriteOmbOnlRwd; // Online vytvorenie medzipervadzkovej prijemky
    property OmbOnlSub[pBookNum:Str5]:boolean read ReadOmbOnlSub write WriteOmbOnlSub; // Online vydaj tovaru zo skladu
    property OmbBpcMod[pBookNum:Str5]:boolean read ReadOmbBpcMod write WriteOmbBpcMod; // Povolenie zmeny predajne ceny polozky
    property OmbSpcMov[pBookNum:Str5]:boolean read ReadOmbSpcMov write WriteOmbSpcMov; // Povolit pozicny presun
    property OmbStkNum[pBookNum:Str5]:word read ReadOmbStkNum write WriteOmbStkNum; // »islo skladu prÌjmu
    property OmbSmCode[pBookNum:Str5]:word read ReadOmbSmCode write WriteOmbSmCode; // »Ìseln˝ kÛd skladovÈho pohybu
    property OmbPlsNum[pBookNum:Str5]:word read ReadOmbPlsNum write WriteOmbPlsNum; // »Ìslo cennika
    property OmbAutAcc[pBookNum:Str5]:boolean read ReadOmbAutAcc write WriteOmbAutAcc; // AutomatickÈ roz˙Ëtovanie dokladu (1-zapnute)
    property OmbFtpSnd[pBookNum:Str5]:boolean read ReadOmbFtpSnd write WriteOmbFtpSnd; // Posielanie dokladu cez FTP
    property OmbImbStk[pBookNum:Str5]:word read ReadOmbImbStk write WriteOmbImbStk; // »islo skladu prÌjmu
    property OmbImbSmc[pBookNum:Str5]:word read ReadOmbImbSmc write WriteOmbImbSmc; // »Ìseln˝ kÛd skladovÈho pohybu prijemky
    property OmbImbNum[pBookNum:Str5]:Str5 read ReadOmbImbNum write WriteOmbImbNum; // Kniha prijemok
    // RMB
    property RmbBoYear[pBookNum:Str5]:Str4 read ReadRmbBoYear write WriteRmbBoYear; // Rok, na ktor˝ je zaloûen· kniha
    property RmbWriNum[pBookNum:Str5]:word read ReadRmbWriNum write WriteRmbWriNum; // »Ìslo prev·dzkovej jednotky
    property RmbOutStn[pBookNum:Str5]:word read ReadRmbOutStn write WriteRmbOutStn; // »islo skladu v˝daja
    property RmbIncStn[pBookNum:Str5]:word read ReadRmbIncStn write WriteRmbIncStn; // Csilo skladu prikmu
    property RmbOutSmc[pBookNum:Str5]:word read ReadRmbOutSmc write WriteRmbOutSmc; // Skladovy pohyb vydaja tovaru
    property RmbIncSmc[pBookNum:Str5]:word read ReadRmbIncSmc write WriteRmbIncSmc; // Skladovy pohyb prijmu tovaru
    property RmbAutAcc[pBookNum:Str5]:boolean read ReadRmbAutAcc write WriteRmbAutAcc; // Automaticke rozuctovanie dokladu
    property RmbOnlSub[pBookNum:Str5]:boolean read ReadRmbOnlSub write WriteRmbOnlSub; // Prebezny skladovy prijem a vydaj (1-zapnuty)
    property RmbSpcMov[pBookNum:Str5]:boolean read ReadRmbSpcMov write WriteRmbSpcMov; // Povolit pozicny presun
    property RmbItmFrm[pBookNum:Str5]:byte read ReadRmbItmFrm write WriteRmbItmFrm; // Cislo formulara pre polozku dokladu
    // PKB
    property PkbStkNum[pBookNum:Str5]:word read ReadPkbStkNum write WritePkbStkNum; // »islo skladu prÌjmu
    property PkbSrcSmc[pBookNum:Str5]:word read ReadPkbSrcSmc write WritePkbSrcSmc; // »Ìseln˝ kÛd skladovÈho pohybu vydaja
    property PkbPlsNum[pBookNum:Str5]:word read ReadPkbPlsNum write WritePkbPlsNum; // »Ìslo cennika
    property PkbTrgSmc[pBookNum:Str5]:word read ReadPkbTrgSmc write WritePkbTrgSmc; // »Ìseln˝ kÛd skladovÈho pohybu prijmu
    // TSB
    property TsbBoYear[pBookNum:Str5]:Str4 read ReadTsbBoYear write WriteTsbBoYear; // Rok, na ktor˝ je zaloûen· kniha
    property TsbWriNum[pBookNum:Str5]:word read ReadTsbWriNum write WriteTsbWriNum; // »Ìslo prev·dzkovej jednotky
    property TsbStkNum[pBookNum:Str5]:word read ReadTsbStkNum write WriteTsbStkNum; // »islo skladu prÌjmu
    property TsbPlsNum[pBookNum:Str5]:word read ReadTsbPlsNum write WriteTsbPlsNum; // »Ìslo predajnÈho cennÌka
    property TsbTsdRcv[pBookNum:Str5]:word read ReadTsbTsdRcv write WriteTsbTsdRcv; // »Ìslo formulara prenosoveho suboru
    property TsbDvName[pBookNum:Str5]:Str3 read ReadTsbDvName write WriteTsbDvName; // N·zov meny v ktorom je veden· kniha
    property TsbPabNum[pBookNum:Str5]:word read ReadTsbPabNum write WriteTsbPabNum; // »Ìslo knihy partnerov
    property TsbDefPac[pBookNum:Str5]:longint read ReadTsbDefPac write WriteTsbDefPac; // »Ìseln˝ kÛd predvolenÈho dod·vatela
    property TsbSmCode[pBookNum:Str5]:word read ReadTsbSmCode write WriteTsbSmCode; // »Ìseln˝ kÛd skladovÈho pohybu
    property TsbAutAcc[pBookNum:Str5]:boolean read ReadTsbAutAcc write WriteTsbAutAcc; // AutomatickÈ roz˙Ëtovanie dokladu (1-zapnute)
    property TsbOnlSub[pBookNum:Str5]:boolean read ReadTsbOnlSub write WriteTsbOnlSub; // Priebeûn˝ prÌjem tovaru na sklad
    property TsbBcsVer[pBookNum:Str5]:boolean read ReadTsbBcsVer write WriteTsbBcsVer; // Kontrola obchodn˝ch podmienok
    property TsbRevClc[pBookNum:Str5]:boolean read ReadTsbRevClc write WriteTsbRevClc; // V˝poËet n·kupnej ceny na z·klade predajnej
    property TsbIsbNum[pBookNum:Str5]:Str5 read ReadTsbIsbNum write WriteTsbIsbNum; // »Ìslo knihy dod·vateæsk˝ch fakt˙r
    property TsbAgnTcb[pBookNum:Str5]:Str5 read ReadTsbAgnTcb write WriteTsbAgnTcb; // Kniha OD pre automatickÈ generovanie dokladov
    property TsbAgnIcb[pBookNum:Str5]:Str5 read ReadTsbAgnIcb write WriteTsbAgnIcb; // Kniha OF pre automatickÈ generovanie dokladov
    property TsbAgnPac[pBookNum:Str5]:longint read ReadTsbAgnPac write WriteTsbAgnPac; // Predvolen˝ odberateæ na automatickÈ generovanie odbytov˝ch dokladov
    property TsbAgnPrf[pBookNum:Str5]:double read ReadTsbAgnPrf write WriteTsbAgnPrf; // Percentu·lna prir·ûka na z·klade ktorÈho bud˙ vypoËÌtanÈ ceny odbytov˝ch dokladov
    property TsbAutPkb[pBookNum:Str5]:Str5 read ReadTsbAutPkb write WriteTsbAutPkb; // Kniha na automatickÈ prebalenie tovaru
    property TsbAcqGsc[pBookNum:Str5]:boolean read ReadTsbAcqGsc write WriteTsbAcqGsc; // Zakladne nastavenie komisionalneho tovaru - cela kniha je pre komisionalny tovar
    property TsbPlsMod[pBookNum:Str5]:boolean read ReadTsbPlsMod write WriteTsbPlsMod; // Zmeniù predajnÈ ceny
    property TsbPrnCls[pBookNum:Str5]:boolean read ReadTsbPrnCls write WriteTsbPrnCls; // Uzamkn˙ù doklad po vytlaËenÌ
    property TsbPckMgc:Str60 read ReadTsbPckMgc write WriteTsbPckMgc; // Tovarove skupiny pre vykaz obalov
    // PSB
    property PsbBoYear[pBookNum:Str5]:Str4 read ReadPsbBoYear write WritePsbBoYear; // Rok, na ktor˝ je zaloûen· kniha
    property PsbExnFrm[pBookNum:Str5]:Str20 read ReadPsbExnFrm write WritePsbExnFrm; // Format variabilneho symbolu
    property PsbStkNum[pBookNum:Str5]:word read ReadPsbStkNum write WritePsbStkNum; // »islo skladu
    property PsbWriNum[pBookNum:Str5]:word read ReadPsbWriNum write WritePsbWriNum; // »islo prevadzky
    property PsbDvName[pBookNum:Str5]:Str3 read ReadPsbDvName write WritePsbDvName; // N·zov meny v ktorom je veden· kniha
    property PsbPabNum[pBookNum:Str5]:word read ReadPsbPabNum write WritePsbPabNum; // »Ìslo knihy partnerov
    property PsbOsbNum[pBookNum:Str5]:Str5 read ReadPsbOsbNum write WritePsbOsbNum; // »Ìslo knihy Objednavok
    property PsbClcTyp[pBookNum:Str5]:byte read ReadPsbClcTyp write WritePsbClcTyp; // Sposob vypoctu doporuceneho mnozstva na objednanie
    // ALB
    property AlbExnFrm[pBookNum:Str5]:Str12 read ReadAlbExnFrm write WriteAlbExnFrm;  // Format externeho cisla zapozickoveho dokladu
    property AlbSurPrc[pBookNum:Str5]:double read ReadAlbSurPrc write WriteAlbSurPrc; // Pozadovana kauci v percentach
    property AlbPenPrc[pBookNum:Str5]:double read ReadAlbPenPrc write WriteAlbPenPrc; // Penale za nedodrzanei lehoty vypozicky v percentach
    property AlbRdiPrc[pBookNum:Str5]:double read ReadAlbRdiPrc write WriteAlbRdiPrc; // Poplatok za spinavom stave vratene zariadenie v percentach
    property AlbRduPrc[pBookNum:Str5]:double read ReadAlbRduPrc write WriteAlbRduPrc; // Poplatok za poskodenom stave vratene zariadenie v percentach
    property AlbCsbNum[pBookNum:Str5]:Str5 read ReadAlbCsbNum write WriteAlbCsbNum; // Cisloknihy hotovostnej pokladne
    property AlbCsoInc[pBookNum:Str5]:word read ReadAlbCsoInc write WriteAlbCsoInc; // Kod hotovostnej operacie, ktora bude na prijmovom pokladnicnom doklade
    property AlbCsoExp[pBookNum:Str5]:word read ReadAlbCsoExp write WriteAlbCsoExp; // Kod hotovostnej operacie, ktora bude na vydajovom pokladnicnom doklade
    property AlbTcbNum[pBookNum:Str5]:Str5 read ReadAlbTcbNum write WriteAlbTcbNum; // Cisloknihy odberatelskych dodacich listov
    property AlbIcbNum[pBookNum:Str5]:Str5 read ReadAlbIcbNum write WriteAlbIcbNum; // Cisloknihy odberatelskych faktur
    property AlbRdiGsc[pBookNum:Str5]:longint read ReadAlbRdiGsc write WriteAlbRdiGsc; // PLU polozky prostrednictvom ktorej bude vyuctovany poplatok za spinavom stave vratene zariadenie
    property AlbRduGsc[pBookNum:Str5]:longint read ReadAlbRduGsc write WriteAlbRduGsc; // PLU polozky prostrednictvom ktorej bude vyuctovany poplatok za znicenom stave vratene zariadenie
    property AlbRndBva[pBookNum:Str5]:boolean read ReadAlbRndBva write WriteAlbRndBva; // Zaokruhlenie ceny s DPH
    property AlbAgpFrc[pBookNum:Str5]:byte read ReadAlbAgpFrc write WriteAlbAgpFrc; // Pocet desatinnnych miest jednotkovej ceny hodnoty prenajateho zariadenia
    property AlbAgvFrc[pBookNum:Str5]:byte read ReadAlbAgvFrc write WriteAlbAgvFrc; // Pocet desatinnnych miest celkovej hodnoty prenajateho zariadenia
    property AlbAspFrc[pBookNum:Str5]:byte read ReadAlbAspFrc write WriteAlbAspFrc; // Pocet desatinnnych miest jednotkovej ceny hodnoty prenajateho zariadenia
    property AlbAsvFrc[pBookNum:Str5]:byte read ReadAlbAsvFrc write WriteAlbAsvFrc; // Pocet desatinnnych miest celkovej hodnoty prenajateho zariadenia
    property AlbLasNit[pBookNum:Str5]:boolean read ReadAlbLasNit write WriteAlbLasNit; // Ak je TRUE - novu polozku vzdy pridavat na konci
    property AlbExpDay[pBookNum:Str5]:word read ReadAlbExpDay write WriteAlbExpDay; // Pocet dni platnosti cenovej ponuky
    property AlbStkNum[pBookNum:Str5]:longint read ReadAlbStkNum write WriteAlbStkNum; // Sklad zapozicky
    property AlbIcdSum[pBookNum:Str5]:boolean read ReadAlbIcdSum write WriteAlbIcdSum; // Kumulativne vyuctovanie najmu do jednej polozky
    property AlbRenGsc[pBookNum:Str5]:longint read ReadAlbRenGsc write WriteAlbRenGsc; // PLU sluzby prenajmu naradia
    property AlbRdnGsc[pBookNum:Str5]:longint read ReadAlbRdnGsc write WriteAlbRdnGsc; // PLU sluzby Zniceneho naradia
    property AlbNorGsc[pBookNum:Str5]:longint read ReadAlbNorGsc write WriteAlbNorGsc; // PLU sluzby strateneho naradia
    property AlbCasNum[pBookNum:Str5]:byte read ReadAlbCasNum write WriteAlbCasNum; // Cislo pokladne pre vyuctovanie
    // TIB
    property TibImbNum[pBookNum:Str5]:Str5 read ReadTibImbNum write WriteTibImbNum; // Kniha internych skladovych prijmov pre medziprevadzkovy presun
    property TibTsbNum[pBookNum:Str5]:Str5 read ReadTibTsbNum write WriteTibTsbNum; // Kniha doöl˝ch dodacich listov, kam bude vygenerovany doklad z terminalovej prijemky
    property TibOsbLst[pBookNum:Str5]:Str200 read ReadTibOsbLst write WriteTibOsbLst; // Zoznam knih objednavok z ktorych bude odpisany prijaty tovar
    property TibOcbLst[pBookNum:Str5]:Str200 read ReadTibOcbLst write WriteTibOcbLst; // Zoznam knih zakaziek z ktorych bude prijaty tovar rezervovany
    property TibWrmAut[pBookNum:Str5]:boolean read ReadTibWrmAut write WriteTibWrmAut; // Povoliù automatick˝ presun tovaru na in˙ prev·dzku
    property TibOsiPce[pBookNum:Str5]:boolean read ReadTibOsiPce write WriteTibOsiPce; // Povoliù vyhladavanie najlepsej NC z objednavok
    // TOB
    property TobSerNum[pBookNum:Str5]:longint read ReadTobSerNum write WriteTobSerNum; // Naposledy pouzite poradove cislo
    property TobSndFms[pBookNum:Str5]:boolean read ReadTobSndFms write WriteTobSndFms; // Poslaù uctenku na fiskalny server
    property TobTrmSer[pBookNum:Str5]:boolean read ReadTobTrmSer write WriteTobTrmSer; // Cislovanie dokladov Sernum podla terminalov
    property TobSadGen[pBookNum:Str5]:byte read ReadTobSadGen write WriteTobSadGen; // Typ vyuctovania terminalovej vydajky (0-klasicke;1-pozicne)
    property TobTcbNum[pBookNum:Str5]:Str5 read ReadTobTcbNum write WriteTobTcbNum; // Kniha odberatelskych dodacich listov, kam bude vygenerovany doklad z terminalovej vydajky
    property TobTcsNum[pBookNum:Str5]:Str5 read ReadTobTcsNum write WriteTobTcsNum; // Kniha odberatelskych dodacich listov, kam bude vygenerovany doËasn˝ ODL z terminalovej vydajky
    property TobIcbNum[pBookNum:Str5]:Str5 read ReadTobIcbNum write WriteTobIcbNum; // Kniha odberatelskych faktur, kam bude vygenerovany doklad z terminalovej vydajky
    property TobOmbNum[pBookNum:Str5]:Str5 read ReadTobOmbNum write WriteTobOmbNum; // Kniha Internych vydajok, kam bude vygenerovany doklad z terminalovej vydajky
    property TobOcbNum[pBookNum:Str5]:Str5 read ReadTobOcbNum write WriteTobOcbNum; // Kniha odberatelskych zakaziek, kam bude vygenerovany doklad z terminalovej vydajky
    property TobCasNum[pBookNum:Str5]:word read ReadTobCasNum write WriteTobCasNum; // »Ìslo pokladne kde naposledy bola vyuctovana terminalova vydajka
    property TobWriNum[pBookNum:Str5]:word read ReadTobWriNum write WriteTobWriNum; // Prednastaven8 prevadzkova jednotka
    property TobStkNum[pBookNum:Str5]:word read ReadTobStkNum write WriteTobStkNum; // Prednastaveny sklad odkial tovar bude vydany
    property TobIcbVer[pBookNum:Str5]:Str200 read ReadTobIcbVer write WriteTobIcbVer; // Zoznam knih z ktorych system kontroluje FA po splatnosti
    property TobOcuBok[pBookNum:Str5]:Str200 read ReadTobOcuBok write WriteTobOcuBok; // Knihy zakaziek, v ktorych sa zrusi rezervacia pri vyuctovani
    // POB
    property PobSerNum[pBookNum:Str5]:longint read ReadPobSerNum write WritePobSerNum; // Naposledy pouzite poradove cislo
    property PobSndFms[pBookNum:Str5]:boolean read ReadPobSndFms write WritePobSndFms; // Poslaù uctenku na fiskalny server
    property PobSadGen[pBookNum:Str5]:byte read ReadPobSadGen write WritePobSadGen; // Typ vyuctovania terminalovej vydajky (0-klasicke;1-pozicne)
    property PobTcbNum[pBookNum:Str5]:Str5 read ReadPobTcbNum write WritePobTcbNum; // Kniha odberatelskych dodacich listov, kam bude vygenerovany doklad z terminalovej vydajky
    property PobIcbNum[pBookNum:Str5]:Str5 read ReadPobIcbNum write WritePobIcbNum; // Kniha odberatelskych faktur, kam bude vygenerovany doklad z terminalovej vydajky
    property PobCasNum[pBookNum:Str5]:word read ReadPobCasNum write WritePobCasNum; // »Ìslo pokladne kde naposledy bola vyuctovana terminalova vydajka
    property PobWriNum[pBookNum:Str5]:word read ReadPobWriNum write WritePobWriNum; // Prednastaven8 prevadzkova jednotka
    property PobStkNum[pBookNum:Str5]:word read ReadPobStkNum write WritePobStkNum; // Prednastaveny sklad odkial tovar bude vydany
    property PobIcbVer[pBookNum:Str5]:Str200 read ReadPobIcbVer write WritePobIcbVer; // Zoznam knih z ktorych system kontroluje FA po splatnosti
    property PobOcuBok[pBookNum:Str5]:Str200 read ReadPobOcuBok write WritePobOcuBok; // Knihy zakaziek, v ktorych sa zrusi rezervacia pri vyuctovani
    // SCB
    property ScbCarEdi[pBookNum:Str5]:boolean read ReadScbCarEdi write WriteScbCarEdi; // UrËuje Ëi formul·r hlaviËky dokladu obsahuje aj ˙daje vozidla
    property ScbPlsNum[pBookNum:Str5]:longint read ReadScbPlsNum write WriteScbPlsNum; // Prednastaveny cennik hlavicky servisnej zakazky
    property SciPlsNum[pBookNum:Str5]:longint read ReadSciPlsNum write WriteSciPlsNum; // Prednastaveny cennik poloziek servisnej zakazky
    property ScbWriNum[pBookNum:Str5]:word read ReadScbWriNum write WriteScbWriNum; // Prednastaven· prevadzkov· jednotka
    property ScbImdStk[pBookNum:Str5]:word read ReadScbImdStk write WriteScbImdStk; // Sklad v˝daja tovaru
    property ScbOmdStk[pBookNum:Str5]:word read ReadScbOmdStk write WriteScbOmdStk; // Sklad prÌjmu tovaru
    property ScbImdSmc[pBookNum:Str5]:word read ReadScbImdSmc write WriteScbImdSmc; // Pohyb v˝daja tovaru
    property ScbOmdSmc[pBookNum:Str5]:word read ReadScbOmdSmc write WriteScbOmdSmc; // Pohyb prÌjmu tovaru
    property ScbImbNum[pBookNum:Str5]:Str5 read ReadScbImbNum write WriteScbImbNum; // Kniha intern˝ch skladov˝ch prÌjmov
    property ScbOmbNum[pBookNum:Str5]:Str5 read ReadScbOmbNum write WriteScbOmbNum; // Kniha intern˝ch skladov˝ch v˝dajov
    property ScbTcbNum[pBookNum:Str5]:Str5 read ReadScbTcbNum write WriteScbTcbNum; // Kniha odberatelskych Dl - dobropisy
    property ScbDvName[pBookNum:Str5]:Str3 read ReadScbDvName write WriteScbDvName; // Vy˙Ëtovacia mena danej knihy
    property ScbExnFmt[pBookNum:Str5]:Str12 read ReadScbExnFmt write WriteScbExnFmt; // Format externeho cisla dokladu
    property ScbReqPro[pBookNum:Str5]:boolean read ReadScbReqPro write WriteScbReqPro; // Povinne sledovanie postupnosti rieöenia
    // SPE
    property SpeMcbNum:Str5 read ReadSpeMcbNum write WriteSpeMcbNum; // Cislo knihy Proforma faktur prijmu zaloh
    // MCB
    property McbFgvDvz[pBookNum:Str5]:Str3 read ReadMcbFgvDvz write WriteMcbFgvDvz; // Vy˙Ëtovacia mena danej knihy
    property McbItmFrm[pBookNum:Str5]:byte read ReadMcbItmFrm write WriteMcbItmFrm; // Cislo formulara pre polozku dokladu
    property McbExnFmt[pBookNum:Str5]:Str12 read ReadMcbExnFmt write WriteMcbExnFmt; // Format externeho cisla dokladu
    property McbPrnCls[pBookNum:Str5]:boolean read ReadMcbPrnCls write WriteMcbPrnCls; // Uzatvorit doklad pojeho vytlaceni
    property McbPrjMcd[pBookNum:Str5]:boolean read ReadMcbPrjMcd write WriteMcbPrjMcd; // ProjektovÈ cenovÈ ponuky
    property McbDsHide[pBookNum:Str5]:boolean read ReadMcbDsHide write WriteMcbDsHide; // Skryt diskrÈtne ˙daje
    property McbRndBva[pBookNum:Str5]:boolean read ReadMcbRndBva write WriteMcbRndBva; // Zaokruhlenie ceny s DPH
    property McbShwPal[pBookNum:Str5]:boolean read ReadMcbShwPal write WriteMcbShwPal; // Zobraziù zoznam firiem  pri zaloûenÌ novÈho dokladu
    property McbVatRnd[pBookNum:Str5]:byte read ReadMcbVatRnd write WriteMcbVatRnd; // Zaokruhlenie DPH
    property McbDocRnd[pBookNum:Str5]:byte read ReadMcbDocRnd write WriteMcbDocRnd; // Zaokruhlenie hodnoty dokladu
    property McbWriNum[pBookNum:Str5]:word read ReadMcbWriNum write WriteMcbWriNum; // Priradena prevadzkova jednotka
    property McbStkNum[pBookNum:Str5]:word read ReadMcbStkNum write WriteMcbStkNum; // Priradeny sklad vydaja tovaru
    property McbPabNum[pBookNum:Str5]:word read ReadMcbPabNum write WriteMcbPabNum; // Cislo knihy odberatelov
    property McbOcbNum[pBookNum:Str5]:Str5 read ReadMcbOcbNum write WriteMcbOcbNum; // Cislo knihy odberatelskych zakaziek
    property McbTcbNum[pBookNum:Str5]:Str5 read ReadMcbTcbNum write WriteMcbTcbNum; // Cislo knihy odberatelskych dodacich listov
    property McbIcbNum[pBookNum:Str5]:Str5 read ReadMcbIcbNum write WriteMcbIcbNum; // Cislo knihy odberatelskych faktur
    property McbCdbNum[pBookNum:Str5]:Str5 read ReadMcbCdbNum write WriteMcbCdbNum; // Cislo knihy vyrobnych dokladov
    property McbOciDiv[pBookNum:Str5]:byte read ReadMcbOciDiv write WriteMcbOciDiv; // Pri generovani polozky zakazky ak je mnzostvo > volne ci sa rozdeli polozka na dve na rezervovanu a na poziadavku
    property McbPrfPrc[pBookNum:Str5]:double read ReadMcbPrfPrc write WriteMcbPrfPrc; // Vyska zalohy v %
    property McbDocSnt[pBookNum:Str5]:Str3 read ReadMcbDocSnt write WriteMcbDocSnt;  // Syntetick· Ëasù ˙Ëtu - odberatelia
    property McbDocAnl[pBookNum:Str5]:Str6 read ReadMcbDocAnl write WriteMcbDocAnl;  // Analytick· Ëast ˙Ëtu - odberatelia
    property McbExpDay[pBookNum:Str5]:word read ReadMcbExpDay write WriteMcbExpDay;  // Platnosù cenovej ponuky
    // OCB
    property OcbBoYear[pBookNum:Str5]:Str4 read ReadOcbBoYear write WriteOcbBoYear; // Rok, na ktor˝ je zaloûen· kniha
    property OcbExnFrm[pBookNum:Str5]:Str12 read ReadOcbExnFrm write WriteOcbExnFrm; // Form·t generovania externÈho ËÌsla
    property OcbDvName[pBookNum:Str5]:Str3 read ReadOcbDvName write WriteOcbDvName; // Vy˙Ëtovacia mena danej knihy
    property OcbAvtRnd[pBookNum:Str5]:byte read ReadOcbAvtRnd write WriteOcbAvtRnd; // Typ zaokruhlenia DPH z PC - ˙Ëtovn· mena
    property OcbAvlRnd[pBookNum:Str5]:byte read ReadOcbAvlRnd write WriteOcbAvlRnd; // Typ zaokruhlenia PC s DPH - ˙Ëtovn· mena
    property OcbFvtRnd[pBookNum:Str5]:byte read ReadOcbFvtRnd write WriteOcbFvtRnd; // Typ zaokruhlenia DPH z PC - vy˙Ëtovaciea mena
    property OcbFvlRnd[pBookNum:Str5]:byte read ReadOcbFvlRnd write WriteOcbFvlRnd; // Typ zaokruhlenia PC s DPH - vy˙Ëtovaciea mena
    property OcbItmEdi[pBookNum:Str5]:byte read ReadOcbItmEdi write WriteOcbItmEdi; // »Ìslo frmulara editora polziek dokladu
    property OcbDocEdi[pBookNum:Str5]:byte read ReadOcbDocEdi write WriteOcbDocEdi; // »Ìslo frmulara editora hlavicky dokladu
    property OcbIntDoc[pBookNum:Str5]:boolean read ReadOcbIntDoc write WriteOcbIntDoc; // Interna (vnutro firmana) zakazka
    property OcbNotRes[pBookNum:Str5]:boolean read ReadOcbNotRes write WriteOcbNotRes; // Nerezervovaù tovar naskladovej karte
    property OcbPrnCls[pBookNum:Str5]:boolean read ReadOcbPrnCls write WriteOcbPrnCls; // Uzatvorenie dokladu po jeho vytlaËenÌ
    property OcbDsHide[pBookNum:Str5]:boolean read ReadOcbDsHide write WriteOcbDsHide; // Skryù diskrÈtne ˙daje (NC,zisk a pod.)
    property OcbUlcRsn[pBookNum:Str5]:boolean read ReadOcbUlcRsn write WriteOcbUlcRsn; // Povinne zadavanie dovodu odblokovania zakazky
    property OcbItdRsn[pBookNum:Str5]:boolean read ReadOcbItdRsn write WriteOcbItdRsn; // Povinne zadavanie dovodu stronovania polozky zakazky
    property OcbAutSlc[pBookNum:Str5]:boolean read ReadOcbAutSlc write WriteOcbAutSlc; // Automaticky zobraziù v˝berov˝ zoznam tovaru
//    property OcbPayVer[pBookNum:Str5]:boolean read ReadOcbPayVer write WriteOcbPayVer; // Automaticka kontrola dodrzania platobnych podmienok
    property OcbQntTrn[pBookNum:Str5]:boolean read ReadOcbQntTrn write WriteOcbQntTrn; // Doprava podæa poËtu tovaru pri generovanÌ expediËnÈho prÌkazu(SYNDICUS)
    property OcbScmDis[pBookNum:Str5]:boolean read ReadOcbScmDis write WriteOcbScmDis; // Zak·zaù obchodnÈ podmienky
    property OcbBaCont[pBookNum:Str5]:Str20 read ReadOcbBaCont write WriteOcbBaCont; // »Ìso pridelenÈho bankovÈho ˙Ëtu
    property OcbBaName[pBookNum:Str5]:Str30 read ReadOcbBaName write WriteOcbBaName; // N·zov banky pridelenÈho ˙Ëtu
    property OcbBaIban[pBookNum:Str5]:Str30 read ReadOcbBaIban write WriteOcbBaIban; // IBAN banky pridelenÈho ˙Ëtu
    property OcbBaSwft[pBookNum:Str5]:Str10 read ReadOcbBaSwft write WriteOcbBaSwft; // SWIFT banky pridelenÈho ˙Ëtu
    property OcbBaAddr[pBookNum:Str5]:Str30 read ReadOcbBaAddr write WriteOcbBaAddr; // Adresa banky pridelenÈho ˙Ëtu
    property OcbBaCity[pBookNum:Str5]:Str30 read ReadOcbBaCity write WriteOcbBaCity; // SÌdlo banky pridelenÈho ˙Ëtu
    property OcbBaStat[pBookNum:Str5]:Str30 read ReadOcbBaStat write WriteOcbBaStat; // ät·t banky pridelenÈho ˙Ëtu
    property OcbWriNum[pBookNum:Str5]:word read ReadOcbWriNum write WriteOcbWriNum; // »Ìslo prev·dzkovej jednotky (0-centr·la, ostanÈ ËÌsla prev·dzky)
    property OcbStkNum[pBookNum:Str5]:word read ReadOcbStkNum write WriteOcbStkNum; // »Ìslo skladu v˝daja tovaru
    property OcbPlsNum[pBookNum:Str5]:word read ReadOcbPlsNum write WriteOcbPlsNum; // »Ìslo predvolenÈho predajnÈho cennika pre dan˙ knihu
    property OcbCasNum[pBookNum:Str5]:word read ReadOcbCasNum write WriteOcbCasNum; // »Ìslo ERP na hotovostnÈ vy˙ctovanie z·kazky
    property OcbPabNum[pBookNum:Str5]:word read ReadOcbPabNum write WriteOcbPabNum; // »Ìslo knihy obchodn˝ch partnerov - odberateæov
    property OcbTcbNum[pBookNum:Str5]:Str5 read ReadOcbTcbNum write WriteOcbTcbNum; // »Ìslo knihy odberateæsk˝ch dodacÌch listov
    property OcbIcbNum[pBookNum:Str5]:Str5 read ReadOcbIcbNum write WriteOcbIcbNum; // »Ìslo knihy odberateæsk˝ch fakt˙r
    property OcbImbNum[pBookNum:Str5]:Str5 read ReadOcbImbNum write WriteOcbImbNum; // »Ìslo knihy PrÌjemok
    property OcbOmbNum[pBookNum:Str5]:Str5 read ReadOcbOmbNum write WriteOcbOmbNum; // »Ìslo knihy V˝dajok
    property OcbRmbNum[pBookNum:Str5]:Str5 read ReadOcbRmbNum write WriteOcbRmbNum; // »Ìslo knihy medziskaldovej prevodky
    property OcbPcbNum[pBookNum:Str5]:Str5 read ReadOcbPcbNum write WriteOcbPcbNum; // »Ìslo knihy odberateæsk˝ch z·lohovych fakt˙r
    property OcbCsbNum[pBookNum:Str5]:Str5 read ReadOcbCsbNum write WriteOcbCsbNum; // »Ìslo knihy hotovostn˝ch pokladniËn˝ch dokladov
    property OcbExpDay[pBookNum:Str5]:word read ReadOcbExpDay write WriteOcbExpDay; // PoËet dnÌ platnosti rezerv·cie
    property OcbDlvDay[pBookNum:Str5]:word read ReadOcbDlvDay write WriteOcbDlvDay; // PoËet dnÌ termÌnu dod·vky
    property OcbMdcImp[pBookNum:Str5]:word read ReadOcbMdcImp write WriteOcbMdcImp; // Format importu Mediacat (0-text 1-Unicode)
    // TCB
    property TcbBoYear[pBookNum:Str5]:Str4 read ReadTcbBoYear write WriteTcbBoYear; // Rok, na ktor˝ je zaloûen· kniha
    property TcbWriNum[pBookNum:Str5]:word read ReadTcbWriNum write WriteTcbWriNum; // »Ìslo prev·dzkovej jednotky (0-centr·la, ostanÈ ËÌsla prev·dzky)
    property TcbStkNum[pBookNum:Str5]:word read ReadTcbStkNum write WriteTcbStkNum; // »Ìslo skladu v˝daja tovaru
    property TcbPlsNum[pBookNum:Str5]:word read ReadTcbPlsNum write WriteTcbPlsNum; // »Ìslo predvolenÈho predajnÈho cennika pre dan˙ knihu
    property TcbDvName[pBookNum:Str5]:Str3 read ReadTcbDvName write WriteTcbDvName; // Vy˙Ëtovacia mena danej knihy
    property TcbExnFrm[pBookNum:Str5]:Str12 read ReadTcbExnFrm write WriteTcbExnFrm; // Form·t generovania externÈho ËÌsla
    property TcbPabNum[pBookNum:Str5]:word read ReadTcbPabNum write WriteTcbPabNum; // »Ìslo knihy obchodn˝ch partnerov - odberateæov
    property TcbDefPac[pBookNum:Str5]:longint read ReadTcbDefPac write WriteTcbDefPac; // »Ìslo predvolenÈho odberateæa
    property TcbSmCode[pBookNum:Str5]:word read ReadTcbSmCode write WriteTcbSmCode; // »Ìslo predvolenÈho skladovÈho pohybu
    property TcbFgCalc[pBookNum:Str5]:byte read ReadTcbFgCalc write WriteTcbFgCalc; // SpÙsob v˝poËtu vy˙Ëtovacej meny (0-z·klad je cena s DPH, 1-z·klad je cena bez DPH)
    property TcbAvtRnd[pBookNum:Str5]:byte read ReadTcbAvtRnd write WriteTcbAvtRnd; // Typ zaokruhlenia DPH z PC - ˙Ëtovn· mena
    property TcbAvlRnd[pBookNum:Str5]:byte read ReadTcbAvlRnd write WriteTcbAvlRnd; // Typ zaokruhlenia PC s DPH - ˙Ëtovn· mena
    property TcbFvtRnd[pBookNum:Str5]:byte read ReadTcbFvtRnd write WriteTcbFvtRnd; // Typ zaokruhlenia DPH z PC - vy˙Ëtovaciea mena
    property TcbFvlRnd[pBookNum:Str5]:byte read ReadTcbFvlRnd write WriteTcbFvlRnd; // Typ zaokruhlenia PC s DPH - vy˙Ëtovaciea mena
    property TcbAutAcc[pBookNum:Str5]:boolean read ReadTcbAutAcc write WriteTcbAutAcc; // AutomatickÈ roz˙Ëtovanie dokladu (1-zapnute)
    property TcbOnlSub[pBookNum:Str5]:boolean read ReadTcbOnlSub write WriteTcbOnlSub; // Priebeûn˝ v˝daj tovaru na sklad
    property TcbDsHide[pBookNum:Str5]:boolean read ReadTcbDsHide write WriteTcbDsHide; // Priebeûn˝ v˝daj tovaru na sklad
    property TcbOcnVer[pBookNum:Str5]:boolean read ReadTcbOcnVer write WriteTcbOcnVer; // Kontrola duplicity ËÌsla z·kazky (1-zapnut·)
    property TcbPrnCls[pBookNum:Str5]:boolean read ReadTcbPrnCls write WriteTcbPrnCls; // Uzatvorenie dokladu po jeho vytlaËenÌ
    property TcbFgbMod[pBookNum:Str5]:boolean read ReadTcbFgbMod write WriteTcbFgbMod; // Ak je TRUE pri zad·vanÌ poloûky OD dovolÌ zmeniù cenu s DPH
    property TcbIcbNum[pBookNum:Str5]:Str5 read ReadTcbIcbNum write WriteTcbIcbNum; // »Ìslo knihy odberateæsk˝ch fakt˙r
    property TcbMovTcb[pBookNum:Str5]:Str5 read ReadTcbMovTcb write WriteTcbMovTcb; // Prednastavena kniha pre funkciu presunu dodacieho listu do inej knihy
    property TcbCasNum[pBookNum:Str5]:byte read ReadTcbCasNum write WriteTcbCasNum; // »Ìslo pokladne kde bol naposledy vyuctovany dodaci list
    property TcbFmType[pBookNum:Str5]:byte read ReadTcbFmType write WriteTcbFmType; // Typ pouûitÈho fisk·lneho modulu (0-ûiadny;1-FM2000;2-FM3000;3-PEGAS)
    property TcbFmPort[pBookNum:Str5]:Str4 read ReadTcbFmPort write WriteTcbFmPort; // Port fisklaneho modulu (-;COM1;COM2;COM3;COM4)
    property TcbCpiBok[pBookNum:Str5]:Str5 read ReadTcbCpiBok write WriteTcbCpiBok; // Prednastavena kniha vyrobnych kalkulacii
    // SAB
    property SabWriNum[pBookNum:Str5]:word read ReadSabWriNum write WriteSabWriNum; // Prednastaven8 prevadzkova jednotka
    property SabStkNum[pBookNum:Str5]:word read ReadSabStkNum write WriteSabStkNum; // Prednastaveny sklad odkial tovar bude vydany
    property SabCenCsb[pBookNum:Str5]:Str5 read ReadSabCenCsb write WriteSabCenCsb; // Cislo knihy hlavnej pokladne
    property SabEcrCsb[pBookNum:Str5]:Str5 read ReadSabEcrCsb write WriteSabEcrCsb; // Cislo knihy pokladne pre ERP
    property SabIdbNum[pBookNum:Str5]:Str5 read ReadSabIdbNum write WriteSabIdbNum; // Cislo knihy uctvonych dokladov
    property SabBgsCoi[pBookNum:Str5]:word read ReadSabBgsCoi write WriteSabBgsCoi; // PokladniËn· poloûka na prÌjem trûby za tovar
    property SabBseCoi[pBookNum:Str5]:word read ReadSabBseCoi write WriteSabBseCoi; // PokladniËn· poloûka na prÌjem trûby za sluûby
    property SabSpiCoi[pBookNum:Str5]:word read ReadSabSpiCoi write WriteSabSpiCoi; // PokladniËn· poloûka na prÌjem prijatej z·lohy
    property SabSpeCoe[pBookNum:Str5]:word read ReadSabSpeCoe write WriteSabSpeCoe; // PokladniËn· poloûka na v˝daj Ëerpanej z·lohy
    property SabCshCoe[pBookNum:Str5]:word read ReadSabCshCoe write WriteSabCshCoe; // PokladniËn· poloûka na v˝daj hotovosti y ERP
    property SabCshCoi[pBookNum:Str5]:word read ReadSabCshCoi write WriteSabCshCoi; // PokladniËn· poloûka na prÌjem hotovosti do HP
    property SabCrdCoe[pBookNum:Str5]:word read ReadSabCrdCoe write WriteSabCrdCoe; // PokladniËn· poloûka na v˝daj platobnej karty do banky
    property SabSviCrd[pBookNum:Str5]:word read ReadSabSviCrd write WriteSabSviCrd; // Poloûka na zauËtovanie DPH z prijatej zalohy - MD ID
    property SabSviDeb[pBookNum:Str5]:word read ReadSabSviDeb write WriteSabSviDeb; // Poloûka na zauËtovanie DPH z prijatej zalohy - DAL ID
    property SabSveCrd[pBookNum:Str5]:word read ReadSabSveCrd write WriteSabSveCrd; // Poloûka na zauËtovanie DPH z pouûitej zalohy - MD ID
    property SabSveDeb[pBookNum:Str5]:word read ReadSabSveDeb write WriteSabSveDeb; // Poloûka na zauËtovanie DPH z pouûitej zalohy - DAL ID
    property SabTcbNum[pBookNum:Str5]:Str5 read ReadSabTcbNum write WriteSabTcbNum; // »Ìslo knihy odberateæsk˝ch fakt˙r odial s˙ poËÌtanÈ n·klady
    property SabCpiBok[pBookNum:Str5]:Str5 read ReadSabCpiBok write WriteSabCpiBok; // »Ìslo knihy vyrobnych kalkulacii
    property SabIcpCoi[pBookNum:Str5]:word read ReadSabIcpCoi write WriteSabIcpCoi; // PokladniËn· poloûka na v˝daj uhrady faktury
    property SabIcpCsb[pBookNum:Str5]:Str5 read ReadSabIcpCsb write WriteSabIcpCsb; // Cislo knihy pokladne pre uhradu FA
    property SabAccAll[pBookNum:Str5]:boolean read ReadSabAccAll write WriteSabAccAll; // Ak je TRUE spravi sa kompletne zauctovanie registracnej pokladne
    property SabAccDcl[pBookNum:Str5]:boolean read ReadSabAccDcl write WriteSabAccDcl; // Ak je TRUE uctuje sa doklad podla dennych uzavierok 
    property SabStkSub[pBookNum:Str5]:boolean read ReadSabStkSub write WriteSabStkSub; // Ak je TRUE spracovanie odpocita tovar zo skladu
    property SabStkDet[pBookNum:Str5]:boolean read ReadSabStkDet write WriteSabStkDet; // Ak je TRUE tak sa cislo skaldu berie z T-suboru
    property SabCrdTrn[pBookNum:Str5]:boolean read ReadSabCrdTrn write WriteSabCrdTrn; // Ak je TRUE tak sa sleduju obraty zakaznickych kariet
    property SabCshCre[pBookNum:Str5]:word read ReadSabCshCre write WriteSabCshCre; // PokladniËn· poloûka na v˝daj hotovosti z HP
    property SabCshCri[pBookNum:Str5]:word read ReadSabCshCri write WriteSabCshCri; // PokladniËn· poloûka na prÌjem hotovosti do ERP
    // RPL
    property RplPceBeg[pIntNum:byte;pBookNum:Str5]:double read ReadRplPceBeg write WriteRplPceBeg;  // Zaciatok intervalu nakupnej ceny
    property RplPceEnd[pIntNum:byte;pBookNum:Str5]:double read ReadRplPceEnd write WriteRplPceEnd;  // Koiec intervalu nakupnej ceny
    property RplPrfKfc[pIntNum:byte;pBookNum:Str5]:double read ReadRplPrfKfc write WriteRplPrfKfc;  // koeficient na vypocet doporucenej ceny
    property RplExcKfc[pIntNum:byte;pBookNum:Str5]:double read ReadRplExcKfc write WriteRplExcKfc;  // koeficient na vypocet specialnej ceny
    property RplImpFile[pBookNum:Str5]:Str200 read ReadRplImpFile write WriteRplImpFile; // Cislo knihy odberatelskych dodacich listov
    // JOB
    property JobOwnUsl[pBookNum:Str5]:Str8 read ReadJobOwnUsl write WriteJobOwnUsl;     // Prihlasovacie meno vlastnÌka knihy
    property JobNdoClr[pBookNum:Str5]:integer read ReadJobNdoClr write WriteJobNdoClr;  // Farba zobrazenia noveho pracovneho ukolu
    property JobRdoClr[pBookNum:Str5]:integer read ReadJobRdoClr write WriteJobRdoClr;  // Farba zobrazenia pracovneho ukolu na ktorom sa pracuje
    property JobSdoClr[pBookNum:Str5]:integer read ReadJobSdoClr write WriteJobSdoClr;  // Farba zobrazenia pozastaveneho pracovneho ukolu
    property JobOdoClr[pBookNum:Str5]:integer read ReadJobOdoClr write WriteJobOdoClr;  // Farba zobrazenia vyrieseneho pracovneho ukolu
    property JobXdoClr[pBookNum:Str5]:integer read ReadJobXdoClr write WriteJobXdoClr;  // Farba zobrazenia neriesitelneho pracovneho ukolu
    property JobDdoClr[pBookNum:Str5]:integer read ReadJobDdoClr write WriteJobDdoClr;  // Farba zobrazenia stornovaneho pracovneho ukolu
    // ISB
    property IsbBoYear[pBookNum:Str5]:Str4 read ReadIsbBoYear write WriteIsbBoYear; // Rok, na ktor˝ je zaloûen· kniha
    property IsbCoSymb[pBookNum:Str5]:Str4 read ReadIsbCoSymb write WriteIsbCoSymb; // Prednastaveny konstantny symnol
    property IsbDvName[pBookNum:Str5]:Str3 read ReadIsbDvName write WriteIsbDvName; // Vy˙Ëtovacia mena danej knihy
    property IsbWriNum[pBookNum:Str5]:word read ReadIsbWriNum write WriteIsbWriNum; // Cislo predvolenej prevadzkovej jednotky
    property IsbStkNum[pBookNum:Str5]:word read ReadIsbStkNum write WriteIsbStkNum; // Cislo predvoleneho skladu
    property IsbPlsNum[pBookNum:Str5]:word read ReadIsbPlsNum write WriteIsbPlsNum; // Cislo predvoleneho predajneho cennika
    property IsbPabNum[pBookNum:Str5]:word read ReadIsbPabNum write WriteIsbPabNum; // Cislo knihy obchodn˝ch partnerov - odberatelia
    property IsbAutAcc[pBookNum:Str5]:boolean read ReadIsbAutAcc write WriteIsbAutAcc; // Automaticke rozuctovanie dokladu
    property IsbSumAcc[pBookNum:Str5]:boolean read ReadIsbSumAcc write WriteIsbSumAcc; // Kumulativne uctovanie
    property IsbTsdAcc[pBookNum:Str5]:boolean read ReadIsbTsdAcc write WriteIsbTsdAcc; // Automaticke rozuctovanie pripojenych DDL
    property IsbVatCls[pBookNum:Str5]:boolean read ReadIsbVatCls write WriteIsbVatCls; // Zapocitat do evidencii DPH
    property IsbNvtDoc[pBookNum:Str5]:boolean read ReadIsbNvtDoc write WriteIsbNvtDoc; // OslobodenÈ od DPH
    property IsbDocSnt[pBookNum:Str5]:Str3 read ReadIsbDocSnt write WriteIsbDocSnt; // Synteticka cast uctu dodavatela
    property IsbDocAnl[pBookNum:Str5]:Str6 read ReadIsbDocAnl write WriteIsbDocAnl; // Analyticka cast uctu dodavatela
    property IsbVatSnt[pBookNum:Str5]:Str3 read ReadIsbVatSnt write WriteIsbVatSnt; // Synteticka cast uctu uplatnenej DPH
    property IsbVatAnl[pBookNum:Str5]:Str6 read ReadIsbVatAnl write WriteIsbVatAnl; // Analyticka cast uctu uplatnenej DPH
    property IsbNvaSnt[pBookNum:Str5]:Str3 read ReadIsbNvaSnt write WriteIsbNvaSnt; // Synteticka cast uctu neuplatnenej DPH
    property IsbNvaAnl[pBookNum:Str5]:Str6 read ReadIsbNvaAnl write WriteIsbNvaAnl; // Analyticka cast uctu neuplatnenej DPH
    property IsbGscSnt[pBookNum:Str5]:Str3 read ReadIsbGscSnt write WriteIsbGscSnt; // Synteticka cast uctu tovarovych poloziek
    property IsbGscAnl[pBookNum:Str5]:Str6 read ReadIsbGscAnl write WriteIsbGscAnl; // Analyticka cast uctu tovarovych poloziek
    property IsbGsdSnt[pBookNum:Str5]:Str3 read ReadIsbGsdSnt write WriteIsbGsdSnt; // Synteticka cast uctu tovarovych poloziek
    property IsbGsdAnl[pBookNum:Str5]:Str6 read ReadIsbGsdAnl write WriteIsbGsdAnl; // Analyticka cast uctu tovarovych poloziek
    property IsbSecSnt[pBookNum:Str5]:Str3 read ReadIsbSecSnt write WriteIsbSecSnt; // Synteticka cast uctu poskytnutych sluzieb
    property IsbSecAnl[pBookNum:Str5]:Str6 read ReadIsbSecAnl write WriteIsbSecAnl; // Analyticka cast uctu poskytnutych sluzieb
    property IsbSedSnt[pBookNum:Str5]:Str3 read ReadIsbSedSnt write WriteIsbSedSnt; // Synteticka cast uctu poskytnutych sluzieb
    property IsbSedAnl[pBookNum:Str5]:Str6 read ReadIsbSedAnl write WriteIsbSedAnl; // Analyticka cast uctu poskytnutych sluzieb
    property IsbTsbNum[pBookNum:Str5]:Str5 read ReadIsbTsbNum write WriteIsbTsbNum; // Cislo knihy dodavatelskych dodacich listov
    property IsbCsbNum[pBookNum:Str5]:Str5 read ReadIsbCsbNum write WriteIsbCsbNum; // Cislo knihy hotovostnych pokladnicnych dokladov
    property IsbDocSpc[pBookNum:Str5]:byte read ReadIsbDocSpc write WriteIsbDocSpc; // Specifikacia dokladu (0-FA,1-Splatkovy kalendar,2-JCD )
    property IsbVtdDef[pBookNum:Str5]:byte read ReadIsbVtdDef write WriteIsbVtdDef; // Predvolene nastavenie d·tumu DPH (0-vystavene,1-doölo,2-dod·vka)
    property IsbAcdDef[pBookNum:Str5]:byte read ReadIsbAcdDef write WriteIsbAcdDef; // Predvolene nastavenie d·tumu za˙Ëtovania (0-vystavene,1-doölo,2-dod·vka)
    property IsbItmAcc[pBookNum:Str5]:byte read ReadIsbItmAcc write WriteIsbItmAcc;  // Sposob rozuctovania polozky FA - text uctovneho zapisu
    property IsbVatRnd[pBookNum:Str5]:byte read ReadIsbVatRnd write WriteIsbVatRnd; // Sposob zaokruhlenia DPH
    property IsbValRnd[pBookNum:Str5]:byte read ReadIsbValRnd write WriteIsbValRnd; // Sposob zaokruhlenia celkovej hodnoty
    property IsbTsbInc[pBookNum:Str5]:Str200 read ReadIsbTsbInc write WriteIsbTsbInc; // Knihy, z ktor˝ch systÈm pon˙ka dodacie listy na p·rovanie
    property IsbTsbExc[pBookNum:Str5]:Str200 read ReadIsbTsbExc write WriteIsbTsbExc; // Knihy, ktorÈ s˙ vyl˙ËenÈ z p·rovania
    // ICB
    property IcbBoYear[pBookNum:Str5]:Str4 read ReadIcbBoYear write WriteIcbBoYear;  // Rok, na ktor˝ je zaloûen· kniha
    property IcbCoSymb[pBookNum:Str5]:Str4 read ReadIcbCoSymb write WriteIcbCoSymb;  // Prednastaveny konstantny symnol
    property IcbDvName[pBookNum:Str5]:Str3 read ReadIcbDvName write WriteIcbDvName;  // Vy˙Ëtovacia mena danej knihy
    property IcbExnFrm[pBookNum:Str5]:Str12 read ReadIcbExnFrm write WriteIcbExnFrm; // Format generovania variabilnÈho symbolu
    property IcbWriNum[pBookNum:Str5]:word read ReadIcbWriNum write WriteIcbWriNum;  // »Ìslo prev·dzkovej jednotky
    property IcbStkNum[pBookNum:Str5]:word read ReadIcbStkNum write WriteIcbStkNum;  // Z·kladnÈ nastavenie pouûitÈho skladu
    property IcbPlsNum[pBookNum:Str5]:word read ReadIcbPlsNum write WriteIcbPlsNum;  // Cislo predvoleneho predajneho cennika
    property IcbPabNum[pBookNum:Str5]:word read ReadIcbPabNum write WriteIcbPabNum;  // »Ìslo knihy obchodn˝ch partnerov - odberatelia
    property IcbAvtRnd[pBookNum:Str5]:byte read ReadIcbAvtRnd write WriteIcbAvtRnd;  // Typ zaokruhlenia DPH z PC - UM
    property IcbAvlRnd[pBookNum:Str5]:byte read ReadIcbAvlRnd write WriteIcbAvlRnd;  // Typ zaokruhlenia PC s DPH - UM
    property IcbFvtRnd[pBookNum:Str5]:byte read ReadIcbFvtRnd write WriteIcbFvtRnd;  // Typ zaokruhlenia DPH z PC - VM
    property IcbFvlRnd[pBookNum:Str5]:byte read ReadIcbFvlRnd write WriteIcbFvlRnd;  // Typ zaokruhlenia PC s DPH - VM
    property IcbAutAcc[pBookNum:Str5]:boolean read ReadIcbAutAcc write WriteIcbAutAcc; // Automaticke rozuctovanie dokladu (1-zapnute)
    property IcbSumAcc[pBookNum:Str5]:boolean read ReadIcbSumAcc write WriteIcbSumAcc; // Kumulativne uctovanie
    property IcbTcdAcc[pBookNum:Str5]:boolean read ReadIcbTcdAcc write WriteIcbTcdAcc; // Automaticke rozuctovanie pripojenych ODL
    property IcbVatCls[pBookNum:Str5]:boolean read ReadIcbVatCls write WriteIcbVatCls; // Zapocitat do evidencii DPH
    property IcbNvtDoc[pBookNum:Str5]:boolean read ReadIcbNvtDoc write WriteIcbNvtDoc; // OslobodenÈ od DPH
    property IcbOcnVer[pBookNum:Str5]:boolean read ReadIcbOcnVer write WriteIcbOcnVer; // Kontrola duplicity cisla zakazky
    property IcbPrnCls[pBookNum:Str5]:boolean read ReadIcbPrnCls write WriteIcbPrnCls; // Uzatvorenie dokladu po jeho vytlaceni
    property IcbVatClc[pBookNum:Str5]:boolean read ReadIcbVatClc write WriteIcbVatClc; // TRUE - vypocita DPH a hod. bez DPH z konecnej sumy FA, FALSE - koneËnÈ hodnoty s˙ suËtom poloûiek FA
    property IcbFgbMod[pBookNum:Str5]:boolean read ReadIcbFgbMod write WriteIcbFgbMod; // Ak je TRUE pri zad·vanÌ poloûky OF dovolÌ zmeniù cenu s DPH
    property IcbDocSnt[pBookNum:Str5]:Str3 read ReadIcbDocSnt write WriteIcbDocSnt;  // Syntetick· Ëasù ˙Ëtu - odberatelia
    property IcbDocAnl[pBookNum:Str5]:Str6 read ReadIcbDocAnl write WriteIcbDocAnl;  // Analytick· Ëast ˙Ëtu - odberatelia
    property IcbVatSnt[pBookNum:Str5]:Str3 read ReadIcbVatSnt write WriteIcbVatSnt;  // Syntetick· Ëasù ˙Ëtu - DPH
    property IcbVatAnl[pBookNum:Str5]:Str6 read ReadIcbVatAnl write WriteIcbVatAnl;  // Analytick· Ëast ˙Ëtu - DPH
    property IcbGscSnt[pBookNum:Str5]:Str3 read ReadIcbGscSnt write WriteIcbGscSnt;  // Syntetick· Ëasù ˙Ëtu - trzba za tovar
    property IcbGscAnl[pBookNum:Str5]:Str6 read ReadIcbGscAnl write WriteIcbGscAnl;  // Analytick· Ëast ˙Ëtu - trzba za tovar
    property IcbSecSnt[pBookNum:Str5]:Str3 read ReadIcbSecSnt write WriteIcbSecSnt;  // Syntetick· Ëasù ˙Ëtu - trzba za sluby
    property IcbSecAnl[pBookNum:Str5]:Str6 read ReadIcbSecAnl write WriteIcbSecAnl;  // Analytick· Ëast ˙Ëtu - trzba za sluby
    property IcbPcrSnt[pBookNum:Str5]:Str3 read ReadIcbPcrSnt write WriteIcbPcrSnt;  // Syntetick· Ëasù ˙Ëtu - kurzovy zisk
    property IcbPcrAnl[pBookNum:Str5]:Str6 read ReadIcbPcrAnl write WriteIcbPcrAnl;  // Analytick· Ëast ˙Ëtu - kurzovy zisk
    property IcbNcrSnt[pBookNum:Str5]:Str3 read ReadIcbNcrSnt write WriteIcbNcrSnt;  // Syntetick· Ëasù ˙Ëtu - kurzova strata
    property IcbNcrAnl[pBookNum:Str5]:Str6 read ReadIcbNcrAnl write WriteIcbNcrAnl;  // Analytick· Ëast ˙Ëtu - kurzova strata
    property IcbPdfSnt[pBookNum:Str5]:Str3 read ReadIcbPdfSnt write WriteIcbPdfSnt;  // Syntetick· Ëasù ˙Ëtu - preplatok faktury
    property IcbPdfAnl[pBookNum:Str5]:Str6 read ReadIcbPdfAnl write WriteIcbPdfAnl;  // Analytick· Ëast ˙Ëtu - preplatok faktury
    property IcbNdfSnt[pBookNum:Str5]:Str3 read ReadIcbNdfSnt write WriteIcbNdfSnt;  // Syntetick· Ëasù ˙Ëtu - nedoplatok faktury
    property IcbNdfAnl[pBookNum:Str5]:Str6 read ReadIcbNdfAnl write WriteIcbNdfAnl;  // Analytick· Ëast ˙Ëtu - nedoplatok faktury
    property IcbTcbNum[pBookNum:Str5]:Str5 read ReadIcbTcbNum write WriteIcbTcbNum;  // »Ìslo knihy odberatelskych dodacich listov
    property IcbCsbNum[pBookNum:Str5]:Str5 read ReadIcbCsbNum write WriteIcbCsbNum;  // »Ìslo knihy priradene hotovostnej pokladne
    property IcbNibNum[pBookNum:Str5]:Str5 read ReadIcbNibNum write WriteIcbNibNum;  // »Ìslo knihy dobropisov
    property IcbDocSpc[pBookNum:Str5]:byte read ReadIcbDocSpc write WriteIcbDocSpc;  // Specifikacia dokladu z hladiska vyplnenia
    property IcbExCalc[pBookNum:Str5]:byte read ReadIcbExCalc write WriteIcbExCalc;  // Sposob vypoctu datumu splatnosti (0-od vystavenia,1-od odoslania,2-od dodania tovaru)
    property IcbBaCont[pBookNum:Str5]:Str30 read ReadIcbBaCont write WriteIcbBaCont; // Bankvy ucet vystavovatela faktrury
    property IcbBaName[pBookNum:Str5]:Str30 read ReadIcbBaName write WriteIcbBaName; // Nazov banky
    property IcbBaIban[pBookNum:Str5]:Str30 read ReadIcbBaIban write WriteIcbBaIban; // IBAN
    property IcbBaSwft[pBookNum:Str5]:Str30 read ReadIcbBaSwft write WriteIcbBaSwft; // SWIFT
    property IcbBaAddr[pBookNum:Str5]:Str30 read ReadIcbBaAddr write WriteIcbBaAddr; // Adresa banky
    property IcbBaCity[pBookNum:Str5]:Str30 read ReadIcbBaCity write WriteIcbBaCity; // Sidlo banky
    property IcbBaStat[pBookNum:Str5]:Str30 read ReadIcbBaStat write WriteIcbBaStat; // Stat kde je sidlo banky
    property IcbCadEnb:boolean read ReadIcbCadEnb write WriteIcbCadEnb;              // Povolonie hotovostnej uhrady FA cez ERP
    property IcbPayCoi[pBookNum:Str5]:word read ReadIcbPayCoi write WriteIcbPayCoi;  // PokladniËn· poloûka na uhradu faktury
    property IcbCadTyp[pBookNum:Str5]:byte read ReadIcbCadTyp write WriteIcbCadTyp;  // Sposob hotovostnej uhrady FA
    property IcbItmAcc[pBookNum:Str5]:byte read ReadIcbItmAcc write WriteIcbItmAcc;  // Sposob rozuctovania polozky FA - text uctovneho zapisu
    property IcbFgCalc[pBookNum:Str5]:byte read ReadIcbFgCalc write WriteIcbFgCalc; // SpÙsob v˝poËtu vy˙Ëtovacej meny (0-z·klad je cena s DPH, 1-z·klad je cena bez DPH)
    property IcbDsHide[pBookNum:Str5]:boolean read ReadIcbDsHide write WriteIcbDsHide; // Skryt diskretne udaje
    property IcbRepVtd[pBookNum:Str5]:Str30 read ReadIcbRepVtd write WriteIcbRepVtd; // TlaËob· maska pre tlaù odberateæskej fakt˙ry - Riadne fakt˙ry (s DPH)
    property IcbRepNvd[pBookNum:Str5]:Str30 read ReadIcbRepNvd write WriteIcbRepNvd; // TlaËob· maska pre tlaù odberateæskej fakt˙ry - Fakt˙ry oslobodenÈ od DPH
    property IcbRepVtdO[pBookNum:Str5]:Str30 read ReadIcbRepVtdO write WriteIcbRepVtdO; // TlaËob· maska pre tlaù odberateæskej fakt˙ry - Riadne fakt˙ry (s DPH)
    property IcbRepNvdO[pBookNum:Str5]:Str30 read ReadIcbRepNvdO write WriteIcbRepNvdO; // TlaËob· maska pre tlaù odberateæskej fakt˙ry - Fakt˙ry oslobodenÈ od DPH
    // DPB
    property DpbHcrSnt[pBookNum:Str5]:Str3 read ReadDpbHcrSnt write WriteDpbHcrSnt;  // Syntetick· Ëasù ˙Ëtu - zmluva postupenych poladavok (MD)
    property DpbHcrAnl[pBookNum:Str5]:Str6 read ReadDpbHcrAnl write WriteDpbHcrAnl;  // Analytick· Ëast ˙Ëtu - zmluva postupenych poladavok (MD)
    property DpbHdbSnt[pBookNum:Str5]:Str3 read ReadDpbHdbSnt write WriteDpbHdbSnt;  // Syntetick· Ëasù ˙Ëtu - zmluva postupenych poladavok (DAL)
    property DpbHdbAnl[pBookNum:Str5]:Str6 read ReadDpbHdbAnl write WriteDpbHdbAnl;  // Analytick· Ëast ˙Ëtu - zmluva postupenych poladavok (DAL)
    property DpbIcrSnt[pBookNum:Str5]:Str3 read ReadDpbIcrSnt write WriteDpbIcrSnt;  // Syntetick· Ëasù ˙Ëtu - faktura postupenych poladavok (MD)
    property DpbIcrAnl[pBookNum:Str5]:Str6 read ReadDpbIcrAnl write WriteDpbIcrAnl;  // Analytick· Ëast ˙Ëtu - faktura postupenych poladavok (MD)
    property DpbIdbSnt[pBookNum:Str5]:Str3 read ReadDpbIdbSnt write WriteDpbIdbSnt;  // Syntetick· Ëasù ˙Ëtu - faktura postupenych poladavok (DAL)
    property DpbIdbAnl[pBookNum:Str5]:Str6 read ReadDpbIdbAnl write WriteDpbIdbAnl;  // Analytick· Ëast ˙Ëtu - faktura postupenych poladavok (DAL)
    // ASC
    property AscExdBeg[pPerNum:byte]:integer read ReadAscExdBeg write WriteAscExdBeg; // Pocet dni po splatnosti od
    property AscExdEnd[pPerNum:byte]:integer read ReadAscExdEnd write WriteAscExdEnd; // Pocet dni po splatnosti do
    property AscExdTxt[pPerNum:byte]:Str30 read ReadAscExdTxt write WriteAscExdTxt; // Textovy popis zadanej splatnosti
    // CAS
    property CasClsTyp[pCasNum:word]:longint read ReadCasClsTyp write WriteCasClsTyp; // Typ uzavierky na PEGAS06
    property CasBlkNum[pCasNum:word]:longint read ReadCasBlkNum write WriteCasBlkNum; // Interne poradove cislo pokladnicnej uctenky
    property CasTrnNeb[pCasNum:word]:boolean read ReadCasTrnNeb write WriteCasTrnNeb; // Vypisaù zostatok k najbliûöiemu bonusu
    property CasDupMsg[pCasNum:word]:boolean read ReadCasDupMsg write WriteCasDupMsg; // Hlasenie duplicity tovaru na doklade
    property CasDupSum[pCasNum:word]:boolean read ReadCasDupSum write WriteCasDupSum; // Kumulovanie duplicitnoho tovaru na doklade
    property CasFmdPrn[pCasNum:word]:boolean read ReadCasFmdPrn write WriteCasFmdPrn; // Ci tlac prijmu hotovosti a vydaja platidiel urobi Fiskalna tlaciaren
    property CasLanDir[pCasNum:word]:Str250 read ReadCasLanDir write WriteCasLanDir; // Sietovy komunikacny adresar registracnej pokladne
    property CasTcdBok[pCasNum:word]:Str5 read ReadCasTcdBok write WriteCasTcdBok; // Kniha ODL pokladne
    property CasTpcNum[pCasNum:word]:word read ReadCasTpcNum write WriteCasTpcNum; // Cislo pouziteho terminovaneho cennika
    property CasFmpWay[pCasNum:word]:word read ReadCasFmpWay write WriteCasFmpWay; // Vseobecne oneskorenie pri zapise na port
    property CasFmiWay[pCasNum:word]:word read ReadCasFmiWay write WriteCasFmiWay; // Oneskorenie pri zapise poloziek
    property CasPauCnt[pCasNum:word]:word read ReadCasPauCnt write WriteCasPauCnt; // Denne poËÌtadlo na vratne obaly z automatu
    property CasExdQnt[pCasNum:word]:byte read ReadCasExdQnt write WriteCasExdQnt; // Pocet vytlacenych dokladov odvodu trzby
    property CasMaxItm[pCasNum:word]:word read ReadCasMaxItm write WriteCasMaxItm; // Maximalny pocet poloziek na jednom pokladnicnom dokladu
    property CasIcpQnt[pCasNum:word]:byte read ReadCasIcpQnt write WriteCasIcpQnt; // Pocet vytlacenych dokladov hotovostnej uhrady FA
    property CasPabBeg:longint read ReadCasPabBeg write WriteCasPabBeg; // Zaciatocny interval pri evidovani novej firmy
    property CasPabEnd:longint read ReadCasPabEnd write WriteCasPabEnd; // Konecny interval pri evidovani novej firmy
    // CAI
    property CaiActTrn:boolean read ReadCaiActTrn write WriteCaiActTrn; // Ci sa zbieraju udaje o trbe z ActTurn 
    // RPC
    property RpcChgNum[pPlsNum:word]:word read ReadRpcChgNum write WriteRpcChgNum; // Poradove ËÌslo pokynu na zmeny predajn˝ch cien
    property RpcChgCas[pPlsNum:word]:Str250 read ReadRpcChgCas write WriteRpcChgCas; // Cisla pokldne pre ktorych treba ulozit zmeny
    property RpcExpRef[pPlsNum:word]:boolean read ReadRpcExpRef write WriteRpcExpRef; // Ci sa pozioadvky exportuju do PLSccccc.REF
    // CSB
    property CsbBoYear[pBookNum:Str5]:Str4 read ReadCsbBoYear write WriteCsbBoYear;
    property CsbDvName[pBookNum:Str5]:Str3 read ReadCsbDvName write WriteCsbDvName;
    property CsbWriNum[pBookNum:Str5]:word read ReadCsbWriNum write WriteCsbWriNum;
    property CsbPabNum[pBookNum:Str5]:word read ReadCsbPabNum write WriteCsbPabNum;
    property CsbPyvBeg[pBookNum:Str5]:double read ReadCsbPyvBeg write WriteCsbPyvBeg;
    property CsbPyvInc[pBookNum:Str5]:double read ReadCsbPyvInc write WriteCsbPyvInc;
    property CsbPyvExp[pBookNum:Str5]:double read ReadCsbPyvExp write WriteCsbPyvExp;
    property CsbPyvEnd[pBookNum:Str5]:double read ReadCsbPyvEnd write WritePyvEndExp;
    property CsbMaxPdf[pBookNum:Str5]:double read ReadCsbMaxPdf write WritePyvPyvMax;
    property CsbAcvBeg[pBookNum:Str5]:double read ReadCsbAcvBeg write WritePyvAcvBeg;
    property CsbAcvInc[pBookNum:Str5]:double read ReadCsbAcvInc write WritePyvAcvInc;
    property CsbAcvExp[pBookNum:Str5]:double read ReadCsbAcvExp write WritePyvAcvExp;
    property CsbEycCrd[pBookNum:Str5]:double read ReadCsbEycCrd write WritePyvEycCrd;
    property CsbEyvCrd[pBookNum:Str5]:double read ReadCsbEyvCrd write WritePyvEyvCrd;
    property CsbAcvEnd[pBookNum:Str5]:double read ReadCsbAcvEnd write WritePyvAcvEnd;
    property CsbDocSnt[pBookNum:Str5]:Str3 read ReadCsbDocSnt write WriteCsbDocSnt;
    property CsbDocAnl[pBookNum:Str5]:Str6 read ReadCsbDocAnl write WriteCsbDocAnl;
    property CsbVaiSnt[pBookNum:Str5]:Str3 read ReadCsbVaiSnt write WriteCsbVaiSnt;
    property CsbVaiAnl[pBookNum:Str5]:Str6 read ReadCsbVaiAnl write WriteCsbVaiAnl;
    property CsbVaoSnt[pBookNum:Str5]:Str3 read ReadCsbVaoSnt write WriteCsbVaoSnt;
    property CsbVaoAnl[pBookNum:Str5]:Str6 read ReadCsbVaoAnl write WriteCsbVaoAnl;
    property ExcVatSnt[pBookNum:Str5]:Str3 read ReadExcVatSnt write WriteExcVatSnt;
    property ExcVatAnl[pBookNum:Str5]:Str6 read ReadExcVatAnl write WriteExcVatAnl;
    property ExcCosSnt[pBookNum:Str5]:Str3 read ReadExcCosSnt write WriteExcCosSnt;
    property ExcCosAnl[pBookNum:Str5]:Str6 read ReadExcCosAnl write WriteExcCosAnl;

    property CsbVatRnd[pBookNum:Str5]:byte read ReadCsbVatRnd write WriteCsbVatRnd;
    property CsbValRnd[pBookNum:Str5]:byte read ReadCsbValRnd write WriteCsbValRnd;
    property CsbSpcCse[pBookNum:Str5]:word read ReadCsbSpcCse write WriteCsbSpcCse;
    property CsbSpcCsi[pBookNum:Str5]:word read ReadCsbSpcCsi write WriteCsbSpcCsi;
    property CsbVatCls[pBookNum:Str5]:boolean read ReadCsbVatCls write WriteCsbVatCls;
    property CsbAutAcc[pBookNum:Str5]:boolean read ReadCsbAutAcc write WriteCsbAutAcc;
    property CsbRndVer[pBookNum:Str5]:boolean read ReadCsbRndVer write WriteCsbRndVer;
    property CsbSumAcc[pBookNum:Str5]:boolean read ReadCsbSumAcc write WriteCsbSumAcc;
    property CsbWriAdd[pBookNum:Str5]:boolean read ReadCsbWriAdd write WriteCsbWriAdd;
    property CsbDoiQnt[pBookNum:Str5]:word read ReadCsbDoiQnt write WriteCsbDoiQnt;
    property CsbDoeQnt[pBookNum:Str5]:word read ReadCsbDoeQnt write WriteCsbDoeQnt;
    property CsbDocQnt[pBookNum:Str5]:word read ReadCsbDocQnt write WriteCsbDocQnt;
    // SPB
    property SpbPabNum:word read ReadSpbPabNum write WriteSpbPabNum; // »Ìslo knihy partnerov
    // SOB
    property SobPyvBeg[pBookNum:Str5]:double  read ReadSobPyvBeg write WriteSobPyvBeg;
    property SobPyvCre[pBookNum:Str5]:double  read ReadSobPyvCre write WriteSobPyvCre;
    property SobPyvDeb[pBookNum:Str5]:double  read ReadSobPyvDeb write WriteSobPyvDeb;
    property SobPyvEnd[pBookNum:Str5]:double  read ReadSobPyvEnd write WriteSobPyvEnd;
    property SobPyvMax[pBookNum:Str5]:double  read ReadSobPyvMax write WriteSobPyvMax;
    property SobAcvBeg[pBookNum:Str5]:double  read ReadSobAcvBeg write WriteSobAcvBeg;
    property SobAcvCre[pBookNum:Str5]:double  read ReadSobAcvCre write WriteSobAcvCre;
    property SobAcvDeb[pBookNum:Str5]:double  read ReadSobAcvDeb write WriteSobAcvDeb;
    property SobAcvEnd[pBookNum:Str5]:double  read ReadSobAcvDeb write WriteSobAcvEnd;
    property SobEycCrd[pBookNum:Str5]:double  read ReadSobEycCrd write WriteSobEycCrd;
    property SobEyvCrd[pBookNum:Str5]:double  read ReadSobEyvCrd write WriteSobEyvCrd;
    property SobPydCrs[pBookNum:Str5]:double  read ReadSobPydCrs write WriteSobPydCrs;
    property SobPydNam[pBookNum:Str5]:Str3    read ReadSobPydNam write WriteSobPydNam;
    property SobDocSnt[pBookNum:Str5]:Str3    read ReadSobDocSnt write WriteSobDocSnt;
    property SobDocAnl[pBookNum:Str5]:Str6    read ReadSobDocAnl write WriteSobDocAnl;
    property SobBaCont[pBookNum:Str5]:Str20   read ReadSobBaCont write WriteSobBaCont;
    property SobBaCode[pBookNum:Str5]:Str4    read ReadSobBaCode write WriteSobBaCode;
    property SobBaName[pBookNum:Str5]:Str30   read ReadSobBaName write WriteSobBaName;
    property SobBaIban[pBookNum:Str5]:Str30   read ReadSobBaIban write WriteSobBaIban;
    property SobBaSwft[pBookNum:Str5]:Str10   read ReadSobBaSwft write WriteSobBaSwft;
    property SobAboTyp[pBookNum:Str5]:byte    read ReadSobAboTyp write WriteSobAboTyp;
    property SobAboPat[pBookNum:Str5]:Str80   read ReadSobAboPat write WriteSobAboPat;
    property SobAutAcc[pBookNum:Str5]:boolean read ReadSobAutAcc write WriteSobAutAcc;
    property SobDocQnt[pBookNum:Str5]:word    read ReadSobDocQnt write WriteSobDocQnt;
    property SobWriNum[pBookNum:Str5]:word    read ReadSobWriNum write WriteSobWriNum;
    property SobPabNum[pBookNum:Str5]:word    read ReadSobPabNum write WriteSobPabNum;
    // OWB
    property OwbDocSnt[pBookNum:Str5]:Str3           read ReadOwbDocSnt  write WriteOwbDocSnt;
    property OwbDocAnl[pBookNum:Str5]:Str6           read ReadOwbDocAnl  write WriteOwbDocAnl;
    property OwbVatSnt[pBookNum:Str5]:Str3           read ReadOwbVatSnt  write WriteOwbVatSnt;
    property OwbVatAnl[pBookNum:Str5]:Str6           read ReadOwbVatAnl  write WriteOwbVatAnl;
    property OwbExnFrm[pBookNum:Str5]:Str12          read ReadOwbExnFrm  write WriteOwbExnFrm;
    property OwbAutAcc[pBookNum:Str5]:boolean        read ReadOwbAutAcc  write WriteOwbAutAcc;
    property OwbVatCls[pBookNum:Str5]:boolean        read ReadOwbVatCls  write WriteOwbVatCls;
    property OwbDvzNam[pBookNum:Str5;pNum:byte]:Str3 read ReadOwbDvzNam  write WriteOwbDvzNam;
    property OwbCsdBok[pBookNum:Str5;pNum:byte]:Str5 read ReadOwbCsdBok  write WriteOwbCsdBok;
    property OwbPabNum[pBookNum:Str5]:word           read ReadOwbPabNum  write WriteOwbPabNum;
    // SVB
    property SvbDocSnt[pBookNum:Str5]:Str3           read ReadSvbDocSnt  write WriteSvbDocSnt; // Synteticka cast uctu zalohy
    property SvbDocAnl[pBookNum:Str5]:Str6           read ReadSvbDocAnl  write WriteSvbDocAnl; // Analyticka cast uctu zalohy
    property SvbVatSnt[pBookNum:Str5]:Str3           read ReadSvbVatSnt  write WriteSvbVatSnt; // Synteticka cast uctu DPH
    property SvbVatAnl[pBookNum:Str5]:Str6           read ReadSvbVatAnl  write WriteSvbVatAnl; // Analyticka cast uctu DPH
    property SvbExnFrm[pBookNum:Str5]:Str12          read ReadSvbExnFrm  write WriteSvbExnFrm; // Format generovania variabilnÈho symbolu
    property SvbAutAcc[pBookNum:Str5]:boolean        read ReadSvbAutAcc  write WriteSvbAutAcc; // Automaticke rozuctovanie dokladu (1-zapnute)
    property SvbWriSha[pBookNum:Str5]:boolean        read ReadSvbWriSha  write WriteSvbWriSha; // Priznak zdielania sklad - zmeny su odoslane cez FTP (1-zdileany)
    property SvbAccNeg[pBookNum:Str5]:boolean        read ReadSvbAccNeg  write WriteSvbAccNeg; // ⁄Ëtovaù na opaËnÈ strany so z·porn˝m znamienkom
    property SvbDvzNam[pBookNum:Str5]:Str3           read ReadSvbDvzNam  write WriteSvbDvzNam; // Skratka devizy, v ktorom sa vedie dana kniha
    property SvbWriNum[pBookNum:Str5]:word           read ReadSvbWriNum  write WriteSvbWriNum; // Cislo prevadzkovej jednotky
    // IDB
    property IdbWriNum[pBookNum:Str5]:word read ReadIdbWriNum write WriteIdbWriNum;
    property IdbWriAdd[pBookNum:Str5]:boolean read ReadIdbWriAdd write WriteIdbWriAdd;
    property IdbAutAcc[pBookNum:Str5]:boolean read ReadIdbAutAcc write WriteIdbAutAcc;
    // ACB
    property AcbPlsNum[pBookNum:Str5]:word read ReadAcbPlsNum write WriteAcbPlsNum;
    property AcbRndTyp[pBookNum:Str5]:integer read ReadAcbRndTyp write WriteAcbRndTyp;
    property AcbPrnMor:boolean read ReadAcbPrnMor write WriteAcbPrnMor; // Hromadna Tlac etikiet na A4
  end;

var gKey:TKey;

implementation

const  cOn='ON';  cOff='OFF';

constructor TKey.Create;
begin
  ohKEYDEF := TKeydefHnd.Create;  ohKEYDEF.Open;
  oSys:=TSysKey.Create(ohKEYDEF);
  oNes:=TNesKey.Create(ohKEYDEF);
  oStk:=TStkKey.Create(ohKEYDEF);
  oTes:=TTesKey.Create(ohKEYDEF);
  oWhs:=TWhsKey.Create(ohKEYDEF);
  oGsc:=TGscKey.Create(ohKEYDEF);
  oApl:=TAplKey.Create(ohKEYDEF);
  oOsb:=TOsbKey.Create(ohKEYDEF);
  oEmc:=TEmcKey.Create(ohKEYDEF);
  oOcm:=TOcmKey.Create(ohKEYDEF);
  oIcm:=TIcmKey.Create(ohKEYDEF);
  oDir:=TDirKey.Create(ohKEYDEF);
  oPrm:=TPrmKey.Create(ohKEYDEF);
  oPrb:=TPrbKey.Create(ohKEYDEF);
  oCrb:=TCrbKey.Create(ohKEYDEF);
  oKsb:=TKsbKey.Create(ohKEYDEF);
  oScm:=TScmKey.Create(ohKEYDEF);
  oXrm:=TXrmKey.Create(ohKEYDEF);
end;

destructor  TKey.Destroy;
begin
  FreeAndNil(oXrm);
  FreeAndNil(oScm);
  FreeAndNil(oKsb);
  FreeAndNil(oCrb);
  FreeAndNil(oPrb);
  FreeAndNil(oPrm);
  FreeAndNil(oDir);
  FreeAndNil(oIcm);
  FreeAndNil(oOcm);
  FreeAndNil(oOsb);
  FreeAndNil(oEmc);
  FreeAndNil(oApl);
  FreeAndNil(oGsc);
  FreeAndNil(oWhs);
  FreeAndNil(oTes);
  FreeAndNil(oStk);
  FreeAndNil(oNes);
  FreeAndNil(oSys);
  FreeAndNil(ohKEYDEF);
end;

// *************************************** PRIVATE ********************************************

function TKey.KeyExist (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30):boolean;
begin
  pPmdMark:=UpperCase(pPmdMark);
  Result := ohKEYDEF.LocatePmBnKn(pPmdMark,pBookNum,pKeyName);
end;

function TKey.ReadString (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:Str200):Str200;
begin
  pPmdMark:=UpperCase(pPmdMark);
  Result := pDefault;
  If ohKEYDEF.LocatePmBnKn(pPmdMark,pBookNum,pKeyName)
    then Result := ohKEYDEF.Keyval
    else WriteString (pPmdMark,pBookNum,pKeyName,pDefault);
end;

procedure TKey.WriteString (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:Str200);
begin
  pPmdMark:=UpperCase(pPmdMark);
  If ohKEYDEF.LocatePmBnKn(pPmdMark,pBookNum,pKeyName) then begin
    ohKEYDEF.Edit;
    ohKEYDEF.KeyVal := pKeyVal;
    ohKEYDEF.Post;
  end
  else begin
    ohKEYDEF.Insert;
    ohKEYDEF.PmdMark := pPmdMark;
    ohKEYDEF.BookNum := pBookNum;
    ohKEYDEF.KeyName := pKeyName;
    ohKEYDEF.KeyVal := pKeyVal;
    ohKEYDEF.Post;
  end;
end;

// ********************************* PUBLIC ************************************

procedure TKey.CopyBokKey(pPmdMark:Str3;pSrcBok,pTrgBok:Str5); // Prekopiruje vsetky vlastnosti zdrojovej knihy do cielovej
var mhKEYDEF:TKeydefHnd;
begin
  pPmdMark:=UpperCase(pPmdMark);
  If ohKEYDEF.LocatePmBn(pPmdMark,pSrcBok) then begin
    mhKEYDEF := TKeydefHnd.Create;  mhKEYDEF.Open;
    Repeat
      If not mhKEYDEF.LocatePmBnKn(pPmdMark,pTrgBok,ohKEYDEF.KeyName) then begin
        mhKEYDEF.Insert;
        mhKEYDEF.PmdMark := pPmdMark;
        mhKEYDEF.BookNum := pTrgBok;
        mhKEYDEF.KeyName := ohKEYDEF.KeyName;
        mhKEYDEF.KeyVal := ohKEYDEF.KeyVal;
        mhKEYDEF.Post;
      end;
      ohKEYDEF.Next;
    until ohKEYDEF.Eof or (ohKEYDEF.PmdMark<>pPmdMark) or (ohKEYDEF.BookNum<>pSrcBok);
    FreeANdNil(mhKEYDEF);
  end;
end;

// ********************************** SYS *************************************

function TKey.ReadRegName:Str60;
begin
  Result := ReadString ('SYS','OWNDAT','RegName','');
end;

procedure TKey.WriteRegName(pValue:Str60);
begin
  WriteString ('SYS','OWNDAT','RegName',pValue);
end;

function TKey.ReadRegAddr:Str30;
begin
end;

procedure TKey.WriteRegAddr(pValue:Str30);
begin
end;

function TKey.ReadRegZip:Str15;
begin
end;

procedure TKey.WriteRegZip(pValue:Str15);
begin
end;

function TKey.ReadRegCty:Str3;
begin
end;

procedure TKey.WriteRegCty(pValue:Str3);
begin
end;

function TKey.ReadRegCtn:Str30;
begin
end;

procedure TKey.WriteRegCtn(pValue:Str30);
begin
end;

function TKey.ReadRegSta:Str2;
begin
end;

procedure TKey.WriteRegSta(pValue:Str2);
begin
end;

function TKey.ReadRegStn:Str30;
begin
end;

procedure TKey.WriteRegStn(pValue:Str30);
begin
end;

function TKey.ReadRegRec:Str80;
begin
end;

procedure TKey.WriteRegRec(pValue:Str80);
begin
end;

function TKey.ReadRegWeb:Str50;
begin
end;

procedure TKey.WriteRegWeb(pValue:Str50);
begin
end;

function TKey.ReadHedName:Str30;
begin
end;

procedure TKey.WriteHedName(pValue:Str30);
begin
end;

function TKey.ReadSysFixCrs:double;
begin
  Result := ValDoub(ReadString ('SYS','','SysFixCrs','0'));
end;

procedure TKey.WriteSysFixCrs(pValue:double);
begin
  WriteString ('SYS','','SysFixCrs',StrDoub(pValue,0,4));
end;

function TKey.ReadSysInfDvz:Str3;
begin
  Result := ReadString ('SYS','','SysInfDvz','');
end;

procedure TKey.WriteSysInfDvz(pValue:Str3);
begin
  WriteString ('SYS','','SysInfDvz',pValue);
end;

function TKey.ReadSysAttPat:Str80;
begin
  Result := ReadString ('SYS','','SysAttPat','');
end;

procedure TKey.WriteSysAttPat(pValue:Str80);
begin
  WriteString ('SYS','','SysAttPat',pValue);
end;

procedure TKey.WriteSysAttCpy(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysAttCpy',cOn)
    else WriteString ('SYS','','SysAttCpy',cOff)
end;

function TKey.ReadSysAttCpy:Boolean;
begin
  Result := ReadString('SYS','','SysAttCpy',cOff)=cOn;
end;

function TKey.ReadSysAccDvz:Str3;
begin
  Result := ReadString ('SYS','','SysAccDvz','EUR');
end;

procedure TKey.WriteSysAccDvz(pValue:Str3);
begin
  WriteString ('SYS','','SysAccDvz',pValue);
end;

function TKey.ReadSysMsuRnd:byte;
begin
  Result := ValInt(ReadString('SYS','','SysMsuRnd','0'));
end;

procedure TKey.WriteSysMsuRnd(pValue:byte);
begin
  WriteString ('SYS','','SysMsuRnd',StrInt(pValue,1));
end;

function TKey.ReadSysMsuFrc:byte;
begin
  Result := ValInt(ReadString('SYS','','SysMsuFrc','3'));
end;

procedure TKey.WriteSysMsuFrc(pValue:byte);
begin
  WriteString ('SYS','','SysMsuFrc',StrInt(pValue,1));
end;

function TKey.ReadSysGsnSrc:byte;
begin
  Result := ValInt(ReadString('SYS','','SysGsnSrc','0'));
end;

procedure TKey.WriteSysGsnSrc(pValue:byte);
begin
  WriteString ('SYS','','SysGsnSrc',StrInt(pValue,1));
end;

function TKey.ReadSysAcvFrc:byte;
begin
  Result := ValInt(ReadString('SYS','','SysAcvFrc','2'));
end;

procedure TKey.WriteSysAcvFrc(pValue:byte);
begin
  WriteString ('SYS','','SysAcvFrc',StrInt(pValue,1));
end;

function TKey.ReadSysFgpFrc:byte;
begin
  Result := ValInt(ReadString('SYS','','SysFgpFrc','5'));
end;

procedure TKey.WriteSysFgpFrc(pValue:byte);
begin
  WriteString ('SYS','','SysFgpFrc',StrInt(pValue,1));
end;

function TKey.ReadSysFgvFrc:byte;
begin
  Result := ValInt(ReadString('SYS','','SysFgvFrc','4'));
end;

procedure TKey.WriteSysFgvFrc(pValue:byte);
begin
  WriteString ('SYS','','SysFgvFrc',StrInt(pValue,1));
end;


function TKey.ReadSysNrdFrc:byte;
begin
  Result := ValInt(ReadString('SYS','','SysNrdFrc','5'));
end;

procedure TKey.WriteSysNrdFrc(pValue:byte);
begin
  WriteString ('SYS','','SysNrdFrc',StrInt(pValue,1));
end;

function TKey.ReadSysFjrSig:boolean;
begin
  Result := ReadString('SYS','','SysFjrSig',cOff)=cOn;
end;

procedure TKey.WriteSysFjrSig(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysFjrSig',cOn)
    else WriteString ('SYS','','SysFjrSig',cOff)
end;

function TKey.ReadSysSpeLev:boolean;
begin
  Result := ReadString('SYS','','SysSpeLev',cOff)=cOn;
end;

procedure TKey.WriteSysSpeLev(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysSpeLev',cOn)
    else WriteString ('SYS','','SysSpeLev',cOff)
end;

function TKey.ReadSysMaxScr:boolean;
begin
  Result := ReadString('SYS','','SysMaxScr',cOn)=cOn;
end;

procedure TKey.WriteSysMaxScr(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysMaxScr',cOn)
    else WriteString ('SYS','','SysMaxScr',cOff)
end;

function TKey.ReadSysPyeAdd:boolean;
begin
  Result := ReadString('SYS','','SysPyeAdd',cOff)=cOn;
end;

procedure TKey.WriteSysPyeAdd(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysPyeAdd',cOn)
    else WriteString ('SYS','','SysPyeAdd',cOff)
end;

function TKey.ReadSysEdiSpc:boolean;
begin
  Result := ReadString('SYS','','SysEdiSpc',cOff)=cOn;
end;

procedure TKey.WriteSysEdiSpc(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysEdiSpc',cOn)
    else WriteString ('SYS','','SysEdiSpc',cOff)
end;

function TKey.ReadSysEdiPce:boolean;
begin
  Result := ReadString('SYS','','SysEdiPce',cOff)=cOn;
end;

procedure TKey.WriteSysEdiPce(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysEdiPce',cOn)
    else WriteString ('SYS','','SysEdiPce',cOff)
end;

//function TKey.ReadSysAdvGsc(pVatGrp:byte):longint;
function TKey.ReadSysAdvGsc:longint;
begin
//  Result := ValInt(ReadString ('SYS',StrIntZero(pVatGrp,2),'SysAdvGsc','900'+StrIntZero(gIni.GetVatPrc(pVatGrp),2)));
  Result := ValInt(ReadString ('SYS','00','SysAdvGsc','90000'));
end;

//procedure TKey.WriteSysAdvGsc(pVatGrp:byte;pValue:longint);
procedure TKey.WriteSysAdvGsc(pValue:longint);
begin
//  WriteString ('SYS',StrIntZero(pVatGrp,2),'SysAdvGsc',StrInt(pValue,0))
  WriteString ('SYS','00','SysAdvGsc',StrInt(pValue,0))
end;

function TKey.ReadSysAdwGsc(pVatGrp:byte):longint;
begin
  Result := ValInt(ReadString ('SYS',StrIntZero(pVatGrp,2),'SysAdwGsc','901'+StrIntZero(gIni.GetVatPrc(pVatGrp),2)));
end;

procedure TKey.WriteSysAdwGsc(pVatGrp:byte;pValue:longint);
begin
  WriteString ('SYS',StrIntZero(pVatGrp,2),'SysAdwGsc',StrInt(pValue,0))
end;

function TKey.ReadSysAdoGsc:longint;
begin
  Result := ValInt(ReadString ('SYS','','SysAdoGsc','90001'));
end;

procedure TKey.WriteSysAdoGsc(pValue:longint);
begin
  WriteString ('SYS','','SysAdoGsc',StrInt(pValue,0))
end;

function TKey.ReadSysAdgGsc:longint;
begin
  Result := ValInt(ReadString ('SYS','','SysAdgGsc','90002'));
end;

procedure TKey.WriteSysAdgGsc(pValue:longint);
begin
  WriteString ('SYS','','SysAdgGsc',StrInt(pValue,0))
end;

function TKey.ReadSysSinVal:double;
begin
  Result := ValDoub(ReadString ('SYS','','SysSinVal','100'));
end;

procedure TKey.WriteSysSinVal(pValue:double);
begin
  WriteString ('SYS','','SysSinVal',StrDoub(pValue,0,2))
end;

function TKey.ReadSysAutReg:boolean;
begin
  Result := ReadString('SYS','','SysAutReg',cOff)=cOn;
end;

procedure TKey.WriteSysAutReg(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysAutReg',cOn)
    else WriteString ('SYS','','SysAutReg',cOff)
end;

function TKey.ReadSysAnlReg:boolean;
begin
  Result := ReadString('SYS','','SysAnlReg',cOff)=cOn;
end;

procedure TKey.WriteSysAnlReg(pValue:boolean);
begin
  If pValue
    then WriteString ('SYS','','SysAnlReg',cOn)
    else WriteString ('SYS','','SysAnlReg',cOff)
end;

// ********************************** HRS *************************************
function TKey.ReadHrsAutNam(pAutName:byte):Str20;
begin
  Result := ReadString ('HRS',StrIntZero(pAutName,3),'HrsAutNam','');
end;

procedure TKey.WriteHrsAutNam(pAutname:byte;pValue:Str20);
begin
  WriteString ('HRS',StrIntZero(pAutName,3),'HrsAutNam',pValue)
end;

function TKey.ReadHrsCrdDev:byte;
begin
  Result := ValInt(ReadString ('HRS','','HrsCrdDev','1'));
end;

procedure TKey.WriteHrsCrdDev(pValue:byte);
begin
  WriteString ('HRS','','HrsCrdDev',IntToStr(pValue));
end;

function TKey.ReadHrsCrdPor:Str4;
begin
  Result := ReadString ('HRS','','HrsCrdPor','COM1');
end;

procedure TKey.WriteHrsCrdPor(pValue:Str4);
begin
  WriteString ('HRS','','HrsCrdPor',pValue);
end;

function TKey.ReadHrsCrdBau:Str6;
begin
  Result := ReadString ('HRS','','HrsCrdBau','9600');
end;

procedure TKey.WriteHrsCrdBau(pValue:Str6);
begin
  WriteString ('HRS','','HrsCrdBau',pValue);
end;

function TKey.ReadHrsCrdPar:Str1;
begin
  Result := ReadString ('HRS','','HrsCrdPar','N');
end;

procedure TKey.WriteHrsCrdPar(pValue:Str1);
begin
  WriteString ('HRS','','HrsCrdPar',pValue);
end;

function TKey.ReadHrsCrdDat:Str1;
begin
  Result := ReadString ('HRS','','HrsCrdDat','8');
end;

procedure TKey.WriteHrsCrdDat(pValue:Str1);
begin
  WriteString ('HRS','','HrsCrdDat',pValue);
end;

function TKey.ReadHrsCrdStp:Str1;
begin
  Result := ReadString ('HRS','','HrsCrdStp','2');
end;

procedure TKey.WriteHrsCrdStp(pValue:Str1);
begin
  WriteString ('HRS','','HrsCrdStp',pValue);
end;

function TKey.ReadHrsCrdHou:byte;
begin
  Result := ValInt(ReadString ('HRS','','HrsCrdHou','12'));
end;

procedure TKey.WriteHrsCrdHou(pValue:byte);
begin
  WriteString ('HRS','','HrsCrdHou',IntToStr(pValue));
end;

function TKey.ReadHrsHeaLog:boolean;
begin
  Result := (ReadString ('HRS','','HrsHeaLog',cOff)=cOn);
end;

procedure TKey.WriteHrsHeaLog(pValue:boolean);
begin
  If pValue
    then WriteString ('HRS','','HrsHeaLog',cOn)
    else WriteString ('HRS','','HrsHeaLog',cOff)
end;

function TKey.ReadHrsEvnPln:boolean;
begin
  Result := (ReadString ('HRS','','HrsEvnPln',cOn)=cOn);
end;

procedure TKey.WriteHrsEvnPln(pValue:boolean);
begin
  If pValue
    then WriteString ('HRS','','HrsEvnPln',cOn)
    else WriteString ('HRS','','HrsEvnPln',cOff)
end;

function TKey.ReadHrsUseTnr:boolean;
begin
  Result := (ReadString ('HRS','','HrsUseTnr',cOff)=cOn);
end;

procedure TKey.WriteHrsUseTnr(pValue:boolean);
begin
  If pValue
    then WriteString ('HRS','','HrsUseTnr',cOn)
    else WriteString ('HRS','','HrsUseTnr',cOff)
end;

function TKey.ReadHrsCrdPrg:boolean;
begin
  Result := (ReadString ('HRS','','HrsCrdPrg',cOff)=cOn);
end;

procedure TKey.WriteHrsCrdPrg(pValue:boolean);
begin
  If pValue
    then WriteString ('HRS','','HrsCrdPrg',cOn)
    else WriteString ('HRS','','HrsCrdPrg',cOff)
end;

function TKey.ReadHrsCadFmd:boolean;
begin
  Result := (ReadString ('HRS','','HrsCadFmd',cOn)=cOn);
end;

procedure TKey.WriteHrsCadFmd(pValue:boolean);
begin
  If pValue
    then WriteString ('HRS','','HrsCadFmd',cOn)
    else WriteString ('HRS','','HrsCadFmd',cOff)
end;

function TKey.ReadHrsTcdGen:boolean;
begin
  Result := (ReadString ('HRS','','HrsTcdGen',cOn)=cOn);
end;

procedure TKey.WriteHrsTcdGen(pValue:boolean);
begin
  If pValue
    then WriteString ('HRS','','HrsTcdGen',cOn)
    else WriteString ('HRS','','HrsTcdGen',cOff)
end;

function TKey.ReadHrsIncTime:Str5;
begin
  Result := ReadString ('HRS','','HrsIncTime','11:00');
end;

procedure TKey.WriteHrsIncTime(pValue:Str5);
begin
  WriteString ('HRS','','HrsIncTime',pValue);
end;

function TKey.ReadHrsOnitIp:Str15;
begin
  Result := ReadString ('HRS','','HrsOnitIp','127.0.0.1');
end;

procedure TKey.WriteHrsOnitIp(pValue:Str15);
begin
  WriteString ('HRS','','HrsOnitIp',pValue);
end;

function TKey.ReadHrsHeatIP:Str15;
begin
  Result := ReadString ('HRS','','HrsHeatIP','');
end;

procedure TKey.WriteHrsHeatIP(pValue:Str15);
begin
  WriteString ('HRS','','HrsHeatIP',pValue);
end;

function TKey.ReadHrsHeatPor:Str5;
begin
  Result := ReadString ('HRS','','HrsHeatPor','');
end;

procedure TKey.WriteHrsHeatPor(pValue:Str5);
begin
  WriteString ('HRS','','HrsHeatPor',pValue);
end;

function TKey.ReadHrsStkNum:integer;
begin
  Result := ValInt(ReadString ('HRS','','HrsStkNum','1'));
end;

procedure TKey.WriteHrsStkNum(pValue:integer);
begin
  WriteString ('HRS','','HrsStkNum',IntToStr(pValue));
end;

function TKey.ReadHrsWriNum:integer;
begin
  Result := ValInt(ReadString ('HRS','','HrsWriNum','1'));
end;

procedure TKey.WriteHrsWriNum(pValue:integer);
begin
  WriteString ('HRS','','HrsWriNum',IntToStr(pValue));
end;

function TKey.ReadHrsCasNum:integer;
begin
  Result := ValInt(ReadString ('HRS','','HrsCasNum','1'));
end;

procedure TKey.WriteHrsCasNum(pValue:integer);
begin
  WriteString ('HRS','','HrsCasNum',IntToStr(pValue));
end;

function TKey.ReadHrsEvbTim:integer;
begin
  Result := ValInt(ReadString ('HRS','','HrsEvbTim','10'));
end;

procedure TKey.WriteHrsEvbTim(pValue:integer);
begin
  WriteString ('HRS','','HrsEvbTim',IntToStr(pValue));
end;

// ********************************** SHP *************************************

function TKey.ReadShpOrdFrm:byte;
begin
  Result := ValInt(ReadString('SHP','','ShpOrdFrm','1'));
end;

procedure TKey.WriteShpOrdFrm(pValue:byte);
begin
  WriteString ('SHP','','ShpOrdFrm',StrInt(pValue,1));
end;

// ********************************** MAR *************************************
function TKey.ReadMarNpyIcb:Str200;
begin
  Result := ReadString ('MAR','','MarNpyIcb','');
end;

procedure TKey.WriteMarNpyIcb(pValue:Str200);
begin
  WriteString ('MAR','','MarNpyIcb',pValue)
end;

function TKey.ReadMarNpiTcb:Str200;
begin
  Result := ReadString ('MAR','','MarNpiTcb','');
end;

procedure TKey.WriteMarNpiTcb(pValue:Str200);
begin
  WriteString ('MAR','','MarNpiTcb',pValue)
end;

function TKey.ReadMarAdvGsc:longint;
begin
  Result := ValInt(ReadString('MAR','','MarAdvGsc','0'));
end;

procedure TKey.WriteMarAdvGsc(pValue:longint);
begin
  WriteString ('MAR','','MarAdvGsc',StrInt(pValue,0))
end;

function TKey.ReadMarCmpGsc:longint;
begin
  Result := ValInt(ReadString('MAR','','MarCmpGsc','0'));
end;

procedure TKey.WriteMarCmpGsc(pValue:longint);
begin
  WriteString ('MAR','','MarCmpGsc',StrInt(pValue,0))
end;

// *********************************** CRD *************************************
function TKey.ReadCrdSerNum:longint;
begin
  Result := ValInt(ReadString('CRD','','CrdSerNum','0'));
end;

procedure TKey.WriteCrdSerNum(pValue:longint);
begin
  WriteString ('CRD','','CrdSerNum',StrInt(pValue,0))
end;

function TKey.ReadCrdOutNum:longint;
begin
  Result := ValInt(ReadString('CRD','','CrdOutNum','0'));
end;

procedure TKey.WriteCrdOutNum(pValue:longint);
begin
  WriteString ('CRD','','CrdOutNum',StrInt(pValue,0))
end;

function TKey.ReadCrdBacFrm:Str15;
begin
  Result := ReadString ('CRD','','CrdBacFrm','');
end;

procedure TKey.WriteCrdBacFrm(pValue:Str15);
begin
  WriteString ('CRD','','CrdBacFrm',pValue)
end;

procedure TKey.WriteCrdPabNum(pValue:word);
begin
  WriteString ('CRD','','CrdPabNum',StrInt(pValue,0))
end;

function TKey.ReadCrdPabNum:word;
begin
  Result := ValInt(ReadString('CRD','','CrdPabNum','0'));
end;

procedure TKey.WriteCrdTrnBon(pValue:double);
begin
  WriteString('CRD','','CrdTrnBon',StrDoub(pValue,0,2))
end;

function TKey.ReadCrdTrnBon:double;
begin
  Result:=ValDoub(ReadString('CRD','','CrdTrnBon','0'));
end;

procedure TKey.WriteCrdTrnDsc(pValue:double);
begin
  WriteString('CRD','','CrdTrnDsc',StrDoub(pValue,0,2))
end;

function TKey.ReadCrdTrnDsc:double;
begin
  Result:=ValDoub(ReadString('CRD','','CrdTrnDsc','0'));
end;

procedure TKey.WriteCrdTrnBci(pValue:double);
begin
  WriteString('CRD','','CrdTrnBci',StrDoub(pValue,0,2))
end;

function TKey.ReadCrdTrnBci:double;
begin
  Result:=ValDoub(ReadString('CRD','','CrdTrnBci','0'));
end;

procedure TKey.WriteCrdBonPay(pValue:double);
begin
  WriteString ('CRD','','CrdBonPay',StrDoub(pValue,0,2))
end;

function TKey.ReadCrdBonPay:double;
begin
  Result := ValDoub(ReadString('CRD','','CrdBonPay','0'));
end;

procedure TKey.WriteCrdDscPrc(pValue:double);
begin
  WriteString ('CRD','','CrdDscPrc',StrDoub(pValue,0,2))
end;

function TKey.ReadCrdDscPrc:double;
begin
  Result := ValDoub(ReadString('CRD','','CrdDscPrc','0'));
end;

procedure TKey.WriteCrdCasRef(pValue:boolean);
begin
  If pValue
    then WriteString ('CRD','','CrdCasRef',cOn)
    else WriteString ('CRD','','CrdCasRef',cOff)
end;

function TKey.ReadCrdCasRef:boolean;
begin
  Result := ReadString('CRD','','CrdCasRef',cOff)=cOn;
end;

// *********************************** WRI *************************************
function TKey.ReadWriPaCode(pWriNum:word):longint;
begin
  Result := ValInt(ReadString ('WRI',StrIntZero(pWriNum,5),'WriPaCode','0'));
end;

procedure TKey.WriteWriPaCode(pWriNum:word;pValue:longint);
begin
  WriteString ('WRI',StrIntZero(pWriNum,5),'WriPaCode',StrInt(pValue,0))
end;

function TKey.ReadWriOcbNum(pWriNum:word):Str5;
begin
  Result := ReadString ('WRI',StrIntZero(pWriNum,5),'WriOcbNum','');
end;

procedure TKey.WriteWriOcbNum(pWriNum:word;pValue:Str5);
begin
  WriteString ('WRI',StrIntZero(pWriNum,5),'WriOcbNum',pValue)
end;

// *********************************** PAB *************************************

function TKey.ReadPabNumIno:boolean;
begin
  Result := ReadString('PAB','','PabNumIno',cOff)=cOn;
end;

procedure TKey.WritePabNumIno(pValue:boolean);
begin
  If pValue
    then WriteString ('PAB','','PabNumIno',cOn)
    else WriteString ('PAB','','PabNumIno',cOff)
end;

function TKey.ReadPabSrcLic:Str20;
begin
  Result := ReadString('PAB','','PabSrcLic','');
end;

procedure TKey.WritePabSrcLic(pValue:Str20);
begin
  WriteString ('PAB','','PabSrcLic',pValue)
end;

// *********************************** SRB *************************************

function TKey.ReadSrbStmCod:Str60;
begin
  Result := ReadString('SRB','','SrbStmCod','13,23,52,53,67,68');
end;

procedure TKey.WriteSrbStmCod(pValue:Str60);
begin
  WriteString ('SRB','','SrbStmCod',pValue)
end;

// *********************************** DSC *************************************

function TKey.ReadDscFgCode:Str60;
begin
  Result := ReadString('DSC','','DscFgCode','1000..9999');
end;

procedure TKey.WriteDscFgCode(pValue:Str60);
begin
  WriteString ('DSC','','DscFgCode',pValue)
end;

function TKey.ReadDscRefGen:boolean;
begin
  Result := ReadString('DSC','','DscRefGen',cOn)=cOn;
end;

procedure TKey.WriteDscRefGen(pValue:boolean);
begin
  If pValue
    then WriteString ('DSC','','DscRefGen',cOn)
    else WriteString ('DSC','','DscRefGen',cOff)
end;

// *********************************** BLC *************************************

function TKey.ReadBlcPrvYea:boolean;
begin
  Result := ReadString('BLC','','BlcPrvYea',cOff)=cOn;
end;

procedure TKey.WriteBlcPrvYea(pValue:boolean);
begin
  If pValue
    then WriteString ('BLC','','BlcPrvYea',cOn)
    else WriteString ('BLC','','BlcPrvYea',cOff)
end;

// *********************************** ACC *************************************

function TKey.ReadAccAcYear:Str4;
begin
  Result := ReadString('ACC','','AccAcYear',gvSys.ActYear);
end;

procedure TKey.WriteAccAcYear(pValue:Str4);
begin
  WriteString ('ACC','','AccAcYear',pValue)
end;

// *********************************** VTR *************************************

function TKey.ReadVtrDocCls:boolean;
begin
  Result := ReadString('VTR','','VtrDocCls',cOn)=cOn;
end;

procedure TKey.WriteVtrDocCls(pValue:boolean);
begin
  If pValue
    then WriteString ('VTR','','VtrDocCls',cOn)
    else WriteString ('VTR','','VtrDocCls',cOff)
end;

function TKey.ReadVtrMthQnt:byte;
begin
  Result := ValInt(ReadString('VTR','','VtrMthQnt','1'));
end;

procedure TKey.WriteVtrMthQnt(pValue:byte);
begin
  WriteString ('VTR','','VtrMthQnt',StrInt(pValue,0));
end;

function TKey.ReadVtrTaxOff:Str60;
begin
  Result := ReadString ('VTR','','VtrTaxOff','');
end;

procedure TKey.WriteVtrTaxOff(pValue:Str60);
begin
  WriteString ('VTR','','VtrTaxOff',pValue)
end;

function TKey.ReadVtrAutNam:Str30;
begin
  Result := ReadString ('VTR','','VtrAutNam','');
end;

procedure TKey.WriteVtrAutNam(pValue:Str30);
begin
  WriteString ('VTR','','VtrAutNam',pValue)
end;

function TKey.ReadVtrAutTel:Str15;
begin
  Result := ReadString ('VTR','','VtrAutTel','');
end;

procedure TKey.WriteVtrAutTel(pValue:Str15);
begin
  WriteString ('VTR','','VtrAutTel',pValue)
end;

function TKey.ReadVtrAutEml:Str30;
begin
  Result := ReadString ('VTR','','VtrAutEml','');
end;

procedure TKey.WriteVtrAutEml(pValue:Str30);
begin
  WriteString ('VTR','','VtrAutEml',pValue)
end;

function TKey.ReadVtrRegStr:Str30;
begin
  Result := ReadString ('VTR','','VtrRegStr','');
end;

procedure TKey.WriteVtrRegStr(pValue:Str30);
begin
  WriteString ('VTR','','VtrRegStr',pValue)
end;

function TKey.ReadVtrRegNum:Str10;
begin
  Result := ReadString ('VTR','','VtrRegNum','');
end;

procedure TKey.WriteVtrRegNum(pValue:Str10);
begin
  WriteString ('VTR','','VtrRegNum',pValue)
end;

function TKey.ReadVtrRegStn:Str30;
begin
  Result := ReadString ('VTR','','VtrRegStn','');
end;

procedure TKey.WriteVtrRegStn(pValue:Str30);
begin
  WriteString ('VTR','','VtrRegStn',pValue)
end;

function TKey.ReadVtrRegCtn:Str30;
begin
  Result := ReadString ('VTR','','VtrRegCtn','');
end;

procedure TKey.WriteVtrRegCtn(pValue:Str30);
begin
  WriteString ('VTR','','VtrRegCtn',pValue)
end;

function TKey.ReadVtrRegZip:Str5;
begin
  Result := ReadString ('VTR','','VtrRegZip','');
end;

procedure TKey.WriteVtrRegZip(pValue:Str5);
begin
  WriteString ('VTR','','VtrRegZip',pValue)
end;

function TKey.ReadVtrRegTel:Str15;
begin
  Result := ReadString ('VTR','','VtrRegTel','');
end;

procedure TKey.WriteVtrRegTel(pValue:Str15);
begin
  WriteString ('VTR','','VtrRegTel',pValue)
end;

function TKey.ReadVtrRegFax:Str15;
begin
  Result := ReadString ('VTR','','VtrRegFax','');
end;

procedure TKey.WriteVtrRegFax(pValue:Str15);
begin
  WriteString ('VTR','','VtrRegFax',pValue)
end;

function TKey.ReadVtrRegEml:Str60;
begin
  Result := ReadString ('VTR','','VtrRegEml','');
end;

procedure TKey.WriteVtrRegEml(pValue:Str60);
begin
  WriteString ('VTR','','VtrRegEml',pValue)
end;

// *********************************** PLS *************************************

function TKey.ReadPlsSapFrc(pPlsNum:word):byte;
begin
  Result := ValInt(ReadString('PLS',StrInt(pPlsNum,0),'PlsSapFrc','2'));
end;

procedure TKey.WritePlsSapFrc(pPlsNum:word;pValue:byte);
begin
  WriteString ('PLS',StrInt(pPlsNum,0),'PlsSapFrc',StrInt(pValue,0));
end;

function TKey.ReadPlsSapRnd(pPlsNum:word):byte;
begin
  Result := ValInt(ReadString('PLS',StrInt(pPlsNum,0),'PlsSapRnd','0'));
end;

procedure TKey.WritePlsSapRnd(pPlsNum:word;pValue:byte);
begin
  WriteString ('PLS',StrInt(pPlsNum,0),'PlsSapRnd',StrInt(pValue,0));
end;

function TKey.ReadPlsRefDia(pPlsNum:word):boolean;
begin
  Result := ReadString('PLS',StrInt(pPlsNum,0),'PlsRefDia',cOn)=cOn;
end;

procedure TKey.WritePlsRefDia(pPlsNum:word;pValue:boolean);
begin
  If pValue
    then WriteString ('PLS',StrInt(pPlsNum,0),'PlsRefDia',cOn)
    else WriteString ('PLS',StrInt(pPlsNum,0),'PlsRefDia',cOff)
end;

// *********************************** STK *************************************
function TKey.ReadStpRndFrc:byte;
begin
  Result := ValInt(ReadString ('STK','','StpRndFrc','6'));
  If Result=0 then Result := 2;
end;

procedure TKey.WriteStpRndFrc(pValue:byte);
begin
  WriteString ('STK','','StpRndFrc',StrInt(pValue,0))
end;

function TKey.ReadStqRndFrc:byte;
begin
  Result := ValInt(ReadString ('STK','','StqRndFrc','3'));
  If Result=0 then Result := 3;
end;

procedure TKey.WriteStqRndFrc(pValue:byte);
begin
  WriteString ('STK','','StqRndFrc',StrInt(pValue,0))
end;

function TKey.ReadStvRndFrc:byte;
begin
  Result := ValInt(ReadString ('STK','','StvRndFrc','4'));
  If Result=0 then Result := 2;
end;

procedure TKey.WriteStvRndFrc(pValue:byte);
begin
  WriteString ('STK','','StvRndFrc',StrInt(pValue,0))
end;

function TKey.ReadStkScType(pBookNum:Str5):Str1;
begin
  Result := ReadString ('STK',pBookNum,'StkScType','T');
end;

procedure TKey.WriteStkScType(pBookNum:Str5;pValue:Str1);
begin
  WriteString ('STK',pBookNum,'StkScType',pValue);
end;

function TKey.ReadStkWriNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('STK',pBookNum,'StkWriNum','1'));
end;

procedure TKey.WriteStkWriNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('STK',pBookNum,'StkWriNum',StrInt(pValue,0));
end;

function TKey.ReadStkPlsNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('STK',pBookNum,'StkPlsNum','1'));
end;

procedure TKey.WriteStkPlsNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('STK',pBookNum,'StkPlsNum',StrInt(pValue,0));
end;

function TKey.ReadStkShared(pBookNum:Str5):boolean;
begin
  Result := ReadString('STK',pBookNum,'StkShared',cOff)=cOn;
end;

procedure TKey.WriteStkShared(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('STK',pBookNum,'StkShared',cOn)
    else WriteString ('STK',pBookNum,'StkShared',cOff)
end;

function TKey.ReadStkRsvOcd(pBookNum:Str5):boolean;
begin
  Result := ReadString('STK',pBookNum,'StkRsvOcd',cOn)=cOn;
end;

procedure TKey.WriteStkRsvOcd(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('STK',pBookNum,'StkRsvOcd',cOn)
    else WriteString ('STK',pBookNum,'StkRsvOcd',cOff)
end;

function TKey.ReadStkNulPrc:boolean;
begin
  Result := ReadString('STK','','StkNulPrc',cOff)=cOn;
end;

procedure TKey.WriteStkNulPrc(pValue:boolean);
begin
  If pValue
    then WriteString ('STK','','StkNulPrc',cOn)
    else WriteString ('STK','','StkNulPrc',cOff)
end;

// *********************************** CMB *************************************
function TKey.ReadCmbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('CMB',pBookNum,'CmbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteCmbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('CMB',pBookNum,'CmbOnlSub',cOn)
     else WriteString ('CMB',pBookNum,'CmbOnlSub',cOff)
end;

function TKey.ReadCmbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CMB',pBookNum,'CmbStkNum','1'));
end;

procedure TKey.WriteCmbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('CMB',pBookNum,'CmbStkNum',StrInt(pValue,0))
end;

function TKey.ReadCmbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CMB',pBookNum,'CmbPlsNum','1'));
end;

procedure TKey.WriteCmbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('CMB',pBookNum,'CmbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadCmbSmCode(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CMB',pBookNum,'CmbSmCode','0'));
end;

procedure TKey.WriteCmbSmCode(pBookNum:Str5;pValue:word);
begin
  WriteString ('CMB',pBookNum,'CmbSmCode',StrInt(pValue,0))
end;

// *********************************** DMB *************************************
function TKey.ReadDmbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('DMB',pBookNum,'DmbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteDmbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('DMB',pBookNum,'DmbOnlSub',cOn)
     else WriteString ('DMB',pBookNum,'DmbOnlSub',cOff)
end;

function TKey.ReadDmbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('DMB',pBookNum,'DmbPlsNum','1'));
end;

procedure TKey.WriteDmbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('DMB',pBookNum,'DmbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadDmbStkNuI(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('DMB',pBookNum,'DmbStkNuI','1'));
end;

procedure TKey.WriteDmbStkNuI(pBookNum:Str5;pValue:word);
begin
  WriteString ('DMB',pBookNum,'DmbStkNuI',StrInt(pValue,0))
end;

function TKey.ReadDmbStkNuO(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('DMB',pBookNum,'DmbStkNuO','0'));
end;

procedure TKey.WriteDmbStkNuO(pBookNum:Str5;pValue:word);
begin
  WriteString ('DMB',pBookNum,'DmbStkNuO',StrInt(pValue,0))
end;

function TKey.ReadDmbSmCodI(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('DMB',pBookNum,'DmbSmCodI','25'));
end;

procedure TKey.WriteDmbSmCodI(pBookNum:Str5;pValue:word);
begin
  WriteString ('DMB',pBookNum,'DmbSmCodI',StrInt(pValue,0))
end;

function TKey.ReadDmbSmCodO(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('DMB',pBookNum,'DmbSmCodO','15'));
end;

procedure TKey.WriteDmbSmCodO(pBookNum:Str5;pValue:word);
begin
  WriteString ('DMB',pBookNum,'DmbSmCodO',StrInt(pValue,0))
end;

// *********************************** CDB *************************************
function TKey.ReadCdbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('CDB',pBookNum,'CdbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteCdbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('CDB',pBookNum,'CdbOnlSub',cOn)
     else WriteString ('CDB',pBookNum,'CdbOnlSub',cOff)
end;

function TKey.ReadCdbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CDB',pBookNum,'CdbPlsNum','1'));
end;

procedure TKey.WriteCdbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('CDB',pBookNum,'CdbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadCdbStkNuI(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CDB',pBookNum,'CdbStkNuI','1'));
end;

procedure TKey.WriteCdbStkNuI(pBookNum:Str5;pValue:word);
begin
  WriteString ('CDB',pBookNum,'CdbStkNuI',StrInt(pValue,0))
end;

function TKey.ReadCdbStkNuO(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CDB',pBookNum,'CdbStkNuO','0'));
end;

procedure TKey.WriteCdbStkNuO(pBookNum:Str5;pValue:word);
begin
  WriteString ('CDB',pBookNum,'CdbStkNuO',StrInt(pValue,0))
end;

function TKey.ReadCdbSmCodI(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CDB',pBookNum,'CdbSmCodI','64'));
end;

procedure TKey.WriteCdbSmCodI(pBookNum:Str5;pValue:word);
begin
  WriteString ('CDB',pBookNum,'CdbSmCodI',StrInt(pValue,0))
end;

function TKey.ReadCdbSmCodO(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CDB',pBookNum,'CdbSmCodO','63'));
end;

procedure TKey.WriteCdbSmCodO(pBookNum:Str5;pValue:word);
begin
  WriteString ('CDB',pBookNum,'CdbSmCodO',StrInt(pValue,0))
end;

function TKey.ReadCdbCpiBok(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CDB',pBookNum,'CdbCpiBok','1'));
end;

procedure TKey.WriteCdbCpiBok(pBookNum:Str5;pValue:word);
begin
  WriteString ('CDB',pBookNum,'CdbCpiBok',StrInt(pValue,0))
end;

// *********************************** IMB *************************************
function TKey.ReadImbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('IMB',pBookNum,'ImbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteImbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('IMB',pBookNum,'ImbOnlSub',cOn)
     else WriteString ('IMB',pBookNum,'ImbOnlSub',cOff)
end;

function TKey.ReadImbBpcMod(pBookNum:Str5):boolean;
begin
  Result := ReadString ('IMB',pBookNum,'ImbBpcMod',cOff)=cOn;
end;

procedure TKey.WriteImbBpcMod(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('IMB',pBookNum,'ImbBpcMod',cOn)
     else WriteString ('IMB',pBookNum,'ImbBpcMod',cOff)
end;

function TKey.ReadImbSpcMov(pBookNum:Str5):boolean;
begin
  Result := ReadString ('IMB',pBookNum,'ImbSpcMov',cOff)=cOn;
end;

procedure TKey.WriteImbSpcMov(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('IMB',pBookNum,'ImbSpcMov',cOn)
     else WriteString ('IMB',pBookNum,'ImbSpcMov',cOff)
end;

function TKey.ReadImbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('IMB',pBookNum,'ImbStkNum','1'));
end;

procedure TKey.WriteImbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('IMB',pBookNum,'ImbStkNum',StrInt(pValue,0))
end;

function TKey.ReadImbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('IMB',pBookNum,'ImbPlsNum','1'));
end;

procedure TKey.WriteImbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('IMB',pBookNum,'ImbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadImbSmCode(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('IMB',pBookNum,'ImbSmCode','0'));
end;

procedure TKey.WriteImbSmCode(pBookNum:Str5;pValue:word);
begin
  WriteString ('IMB',pBookNum,'ImbSmCode',StrInt(pValue,0))
end;

function TKey.ReadImbDlvDay(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('IMB',pBookNum,'ImbDlvDay','5'));
end;

procedure TKey.WriteImbDlvDay(pBookNum:Str5;pValue:word);
begin
  WriteString ('IMB',pBookNum,'ImbDlvDay',StrInt(pValue,0))
end;

function TKey.ReadImbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('IMB',pBookNum,'ImbAutAcc',cOn)=cOn;
end;

procedure TKey.WriteImbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('IMB',pBookNum,'ImbAutAcc',cOn)
    else WriteString ('IMB',pBookNum,'ImbAutAcc',cOff)
end;

function TKey.ReadImbFtpRcv(pBookNum:Str5):boolean;
begin
  Result := ReadString ('IMB',pBookNum,'ImbFtpRcv',cOn)=cOn;
end;

procedure TKey.WriteImbFtpRcv(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('IMB',pBookNum,'ImbFtpRcv',cOn)
    else WriteString ('IMB',pBookNum,'ImbFtpRcv',cOff)
end;

// *********************************** OMB *************************************
function TKey.ReadOmbOnlRwd(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OMB',pBookNum,'OmbOnlRwd',cOff)=cOn;
end;

procedure TKey.WriteOmbOnlRwd(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OMB',pBookNum,'OmbOnlRwd',cOn)
    else WriteString ('OMB',pBookNum,'OmbOnlRwd',cOff)
end;

function TKey.ReadOmbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OMB',pBookNum,'OmbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteOmbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('OMB',pBookNum,'OmbOnlSub',cOn)
     else WriteString ('OMB',pBookNum,'OmbOnlSub',cOff)
end;

function TKey.ReadOmbBpcMod(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OMB',pBookNum,'OmbBpcMod',cOff)=cOn;
end;

procedure TKey.WriteOmbBpcMod(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('OMB',pBookNum,'OmbBpcMod',cOn)
     else WriteString ('OMB',pBookNum,'OmbBpcMod',cOff)
end;

function TKey.ReadOmbSpcMov(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OMB',pBookNum,'OmbSpcMov',cOff)=cOn;
end;

procedure TKey.WriteOmbSpcMov(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('OMB',pBookNum,'OmbSpcMov',cOn)
     else WriteString ('OMB',pBookNum,'OmbSpcMov',cOff)
end;

function TKey.ReadOmbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OMB',pBookNum,'OmbStkNum','1'));
end;

procedure TKey.WriteOmbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OMB',pBookNum,'OmbStkNum',StrInt(pValue,0))
end;

function TKey.ReadOmbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OMB',pBookNum,'OmbPlsNum','1'));
end;

procedure TKey.WriteOmbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OMB',pBookNum,'OmbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadOmbSmCode(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OMB',pBookNum,'OmbSmCode','0'));
end;

procedure TKey.WriteOmbSmCode(pBookNum:Str5;pValue:word);
begin
  WriteString ('OMB',pBookNum,'OmbSmCode',StrInt(pValue,0))
end;

function TKey.ReadOmbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OMB',pBookNum,'OmbAutAcc',cOn)=cOn;
end;

procedure TKey.WriteOmbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OMB',pBookNum,'OmbAutAcc',cOn)
    else WriteString ('OMB',pBookNum,'OmbAutAcc',cOff)
end;

function TKey.ReadOmbFtpSnd(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OMB',pBookNum,'OmbFtpSnd',cOn)=cOn;
end;

procedure TKey.WriteOmbFtpSnd(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OMB',pBookNum,'OmbFtpSnd',cOn)
    else WriteString ('OMB',pBookNum,'OmbFtpSnd',cOff)
end;

function TKey.ReadOmbImbStk(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OMB',pBookNum,'OmbImbStk','1'));
end;

procedure TKey.WriteOmbImbStk(pBookNum:Str5;pValue:word);
begin
  WriteString ('OMB',pBookNum,'OmbImbStk',StrInt(pValue,0))
end;

function TKey.ReadOmbImbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString('OMB',pBookNum,'OmbImbNum','');
end;

procedure TKey.WriteOmbImbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OMB',pBookNum,'OmbImbNum',pValue)
end;

function TKey.ReadOmbImbSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OMB',pBookNum,'OmbImbSmc','0'));
end;

procedure TKey.WriteOmbImbSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('OMB',pBookNum,'OmbImbSmc',StrInt(pValue,0))
end;

// *********************************** RMB *************************************

function TKey.ReadRmbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('RMB',pBookNum,'RmbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteRmbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('RMB',pBookNum,'RmbBoYear',pValue);
end;

function TKey.ReadRmbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('RMB',pBookNum,'RmbWriNum','1'));
end;

procedure TKey.WriteRmbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('RMB',pBookNum,'RmbWriNum',StrInt(pValue,0));
end;

function TKey.ReadRmbOutStn(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('RMB',pBookNum,'RmbOutStn','0'));
end;

procedure TKey.WriteRmbOutStn(pBookNum:Str5;pValue:word);
begin
  WriteString ('RMB',pBookNum,'RmbOutStn',StrInt(pValue,0));
end;

function TKey.ReadRmbIncStn(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('RMB',pBookNum,'RmbIncStn','0'));
end;

procedure TKey.WriteRmbIncStn(pBookNum:Str5;pValue:word);
begin
  WriteString ('RMB',pBookNum,'RmbIncStn',StrInt(pValue,0));
end;

function TKey.ReadRmbOutSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('RMB',pBookNum,'RmbOutSmc','51'));
end;

procedure TKey.WriteRmbOutSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('RMB',pBookNum,'RmbOutSmc',StrInt(pValue,0));
end;

function TKey.ReadRmbIncSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('RMB',pBookNum,'RmbIncSmc','50'));
end;

procedure TKey.WriteRmbIncSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('RMB',pBookNum,'RmbIncSmc',StrInt(pValue,0));
end;

function TKey.ReadRmbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('RMB',pBookNum,'RmbAutAcc',cOff)=cOn;
end;

procedure TKey.WriteRmbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('RMB',pBookNum,'RmbAutAcc',cOn)
     else WriteString ('RMB',pBookNum,'RmbAutAcc',cOff)
end;

function TKey.ReadRmbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('RMB',pBookNum,'RmbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteRmbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('RMB',pBookNum,'RmbOnlSub',cOn)
     else WriteString ('RMB',pBookNum,'RmbOnlSub',cOff)
end;

function TKey.ReadRmbSpcMov(pBookNum:Str5):boolean;
begin
  Result := ReadString ('RMB',pBookNum,'RmbSpcMov',cOff)=cOn;
end;

procedure TKey.WriteRmbSpcMov(pBookNum:Str5;pValue:boolean);
begin
  If pValue
     then WriteString ('RMB',pBookNum,'RmbSpcMov',cOn)
     else WriteString ('RMB',pBookNum,'RmbSpcMov',cOff)
end;

function TKey.ReadRmbItmFrm(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString ('RMB',pBookNum,'RmbItmFrm','0'));
end;

procedure TKey.WriteRmbItmFrm(pBookNum:Str5;pValue:byte);
begin
  WriteString ('RMB',pBookNum,'RmbItmFrm',StrInt(pValue,0))
end;

// *********************************** PKB *************************************
function TKey.ReadPkbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PKB',pBookNum,'PkbStkNum','1'));
end;

procedure TKey.WritePkbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('PKB',pBookNum,'PkbStkNum',StrInt(pValue,0))
end;

function TKey.ReadPkbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PKB',pBookNum,'PkbPlsNum','1'));
end;

procedure TKey.WritePkbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('PKB',pBookNum,'PkbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadPkbSrcSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PKB',pBookNum,'PkbSrcSmc','13')); //53
end;

procedure TKey.WritePkbSrcSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('PKB',pBookNum,'PkbSrcSmc',StrInt(pValue,0))
end;

function TKey.ReadPkbTrgSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PKB',pBookNum,'PkbTrgSmc','23'));  //52
end;

procedure TKey.WritePkbTrgSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('PKB',pBookNum,'PkbTrgSmc',StrInt(pValue,0))
end;

// ********************************** TSB **************************************
function TKey.ReadTsbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('TSB',pBookNum,'TsbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteTsbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('TSB',pBookNum,'TsbBoYear',pValue)
end;

function TKey.ReadTsbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbWriNum','1'));
end;

procedure TKey.WriteTsbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TSB',pBookNum,'TsbWriNum',StrInt(pValue,0))
end;

function TKey.ReadTsbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbStkNum','1'));
end;

procedure TKey.WriteTsbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TSB',pBookNum,'TsbStkNum',StrInt(pValue,0))
end;

function TKey.ReadTsbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbPlsNum','1'));
end;

procedure TKey.WriteTsbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TSB',pBookNum,'TsbPlsNum',StrInt(pValue,0))
end;

function TKey.ReadTsbTsdRcv(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbTsdRcv','0'));
end;

procedure TKey.WriteTsbTsdRcv(pBookNum:Str5;pValue:word);
begin
  WriteString ('TSB',pBookNum,'TsbTsdRcv',StrInt(pValue,0))
end;

function TKey.ReadTsbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('TSB',pBookNum,'TsbDvName','');
end;

procedure TKey.WriteTsbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('TSB',pBookNum,'TsbDvName',pValue)
end;

function TKey.ReadTsbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbPabNum','0'));
end;

procedure TKey.WriteTsbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TSB',pBookNum,'TsbPabNum',StrInt(pValue,0))
end;

function TKey.ReadTsbDefPac(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbDefPac','0'));
end;

procedure TKey.WriteTsbDefPac(pBookNum:Str5;pValue:longint);
begin
  WriteString ('TSB',pBookNum,'TsbDefPac',StrInt(pValue,0))
end;

function TKey.ReadTsbSmCode(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbSmCode','0'));
end;

procedure TKey.WriteTsbSmCode(pBookNum:Str5;pValue:word);
begin
  WriteString ('TSB',pBookNum,'TsbSmCode',StrInt(pValue,0))
end;

function TKey.ReadTsbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbAutAcc',cOn)=cOn;
end;

procedure TKey.WriteTsbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbAutAcc',cOn)
    else WriteString ('TSB',pBookNum,'TsbAutAcc',cOff)
end;

function TKey.ReadTsbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbOnlSub',cOn)=cOn;
end;

procedure TKey.WriteTsbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbOnlSub',cOn)
    else WriteString ('TSB',pBookNum,'TsbOnlSub',cOff)
end;

function TKey.ReadTsbBcsVer(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbBcsVer',cOn)=cOn;
end;

procedure TKey.WriteTsbBcsVer(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbBcsVer',cOn)
    else WriteString ('TSB',pBookNum,'TsbBcsVer',cOff)
end;

function TKey.ReadTsbRevClc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbRevClc',cOn)=cOn;
end;

procedure TKey.WriteTsbRevClc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbRevClc',cOn)
    else WriteString ('TSB',pBookNum,'TsbRevClc',cOff)
end;

function TKey.ReadTsbTcdGen(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbTcdGen',cOn)=cOn;
end;

procedure TKey.WriteTsbTcdGen(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbTcdGen',cOn)
    else WriteString ('TSB',pBookNum,'TsbTcdGen',cOff)
end;

function TKey.ReadTsbIcdGen(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbIcdGen',cOn)=cOn;
end;

procedure TKey.WriteTsbIcdGen(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbIcdGen',cOn)
    else WriteString ('TSB',pBookNum,'TsbIcdGen',cOff)
end;

function TKey.ReadTsbIsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TSB',pBookNum,'TsbIsbNum','');
end;

procedure TKey.WriteTsbIsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TSB',pBookNum,'TsbIsbNum',pValue)
end;

function TKey.ReadTsbAgnTcb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TSB',pBookNum,'TsbAgnTcb','');
end;

procedure TKey.WriteTsbAgnTcb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TSB',pBookNum,'TsbAgnTcb',pValue)
end;

function TKey.ReadTsbAgnIcb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TSB',pBookNum,'TsbAgnIcb','');
end;

procedure TKey.WriteTsbAgnIcb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TSB',pBookNum,'TsbAgnIcb',pValue)
end;

function TKey.ReadTsbAgnPac(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('TSB',pBookNum,'TsbAgnPac','0'));
end;

procedure TKey.WriteTsbAgnPac(pBookNum:Str5;pValue:longint);
begin
  WriteString ('TSB',pBookNum,'TsbAgnPac',StrInt(pValue,0))
end;

function TKey.ReadTsbAgnPrf(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('TSB',pBookNum,'TsbAgnPrf','10'));
end;

procedure TKey.WriteTsbAgnPrf(pBookNum:Str5;pValue:double);
begin
  WriteString ('TSB',pBookNum,'TsbAgnPrf',StrDoub(pValue,0,2));
end;

function TKey.ReadTsbAutPkb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TSB',pBookNum,'TsbAutPkb','');
end;

procedure TKey.WriteTsbAutPkb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TSB',pBookNum,'TsbAutPkb',pValue)
end;

function TKey.ReadTsbAcqGsc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbAcqGsc',cOff)=cOn;
end;

procedure TKey.WriteTsbAcqGsc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbAcqGsc',cOn)
    else WriteString ('TSB',pBookNum,'TsbAcqGsc',cOff)
end;

function TKey.ReadTsbPlsMod(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TSB',pBookNum,'TsbPlsMod',cOn)=cOn;
end;

procedure TKey.WriteTsbPlsMod(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TSB',pBookNum,'TsbPlsMod',cOn)
    else WriteString ('TSB',pBookNum,'TsbPlsMod',cOff)
end;

function TKey.ReadTsbPrnCls(pBookNum:Str5):boolean;
begin
  Result:=ReadString ('TSB',pBookNum,'TsbPrnCls',cOff)=cOn;
end;

procedure TKey.WriteTsbPrnCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString('TSB',pBookNum,'TsbPrnCls',cOn)
    else WriteString('TSB',pBookNum,'TsbPrnCls',cOff)
end;

function TKey.ReadTsbPckMgc:Str60;
begin
  Result := ReadString ('TSB','','TsbPckMgc','');
end;

procedure TKey.WriteTsbPckMgc(pValue:Str60);
begin
  WriteString ('TSB','','TsbPckMgc',pValue)
end;

// ********************************** PSB **************************************
function TKey.ReadPsbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('PSB',pBookNum,'PsbBoYear',gvSys.ActYear);
end;

procedure TKey.WritePsbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('PSB',pBookNum,'PsbBoYear',pValue)
end;

function TKey.ReadPsbExnFrm(pBookNum:Str5):Str20;
begin
  Result := ReadString('PSB',pBookNum,'PsbExnFrm','yynnnnn');
end;

procedure TKey.WritePsbExnFrm(pBookNum:Str5;pValue:Str20);
begin
  WriteString ('PSB',pBookNum,'PsbExnFrm',pValue)
end;

function TKey.ReadPsbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PSB',pBookNum,'PsbStkNum','1'));
end;

procedure TKey.WritePsbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('PSB',pBookNum,'PsbStkNum',StrInt(pValue,0))
end;

function TKey.ReadPsbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PSB',pBookNum,'PsbWriNum','1'));
end;

procedure TKey.WritePsbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('PSB',pBookNum,'PsbWriNum',StrInt(pValue,0))
end;

function TKey.ReadPsbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('PSB',pBookNum,'PsbDvName','');
end;

procedure TKey.WritePsbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('PSB',pBookNum,'PsbDvName',pValue)
end;

function TKey.ReadPsbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('PSB',pBookNum,'PsbPabNum','0'));
end;

procedure TKey.WritePsbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('PSB',pBookNum,'PsbPabNum',StrInt(pValue,0))
end;

function TKey.ReadPsbOsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('PSB',pBookNum,'PsbOsbNum','');
end;

procedure TKey.WritePsbOsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('PSB',pBookNum,'PsbOsbNum',pValue)
end;

function TKey.ReadPsbClcTyp(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString ('PSB',pBookNum,'PsbClcTyp','0'));
end;

procedure TKey.WritePsbClcTyp(pBookNum:Str5;pValue:byte);
begin
  WriteString ('PSB',pBookNum,'PsbClcTyp',IntToStr(pValue));
end;

// ********************************** ALB **************************************
function TKey.ReadAlbExnFrm(pBookNum:Str5):Str12;
begin
  Result := ReadString ('ALB',pBookNum,'AlbExnFrm','bbbbbnnnnn');
end;

procedure TKey.WriteAlbExnFrm(pBookNum:Str5;pValue:Str12);
begin
  WriteString ('ALB',pBookNum,'AlbExnFrm',pValue)
end;

function TKey.ReadAlbSurPrc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('ALB',pBookNum,'AlbSurPrc','0'));
end;

procedure TKey.WriteAlbSurPrc(pBookNum:Str5;pValue:double);
begin
  WriteString ('ALB',pBookNum,'AlbSurPrc',StrDoub(pValue,0,2));
end;

function TKey.ReadAlbPenPrc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('ALB',pBookNum,'AlbPenPrc','0'));
end;

procedure TKey.WriteAlbPenPrc(pBookNum:Str5;pValue:double);
begin
  WriteString ('ALB',pBookNum,'AlbPenPrc',StrDoub(pValue,0,2));
end;

function TKey.ReadAlbRdiPrc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('ALB',pBookNum,'AlbRdiPrc','0'));
end;

procedure TKey.WriteAlbRdiPrc(pBookNum:Str5;pValue:double);
begin
  WriteString ('ALB',pBookNum,'AlbRdiPrc',StrDoub(pValue,0,2));
end;

function TKey.ReadAlbRduPrc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('ALB',pBookNum,'AlbRduPrc','0'));
end;

procedure TKey.WriteAlbRduPrc(pBookNum:Str5;pValue:double);
begin
  WriteString ('ALB',pBookNum,'AlbRduPrc',StrDoub(pValue,0,2));
end;

function TKey.ReadAlbCsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ALB',pBookNum,'AlbCsbNum','');
end;

procedure TKey.WriteAlbCsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ALB',pBookNum,'AlbCsbNum',pValue);
end;

function TKey.ReadAlbCsoInc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbCsoInc','0'));
end;

procedure TKey.WriteAlbCsoInc(pBookNum:Str5;pValue:word);
begin
  WriteString ('ALB',pBookNum,'AlbCsoInc',StrInt(pValue,0));
end;

function TKey.ReadAlbCsoExp(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbCsoExp','0'));
end;

procedure TKey.WriteAlbCsoExp(pBookNum:Str5;pValue:word);
begin
  WriteString ('ALB',pBookNum,'AlbCsoExp',StrInt(pValue,0));
end;

function TKey.ReadAlbTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ALB',pBookNum,'AlbTcbNum','');
end;

procedure TKey.WriteAlbTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ALB',pBookNum,'AlbTcbNum',pValue);
end;

function TKey.ReadAlbIcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ALB',pBookNum,'AlbIcbNum','');
end;

procedure TKey.WriteAlbIcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ALB',pBookNum,'AlbIcbNum',pValue);
end;

function TKey.ReadAlbRdiGsc(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbRdiGsc','0'));
end;

procedure TKey.WriteAlbRdiGsc(pBookNum:Str5;pValue:longint);
begin
  WriteString ('ALB',pBookNum,'AlbRdiGsc',StrInt(pValue,0));
end;

function TKey.ReadAlbRduGsc(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbRduGsc','0'));
end;

procedure TKey.WriteAlbRduGsc(pBookNum:Str5;pValue:longint);
begin
  WriteString ('ALB',pBookNum,'AlbRduGsc',StrInt(pValue,0));
end;

function TKey.ReadAlbRndBva(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ALB',pBookNum,'AlbRndBva',cOn)=cOn;
end;

procedure TKey.WriteAlbRndBva(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ALB',pBookNum,'AlbRndBva',cOn)
    else WriteString ('ALB',pBookNum,'AlbRndBva',cOff)
end;

function TKey.ReadAlbAgpFrc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ALB',pBookNum,'AlbAgpFrc','3'));
end;

procedure TKey.WriteAlbAgpFrc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ALB',pBookNum,'AlbAgpFrc',StrInt(pValue,0));
end;

function TKey.ReadAlbAgvFrc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ALB',pBookNum,'AlbAgvFrc','2'));
end;

procedure TKey.WriteAlbAgvFrc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ALB',pBookNum,'AlbAgvFrc',StrInt(pValue,0));
end;

function TKey.ReadAlbAspFrc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ALB',pBookNum,'AlbAspFrc','3'));
end;

procedure TKey.WriteAlbAspFrc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ALB',pBookNum,'AlbAspFrc',StrInt(pValue,0));
end;

function TKey.ReadAlbAsvFrc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ALB',pBookNum,'AlbAsvFrc','3'));
end;

procedure TKey.WriteAlbAsvFrc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ALB',pBookNum,'AlbAsvFrc',StrInt(pValue,0));
end;

function TKey.ReadAlbLasNit(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ALB',pBookNum,'AlbLasNit',cOn)=cOn;
end;

procedure TKey.WriteAlbLasNit(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ALB',pBookNum,'AlbLasNit',cOn)
    else WriteString ('ALB',pBookNum,'AlbLasNit',cOff)
end;

function TKey.ReadAlbExpDay(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbExpDay','15'));
end;

procedure TKey.WriteAlbExpDay(pBookNum:Str5;pValue:word);
begin
  WriteString ('ALB',pBookNum,'AlbExpDay',StrInt(pValue,0));
end;

function TKey.ReadAlbStkNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbStkNum','1'));
end;

procedure TKey.WriteAlbStkNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('ALB',pBookNum,'AlbStkNum',StrInt(pValue,0));
end;

function TKey.ReadAlbIcdSum(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ALB',pBookNum,'AlbIcdSum',cOn)=cOn;
end;

procedure TKey.WriteAlbIcdSum(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ALB',pBookNum,'AlbIcdSum',cOn)
    else WriteString ('ALB',pBookNum,'AlbIcdSum',cOff)
end;

function TKey.ReadAlbRenGsc(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbRenGsc','0'));
end;

procedure TKey.WriteAlbRenGsc(pBookNum:Str5;pValue:longint);
begin
  WriteString ('ALB',pBookNum,'AlbRenGsc',StrInt(pValue,0));
end;

function TKey.ReadAlbRdnGsc(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbRdnGsc','0'));
end;

procedure TKey.WriteAlbRdnGsc(pBookNum:Str5;pValue:longint);
begin
  WriteString ('ALB',pBookNum,'AlbRdnGsc',StrInt(pValue,0));
end;

function TKey.ReadAlbNorGsc(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString ('ALB',pBookNum,'AlbNorGsc','0'));
end;

procedure TKey.WriteAlbNorGsc(pBookNum:Str5;pValue:longint);
begin
  WriteString ('ALB',pBookNum,'AlbNorGsc',StrInt(pValue,0));
end;

function TKey.ReadAlbCasNum(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ALB',pBookNum,'AlbCasNum','0'));
end;

procedure TKey.WriteAlbCasNum(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ALB',pBookNum,'AlbCasNum',StrInt(pValue,0));
end;

// ********************************** TIB *************************************
function TKey.ReadTibImbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TIB',pBookNum,'TibImbNum','');
end;

procedure TKey.WriteTibImbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TIB',pBookNum,'TibImbNum',pValue)
end;

function TKey.ReadTibTsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TIB',pBookNum,'TibTsbNum','');
end;

procedure TKey.WriteTibTsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TIB',pBookNum,'TibTsbNum',pValue)
end;

function TKey.ReadTibOsbLst(pBookNum:Str5):Str200;
begin
  Result := ReadString ('TIB',pBookNum,'TibOsbLst','');
end;

procedure TKey.WriteTibOsbLst(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('TIB',pBookNum,'TibOsbLst',pValue)
end;

function TKey.ReadTibOcbLst(pBookNum:Str5):Str200;
begin
  Result := ReadString ('TIB',pBookNum,'TibOcbLst','');
end;

procedure TKey.WriteTibOcbLst(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('TIB',pBookNum,'TibOcbLst',pValue)
end;

function TKey.ReadTibWrmAut(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TIB',pBookNum,'TibWrmAut',cOff)=cOn;
end;

procedure TKey.WriteTibWrmAut(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TIB',pBookNum,'TibWrmAut',cOn)
    else WriteString ('TIB',pBookNum,'TibWrmAut',cOff)
end;

function TKey.ReadTibOsiPce(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TIB',pBookNum,'TibOsiPce',cOff)=cOn;
end;

procedure TKey.WriteTibOsiPce(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TIB',pBookNum,'TibOsiPce',cOn)
    else WriteString ('TIB',pBookNum,'TibOsiPce',cOff)
end;


// ********************************** TOB *************************************

function TKey.ReadTobSerNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('TOB',pBookNum,'TobSerNum','0'));
end;

procedure TKey.WriteTobSerNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('TOB',pBookNum,'TobSerNum',StrInt(pValue,0));
end;

function TKey.ReadTobSndFms(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TOB',pBookNum,'TobSndFms',cOff)=cOn;
end;

procedure TKey.WriteTobSndFms(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TOB',pBookNum,'TobSndFms',cOn)
    else WriteString ('TOB',pBookNum,'TobSndFms',cOff)
end;

function TKey.ReadTobTrmSer(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TOB',pBookNum,'TobTrmSer',cOn)=cOn;
end;

procedure TKey.WriteTobTrmSer(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TOB',pBookNum,'TobTrmSer',cOn)
    else WriteString ('TOB',pBookNum,'TobTrmSer',cOff)
end;

function TKey.ReadTobSadGen(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString ('TOB',pBookNum,'TobSadGen','0'));
end;

procedure TKey.WriteTobSadGen(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TOB',pBookNum,'TobSadGen',StrInt(pValue,0))
end;

function TKey.ReadTobTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TOB',pBookNum,'TobTcbNum','');
end;

procedure TKey.WriteTobTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TOB',pBookNum,'TobTcbNum',pValue)
end;

function TKey.ReadTobTcsNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TOB',pBookNum,'TobTcsNum','');
end;

procedure TKey.WriteTobTcsNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TOB',pBookNum,'TobTcsNum',pValue)
end;

function TKey.ReadTobIcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TOB',pBookNum,'TobIcbNum','');
end;

procedure TKey.WriteTobIcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TOB',pBookNum,'TobIcbNum',pValue)
end;

function TKey.ReadTobOmbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TOB',pBookNum,'TobOmbNum','');
end;

procedure TKey.WriteTobOmbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TOB',pBookNum,'TobOmbNum',pValue)
end;

function TKey.ReadTobOcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TOB',pBookNum,'TobOcbNum','');
end;

procedure TKey.WriteTobOcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TOB',pBookNum,'TobOcbNum',pValue)
end;

function TKey.ReadTobCasNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TOB',pBookNum,'TobCasNum','0'));
end;

procedure TKey.WriteTobCasNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TOB',pBookNum,'TobCasNum',StrInt(pValue,0));
end;

function TKey.ReadTobWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TOB',pBookNum,'TobWriNum','1'));
end;

procedure TKey.WriteTobWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TOB',pBookNum,'TobWriNum',StrInt(pValue,0));
end;

function TKey.ReadTobStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TOB',pBookNum,'TobStkNum','1'));
end;

procedure TKey.WriteTobStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TOB',pBookNum,'TobStkNum',StrInt(pValue,0));
end;

function TKey.ReadTobIcbVer(pBookNum:Str5):Str200;
begin
  Result := ReadString('TOB',pBookNum,'TobIcbVer','');
end;

procedure TKey.WriteTobIcbVer(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('TOB',pBookNum,'TobIcbVer',pValue);
end;

function TKey.ReadTobOcuBok(pBookNum:Str5):Str200;
begin
  Result := ReadString('TOB',pBookNum,'TobOcuBok','');
end;

procedure TKey.WriteTobOcuBok(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('TOB',pBookNum,'TobOcuBok',pValue);
end;

// ********************************** Pob *************************************

function TKey.ReadPobSerNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('POB',pBookNum,'PobSerNum','0'));
end;

procedure TKey.WritePobSerNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('POB',pBookNum,'PobSerNum',StrInt(pValue,0));
end;

function TKey.ReadPobSndFms(pBookNum:Str5):boolean;
begin
  Result := ReadString ('POB',pBookNum,'PobSndFms',cOff)=cOn;
end;

procedure TKey.WritePobSndFms(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('POB',pBookNum,'PobSndFms',cOn)
    else WriteString ('POB',pBookNum,'PobSndFms',cOff)
end;

function TKey.ReadPobSadGen(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString ('POB',pBookNum,'PobSadGen','0'));
end;

procedure TKey.WritePobSadGen(pBookNum:Str5;pValue:byte);
begin
  WriteString ('POB',pBookNum,'PobSadGen',StrInt(pValue,0))
end;

function TKey.ReadPobTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('POB',pBookNum,'PobTcbNum','');
end;

procedure TKey.WritePobTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('POB',pBookNum,'PobTcbNum',pValue)
end;

function TKey.ReadPobIcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('POB',pBookNum,'PobIcbNum','');
end;

procedure TKey.WritePobIcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('POB',pBookNum,'PobIcbNum',pValue)
end;

function TKey.ReadPobCasNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('POB',pBookNum,'PobCasNum','0'));
end;

procedure TKey.WritePobCasNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('POB',pBookNum,'PobCasNum',StrInt(pValue,0));
end;

function TKey.ReadPobWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('POB',pBookNum,'PobWriNum','1'));
end;

procedure TKey.WritePobWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('POB',pBookNum,'PobWriNum',StrInt(pValue,0));
end;

function TKey.ReadPobStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('POB',pBookNum,'PobStkNum','1'));
end;

procedure TKey.WritePobStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('POB',pBookNum,'PobStkNum',StrInt(pValue,0));
end;

function TKey.ReadPobIcbVer(pBookNum:Str5):Str200;
begin
  Result := ReadString('POB',pBookNum,'PobIcbVer','');
end;

procedure TKey.WritePobIcbVer(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('POB',pBookNum,'PobIcbVer',pValue);
end;

function TKey.ReadPobOcuBok(pBookNum:Str5):Str200;
begin
  Result := ReadString('POB',pBookNum,'PobOcuBok','');
end;

procedure TKey.WritePobOcuBok(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('POB',pBookNum,'PobOcuBok',pValue);
end;

// ********************************** SCB *************************************

function TKey.ReadScbCarEdi(pBookNum:Str5):boolean;
begin
  Result := ReadString('SCB',pBookNum,'ScbCarEdi',cOff)=cOn;
end;

procedure TKey.WriteScbCarEdi(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('SCB',pBookNum,'ScbCarEdi',cOn)
    else WriteString ('SCB',pBookNum,'ScbCarEdi',cOff);
end;

function TKey.ReadScbPlsNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'ScbPlsNum','1'));
end;

procedure TKey.WriteScbPlsNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('SCB',pBookNum,'ScbPlsNum',StrInt(pValue,0));
end;

function TKey.ReadSciPlsNum(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'SciPlsNum','1'));
end;

procedure TKey.WriteSciPlsNum(pBookNum:Str5;pValue:longint);
begin
  WriteString ('SCB',pBookNum,'SciPlsNum',StrInt(pValue,0));
end;

function TKey.ReadScbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'ScbWriNum','1'));
end;

procedure TKey.WriteScbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('SCB',pBookNum,'ScbWriNum',StrInt(pValue,0));
end;

function TKey.ReadScbImdStk(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'ScbImdStk','1'));
end;

procedure TKey.WriteScbImdStk(pBookNum:Str5;pValue:word);
begin
  WriteString ('SCB',pBookNum,'ScbImdStk',StrInt(pValue,0));
end;

function TKey.ReadScbOmdStk(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'ScbOmdStk','1'));
end;

procedure TKey.WriteScbOmdStk(pBookNum:Str5;pValue:word);
begin
  WriteString ('SCB',pBookNum,'ScbOmdStk',StrInt(pValue,0));
end;

function TKey.ReadScbImdSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'ScbImdSmc','100'));
end;

procedure TKey.WriteScbImdSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('SCB',pBookNum,'ScbImdSmc',StrInt(pValue,0));
end;

function TKey.ReadScbOmdSmc(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SCB',pBookNum,'ScbOmdSmc','200'));
end;

procedure TKey.WriteScbOmdSmc(pBookNum:Str5;pValue:word);
begin
  WriteString ('SCB',pBookNum,'ScbOmdSmc',StrInt(pValue,0));
end;

function TKey.ReadScbImbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SCB',pBookNum,'ScbImbNum','');
end;

procedure TKey.WriteScbImbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SCB',pBookNum,'ScbImbNum',pValue)
end;

function TKey.ReadScbOmbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SCB',pBookNum,'ScbOmbNum','');
end;

procedure TKey.WriteScbOmbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SCB',pBookNum,'ScbOmbNum',pValue)
end;

function TKey.ReadScbTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SCB',pBookNum,'ScbTcbNum','');
end;

procedure TKey.WriteScbTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SCB',pBookNum,'ScbTcbNum',pValue)
end;

function TKey.ReadScbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('SCB',pBookNum,'ScbDvName','');
end;

procedure TKey.WriteScbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('SCB',pBookNum,'ScbDvName',pValue);
end;

function TKey.ReadScbExnFmt(pBookNum:Str5):Str12;
begin
  Result := ReadString ('SCB',pBookNum,'ScbExnFmt','');
end;

procedure TKey.WriteScbExnFmt(pBookNum:Str5;pValue:Str12);
begin
  WriteString ('SCB',pBookNum,'ScbExnFmt',pValue)
end;

function TKey.ReadScbReqPro(pBookNum:Str5):boolean;
begin
  Result:=ReadString('SCB',pBookNum,'ScbReqPro',cOn)=cOn;
end;

procedure TKey.WriteScbReqPro(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString('SCB',pBookNum,'ScbReqPro',cOn)
    else WriteString('SCB',pBookNum,'ScbReqPro',cOff);
end;

// ********************************** SPE *************************************

function TKey.ReadSpeMcbNum:Str5;
begin
  Result := ReadString ('SPE','','SpeMcbNum','');
end;

procedure TKey.WriteSpeMcbNum(pValue:Str5);
begin
  WriteString ('SPE','','SpeMcbNum',pValue);
end;

// ********************************** MCB *************************************

function TKey.ReadMcbFgvDvz(pBookNum:Str5):Str3;
begin
  Result := ReadString ('MCB',pBookNum,'McbFgvDvz','EUR');
end;

procedure TKey.WriteMcbFgvDvz(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('MCB',pBookNum,'McbFgvDvz',pValue)
end;

function TKey.ReadMcbItmFrm(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString ('MCB',pBookNum,'McbItmFrm','0'));
end;

procedure TKey.WriteMcbItmFrm(pBookNum:Str5;pValue:byte);
begin
  WriteString ('MCB',pBookNum,'McbItmFrm',StrInt(pValue,0))
end;

function TKey.ReadMcbPrfPrc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('MCB',pBookNum,'McbPrfPrc','0'));
end;

procedure TKey.WriteMcbPrfPrc(pBookNum:Str5;pValue:double);
begin
  WriteString ('MCB',pBookNum,'McbPrfPrc',StrDoub(pValue,0,4))
end;

function TKey.ReadMcbExnFmt(pBookNum:Str5):Str12;
begin
  Result := ReadString ('MCB',pBookNum,'McbExnFmt','');
end;

procedure TKey.WriteMcbExnFmt(pBookNum:Str5;pValue:Str12);
begin
  WriteString ('MCB',pBookNum,'McbExnFmt',pValue)
end;

function TKey.ReadMcbPrnCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('MOB',pBookNum,'McbPrnCls',cOff)=cOn;
end;

procedure TKey.WriteMcbPrnCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('MOB',pBookNum,'McbPrnCls',cOn)
    else WriteString ('MOB',pBookNum,'McbPrnCls',cOff)
end;

function TKey.ReadMcbPrjMcd(pBookNum:Str5):boolean;
begin
  Result := ReadString ('MOB',pBookNum,'McbPrjMcd',cOff)=cOn;
end;

procedure TKey.WriteMcbPrjMcd(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('MOB',pBookNum,'McbPrjMcd',cOn)
    else WriteString ('MOB',pBookNum,'McbPrjMcd',cOff)
end;

function TKey.ReadMcbDsHide(pBookNum:Str5):boolean;
begin
  Result := ReadString ('MOB',pBookNum,'McbDsHide',cOff)=cOn;
end;

procedure TKey.WriteMcbDsHide(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('MOB',pBookNum,'McbDsHide',cOn)
    else WriteString ('MOB',pBookNum,'McbDsHide',cOff)
end;

function TKey.ReadMcbRndBva(pBookNum:Str5):boolean;
begin
  Result := ReadString ('MOB',pBookNum,'McbRndBva',cOn)=cOn;
end;

procedure TKey.WriteMcbRndBva(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('MOB',pBookNum,'McbRndBva',cOn)
    else WriteString ('MOB',pBookNum,'McbRndBva',cOff)
end;

function TKey.ReadMcbShwPal(pBookNum:Str5):boolean;
begin
  Result := ReadString ('MCB',pBookNum,'ShwPal',cOff)=cOn;
end;

procedure TKey.WriteMcbShwPal(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('MCB',pBookNum,'ShwPal',cOn)
    else WriteString ('MCB',pBookNum,'ShwPal',cOff)
end;

function TKey.ReadMcbVatRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('MCB',pBookNum,'McbVatRnd','0'));
end;

procedure TKey.WriteMcbVatRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('MCB',pBookNum,'McbVatRnd',StrInt(pValue,0));
end;

function TKey.ReadMcbDocRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('MCB',pBookNum,'McbDocRnd','0'));
end;

procedure TKey.WriteMcbDocRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('MCB',pBookNum,'McbDocRnd',StrInt(pValue,0));
end;

function TKey.ReadMcbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('MCB',pBookNum,'McbWriNum','1'));
end;

procedure TKey.WriteMcbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('MCB',pBookNum,'McbWriNum',StrInt(pValue,0));
end;

function TKey.ReadMcbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('MCB',pBookNum,'McbStkNum','1'));
end;

procedure TKey.WriteMcbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('MCB',pBookNum,'McbStkNum',StrInt(pValue,0));
end;

function TKey.ReadMcbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('MCB',pBookNum,'McbPabNum','0'));
end;

procedure TKey.WriteMcbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString    ('MCB',pBookNum,'McbPabNum',StrInt(pValue,0));
end;

function TKey.ReadMcbOcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('MCB',pBookNum,'McbOcbNum','');
end;

procedure TKey.WriteMcbOcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('MCB',pBookNum,'McbOcbNum',pValue);
end;

function TKey.ReadMcbTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('MCB',pBookNum,'McbTcbNum','');
end;

procedure TKey.WriteMcbTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('MCB',pBookNum,'McbTcbNum',pValue);
end;

function TKey.ReadMcbIcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('MCB',pBookNum,'McbIcbNum','');
end;

procedure TKey.WriteMcbIcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('MCB',pBookNum,'McbIcbNum',pValue);
end;

function TKey.ReadMcbCdbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('MCB',pBookNum,'McbCdbNum','');
end;

procedure TKey.WriteMcbCdbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('MCB',pBookNum,'McbCdbNum',pValue);
end;

function TKey.ReadMcbOciDiv(pBookNum:Str5):Byte;
var mV:Str3;
begin
  mV:=ReadString ('MCB',pBookNum,'McbOciDiv','0');
  If mV=cOff then Result:=0 else If mV=cOn then Result:=1
  else Result := ValInt(ReadString ('MCB',pBookNum,'McbOciDiv',''));
end;

procedure TKey.WriteMcbOciDiv(pBookNum:Str5;pValue:Byte);
begin
  WriteString ('MCB',pBookNum,'McbOciDiv',IntToStr(pValue));
end;

function TKey.ReadMcbDocSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('MCB',pBookNum,'McbDocSnt','311');
end;

procedure TKey.WriteMcbDocSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('MCB',pBookNum,'McbDocSnt',pValue);
end;

function TKey.ReadMcbDocAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('MCB',pBookNum,'McbDocAnl','pppppp');
end;

procedure TKey.WriteMcbDocAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('MCB',pBookNum,'McbDocAnl',pValue);
end;

function TKey.ReadMcbExpDay(pBookNum:Str5):word;
begin
  Result:=ValInt(ReadString('MCB',pBookNum,'ExpDay','15'));
end;

procedure TKey.WriteMcbExpDay(pBookNum:Str5;pValue:word);
begin
  WriteString('MCB',pBookNum,'ExpDay',StrInt(pValue,0));
end;

// ********************************** OCB *************************************

function TKey.ReadOcbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteOcbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('OCB',pBookNum,'OcbBoYear',pValue);
end;

function TKey.ReadOcbExnFrm(pBookNum:Str5):Str12;
begin
  Result := ReadString ('OCB',pBookNum,'OcbExnFrm','bbbbbnnnnn');
end;

procedure TKey.WriteOcbExnFrm(pBookNum:Str5;pValue:Str12);
begin
  WriteString ('OCB',pBookNum,'OcbExnFrm',pValue);
end;

function TKey.ReadOcbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('OCB',pBookNum,'OcbDvName','');
end;

procedure TKey.WriteOcbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('OCB',pBookNum,'OcbDvName',pValue);
end;

function TKey.ReadOcbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbWriNum','1'));
end;

procedure TKey.WriteOcbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbWriNum',StrInt(pValue,0));
end;

function TKey.ReadOcbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbStkNum','1'));
end;

procedure TKey.WriteOcbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbStkNum',StrInt(pValue,0));
end;

function TKey.ReadOcbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbPlsNum','1'));
end;

procedure TKey.WriteOcbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbPlsNum',StrInt(pValue,0));
end;

function TKey.ReadOcbCasNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbCasNum','1'));
end;

procedure TKey.WriteOcbCasNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbCasNum',StrInt(pValue,0));
end;

function TKey.ReadOcbAvtRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbAvtRnd','1'));
end;

procedure TKey.WriteOcbAvtRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('OCB',pBookNum,'OcbAvtRnd',StrInt(pValue,0));
end;

function TKey.ReadOcbAvlRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbAvlRnd','1'));
end;

procedure TKey.WriteOcbAvlRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('OCB',pBookNum,'OcbAvlRnd',StrInt(pValue,0));
end;

function TKey.ReadOcbFvtRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbFvtRnd','1'));
end;

procedure TKey.WriteOcbFvtRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('OCB',pBookNum,'OcbFvtRnd',StrInt(pValue,0));
end;

function TKey.ReadOcbFvlRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbFvlRnd','1'));
end;

procedure TKey.WriteOcbFvlRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('OCB',pBookNum,'OcbFvlRnd',StrInt(pValue,0));
end;

function TKey.ReadOcbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbPabNum','1'));
end;

procedure TKey.WriteOcbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbPabNum',StrInt(pValue,0));
end;

function TKey.ReadOcbTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbTcbNum','');
end;

procedure TKey.WriteOcbTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbTcbNum',pValue);
end;

function TKey.ReadOcbIcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbIcbNum','');
end;

procedure TKey.WriteOcbIcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbIcbNum',pValue);
end;

function TKey.ReadOcbImbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbImbNum','');
end;

procedure TKey.WriteOcbImbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbImbNum',pValue);
end;

function TKey.ReadOcbOmbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbOmbNum','');
end;

procedure TKey.WriteOcbOmbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbOmbNum',pValue);
end;

function TKey.ReadOcbRmbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbRmbNum','');
end;

procedure TKey.WriteOcbRmbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbRmbNum',pValue);
end;

function TKey.ReadOcbPcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbPcbNum','');
end;

procedure TKey.WriteOcbPcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbPcbNum',pValue);
end;

function TKey.ReadOcbCsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('OCB',pBookNum,'OcbCsbNum','');
end;

procedure TKey.WriteOcbCsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('OCB',pBookNum,'OcbCsbNum',pValue);
end;

function TKey.ReadOcbExpDay(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString ('OCB',pBookNum,'OcbExpDay','15'));
end;

procedure TKey.WriteOcbExpDay(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbExpDay',IntToStr(pValue));
end;

function TKey.ReadOcbDlvDay(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString ('OCB',pBookNum,'OcbDlvDay','15'));
end;

procedure TKey.WriteOcbDlvDay(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbDlvDay',IntToStr(pValue));
end;

function TKey.ReadOcbMdcImp(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString ('OCB',pBookNum,'OcbMdcImp','0'));
end;

procedure TKey.WriteOcbMdcImp(pBookNum:Str5;pValue:word);
begin
  WriteString ('OCB',pBookNum,'OcbMdcImp',IntToStr(pValue));
end;

function TKey.ReadOcbItmEdi(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbItmEdi','0'));
end;

procedure TKey.WriteOcbItmEdi(pBookNum:Str5;pValue:byte);
begin
  WriteString ('OCB',pBookNum,'OcbItmEdi',StrInt(pValue,0));
end;

function TKey.ReadOcbDocEdi(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('OCB',pBookNum,'OcbDocEdi','0'));
end;

procedure TKey.WriteOcbDocEdi(pBookNum:Str5;pValue:byte);
begin
  WriteString ('OCB',pBookNum,'OcbDocEdi',StrInt(pValue,0));
end;

function TKey.ReadOcbIntDoc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbIntDoc',cOff)=cOn;
end;

procedure TKey.WriteOcbIntDoc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbIntDoc',cOn)
    else WriteString ('OCB',pBookNum,'OcbIntDoc',cOff)
end;

function TKey.ReadOcbNotRes(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbNotRes',cOff)=cOn;
end;

procedure TKey.WriteOcbNotRes(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbNotRes',cOn)
    else WriteString ('OCB',pBookNum,'OcbNotRes',cOff)
end;

function TKey.ReadOcbPrnCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbPrnCls',cOff)=cOn;
end;

procedure TKey.WriteOcbPrnCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbPrnCls',cOn)
    else WriteString ('OCB',pBookNum,'OcbPrnCls',cOff)
end;

function TKey.ReadOcbDsHide(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbDsHide',cOff)=cOn;
end;

procedure TKey.WriteOcbDsHide(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbDsHide',cOn)
    else WriteString ('OCB',pBookNum,'OcbDsHide',cOff)
end;

function TKey.ReadOcbUlcRsn(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbUlcRsn',cOff)=cOn;
end;

procedure TKey.WriteOcbUlcRsn(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbUlcRsn',cOn)
    else WriteString ('OCB',pBookNum,'OcbUlcRsn',cOff)
end;

function TKey.ReadOcbItdRsn(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbItdRsn',cOff)=cOn;
end;

procedure TKey.WriteOcbItdRsn(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbItdRsn',cOn)
    else WriteString ('OCB',pBookNum,'OcbItdRsn',cOff)
end;

function TKey.ReadOcbAutSlc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbAutSlc',cOff)=cOn;
end;

procedure TKey.WriteOcbAutSlc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbAutSlc',cOn)
    else WriteString ('OCB',pBookNum,'OcbAutSlc',cOff)
end;

function TKey.ReadOcbPayVer(pBookNum:Str5):boolean;
begin
  Result := ReadString ('OCB',pBookNum,'OcbPayVer',cOff)=cOn;
end;

procedure TKey.WriteOcbPayVer(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('OCB',pBookNum,'OcbPayVer',cOn)
    else WriteString ('OCB',pBookNum,'OcbPayVer',cOff)
end;

function TKey.ReadOcbQntTrn(pBookNum:Str5):boolean;
begin
  Result:=ReadString('OCB',pBookNum,'OcbQntTrn',cOff)=cOn;
end;

procedure TKey.WriteOcbQntTrn(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString('OCB',pBookNum,'OcbQntTrn',cOn)
    else WriteString('OCB',pBookNum,'OcbQntTrn',cOff)
end;

function TKey.ReadOcbScmDis(pBookNum:Str5):boolean;
begin
  Result:=ReadString('OCB',pBookNum,'OcbScmDis',cOff)=cOn;
end;

procedure TKey.WriteOcbScmDis(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString('OCB',pBookNum,'OcbScmDis',cOn)
    else WriteString('OCB',pBookNum,'OcbScmDis',cOff)
end;

function TKey.ReadOcbBaCont(pBookNum:Str5):Str20;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaCont','');
end;

procedure TKey.WriteOcbBaCont(pBookNum:Str5;pValue:Str20);
begin
  WriteString ('OCB',pBookNum,'OcbBaCont',pValue);
end;

function TKey.ReadOcbBaName(pBookNum:Str5):Str30;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaName','');
end;

procedure TKey.WriteOcbBaName(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('OCB',pBookNum,'OcbBaName',pValue);
end;

function TKey.ReadOcbBaIban(pBookNum:Str5):Str30;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaIban','');
end;

procedure TKey.WriteOcbBaIban(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('OCB',pBookNum,'OcbBaIban',pValue);
end;

function TKey.ReadOcbBaSwft(pBookNum:Str5):Str10;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaSwft','');
end;

procedure TKey.WriteOcbBaSwft(pBookNum:Str5;pValue:Str10);
begin
  WriteString ('OCB',pBookNum,'OcbBaSwft',pValue);
end;

function TKey.ReadOcbBaAddr(pBookNum:Str5):Str30;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaAddr','');
end;

procedure TKey.WriteOcbBaAddr(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('OCB',pBookNum,'OcbBaAddr',pValue);
end;

function TKey.ReadOcbBaCity(pBookNum:Str5):Str30;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaCity','');
end;

procedure TKey.WriteOcbBaCity(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('OCB',pBookNum,'OcbBaCity',pValue);
end;

function TKey.ReadOcbBaStat(pBookNum:Str5):Str30;
begin
  Result := ReadString ('OCB',pBookNum,'OcbBaStat','');
end;

procedure TKey.WriteOcbBaStat(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('OCB',pBookNum,'OcbBaStat',pValue);
end;

// ********************************** TCB *************************************
function TKey.ReadTcbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('TCB',pBookNum,'TcbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteTcbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('TCB',pBookNum,'TcbBoYear',pValue);
end;

function TKey.ReadTcbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbWriNum','1'));
end;

procedure TKey.WriteTcbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TCB',pBookNum,'TcbWriNum',StrInt(pValue,0));
end;

function TKey.ReadTcbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbStkNum','1'));
end;

procedure TKey.WriteTcbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TCB',pBookNum,'TcbStkNum',StrInt(pValue,0));
end;

function TKey.ReadTcbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbPlsNum','1'));
end;

procedure TKey.WriteTcbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TCB',pBookNum,'TcbPlsNum',StrInt(pValue,0));
end;

function TKey.ReadTcbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('TCB',pBookNum,'TcbDvName','');
end;

procedure TKey.WriteTcbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('TCB',pBookNum,'TcbDvName',pValue);
end;

function TKey.ReadTcbExnFrm(pBookNum:Str5):Str12;
begin
  Result := ReadString ('TCB',pBookNum,'TcbExnFrm','bbbbbnnnnn');
end;

procedure TKey.WriteTcbExnFrm(pBookNum:Str5;pValue:Str12);
begin
  WriteString ('TCB',pBookNum,'TcbExnFrm',pValue);
end;

function TKey.ReadTcbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbPabNum','0'));
end;

procedure TKey.WriteTcbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('TCB',pBookNum,'TcbPabNum',StrInt(pValue,0));
end;

function TKey.ReadTcbDefPac(pBookNum:Str5):longint;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbDefPac','0'));
end;

procedure TKey.WriteTcbDefPac(pBookNum:Str5;pValue:longint);
begin
  WriteString ('TCB',pBookNum,'TcbDefPac',StrInt(pValue,0));
end;

function TKey.ReadTcbSmCode(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbSmCode','55'));
end;

procedure TKey.WriteTcbSmCode(pBookNum:Str5;pValue:word);
begin
  WriteString ('TCB',pBookNum,'TcbSmCode',StrInt(pValue,0));
end;

function TKey.ReadTcbFgCalc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbFgCalc','0'));
end;

procedure TKey.WriteTcbFgCalc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbFgCalc',StrInt(pValue,0));
end;

function TKey.ReadTcbAvtRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbAvtRnd','0'));
end;

procedure TKey.WriteTcbAvtRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbAvtRnd',StrInt(pValue,0));
end;

function TKey.ReadTcbAvlRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbAvlRnd','0'));
end;

procedure TKey.WriteTcbAvlRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbAvlRnd',StrInt(pValue,0));
end;

function TKey.ReadTcbFvtRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbFvtRnd','0'));
end;

procedure TKey.WriteTcbFvtRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbFvtRnd',StrInt(pValue,0));
end;

function TKey.ReadTcbFvlRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbFvlRnd','0'));
end;

procedure TKey.WriteTcbFvlRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbFvlRnd',StrInt(pValue,0));
end;

function TKey.ReadTcbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TCB',pBookNum,'TcbAutAcc',cOff)=cOn;
end;

procedure TKey.WriteTcbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TCB',pBookNum,'TcbAutAcc',cOn)
    else WriteString ('TCB',pBookNum,'TcbAutAcc',cOff)
end;

function TKey.ReadTcbOnlSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TCB',pBookNum,'TcbOnlSub',cOff)=cOn;
end;

procedure TKey.WriteTcbOnlSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TCB',pBookNum,'TcbOnlSub',cOn)
    else WriteString ('TCB',pBookNum,'TcbOnlSub',cOff)
end;

function TKey.ReadTcbDsHide(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TCB',pBookNum,'TcbDsHide',cOff)=cOn;
end;

procedure TKey.WriteTcbDsHide(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TCB',pBookNum,'TcbDsHide',cOn)
    else WriteString ('TCB',pBookNum,'TcbDsHide',cOff)
end;

function TKey.ReadTcbOcnVer(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TCB',pBookNum,'TcbOcnVer',cOff)=cOn;
end;

procedure TKey.WriteTcbOcnVer(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TCB',pBookNum,'TcbOcnVer',cOn)
    else WriteString ('TCB',pBookNum,'TcbOcnVer',cOff)
end;

function TKey.ReadTcbPrnCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TCB',pBookNum,'TcbPrnCls',cOff)=cOn;
end;

procedure TKey.WriteTcbPrnCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TCB',pBookNum,'TcbPrnCls',cOn)
    else WriteString ('TCB',pBookNum,'TcbPrnCls',cOff)
end;

function TKey.ReadTcbFgbMod(pBookNum:Str5):boolean;
begin
  Result := ReadString ('TCB',pBookNum,'TcbFgbMod',cOff)=cOn;
end;

procedure TKey.WriteTcbFgbMod(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('TCB',pBookNum,'TcbFgbMod',cOn)
    else WriteString ('TCB',pBookNum,'TcbFgbMod',cOff)
end;

function TKey.ReadTcbIcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TCB',pBookNum,'TcbIcbNum','');
end;

procedure TKey.WriteTcbIcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TCB',pBookNum,'TcbIcbNum',pValue);
end;

function TKey.ReadTcbMovTcb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TCB',pBookNum,'TcbMovTcb','');
end;

procedure TKey.WriteTcbMovTcb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TCB',pBookNum,'TcbMovTcb',pValue);
end;

function TKey.ReadTcbCasNum(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbCasNum','0'));
end;

procedure TKey.WriteTcbCasNum(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbCasNum',StrInt(pValue,0));
end;

function TKey.ReadTcbFmType(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('TCB',pBookNum,'TcbFmType','0'));
end;

procedure TKey.WriteTcbFmType(pBookNum:Str5;pValue:byte);
begin
  WriteString ('TCB',pBookNum,'TcbFmType',StrInt(pValue,0));
end;

function TKey.ReadTcbFmPort(pBookNum:Str5):Str4;
begin
  Result := ReadString ('TCB',pBookNum,'TcbFmPort','-');
end;

procedure TKey.WriteTcbFmPort(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('TCB',pBookNum,'TcbFmPort',pValue);
end;

function TKey.ReadTcbCpiBok(pBookNum:Str5):Str5;
begin
  Result := ReadString ('TCB',pBookNum,'TcbCpiBok','');
end;

procedure TKey.WriteTcbCpiBok(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('TCB',pBookNum,'TcbCpiBok',pValue);
end;

// *********************************** SAB *************************************

function TKey.ReadSabWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabWriNum','1'));
end;

procedure TKey.WriteSabWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabWriNum',StrInt(pValue,0));
end;

function TKey.ReadSabStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabStkNum','1'));
end;

procedure TKey.WriteSabStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabStkNum',StrInt(pValue,0));
end;

function TKey.ReadSabCenCsb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SAB',pBookNum,'SabCenCsb','');
end;

procedure TKey.WriteSabCenCsb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SAB',pBookNum,'SabCenCsb',pValue);
end;

function TKey.ReadSabEcrCsb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SAB',pBookNum,'SabEcrCsb','');
end;

procedure TKey.WriteSabEcrCsb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SAB',pBookNum,'SabEcrCsb',pValue);
end;

function TKey.ReadSabIdbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SAB',pBookNum,'SabIdbNum','');
end;

procedure TKey.WriteSabIdbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SAB',pBookNum,'SabIdbNum',pValue);
end;

function TKey.ReadSabBgsCoi(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabBgsCoi','0'));
end;

procedure TKey.WriteSabBgsCoi(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabBgsCoi',StrInt(pValue,0));
end;

function TKey.ReadSabBseCoi(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabBseCoi','0'));
end;

procedure TKey.WriteSabBseCoi(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabBseCoi',StrInt(pValue,0));
end;

function TKey.ReadSabSpiCoi(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabSpiCoi','0'));
end;

procedure TKey.WriteSabSpiCoi(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabSpiCoi',StrInt(pValue,0));
end;

function TKey.ReadSabSpeCoe(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabSpeCoe','0'));
end;

procedure TKey.WriteSabSpeCoe(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabSpeCoe',StrInt(pValue,0));
end;

function TKey.ReadSabCshCoe(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabCshCoe','0'));
end;

procedure TKey.WriteSabCshCoe(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabCshCoe',StrInt(pValue,0));
end;

function TKey.ReadSabCshCoi(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabCshCoi','0'));
end;

procedure TKey.WriteSabCshCoi(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabCshCoi',StrInt(pValue,0));
end;

function TKey.ReadSabCshCre(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabCshCre','0'));
end;

procedure TKey.WriteSabCshCre(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabCshCre',StrInt(pValue,0));
end;

function TKey.ReadSabCshCri(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabCshCri','0'));
end;

procedure TKey.WriteSabCshCri(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabCshCri',StrInt(pValue,0));
end;

function TKey.ReadSabCrdCoe(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabCrdCoe','0'));
end;

procedure TKey.WriteSabCrdCoe(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabCrdCoe',StrInt(pValue,0));
end;

function TKey.ReadSabSviCrd(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabSviCrd','0'));
end;

procedure TKey.WriteSabSviCrd(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabSviCrd',StrInt(pValue,0));
end;

function TKey.ReadSabSviDeb(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabSviDeb','0'));
end;

procedure TKey.WriteSabSviDeb(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabSviDeb',StrInt(pValue,0));
end;

function TKey.ReadSabSveCrd(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabSveCrd','0'));
end;

procedure TKey.WriteSabSveCrd(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabSveCrd',StrInt(pValue,0));
end;

function TKey.ReadSabSveDeb(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabSveDeb','0'));
end;

procedure TKey.WriteSabSveDeb(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabSveDeb',StrInt(pValue,0));
end;

function TKey.ReadSabTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SAB',pBookNum,'SabTcbNum','');
end;

procedure TKey.WriteSabTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SAB',pBookNum,'SabTcbNum',pValue);
end;

function TKey.ReadSabCpiBok(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SAB',pBookNum,'SabCpiBok','');
end;

procedure TKey.WriteSabCpiBok(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SAB',pBookNum,'SabCpiBok',pValue);
end;

function TKey.ReadSabIcpCsb(pBookNum:Str5):Str5;
begin
  Result := ReadString ('SAB',pBookNum,'SabIcpCsb','');
end;

procedure TKey.WriteSabIcpCsb(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('SAB',pBookNum,'SabIcpCsb',pValue);
end;

function TKey.ReadSabIcpCoi(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SAB',pBookNum,'SabIcpCoi','0'));
end;

procedure TKey.WriteSabIcpCoi(pBookNum:Str5;pValue:word);
begin
  WriteString ('SAB',pBookNum,'SabIcpCoi',StrInt(pValue,0));
end;

function TKey.ReadSabAccAll(pBookNum:Str5):boolean;
begin
  Result := ReadString ('SAB',pBookNum,'SabAccAll',cOff)=cOn;
end;

procedure TKey.WriteSabAccAll(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('SAB',pBookNum,'SabAccAll',cOn)
    else WriteString ('SAB',pBookNum,'SabAccAll',cOff)
end;

function TKey.ReadSabAccDcl(pBookNum:Str5):boolean;
begin
  Result := ReadString ('SAB',pBookNum,'SabAccDcl',cOff)=cOn;
end;

procedure TKey.WriteSabAccDcl(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('SAB',pBookNum,'SabAccDcl',cOn)
    else WriteString ('SAB',pBookNum,'SabAccDcl',cOff)
end;

function TKey.ReadSabStkSub(pBookNum:Str5):boolean;
begin
  Result := ReadString ('SAB',pBookNum,'SabStkSub',cOn)=cOn;
end;

procedure TKey.WriteSabStkSub(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('SAB',pBookNum,'SabStkSub',cOn)
    else WriteString ('SAB',pBookNum,'SabStkSub',cOff)
end;

function TKey.ReadSabStkDet(pBookNum:Str5):boolean;
begin
  Result := ReadString ('SAB',pBookNum,'SabStkDet',cOn)=cOn;
end;

procedure TKey.WriteSabStkDet(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('SAB',pBookNum,'SabStkDet',cOn)
    else WriteString ('SAB',pBookNum,'SabStkDet',cOff)
end;

function TKey.ReadSabCrdTrn(pBookNum:Str5):boolean;
begin
  Result := ReadString ('SAB',pBookNum,'SabCrdTrn',cOn)=cOn;
end;

procedure TKey.WriteSabCrdTrn(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('SAB',pBookNum,'SabCrdTrn',cOn)
    else WriteString ('SAB',pBookNum,'SabCrdTrn',cOff)
end;

// *********************************** RPL *************************************

function TKey.ReadRplPceBeg(pIntNum:byte;pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('RPL',pBookNum,'RplPceBeg'+StrIntZero(pIntNum,1),'0'));
end;

procedure TKey.WriteRplPceBeg(pIntNum:byte;pBookNum:Str5;pValue:double);
begin
  WriteString ('RPL',pBookNum,'RplPceBeg'+StrIntZero(pIntNum,1),StrDoub(pValue,0,4));
end;

function TKey.ReadRplPceEnd(pIntNum:byte;pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('RPL',pBookNum,'RplPceEnd'+StrIntZero(pIntNum,1),'0'));
end;

procedure TKey.WriteRplPceEnd(pIntNum:byte;pBookNum:Str5;pValue:double);
begin
  WriteString ('RPL',pBookNum,'RplPceEnd'+StrIntZero(pIntNum,1),StrDoub(pValue,0,4));
end;

function TKey.ReadRplPrfKfc(pIntNum:byte;pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('RPL',pBookNum,'RplPrfKfc'+StrIntZero(pIntNum,2),'0'));
end;

procedure TKey.WriteRplPrfKfc(pIntNum:byte;pBookNum:Str5;pValue:double);
begin
  WriteString ('RPL',pBookNum,'RplPrfKfc'+StrIntZero(pIntNum,2),StrDoub(pValue,0,4));
end;

function TKey.ReadRplExcKfc(pIntNum:byte;pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString ('RPL',pBookNum,'RplExcKfc'+StrIntZero(pIntNum,2),'0'));
end;

procedure TKey.WriteRplExcKfc(pIntNum:byte;pBookNum:Str5;pValue:double);
begin
  WriteString ('RPL',pBookNum,'RplExcKfc'+StrIntZero(pIntNum,2),StrDoub(pValue,0,4));
end;

function TKey.ReadRplImpFile(pBookNum:Str5):Str200;
begin
  Result := ReadString ('RPL',pBookNum,'RplImpFile','');
end;

procedure TKey.WriteRplImpFile(pBookNum:Str5;pValue:Str200);
begin
  WriteString ('RPL',pBookNum,'RplImpFile',pValue);
end;

// ********************************** JOB **************************************

function TKey.ReadJobOwnUsl(pBookNum:Str5):Str8;
begin
  Result := ReadString ('JOB',pBookNum,'JobOwnUsl','');
end;

procedure TKey.WriteJobOwnUsl(pBookNum:Str5;pValue:Str8);
begin
  WriteString ('JOB',pBookNum,'JobOwnUsl',pValue);
end;

function TKey.ReadJobNdoClr(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('JOB',pBookNum,'JobNdoClr','0'));
end;

procedure TKey.WriteJobNdoClr(pBookNum:Str5;pValue:integer);
begin
  WriteString ('JOB',pBookNum,'JobNdoClr',StrInt(pValue,0));
end;

function TKey.ReadJobRdoClr(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('JOB',pBookNum,'JobRdoClr','32768'));
end;

procedure TKey.WriteJobRdoClr(pBookNum:Str5;pValue:integer);
begin
  WriteString ('JOB',pBookNum,'JobRdoClr',StrInt(pValue,0));
end;

function TKey.ReadJobSdoClr(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('JOB',pBookNum,'JobSdoClr','255'));
end;

procedure TKey.WriteJobSdoClr(pBookNum:Str5;pValue:integer);
begin
  WriteString ('JOB',pBookNum,'JobSdoClr',StrInt(pValue,0));
end;

function TKey.ReadJobOdoClr(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('JOB',pBookNum,'JobOdoClr','8421504'));
end;

procedure TKey.WriteJobOdoClr(pBookNum:Str5;pValue:integer);
begin
  WriteString ('JOB',pBookNum,'JobOdoClr',StrInt(pValue,0));
end;

function TKey.ReadJobXdoClr(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('JOB',pBookNum,'JobXdoClr','128'));
end;

procedure TKey.WriteJobXdoClr(pBookNum:Str5;pValue:integer);
begin
  WriteString ('JOB',pBookNum,'JobXdoClr',StrInt(pValue,0));
end;

function TKey.ReadJobDdoClr(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('JOB',pBookNum,'JobDdoClr','16711680'));
end;

procedure TKey.WriteJobDdoClr(pBookNum:Str5;pValue:integer);
begin
  WriteString ('JOB',pBookNum,'JobDdoClr',StrInt(pValue,0));
end;

// ********************************** ISB **************************************
function TKey.ReadIsbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('ISB',pBookNum,'IsbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteIsbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('ISB',pBookNum,'IsbBoYear',pValue);
end;

function TKey.ReadIsbCoSymb(pBookNum:Str5):Str4;
begin
  Result := ReadString ('ISB',pBookNum,'IsbCoSymb','0008');
end;

procedure TKey.WriteIsbCoSymb(pBookNum:Str5;pValue:str4);
begin
  WriteString ('ISB',pBookNum,'IsbCoSymb',pValue);
end;

function TKey.ReadIsbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbDvName','Sk');
end;

procedure TKey.WriteIsbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbDvName',pValue);
end;

function TKey.ReadIsbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbWriNum','1'));
end;

procedure TKey.WriteIsbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ISB',pBookNum,'IsbWriNum',StrInt(pValue,0));
end;

function TKey.ReadIsbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbStkNum','1'));
end;

procedure TKey.WriteIsbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ISB',pBookNum,'IsbStkNum',StrInt(pValue,0));
end;

function TKey.ReadIsbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbPlsNum','1'));
end;

procedure TKey.WriteIsbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ISB',pBookNum,'IsbPlsNum',StrInt(pValue,0));
end;

function TKey.ReadIsbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbPabNum','0'));
end;

procedure TKey.WriteIsbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ISB',pBookNum,'IsbPabNum',StrInt(pValue,0));
end;

function TKey.ReadIsbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ISB',pBookNum,'IsbAutAcc',cOff)=cOn;
end;

procedure TKey.WriteIsbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ISB',pBookNum,'IsbAutAcc',cOn)
    else WriteString ('ISB',pBookNum,'IsbAutAcc',cOff)
end;

function TKey.ReadIsbSumAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ISB',pBookNum,'IsbSumAcc',cOff)=cOn;
end;

procedure TKey.WriteIsbSumAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ISB',pBookNum,'IsbSumAcc',cOn)
    else WriteString ('ISB',pBookNum,'IsbSumAcc',cOff)
end;

function TKey.ReadIsbTsdAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ISB',pBookNum,'IsbTsdAcc',cOff)=cOn;
end;

procedure TKey.WriteIsbTsdAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ISB',pBookNum,'IsbTsdAcc',cOn)
    else WriteString ('ISB',pBookNum,'IsbTsdAcc',cOff)
end;

function TKey.ReadIsbVatCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ISB',pBookNum,'IsbVatCls',cOff)=cOn;
end;

procedure TKey.WriteIsbVatCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ISB',pBookNum,'IsbVatCls',cOn)
    else WriteString ('ISB',pBookNum,'IsbVatCls',cOff)
end;

function TKey.ReadIsbNvtDoc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ISB',pBookNum,'IsbNvtDoc',cOff)=cOn;
end;

procedure TKey.WriteIsbNvtDoc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ISB',pBookNum,'IsbNvtDoc',cOn)
    else WriteString ('ISB',pBookNum,'IsbNvtDoc',cOff)
end;

function TKey.ReadIsbDocSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbDocSnt','321');
end;

procedure TKey.WriteIsbDocSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbDocSnt',pValue);
end;

function TKey.ReadIsbDocAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbDocAnl','pppppp');
end;

procedure TKey.WriteIsbDocAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbDocAnl',pValue);
end;

function TKey.ReadIsbVatSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbVatSnt','343');
end;

procedure TKey.WriteIsbVatSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbVatSnt',pValue);
end;

function TKey.ReadIsbVatAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbVatAnl','0000vv');
end;

procedure TKey.WriteIsbVatAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbVatAnl',pValue);
end;

function TKey.ReadIsbNvaSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbNvaSnt','343');
end;

procedure TKey.WriteIsbNvaSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbNvaSnt',pValue);
end;

function TKey.ReadIsbNvaAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbNvaAnl','1000vv');
end;

procedure TKey.WriteIsbNvaAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbNvaAnl',pValue);
end;

function TKey.ReadIsbGscSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbGscSnt','131');
end;

procedure TKey.WriteIsbGscSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbGscSnt',pValue);
end;

function TKey.ReadIsbGscAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbGscAnl','000100');
end;

procedure TKey.WriteIsbGscAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbGscAnl',pValue);
end;

function TKey.ReadIsbGsdSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbGsdSnt','131');
end;

procedure TKey.WriteIsbGsdSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbGsdSnt',pValue);
end;

function TKey.ReadIsbGsdAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbGsdAnl','000100');
end;

procedure TKey.WriteIsbGsdAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbGsdAnl',pValue);
end;

function TKey.ReadIsbSecSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbSecSnt','518');
end;

procedure TKey.WriteIsbSecSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbSecSnt',pValue);
end;

function TKey.ReadIsbSecAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbSecAnl','000100');
end;

procedure TKey.WriteIsbSecAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbSecAnl',pValue);
end;

function TKey.ReadIsbSedSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ISB',pBookNum,'IsbSedSnt','518');
end;

procedure TKey.WriteIsbSedSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ISB',pBookNum,'IsbSedSnt',pValue);
end;

function TKey.ReadIsbSedAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ISB',pBookNum,'IsbSedAnl','000100');
end;

procedure TKey.WriteIsbSedAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ISB',pBookNum,'IsbSedAnl',pValue);
end;

function TKey.ReadIsbTsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ISB',pBookNum,'IsbTsbNum','');
end;

procedure TKey.WriteIsbTsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ISB',pBookNum,'IsbTsbNum',pValue);
end;

function TKey.ReadIsbCsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ISB',pBookNum,'IsbCsbNum','');
end;

procedure TKey.WriteIsbCsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ISB',pBookNum,'IsbCsbNum',pValue);
end;

function TKey.ReadIsbDocSpc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbDocSpc','0'));
end;

procedure TKey.WriteIsbDocSpc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ISB',pBookNum,'IsbDocSpc',StrInt(pValue,0));
end;

function TKey.ReadIsbVtdDef(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbVtdDef','1'));
end;

procedure TKey.WriteIsbVtdDef(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ISB',pBookNum,'IsbVtdDef',StrInt(pValue,0));
end;

function TKey.ReadIsbAcdDef(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbAcdDef','1'));
end;

procedure TKey.WriteIsbAcdDef(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ISB',pBookNum,'IsbAcdDef',StrInt(pValue,0));
end;

function TKey.ReadIsbItmAcc(pBookNum:Str5):byte;
begin
  Result := Valint(ReadString ('ISB',pBookNum,'IsbItmAcc','0'));
end;

procedure TKey.WriteIsbItmAcc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ISB',pBookNum,'IsbItmAcc',StrInt(pValue,0));
end;

function TKey.ReadIsbVatRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbVatRnd','0'));
end;

procedure TKey.WriteIsbVatRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ISB',pBookNum,'IsbVatRnd',StrInt(pValue,0));
end;

function TKey.ReadIsbValRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ISB',pBookNum,'IsbValRnd','0'));
end;

procedure TKey.WriteIsbValRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ISB',pBookNum,'IsbValRnd',StrInt(pValue,0));
end;

function TKey.ReadIsbTsbInc(pBookNum:Str5):Str200;
begin
  Result:=ReadString('ISB',pBookNum,'IsbTsbInc','');
end;

procedure TKey.WriteIsbTsbInc(pBookNum:Str5;pValue:Str200);
begin
  WriteString('ISB',pBookNum,'IsbTsbInc',pValue);
end;

function TKey.ReadIsbTsbExc(pBookNum:Str5):Str200;
begin
  Result:=ReadString('ISB',pBookNum,'IsbTsbExc','');
end;

procedure TKey.WriteIsbTsbExc(pBookNum:Str5;pValue:Str200);
begin
  WriteString('ISB',pBookNum,'IsbTsbExc',pValue);
end;

// ********************************** ICB **************************************
function TKey.ReadIcbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteIcbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('ICB',pBookNum,'IcbBoYear',pValue);
end;

function TKey.ReadIcbCoSymb(pBookNum:Str5):Str4;
begin
  Result := ReadString ('ICB',pBookNum,'IcbCoSymb','0008');
end;

procedure TKey.WriteIcbCoSymb(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('ICB',pBookNum,'IcbCoSymb',pValue);
end;

function TKey.ReadIcbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbDvName','Sk');
end;

procedure TKey.WriteIcbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbDvName',pValue);
end;

function TKey.ReadIcbExnFrm(pBookNum:Str5):Str12;
begin
  Result := ReadString ('ICB',pBookNum,'IcbExnFrm','bbbbbnnnnn');
end;

procedure TKey.WriteIcbExnFrm(pBookNum:Str5;pValue:Str12);
begin
  WriteString ('ICB',pBookNum,'IcbExnFrm',pValue);
end;

function TKey.ReadIcbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbWriNum','1'));
end;

procedure TKey.WriteIcbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ICB',pBookNum,'IcbWriNum',StrInt(pValue,0));
end;

function TKey.ReadIcbStkNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbStkNum','1'));
end;

procedure TKey.WriteIcbStkNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ICB',pBookNum,'IcbStkNum',StrInt(pValue,0));
end;

function TKey.ReadIcbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbPlsNum','1'));
end;

procedure TKey.WriteIcbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ICB',pBookNum,'IcbPlsNum',StrInt(pValue,0));
end;

function TKey.ReadIcbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbPabNum','0'));
end;

procedure TKey.WriteIcbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ICB',pBookNum,'IcbPabNum',StrInt(pValue,0));
end;

function TKey.ReadIcbAvtRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbAvtRnd','0'));
end;

procedure TKey.WriteIcbAvtRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbAvtRnd',StrInt(pValue,0));
end;

function TKey.ReadIcbAvlRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbAvlRnd','0'));
end;

procedure TKey.WriteIcbAvlRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbAvlRnd',StrInt(pValue,0));
end;

function TKey.ReadIcbFvtRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbFvtRnd','0'));
end;

procedure TKey.WriteIcbFvtRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbFvtRnd',StrInt(pValue,0));
end;

function TKey.ReadIcbFvlRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbFvlRnd','0'));
end;

procedure TKey.WriteIcbFvlRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbFvlRnd',StrInt(pValue,0));
end;

function TKey.ReadIcbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbAutAcc',cOff)=cOn;
end;

procedure TKey.WriteIcbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbAutAcc',cOn)
    else WriteString ('ICB',pBookNum,'IcbAutAcc',cOff)
end;

function TKey.ReadIcbCadEnb:boolean;
begin
  Result := ReadString ('ICB','','IcbCadEnb',cOff)=cOn;
end;

procedure TKey.WriteIcbCadEnb(pValue:boolean);
begin
  If pValue
    then WriteString ('ICB','','IcbCadEnb',cOn)
    else WriteString ('ICB','','IcbCadEnb',cOff)
end;

function TKey.ReadIcbSumAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbSumAcc',cOff)=cOn;
end;

procedure TKey.WriteIcbSumAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbSumAcc',cOn)
    else WriteString ('ICB',pBookNum,'IcbSumAcc',cOff)
end;

function TKey.ReadIcbTcdAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbTcdAcc',cOff)=cOn;
end;

procedure TKey.WriteIcbTcdAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbTcdAcc',cOn)
    else WriteString ('ICB',pBookNum,'IcbTcdAcc',cOff)
end;

function TKey.ReadIcbVatCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbVatCls',cOn)=cOn;
end;

procedure TKey.WriteIcbVatCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbVatCls',cOn)
    else WriteString ('ICB',pBookNum,'IcbVatCls',cOff)
end;

function TKey.ReadIcbNvtDoc(pBookNum:Str5):boolean;
begin
  Result:=ReadString ('ICB',pBookNum,'IcbNvtDoc',cOff)=cOn;
end;

procedure TKey.WriteIcbNvtDoc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString('ICB',pBookNum,'IcbNvtDoc',cOn)
    else WriteString('ICB',pBookNum,'IcbNvtDoc',cOff)
end;

function TKey.ReadIcbOcnVer(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbOcnVer',cOff)=cOn;
end;

procedure TKey.WriteIcbOcnVer(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbOcnVer',cOn)
    else WriteString ('ICB',pBookNum,'IcbOcnVer',cOff)
end;

function TKey.ReadIcbFgbMod(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbFgbMod',cOff)=cOn;
end;

procedure TKey.WriteIcbFgbMod(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbFgbMod',cOn)
    else WriteString ('ICB',pBookNum,'IcbFgbMod',cOff)
end;

function TKey.ReadIcbPrnCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbPrnCls',cOff)=cOn;
end;

procedure TKey.WriteIcbPrnCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbPrnCls',cOn)
    else WriteString ('ICB',pBookNum,'IcbPrnCls',cOff)
end;

function TKey.ReadIcbVatClc(pBookNum:Str5):boolean;
begin
  Result := ReadString ('ICB',pBookNum,'IcbVatClc',cOff)=cOn;
end;

procedure TKey.WriteIcbVatClc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbVatClc',cOn)
    else WriteString ('ICB',pBookNum,'IcbVatClc',cOff)
end;

function TKey.ReadIcbDocSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbDocSnt','311');
end;

procedure TKey.WriteIcbDocSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbDocSnt',pValue);
end;

function TKey.ReadIcbDocAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbDocAnl','pppppp');
end;

procedure TKey.WriteIcbDocAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbDocAnl',pValue);
end;

function TKey.ReadIcbVatSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbVatSnt','343');
end;

procedure TKey.WriteIcbVatSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbVatSnt',pValue);
end;

function TKey.ReadIcbVatAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbVatAnl','');
end;

procedure TKey.WriteIcbVatAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbVatAnl',pValue);
end;

function TKey.ReadIcbGscSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbGscSnt','604');
end;

procedure TKey.WriteIcbGscSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbGscSnt',pValue);
end;

function TKey.ReadIcbGscAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbGscAnl','000100');
end;

procedure TKey.WriteIcbGscAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbGscAnl',pValue);
end;

function TKey.ReadIcbSecSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbSecSnt','602');
end;

procedure TKey.WriteIcbSecSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbSecSnt',pValue);
end;

function TKey.ReadIcbSecAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbSecAnl','000100');
end;

procedure TKey.WriteIcbSecAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbSecAnl',pValue);
end;

function TKey.ReadIcbPcrSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbPcrSnt','');
end;

procedure TKey.WriteIcbPcrSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbPcrSnt',pValue);
end;

function TKey.ReadIcbPcrAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbPcrAnl','');
end;

procedure TKey.WriteIcbPcrAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbPcrAnl',pValue);
end;

function TKey.ReadIcbNcrSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbNcrSnt','');
end;

procedure TKey.WriteIcbNcrSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbNcrSnt',pValue);
end;

function TKey.ReadIcbNcrAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbNcrAnl','');
end;

procedure TKey.WriteIcbNcrAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbNcrAnl',pValue);
end;

function TKey.ReadIcbPdfSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbPdfSnt','');
end;

procedure TKey.WriteIcbPdfSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbPdfSnt',pValue);
end;

function TKey.ReadIcbPdfAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbPdfAnl','');
end;

procedure TKey.WriteIcbPdfAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbPdfAnl',pValue);
end;

function TKey.ReadIcbNdfSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('ICB',pBookNum,'IcbNdfSnt','');
end;

procedure TKey.WriteIcbNdfSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('ICB',pBookNum,'IcbNdfSnt',pValue);
end;

function TKey.ReadIcbNdfAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('ICB',pBookNum,'IcbNdfAnl','');
end;

procedure TKey.WriteIcbNdfAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('ICB',pBookNum,'IcbNdfAnl',pValue);
end;

function TKey.ReadIcbTcbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ICB',pBookNum,'IcbTcbNum','');
end;

procedure TKey.WriteIcbTcbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ICB',pBookNum,'IcbTcbNum',pValue);
end;

function TKey.ReadIcbCsbNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ICB',pBookNum,'IcbCsbNum','');
end;

procedure TKey.WriteIcbCsbNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ICB',pBookNum,'IcbCsbNum',pValue);
end;

function TKey.ReadIcbNibNum(pBookNum:Str5):Str5;
begin
  Result := ReadString ('ICB',pBookNum,'IcbNibNum','');
end;

procedure TKey.WriteIcbNibNum(pBookNum:Str5;pValue:Str5);
begin
  WriteString ('ICB',pBookNum,'IcbNibNum',pValue);
end;

function TKey.ReadIcbDocSpc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbDocSpc','0'));
end;

procedure TKey.WriteIcbDocSpc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbDocSpc',StrInt(pValue,0));
end;

function TKey.ReadIcbExCalc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbExCalc','0'));
end;

procedure TKey.WriteIcbExCalc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbExCalc',StrInt(pValue,0));
end;

function TKey.ReadIcbBaCont(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaCont','');
end;

procedure TKey.WriteIcbBaCont(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaCont',pValue);
end;

function TKey.ReadIcbBaName(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaName','');
end;

procedure TKey.WriteIcbBaName(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaName',pValue);
end;

function TKey.ReadIcbBaIban(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaIban','');
end;

procedure TKey.WriteIcbBaIban(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaIban',pValue);
end;

function TKey.ReadIcbBaSwft(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaSwft','');
end;

procedure TKey.WriteIcbBaSwft(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaSwft',pValue);
end;

function TKey.ReadIcbBaAddr(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaAddr','');
end;

procedure TKey.WriteIcbBaAddr(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaAddr',pValue);
end;

function TKey.ReadIcbBaCity(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaCity','');
end;

procedure TKey.WriteIcbBaCity(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaCity',pValue);
end;

function TKey.ReadIcbBaStat(pBookNum:Str5):Str30;
begin
  Result := ReadString ('ICB',pBookNum,'IcbBaStat','');
end;

procedure TKey.WriteIcbBaStat(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbBaStat',pValue);
end;

function TKey.ReadIcbPayCoi(pBookNum:Str5):word;
begin
  Result := Valint(ReadString ('ICB',pBookNum,'IcbPayCoi','0'));
end;

procedure TKey.WriteIcbPayCoi(pBookNum:Str5;pValue:word);
begin
  WriteString ('ICB',pBookNum,'IcbPayCoi',StrInt(pValue,0));
end;

function TKey.ReadIcbCadTyp(pBookNum:Str5):byte;
begin
  Result := Valint(ReadString ('ICB',pBookNum,'IcbCadTyp','1'));
end;

procedure TKey.WriteIcbCadTyp(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbCadTyp',StrInt(pValue,0));
end;

function TKey.ReadIcbItmAcc(pBookNum:Str5):byte;
begin
  Result := Valint(ReadString ('ICB',pBookNum,'IcbItmAcc','0'));
end;

procedure TKey.WriteIcbItmAcc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbItmAcc',StrInt(pValue,0));
end;

function TKey.ReadIcbFgCalc(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('ICB',pBookNum,'IcbFgCalc','0'));
end;

procedure TKey.WriteIcbFgCalc(pBookNum:Str5;pValue:byte);
begin
  WriteString ('ICB',pBookNum,'IcbFgCalc',StrInt(pValue,0));
end;

function TKey.ReadIcbDsHide(pBookNum:Str5):boolean;
begin
  Result := ReadString('ICB',pBookNum,'IcbDsHide',cOff)=cOn;
end;

procedure TKey.WriteIcbDsHide(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('ICB',pBookNum,'IcbDsHide',cOn)
    else WriteString ('ICB',pBookNum,'IcbDsHide',cOff);
end;

function TKey.ReadIcbRepVtd(pBookNum:Str5):Str30;
begin
  Result:=ReadString ('ICB',pBookNum,'IcbRepVtd','ICD');
end;

procedure TKey.WriteIcbRepVtd(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbRepVtd',pValue);
end;

function TKey.ReadIcbRepNvd(pBookNum:Str5):Str30;
begin
  Result:=ReadString ('ICB',pBookNum,'IcbRepNvd','ICD');
end;

procedure TKey.WriteIcbRepNvd(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbRepNvd',pValue);
end;

function TKey.ReadIcbRepVtdO(pBookNum:Str5):Str30;
begin
  Result:=ReadString ('ICB',pBookNum,'IcbRepVtdO','ICD_E');
end;

procedure TKey.WriteIcbRepVtdO(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbRepVtdO',pValue);
end;

function TKey.ReadIcbRepNvdO(pBookNum:Str5):Str30;
begin
  Result:=ReadString ('ICB',pBookNum,'IcbRepNvdO','ICD_E');
end;

procedure TKey.WriteIcbRepNvdO(pBookNum:Str5;pValue:Str30);
begin
  WriteString ('ICB',pBookNum,'IcbRepNvdO',pValue);
end;

// ********************************** DPB **************************************

function TKey.ReadDpbHcrSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('DPB',pBookNum,'DpbHcrSnt','');
end;

procedure TKey.WriteDpbHcrSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('DPB',pBookNum,'DpbHcrSnt',pValue);
end;

function TKey.ReadDpbHcrAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('DPB',pBookNum,'DpbHcrAnl','');
end;

procedure TKey.WriteDpbHcrAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('DPB',pBookNum,'DpbHcrAnl',pValue);
end;

function TKey.ReadDpbHdbSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('DPB',pBookNum,'DpbHdbSnt','');
end;

procedure TKey.WriteDpbHdbSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('DPB',pBookNum,'DpbHdbSnt',pValue);
end;

function TKey.ReadDpbHdbAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('DPB',pBookNum,'DpbHdbAnl','');
end;

procedure TKey.WriteDpbHdbAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('DPB',pBookNum,'DpbHdbAnl',pValue);
end;

function TKey.ReadDpbIcrSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('DPB',pBookNum,'DpbIcrSnt','');
end;

procedure TKey.WriteDpbIcrSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('DPB',pBookNum,'DpbIcrSnt',pValue);
end;

function TKey.ReadDpbIcrAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('DPB',pBookNum,'DpbIcrAnl','');
end;

procedure TKey.WriteDpbIcrAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('DPB',pBookNum,'DpbIcrAnl',pValue);
end;

function TKey.ReadDpbIdbSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString ('DPB',pBookNum,'DpbIdbSnt','');
end;

procedure TKey.WriteDpbIdbSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('DPB',pBookNum,'DpbIdbSnt',pValue);
end;

function TKey.ReadDpbIdbAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString ('DPB',pBookNum,'DpbIdbAnl','');
end;

procedure TKey.WriteDpbIdbAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('DPB',pBookNum,'DpbIdbAnl',pValue);
end;

// ********************************** ASC **************************************

function TKey.ReadAscExdBeg(pPerNum:byte):integer;
var mDefault:Str10;
begin
  case pPerNum of
    1: mDefault := '-99999';
    2: mDefault := '0';
    3: mDefault := '1';
    4: mDefault := '2';
    5: mDefault := '8';
    6: mDefault := '16';
    7: mDefault := '31';
    8: mDefault := '61';
    9: mDefault := '91';
  end;
  Result := ValInt(ReadString('ASC','','AscExdBeg'+StrInt(pPerNum,1),mDefault));
end;

procedure TKey.WriteAscExdBeg(pPerNum:byte;pValue:integer);
begin
  WriteString ('ASC','','AscExdBeg'+StrInt(pPerNum,1),StrInt(pValue,0));
end;

function TKey.ReadAscExdEnd(pPerNum:byte):integer;
var mDefault:Str10;
begin
  case pPerNum of
    1: mDefault := '-1';
    2: mDefault := '0';
    3: mDefault := '1';
    4: mDefault := '7';
    5: mDefault := '15';
    6: mDefault := '30';
    7: mDefault := '60';
    8: mDefault := '90';
    9: mDefault := '99999';
  end;
  Result := ValInt(ReadString('ASC','','AscExdEnd'+StrInt(pPerNum,1),mDefault));
end;

procedure TKey.WriteAscExdEnd(pPerNum:byte;pValue:integer);
begin
  WriteString ('ASC','','AscExdEnd'+StrInt(pPerNum,1),StrInt(pValue,0));
end;

function TKey.ReadAscExdTxt(pPerNum:byte):Str30;
var mDefault:Str30;
begin
  case pPerNum of
    1: mDefault := 'Pred splatnosùou:';
    2: mDefault := 'Dnes splatnÈ:';
    3: mDefault := '1 deÚ po splatnosti:';
    4: mDefault := '2-7 dnÌ po splatnosti:';
    5: mDefault := '8-15 dnÌ po splatnosti:';
    6: mDefault := '16-30 dnÌ po splatnosti:';
    7: mDefault := '31-60 dnÌ po splatnosti:';
    8: mDefault := '61-90 dnÌ po splatnosti:';
    9: mDefault := '> 90 dnÌ po splatnosti:';
  end;
  Result := ReadString ('ASC','','AscExdTxt'+StrInt(pPerNum,1),mDefault);
end;

procedure TKey.WriteAscExdTxt(pPerNum:byte;pValue:Str30);
begin
  WriteString ('ASC','','AscExdTxt'+StrInt(pPerNum,1),pValue);
end;

// ********************************** CAS **************************************

function TKey.ReadCasClsTyp(pCasNum:word):longint;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasClsTyp','2'));
end;

procedure TKey.WriteCasClsTyp(pCasNum:word;pValue:longint);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasClsTyp',StrInt(pValue,0));
end;

function TKey.ReadCasBlkNum(pCasNum:word):longint;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasBlkNum','0'));
end;

procedure TKey.WriteCasBlkNum(pCasNum:word;pValue:longint);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasBlkNum',StrInt(pValue,0));
end;

function TKey.ReadCasTrnNeb(pCasNum:word):boolean;
begin
  Result := ReadString ('CAS',StrInt(pCasNum,0),'CasTrnNeb',cOff)=cOn;
end;

procedure TKey.WriteCasTrnNeb(pCasNum:word;pValue:boolean);
begin
  If pValue
    then WriteString ('CAS',StrInt(pCasNum,0),'CasTrnNeb',cOn)
    else WriteString ('CAS',StrInt(pCasNum,0),'CasTrnNeb',cOff)
end;

function TKey.ReadCasDupMsg(pCasNum:word):boolean;
begin
  Result := ReadString ('CAS',StrInt(pCasNum,0),'CasDupMsg',cOff)=cOn;
end;

procedure TKey.WriteCasDupMsg(pCasNum:word;pValue:boolean);
begin
  If pValue
    then WriteString ('CAS',StrInt(pCasNum,0),'CasDupMsg',cOn)
    else WriteString ('CAS',StrInt(pCasNum,0),'CasDupMsg',cOff)
end;

function TKey.ReadCasDupSum(pCasNum:word):boolean;
begin
  Result := ReadString ('CAS',StrInt(pCasNum,0),'CasDupSum',cOff)=cOn;
end;

procedure TKey.WriteCasDupSum(pCasNum:word;pValue:boolean);
begin
  If pValue
    then WriteString ('CAS',StrInt(pCasNum,0),'CasDupSum',cOn)
    else WriteString ('CAS',StrInt(pCasNum,0),'CasDupSum',cOff)
end;

function TKey.ReadCasFmdPrn(pCasNum:word):boolean;
begin
  Result := ReadString ('CAS',StrInt(pCasNum,0),'CasFmdPrn',cOff)=cOn;
end;

procedure TKey.WriteCasFmdPrn(pCasNum:word;pValue:boolean);
begin
  If pValue
    then WriteString ('CAS',StrInt(pCasNum,0),'CasFmdPrn',cOn)
    else WriteString ('CAS',StrInt(pCasNum,0),'CasFmdPrn',cOff)
end;

function TKey.ReadCasLanDir(pCasNum:word):Str250;
begin
  Result := ReadString('CAS',StrInt(pCasNum,0),'CasLanDir','');
end;

procedure TKey.WriteCasLanDir(pCasNum:word;pValue:Str250);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasLanDir',pValue);
end;

function TKey.ReadCasTcdBok(pCasNum:word):Str5;        
begin
  If pCasNum=0
    then Result := ReadString('CAS','','CasTcdBok','A-001')
    else Result := ReadString('CAS',StrInt(pCasNum,0),'CasTcdBok','A-001');
end;

procedure TKey.WriteCasTcdBok(pCasNum:word;pValue:Str5);
begin
  If pCasNum=0
    then WriteString ('CAS','','CasTcdBok',pValue)
    else WriteString ('CAS',StrInt(pCasNum,0),'CasTcdBok',pValue);
end;

function TKey.ReadCasTpcNum(pCasNum:word):word;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasTpcNum','1'));
end;

procedure TKey.WriteCasTpcNum(pCasNum:word;pValue:word);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasTpcNum',StrInt(pValue,0));
end;

function TKey.ReadCasFmpWay(pCasNum:word):word;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasFmpWay','200'));
end;

procedure TKey.WriteCasFmpWay(pCasNum:word;pValue:word);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasFmpWay',StrInt(pValue,0));
end;

function TKey.ReadCasFmiWay(pCasNum:word):word;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasFmiWay','700'));
end;

procedure TKey.WriteCasFmiWay(pCasNum:word;pValue:word);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasFmiWay',StrInt(pValue,0));
end;

function TKey.ReadCasPauCnt(pCasNum:word):word;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasPauCnt','0'));
end;

procedure TKey.WriteCasPauCnt(pCasNum:word;pValue:word);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasPauCnt',StrInt(pValue,0));
end;

function TKey.ReadCasExdQnt(pCasNum:word):byte;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasExdQnt','2'));
end;

procedure TKey.WriteCasExdQnt(pCasNum:word;pValue:byte);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasExdQnt',StrInt(pValue,0));
end;

function TKey.ReadCasMaxItm(pCasNum:word):word;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasMaxItm','60'));
end;

procedure TKey.WriteCasMaxItm(pCasNum:word;pValue:word);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasMaxItm',StrInt(pValue,0));
end;

function TKey.ReadCasIcpQnt(pCasNum:word):byte;
begin
  Result := ValInt(ReadString('CAS',StrInt(pCasNum,0),'CasIcpQnt','2'));
end;

procedure TKey.WriteCasIcpQnt(pCasNum:word;pValue:byte);
begin
  WriteString ('CAS',StrInt(pCasNum,0),'CasIcpQnt',StrInt(pValue,0));
end;

function TKey.ReadCasPabBeg:longint;
begin
  Result := ValInt(ReadString('CAS','','CasPabBeg','0'))
end;

procedure TKey.WriteCasPabBeg(pValue:longint);
begin
  WriteString ('CAS','','CasPabBeg',IntToStr(pValue));
end;

function TKey.ReadCasPabEnd:longint;
begin
  Result := ValInt(ReadString('CAS','','CasPabEnd','0'))
end;

procedure TKey.WriteCasPabEnd(pValue:longint);
begin
  WriteString ('CAS','','CasPabEnd',IntToStr(pValue));
end;

// ********************************** CAI **************************************

function TKey.ReadCaiActTrn:boolean;
begin
  Result := ReadString ('CAI','','CaiActTrn',cOff)=cOn;
end;

procedure TKey.WriteCaiActTrn(pValue:boolean);
begin
  If pValue
    then WriteString ('CAI','','CaiActTrn',cOn)
    else WriteString ('CAI','','CaiActTrn',cOff)
end;

// ********************************** RPC **************************************

function TKey.ReadRpcChgNum(pPlsNum:word):word;
begin
  Result := ValInt(ReadString('RPC',StrInt(pPlsNum,5),'RpcChgNum','0'));
end;

procedure TKey.WriteRpcChgNum(pPlsNum:word;pValue:word);
begin
  WriteString ('RPC',StrInt(pPlsNum,5),'RpcChgNum',StrInt(pValue,0));
end;

function TKey.ReadRpcChgCas(pPlsNum:word):Str250;
begin
  Result := ReadString('RPC',StrInt(pPlsNum,5),'RpcChgCas','1,2,3');
end;

procedure TKey.WriteRpcChgCas(pPlsNum:word;pValue:Str250);
begin
  WriteString ('RPC',StrInt(pPlsNum,5),'RpcChgCas',pValue);
end;

function TKey.ReadRpcExpRef(pPlsNum:word):boolean;
begin
  Result := ValInt(ReadString('RPC',StrInt(pPlsNum,5),'RpcExpRef','0'))=1;
end;

procedure TKey.WriteRpcExpRef(pPlsNum:word;pValue:boolean);
begin
  WriteString ('RPC',StrInt(pPlsNum,5),'RpcExpRef',BoolToStr(pValue));
end;

// ********************************** CSB **************************************

function TKey.ReadCsbBoYear(pBookNum:Str5):Str4;
begin
  Result := ReadString('CSB',pBookNum,'CsbBoYear',gvSys.ActYear);
end;

procedure TKey.WriteCsbBoYear(pBookNum:Str5;pValue:Str4);
begin
  WriteString ('CSB',pBookNum,'CsbBoYear',pValue);
end;

function TKey.ReadCsbDvName(pBookNum:Str5):Str3;
begin
  Result := ReadString('CSB',pBookNum,'CsbDvName','');
end;

procedure TKey.WriteCsbDvName(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('CSB',pBookNum,'CsbDvName',pValue);
end;

function TKey.ReadCsbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbWriNum','0'));
end;

procedure TKey.WriteCsbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbWriNum',StrInt(pValue,0));
end;

function TKey.ReadCsbPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbPabNum','0'));
end;

procedure TKey.WriteCsbPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbPabNum',StrInt(pValue,0));
end;

function TKey.ReadCsbPyvBeg(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbPyvBeg','0'));
end;

procedure TKey.WriteCsbPyvBeg(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbPyvBeg',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbPyvInc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbPyvInc','0'));
end;

procedure TKey.WriteCsbPyvInc(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbPyvInc',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbPyvExp(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbPyvExp','0'));
end;

procedure TKey.WriteCsbPyvExp(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbPyvExp',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbPyvEnd(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbPyvEnd','0'));
end;

procedure TKey.WritePyvEndExp(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbEndExp',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbMaxPdf(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbMaxPdf','0'));
end;

procedure TKey.WritePyvPyvMax(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbMaxPdf',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbAcvBeg(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbAcvBeg','0'));
end;

procedure TKey.WritePyvAcvBeg(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbAcvBeg',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbAcvInc(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbAcvInc','0'));
end;

procedure TKey.WritePyvAcvInc(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbAcvInc',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbAcvExp(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbAcvExp','0'));
end;

procedure TKey.WritePyvAcvExp(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbAcvExp',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbEycCrd(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbEycCrd','0'));
end;

procedure TKey.WritePyvEycCrd(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbEycCrd',StrDoub(pValue,0,5));
end;

function TKey.ReadCsbEyvCrd(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbEyvCrd','0'));
end;

procedure TKey.WritePyvEyvCrd(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbEyvCrd',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbAcvEnd(pBookNum:Str5):double;
begin
  Result := ValDoub(ReadString('CSB',pBookNum,'CsbAcvEnd','0'));
end;

procedure TKey.WritePyvAcvEnd(pBookNum:Str5;pValue:double);
begin
  WriteString ('CSB',pBookNum,'CsbAcvEnd',StrDoub(pValue,0,2));
end;

function TKey.ReadCsbDocSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString('CSB',pBookNum,'CsbDocSnt','');
end;

procedure TKey.WriteCsbDocSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('CSB',pBookNum,'CsbDocSnt',pValue);
end;

function TKey.ReadCsbDocAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString('CSB',pBookNum,'CsbDocAnl','');
end;

procedure TKey.WriteCsbDocAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('CSB',pBookNum,'CsbDocAnl',pValue);
end;

function TKey.ReadCsbVaiSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString('CSB',pBookNum,'CsbVaiSnt','');
end;

procedure TKey.WriteCsbVaiSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('CSB',pBookNum,'CsbVaiSnt',pValue);
end;

function TKey.ReadCsbVaiAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString('CSB',pBookNum,'CsbVaiAnl','');
end;

procedure TKey.WriteCsbVaiAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('CSB',pBookNum,'CsbVaiAnl',pValue);
end;

function TKey.ReadCsbVaoSnt(pBookNum:Str5):Str3;
begin
  Result := ReadString('CSB',pBookNum,'CsbVaoSnt','');
end;

procedure TKey.WriteCsbVaoSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString ('CSB',pBookNum,'CsbVaoSnt',pValue);
end;

function TKey.ReadCsbVaoAnl(pBookNum:Str5):Str6;
begin
  Result := ReadString('CSB',pBookNum,'CsbVaoAnl','');
end;

procedure TKey.WriteCsbVaoAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('CSB',pBookNum,'CsbVaoAnl',pValue);
end;

function TKey.ReadExcVatSnt(pBookNum:Str5):Str3;
begin
  Result:=ReadString('CSB',pBookNum,'ExcVatSnt','');
end;

procedure TKey.WriteExcVatSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString('CSB',pBookNum,'ExcVatSnt',pValue);
end;

function TKey.ReadExcVatAnl(pBookNum:Str5):Str6;
begin
  Result:=ReadString('CSB',pBookNum,'ExcVatAnl','');
end;

procedure TKey.WriteExcVatAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString('CSB',pBookNum,'ExcVatAnl',pValue);
end;

function TKey.ReadExcCosSnt(pBookNum:Str5):Str3;
begin
  Result:=ReadString('CSB',pBookNum,'ExcCosSnt','');
end;

procedure TKey.WriteExcCosSnt(pBookNum:Str5;pValue:Str3);
begin
  WriteString('CSB',pBookNum,'ExcCosSnt',pValue);
end;

function TKey.ReadExcCosAnl(pBookNum:Str5):Str6;
begin
  Result:=ReadString('CSB',pBookNum,'ExcCosAnl','');
end;

procedure TKey.WriteExcCosAnl(pBookNum:Str5;pValue:Str6);
begin
  WriteString ('CSB',pBookNum,'ExcCosAnl',pValue);
end;

function TKey.ReadCsbVatRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbVatRnd',''));
end;

procedure TKey.WriteCsbVatRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('CSB',pBookNum,'CsbVatRnd',StrInt(pValue,0));
end;

function TKey.ReadCsbValRnd(pBookNum:Str5):byte;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbValRnd',''));
end;

procedure TKey.WriteCsbValRnd(pBookNum:Str5;pValue:byte);
begin
  WriteString ('CSB',pBookNum,'CsbValRnd',StrInt(pValue,0));
end;

function TKey.ReadCsbSpcCse(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbSpcCse','100'));
end;

procedure TKey.WriteCsbSpcCse(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbSpcCse',StrInt(pValue,0));
end;

function TKey.ReadCsbSpcCsi(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbSpcCsi','200'));
end;

procedure TKey.WriteCsbSpcCsi(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbSpcCsi',StrInt(pValue,0));
end;

function TKey.ReadCsbVatCls(pBookNum:Str5):boolean;
begin
  Result := ReadString ('CSB',pBookNum,'CsbVatCls',cOn)=cOn;
end;

procedure TKey.WriteCsbVatCls(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('CSB',pBookNum,'CsbVatCls',cOn)
    else WriteString ('CSB',pBookNum,'CsbVatCls',cOff)
end;



function TKey.ReadCsbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString('CSB',pBookNum,'CsbAutAcc',cOff)=cOn;
end;

procedure TKey.WriteCsbAutAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('CSB',pBookNum,'CsbAutAcc',cOn)
    else WriteString ('CSB',pBookNum,'CsbAutAcc',cOff)
end;

function TKey.ReadCsbRndVer(pBookNum:Str5):boolean;
begin
  Result := ReadString('CSB',pBookNum,'CsbRndVer',cOff)=cOn;
end;

procedure TKey.WriteCsbRndVer(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('CSB',pBookNum,'CsbRndVer',cOn)
    else WriteString ('CSB',pBookNum,'CsbRndVer',cOff)
end;

function TKey.ReadCsbSumAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString('CSB',pBookNum,'CsbSumAcc',cOff)=cOn;
end;

procedure TKey.WriteCsbSumAcc(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('CSB',pBookNum,'CsbSumAcc',cOn)
    else WriteString ('CSB',pBookNum,'CsbSumAcc',cOff)
end;

function TKey.ReadCsbWriAdd(pBookNum:Str5):boolean;
begin
  Result := ReadString('CSB',pBookNum,'CsbWriAdd',cOff)=cOn;
end;

procedure TKey.WriteCsbWriAdd(pBookNum:Str5;pValue:boolean);
begin
  If pValue
    then WriteString ('CSB',pBookNum,'CsbWriAdd',cOn)
    else WriteString ('CSB',pBookNum,'CsbWriAdd',cOff)
end;

function TKey.ReadCsbDoiQnt(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbDoiQnt','0'));
end;

procedure TKey.WriteCsbDoiQnt(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbDoiQnt',StrInt(pValue,0));
end;

function TKey.ReadCsbDoeQnt(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbDoeQnt','0'));
end;

procedure TKey.WriteCsbDoeQnt(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbDoeQnt',StrInt(pValue,0));
end;

function TKey.ReadCsbDocQnt(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('CSB',pBookNum,'CsbDocQnt','0'));
end;

procedure TKey.WriteCsbDocQnt(pBookNum:Str5;pValue:word);
begin
  WriteString ('CSB',pBookNum,'CsbDocQnt',StrInt(pValue,0));
end;

// ********************************** SPB **************************************

procedure TKey.WriteSpbPabNum(pValue:word);
begin
  WriteString ('SPB','','SpbPabNum',StrInt(pValue,0))
end;

function TKey.ReadSpbPabNum:word;
begin
  Result := ValInt(ReadString('SPB','','SpbPabNum','0'));
end;

// ********************************** SPB **************************************

function TKey.ReadSobAboPat(pBookNum: Str5): Str80;
begin
  Result := ReadString('SOB',pBookNum,'SobAboPat','');
end;

function TKey.ReadSobAboTyp(pBookNum: Str5): byte;
begin
  Result := ValInt(ReadString('SOB',pBookNum,'SobAboTyp','0'));
end;

function TKey.ReadSobAcvBeg(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobAcvBeg','0'));
end;

function TKey.ReadSobAcvCre(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobAcvCre','0'));
end;

function TKey.ReadSobAcvDeb(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobAcvDeb','0'));
end;

function TKey.ReadSobAcvEnd(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobAcvEnd','0'));
end;

function TKey.ReadSobAutAcc(pBookNum: Str5): boolean;
begin
  Result := ReadString('SOB',pBookNum,'SobAutAcc',cOn)=cOn;
end;

function TKey.ReadSobBaCont(pBookNum: Str5): Str20;
begin
  Result := ReadString('SOB',pBookNum,'SobBaCont','');
end;

function TKey.ReadSobBaIban(pBookNum: Str5): Str30;
begin
  Result := ReadString('SOB',pBookNum,'SobBaIban','');
end;

function TKey.ReadSobBaCode(pBookNum: Str5): Str4;
begin
  Result := ReadString('SOB',pBookNum,'SobBaCode','');
end;

function TKey.ReadSobBaName(pBookNum: Str5): Str30;
begin
  Result := ReadString('SOB',pBookNum,'SobBaName','');
end;

function TKey.ReadSobBaSwft(pBookNum: Str5): Str10;
begin
  Result := ReadString('SOB',pBookNum,'SobBaSwft','');
end;

function TKey.ReadSobDocAnl(pBookNum: Str5): Str6;
begin
  Result := ReadString('SOB',pBookNum,'SobDocAnl','');
end;

function TKey.ReadSobDocSnt(pBookNum: Str5): Str3;
begin
  Result := ReadString('SOB',pBookNum,'SobDocSnt','');
end;

function TKey.ReadSobEycCrd(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobEycCrd','0'));
end;

function TKey.ReadSobEyvCrd(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobAcvCre','0'));
end;

function TKey.ReadSobPydCrs(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobPydCrs','0'));
end;

function TKey.ReadSobPydNam(pBookNum: Str5): Str3;
begin
  Result := ReadString('SOB',pBookNum,'SobPydNam','');
end;

function TKey.ReadSobPyvBeg(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobPyvBeg','0'));
end;

function TKey.ReadSobPyvCre(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobPyvCre','0'));
end;

function TKey.ReadSobPyvDeb(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobPyvDeb','0'));
end;

function TKey.ReadSobPyvEnd(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobPyvEnd','0'));
end;

function TKey.ReadSobPyvMax(pBookNum: Str5): double;
begin
  Result := ValDoub(ReadString('SOB',pBookNum,'SobPyvMax','0'));
end;
procedure TKey.WriteSobAboPat(pBookNum: Str5; pValue: Str80);
begin
  WriteString ('SOB',pBookNum,'SobAboPat',pValue);
end;

procedure TKey.WriteSobAboTyp(pBookNum: Str5; pValue: byte);
begin
  WriteString ('SOB',pBookNum,'SobAboTyp',StrInt(pValue,0));
end;

procedure TKey.WriteSobAcvBeg(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobAcvBeg',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobAcvCre(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobAcvCre',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobAcvDeb(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobAcvDeb',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobAcvEnd(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobAcvEnd',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobAutAcc(pBookNum: Str5; pValue: boolean);
begin
  If pValue
    then WriteString ('SOB',pBookNum,'SobAutAcc',cOn)
    else WriteString ('SOB',pBookNum,'SobAutAcc',cOff);
end;

procedure TKey.WriteSobBaCont(pBookNum: Str5; pValue: Str20);
begin
  WriteString ('SOB',pBookNum,'SobBaCont',pValue);
end;

procedure TKey.WriteSobBaCode(pBookNum: Str5; pValue: Str4);
begin
  WriteString ('SOB',pBookNum,'SobBaCode',pValue);
end;

procedure TKey.WriteSobBaIban(pBookNum: Str5; pValue: Str30);
begin
  WriteString ('SOB',pBookNum,'SobBaIban',pValue);
end;

procedure TKey.WriteSobBaName(pBookNum: Str5; pValue: Str30);
begin
  WriteString ('SOB',pBookNum,'SobBaName',pValue);
end;

procedure TKey.WriteSobBaSwft(pBookNum: Str5; pValue: Str10);
begin
  WriteString ('SOB',pBookNum,'SobBaSwft',pValue);
end;

procedure TKey.WriteSobDocAnl(pBookNum: Str5; pValue: Str6);
begin
  WriteString ('SOB',pBookNum,'SobDocAnl',pValue);
end;

procedure TKey.WriteSobDocSnt(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('SOB',pBookNum,'SobDocSnt',pValue);
end;

procedure TKey.WriteSobEycCrd(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobEycCrd',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobEyvCrd(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobEyvCrd',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobPydCrs(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobPydCrs',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobPydNam(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('SOB',pBookNum,'SobPydNam',pValue);
end;

procedure TKey.WriteSobPyvBeg(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobPyvBeg',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobPyvCre(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobPyvCre',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobPyvDeb(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobPyvDeb',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobPyvEnd(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobPyvEnd',StrDoub(pValue,0,2));
end;

procedure TKey.WriteSobPyvMax(pBookNum: Str5; pValue: double);
begin
  WriteString ('SOB',pBookNum,'SobPyvMax',StrDoub(pValue,0,2));
end;

function TKey.ReadSobDocQnt(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SOB',pBookNum,'SobDocQnt','0'));
end;

procedure TKey.WriteSobDocQnt(pBookNum:Str5;pValue:word);
begin
  WriteString ('SOB',pBookNum,'SobDocQnt',StrInt(pValue,0));
end;

function TKey.ReadSobWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SOB',pBookNum,'SobWriNum','0'));
end;

procedure TKey.WriteSobWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('SOB',pBookNum,'SobWriNum',StrInt(pValue,0));
end;

function TKey.ReadSobPabNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('SOB',pBookNum,'SobPabNum','0'));
end;

procedure TKey.WriteSobPabNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('SOB',pBookNum,'SobPabNum',StrInt(pValue,0));
end;

// ********************************** OWB **************************************

function TKey.ReadOwbAutAcc(pBookNum: Str5): boolean;
begin
  Result := ReadString('OWB',pBookNum,'OwbAutAcc',cOn)=cOn;
end;

function TKey.ReadOwbCsdBok(pBookNum: Str5; pNum: byte): Str5;
begin
  Result := ReadString ('OWB',pBookNum,'OwbCsdBo'+IntToStr(pNum),'');
end;

function TKey.ReadOwbVatCls(pBookNum: Str5): boolean;
begin
  Result := ReadString('OWB',pBookNum,'OwbVatCls',cOn)=cOn;
end;

function TKey.ReadOwbDocAnl(pBookNum: Str5): Str6;
begin
  Result := ReadString ('OWB',pBookNum,'OwbDocAnl','');
end;

function TKey.ReadOwbDocSnt(pBookNum: Str5): Str3;
begin
  Result := ReadString ('OWB',pBookNum,'OwbDocSnt','');
end;

function TKey.ReadOwbDvzNam(pBookNum: Str5; pNum: byte): Str3;
begin
  Result := ReadString ('OWB',pBookNum,'OwbDvzNa'+IntToStr(pNum),'');
end;

function TKey.ReadOwbExnFrm(pBookNum: Str5): Str12;
begin
  Result := ReadString ('OWB',pBookNum,'OwbExnFrm','');
end;

function TKey.ReadOwbPabNum(pBookNum: Str5): word;
begin
  Result := ValInt(ReadString ('OWB',pBookNum,'OwbPabNum',''));
end;

function TKey.ReadOwbVatAnl(pBookNum: Str5): Str6;
begin
  Result := ReadString ('OWB',pBookNum,'OwbVatAnl','');
end;

function TKey.ReadOwbVatSnt(pBookNum: Str5): Str3;
begin
  Result := ReadString ('OWB',pBookNum,'OwbVatSnt','');
end;

procedure TKey.WriteOwbAutAcc(pBookNum: Str5; pValue: boolean);
begin
  If pValue
    then WriteString ('OWB',pBookNum,'OwbAutAcc',cOn)
    else WriteString ('OWB',pBookNum,'OwbAutAcc',cOff);
end;

procedure TKey.WriteOwbVatCls(pBookNum: Str5; pValue: boolean);
begin
  If pValue
    then WriteString ('OWB',pBookNum,'OwbVatCls',cOn)
    else WriteString ('OWB',pBookNum,'OwbVatCls',cOff);
end;

procedure TKey.WriteOwbCsdBok(pBookNum: Str5; pNum: byte; pValue: Str5);
begin
  WriteString ('OWB',pBookNum,'OwbCsdBo'+IntToStr(pNum),pValue);
end;

procedure TKey.WriteOwbDocAnl(pBookNum: Str5; pValue: Str6);
begin
  WriteString ('OWB',pBookNum,'OwbDocAnl',pValue);
end;

procedure TKey.WriteOwbDocSnt(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('OWB',pBookNum,'OwbDocSnt',pValue);
end;

procedure TKey.WriteOwbDvzNam(pBookNum: Str5; pNum: byte; pValue: Str3);
begin
  WriteString ('OWB',pBookNum,'OwbDvzNa'+IntToStr(pNum),pValue);
end;

procedure TKey.WriteOwbExnFrm(pBookNum: Str5; pValue: Str12);
begin
  WriteString ('OWB',pBookNum,'OwbExnFrm',pValue);
end;

procedure TKey.WriteOwbPabNum(pBookNum: Str5; pValue: word);
begin
  WriteString ('OWB',pBookNum,'OwbPabNum',StrInt(pValue,0));
end;

procedure TKey.WriteOwbVatAnl(pBookNum: Str5; pValue: Str6);
begin
  WriteString ('OWB',pBookNum,'OwbVatAnl',pValue);
end;

procedure TKey.WriteOwbVatSnt(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('OWB',pBookNum,'OwbVatSnt',pValue);
end;

// ********************************** SVB **************************************

function TKey.ReadSvbAutAcc(pBookNum: Str5): boolean;
begin
  Result := ReadString('SVB',pBookNum,'SvbAutAcc',cOn)=cOn;
end;

function TKey.ReadSvbWriSha(pBookNum: Str5): boolean;
begin
  Result := ReadString('SVB',pBookNum,'SvbWriSha',cOn)=cOn;
end;

function TKey.ReadSvbAccNeg(pBookNum: Str5): boolean;
begin
  Result := ReadString('SVB',pBookNum,'SvbAccNeg',cOff)=cOn;
end;

function TKey.ReadSvbDocAnl(pBookNum: Str5): Str6;
begin
  Result := ReadString ('SVB',pBookNum,'SvbDocAnl','000100');
end;

function TKey.ReadSvbDocSnt(pBookNum: Str5): Str3;
begin
  Result := ReadString ('SVB',pBookNum,'SvbDocSnt','324');
end;

function TKey.ReadSvbDvzNam(pBookNum: Str5): Str3;
begin
  Result := ReadString ('SVB',pBookNum,'SvbDvzNa','');
end;

function TKey.ReadSvbExnFrm(pBookNum: Str5): Str12;
begin
  Result := ReadString ('SVB',pBookNum,'SvbExnFrm','bbbbbnnnnn');
end;

function TKey.ReadSvbWriNum(pBookNum: Str5): word;
begin
  Result := ValInt(ReadString ('SVB',pBookNum,'SvbWriNum',''));
end;

function TKey.ReadSvbVatAnl(pBookNum: Str5): Str6;
begin
  Result := ReadString ('SVB',pBookNum,'SvbVatAnl','000020');
end;

function TKey.ReadSvbVatSnt(pBookNum: Str5): Str3;
begin
  Result := ReadString ('SVB',pBookNum,'SvbVatSnt','343');
end;

procedure TKey.WriteSvbAutAcc(pBookNum: Str5; pValue: boolean);
begin
  If pValue
    then WriteString ('SVB',pBookNum,'SvbAutAcc',cOn)
    else WriteString ('SVB',pBookNum,'SvbAutAcc',cOff);
end;

procedure TKey.WriteSvbWriSha(pBookNum: Str5; pValue: boolean);
begin
  If pValue
    then WriteString ('SVB',pBookNum,'SvbWriSha',cOn)
    else WriteString ('SVB',pBookNum,'SvbWriSha',cOff);
end;

procedure TKey.WriteSvbAccNeg(pBookNum: Str5; pValue: boolean);
begin
  If pValue
    then WriteString ('SVB',pBookNum,'SvbAccNeg',cOn)
    else WriteString ('SVB',pBookNum,'SvbAccNeg',cOff);
end;

procedure TKey.WriteSvbDocAnl(pBookNum: Str5; pValue: Str6);
begin
  WriteString ('SVB',pBookNum,'SvbDocAnl',pValue);
end;

procedure TKey.WriteSvbDocSnt(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('SVB',pBookNum,'SvbDocSnt',pValue);
end;

procedure TKey.WriteSvbDvzNam(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('SVB',pBookNum,'SvbDvzNa',pValue);
end;

procedure TKey.WriteSvbExnFrm(pBookNum: Str5; pValue: Str12);
begin
  WriteString ('SVB',pBookNum,'SvbExnFrm',pValue);
end;

procedure TKey.WriteSvbWriNum(pBookNum: Str5; pValue: word);
begin
  WriteString ('SVB',pBookNum,'SvbWriNum',StrInt(pValue,0));
end;

procedure TKey.WriteSvbVatAnl(pBookNum: Str5; pValue: Str6);
begin
  WriteString ('SVB',pBookNum,'SvbVatAnl',pValue);
end;

procedure TKey.WriteSvbVatSnt(pBookNum: Str5; pValue: Str3);
begin
  WriteString ('SVB',pBookNum,'SvbVatSnt',pValue);
end;

// ********************************** IDB **************************************

function TKey.ReadIdbWriNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('IDB',pBookNum,'IdbWriNum','0'));
end;

procedure TKey.WriteIdbWriNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('IDB',pBookNum,'IdbWriNum',StrInt(pValue,0));
end;

function TKey.ReadIdbWriAdd(pBookNum:Str5):boolean;
begin
  Result := ReadString('IDB',pBookNum,'IdbWriAdd',cOn)=cOn;
end;

procedure TKey.WriteIdbWriAdd(pBookNum:Str5;pValue:Boolean);
begin
  If pValue
    then WriteString ('IDB',pBookNum,'IdbWriAdd',cOn)
    else WriteString ('IDB',pBookNum,'IdbWriAdd',cOff);
end;

function TKey.ReadIdbAutAcc(pBookNum:Str5):boolean;
begin
  Result := ReadString('IDB',pBookNum,'IdbAutAcc',cOn)=cOn;
end;

procedure TKey.WriteIdbAutAcc(pBookNum:Str5;pValue:Boolean);
begin
  If pValue
    then WriteString ('IDB',pBookNum,'IdbAutAcc',cOn)
    else WriteString ('IDB',pBookNum,'IdbAutAcc',cOff);
end;

// ********************************** ACB **************************************

function TKey.ReadAcbPlsNum(pBookNum:Str5):word;
begin
  Result := ValInt(ReadString('ACB',pBookNum,'AcbPlsNum','0'));
end;

procedure TKey.WriteAcbPlsNum(pBookNum:Str5;pValue:word);
begin
  WriteString ('ACB',pBookNum,'AcbPlsNum',StrInt(pValue,0));
end;

function TKey.ReadAcbRndTyp(pBookNum:Str5):integer;
begin
  Result := ValInt(ReadString('ACB',pBookNum,'AcbRndTyp','0'));
end;

procedure TKey.WriteAcbRndTyp(pBookNum:Str5;pValue:integer);
begin
  WriteString ('ACB',pBookNum,'AcbRndTyp',IntToStr(pValue));
end;

function TKey.ReadAcbPrnMor:boolean;
begin
  Result := ReadString('ACB','','AcbPrnMor',cOff)=cOn;
end;

procedure TKey.WriteAcbPrnMor(pValue:boolean);
begin
  If pValue
    then WriteString ('ACB','','AcbPrnMor',cOn)
    else WriteString ('ACB','','AcbPrnMor',cOff)
end;

end.
{MOD 1806011}
{MOD 1809006}
{MOD 1810003} {MOD 1810006}
{MOD 1901005} {MOD 1901015}
{MOD 1902017}
{MOD 1904015}
{MOD 1905021}
{MOD 1905024}

