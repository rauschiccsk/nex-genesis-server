unit Udbmmc;
// *****************************************************************
//                   OVLADAC PRE DATOVY ZAZNAMNIK
//                            UDB-MMX
//                     Vyrobca zariadenia: VAROS
// *****************************************************************
// UPOZORNENIE:
// Tento unit nie je urceny na priame pouzitie z aplikacneho programu
// Vsetky datove zaznamniky sa pouzivaju prostrednictvom spolocneho
// ovladaca - Terminal_F
// *****************************************************************

interface

uses
  IcTypes, IcFiles, NexPath, NexMsg, NexError, 
  TxtCut, TxtWrap, ExecWait, Devices,
  ShellAPI, IniFiles, SysUtils, Forms, Windows, Classes;

type
  TUdbmmc = class
    constructor Create;
    destructor Destroy; override;
  private
    oFile: TStrings;   // Subor na odoslanie a prijatie udajov zaznamnika
    oSndPath: string;  // Adresar na posielanie suboru do zaznamnika
    oRcvPath: string;  // Adresar na prijatie suboru zo zaznamnika
    oGscName: string;  // Názov databazového súboru, ktorá bude posielaná do terminálu
    oImdName: string;  // Názov súboru príjemky
    oOmdName: string;  // Názov súboru výdajky
    oIvdName: string;  // Názov súboru inventury
    oDvcPrgName: Str12;  // Nazov externeho komunikacneho programu
    oInstalled: boolean; // TRUE ak existuje komunikacny program
    // Udaje tovarovej polozky
    oBarCode: Str15; // Ciarovy kod tovaru
    oGsQnt: double;  // Mnozstvo tovaru na sklade - zasoba
    oBPrice: double; // Predajna cena tovaru s DPH
    oGsName: Str30;  // Nazov tovaru
    // Na spracovanie udajov
    oWrap: TTxtWrap;
    procedure SetDvcPrgIniParams; // Nastavi inicializacne parametre komunikacneho programu
    procedure ReadDataFromTerminal; // Nacita udaje zo zaznamnika
    procedure ConvertToTxtFile; // Prekonvertuje nacitane udaje do textoveho suboru pre NEX
    procedure DeleteTerminalFile; // Vymaze subor ktory bolnacitany zo zaznamnika
  public
    procedure OpenFile; // Otvori suboru ktory bude poslany do terminalu
    procedure AddToFile; // Prida zaznam s polozkami GsName, BarCode, BPrice do suboru ktory bude potom poslany do terminalu
    procedure CloseFile; // Uzatvory suboru ktory bude poslany do terminalu
    procedure SendData;  // Posiela údaje do zaznamnika

    procedure ReadData;  // Naèíta údaje zo zaznamnika
  published
    property Installed: boolean read oInstalled;

    property BarCode:Str15 write oBarCode;
    property GsQnt:double write oGsQnt;
    property BPrice:double write oBPrice;
    property GsName:Str30 write oGsName;
  end;

implementation

constructor TUdbmmc.Create;
begin
  oSndPath := gPath.DvcPath+'DATASND\';
  oRcvPath := gPath.DvcPath+'DATARCV\';
  If not DirectoryExists (oSndPath) then ForceDirectories (oSndPath);
  If not DirectoryExists (oRcvPath) then ForceDirectories (oRcvPath);
  If not DirectoryExists (gPath.IndPath) then ForceDirectories (gPath.IndPath);
  oGscName := 'DATA_IN.TXT';   // Názov databazového súboru, ktorá bude posielaná do terminálu
  oImdName := 'PRIJEMKY.TXT';  // Názov súboru príjemky
  oOmdName := 'VYDAJKY.TXT';   // Názov súboru výdajky
  oIvdName := 'DATAOUTN.TXT';  // Názov súboru inventury

  oDvcPrgName := 'UDBMMC.EXE';
  oInstalled := FileExistsI (gPath.DvcPath+oDvcPrgName);
  If oInstalled
    then SetDvcPrgIniParams // Nastavi inicializacne parametre komunikacneho programu
    else ShowMsg (ecSysFileIsNotExist,gPath.DvcPath+oDvcPrgName);
end;

destructor  TUdbmmc.Destroy;
begin
  inherited;
end;

procedure TUdbmmc.OpenFile; // Otvori suboru ktory bude poslany do terminalu
begin
  If FileExistsI (oSndPath+oGscName) then DeleteFile (PChar(oSndPath+oGscName));
  oFile := TStringList.Create;
  oWrap := TTxtWrap.Create;
  oWrap.SetDelimiter('');
  oWrap.SetSeparator(';');
end;

procedure TUdbmmc.AddToFile; // Prida zaznam s polozkami GsName, BarCode, BPrice do suboru ktory bude potom poslana do terminalu
begin
  oWrap.ClearWrap;
  oWrap.SetText(oBarCode,0);
  oWrap.SetReal(0,0,3);
  oWrap.SetReal(oBPrice,0,2);
  oWrap.SetText(oGsName,0);
  oFile.Add (oWrap.GetWrapText);
end;

procedure TUdbmmc.CloseFile; // Uzatvori suboru ktory bude poslany do terminalu
begin
  oFile.SaveToFile(oSndPath+'DATA_IN.TXT');
  FreeAndNil (oFile);
  FreeAndNil (oWrap);
end;

procedure TUdbmmc.SendData;
begin
  ExecAppWait (gPath.DvcPath+'UDBMMC.EXE','O');
end;

procedure TUdbmmc.ReadData;
begin
  DeleteTerminalFile; // Vymaze subor ktory bolnacitany zo zaznamnika
  ReadDataFromTerminal; // Nacita udaje zo zaznamnika
  ConvertToTxtFile; // Prekonvertuje nacitane udaje do textoveho suboru pre NEX
end;

// ************************** PRIVATE ******************************

procedure TUdbmmc.SetDvcPrgIniParams; // Nastavi inicializacne parametre komunikacneho programu
var mIni:TIniFile;  mDevices:TDevices;
begin
  mDevices := TDevices.Create;
  If mDevices.FindDevice('UDBMMC') then begin // Je nadefinovany na tejto pracovnej stanice dane periferne zariadenie
    If not FileExistsI(gPath.DvcPath+'UDBMMC.INI') then begin
      mIni :=TIniFile.Create(gPath.DvcPath+'UDBMMC.INI');
      // [GLOBAL]
      mIni.WriteInteger('GLOBAL','sort',0);
      mIni.WriteString('GLOBAL','port',mDevices.Port);
      mIni.WriteString('GLOBAL','verzia','5.8');
      // [PATHS]
      mIni.WriteString('PATHS','path_ins',oSndPath+oGscName);
      mIni.WriteString('PATHS','path_outn',oRcvPath+oIvdName);
      mIni.WriteString('PATHS','path_prijemky',oRcvPath+oImdName);
      mIni.WriteString('PATHS','path_vydajky',oRcvPath+oOmdName);
      mIni.WriteString('PATHS','path_ino',oRcvPath+'DATA_ODB.TXT');   // Nepouzivame
      mIni.WriteString('PATHS','path_outv',oRcvPath+'DATAOUTV.TXT');  // Nepouzivame
      // [InFormat Casio]
      mIni.WriteInteger('InFormat Casio','CASIO1_ISK',0);
      // [OutFormat Casio]
      mIni.WriteInteger('OutFormat Casio','CASIO1_OSK',0);
      // [InFormat Oddelovac]
      mIni.WriteInteger('InFormat Oddelovac','Odd_ISK',1);
      mIni.WriteInteger('InFormat Oddelovac','Odd1_ISK',0);
      mIni.WriteInteger('InFormat Oddelovac','Odd2_ISK',2);
      mIni.WriteInteger('InFormat Oddelovac','Odd3_ISK',1);
      mIni.WriteInteger('InFormat Oddelovac','Odd4_ISK',3);
      mIni.WriteString ('InFormat Oddelovac','Odd_Char_ISK',';');
      // [OutFormat Oddelovac]
      mIni.WriteInteger('OutFormat Oddelovac','Odd_OSK',1);
      mIni.WriteInteger('OutFormat Oddelovac','Odd1_OSK',0);
      mIni.WriteInteger('OutFormat Oddelovac','Odd2_OSK',1);
      mIni.WriteInteger('OutFormat Oddelovac','Odd3_OSK',2);
      mIni.WriteInteger('OutFormat Oddelovac','Odd4_OSK',3);
      mIni.WriteString ('OutFormat Oddelovac','Odd_Char_OSK',';');
      // [InFormat Pevna_dlzka]
      mIni.WriteInteger('InFormat Pevna_dlzka','Pevna_dl_ISK',0);
      mIni.WriteInteger('InFormat Pevna_dlzka','KOD_zac',0);
      mIni.WriteInteger('InFormat Pevna_dlzka','KOD_dlzka',16);
      mIni.WriteInteger('InFormat Pevna_dlzka','POC_zac',17);
      mIni.WriteInteger('InFormat Pevna_dlzka','POC_dlzka',8);
      mIni.WriteInteger('InFormat Pevna_dlzka','NAZ_zac',34);
      mIni.WriteInteger('InFormat Pevna_dlzka','CEN_dlzka',8);
      mIni.WriteInteger('InFormat Pevna_dlzka','CEN_zac',25);
      mIni.WriteInteger('InFormat Pevna_dlzka','NAZ_dlzka',39);
      // [OutFormat Pevna_dlzka]
      mIni.WriteInteger('OutFormat Pevna_dlzka','Pevna_dl_OSK',0);
      mIni.WriteInteger('OutFormat Pevna_dlzka','dlzka1_OSK',16);
      mIni.WriteInteger('OutFormat Pevna_dlzka','dlzka2_OSK',8);
      mIni.WriteInteger('OutFormat Pevna_dlzka','dlzka3_OSK',8);
      mIni.WriteInteger('OutFormat Pevna_dlzka','dlzka4_OSK',40);
      // [InFormat Old]
      mIni.WriteInteger('InFormat Old','Old_ISK',0);
      // [OutFormat Old]
      mIni.WriteInteger('OutFormat Old','Old_OSK',0);
      // [Format]
      mIni.WriteInteger('Format','PDM1_OSK',3);
      mIni.WriteInteger('Format','PDM2_OSK',2);
      mIni.WriteInteger('Format','WriteCisloDokladu',1);
      FreeAndNil (mIni);
    end
    else begin // Ak existuje inicializacny subor prekontrolujeme ci je dobre nastaveny port
      mIni :=TIniFile.Create(gPath.DvcPath+'UDBMMC.INI');
      If mDevices.Port<>mIni.ReadString('GLOBAL','port','') then begin
        mIni.WriteString('GLOBAL','port',mDevices.Port);
      end;
      FreeAndNil (mIni);
    end;
  end
  else ShowMsg (ecSysDeviceIsNotInReg,mDevices.DvcType);
  FreeAndNil (mDevices);
end;

procedure TUdbmmc.ReadDataFromTerminal; // Nacita udaje zo zaznamnika
begin
  ExecAppWait (gPath.DvcPath+'UDBMMC.EXE','P');
end;

procedure TUdbmmc.ConvertToTxtFile; // Prekonvertuje nacitane udaje do textoveho suboru pre NEX
var mTrmFile,mNexFile:TStrings;  mCut:TTxtCut;  mWrap:TTxtWrap;  mCnt:longint;
begin
  If FileExistsI (oRcvPath+'PRIJEMKY.TXT') or FileExistsI (oRcvPath+'VYDAJKY.TXT') then begin
    mTrmFile := TStringList.Create;
    mTrmFile.LoadFromFile (oRcvPath+'PRIJEMKY.TXT');
    If mTrmFile.Count=0 then mTrmFile.LoadFromFile (oRcvPath+'VYDAJKY.TXT');
    If mTrmFile.Count>0 then begin
      mCut := TTxtCut.Create;
      mCut.SetDelimiter('');
      mCut.SetSeparator(';');
      mWrap := TTxtWrap.Create;
      mNexFile := TStringList.Create;
      mCnt := 0;
      Repeat
        mCut.SetStr(mTrmFile.Strings[mCnt]);
        mWrap.ClearWrap;
        mWrap.SetText(mCut.GetText(1),0);
        mWrap.SetReal(mCut.GetReal(3),0,3);
        mWrap.SetReal(mCut.GetReal(2),0,2);
        mWrap.SetText(mCut.GetText(4),0);
        mNexFile.Add(mWrap.GetWrapText);
        Inc (mCnt);
      until mCnt=mTrmFile.Count;
      mNexFile.SaveToFile(gPath.IndPath+'RCVDATA.TXT');
      FreeAndNil (mNexFile);
      FreeAndNil (mWrap);
      FreeAndNil (mCut);
    end;
    FreeAndNil (mTrmFile);
  end;
end;

procedure TUdbmmc.DeleteTerminalFile; // Vymaze subor ktory bolnacitany zo zaznamnika
begin
  If FileExistsI (oRcvPath+oIvdName) then DeleteFile (PChar(oRcvPath+oIvdName));
  If FileExistsI (oRcvPath+oImdName) then DeleteFile (PChar(oRcvPath+oImdName));
  If FileExistsI (oRcvPath+oOmdName) then DeleteFile (PChar(oRcvPath+oOmdName));
  If FileExistsI (oRcvPath+'DATA_ODB.TXT') then DeleteFile (PChar(oRcvPath+'DATA_ODB.TXT'));
  If FileExistsI (oRcvPath+'DATAOUTV.TXT') then DeleteFile (PChar(oRcvPath+'DATAOUTV.TXT'));
end;

end.
