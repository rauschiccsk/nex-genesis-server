unit EasFnc;

interface

uses
  Tcd, Icd, Bok,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexPath, NexClc, NexGlob, LinLst, DocFnc, Rep, Cnt, ArpFnc, EmdFnc, Shm_ColDat,
  ePERLST, eEASLST, eEASDEF, tEASDEF, tEASUSR,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TEasFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oArp:TArpFnc;
    ohPERLST:TPerlstHne;  // Zoznam osÙb
    ohEASLST:TEaslstHne;  // AutomatickÈ emailovÈ spr·vy
    ohEASDEF:TEasdefHne;  // DefinÌcia komu odoslaù spr·vu
    otEASDEF:TEasdefTmp;  // DefinÌcia komu odoslaù spr·vu - pre vybran˙ spr·vu
    otEASUSR:TEasusrTmp;  // Zoznam uûÌvateæov, ktorÌm bude osolan· spr·va - pre vybran˝ report
    procedure AddNewDat;  // Prida novÈ reporty, ktorÈ nie s˙ v zozname
    procedure ClrEasDef;  // Vymaûe poloûky z doËasnÈho s˙boru
    procedure LodEasDef(pEasCod:Str9); // Na z·klade zadanÈho reùazca vytvorÌ definiËn˝ zoznam
    procedure SndIntEml(pEasCod:Str9;pAtdNam:Str30);  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
    procedure SndExtEml(pTrgEml:Str30;pSubjec:Str100;pParNum:longint;pParNam:Str60;pExtNum:Str12;pDocDte:TDate;pAtdNam:Str30;pEmlMsk:Str20);  // Poöle exetrn˙ spr·vu pre zadan˝ kontakt

    procedure OsdDlyDlv;  // Meökaj˙ce dod·vky a nezadanÈ termÌny dod·vok od od·vateæov - na internÈ ˙Ëely
    procedure OsdChgRat;  // Dod·vateæom zmenenÈ termÌny na internÈ ˙Ëely
    procedure OsdImpRat;  // ImportovanÈ zmenenÈ termÌny dod·vateæov
    procedure OcdDlyDlv;  // Meökaj˙ce dod·vky pre z·kaznÌkov na internÈ ˙Ëely
    procedure OcdUndReq;  // NesplniteænÈ poûadovanÈ termÌny na internÈ ˙Ëely
    procedure OcdDlyReq;  // Dlhodobo nerieöenÈ z·kaznÌcke poûiadavky na internÈ ˙Ëely
    procedure OspDlyDlv;  // Meökaj˙ce dod·vky a nezadanÈ termÌny dod·vok osobitne pre kaûdÈho dod·vateæa
    procedure OcpChgSnd;  // Odoslanie zmenen˝ch z·kaziek osobitne pre kaûdÈho odberateæa
    procedure ShmColDat;  // Zber ˙dajov predaja do ötatistiky
    procedure TcpNicTcd(pParNum:longint;pSndDte:TDateTime);  // NevyfakturovanÈ dod·vky z·kaznÌka za aktu·lny deÚ
    procedure IcpNewIcd(pParNum:longint;pSndDte:TDateTime);  // VystavenÈ fakt˙ry pre z·kaznÌka za aktu·lny deÚ
  end;

implementation

constructor TEasFnc.Create;
begin
  ohPERLST:=TPerlstHne.Create;
  ohEASLST:=TEaslstHne.Create;
  ohEASDEF:=TEasdefHne.Create;
  otEASDEF:=TEasdefTmp.Create;
  otEASUSR:=TEasusrTmp.Create;
  oArp:=TArpFnc.Create;
end;

destructor TEasFnc.Destroy;
begin
  FreeAndNil(oArp);
  FreeAndNil(otEASUSR);
  FreeAndNil(otEASDEF);
  FreeAndNil(ohEASDEF);
  FreeAndNil(ohEASLST);
  FreeAndNil(ohPERLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TEasFnc.AddNewDat;  // Prida novÈ reporty, ktorÈ nie s˙ v zozname
var mEasDef:TLinLst; mEasNum:word;  mEasCod:Str9;  mEasDes:Str200;
begin
  If FileExists(gPath.SysPath+'easlst.sys') then begin
    mEasDef:=TLinLst.Create;
    mEasDef.oLinLst.LoadFromFile(gPath.SysPath+'easlst.sys');
    If mEasDef.Count>0 then begin
      mEasDef.First;
      Repeat
        mEasCod:=LineElement(mEasDef.Itm,0,';');
        mEasDes:=LineElement(mEasDef.Itm,1,';');
        If not ohEASLST.LocEasCod(mEasCod) then begin
          ohEASLST.SwapIndex;
          ohEASLST.SetIndex('EasNum');
          ohEASLST.Last;
          mEasNum:=ohEASLST.EasNum+1;
          ohEASLST.RestIndex;
          ohEASLST.Insert;
          ohEASLST.EasNum:=mEasNum;
          ohEASLST.EasCod:=mEasCod;
          ohEASLST.EasDes:=mEasDes;
          ohEASLST.Post;
        end;
        mEasDef.Next;
      until mEasDef.Eof;
    end;
    FreeAndNil(mEasDef);
    DeleteFile(gPath.SysPath+'easlst.sys');
  end;
end;

procedure TEasFnc.ClrEasDef;  // Vymaûe poloûky z doËasnÈho s˙boru
begin
  If not otEASDEF.Active then otEASDEF.Open;
  If otEASDEF.Count>0 then begin
    otEASDEF.First;
    Repeat
      otEASDEF.Delete;
    until otEASDEF.Count=0;
    otEASDEF.TmpTable.Refresh;
    Application.ProcessMessages;
  end;
end;

procedure TEasFnc.LodEasDef(pEasCod:Str9); // Na z·klade zadanÈho reùazca vytvorÌ definiËn˝ zoznam
begin
  ClrEasDef;
  If ohEASDEF.LocEasCod(pEasCod) then begin
    Repeat
      otEASDEF.Insert;
      BTR_To_PX(ohEASDEF.Table,otEASDEF.TmpTable);
      If (ohEASDEF.EasTyp='U') and (ohPERLST.LocPerNum(ohEASDEF.EasIdn)) then begin
        otEASDEF.EasNam:=ohPERLST.PerNam;
        otEASDEF.EmlAdr:=ohPERLST.EmlAdr;
      end;
      otEASDEF.Post;
      Application.ProcessMessages;
      ohEASDEF.Next;
    until ohEASDEF.Eof or (ohEASDEF.EasCod<>pEasCod);
  end;
end;

procedure TEasFnc.SndIntEml(pEasCod:Str9;pAtdNam:Str30);  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
var mEmd:TEmdFnc;  mEmdNum:longint;
begin
  LodEasDef(pEasCod); // Na z·klade zadanÈho reùazca vytvorÌ definiËn˝ zoznam
  If ohEASLST.LocEasCod(pEasCod) then begin
    If otEASDEF.Count>0 then begin
      otEASDEF.First;
      Repeat
        // VytvorÌme z·znam pre emailov˝ server
        mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
        mEmd:=TEmdFnc.Create;
        mEmd.ohEMDLST.Insert;
        mEmd.ohEMDLST.EmdNum:=mEmdNum;
        mEmd.ohEMDLST.SndNam:='Administr·tor systÈmu';
        mEmd.ohEMDLST.SndAdr:=ohEASLST.SndEml;
        mEmd.ohEMDLST.TrgAdr:=otEASDEF.EmlAdr;
        mEmd.ohEMDLST.HidAdr:=ohEASLST.CpyEml;
        mEmd.ohEMDLST.Subjec:=ohEASLST.EasDes;
        mEmd.ohEMDLST.ParNum:=0;
        mEmd.ohEMDLST.ParNam:=gvSys.FirmaName;
        mEmd.ohEMDLST.CrtDte:=Date;
        mEmd.ohEMDLST.CrtTim:=Time;
        mEmd.ohEMDLST.AtdDoq:=0;       // PoËet pripojen˝ch prÌlohov˝ch dokumentov
        mEmd.ohEMDLST.ErrSta:='P';     // PrÌznak, ûe treba pripojiù prilohu
        mEmd.ohEMDLST.SndSta:='P';
        mEmd.ohEMDLST.Post;
        mEmd.SavAtd(mEmdNum,pAtdNam);
        mEmd.CrtEmd(mEmdNum);
        FreeAndNil(mEmd);
        Application.ProcessMessages;
        otEASDEF.Next;
      until otEASDEF.Eof;
    end;
  end else ; // TODO - ChybovÈ hl·senie ûe z·znam neboln·jden˝
end;

procedure TEasFnc.SndExtEml(pTrgEml:Str30;pSubjec:Str100;pParNum:longint;pParNam:Str60;pExtNum:Str12;pDocDte:TDate;pAtdNam:Str30;pEmlMsk:Str20);  // Poöle exetrn˙ spr·vu pre zadan˝ kontakt
var mEmd:TEmdFnc;  mEmdNum:longint;
begin
  mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
  mEmd:=TEmdFnc.Create;
  mEmd.ohEMDLST.Insert;
  mEmd.ohEMDLST.EmdNum:=mEmdNum;
  If pTrgEml<>''
    then mEmd.ohEMDLST.TrgAdr:=pTrgEml
    else mEmd.ohEMDLST.TrgAdr:=ohEASLST.EmpEml;
  mEmd.ohEMDLST.HidAdr:=ohEASLST.CpyEml;
  mEmd.ohEMDLST.SndNam:=gvSys.FirmaName;
  mEmd.ohEMDLST.SndAdr:=ohEASLST.SndEml;
  mEmd.ohEMDLST.Subjec:=pSubjec;
  mEmd.ohEMDLST.ParNum:=pParNum;
  mEmd.ohEMDLST.ParNam:=pParNam;
  mEmd.ohEMDLST.CrtDte:=Date;
  mEmd.ohEMDLST.CrtTim:=Time;
  mEmd.ohEMDLST.AtdDoq:=1;  // PoËet pripojen˝ch prÌlohov˝ch dokumentov
  mEmd.ohEMDLST.ErrSta:='P';  // PrÌznak, ûe treba pripojiù prilohu
  mEmd.ohEMDLST.EmlMsk:=pEmlMsk;
  mEmd.ohEMDLST.SndSta:='P';
  mEmd.ohEMDLST.Post;
  mEmd.AddVar('ParNum',StrInt(pParNum,0));
  mEmd.AddVar('ExtNum',pExtNum);
  mEmd.AddVar('DocDte',StrDate(pDocDte));
  mEmd.SavAtd(mEmdNum,pAtdNam);
  mEmd.CrtEmd(mEmdNum);
  FreeAndNil(mEmd);
end;

procedure TEasFnc.OsdDlyDlv;  // Meökaj˙ce dod·vky od od·vateæov na internÈ ˙Ëely
var mDoc:TDocFnc; mRep:TRep;
begin
  If ohEASLST.LocEasCod('OsdDlyDlv') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOsd do begin
      If ohOSILST.LocItmSta('O') then begin
        otOSILST.Open;
        Repeat
          If (ohOSILST.SndDte>0) and (ohOSILST.RatDte<Date) then begin
            otOSILST.Insert;
            BTR_To_PX(ohOSILST.Table,otOSILST.TmpTable);
            If ohOSILST.RatDte=0
              then otOSILST.DlyDay:=Trunc(Date)-Trunc(ohOSILST.DocDte)
              else otOSILST.DlyDay:=Trunc(Date)-Trunc(ohOSILST.RatDte);
            If mDoc.oPar.ohPARCAT.LocParNum(ohOSILST.ParNum) then otOSILST.ParNam:=mDoc.oPar.ohPARCAT.ParNam;
            otOSILST.Post;
          end;
          Application.ProcessMessages;
          ohOSILST.Next;
        until ohOSILST.Eof or (ohOSILST.ItmSta<>'O');
        If otOSILST.Count>0 then begin // Boli n·jdenÈ meökaj˙ce dodv·ky
          otOSILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- TlaË dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OSD-DLY-DLV',0,'SOLIDSTAV OBCHODN¡ s.r.o.',gvSys.LoginName,'OSDDLY','Q01','Dod·vateæskÈ objedn·vky - meökaj˙ce dod·vky a nezadanÈ termÌny');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOSILST.TmpTable;
          mRep.ExecuteQuick('OSDDLY','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //        mRep.Execute('OSDDLY',oArp.ohARPHIS.PdfNam);  // Zapn˙ù ak chceme zmeniù tlaËov˙ masku
          FreeAndNil(mRep);
          oArp.PdfPrnVer;
          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OsdDlyDlv',oArp.ohARPHIS.PdfNam+'.PDF');  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
        end;
        otOSILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OsdChgRat;  // Dod·vateæom zmenenÈ termÌny na internÈ ˙Ëely
var mDoc:TDocFnc; mRep:TRep;
begin
  If ohEASLST.LocEasCod('OsdChgRat') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOsd do begin
      If ohOSILST.LocItmSta('O') then begin
        otOSILST.Open;
        Repeat
          If (ohOSILST.SndDte>0) and (ohOSILST.RatChg>0) and (ohOSILST.RatPrv>0) and (ohOSILST.RatDte<>ohOSILST.RatPrv) then begin
            ohOSILST.Edit;
            ohOSILST.Notice:='CHG';
            ohOSILST.RatChg:=0;
            ohOSILST.Post;
            otOSILST.Insert;
            BTR_To_PX(ohOSILST.Table,otOSILST.TmpTable);
            otOSILST.DlyDay:=Trunc(ohOSILST.RatDte)-Trunc(ohOSILST.RatPrv);
            If mDoc.oPar.ohPARCAT.LocParNum(ohOSILST.ParNum) then otOSILST.ParNam:=mDoc.oPar.ohPARCAT.ParNam;
            otOSILST.Post;
          end;
          Application.ProcessMessages;
          ohOSILST.Next;
        until ohOSILST.Eof or (ohOSILST.ItmSta<>'O');
        If otOSILST.Count>0 then begin // Boli n·jdenÈ meökaj˙ce dodv·ky
          otOSILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- TlaË dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OSD-CHG-RAT',0,'SOLIDSTAV OBCHODN¡ s.r.o.',gvSys.LoginName,'OSDCHG','Q01','Dod·vateæskÈ objedn·vky - zmenenÈ termÌny dod·vok');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOSILST.TmpTable;
          mRep.ExecuteQuick('OSDCHG','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //        mRep.Execute('OSDCHG',oArp.ohARPHIS.PdfNam);  // Zapn˙ù ak chceme zmeniù tlaËov˙ masku
          FreeAndNil(mRep);
          oArp.PdfPrnVer;
          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OsdChgRat',oArp.ohARPHIS.PdfNam+'.PDF');  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
        end;
        otOSILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OsdImpRat;  // ImportovanÈ zmenenÈ termÌny dod·vateæov
var mDoc:TDocFnc; mRep:TRep;
begin
  If ohEASLST.LocEasCod('OsdImpRat') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOsd do begin
      ohOSRHIS.Table.Filter:='['+ohOSRHIS.FieldNum('SndSta')+']={W}';
      ohOSRHIS.Table.Filtered:=TRUE;
      // -------------------------------------------------------------- TlaË dokladu --------------------------------------------------------------------------
      oArp.AddArpHis('IR','OSD-IMP-RAT',0,'SOLIDSTAV OBCHODN¡ s.r.o.',gvSys.LoginName,'OSDIMP','Q01','ImportovanÈ zmenenÈ termÌny dod·vateæov');
      mRep:=TRep.Create(Application);
      mRep.ItmBtr:=ohOSRHIS.Table;
      mRep.ExecuteQuick('OSRIMP','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //    mRep.Execute('OSRIMP',oArp.ohARPHIS.PdfNam);  // Zapn˙ù ak chceme zmeniù tlaËov˙ masku
      FreeAndNil(mRep);
      SndIntEml('OsdImpRat',oArp.ohARPHIS.PdfNam+'.PDF');  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
      SetOsrSnd; // ZruöÌ prÌznkay Ëakania na odoslanie internej spr·vy
    end;
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OspDlyDlv;  // Meökaj˙ce dod·vky osobitne pre kaûdÈho dod·vateæa
var mDoc:TDocFnc; mPar:TLinLst; mRep:TRep;  mParNum:longint;  mParNam:Str60;
begin
  If ohEASLST.LocEasCod('OspDlyDlv') then begin
    mDoc:=TDocFnc.Create;
    mPar:=TLinLst.Create;
    With mDoc.oOsd do begin
      // VytvorÌme zoznam dod·vateæov, komu budeme posielaù v˝kazy
      If ohOSILST.LocItmSta('O') then begin
        Repeat
          If (ohOSILST.SndDte>0) and (ohOSILST.RatDte<Date) then begin
            If not mPar.LocItm(StrInt(ohOSILST.ParNum,0)) then mPar.AddItm(StrInt(ohOSILST.ParNum,0));
          end;
          Application.ProcessMessages;
          ohOSILST.Next;
        until ohOSILST.Eof or (ohOSILST.ItmSta<>'O');
      end;
      // Ak boli n·jdenÈ nejakÈ poloûky pre kaûdÈho dod·vateæa odoöleme emailov˙ spr·vu
      If mPar.Count>0 then begin // M·me komu poslaù
        mPar.First;
        Repeat
          mParNum:=ValInt(mPar.Itm);
          If mDoc.oPar.ohPARCAT.LocParNum(mParNum) then begin
            mParNam:=mDoc.oPar.ohPARCAT.ParNam;
            If ohOSILST.LocItmSta('O') then begin
              otOSILST.Open;
              Repeat
                If (ohOSILST.ParNum=mParNum) and (ohOSILST.SndDte>0) and (ohOSILST.RatDte>0) and (ohOSILST.RatDte<>0) and (ohOSILST.RatDte<Date) then begin
                  otOSILST.Insert;
                  BTR_To_PX(ohOSILST.Table,otOSILST.TmpTable);
                  otOSILST.ParNam:=mDoc.oPar.ohPARCAT.ParNam;
                  If ohOSILST.RatDte=0
                    then otOSILST.DlyDay:=Trunc(Date)-Trunc(ohOSILST.DocDte)
                    else otOSILST.DlyDay:=Trunc(Date)-Trunc(ohOSILST.RatDte);
                  otOSILST.Post;
                end;
                Application.ProcessMessages;
                ohOSILST.Next;
              until ohOSILST.Eof or (ohOSILST.ItmSta<>'O');
              If otOSILST.Count>0 then begin // Boli n·jdenÈ meökaj˙ce dodv·ky
                otOSILST.SetIndex('PaDnIn');
                // ----------------------- TlaË dokladu (OCDBAS) -------------------------
                oArp.AddArpHis('ER','OSP-DLY-DLV',mParNum,mParNam,gvSys.LoginName,'OSPDLY','Q01','Meökaj˙ce dod·vky od dod·vateæa');
                mRep:=TRep.Create(Application);
                mRep.ItmTmp:=otOSILST.TmpTable;
                mRep.ExecuteQuick('OSPDLY','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //              mRep.Execute('OSPDLY',oArp.ohARPHIS.PdfNam);  // Zapn˙ù ak chceme zmeniù tlaËov˙ masku
                FreeAndNil(mRep);
                oArp.PdfPrnVer;
                If (oArp.ohARPHIS.PdfSta='A') then SndExtEml(mDoc.oPar.ohPARCAT.RegEml,'Meökaj˙ce dod·vky',mParNum,mParNam,'',0,oArp.ohARPHIS.PdfNam+'.PDF','ospdly.html')   // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
              end;
              otOSILST.Close;
            end;
          end;
          Application.ProcessMessages;
          mPar.Next;
        until mPar.Eof;
      end;
    end;
    FreeAndNil(mPar);
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OcdDlyDlv;  // Meökaj˙ce dod·vky pre z·kaznÌkov na internÈ ˙Ëely
var mDoc:TDocFnc; mRep:TRep;
begin
//  If ohEASLST.LocEasCod('OcdDlyDlv') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOcd do begin
      If ohOCILST.LocUndSta('U') then begin
        otOCILST.Open;
        Repeat
          If (ohOCILST.UndPrq>0) and (ohOCILST.ReqDte<>0) and (ohOCILST.ReqDte<>ohOCILST.DocDte) and (ohOCILST.ReqDte<Date) then begin
            otOCILST.Insert;
            BTR_To_PX(ohOCILST.Table,otOCILST.TmpTable);
            otOCILST.DlyDay:=Trunc(Date)-Trunc(ohOCILST.ReqDte);
            If mDoc.oPar.ohPARCAT.LocParNum(ohOCILST.ParNum) then otOCILST.ParNam:=mDoc.oPar.ohPARCAT.ParNam;
            otOCILST.Post;
          end;
          If (ohOCILST.RstPrq>0) and ((ohOCILST.ReqDte=0) or (ohOCILST.ReqDte=ohOCILST.DocDte)) then begin // PrÌpad ak nie je zadan˝ termÌn ale tovar je na sklade (Tiket:7075)
            otOCILST.Insert;
            BTR_To_PX(ohOCILST.Table,otOCILST.TmpTable);
            otOCILST.TmpTable.FieldByName('ReqDte').AsString:='';
            otOCILST.TmpTable.FieldByName('DlyDay').AsString:='';
            If mDoc.oPar.ohPARCAT.LocParNum(ohOCILST.ParNum) then otOCILST.ParNam:=mDoc.oPar.ohPARCAT.ParNam;
            otOCILST.Post;
          end;
          Application.ProcessMessages;
          ohOCILST.Next;
        until ohOCILST.Eof or (ohOCILST.UndSta<>'U');
        If otOCILST.Count>0 then begin // Boli n·jdenÈ meökaj˙ce dodv·ky
          otOCILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- TlaË dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OCD-DLY-DLV',0,'SOLIDSTAV OBCHODN¡ s.r.o.',gvSys.LoginName,'OCDDLY','Q01','OdberateæskÈ z·kazky - meökaj˙ce dod·vky pre z·kaznÌkov');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOCILST.TmpTable;
//          mRep.ExecuteQuick('OCDDLY','PDFCreator',oArp.ohARPHIS.PdfNam,1);
          mRep.Execute('OCDDLY',oArp.ohARPHIS.PdfNam);  // Zapn˙ù ak chceme zmeniù tlaËov˙ masku
          FreeAndNil(mRep);
//          oArp.PdfPrnVer;
//          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OcdDlyDlv',oArp.ohARPHIS.PdfNam+'.PDF');  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
        end;
        otOCILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
//  end;
end;

procedure TEasFnc.OcdUndReq;  // NesplniteænÈ poûadovanÈ termÌny na internÈ ˙Ëely
var mDoc:TDocFnc; mRep:TRep;   mNowDlv:boolean;
begin
//  If ohEASLST.LocEasCod('OcdUndReq') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOcd do begin
      If ohOCILST.LocUndSta('U') then begin
        otOCILST.Open;
        Repeat
          mNowDlv:= (ohOCILST.ReqDte=0) or (ohOCILST.ReqDte=ohOCILST.DocDte); // Dodaù ihneÔ
          If (ohOCILST.UndPrq>0) and not mNowDlv then begin // Len vtedy ak nieËo je na dodanie a nie je to odadanie IHNEœ
            If (ohOCILST.ReqDte<ohOCILST.RatDte) or (ohOCILST.ReqDte<Date) then begin
              otOCILST.Insert;
              BTR_To_PX(ohOCILST.Table,otOCILST.TmpTable);
              otOCILST.DlyDay:=Trunc(Date)-Trunc(ohOCILST.ReqDte);
              If mDoc.oPar.ohPARCAT.LocParNum(ohOCILST.ParNum) then otOCILST.ParNam:=mDoc.oPar.ohPARCAT.ParNam;
              otOCILST.Post;
            end;
          end;
          Application.ProcessMessages;
          ohOCILST.Next;
        until ohOCILST.Eof or (ohOCILST.UndSta<>'U');
        If otOCILST.Count>0 then begin // Boli n·jdenÈ meökaj˙ce dodv·ky
          otOCILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- TlaË dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OCD-UND-REQ',0,'SOLIDSTAV OBCHODN¡ s.r.o.',gvSys.LoginName,'OCDUND','Q01','OdberateæskÈ z·kazky - nesplniteænÈ poûadovanÈ termÌny');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOCILST.TmpTable;
//          mRep.ExecuteQuick('OCDUND','PDFCreator',oArp.ohARPHIS.PdfNam,1);
          mRep.Execute('OCDUND',oArp.ohARPHIS.PdfNam);  // Zapn˙ù ak chceme zmeniù tlaËov˙ masku
          FreeAndNil(mRep);
//          oArp.PdfPrnVer;
//          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OcdUndReq',oArp.ohARPHIS.PdfNam+'.PDF');  // Poöle intern˙ spr·vu pre kaûdej osoby, ktÈ s˙ nastavenÈ pre dan˝ v˝kaz
        end;
        otOCILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
//  end;
end;

procedure TEasFnc.OcdDlyReq;  // Dlhodobo nerieöenÈ z·kaznÌcke poûiadavky na internÈ ˙Ëely
begin
  If ohEASLST.LocEasCod('OcdDlyReq') then begin

  end;
end;

procedure TEasFnc.OcpChgSnd; // Odoslanie zmenen˝ch z·kaziek osobitne pre kaûdÈho odberateæa
var mDoc:TDocFnc; mRep:TRep;   mNowDlv:boolean;
begin
(*
  If ohEASLST.LocEasCod('OcpChgSnd') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOcd do begin
      If ohOCHLST.LocDstMod('M') then begin
        Repeat
          oArp.AddArpHis('ZK',ohOCHLST.DocNum,ohOCHLST.ParNum,ohOCHLST.ParNam,gvSys.LoginName,'OCDBAS','Q11','Stav z·kaznÌckej objedn·vky');
          SndExtEml(ohOCHLST.CtpEml,'Stav z·kaznÌckej objedn·vky',ohOCHLST.ParNum,ohOCHLST.ParNam,ohOCHLST.ExtNum,ohOCHLST.DocDte,oArp.ohARPHIS.PdfNam+'.PDF','ocdmod.html');
          ClrModSta(ohOCHLST.DocNum);
          Application.ProcessMessages;
          ohOCHLST.Next;
        until ohOCHLST.Eof or (ohOCHLST.DstMod<>'M');
      end;
    end;
  end;
*)
end;

procedure TEasFnc.ShmColDat;  // Zber ˙dajov predaja do ötatistiky
var mColDat:TShmColDat;
begin
  mColDat:=TShmColDat.Create(Application);
  mColDat.Show;
  mColDat.A_RunExecute(nil);
  FreeAndNil(mColDat);
end;

procedure TEasFnc.TcpNicTcd(pParNum:longint;pSndDte:TDateTime);  // NevyfakturovanÈ dod·vky z·kaznÌka za aktu·lny deÚ
var mParLst:TLinLst; mTcdLst:TLinLst; mParNum:longint;  mParNam:Str60;  mTcd:TTcd;  mDoc:TDocFnc;  mEmlAdr:Str30;  mEmd:TEmdFnc;  mEmdNum:longint;
begin
  If ohEASLST.LocEasCod('TcpNicTcd') then begin
    mTcd:=TTcd.Create(Application);
    mParLst:=TLinLst.Create;
    mTcdLst:=TLinLst.Create;
    With mTcd do begin
      If pParNum=0 then begin
        gBok.LoadBoks('TCB','');
        If gBok.otBOKLST.Count>0 then begin
          gBok.otBOKLST.First;
          Repeat
            Open(gBok.otBOKLST.BokNum);
  //          ohTCH.NearestDocDate(pSndDte);
  //          If (ohTCH.DocDate=pSndDte)then begin
            If ohTCH.LocateDocDate(pSndDte) then begin
              Repeat
                If (ohTCH.IcdNum='') and (ohTCH.ItmQnt>0) and not mParLst.LocItm(StrInt(ohTCH.PaCode,0)) then mParLst.AddItm(StrInt(ohTCH.PaCode,0));
                ohTCH.Next;
              until ohTCH.Eof or (ohTCH.DocDate<>pSndDte);
            end;
            Application.ProcessMessages;
            gBok.otBOKLST.Next;
          until gBok.otBOKLST.Eof;
        end;
      end else mParLst.AddItm(Strint(pParNum,0));
      If mParLst.Count>0 then begin
        mDoc:=TDocFnc.Create;
        With mDoc do begin
          mParLst.First;
          Repeat
            mParNum:=ValInt(mParLst.Itm);
            If (mParNum>0) and oPar.ohPARCAT.LocParNum(mParNum) then begin
              mTcdlst.Clear;
              gBok.LoadBoks('TCB','');
              If gBok.otBOKLST.Count>0 then begin
                gBok.otBOKLST.First;
                Repeat
                  Open(gBok.otBOKLST.BokNum);
                  If ohTCH.LocatePaCode(mParNum) then begin
                    Repeat
                      If (ohTCH.DocDate=pSndDte) and (ohTCH.IcdNum='') and (ohTCH.ItmQnt>0) then begin  // TlaË odberateæsk˝ch dodacÌch listov
                        oArp.AddArpHis('',ohTCH.DocNum,ohTCH.PaCode,ohTCH.PaName,gvSys.LoginName,'TCPNIC','Q01','Zoznam nevyfakturovanÈho odobranÈho tovaru zo dÚa '+DateToStr(pSndDte));
                        PrnPdfDoc(ohTCH.DocNum,'TCD.Q01',oArp.ohARPHIS.PdfNam);  // TlaË adanÈho dokladu do PDF s˙boru  // TODO n·zov tlaËovej masky do vlastnosti
                        oArp.PdfPrnVer;
                        If oArp.ohARPHIS.PdfSta='A' then mTcdLst.AddItm(oArp.ohARPHIS.PdfNam);
                      end;
                      ohTCH.Next;
                    until ohTCH.Eof or (ohTCH.PaCode<>mParNum);
                  end;
                  Application.ProcessMessages;
                  gBok.otBOKLST.Next;
                until gBok.otBOKLST.Eof;
              end;
              If mTcdLst.Count>0 then begin // PripravÌme Email pre danÈho z·kaznÌka
                mEmlAdr:=oPar.ohPARCAT.RegEml;
                If mEmlAdr='' then mEmlAdr:=ohEASLST.EmpEml;
                mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
                mEmd:=TEmdFnc.Create;
                mEmd.ohEMDLST.Insert;
                mEmd.ohEMDLST.EmdNum:=mEmdNum;
                mEmd.ohEMDLST.SndNam:=gvSys.FirmaName;
                mEmd.ohEMDLST.SndAdr:=ohEASLST.SndEml;
                mEmd.ohEMDLST.TrgAdr:=mEmlAdr;
                mEmd.ohEMDLST.HidAdr:=ohEASLST.CpyEml;
                mEmd.ohEMDLST.Subjec:='Zoznam nevyfakturovanÈho odobranÈho tovaru zo dÚa '+DateToStr(Date);
                mEmd.ohEMDLST.ParNum:=mParNum;
                mEmd.ohEMDLST.ParNam:=oPar.ohPARCAT.ParNam;
                mEmd.ohEMDLST.CrtDte:=Date;
                mEmd.ohEMDLST.CrtTim:=Time;
                mEmd.ohEMDLST.AtdDoq:=mTcdLst.Count; // PoËet pripojen˝ch prÌlohov˝ch dokumentov
                mEmd.ohEMDLST.AtdTyp:='OD';
                mEmd.ohEMDLST.ErrSta:='P';  // PrÌznak, ûe treba pripojiù prilohu
                mEmd.ohEMDLST.EmlMsk:='tcpnic.html';
                mEmd.ohEMDLST.SndSta:='P';
                mEmd.ohEMDLST.Post;
                mEmd.AddVar('CurDte',DateToStr(pSndDte));
                // Prid·me prÌlohy
                mTcdLst.First;
                Repeat
                  mEmd.SavAtd(mEmdNum,mTcdLst.Itm+'.PDF');
                  mTcdLst.Next;
                until mTcdLst.Eof;
                mEmd.CrtEmd(mEmdNum);
                FreeAndNil(mEmd);
              end;
            end;
            Application.ProcessMessages;
            mParLst.Next;
          until mParLst.Eof;
        end;
        FreeAndNil(mDoc);
      end;
    end;
    FreeAndNil(mTcdLst);
    FreeAndNil(mParLst);
    FreeAndNil(mTcd);
  end;
end;

procedure TEasFnc.IcpNewIcd;  // VystavenÈ fakt˙ry pre z·kaznÌka za aktu·lny deÚ
var mParLst:TLinLst; mIcdLst:TLinLst; mParNum:longint;  mIcd:TIcd;  mDoc:TDocFnc;  mEmd:TEmdFnc;  mEmdNum:longint;  mEmlAdr:Str30;
begin
  If ohEASLST.LocEasCod('IcpNewIcd') then begin
    mIcd:=TIcd.Create(Application);
    mParLst:=TLinLst.Create;
    mIcdLst:=TLinLst.Create;
    With mIcd do begin
      If pParNum=0 then begin
        gBok.LoadBoks('ICB','');
        If gBok.otBOKLST.Count>0 then begin
          gBok.otBOKLST.First;
          Repeat
            Open(gBok.otBOKLST.BokNum);
  //          ohICH.NearestDocDate(pSndDte);
  //          If (ohICH.DocDate=pSndDte) then begin
            If ohICH.LocateDocDate(pSndDte) then begin
              Repeat
                If IsNotNul(ohICH.FgEndVal)  and not mParLst.LocItm(StrInt(ohICH.PaCode,0)) then mParLst.AddItm(StrInt(ohICH.PaCode,0));
                ohICH.Next;
              until ohICH.Eof or (ohICH.DocDate<>pSndDte);
            end;
            Application.ProcessMessages;
            gBok.otBOKLST.Next;
          until gBok.otBOKLST.Eof;
        end;
      end else mParLst.AddItm(Strint(pParNum,0));
      If mParLst.Count>0 then begin
        mDoc:=TDocFnc.Create;
        With mDoc do begin
          mParLst.First;
          Repeat
            mParNum:=ValInt(mParLst.Itm);
            If (mParNum>0) and oPar.ohPARCAT.LocParNum(mParNum) then begin
              mIcdlst.Clear;
              gBok.LoadBoks('ICB','');
              If gBok.otBOKLST.Count>0 then begin
                gBok.otBOKLST.First;
                Repeat
                  Open(gBok.otBOKLST.BokNum);
                  If ohICH.LocatePaCode(mParNum) then begin
                    Repeat
                      If (ohICH.DocDate=pSndDte) and IsNotNul(ohICH.FgEndVal) then begin
                        oArp.AddArpHis('',ohICH.DocNum,ohICH.PaCode,ohICH.PaName,gvSys.LoginName,'ICD','Q01','Vaöe vystavenÈ fakt˙ry zo dÚa '+DateToStr(pSndDte));
                        PrnDoc(ohICH.DocNum,TRUE,'',oArp.ohARPHIS.PdfNam,1,TRUE); // TlaË adanÈho dokladu do PDF s˙boru
                        oArp.PdfPrnVer;
                        If oArp.ohARPHIS.PdfSta='A' then mIcdLst.AddItm(oArp.ohARPHIS.PdfNam);
                      end;
                      ohICH.Next;
                    until ohICH.Eof or (ohICH.PaCode<>mParNum);
                  end;
                  Application.ProcessMessages;
                  gBok.otBOKLST.Next;
                until gBok.otBOKLST.Eof;
              end;
              If mIcdLst.Count>0 then begin // PripravÌme Email pre danÈho z·kaznÌka
                mEmlAdr:=oPar.ohPARCAT.RegEml;
                If mEmlAdr='' then mEmlAdr:=ohEASLST.EmpEml;
                mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
                mEmd:=TEmdFnc.Create;
                mEmd.ohEMDLST.Insert;
                mEmd.ohEMDLST.EmdNum:=mEmdNum;
                mEmd.ohEMDLST.SndNam:=gvSys.FirmaName;
                mEmd.ohEMDLST.SndAdr:=ohEASLST.SndEml;
                mEmd.ohEMDLST.TrgAdr:=mEmlAdr;
                mEmd.ohEMDLST.HidAdr:=ohEASLST.CpyEml;
                mEmd.ohEMDLST.Subjec:='Vaöe vystavenÈ fakt˙ry za dneön˝ deÚ '+DateToStr(pSndDte);
                mEmd.ohEMDLST.ParNum:=mParNum;
                mEmd.ohEMDLST.ParNam:=oPar.ohPARCAT.ParNam;
                mEmd.ohEMDLST.CrtDte:=Date;
                mEmd.ohEMDLST.CrtTim:=Time;
                mEmd.ohEMDLST.AtdTyp:='OD';
                mEmd.ohEMDLST.ErrSta:='P';  // PrÌznak, ûe treba pripojiù prilohu
                mEmd.ohEMDLST.EmlMsk:='icpnew.html';
                mEmd.ohEMDLST.SndSta:='P';
                mEmd.ohEMDLST.Post;
                mEmd.AddVar('CurDte',DateToStr(pSndDte));
                // Prid·me prÌlohy
                mIcdLst.First;
                Repeat
                  mEmd.SavAtd(mEmdNum,mIcdLst.Itm+'.PDF');
                  mIcdLst.Next;
                until mIcdLst.Eof;
                mEmd.CrtEmd(mEmdNum);
                FreeAndNil(mEmd);
              end;
            end;
            Application.ProcessMessages;
            mParLst.Next;
          until mParLst.Eof;
        end;
        FreeAndNil(mDoc);
      end;
    end;
    FreeAndNil(mIcdLst);
    FreeAndNil(mParLst);
    FreeAndNil(mIcd);
  end;
end;

end.


