unit NexInit;

interface

uses
  NexLgn,
  IcConst, IcTypes, IcVariab, IcText, IcDate, IcConv, TxtCut, DefRgh, BaseUtils,
  Key, Afc, Bok, Plc, Txt, Cnt, TblRef, dmImg, hUSRLST,
  Prp, 
  IniFiles, IcFiles, BtrLst, BtrHand, BtrStruct,
  NexVar, NexText, NexPath, BtrTable, PQRep_, NexIni, QRepH,
  Windows, Forms, Classes, SysUtils;

type
  TReg=class
    constructor Create;
    destructor  Destroy; override;
  private
    oPort: Str4;
    oBaud: Str6;
    oData: Str1;
    oStop: Str1;
    oParit: Str1;
  public
    procedure ReadBcsData; // Nacita udaje portu snimaca ciaroveho kodu
  published
    property Port:Str4 read oPort; // Port ku ktoremu je pripojeny snimac ciaroveho kodu
    property Baud:Str6 read oBaud; // Prenosova rychlost portu ciaroveho kodu
    property Data:Str1 read oData; // Pocet data bytov prenosu portu snimaca ciaroveho kodu
    property Stop:Str1 read oStop; // Pocet stop bytov prenosu portu snimaca ciaroveho kodu
    property Parit:Str1 read oParit; // Parita prenosu portu snimaca ciaroveho kodu
  end;


 procedure DefInitialize; // Inicializuje základné údaje, èo je potrébné pri prihlásení
 procedure NexInitialize(pSndFiles:boolean); // Inicializuje globalne premenne systemu NEX
 procedure LoadGlobalData; // Nacita globalne textove premenne
 procedure DefDestroy; // Uzatvory základné údaje, ktoré boli inicializované pred prihlásením
 procedure NexDestroy; // Uzatvory globalne premenne
// procedure InitRefresh;
 procedure SysDateVerify; // Prekontroluje ci v systemovom adresare existuje SYSDAT.TXT ak ano naimportuje udaje do SYSTEM.BTR

 procedure CloseAllDatabase (pDataModule:TDataModule);

var gReg:TReg;

implementation

uses
    DM_PRNTMP,
  // Nove databaze
    DM_DLSDAT, DM_CPDDAT, DM_STKDAT, DM_LDGDAT, DM_CABDAT, DM_STADAT,
    DM_SYSTEM, DM_PRODPL, DM_PRNDAT, DM_MNGDAT, DM_TIM, DM_TOM, bUSRLST;

constructor TReg.Create;
begin
  oPort:='';
end;

destructor TReg.Destroy;
begin
end;

procedure TReg.ReadBcsData; // Nacita udaje portu snimaca ciaroveho kodu
var mStr:ShortString;  mCut: TTxtCut;
begin
  oPort:='';
  oPort:=GetBcsPort;
  // Nacitame parametre portu snimaca ciaroveho kodu
  If oPort<>'' then begin
    mStr:=GetPortData(oPort);
    mCut:=TTxtCut.Create;
    mCut.SetDelimiter('');
    mCut.SetStr(mStr);
    oBaud:=mCut.GetText(1);
    oData:=mCut.GetText(2);
    oStop:=mCut.GetText(3);
    oParit:=mCut.GetText(4);
    FreeAndNil (mCut);
  end;
end;

// ******************************************************************
procedure DefInitialize;
begin
  gPath:=TPaths.Create;
  gNT:=TNexText.Create;
  gBtr:=TBtrLst.Create;
//*  SetLanguage (GetSysLanguage);
//*  SetActYear (GetSysActYear);
//*  gvSys.SysPath:=gPath.SysPath;
//*  gvSys.ActOrgName :=

  dmSYS:=TdmSYS.Create (Application);
//  gImg:=TdmImg.Create (Application);
end;

procedure SysDateVerify; // Prekontroluje ci v systemovom adresare existuje SYSDAT.TXT ak ano naimportuje udaje do SYSTEM.BTR
var mFileName:string; mSysDat:TIniFile;  mMyPaTin:Str15;
begin
  mFileName:=gPath.SysPath+'SYSDAT.TXT';
  If FileExistsI (mFileName) then begin
    mSysDat:=TIniFile.Create(mFileName);
    mMyPaTin:=mSysDat.ReadString('SYSTEM','SelfTin','');
    If copy(mMyPaTin,1,2)='SK' then Delete(mMyPaTin,1,2);
    If dmSYS.btSYSTEM.RecordCount>0
      then dmSYS.btSYSTEM.Edit
      else dmSYS.btSYSTEM.Insert;
    dmSYS.btSYSTEM.FieldByName ('MyPaIno').AsString:=mSysDat.ReadString('SYSTEM','SelfIno','');
    dmSYS.btSYSTEM.FieldByName ('MyPaTin').AsString:=mMyPaTin;
    dmSYS.btSYSTEM.FieldByName ('MyPaVin').AsString:=mSysDat.ReadString('SYSTEM','SelfTin','');
    dmSYS.btSYSTEM.FieldByName ('MyPaName').AsString:=mSysDat.ReadString('SYSTEM','SelfName','');
    dmSYS.btSYSTEM.FieldByName ('MyPaAddr').AsString:=mSysDat.ReadString('SYSTEM','SelfAddr','');
    dmSYS.btSYSTEM.FieldByName ('MyStaCode').AsString:=mSysDat.ReadString('SYSTEM','SK','');
    dmSYS.btSYSTEM.FieldByName ('MyStaName').AsString:=mSysDat.ReadString('SYSTEM','StaName','');
    dmSYS.btSYSTEM.FieldByName ('MyCtyName').AsString:=mSysDat.ReadString('SYSTEM','CtyName','');
    dmSYS.btSYSTEM.FieldByName ('MyZipCode').AsString:=mSysDat.ReadString('SYSTEM','ZipCode','');
    dmSYS.btSYSTEM.FieldByName ('MyWebSite').AsString:=mSysDat.ReadString('SYSTEM','WebSite','');
    dmSYS.btSYSTEM.FieldByName ('MyTelNum').AsString:=mSysDat.ReadString('SYSTEM','TelNum','');
    dmSYS.btSYSTEM.FieldByName ('MyFaxNum').AsString:=mSysDat.ReadString('SYSTEM','FaxNum','');
    dmSYS.btSYSTEM.FieldByName ('MyEmail').AsString:=mSysDat.ReadString('SYSTEM','Email','');
    dmSYS.btSYSTEM.FieldByName ('MyBaConto').AsString:=mSysDat.ReadString('SYSTEM','ContoNum','');
    dmSYS.btSYSTEM.FieldByName ('MyBaName').AsString:=mSysDat.ReadString('SYSTEM','BankName','');
    dmSYS.btSYSTEM.FieldByName ('MyBaCity').AsString:=mSysDat.ReadString('SYSTEM','BankSeat','');
    dmSYS.btSYSTEM.FieldByName ('MyBaStat').AsString:=mSysDat.ReadString('SYSTEM','StaName','');
    dmSYS.btSYSTEM.FieldByName ('Register').AsString:=mSysDat.ReadString('SYSTEM','Register','');
    dmSYS.btSYSTEM.FieldByName ('MyWriNum').AsInteger:=1;
    dmSYS.btSYSTEM.Post;
    FreeAndNil (mSysDat);
    DeleteFile (PChar(mFileName));
  end;
end;

procedure NexInitialize(pSndFiles:boolean);
var mActOrg:byte; mCut:TTxtCut; mhUSRLST:TusrlstHnd;
begin
  RuningOn;
  gReg:=TReg.Create;
  gPrp:=TPrp.Create;
  gCnt:=TCnt.Create;
  // Nove databaze
  dmSTK:=TdmSTK.Create (Application);
  dmDLS:=TdmDLS.Create (Application);
  dmCAB:=TdmCAB.Create (Application);
  dmPDP:=TdmPDP.Create (Application);
  dmCPD:=TdmCPD.Create (Application);
  dmLDG:=TdmLDG.Create (Application);
  dmMNG:=TdmMNG.Create (Application);
  dmPRN:=TdmPRN.Create (Application);
  dmSTA:=TdmSTA.Create (Application);
  dmTIM:=TdmTIM.Create (Application);
  dmTOM:=TdmTOM.Create (Application);
  dmSYS.btUSRLST.Open;
  dmSYS.btBKUSRG.Open;
  If FileExistsI (gPath.DefPath+'MSGDIS.BDF') then dmSYS.btMSGDIS.Open;
  // Nacitame systemove udaje
  dmSYS.btSYSTEM.Open;
  If pSndFiles then dmSYS.btSNDDEF.Open;
  SysDateVerify; // Prekontroluje ci v systemovom adresare existuje SYSDAT.TXT ak ano naimportuje udaje do SYSTEM.BTR
  gvSys.WriNum:=dmSYS.btSYSTEM.FieldByName ('MyWriNum').AsInteger;
  gvSys.FirmaName:=dmSYS.btSYSTEM.FieldByName ('MyPaName').AsString;
  gvSys.BegGsCode:=dmSYS.btSYSTEM.FieldByName ('BegGsCode').AsInteger;
  gvSys.EndGsCode:=dmSYS.btSYSTEM.FieldByName ('EndGsCode').AsInteger;
  gvSys.BegPaCode:=dmSYS.btSYSTEM.FieldByName ('BegPaCode').AsInteger;
  gvSys.EndPaCode:=dmSYS.btSYSTEM.FieldByName ('EndPaCode').AsInteger;
  gIni:=TNexIni.Create (gPath.SysPath+'NEX.INI');
  gSet:=TNexIni.Create (gPath.SysPath+gvSys.LoginName+'.INI');
//  gFlt:=TFltIni.Create (gPath.SysPath+'FLT_SET.LST');
  gRgh:=TDefRgh.Create;
  gBok:=TBok.Create;
  gAfc:=TAfc.Create;
  gRgh.LoadRight(gvSys.LoginGroup);
  gvSys.DefVatPrc:=gIni.GetVatPrc(gIni.GetDefVatGrp);
  gvSys.AccStk:=gIni.AccStk;
  gvSys.AccWri:=gIni.AccWri;
  gvSys.AccCen:=gIni.AccCen;
  gvSys.MainWri:=gIni.MainWri;
  gvSys.ModToDsc:=gIni.ModToDsc;
  gvSys.EasLdg:=gIni.EasLdg;
  gvSys.SecMgc:=gIni.ServiceMg;
  gStatistic2:=gIni.ReadBool('SYSTEM', 'BtrStatistic',True);
  gBtrErrorLogfile:=gIni.ReadBool('SYSTEM', 'BtrErrorLog',False);
  gIni.WriteBool('SYSTEM', 'BtrStatistic',gStatistic2);
  gIni.WriteBool('SYSTEM', 'BtrErrorLog',gBtrErrorLogfile);
  If gStatistic2 and (ValDoub(dmSYS.btSYSTEM.GetVersion)<9) then gStatistic2:=FALSE;
  cFirmaName:=gvSys.FirmaName;
  cPrintDemo:=FALSE;
  SetDesignMode (gIni.GetDesignMode);
  LoadGlobalData;
  cRepPath:=gPath.RepPath;  // Pre report generator RZ 26.02.2008
  gKey:=TKey.Create;
  gvSys.MaximizeMode:= gKey.SysMaxScr;
  gvSys.StpRndFrc:= gKey.StpRndFrc;
  gvSys.StqRndFrc:= gKey.StqRndFrc;
  gvSys.StvRndFrc:= gKey.StvRndFrc;
  gvSys.InfDvz:=gKey.SysInfDvz;
  gvSys.AccDvz:=gKey.SysAccDvz;
  ctIntCoin:=gKey.SysAccDvz;     // Cele peniaze
  ctFractCoin:=gKey.SysAccDvz;   // Drobne peniaze
  // StatusLine
  ctSLYear:=gvSys.ActYear;
  ctSLFirmaNum:=gvSys.ActOrgNum;
  ctSLFirmaName:=gvSys.FirmaName;
  ctSLUserName:=gvSys.UserName;
  // Nastavime cisleny kód uzivaela      
  If gvSys.UsrNum=0 then begin // Vygenerujeme nové užívate¾ské èíslo
    mhUSRLST:=TusrlstHnd.Create;  mhUSRLST.Open;
    If mhUSRLST.LocateLoginName(gvSys.LoginName) then begin
      mhUSRLST.Edit;
      mhUSRLST.UsrNum:=gKey.Sys.NextUsrNum;
      mhUSRLST.Post;
    end;
    gvSys.UsrNum:=mhUSRLST.UsrNum;
    FreeAndNil(mhUSRLST);
  end;

  gPlc:=TPlc.Create;
  gTblRef:=TTblRefF.Create(Application);
  gTxt:=nil;
end;

procedure DefDestroy;
begin
  FreeAndNil (gTblRef);
  CloseAllDatabase (dmSYS);
  FreeAndNil (dmSYS);
  FreeAndNil (gBtr);
  FreeAndNil (gPath);
  FreeAndNil (gNT);
  If not cUpgrade then FreeAndNil (gKey);
//  FreeAndNil (gImg);
end;

procedure NexDestroy;
begin
  CloseAllDatabase (dmDLS);  FreeAndNil (dmDLS);
  CloseAllDatabase (dmSTK);  FreeAndNil (dmSTK);
  CloseAllDatabase (dmCAB);  FreeAndNil (dmCAB);
  CloseAllDatabase (dmPDP);  FreeAndNil (dmPDP);
  CloseAllDatabase (dmCPD);  FreeAndNil (dmCPD);
  CloseAllDatabase (dmLDG);  FreeAndNil (dmLDG);
  CloseAllDatabase (dmMNG);  FreeAndNil (dmMNG);
  CloseAllDatabase (dmPRN);  FreeAndNil (dmPRN);
  CloseAllDatabase (dmSTA);  FreeAndNil (dmSTA);
  CloseAllDatabase (dmTIM);  FreeAndNil (dmTIM);
  CloseAllDatabase (dmTOM);  FreeAndNil (dmTOM);

//  FreeAndNil (gFlt);
  FreeAndNil (gSet);
  FreeAndNil (gIni);
  FreeAndNil (gAfc);
  FreeAndNil (gBok);
  FreeAndNil (gRgh);
  FreeAndNil (gReg);
  FreeAndNil (gPlc);
  FreeAndNil (gPrp);
  FreeAndNil (gCnt);
  If gTxt<>nil  then FreeAndNil(gTxt);
end;

procedure CloseAllDatabase (pDataModule:TDataModule);
var I: integer;
begin
  If pDataModule<>nil then begin
    For I:=0 to pDataModule.ComponentCount-1 do begin
      // TBtrieveTable
      If (pDataModule.Components[I] is TBtrieveTable) then begin
        If (pDataModule.Components[I] as TBtrieveTable).Active
          then (pDataModule.Components[I] as TBtrieveTable).Close;
      end;
    end;
  end;
end;

procedure LoadGlobalData;
begin
  gNT.SetSection ('GLOBAL');
  ctIntCoin:=gNT.GetText ('IntCoin',ctIntCoin);     { Cele peniaze }
  ctFractCoin:=gNT.GetText ('FractCoin',ctFractCoin);{ Drobne peniaze }
  ctMeasure:=gNT.GetText ('Measure',ctMeasure);     { Oznacenie mernej jednotky }
  ctHour:=gNT.GetText ('Hour',ctHour);  { Oznacenie hodinky }
  ctQuant:=gNT.GetText ('Quant',ctQuant);{ Oznacenie kusoveho mnozstva }
  ctDay:=gNT.GetText ('Day',ctDay);
  ctDays:=gNT.GetText ('Days',ctDays);
  ctMinute:=gNT.GetText ('Minute',ctMinute);

  gvDocIM:=gNT.GetText ('IM.DocumentSymbol','SP');  { Skladove prijemky }
  gvDocOM:=gNT.GetText ('OM.DocumentSymbol','SV');  { Skladove vydajky  }
  gvDocRM:=gNT.GetText ('RM.DocumentSymbol','MP');  { Medziskladovy presun }
  gvDocTS:=gNT.GetText ('TS.DocumentSymbol','DD');  { Dosle dodacie listy }
  gvDocTC:=gNT.GetText ('TC.DocumentSymbol','OD');  { Odoslane dodacie lsity }
  gvDocIS:=gNT.GetText ('IS.DocumentSymbol','DF');  { Dosle faktury }
  gvDocIC:=gNT.GetText ('IC.DocumentSymbol','OF');  { Odoslane faktury }
  gvDocIZ:=gNT.GetText ('IZ.DocumentSymbol','ZF');  { Dosle zalohove faktury }
  gvDocIP:=gNT.GetText ('IP.DocumentSymbol','PF');  { Odoslane zalohove faktury }
  gvDocOS:=gNT.GetText ('OS.DocumentSymbol','OB');  { Dosle objednavky }
  gvDocOC:=gNT.GetText ('OC.DocumentSymbol','ZK');  { Odolane objednavky }
  gvDocIV:=gNT.GetText ('IV.DocumentSymbol','IN');  { Inventarne doklady }
  gvDocTB:=gNT.GetText ('TB.DocumentSymbol','TP');  { Trzby registravnych pokladni }
  gvDocOP:=gNT.GetText ('OP.DocumentSymbol','VZ');  { Vyrobne zakazky }
  gvDocID:=gNT.GetText ('ID.DocumentSymbol','ID');  { Interne uctovne doklady }
  gvDocSA:=gNT.GetText ('SA.DocumentSymbol','BV');  { Bankove vypisy }
  gvDocCI:=gNT.GetText ('CI.DocumentSymbol','PP');  { Prijmove pokladnicne doklady }
  gvDocCE:=gNT.GetText ('CE.DocumentSymbol','PV');  { Vydavkove pokladnicne doklady }
  gvDocSH:=gNT.GetText ('DM.DocumentSymbol','SH');  { Drobny majetok }
  gvDocIH:=gNT.GetText ('HM.DocumentSymbol','IH');  { Hmotny a nehmotny investicnym majetok }
end;

end.
{MOD 1810006}
