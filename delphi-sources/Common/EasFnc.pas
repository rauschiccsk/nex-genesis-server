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
    ohPERLST:TPerlstHne;  // Zoznam os�b
    ohEASLST:TEaslstHne;  // Automatick� emailov� spr�vy
    ohEASDEF:TEasdefHne;  // Defin�cia komu odosla� spr�vu
    otEASDEF:TEasdefTmp;  // Defin�cia komu odosla� spr�vu - pre vybran� spr�vu
    otEASUSR:TEasusrTmp;  // Zoznam u��vate�ov, ktor�m bude osolan� spr�va - pre vybran� report
    procedure AddNewDat;  // Prida nov� reporty, ktor� nie s� v zozname
    procedure ClrEasDef;  // Vyma�e polo�ky z do�asn�ho s�boru
    procedure LodEasDef(pEasCod:Str9); // Na z�klade zadan�ho re�azca vytvor� defini�n� zoznam
    procedure SndIntEml(pEasCod:Str9;pAtdNam:Str30);  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
    procedure SndExtEml(pTrgEml:Str30;pSubjec:Str100;pParNum:longint;pParNam:Str60;pExtNum:Str12;pDocDte:TDate;pAtdNam:Str30;pEmlMsk:Str20);  // Po�le exetrn� spr�vu pre zadan� kontakt

    procedure OsdDlyDlv;  // Me�kaj�ce dod�vky a nezadan� term�ny dod�vok od od�vate�ov - na intern� ��ely
    procedure OsdChgRat;  // Dod�vate�om zmenen� term�ny na intern� ��ely
    procedure OsdImpRat;  // Importovan� zmenen� term�ny dod�vate�ov
    procedure OcdDlyDlv;  // Me�kaj�ce dod�vky pre z�kazn�kov na intern� ��ely
    procedure OcdUndReq;  // Nesplnite�n� po�adovan� term�ny na intern� ��ely
    procedure OcdDlyReq;  // Dlhodobo nerie�en� z�kazn�cke po�iadavky na intern� ��ely
    procedure OspDlyDlv;  // Me�kaj�ce dod�vky a nezadan� term�ny dod�vok osobitne pre ka�d�ho dod�vate�a
    procedure OcpChgSnd;  // Odoslanie zmenen�ch z�kaziek osobitne pre ka�d�ho odberate�a
    procedure ShmColDat;  // Zber �dajov predaja do �tatistiky
    procedure TcpNicTcd(pParNum:longint;pSndDte:TDateTime);  // Nevyfakturovan� dod�vky z�kazn�ka za aktu�lny de�
    procedure IcpNewIcd(pParNum:longint;pSndDte:TDateTime);  // Vystaven� fakt�ry pre z�kazn�ka za aktu�lny de�
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

procedure TEasFnc.AddNewDat;  // Prida nov� reporty, ktor� nie s� v zozname
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

procedure TEasFnc.ClrEasDef;  // Vyma�e polo�ky z do�asn�ho s�boru
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

procedure TEasFnc.LodEasDef(pEasCod:Str9); // Na z�klade zadan�ho re�azca vytvor� defini�n� zoznam
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

procedure TEasFnc.SndIntEml(pEasCod:Str9;pAtdNam:Str30);  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
var mEmd:TEmdFnc;  mEmdNum:longint;
begin
  LodEasDef(pEasCod); // Na z�klade zadan�ho re�azca vytvor� defini�n� zoznam
  If ohEASLST.LocEasCod(pEasCod) then begin
    If otEASDEF.Count>0 then begin
      otEASDEF.First;
      Repeat
        // Vytvor�me z�znam pre emailov� server
        mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
        mEmd:=TEmdFnc.Create;
        mEmd.ohEMDLST.Insert;
        mEmd.ohEMDLST.EmdNum:=mEmdNum;
        mEmd.ohEMDLST.SndNam:='Administr�tor syst�mu';
        mEmd.ohEMDLST.SndAdr:=ohEASLST.SndEml;
        mEmd.ohEMDLST.TrgAdr:=otEASDEF.EmlAdr;
        mEmd.ohEMDLST.HidAdr:=ohEASLST.CpyEml;
        mEmd.ohEMDLST.Subjec:=ohEASLST.EasDes;
        mEmd.ohEMDLST.ParNum:=0;
        mEmd.ohEMDLST.ParNam:=gvSys.FirmaName;
        mEmd.ohEMDLST.CrtDte:=Date;
        mEmd.ohEMDLST.CrtTim:=Time;
        mEmd.ohEMDLST.AtdDoq:=0;       // Po�et pripojen�ch pr�lohov�ch dokumentov
        mEmd.ohEMDLST.ErrSta:='P';     // Pr�znak, �e treba pripoji� prilohu
        mEmd.ohEMDLST.SndSta:='P';
        mEmd.ohEMDLST.Post;
        mEmd.SavAtd(mEmdNum,pAtdNam);
        mEmd.CrtEmd(mEmdNum);
        FreeAndNil(mEmd);
        Application.ProcessMessages;
        otEASDEF.Next;
      until otEASDEF.Eof;
    end;
  end else ; // TODO - Chybov� hl�senie �e z�znam neboln�jden�
end;

procedure TEasFnc.SndExtEml(pTrgEml:Str30;pSubjec:Str100;pParNum:longint;pParNam:Str60;pExtNum:Str12;pDocDte:TDate;pAtdNam:Str30;pEmlMsk:Str20);  // Po�le exetrn� spr�vu pre zadan� kontakt
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
  mEmd.ohEMDLST.AtdDoq:=1;  // Po�et pripojen�ch pr�lohov�ch dokumentov
  mEmd.ohEMDLST.ErrSta:='P';  // Pr�znak, �e treba pripoji� prilohu
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

procedure TEasFnc.OsdDlyDlv;  // Me�kaj�ce dod�vky od od�vate�ov na intern� ��ely
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
        If otOSILST.Count>0 then begin // Boli n�jden� me�kaj�ce dodv�ky
          otOSILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- Tla� dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OSD-DLY-DLV',0,'SOLIDSTAV OBCHODN� s.r.o.',gvSys.LoginName,'OSDDLY','Q01','Dod�vate�sk� objedn�vky - me�kaj�ce dod�vky a nezadan� term�ny');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOSILST.TmpTable;
          mRep.ExecuteQuick('OSDDLY','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //        mRep.Execute('OSDDLY',oArp.ohARPHIS.PdfNam);  // Zapn�� ak chceme zmeni� tla�ov� masku
          FreeAndNil(mRep);
          oArp.PdfPrnVer;
          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OsdDlyDlv',oArp.ohARPHIS.PdfNam+'.PDF');  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
        end;
        otOSILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OsdChgRat;  // Dod�vate�om zmenen� term�ny na intern� ��ely
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
        If otOSILST.Count>0 then begin // Boli n�jden� me�kaj�ce dodv�ky
          otOSILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- Tla� dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OSD-CHG-RAT',0,'SOLIDSTAV OBCHODN� s.r.o.',gvSys.LoginName,'OSDCHG','Q01','Dod�vate�sk� objedn�vky - zmenen� term�ny dod�vok');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOSILST.TmpTable;
          mRep.ExecuteQuick('OSDCHG','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //        mRep.Execute('OSDCHG',oArp.ohARPHIS.PdfNam);  // Zapn�� ak chceme zmeni� tla�ov� masku
          FreeAndNil(mRep);
          oArp.PdfPrnVer;
          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OsdChgRat',oArp.ohARPHIS.PdfNam+'.PDF');  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
        end;
        otOSILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OsdImpRat;  // Importovan� zmenen� term�ny dod�vate�ov
var mDoc:TDocFnc; mRep:TRep;
begin
  If ohEASLST.LocEasCod('OsdImpRat') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOsd do begin
      ohOSRHIS.Table.Filter:='['+ohOSRHIS.FieldNum('SndSta')+']={W}';
      ohOSRHIS.Table.Filtered:=TRUE;
      // -------------------------------------------------------------- Tla� dokladu --------------------------------------------------------------------------
      oArp.AddArpHis('IR','OSD-IMP-RAT',0,'SOLIDSTAV OBCHODN� s.r.o.',gvSys.LoginName,'OSDIMP','Q01','Importovan� zmenen� term�ny dod�vate�ov');
      mRep:=TRep.Create(Application);
      mRep.ItmBtr:=ohOSRHIS.Table;
      mRep.ExecuteQuick('OSRIMP','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //    mRep.Execute('OSRIMP',oArp.ohARPHIS.PdfNam);  // Zapn�� ak chceme zmeni� tla�ov� masku
      FreeAndNil(mRep);
      SndIntEml('OsdImpRat',oArp.ohARPHIS.PdfNam+'.PDF');  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
      SetOsrSnd; // Zru�� pr�znkay �akania na odoslanie internej spr�vy
    end;
    FreeAndNil(mDoc);
  end;
end;

procedure TEasFnc.OspDlyDlv;  // Me�kaj�ce dod�vky osobitne pre ka�d�ho dod�vate�a
var mDoc:TDocFnc; mPar:TLinLst; mRep:TRep;  mParNum:longint;  mParNam:Str60;
begin
  If ohEASLST.LocEasCod('OspDlyDlv') then begin
    mDoc:=TDocFnc.Create;
    mPar:=TLinLst.Create;
    With mDoc.oOsd do begin
      // Vytvor�me zoznam dod�vate�ov, komu budeme posiela� v�kazy
      If ohOSILST.LocItmSta('O') then begin
        Repeat
          If (ohOSILST.SndDte>0) and (ohOSILST.RatDte<Date) then begin
            If not mPar.LocItm(StrInt(ohOSILST.ParNum,0)) then mPar.AddItm(StrInt(ohOSILST.ParNum,0));
          end;
          Application.ProcessMessages;
          ohOSILST.Next;
        until ohOSILST.Eof or (ohOSILST.ItmSta<>'O');
      end;
      // Ak boli n�jden� nejak� polo�ky pre ka�d�ho dod�vate�a odo�leme emailov� spr�vu
      If mPar.Count>0 then begin // M�me komu posla�
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
              If otOSILST.Count>0 then begin // Boli n�jden� me�kaj�ce dodv�ky
                otOSILST.SetIndex('PaDnIn');
                // ----------------------- Tla� dokladu (OCDBAS) -------------------------
                oArp.AddArpHis('ER','OSP-DLY-DLV',mParNum,mParNam,gvSys.LoginName,'OSPDLY','Q01','Me�kaj�ce dod�vky od dod�vate�a');
                mRep:=TRep.Create(Application);
                mRep.ItmTmp:=otOSILST.TmpTable;
                mRep.ExecuteQuick('OSPDLY','PDFCreator',oArp.ohARPHIS.PdfNam,1);
  //              mRep.Execute('OSPDLY',oArp.ohARPHIS.PdfNam);  // Zapn�� ak chceme zmeni� tla�ov� masku
                FreeAndNil(mRep);
                oArp.PdfPrnVer;
                If (oArp.ohARPHIS.PdfSta='A') then SndExtEml(mDoc.oPar.ohPARCAT.RegEml,'Me�kaj�ce dod�vky',mParNum,mParNam,'',0,oArp.ohARPHIS.PdfNam+'.PDF','ospdly.html')   // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
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

procedure TEasFnc.OcdDlyDlv;  // Me�kaj�ce dod�vky pre z�kazn�kov na intern� ��ely
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
          If (ohOCILST.RstPrq>0) and ((ohOCILST.ReqDte=0) or (ohOCILST.ReqDte=ohOCILST.DocDte)) then begin // Pr�pad ak nie je zadan� term�n ale tovar je na sklade (Tiket:7075)
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
        If otOCILST.Count>0 then begin // Boli n�jden� me�kaj�ce dodv�ky
          otOCILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- Tla� dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OCD-DLY-DLV',0,'SOLIDSTAV OBCHODN� s.r.o.',gvSys.LoginName,'OCDDLY','Q01','Odberate�sk� z�kazky - me�kaj�ce dod�vky pre z�kazn�kov');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOCILST.TmpTable;
//          mRep.ExecuteQuick('OCDDLY','PDFCreator',oArp.ohARPHIS.PdfNam,1);
          mRep.Execute('OCDDLY',oArp.ohARPHIS.PdfNam);  // Zapn�� ak chceme zmeni� tla�ov� masku
          FreeAndNil(mRep);
//          oArp.PdfPrnVer;
//          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OcdDlyDlv',oArp.ohARPHIS.PdfNam+'.PDF');  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
        end;
        otOCILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
//  end;
end;

procedure TEasFnc.OcdUndReq;  // Nesplnite�n� po�adovan� term�ny na intern� ��ely
var mDoc:TDocFnc; mRep:TRep;   mNowDlv:boolean;
begin
//  If ohEASLST.LocEasCod('OcdUndReq') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOcd do begin
      If ohOCILST.LocUndSta('U') then begin
        otOCILST.Open;
        Repeat
          mNowDlv:= (ohOCILST.ReqDte=0) or (ohOCILST.ReqDte=ohOCILST.DocDte); // Doda� ihne�
          If (ohOCILST.UndPrq>0) and not mNowDlv then begin // Len vtedy ak nie�o je na dodanie a nie je to odadanie IHNE�
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
        If otOCILST.Count>0 then begin // Boli n�jden� me�kaj�ce dodv�ky
          otOCILST.SetIndex('PaDnIn');
          // -------------------------------------------------------------- Tla� dokladu --------------------------------------------------------------------------
          oArp.AddArpHis('IR','OCD-UND-REQ',0,'SOLIDSTAV OBCHODN� s.r.o.',gvSys.LoginName,'OCDUND','Q01','Odberate�sk� z�kazky - nesplnite�n� po�adovan� term�ny');
          mRep:=TRep.Create(Application);
          mRep.ItmTmp:=otOCILST.TmpTable;
//          mRep.ExecuteQuick('OCDUND','PDFCreator',oArp.ohARPHIS.PdfNam,1);
          mRep.Execute('OCDUND',oArp.ohARPHIS.PdfNam);  // Zapn�� ak chceme zmeni� tla�ov� masku
          FreeAndNil(mRep);
//          oArp.PdfPrnVer;
//          If oArp.ohARPHIS.PdfSta='A' then SndIntEml('OcdUndReq',oArp.ohARPHIS.PdfNam+'.PDF');  // Po�le intern� spr�vu pre ka�dej osoby, kt� s� nastaven� pre dan� v�kaz
        end;
        otOCILST.Close;
      end;
    end;
    FreeAndNil(mDoc);
//  end;
end;

procedure TEasFnc.OcdDlyReq;  // Dlhodobo nerie�en� z�kazn�cke po�iadavky na intern� ��ely
begin
  If ohEASLST.LocEasCod('OcdDlyReq') then begin

  end;
end;

procedure TEasFnc.OcpChgSnd; // Odoslanie zmenen�ch z�kaziek osobitne pre ka�d�ho odberate�a
var mDoc:TDocFnc; mRep:TRep;   mNowDlv:boolean;
begin
(*
  If ohEASLST.LocEasCod('OcpChgSnd') then begin
    mDoc:=TDocFnc.Create;
    With mDoc.oOcd do begin
      If ohOCHLST.LocDstMod('M') then begin
        Repeat
          oArp.AddArpHis('ZK',ohOCHLST.DocNum,ohOCHLST.ParNum,ohOCHLST.ParNam,gvSys.LoginName,'OCDBAS','Q11','Stav z�kazn�ckej objedn�vky');
          SndExtEml(ohOCHLST.CtpEml,'Stav z�kazn�ckej objedn�vky',ohOCHLST.ParNum,ohOCHLST.ParNam,ohOCHLST.ExtNum,ohOCHLST.DocDte,oArp.ohARPHIS.PdfNam+'.PDF','ocdmod.html');
          ClrModSta(ohOCHLST.DocNum);
          Application.ProcessMessages;
          ohOCHLST.Next;
        until ohOCHLST.Eof or (ohOCHLST.DstMod<>'M');
      end;
    end;
  end;
*)
end;

procedure TEasFnc.ShmColDat;  // Zber �dajov predaja do �tatistiky
var mColDat:TShmColDat;
begin
  mColDat:=TShmColDat.Create(Application);
  mColDat.Show;
  mColDat.A_RunExecute(nil);
  FreeAndNil(mColDat);
end;

procedure TEasFnc.TcpNicTcd(pParNum:longint;pSndDte:TDateTime);  // Nevyfakturovan� dod�vky z�kazn�ka za aktu�lny de�
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
                      If (ohTCH.DocDate=pSndDte) and (ohTCH.IcdNum='') and (ohTCH.ItmQnt>0) then begin  // Tla� odberate�sk�ch dodac�ch listov
                        oArp.AddArpHis('',ohTCH.DocNum,ohTCH.PaCode,ohTCH.PaName,gvSys.LoginName,'TCPNIC','Q01','Zoznam nevyfakturovan�ho odobran�ho tovaru zo d�a '+DateToStr(pSndDte));
                        PrnPdfDoc(ohTCH.DocNum,'TCD.Q01',oArp.ohARPHIS.PdfNam);  // Tla� adan�ho dokladu do PDF s�boru  // TODO n�zov tla�ovej masky do vlastnosti
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
              If mTcdLst.Count>0 then begin // Priprav�me Email pre dan�ho z�kazn�ka
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
                mEmd.ohEMDLST.Subjec:='Zoznam nevyfakturovan�ho odobran�ho tovaru zo d�a '+DateToStr(Date);
                mEmd.ohEMDLST.ParNum:=mParNum;
                mEmd.ohEMDLST.ParNam:=oPar.ohPARCAT.ParNam;
                mEmd.ohEMDLST.CrtDte:=Date;
                mEmd.ohEMDLST.CrtTim:=Time;
                mEmd.ohEMDLST.AtdDoq:=mTcdLst.Count; // Po�et pripojen�ch pr�lohov�ch dokumentov
                mEmd.ohEMDLST.AtdTyp:='OD';
                mEmd.ohEMDLST.ErrSta:='P';  // Pr�znak, �e treba pripoji� prilohu
                mEmd.ohEMDLST.EmlMsk:='tcpnic.html';
                mEmd.ohEMDLST.SndSta:='P';
                mEmd.ohEMDLST.Post;
                mEmd.AddVar('CurDte',DateToStr(pSndDte));
                // Prid�me pr�lohy
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

procedure TEasFnc.IcpNewIcd;  // Vystaven� fakt�ry pre z�kazn�ka za aktu�lny de�
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
                        oArp.AddArpHis('',ohICH.DocNum,ohICH.PaCode,ohICH.PaName,gvSys.LoginName,'ICD','Q01','Va�e vystaven� fakt�ry zo d�a '+DateToStr(pSndDte));
                        PrnDoc(ohICH.DocNum,TRUE,'',oArp.ohARPHIS.PdfNam,1,TRUE); // Tla� adan�ho dokladu do PDF s�boru
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
              If mIcdLst.Count>0 then begin // Priprav�me Email pre dan�ho z�kazn�ka
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
                mEmd.ohEMDLST.Subjec:='Va�e vystaven� fakt�ry za dne�n� de� '+DateToStr(pSndDte);
                mEmd.ohEMDLST.ParNum:=mParNum;
                mEmd.ohEMDLST.ParNam:=oPar.ohPARCAT.ParNam;
                mEmd.ohEMDLST.CrtDte:=Date;
                mEmd.ohEMDLST.CrtTim:=Time;
                mEmd.ohEMDLST.AtdTyp:='OD';
                mEmd.ohEMDLST.ErrSta:='P';  // Pr�znak, �e treba pripoji� prilohu
                mEmd.ohEMDLST.EmlMsk:='icpnew.html';
                mEmd.ohEMDLST.SndSta:='P';
                mEmd.ohEMDLST.Post;
                mEmd.AddVar('CurDte',DateToStr(pSndDte));
                // Prid�me pr�lohy
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


