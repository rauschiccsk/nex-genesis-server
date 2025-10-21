unit NexRgh;

interface

  uses NexLic, IcVariab, NexBtrTable, NexGlob, NexPath, SysUtils;

  const
   cUsrModLst:string='';

   cSys =  1;   // Systemove nastavenia
   cUsr =  2;   // Evidencia uzivatelov
   cDbs =  3;   // Udrzba databazovych suborov
   cEml =  4;   // Interna elektronicka posta
   cWdc =  5;   // Denn· uz·vierka prev·dzky
   cBac =  6;   // Riadenie viazanosti knih
   cKey =  7;   // Spr·va riadiacich parametrov
   cIfc =  8;   // KomunikaËnÈ rozhranie
   // ----------------------------------------------
   cGsc = 10;   // Evidencia tovaru
   cPab = 11;   // Evidencia partnerov
   cPls = 12;   // Tvorba predajnych cien
   cWgh = 13;   // Obsluha elektronick˝ch v·h
   cApl = 14;   // Evidencia akciov˝ch cien
   // ----------------------------------------------
   cPsb = 20;   // Planovanie objednavok
   cOsb = 21;   // Dodavatelske objednavky
   cTsb = 22;   // Dodavatelske dodacie listy
   cBsb = 23;   // Obchodne podmienky dod·vok
   cTim = 24;   // Termin·lovÈ prÌjemky
   cPim = 25;   // PoziËnÈ prÌjemky
   cKsb = 26;   // Komision·lne vy˙Ëtovanie
   cOsq = 27;   // Tvorba objedn·vok zo skladu
   // ----------------------------------------------
   cStl = 30;   // Evidencia skladov
   cWrl = 31;   // Evidencia prevadzok
   cCel = 32;   // Evidencia stredisk
   cAtl = 33;   // Evidencia zavodov
   cStk = 34;   // Skladov ekarty zasob
   cImb = 35;   // Interne skaldove prijemky
   cOmb = 36;   // Interne skaldove vydajky
   cRmb = 37;   // Medziskladove presuny
   cIvd = 38;   // Inventarizacia skladov
   cCmb = 39;   // Kompletiz·cia v˝robkov
   cReb = 40;   // Precenovacie doklady
   cAcb = 41;   // Akciove precenenie tovaru
   cPkb = 42;   // Prebalenie tovaru
   cDmb = 43;   // Rozobratie v˝robkov
   cAlb = 44;   // Evidencia zapozicanych naradi
   cCpb = 45;   // Kalkul·cia v˝robkov
   cPnb = 46;   // Protokol nepredajneho skladu
   cCdb = 47;   // Manu·lna v˝roba
   // ----------------------------------------------
   cPkl = 50;   // Prebalovacie koeficienty
   cMpb = 51;   // Prebalenie tovaru
   cLab = 52;   // Tlac cenovych etikiet
   cKom = 53;   // Komisionalny tovar
   cStt = 54;   // Pomocne nastroje skladu
   // ----------------------------------------------
   cMcb = 60;   // Odberatelske cenove ponuky
   cOcb = 61;   // Odberatelske zakazky
   cPcb = 62;   // Odberatelske zalohove faktury
   cTcb = 63;   // Odberatelske dodacie listy
   cIcb = 64;   // Odberatelske faktury
   cScb = 65;   // Servisne zakazky
   cSpe = 66;   // Evidencia zalohovych platieb
   cSvb = 67;   // Faktury zalohovych platieb
   cBci = 68;   // Obchodne podmienky odberatelov
   cCrd = 69;   // Evidencia zakaznickych kariet
   cCas = 70;   // Maloobchodny predaj
   cClb = 71;   // Zakaznicke reklamacie
   cUdb = 72;   // Univerzalne odbytove doklady
   cAgl = 73;   // Evidencai zmluvnych podmienok
   cOcp = 74;   // Spracovanie zakaziek
   cItc = 75;   // Export pre internetovy obchod
   cTom = 76;   // Termin·lovÈ v˝dajky
   cRpl = 77;   // DoporuËenÈ predajnÈ ceny
   cRpc = 78;   // Poûiadavky na zmeny cien
   cMds = 79;   // V˝kaz najmenöieho zisku
   cTpc = 200;  // Evidencia terminovan˝ch cien
   cDir = 201;  // Kontaktny manaûÈrsky di·r
   cDsp = 202;  // Vynimky blokovania zakznika
   cPom = 203;  // Pozicny vydaj tovaru
   // ------------- Riadenie logistiky -------------
   cExb = 220;  // Evidencia expediËn˝ch prÌkazov
   cRba = 221;  // Vykaz vyrobnej sarze
   // ----------------------------------------------
   cCab = 80;   // Knihy registracnych pokladnic
   cCai = 81;   // Informacie pokladnicneho predaja
   cSab = 82;   // Skladove vydajky MO predaja
   cCwb = 83;   // Bankov˝ v˝pis SEPA
   cCap = 84;   // TlaË kÛpiÌ dokladov
   cCac = 85;   // V˝kaz denn˝ch uz·vierok
   cCwe = 87;   // Prevodn˝ prÌkaz SEPA
   // ----------------------------------------------
   cSnt = 90;   // Synteticka uctovna osnova
   cAnl = 91;   // Analyticka uctovna osnova
   cIdb = 92;   // Dennik internych dokladov
   cCsb = 93;   // Hotovostne pokladne
   cSob = 94;   // Bankove vypisy
   cPqb = 95;   // Prevodne prikazy
   cDsb = 96;   // Dodavetelske zalohove faktury
   cIsb = 97;   // Dodavetelske faktury
   cVtb = 98;   // Evuidencia DPH
   cJrn = 99;   // Dennik uctovnych zapisov
   cLdg = 100;  // Hlavna kniha uctov
   cAcc = 101;  // Obratova predvaha
   cBlr = 102;  // Tvorba uctovnych vykazov
   cPyc = 103;  // Pohladavky k zadanemu datumu
   cPys = 104;  // Zavazky k zadanemu datumu
   cSac = 105;  // Evidencia podsuvahovych uctov
   cAcv = 106;  // Uctovne kontroly
   cSrb = 107;  // Vykazy liehovych vyrobkov
   cMtb = 108;  // Operativna evidencia MTZ
   cRcr = 109;  // Koncorocne prekurzovanie faktur
   cAct = 110;  // Vykaz obratovej predvahy
   cCrs = 111;  // Kurzovy list NB
   cDpb = 112;  // Post˙penÈ a odk˙penÈ pohæad·vky
   // ----------------------------------------------
   cSta = 120;  // Statistika nakupu a predaja
   cSeb = 121;  // Vyberova statistika predaja
   cNpb = 122;  // Zaznamy o problemoch
   cWab = 123;  // Vypocet odmeny zamestnancov
   // ----------------------------------------------
   cOwb = 140;  // Vyuctovanie sluzobnych ciest
   cFxb = 150;  // Dlhodoby majetok
   cSma = 151;  // Kratokodoby majetok
   // ----------------------------------------------
   cJob = 160;  // Evidencia pracovn˝ch ˙kolov
   cApb = 161;  // éiadosù o bezhotovostn˝ styk
   cIpb = 162;  // Evidencia doölej poöty
   cPrj = 163;  // Evidencia projektov
   cEmc = 164;  // ElektronickÈ spr·vy z·kaznÌkom
   cPrb = 165;  // Spr·va informaËn˝ch projektov
   cCrb = 166;  // Spr·va z·kaznÌckych poûiadaviek
   cPxb = 167;  // N·vrh informaËn˝ch systÈmov
   cXrm = 168;  // Tvorba XLS v˝kazov
   // ----------------------------------------------
   cAsc = 184;  // Prehæad z·v‰zkov a pohæad·vok
   // ----------------------------------------------
   cHrs = 190;  // Hotelov˝ rezervaËn˝ systÈm


  function LicModEnabled(pModID:string):boolean;
  function RghModEnabled(pRgh:string):boolean;
  function ModEnabled(pModID:string):boolean;
  function GetPmdMark (pModul:byte):string;

implementation

procedure FillUsrRghLst;
var mApmDef:TNexBtrTable;
begin
  If cUsrModLst='' then begin
    mApmDef:=BtrInit ('APMDEF',gPath.SysPath, nil);
    mApmDef.Open;
    If mApmDef.RecordCount>0 then begin
      mApmDef.IndexName:='GrpNum';
      If mApmDef.FindKey([gvSys.LoginGroup]) then begin
        cUsrModLst:=';';
        Repeat
          cUsrModLst:=cUsrModLst+mApmDef.FieldByName('PmdMark').AsString+';';
          mApmDef.Next;
        until mApmDef.EOF or (mApmDef.FieldByName('GrpNum').AsInteger<>gvSys.LoginGroup);
      end;
    end;
    FreeAndNil(mApmDef);
    If cUsrModLst='' then cUsrModLst:='*';
  end;
end;

function ModIDToRgh(pModID:string):string;
begin
  Result:=pModID;
//B·zov· evidencia
  If pModID='GSC' then Result:='GSC';
  If pModID='PAB' then Result:='PAB';
  If pModID='WGH' then Result:='WGH';
//Obchod
  If pModID='PLM' then Result:='PLS';
  If pModID='APM' then Result:='APL';
  If pModID='TPC' then Result:='TPC';
  If pModID='ACB' then Result:='ACB';
  If pModID='BCM' then Result:='BCI';
  If pModID='AGM' then Result:='AGL';
  If pModID='CRD' then Result:='CRD';
//Z·sobovanie
  If pModID='PSM' then Result:='PSB';
  If pModID='OSM' then Result:='OSB';
  If pModID='TSM' then Result:='TSB';
  If pModID='KSM' then Result:='KSB';
  If pModID='BSM' then Result:='BSB';
  If pModID='TIM' then Result:='TIB';
  If pModID='LAB' then Result:='LAB';
//Sklad
  If pModID='STK' then Result:='STK';
//  If pModID='PDN' then Result:='PDN';
  If pModID='PDN' then Result:='ASN';
  If pModID='IMM' then Result:='IMB';
  If pModID='OMM' then Result:='OMB';
  If pModID='RMM' then Result:='RMB';
  If pModID='CPM' then Result:='CPB';
  If pModID='CMM' then Result:='CMB';
  If pModID='DMM' then Result:='DMB';
  If pModID='PKM' then Result:='PKB';
  If pModID='CDM' then Result:='CDB';
  If pModID='IVD' then Result:='IVB';
  If pModID='IVM' then Result:='IVB';
//Odbyt
  If pModID='UDM' then Result:='UDB';
  If pModID='MCM' then Result:='MCB';
  If pModID='OCM' then Result:='OCB';
  If pModID='TCM' then Result:='TCB';
  If pModID='ICM' then Result:='ICB';
  If pModID='SPE' then Result:='PCO';
  If pModID='SVB' then Result:='SVB';
  If pModID='ESM' then Result:='ITC';
  If pModID='TOM' then Result:='TOB';
  If pModID='BWM' then Result:='ALB';
//Servis
  If pModID='SCM' then Result:='SCB';
//Obsluha ERP
  If pModID='CAB' then Result:='CAB';
  If pModID='SAB' then Result:='SAB';
  If pModID='CAI' then Result:='CAI';
  If pModID='CAC' then Result:='CAC';
//⁄ËtovnÌctvo
  If pModID='JRN' then Result:='JRN';
  If pModID='ACC' then Result:='ACT';
  If pModID='ACT' then Result:='ACT';
  If pModID='BLR' then Result:='BLR';
  If pModID='IDM' then Result:='IDB';
  If pModID='ISM' then Result:='ISB';
  If pModID='CSM' then Result:='CSB';
  If pModID='SOM' then Result:='SOB';
  If pModID='BQM' then Result:='PQB';
  If pModID='DPB' then Result:='DPB';
  If pModID='VTM' then Result:='VTR';
  If pModID='SRB' then Result:='SRB';
  If pModID='CRS' then Result:='CRS';
  If pModID='ACV' then Result:='ACV';
//Majetok
  If pModID='FXM' then Result:='FXB';
//Ekonomika
  If pModID='ASC' then Result:='ASC';
//Manaûment
  If pModID='SHM' then Result:='SSA';
  If pModID='STA' then Result:='SSA';
  If pModID='SEB' then Result:='SEB';
  If pModID='RPL' then Result:='RPL';
  If pModID='DSP' then Result:='DSP';
  If pModID='XRM' then Result:='XRB';
//SystÈm
  If pModID='SYS' then Result:='SYS';
  If pModID='USR' then Result:='USD';
  If pModID='GRP' then Result:='USD';
  If pModID='KEY' then Result:='KEY';
  If pModID='DBS' then Result:='DBS';
end;

function ModIDToLic(pModID:string):string;
begin
  Result:=pModID;
//B·zov· evidencia
  If pModID='GSC' then Result:='NEX';
  If pModID='PAB' then Result:='NEX';
  If pModID='WGH' then Result:='WGH';
//Obchod
  If pModID='PLM' then Result:='PLM';
  If pModID='APM' then Result:='APM';
  If pModID='TPC' then Result:='APM';
  If pModID='ACB' then Result:='APM';
  If pModID='BCM' then Result:='BCM';
  If pModID='AGM' then Result:='AGM';
  If pModID='CRD' then Result:='CRD';
//Z·sobovanie
  If pModID='PSM' then Result:='PSM';
  If pModID='OSM' then Result:='OSM';
  If pModID='TSM' then Result:='TSM';
  If pModID='KSM' then Result:='KSM';
  If pModID='BSM' then Result:='BSM';
  If pModID='TIM' then Result:='TIM';
  If pModID='LAB' then Result:='PLM';
//Sklad
  If pModID='STK' then Result:='NEX';
  If pModID='PDN' then Result:='NEX';
  If pModID='IMM' then Result:='IMM';
  If pModID='OMM' then Result:='OMM';
  If pModID='RMM' then Result:='RMM';
  If pModID='CPM' then Result:='CMM';
  If pModID='CMM' then Result:='CMM';
  If pModID='DMM' then Result:='DMM';
  If pModID='PKM' then Result:='PKM';
  If pModID='CDM' then Result:='CDM';
  If pModID='IVD' then Result:='IVM';
  If pModID='IVM' then Result:='IVM';
//Odbyt
  If pModID='UDM' then Result:='UDM';
  If pModID='MCM' then Result:='MCM';
  If pModID='OCM' then Result:='OCM';
  If pModID='TCM' then Result:='TCM';
  If pModID='ICM' then Result:='ICM';
  If pModID='SPE' then Result:='DCM';
  If pModID='SVB' then Result:='DCM';
  If pModID='ESM' then Result:='ESM';
  If pModID='TOM' then Result:='TOM';
  If pModID='BWM' then Result:='BWM';
//Servis
  If pModID='SCM' then Result:='SCM';
//Obsluha ERP
  If pModID='CAB' then Result:='REM';
  If pModID='SAB' then Result:='REM';
  If pModID='CAI' then Result:='REM';
  If pModID='CAC' then Result:='REM';
//⁄ËtovnÌctvo
  If pModID='JRN' then Result:='IDM';
  If pModID='ACC' then Result:='IDM';
  If pModID='ACT' then Result:='IDM';
  If pModID='BLR' then Result:='IDM';
  If pModID='IDM' then Result:='IDM';
  If pModID='ISM' then Result:='ISM';
  If pModID='CSM' then Result:='CSM';
  If pModID='SOM' then Result:='SOM';
  If pModID='BQM' then Result:='BQM';
  If pModID='DPB' then Result:='DPB';
  If pModID='VTM' then Result:='VTM';
  If pModID='SRB' then Result:='SRB';
  If pModID='CRS' then Result:='SOM';
  If pModID='ACV' then Result:='IDM';
//Majetok
  If pModID='FXM' then Result:='FXM';
//Ekonomika
  If pModID='ASC' then Result:='ASC';
//Manaûment
  If pModID='SHM' then Result:='STA';
  If pModID='STA' then Result:='STA';
  If pModID='SEB' then Result:='STA';
  If pModID='RPL' then Result:='RPL';
  If pModID='DSP' then Result:='DSP';
  If pModID='XRM' then Result:='XRM';
//SystÈm
  If pModID='SYS' then Result:='NEX';
  If pModID='USR' then Result:='NEX';
  If pModID='GRP' then Result:='NEX';
  If pModID='KEY' then Result:='NEX';
  If pModID='DBS' then Result:='NEX';
end;

function RghToLic(pModID:string):string;
begin
  Result:=pModID;
//B·zov· evidencia
  If pModID='GSC' then Result:='NEX';
  If pModID='PAB' then Result:='NEX';
  If pModID='WGH' then Result:='WGH';
//Obchod
  If pModID='PLS' then Result:='PLM';
  If pModID='APL' then Result:='APM';
  If pModID='TPC' then Result:='APM';
  If pModID='ACB' then Result:='APM';
  If pModID='BCI' then Result:='BCM';
  If pModID='AGL' then Result:='AGM';
  If pModID='CRD' then Result:='CRD';
//Z·sobovanie
  If pModID='PSB' then Result:='PSM';
  If pModID='OSB' then Result:='OSM';
  If pModID='TSB' then Result:='TSM';
  If pModID='KSB' then Result:='KSM';
  If pModID='BSB' then Result:='BSM';
  If pModID='TIB' then Result:='TIM';
  If pModID='LAB' then Result:='PLM';
//Sklad
  If pModID='STK' then Result:='NEX';
//  If pModID='PDN' then Result:='NEX';
  If pModID='ASN' then Result:='NEX';
  If pModID='IMB' then Result:='IMM';
  If pModID='OMB' then Result:='OMM';
  If pModID='RMB' then Result:='RMM';
  If pModID='CPB' then Result:='CMM';
  If pModID='CMB' then Result:='CMM';
  If pModID='DMB' then Result:='DMM';
  If pModID='PKB' then Result:='PKM';
  If pModID='CDB' then Result:='CDM';
  If pModID='IVB' then Result:='IVM';
//Odbyt
  If pModID='UDB' then Result:='UDM';
  If pModID='MCB' then Result:='MCM';
  If pModID='OCB' then Result:='OCM';
  If pModID='TCB' then Result:='TCM';
  If pModID='ICB' then Result:='ICM';
  If pModID='PCO' then Result:='DCM';
  If pModID='SVB' then Result:='DCM';
  If pModID='ITC' then Result:='ESM';
  If pModID='TOB' then Result:='TOM';
  If pModID='ALB' then Result:='BWM';
//Servis
  If pModID='SCB' then Result:='SCM';
//Obsluha ERP
  If pModID='CAB' then Result:='REM';
  If pModID='SAB' then Result:='REM';
  If pModID='CAI' then Result:='REM';
  If pModID='CAC' then Result:='REM';
//⁄ËtovnÌctvo
  If pModID='JRN' then Result:='IDM';
  If pModID='ACC' then Result:='IDM';
  If pModID='ACT' then Result:='IDM';
  If pModID='BLR' then Result:='IDM';
  If pModID='IDB' then Result:='IDM';
  If pModID='ISB' then Result:='ISM';
  If pModID='CSB' then Result:='CSM';
  If pModID='SOB' then Result:='SOM';
  If pModID='PQB' then Result:='BQM';
  If pModID='DPB' then Result:='DPB';
  If pModID='VTR' then Result:='VTM';
  If pModID='SRB' then Result:='SRB';
  If pModID='CRS' then Result:='SOM';
  If pModID='ACV' then Result:='IDM';
//Majetok
  If pModID='FXB' then Result:='FXM';
//Ekonomika
  If pModID='ASC' then Result:='ASC';
//Manaûment
  If pModID='SHM' then Result:='STA';
  If pModID='SSA' then Result:='STA';
  If pModID='SEB' then Result:='STA';
  If pModID='RPL' then Result:='RPL';
  If pModID='DSP' then Result:='DSP';
  If pModID='XRB' then Result:='XRM';
//SystÈm
  If pModID='SYS' then Result:='NEX';
  If pModID='USR' then Result:='NEX';
  If pModID='GRP' then Result:='NEX';
  If pModID='KEY' then Result:='NEX';
  If pModID='DBS' then Result:='NEX';
end;

function UsrModEnabled(pModID:string):boolean;
begin
  Result:=FALSE;
  If pModID<>'' then begin
//    If gvSys.LoginGroup>0 then begin
      FillUsrRghLst;
      pModID:=ModIDtoRgh(pModID);
      Result:=Pos(';'+pModID+';',cUsrModLst)>0;
//    end else Result:=TRUE;
  end;
end;

function LicModEnabled(pModID:string):boolean;
begin
  Result:=FALSE;
  If pModID<>'' then begin
    pModID:=ModIDToLic(pModID);
    Result:=Pos(';'+pModID+';',gNEXLic.ModLst)>0;
  end;
end;

function RghModEnabled(pRgh:string):boolean;
begin
  Result:=FALSE;
  If pRgh<>'' then begin
    pRgh:=RghToLic(pRgh);
    Result:=Pos(';'+pRgh+';',gNEXLic.ModLst)>0;
  end;
end;

function ModEnabled(pModID:string):boolean;
begin
  Result:=LicModEnabled(pModID) and UsrModEnabled(pModID);
end;

function GetPmdMark (pModul:byte):string;
begin
  case pModul of
    cEml: Result := '';
    cWdc: Result := '';
    cStl: Result := '';
    cWrl: Result := '';
    cCel: Result := '';
    cAtl: Result := '';
    cSnt: Result := '';
    cAnl: Result := '';
    // ------ Bazova evidencia ------
    cGsc: Result := 'GSC';
    cWgh: Result := 'WGH';
    cPab: Result := 'PAB';
    // ------ Obchodn· Ëinnosù ------
    cPls: Result := 'PLS';
    cApl: Result := 'APL';
    cTpc: Result := 'TPC';
    cAcb: Result := 'ACB';
    cRpc: Result := 'RPC';
    cCrd: Result := 'CRD';
    cDir: Result := 'DIR';
    cMds: Result := 'MDS';
    // ---- Z·sobovanie skladov -----
    cOcp: Result := 'OCP';
    cPsb: Result := 'PSB';
    cOsb: Result := 'OSB';
    cOsq: Result := 'OSQ';
    cTsb: Result := 'TSB';
    cKsb: Result := 'KSB';
    cBsb: Result := 'BSB';
    cTim: Result := 'TIB';
    cLab: Result := 'LAB';
    // ----- Riadenia skladov -----
    cStk: Result := 'STK';
    cImb: Result := 'IMB';
    cOmb: Result := 'OMB';
    cRmb: Result := 'RMB';
    cCpb: Result := 'CPB';
    cCmb: Result := 'CMB';
    cDmb: Result := 'DMB';
    cPkb: Result := 'PKB';
    cCdb: Result := 'CDB';
    cReb: Result := 'REB';
    cAlb: Result := 'ALB';
    cIvd: Result := 'IVB';
    // --- Velkoobchodn· Ëinnosù ---
    cUdb: Result := 'UDB';
    cMcb: Result := 'MCB';
    cOcb: Result := 'OCB';
    cPcb: Result := 'PCB';
    cTcb: Result := 'TCB';
    cIcb: Result := 'ICB';
    cSpe: Result := 'PCO';
    cSvb: Result := 'PCO';
    cBci: Result := 'BCI';
    cAgl: Result := 'AGL';
    cCas: Result := 'CAS';
    cItc: Result := 'ITC';
    cTom: Result := 'TOB';
    cPom: Result := 'POM';
    cDsp: Result := 'DSP';
    // ---- Riadenie logistiky ----
    cExb: Result := 'EXB';
    cRba: Result := 'RBA';
    // ----- Servisn· Ëinnosù -----
    cScb: Result := 'SCB';
    cClb: Result := 'CLB';
    // ------- Obsluha ERP --------
    cCab: Result := 'CAB';
    cSab: Result := 'SAB';
    cCai: Result := 'CAI';
    cCap: Result := 'CAP';
    cCac: Result := 'CAC';
    // --- FinanËnÈ ˙ËtovnÌctvo ---
    cAcc: Result := 'ACC';
    cAct: Result := 'ACT';
    cBlr: Result := 'BLC';
    cIdb: Result := 'IDB';
    cIsb: Result := 'ISB';
    cCsb: Result := 'CSB';
    cSob: Result := 'SOB';
    cPqb: Result := 'PQB';
    cCwb: Result := 'CWB';
    cCwe: Result := 'CWE';
    cVtb: Result := 'VTR';
    cSrb: Result := 'SRB';
    cMtb: Result := 'MTB';
    cCrs: Result := 'CRS';
    cOwb: Result := 'OWB';
    cRcr: Result := 'RCR';
    cAcv: Result := 'ACV';
    cDpb: Result := 'DPB';
    // ---- Evidencia majetku ----
    cFxb: Result := 'FXB';
    cSma: Result := 'SMA';
    // --- Ekonomick· Ëinnosù ----
    cAsc: Result := 'ASC';
    // ----- Administrativa ------
    cIpb: Result := 'IPB';
    cJob: Result := 'JOB';
    cApb: Result := 'APB';
    cPrj: Result := 'PRJ';
    cEmc: Result := 'EMC';
    // ------- Manaûment ---------
    cPrb: Result := 'PRB';
    cCrb: Result := 'CRB';
    cPxb: Result := 'PXB';
    cXrm: Result := 'XRB';
    // ------- ätatistika --------
    cSta: Result := 'SSA';
    cSeb: Result := 'SEB';
    cNpb: Result := 'NPB';
    cRpl: Result := 'RPL';
    cWab: Result := 'WAB';
    // -------------------
    cSys: Result := 'SYS';
    cUsr: Result := 'USD';
    cDbs: Result := 'DBS';
    cBac: Result := 'BAC';
    cKey: Result := 'KEY';
    cIfc: Result := 'IFC';
    // -------------------
    cPkl: Result := 'PKL';
    cMpb: Result := 'MPB';
    cKom: Result := 'KOM';
    cStt: Result := 'STT';
    cDsb: Result := 'DSB';
    cJrn: Result := 'JRN';
    cLdg: Result := 'LDG';
    cPyc: Result := 'PYC';
    cPys: Result := 'PYS';
    cSac: Result := 'SAC';
    cHrs: Result := 'HRS';
  else Result := '';
  end;
end;

end.
