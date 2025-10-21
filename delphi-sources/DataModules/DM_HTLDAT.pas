unit DM_HTLDAT;

interface

uses
  IdSMTP, IdMessage, IdEmailAddress, DM_DLSDAT,
  ComObj,  nmsmtp, MAPI, MapiControl,
  Ictools, IcConv,  IcTypes, IcVariab, BtrTable, NexBtrTable, NexTmpTable, PxTmpTable,
  NexPath, NexText,   NEXini,
  Grids,   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  IniFiles, LinkBtrTable, DBTables, DbfTable, PxTable, NexPxTable, ExtCtrls;

const
  // HTL - Hotelovy system
  acHtlRoomReserved       = 200001;  // Vybranu izbu nie je mozne rezervovat
  acHtlDateIReserved      = 200002;  // Nie je mozne zmenit prichod lebo datumovy interval je uz rezorvovany
  acHtlDateOReserved      = 200003;  // Nie je mozne zmenit  odchod lebo datumovy interval je uz rezorvovany
  acHtlLastVisInRoom      = 200004;  // Nie je mozne vyuctovat hosta len izbu lebo je posledny z danej izby
  acHtlYourSaveRolBefExit = 200101;  // Zmenili ste udaje izby. Chcete tieto zmeny ulozit pred nacitanim druhej polozky?
  acHtlYourCanDeleteRol   = 200102;  // Naozaj chcete zrusit vybranu izbu?
  acHtlYourSaveVisBefExit = 200111;  // Zmenili ste udaje hosta. Chcete tieto zmeny ulozit pred nacitanim druhej polozky?
  acHtlYourCanDeleteVis   = 200112;  // Naozaj chcete zrusit vybraneho hosta?
  acHtlYourSaveSrvBefExit = 200121;  // Zmenili ste udaje sluzby. Chcete tieto zmeny ulozit pred nacitanim druhej polozky?
  acHtlYourCanDeleteSrv   = 200122;  // Naozaj chcete zrusit vybranu sluzbu?
  acHtlDeleteTNS          = 200123;  // Naozaj chcete zrusit vybranu sluzbu?
  acHtlFoundLastTNS_N     = 200124;  // Nie je mozne odubytovat posledneho hosta na izbe lebo este nie je vyuctovany
  acHtlDeleteTent         = 200125;  // Naozaj chcete zrusit ubytovanie?
  acHtlDeleteRes          = 200126;  // Naozaj chcete zrusit rezervaciu?
  acHtlResToTent          = 200127;  // Naozaj chcete vytvorit ubytovanie z rezervacie?
  acHtlChangeDscPrc       = 200128;  // Naozaj chcete zmenit zlavy na izby z %1 na %2?
  acHtlRecalcPayAll       = 200129;  // Naozaj chcete prepocitat ceny vsetkych izeb?
  acHtlMoveTent           = 200130;  // Naozaj chcete zlucit ubytovanie?
  acHtlInsertVis          = 200131;  // Naozaj chcete zaevidovat hosta?
  acHtlVisToPAB           = 200132;  // Chcete zaevidovat hosta aj do katalogu firiem?
  acHtlTentMarkPay        = 200133;  // Chcete zmenit ubytovanie za zaplatene?
  acHtlEndDateGreater     = 200134;  // Chcete zmenit ubytovanie za zaplatene?
  ecHtlPlnEmpty           = 200135;  // Nemate aktivne ziadne pripomienky
  cChildAge  : integer    = 8*365;   // Vek pre dieta
  cInfantAge : integer    = 2*365;   // Vek kojenca
  cBedPrice  : double     = 20;      // Prednastavena cena za lozko
  cAdbPrice  : double     = 15;      // Prednastavena cena za pristelok
  cRoomPrice : double     = 40;      // Prednastavena cena za izbu
  cDefRowH   : integer    = 14;      // Vyska pola v gride
  cDefColW   : integer    = 20;      // Sirka pola v gride
  cHrsImpPrc : double     = 30;      // percentualna hodnota zalohy z celkovej ceny rezervacie
  cMaxDays   : integer    = 31;      // pocet zobrazenych dni
  cMaxRooms  : integer    = 30;      // pocet zobrazenych izieb
  cMaxArray               = 61;      // pocet zobrazenych stlpcov - v podstate 2*pocet dni+1
  cDefDateFontSize:byte   = 9;       // velkost fontu pisma datumov
  cDefGridFontSize:byte   = 8;       // velkost fontu pisma ubytopvani
  cDefRoomFontSize:byte   = 8;       // velkost fontu pisma izieb
  cRoomDevices  : array[1..10] of string[60]=('Vana','Televizor','Telefon','Klima','Internet','Zariadenie 6','Zariadenie 7','Zariadenie 8','Zariadenie 9','Zariadenie 10');
  cRoomDevGsCode: array[1..10] of longint   =(0,0,0,0,0,0,0,0,0,0);
  cUseROLDevice : boolean=FALSE;       // ci sa budu pouzivat samostatne zariadenia pre kazdu izbu
  cFullnameCrtType:byte=1;             // algoritmus vytvorenia celeho mena hosta
// 0: E_FirstName+' ' +E_MidName+' ' +E_LastName
// 1: E_FirstName+', '+E_MidName+', '+E_LastName.Text
// 2: E_LastName +' ' +E_MidName+' ' +E_FirstName.Text
  cVisToPAB:boolean=FALSE;
  cRefreshGrid:boolean=FALSE;
  cRoomPriceFDsc:boolean=FALSE;        // zlava sa pocita na vyslednu cenu izby aj so zariadeniami
  cHrsPlsNum : integer     = 1;        // cislo cennika
  cSortRoomByCode:boolean = False;  // Zoradenie izieb podla kodu izby a nie podla poradoveho cisla izby
  cRoomTypes  : array[1..10] of string[20]=('Standard','Apartman','','','','','','','','');
type
  TDayRec=record
    RoomPrice : double;  // cena za izbu
    VisCnt    : byte;    // Pocet hosti platoacich za ubytovanie - sluzba 3
    VisCntA   : byte;    // Pocet hosti na pristelku             - sluzba 2
    VisCntP   : byte;    // Pocet hosti ktori zaplatili za ubytovanie
    RoomPrice1: double;  // Cena na 1 hosta za izbu = RoomPrice/(VisCnt+VisCntP)
    PayVal    : double;  // Uz uhradena suma
    VisCntI   : byte;    // Pocet hosti platoacich za ubytovanie - sluzba 3
    VisCntO   : byte;    // Pocet hosti platoacich za ubytovanie - sluzba 3
  end;

  TPabData=record
    RegName : Str60;
    RegIno  : Str15;
    RegTin  : Str15;
    RegVin  : Str15;
    RegAddr : Str30;
    RegSta  : Str2;
    RegCty  : Str3;
    RegCtn  : Str30;
    RegZip  : Str15;
    RegTel  : Str20;
    RegFax  : Str20;
    RegEml  : Str30;
  end;

  TdmHTL = class(TDataModule)
    btRSH: TNexBtrTable;
    ptATU: TPxTable;
    ptRSI: TNexPxTable;
    btRSI: TNexBtrTable;
    ptRSS: TNexPxTable;
    btRSS: TNexBtrTable;
    ptRSP: TNexPxTable;
    btRSP: TNexBtrTable;
    btVIS: TNexBtrTable;
    btROL: TNexBtrTable;
    btSrv: TNexBtrTable;
    btTNH: TNexBtrTable;
    btTNI: TNexBtrTable;
    btTNS: TNexBtrTable;
    btTNP: TNexBtrTable;
    btTNB2: TNexBtrTable;
    btTNV: TNexBtrTable;
    ptTNI: TNexPxTable;
    ptTNS: TNexPxTable;
    ptTNP: TNexPxTable;
    ptTNB: TNexPxTable;
    ptTNV: TNexPxTable;
    ptTNS2: TNexPxTable;
    ptROL: TNexPxTable;
    btTNNOTI: TNexBtrTable;
    btRSNOTI: TNexBtrTable;
    ptTNH: TNexPxTable;
    ptTNC: TNexPxTable;
    btTNATU: TNexBtrTable;
    btHRSC: TNexBtrTable;
    ptTNVSTA: TNexPxTable;
    btTNOMB: TNexBtrTable;
    btSRV0: TNexBtrTable;
    btCRSVLST: TNexBtrTable;
    btCRSVHIS: TNexBtrTable;
    ptSRVCOL: TNexPxTable;
    btGSLANG: TNexBtrTable;
    btSRVLANG: TNexBtrTable;
    T_HtlDat: TTimer;
    btTNR: TNexBtrTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure btRSHAfterOpen(DataSet: TDataSet);
    procedure ptATUBeforeOpen(DataSet: TDataSet);
    procedure btSrvAfterOpen(DataSet: TDataSet);
    procedure T_HtlDatTimer(Sender: TObject);
    procedure btVISBeforePost(DataSet: TDataSet);
    procedure btTNVBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure RSI_To_TMP;    // Ulozi zaznam z btRSI do ptRSI
    procedure RSS_To_TMP;    // Ulozi zaznam z btRSS do ptRSS
    procedure RSP_To_TMP;    // Ulozi zaznam z btRSP do ptRSP

    procedure TNI_To_TMP;    // Ulozi zaznam z btTNI do ptTNI
    procedure InsTNS_To_TMP; // Ulozi zaznam z btTNS do ptTNS
    procedure TNP_To_TMP;    // Ulozi zaznam z btTNP do ptTNP
    procedure InsTNB_To_TMP; // Ulozi zaznam z btTNS do ptTNB
    procedure TNV_To_TMP;    // Ulozi zaznam z btTNV do ptTNV
    procedure TNS_To_TNS2;   // Ulozi zaznam z ptTNS do ptTNS2
    procedure TNS2_Slct_To_TNS;   // Vytvoti zaznam z ptTNS2 do btTNS a ptTNS ak je len ciastocne uhradeny

    procedure InsROL_To_TMP; // Ulozi zaznam z btROL do ptROL
    procedure TNH_To_TMP;    // Ulozi zaznam z btROL do ptROL


//    procedure TNS_To_TNB;    // Ulozi zaznam z btTNS do btTNP
  end;

procedure StringGridRotateTextOut(Grid: TStringGrid; ARow, ACol: Integer; Rect: TRect;
          Schriftart: string; Size:Integer; Color: TColor; Alignment: TAlignment);
procedure StringGridRotateTextOut2(Grid:TStringGrid;ARow,ACol:Integer;Rect:TRect;
          Schriftart: string; Size:Integer;Color:TColor;Alignment:TAlignment);
function  DecodeRoomType(pSt:Str1):Str20;
function  DecodeVisStatus(pSt:Str1):Str20;
function  EncodeVisStatus(pSt:Str20):Str1;
function  DecodeHeadStatus(pSt:Str1):Str20;
function  EncodeHeadStatus(pSt:Str20):Str1;
function  RoomCode2RoomNum(pRoomCode:Str30):longint; // zisti cislo izby podla kodu izby
function  DayQntToText(pDays:integer):Str10;
function  RoomNum2RoomCode(pRoomNum:longint):Str15; // vrati kod izby podla cisla izby

procedure SendOutlookMail(pRecipients,pSubjekt,pBody,pFile:String);
procedure SendMailNMSMTP(pRecipients,pSubjekt,pBody,pFile:String);
procedure SendMail(Subject, Body, RecvAddress : string; Attachs : array of string);
procedure SendMailMAPI(S0,R,pSubjekt,pBody:String);
procedure SendOutLookMail2;
function  GetPAB_IcDscPrc(pPAB:longint):double;
procedure WriteCommand(pCommand:Str20;pType:Str1;pH1,pI1,pV1,pS1:longint;pDI1,pDO1:TDateTime;pH2,pI2,pV2,pS2:longint;pDI2,pDO2:TDateTime);
function  GetFloor:longint;
function  GetBlok:longint;
procedure SumTNS(pTentNum,pRoomNum,pVisNum,pSrvCode:integer; pStatus:Str1; var pAValue,pBValue:double; var pCnt:integer);
procedure FillDayArray(pTentNum,pRoomNum:integer);
procedure RecalcPay(pTentNum,pRoomNum:integer);
procedure ChangeTNR(pTentNum,pRoomNum,pOldTentNum,pOldRoomNum:integer;pBegDay,pEndDay:integer);

function SumOrdStr(pStr:String):integer;

var
  dmHTL: TdmHTL;
  gHrsIni: TIniFile;
  gPCB_Text,gResText1,gResText2:Str100;
  gDefMCBBook,gDefICBBook,gDefCsbBook,gDefOMBBook,gDefCpbBook: Str5;
  gDefStkNum :integer;
  gMailType  : byte;
  gMailSender: Str30;
  gMailConto: Str30;
  gAutoPayCode:longint;
  gATUSrvCode:longint;
  gATUPath:str80;
  gATUType:byte;
  gMiniBarGsCode:longint;
  gOMSmCode:longint;
  gCheckFloorBlok:byte;
  gDayArray: array[1..61] of TDayRec;

implementation

{$R *.DFM}

function SumOrdStr(pStr:String):integer;
var I:byte;
begin
  Result:=0;
  for I:=1 to Length(pStr) do Result:=Result+ord(pstr[I]);
end;

procedure SumTNS(pTentNum,pRoomNum,pVisNum,pSrvCode:integer; pStatus:Str1; var pAValue,pBValue:double; var pCnt:integer);
begin
  // tns.bdf
  pAValue:=0;pBValue:=0;pCnt:=0;
  dmHtl.btTNS.SwapStatus;
  If pVisNum<>0 then begin
    dmHtl.btTNS.IndexName:='TnRnVi';
    dmHtl.btTNS.FindNearest([pTentNum,pRoomNum,pVisNum]);
  end else If pRoomNum<>0 then begin
    dmHtl.btTNS.IndexName:='TnRn';
    dmHtl.btTNS.FindNearest([pTentNum,pRoomNum]);
  end else begin
    dmHtl.btTNS.IndexName:='TentNum';
    dmHtl.btTNS.FindNearest([pTentNum]);
  end;
  while not dmHtl.btTNS.Eof
  and  ((pTentNum=0)or(pTentNum=dmHtl.btTNS.FieldByName('TentNum').AsInteger))
  and  ((pRoomNum=0)or(pRoomNum=dmHtl.btTNS.FieldByName('RoomNum').AsInteger))
  and  ((pVisNum=0)or(pVisNum=dmHtl.btTNS.FieldByName('VisNum').AsInteger)) do
  begin
    If ((pSrvCode=0)or(pSrvCode=dmHtl.btTNS.FieldByName('SrvCode').AsInteger))
    and((pStatus='')or(pStatus=dmHtl.btTNS.FieldByName('Status').AsString)) then begin
      pAValue:=pAValue+dmHtl.btTNS.FieldByName('AValue').AsFloat;
      pBValue:=pBValue+dmHtl.btTNS.FieldByName('BValue').AsFloat;
      Inc(pCnt);
    end;
    dmHtl.btTNS.Next;
  end;
  dmHtl.btTNS.RestoreStatus;
end;

procedure FillDayArray(pTentNum,pRoomNum:integer);
var mI,mB,mE,mDay:byte;mPrice:double;
begin
  FillChar(gDayArray,sizeof(gDayArray),0);
  // TNI.BDF TNV.BDF TNR.BDF
  dmHtl.btTNI.SwapStatus;dmHtl.btTNI.IndexName:='TnRn';
  dmHtl.btTNV.SwapStatus;dmHtl.btTNV.IndexName:='TnRnVi';
  dmHtl.btTNR.SwapStatus;dmHtl.btTNR.IndexName:='TnRnDa';
  dmHtl.btTNS.SwapStatus;dmHtl.btTNS.IndexName:='TnRnVi';
  If dmHtl.btTNI.FindKey([pTentNum,pRoomNum]) then begin
    mDay:=Trunc(dmHTL.btTNI.fieldbyName('DateO').AsDateTime)-Trunc(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+1;
    For mI:=1 to mDay-1 do begin
      gDayArray[mI].RoomPrice:=dmHTL.btTNI.fieldbyName('RoomPriceF').AsFloat;
      If dmHtl.btTNR.FindKey([pTentNum,pRoomNum,dmHTL.btTNI.fieldbyName('DateI').AsDateTime+mI-1])
        then gDayArray[mI].RoomPrice:=dmHTL.btTNR.fieldbyName('RoomPriceF').AsFloat;
    end;
    dmHtl.btTNV.FindNearest([pTentNum,pRoomNum,0]);
    while not dmHtl.btTNV.Eof
    and  (pTentNum=dmHtl.btTNV.FieldByName('TentNum').AsInteger)
    and  (pRoomNum=dmHtl.btTNV.FieldByName('RoomNum').AsInteger) do
    begin
      If dmHtl.btTNS.FindKey([pTentNum,pRoomNum,dmHtl.btTNV.FieldByName('VisNum').AsInteger]) then begin
        mB:=Trunc(dmHTL.btTNV.fieldbyName('DateI').AsDateTime)-Trunc(dmHTL.btTNI.fieldbyName('DateI').AsDateTime);
        mE:=Trunc(dmHTL.btTNI.fieldbyName('DateO').AsDateTime)-Trunc(dmHTL.btTNV.fieldbyName('DateO').AsDateTime);
        gDayArray[mB+1].VisCntI:=gDayArray[mB+1].VisCntI+1;
        gDayArray[mDay-mE].VisCntO:=gDayArray[mDay-mE].VisCntO+1;
        while not dmHtl.btTNS.Eof
        and  (pTentNum=dmHtl.btTNS.FieldByName('TentNum').AsInteger)
        and  (pRoomNum=dmHtl.btTNS.FieldByName('RoomNum').AsInteger)
        and  (dmHtl.btTNV.FieldByName('VisNum').AsInteger=dmHtl.btTNS.FieldByName('VisNum').AsInteger) do
        begin
          If (dmHtl.btTNS.FieldByName('SrvCode').AsInteger=3) then begin
            If ('N'=dmHtl.btTNS.FieldByName('Status').AsString) then begin
              For mI:=1+mB to mDay-mE-1 do begin
                gDayArray[mI].VisCnt:=gDayArray[mI].VisCnt+1;
              end;
            end else If ('S'=dmHtl.btTNS.FieldByName('Status').AsString) then begin
              For mI:=1+mB to mDay-mE-1 do begin
                gDayArray[mI].VisCntP:=gDayArray[mI].VisCntP+1;
                gDayArray[mI].PayVal:=gDayArray[mI].PayVal+dmHtl.btTNS.FieldByName('BValue').AsFloat
                { TODO : prepocet ceny izby na dany den };
              end;
            end;
          end else If(dmHtl.btTNS.FieldByName('SrvCode').AsInteger=2) then begin
            For mI:=1+mB to mDay-mE-1 do begin
              gDayArray[mI].VisCntA:=gDayArray[mI].VisCntA+1;
            end;
          end;
          dmHtl.btTNS.Next;
        end;
      end;
      dmHtl.btTNV.Next;
    end;
    For mI:=1 to mDay-1 do begin
      gDayArray[mI].RoomPrice1:=gDayArray[mI].RoomPrice/(gDayArray[mI].VisCnt+gDayArray[mI].VisCntP);
    end;
  end;
  dmHtl.btTNS.RestoreStatus;
  dmHtl.btTNR.RestoreStatus;
  dmHtl.btTNI.RestoreStatus;
  dmHtl.btTNV.RestoreStatus;
end;

procedure RecalcPay(pTentNum,pRoomNum:integer);
var mI,mB,mE,mDay:byte; mAV,mBV,mDays:double;
begin
  FillDayArray(pTentNum,pRoomNum);
  dmHtl.btTNI.SwapStatus;dmHtl.btTNI.IndexName:='TnRn';
  dmHtl.btTNV.SwapStatus;dmHtl.btTNV.IndexName:='TnRnVi';
  dmHtl.btTNR.SwapStatus;dmHtl.btTNR.IndexName:='TnRnDa';
  dmHtl.btTNS.SwapStatus;dmHtl.btTNS.IndexName:='TnRnVi';
  dmHtl.ptTNS.SwapStatus;dmHtl.ptTNS.IndexName:='';
  If dmHtl.btTNI.FindKey([pTentNum,pRoomNum]) then begin
    mDay:=Trunc(dmHTL.btTNI.fieldbyName('DateO').AsDateTime)-Trunc(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+1;
    dmHtl.btTNV.FindNearest([pTentNum,pRoomNum,0]);
    while not dmHtl.btTNV.Eof
    and  (pTentNum=dmHtl.btTNV.FieldByName('TentNum').AsInteger)
    and  (pRoomNum=dmHtl.btTNV.FieldByName('RoomNum').AsInteger) do
    begin
      If dmHtl.btTNS.FindKey([pTentNum,pRoomNum,dmHtl.btTNV.FieldByName('VisNum').AsInteger]) then begin
        mB:=Trunc(dmHTL.btTNV.fieldbyName('DateI').AsDateTime)-Trunc(dmHTL.btTNI.fieldbyName('DateI').AsDateTime);
        mE:=Trunc(dmHTL.btTNI.fieldbyName('DateO').AsDateTime)-Trunc(dmHTL.btTNV.fieldbyName('DateO').AsDateTime);
        mAV:=0;mBV:=0;
        For mI:=mB+1 to mDay-mE-1 do begin
          mBV:=mBV+gDayArray[mI].RoomPrice1;
        end;
        while not dmHtl.btTNS.Eof
        and  (pTentNum=dmHtl.btTNS.FieldByName('TentNum').AsInteger)
        and  (pRoomNum=dmHtl.btTNS.FieldByName('RoomNum').AsInteger)
        and  (dmHtl.btTNV.FieldByName('VisNum').AsInteger=dmHtl.btTNS.FieldByName('VisNum').AsInteger) do
        begin
          If (dmHtl.btTNS.FieldByName('SrvCode').AsInteger=3) then begin
            If (dmHTL.btTNS.FieldByName('Status').AsString='N') then begin
              dmHTL.btTNS.Edit;
              dmHTL.btTNS.FieldByName('BPrice').AsFloat:=mBV/(mDay-mB-mE-1);
              dmHTL.btTNS.FieldByName('BValue').AsFloat:=mBV;
              dmHTL.btTNS.FieldByName('AValue').AsFloat:=mBV/(1+dmHTL.btTNS.FieldByName('VatPrc').AsFloat/100);
              dmHTL.btTNS.FieldByName('APrice').AsFloat:=dmHTL.btTNS.FieldByName('AValue').AsFloat/(mDay-mB-mE-1);
              dmHTL.btTNS.Post;
              If dmHTL.ptTNS.FindKey([dmHTL.btTNS.FieldByName('Sernum').asInteger]) then begin
                dmHTL.ptTNS.Edit;
                dmHTL.ptTNS.FieldByName('BPrice').AsFloat:=dmHTL.btTNS.FieldByName('BPrice').AsFloat;
                dmHTL.ptTNS.FieldByName('BValue').AsFloat:=dmHTL.btTNS.FieldByName('BValue').AsFloat;
                dmHTL.ptTNS.FieldByName('AValue').AsFloat:=dmHTL.btTNS.FieldByName('AValue').AsFloat;
                dmHTL.ptTNS.FieldByName('APrice').AsFloat:=dmHTL.btTNS.FieldByName('APrice').AsFloat;
                dmHTL.ptTNS.Post;
              end;
            end;
          end else If(dmHtl.btTNS.FieldByName('Status').AsString='N') then begin
            mDays:=dmHTL.btTNS.FieldByName('Quant').AsFloat;
            If dmHTL.btTNS.FieldByName('Daily').AsString='A' then mDays:=mDays*(mDay-mB-mE-1);
            dmHTL.btTNS.Edit;
            dmHTL.btTNS.FieldByName('BValue').AsFloat:=dmHTL.btTNS.FieldByName('BPrice').AsFloat*mDays;
            dmHTL.btTNS.FieldByName('AValue').AsFloat:=dmHTL.btTNS.FieldByName('BPrice').AsFloat*mDays/(1+dmHTL.ptTNS.FieldByName('VatPrc').AsFloat/100);
            dmHTL.btTNS.Post;
            If dmHTL.ptTNS.FindKey([dmHTL.btTNS.FieldByName('Sernum').asInteger]) then begin
              dmHTL.ptTNS.Edit;
              dmHTL.ptTNS.FieldByName('BValue').AsFloat:=dmHTL.btTNS.FieldByName('BValue').AsFloat;
              dmHTL.ptTNS.FieldByName('AValue').AsFloat:=dmHTL.btTNS.FieldByName('AValue').AsFloat;
              dmHTL.ptTNS.Post;
            end;
          end;
          dmHtl.btTNS.Next;
        end;
      end;
      dmHtl.btTNV.Next;
    end;
  end;
  dmHtl.btTNS.RestoreStatus;
  dmHtl.btTNR.RestoreStatus;
  dmHtl.btTNI.RestoreStatus;
  dmHtl.btTNV.RestoreStatus;
end;

procedure ChangeTNR(pTentNum,pRoomNum,pOldTentNum,pOldRoomNum:integer;pBegDay,pEndDay:integer);
var mI,mD,mB,mE:integer;
begin
  // TNR.BDF btnr
  dmHtl.btTNR.SwapStatus;dmHtl.btTNR.IndexName:='TnRn';
  dmHtl.btTNI.SwapStatus;dmHtl.btTNI.IndexName:='TnRn';
  If pOldTentNum=0 then pOldTentNum:=pTentNum;
  If pOldRoomNum=0 then pOldRoomNum:=pRoomNum;

  If ((pOldTentNum<>pTentNum)or(pOldRoomNum<>pRoomNum))
  and dmHtl.btTNI.FindKey([pTentNum,pRoomNum]) and dmHtl.btTNR.FindKey([pTentNum,pRoomNum]) then begin
    while not dmHtl.btTNR.Eof and (dmHtl.btTNR.FieldByName('TentNum').AsInteger=pOldTentNum)
    and (dmHtl.btTNR.FieldByName('RoomNum').AsInteger=pOldTentNum) do
    begin
      dmHtl.btTNR.Edit;
      dmHtl.btTNR.FieldByName('TentNum').AsInteger:=pTentNum;
      dmHtl.btTNR.FieldByName('RoomNum').AsInteger:=pTentNum;
      dmHtl.btTNR.Post;
      dmHtl.btTNR.Next;
    end;
  end;
  FillDayArray(pTentNum,pRoomNum);
  mD:=TRUNC(dmHTL.btTNI.fieldbyName('DateO').AsDateTime)-TRUNC(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+1;
  dmHtl.btTNR.IndexName:='TnRnDa';
  If (pBegDay=pEndDay) and (pBegDay>0) then begin
    // posun o x dni >>
    for mI:=mD downto 1 do begin
      If dmHtl.btTNR.FindKey([pTentNum,pRoomNum,TRUNC(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+mI-1-pBegDay]) then begin
        dmHtl.btTNR.Edit;
        dmHtl.btTNR.FieldByName('Date').AsDateTime:=dmHtl.btTNR.FieldByName('Date').AsDateTime+pBegDay;
        dmHtl.btTNR.Post;
      end;
    end;
  end else If (pBegDay=pEndDay) and (pBegDay<0) then begin
    // posun o x dni <<
    for mI:=1 to mD do begin
      If dmHtl.btTNR.FindKey([pTentNum,pRoomNum,TRUNC(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+mI-1-pBegDay]) then begin
        dmHtl.btTNR.Edit;
        dmHtl.btTNR.FieldByName('Date').AsDateTime:=dmHtl.btTNR.FieldByName('Date').AsDateTime+pBegDay;
        dmHtl.btTNR.Post;
      end;
    end;
  end else If (pBegDay<0) then begin
    // posun prichodu o x dni <<
    for mI:=1 to mD do begin
      If not dmHtl.btTNR.FindKey([pTentNum,pRoomNum,TRUNC(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+mI-1]) then begin
        dmHtl.btTNR.Insert;
        dmHtl.btTNR.FieldByName('TentNum').AsInteger:=dmHtl.btTNI.FieldByName('TentNum').AsInteger;
        dmHtl.btTNR.FieldByName('RoomNum').AsInteger:=dmHtl.btTNI.FieldByName('RoomNum').AsInteger;
        dmHtl.btTNR.FieldByName('Date').AsDateTime:=dmHtl.btTNI.FieldByName('DateI').AsDateTime+mI-1;
        dmHtl.btTNR.FieldByName('RoomPrice').AsFloat:=dmHtl.btTNI.FieldByName('RoomPrice').AsFloat;
        dmHtl.btTNR.FieldByName('RoomPriceF').AsFloat:=gdayarray[mI].RoomPrice;
        dmHtl.btTNR.Post;
      end;
    end;
  end else If (pBegDay>0) then begin
    // posun prichodu o x dni >>
    for mI:=1 to pBegDay do begin
      If dmHtl.btTNR.FindKey([pTentNum,pRoomNum,TRUNC(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+mI-1-pBegDay]) then begin
        dmHtl.btTNR.Delete;
      end;
    end;
  end else If (pEndDay<0) then begin
    // posun odchodu o x dni <<
    for mI:=1 to Abs(pEndDay) do begin
      If dmHtl.btTNR.FindKey([pTentNum,pRoomNum,TRUNC(dmHTL.btTNI.fieldbyName('DateO').AsDateTime)+mI]) then begin
        dmHtl.btTNR.Delete;
      end;
    end;
  end else If (pEndDay>0) then begin
    // posun odchodu o x dni >>
    for mI:=1 to mD do begin
      If not dmHtl.btTNR.FindKey([pTentNum,pRoomNum,TRUNC(dmHTL.btTNI.fieldbyName('DateI').AsDateTime)+mI-1]) then begin
        dmHtl.btTNR.Insert;
        dmHtl.btTNR.FieldByName('TentNum').AsInteger:=dmHtl.btTNI.FieldByName('TentNum').AsInteger;
        dmHtl.btTNR.FieldByName('RoomNum').AsInteger:=dmHtl.btTNI.FieldByName('RoomNum').AsInteger;
        dmHtl.btTNR.FieldByName('Date').AsDateTime:=dmHtl.btTNI.FieldByName('DateI').AsDateTime+mI-1;
        dmHtl.btTNR.FieldByName('RoomPrice').AsFloat:=dmHtl.btTNI.FieldByName('RoomPrice').AsFloat;
        dmHtl.btTNR.FieldByName('RoomPriceF').AsFloat:=gdayarray[mI].RoomPrice;
        dmHtl.btTNR.Post;
      end;
    end;
  end;
  dmHtl.btTNI.RestoreStatus;
  dmHtl.btTNR.RestoreStatus;
end;

function GetFloor:longint;
begin
  If gCheckFloorBlok in [1,3]
    then Result:=dmHTL.btROL.FieldByName('Floor').AsInteger
    else Result:=0;
end;

function GetBlok:longint;
begin
  If gCheckFloorBlok in [2,3]
    then Result:=dmHTL.btROL.FieldByName('Blok').AsInteger
    else Result:=0;
end;

procedure WriteCommand(pCommand:Str20;pType:Str1;pH1,pI1,pV1,pS1:longint;pDI1,pDO1:TDateTime;pH2,pI2,pV2,pS2:longint;pDI2,pDO2:TDateTime);
var mL:longint;
begin
  dmHTL.btHRSC.SwapStatus;
  dmHTL.btHRSC.IndexName:='SerNum';
  dmHTL.btHRSC.Last;
  mL:=dmHTL.btHRSC.FieldByName('SerNum').AsInteger+1;
  dmHTL.btHRSC.RestoreStatus;
  dmHTL.btHRSC.Insert;
  dmHTL.btHRSC.FieldByName('SerNum').AsInteger    :=mL;
  dmHTL.btHRSC.FieldByName('Command').AsString    :=pCommand;
  dmHTL.btHRSC.FieldByName('HRSType').AsString    :=pType;
  dmHTL.btHRSC.FieldByName('HeadNum1').AsInteger  :=pH1;
  dmHTL.btHRSC.FieldByName('RoomNum1').AsInteger  :=pI1;
  dmHTL.btHRSC.FieldByName('VisNum1').AsInteger   :=pV1;
  dmHTL.btHRSC.FieldByName('ServNum1').AsInteger  :=pS1;
  dmHTL.btHRSC.FieldByName('DateI1').AsDateTime   :=pDI1;
  dmHTL.btHRSC.FieldByName('DateO1').AsDateTime   :=pDO1;
  dmHTL.btHRSC.FieldByName('HeadNum2').AsInteger  :=pH2;
  dmHTL.btHRSC.FieldByName('RoomNum2').AsInteger  :=pI2;
  dmHTL.btHRSC.FieldByName('VisNum2').AsInteger   :=pV2;
  dmHTL.btHRSC.FieldByName('ServNum2').AsInteger  :=pS2;
  dmHTL.btHRSC.FieldByName('DateI2').AsDateTime   :=pDI2;
  dmHTL.btHRSC.FieldByName('DateO2').AsDateTime   :=pDO2;
  dmHTL.btHRSC.Post;
end;

function  GetPAB_IcDscPrc(pPAB:longint):double;
begin
  If (pPAB<>0) and dmDLS.btPAB.FindKey([pPAB])
    then Result:=dmDLS.btPAB.FieldByName('IcDscPrc').AsFloat 
    else Result:=0;
end;

function  DayQntToText(pDays:integer):Str10;
begin
  Result:='';
  case pDays of
    1: Result := '1 deò';
    2,3: Result := IntToStr(pDays)+' dni';
  else Result := IntToStr(pDays)+' dní';
  end;
end;

procedure SendOutLookMail2;
begin
(*
  CLSIDFromProgID('Outlook.Application', CLSID);
  GetActiveObject(CLSID, nil, Intf);
  Intf.QueryInterface(IDispatch, AppServer);
  MailItem := AppServer.CreateItem(0);
  MailItem.Subject := ASubject; // some text, may vary
  MailItem.BodyFormat := 2 // HTML
  MailItem.InternetCodepage := '1251';
  MailItem.HTMLBody
*)
end;

procedure SendMailMAPI;
var
  Mailer:TMapiControl;  // Just for testing component
begin
(*
I have seen in Mapi.pas the InitMapi procedure.
The procedure try to read, in the registry key HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows Messaging Subsystem', the string MAPI. This string must have a value of 1. If the string MAPI is not found or it has a value not equal to 1 the  LoadLibrary(PChar(MAPIDLL)) is not executed.
In a PC with Outlook 2000 the string MAPI is defined and equal to 1.
In a PC with Outlook Express there is no MAPI string. If you define it and set equal to 1 the send mail is corretly executed (I hope).
Else you can try to modify the source of MAPI.PAS
*)
  Mailer:= TMapiControl.Create(nil);
  Mailer.Recipients.Clear;
  Mailer.AttachedFiles.Clear;
  Mailer.FromAdress:=gMailSender;
  Mailer.FromName:=gMailSender;
  Mailer.Recipients.Add( R);
  Mailer.Subject:=pSubjekt;
  Mailer.AttachedFiles.Add (S0);
  Mailer.Body:=pBody;
  Mailer.ShowDialog:=true;
  Mailer.Sendmail ;
  Mailer.Free;
end;

procedure SendMailNMSMTP;
var nmsmtp:Tnmsmtp;
begin
  nmsmtp:=tnmsmtp.create(NIL);
  nmsmtp.Host:=gMailConto; //127.0.0.1
  nmsmtp.PostMessage.Body.Clear;
  nmsmtp.PostMessage.Subject:=pSubjekt;
  nmsmtp.PostMessage.Body.Add(pBody);  {add as many lines as you want}
  nmsmtp.PostMessage.FromAddress:=gMailSender;
  nmsmtp.PostMessage.FromName:=gMailSender;
  nmsmtp.PostMessage.ReplyTo:=gMailConto;
  nmsmtp.PostMessage.ToAddress.Add(pRecipients);  {you can have lots of recipients}
  nmsmtp.Connect;
  nmsmtp.SendMail;
  nmsmtp.Disconnect;
  FreeandNil(nmsmtp)
end;

procedure SendMail;
var
  MM, MS : Variant;
  i : integer;
begin
  MS := CreateOleObject('MSMAPI.MAPISession');
  try
    MM := CreateOleObject('MSMAPI.MAPIMessages');
    try
      MS.DownLoadMail := False;
      MS.NewSession := False;
      MS.LogonUI := True;
      MS.SignOn;
      MM.SessionID := MS.SessionID;

      MM.Compose;

      MM.RecipIndex := 0;
      MM.RecipAddress := RecvAddress;
      MM.MsgSubject := Subject;
      MM.MsgNoteText := Body;

      for i := Low(Attachs) to High(Attachs) do
      begin
        MM.AttachmentIndex := i;
        MM.AttachmentPathName := Attachs[i];
      end;
      MM.Send(True);
      MS.SignOff;
    finally
      VarClear(MS);
    end;
  finally
    VarClear(MM);
  end;
end;

procedure SendOutlookMail;
const
  olMailItem = 0;
var
  Outlook: OleVariant;
  vRecipient, vMailItem: Olevariant;
begin
  try
    Outlook := GetActiveOleObject('Outlook.Application');
  except
    Outlook := CreateOleObject('Outlook.Application');
  end;
  vMailItem := Outlook.CreateItem(olMailItem);
  vRecipient := vMailItem.Recipients.Add(pRecipients);
  vMailItem.Subject := pSubjekt;
  vMailItem.Body := pBody;
  If pFile<>'' then vMailItem.Attachments.Add(pFile);
  vMailItem.Send;
  VarClear(Outlook);
  vMailItem := VarNull;
  vRecipient := VarNull;

end;

function  DecodeRoomType(pSt:Str1):Str20;
begin
  Result:='';
  case pSt[1] of
    '0' : Result:=cRoomTypes[1];
    '1','A': Result:=cRoomTypes[2];
    '2': Result:=cRoomTypes[3];
    '3': Result:=cRoomTypes[4];
    '4': Result:=cRoomTypes[5];
  end;
end;

function  DecodeVisStatus(pSt:Str1):Str20;
begin
  Result:='';
  case pSt[1] of
    'U': Result:='Ubytovany';
    'Z': Result:='Zaplatil';
    'O': Result:='Odubytovany';
  end;
end;

function  EncodeVisStatus(pSt:Str20):Str1;
begin
  Result:='';
  case pSt[1] of
    'U': Result:='U';
    'Z': Result:='Z';
    'O': Result:='O';
  end;
end;

function  DecodeHeadStatus(pSt:Str1):Str20;
begin
  Result:='';
  case pSt[1] of
    'E': Result:='Evidovaná'  ;
    'T': Result:='Terminovaná';
    'N': Result:='Neuhradená' ;
    'S': Result:='Stornovaná' ;

    'U': Result:='Obsadené'   ;
    'O': Result:='Ukonèené'   ;
    'D': Result:='Stornované' ;
    'Z': Result:='Zaplatené'  ;
  end;
end;

function  EncodeHeadStatus(pSt:Str20):Str1;
begin
  Result:='';
  case pSt[1] of
    'E': Result:='E';
    'T': Result:='T';
    'N': Result:='N';
    'S': Result:='S';

    'U': Result:='O';
    'O': Result:='U';
//  'S': Result:='D';
    'Z': Result:='Z';
  end;
end;

function  RoomCode2RoomNum(pRoomCode:Str30):longint; // zisti cislo izby podla kodu izby
var mRoomCode:Str15;
begin
  If Pos(#255,mRoomCode)=1 then mRoomCode:=copy(mRoomCode,2,255);
  mRoomCode:=pRoomCode; If Pos(#255,mRoomCode)>0 then mRoomCode:=copy(mRoomCode,1,Pos(#255,mRoomCode)-1);
  Result:=0;
  with dmHTL.btROL do begin
    SwapStatus;
    IndexName:='RoomCode';
    First;
    while not Eof and (FieldByName('RoomCode').AsString<>mRoomCode) do Next;
    If (FieldByName('RoomCode').AsString=mRoomCode) then Result:=FieldByName('RoomNum').AsInteger;
    RestoreStatus;
  end;
end;

function  RoomNum2RoomCode(pRoomNum:longint):Str15; // vrati kod izby podla cisla izby
var mOp:boolean;
begin
  mOP:=dmHTL.btROL.Active;If not mOP then dmHTL.btROL.Open;
  Result:='';
  with dmHTL.btROL do begin
    SwapIndex;        // rol.bdf
    IndexName:='RoomNum';
    If (FieldByName('RoomNum').AsInteger=pRoomNum) or  Findkey([pRoomNum]) then Result:=FieldByName('RoomCode').AsString;
    RestoreIndex;
  end;
  If not mOP then dmHTL.btROL.Close;
end;

// Display text vertically in StringGrid cells
// Vertikale Textausgabe in den Zellen eines StringGrid
procedure StringGridRotateTextOut(Grid: TStringGrid; ARow, ACol: Integer; Rect: TRect;
  Schriftart: string; Size: Integer; Color: TColor; Alignment: TAlignment);
var
  lf: TLogFont;
  tf: TFont;
begin
  // if the font is to big, resize it
  // wenn Schrift zu groß dann anpassen
  if (Size > Grid.ColWidths[ACol] div 2) then
    Size := Grid.ColWidths[ACol] div 2;
  with Grid.Canvas do
  begin
    // Replace the font
    // Font setzen
    Font.Name := Schriftart;
    Font.Size := Size;
    Font.Color := Color;
    tf := TFont.Create;
    try
      tf.Assign(Font);
      GetObject(tf.Handle, SizeOf(lf), @lf);
      lf.lfEscapement  := 900;
      lf.lfOrientation := 0;
      tf.Handle := CreateFontIndirect(lf);
      Font.Assign(tf);
    finally
      tf.Free;
    end;
    // fill the rectangle
    // Rechteck füllen
    FillRect(Rect);
    // Align text and write it
    // Text nach Ausrichtung ausgeben
    if Alignment = taLeftJustify then
      TextRect(Rect, Rect.Left + 2,Rect.Bottom - 2,Grid.Cells[ACol, ARow]);
    if Alignment = taCenter then
      TextRect(Rect, Rect.Left + Grid.ColWidths[ACol] div 2 - Size +
        Size div 3,Rect.Bottom - 2,Grid.Cells[ACol, ARow]);
    if Alignment = taRightJustify then
      TextRect(Rect, Rect.Right - Size - Size div 2 - 2,Rect.Bottom -
        2,Grid.Cells[ACol, ARow]);
  end;
end;

procedure StringGridRotateTextOut2(Grid:TStringGrid;ARow,ACol:Integer;Rect:TRect;
          Schriftart:String;Size:Integer;Color:TColor;Alignment:TAlignment);
var
    NewFont, OldFont : Integer;
    FontStyle, FontItalic, FontUnderline, FontStrikeout: Integer;
begin
   // if the font is to big, resize it
   // wenn Schrift zu groß dann anpassen
   If (Size > Grid.ColWidths[ACol] DIV 2) Then
       Size := Grid.ColWidths[ACol] DIV 2;
   with Grid.Canvas do
   begin
       // Set font
       // Font setzen
       If (fsBold IN Font.Style) Then
          FontStyle := FW_BOLD
       Else
          FontStyle := FW_NORMAL;

       If (fsItalic IN Font.Style) Then
          FontItalic := 1
       Else
          FontItalic := 0;

       If (fsUnderline IN Font.Style) Then
          FontUnderline := 1
       Else
          FontUnderline := 0;

       If (fsStrikeOut IN Font.Style) Then
          FontStrikeout:=1
       Else
          FontStrikeout:=0;

       Font.Color := Color;

       NewFont := CreateFont(Size, 0, 900, 0, FontStyle, FontItalic,
                             FontUnderline, FontStrikeout, DEFAULT_CHARSET,
                             OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                             DEFAULT_PITCH, PChar(Schriftart));

       OldFont := SelectObject(Handle, NewFont);
       // fill the rectangle
       // Rechteck füllen
       FillRect(Rect);
       // Write text depending on the alignment
       // Text nach Ausrichtung ausgeben
       If Alignment = taLeftJustify Then
          TextRect(Rect,Rect.Left+2,Rect.Bottom-2,Grid.Cells[ACol,ARow]);
       If Alignment = taCenter Then
          TextRect(Rect,Rect.Left+Grid.ColWidths[ACol] DIV 2 - Size + Size DIV 3,
            Rect.Bottom-2,Grid.Cells[ACol,ARow]);
       If Alignment = taRightJustify Then
          TextRect(Rect,Rect.Right-Size - Size DIV 2 - 2,Rect.Bottom-2,Grid.Cells[ACol,ARow]);

       // Recreate reference to the old font
       // Referenz auf alten Font wiederherstellen
       SelectObject(Handle, OldFont);
       // Recreate reference to the new font
       // Referenz auf neuen Font löschen
       DeleteObject(NewFont);
   end;
end;

procedure TdmHTL.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName := gPath.HTLPath;
      (Components[I] as TNexBtrTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName := gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName := gPath.SubPrivPath;
  end;
end;

//*****************************************************************************

procedure TdmHTL.btRSHAfterOpen(DataSet: TDataSet);
begin
//
end;

//********************************** Cisla otvorenych knih *********************************

procedure TdmHTL.ptATUBeforeOpen(DataSet: TDataSet);
begin
  ptATU.FieldDefs.Clear;
  ptATU.FieldDefs.Add ('Datum',ftDate,0,FALSE);
  ptATU.FieldDefs.Add ('Cas',ftTime,0,FALSE);
  ptATU.FieldDefs.Add ('Num',ftInteger,0,FALSE);
  ptATU.FieldDefs.Add ('Klapka',ftString,5,FALSE);
  ptATU.FieldDefs.Add ('Linka',ftString,18,FALSE);
  ptATU.FieldDefs.Add ('VolaneC',ftString,28,FALSE);
  ptATU.FieldDefs.Add ('VolanaO',ftString,28,FALSE);
  ptATU.FieldDefs.Add ('Dlzka',ftTime,0,FALSE);
  ptATU.FieldDefs.Add ('Cena',ftFloat,0,FALSE);

  ptATU.IndexDefs.Clear;
  ptATU.IndexDefs.Add ('','Datum;Cas;Num',[ixPrimary]);
  ptATU.CreateTable;
end;

procedure TdmHTL.RSI_To_TMP;
var mI    : integer;
begin
  for mI:=0 to ptRSI.FieldCount-1 do begin
    If Pos('_',btRSI.FieldDefs[mi].Name)=0
      then ptRSI.FieldByName (btRSI.FieldDefs[mi].Name).AsString := btRSI.FieldByName (btRSI.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.RSS_To_TMP;
var mI    : integer;
begin
  for mI:=0 to ptRSS.FieldCount-1 do begin
    If Pos('_',btRSS.FieldDefs[mi].Name)=0
      then ptRSS.FieldByName (btRSS.FieldDefs[mi].Name).AsString := btRSS.FieldByName (btRSS.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.RSP_To_TMP;
var mI    : integer;
begin
  for mI:=0 to ptRSP.FieldCount-1 do begin
    If Pos('_',btRSP.FieldDefs[mi].Name)=0
      then ptRSP.FieldByName (btRSP.FieldDefs[mi].Name).AsString := btRSP.FieldByName (btRSP.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.TNI_To_TMP;
var mI    : integer;
begin
  for mI:=0 to ptTNI.FieldCount-1 do begin
    If Pos('_',btTNI.FieldDefs[mi].Name)=0
      then ptTNI.FieldByName (btTNI.FieldDefs[mi].Name).AsString := btTNI.FieldByName (btTNI.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.TNP_To_TMP;
var mI    : integer;
begin
  for mI:=0 to ptTNP.FieldCount-1 do begin
    If Pos('_',btTNP.FieldDefs[mi].Name)=0
      then ptTNP.FieldByName (btTNP.FieldDefs[mi].Name).AsString := btTNP.FieldByName (btTNP.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.InsTNB_To_TMP;
var mI    : integer;
begin
  If btTNS.FieldByName('Status').AsString='S' then begin
    ptTNB.Insert;
    for mI:=0 to btTNS.FieldCount-1 do begin
      If Pos('_',btTNS.FieldDefs[mi].Name)=0
        then ptTNB.FieldByName (btTNS.FieldDefs[mi].Name).AsString := btTNS.FieldByName (btTNS.FieldDefs[mi].Name).AsString;
    end;
    ptTNB.Post;
  end;
end;

procedure TdmHTL.InsTNS_To_TMP;
var mI    : integer;
begin
  If {(btTNS.FieldByName('Status').AsString<>'S')and}(btTNS.FieldByName('Status').AsString<>'S') then begin
    ptTNS.Insert;
    for mI:=0 to btTNS.FieldCount-1 do begin
      If Pos('_',btTNS.FieldDefs[mi].Name)=0
        then ptTNS.FieldByName (btTNS.FieldDefs[mi].Name).AsString := btTNS.FieldByName (btTNS.FieldDefs[mi].Name).AsString;
    end;
    ptTNS.Post;
  end;
end;

procedure TdmHTL.TNV_To_TMP;
var mI    : integer;
begin
  for mI:=0 to btTNV.FieldCount-1 do begin
    If Pos('_',btTNV.FieldDefs[mi].Name)=0
      then ptTNV.FieldByName (btTNV.FieldDefs[mi].Name).AsString := btTNV.FieldByName (btTNV.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.TNS_To_TNS2;
var mI    : integer;
begin
  for mI:=0 to ptTNS2.FieldCount-1 do begin
    ptTNS2.FieldByName (ptTNS2.FieldDefs[mi].Name).AsString := ptTNS.FieldByName (ptTNS.FieldDefs[mi].Name).AsString;
  end;
end;

procedure TdmHTL.TNS2_Slct_To_TNS;
var mI,mSN    : integer;
begin
  If not Eq3(ptTNS2.FieldByName ('Quant').AsFloat,ptTNS2.FieldByName ('SlctQnt').AsFloat) then begin
    ptTNS.SwapIndex;ptTNS.IndexName:='';
    btTNS.SwapIndex;btTNS.IndexName:='SerNum';btTNS.Last;mSN:=btTNS.fieldbyName('Sernum').AsInteger+1;
    btTNS.Insert;
    for mI:=0 to btTNS.FieldCount-1 do begin
      If ptTNS2.FindField(btTNS.FieldDefs[mi].Name)<> NIL
        then btTNS.FieldByName (btTNS.FieldDefs[mi].Name).AsString := ptTNS2.FieldByName (btTNS.FieldDefs[mi].Name).AsString;
    end;
    btTNS.FieldByName ('SerNum').AsInteger :=mSN;
    btTNS.FieldByName ('Quant').AsFloat    :=btTNS.FieldByName ('Quant').AsFloat    -ptTNS2.FieldByName ('SlctQnt').AsFloat;
    btTNS.FieldByName ('BValue').AsFloat   :=btTNS.FieldByName ('BValue').AsFloat   -ptTNS2.FieldByName ('SlctBval').AsFloat;
    btTNS.FieldByName ('AValue').AsFloat   :=btTNS.FieldByName ('AValue').AsFloat   -ptTNS2.FieldByName ('SlctAVal').AsFloat;
    btTNS.Post;

    InsTNS_To_TMP;

    If btTNS.FindKey([ptTNS2.FieldByName ('SerNum').AsInteger]) then
    begin
      btTNS.Edit;
      btTNS.FieldByName ('Quant').AsFloat    :=ptTNS2.FieldByName ('SlctQnt').AsFloat;
      btTNS.FieldByName ('BValue').AsFloat   :=ptTNS2.FieldByName ('SlctBval').AsFloat;
      btTNS.FieldByName ('AValue').AsFloat   :=ptTNS2.FieldByName ('SlctAVal').AsFloat;
      btTNS.Post;
    end;
    If ptTNS.FindKey([ptTNS2.FieldByName ('SerNum').AsInteger]) then
    begin
      ptTNS.Edit;
      ptTNS.FieldByName ('Quant').AsFloat    :=ptTNS2.FieldByName ('SlctQnt').AsFloat;
      ptTNS.FieldByName ('BValue').AsFloat   :=ptTNS2.FieldByName ('SlctBval').AsFloat;
      ptTNS.FieldByName ('AValue').AsFloat   :=ptTNS2.FieldByName ('SlctAVal').AsFloat;
      ptTNS.Post;
    end;
    btTNS.RestoreIndex;ptTNS.RestoreIndex;
    ptTNS2.Edit;
    ptTNS2.FieldByName ('Quant').AsFloat    :=ptTNS2.FieldByName ('SlctQnt').AsFloat;
    ptTNS2.FieldByName ('BValue').AsFloat   :=ptTNS2.FieldByName ('SlctBval').AsFloat;
    ptTNS2.FieldByName ('AValue').AsFloat   :=ptTNS2.FieldByName ('SlctAVal').AsFloat;
    ptTNS2.FieldByName ('SlctQnt').AsFloat  :=0;
    ptTNS2.FieldByName ('SlctBVal').AsFloat :=0;
    ptTNS2.FieldByName ('SlctAVal').AsFloat :=0;
    ptTNS2.Post;
  end;
end;

procedure TdmHTL.InsROL_To_TMP;
var mI    : integer;
begin
  ptROL.Insert;
  for mI:=0 to btROL.FieldCount-1 do begin
    If (Pos('_',btROL.FieldDefs[mi].Name)=0) and (ptROL.FindField (btROL.FieldDefs[mi].Name)<>NIL)
      then ptROL.FieldByName (btROL.FieldDefs[mi].Name).AsString := btROL.FieldByName (btROL.FieldDefs[mi].Name).AsString;
  end;
  ptROL.Post;
end;

procedure TdmHTL.TNH_To_TMP;
var mI    : integer;
begin
  for mI:=0 to btTNH.FieldCount-1 do begin
    If (Pos('_',btTNH.FieldDefs[mi].Name)=0) and (ptTNH.FindField(btTNH.FieldDefs[mi].Name)<>NIL)
      then ptTNH.FieldByName (btTNH.FieldDefs[mi].Name).AsString := btTNH.FieldByName (btTNH.FieldDefs[mi].Name).AsString;
  end;
end;

(*
procedure TdmHTL.TNS_To_TNB;
begin
//Days        longint      ;
//-
//Daily       Str1         ;
//Status      Str1         ;
  btTNB.FieldByName ('SerNum').AsString  := btTNS.FieldByName ('SerNum').AsString;
  btTNB.FieldByName ('TentNum').AsString := btTNS.FieldByName ('TentNum').AsString;
  btTNB.FieldByName ('RoomNum').AsString := btTNS.FieldByName ('RoomNum').AsString;
  btTNB.FieldByName ('VisNum').AsInteger := btTNS.FieldByName ('VisNum').AsInteger;
  btTNB.FieldByName ('Group').AsInteger  := btTNS.FieldByName ('Group').AsInteger;
  btTNB.FieldByName ('SrvCode').AsInteger:= btTNS.FieldByName ('SrvCode').AsInteger;
  btTNB.FieldByName ('GsCode').AsInteger := btTNS.FieldByName ('GsCode').AsInteger;
  btTNB.FieldByName ('MgCode').AsInteger := btTNS.FieldByName ('MgCode').AsInteger;
  btTNB.FieldByName ('GsName').AsString  := btTNS.FieldByName ('GsName').AsString;
  btTNB.FieldByName ('VatPrc').AsFloat   := btTNS.FieldByName ('VatPrc').AsFloat;
  btTNB.FieldByName ('APrice').AsFloat   := btTNS.FieldByName ('APrice').AsFloat;
  btTNB.FieldByName ('Quant').AsFloat    := btTNS.FieldByName ('Quant').AsFloat;
  btTNB.FieldByName ('AValue').AsFloat   := btTNS.FieldByName ('AValue').AsFloat;
  btTNB.FieldByName ('BPrice').AsFloat   := btTNS.FieldByName ('BPrice').AsFloat;
  btTNB.FieldByName ('BValue').AsFloat   := btTNS.FieldByName ('BValue').AsFloat;
end;
*)
procedure TdmHTL.btSrvAfterOpen(DataSet: TDataSet);
begin
    btSrv.IndexName:='SrvCode';
    If not btSrv.FindKey([1]) then begin
      btSrv.Insert;
      btSrv.FieldByName('SrvCode').AsInteger:=1;
      btSrv.FieldByName('MgCode').AsInteger :=1;
      btSrv.FieldByName('GsName').AsString  :='Ubytovanie-lozko';
//      btSrv.FieldByName('_GsName').AsString:='UBYTOVANIE-LOZK';
      btSrv.FieldByName('VatPrc').AsFloat   := gIni.GetVatPrc(2);
      btSrv.FieldByName('APrice').AsFloat   := cBedPrice/(1+gIni.GetVatPrc(2)/100);
      btSrv.FieldByName('BPrice').AsFloat   := cBedPrice;
      btSrv.FieldByName('Daily').AsString   := 'A';
      btSrv.FieldByName('QntMod').AsString  := 'N';
      btSrv.FieldByName('MsName').AsString  := '';
      btSrv.Post;
    end;
    If not btSrv.FindKey([2]) then begin
      btSrv.Insert;
      btSrv.FieldByName('SrvCode').AsInteger:=2;
      btSrv.FieldByName('MgCode').AsInteger :=1;
      btSrv.FieldByName('GsName').AsString  :='Ubytovanie-pristelok';
//      btSrv.FieldByName('_GsName').AsString:='UBYTOVANIE-PRIS';
      btSrv.FieldByName('VatPrc').AsFloat   := gIni.GetVatPrc(2);
      btSrv.FieldByName('APrice').AsFloat   := cAdbPrice/(1+gIni.GetVatPrc(2)/100);
      btSrv.FieldByName('BPrice').AsFloat   := cAdbPrice;
      btSrv.FieldByName('Daily').AsString   := 'A';
      btSrv.FieldByName('QntMod').AsString  := 'N';
      btSrv.FieldByName('MsName').AsString  := '';
      btSrv.Post;
    end;
    If not btSrv.FindKey([3]) then begin
      btSrv.Insert;
      btSrv.FieldByName('SrvCode').AsInteger:=3;
      btSrv.FieldByName('MgCode').AsInteger :=1;
      btSrv.FieldByName('GsName').AsString  :='Ubytovanie-izba';
//      btSrv.FieldByName('_GsName').AsString:='UBYTOVANIE-IZBA';
      btSrv.FieldByName('VatPrc').AsFloat   := gIni.GetVatPrc(2);
      btSrv.FieldByName('APrice').AsFloat   := cRoomPrice/(1+gIni.GetVatPrc(2)/100);
      btSrv.FieldByName('BPrice').AsFloat   := cRoomPrice;
      btSrv.FieldByName('Daily').AsString   := 'A';
      btSrv.FieldByName('QntMod').AsString  := 'N';
      btSrv.FieldByName('MsName').AsString  := '';
      btSrv.Post;
    end;
end;

procedure TdmHTL.T_HtlDatTimer(Sender: TObject);
var I: integer;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TBtrieveTable) then begin
      If (Components[I] as TBtrieveTable).Active and ((Components[I] as TBtrieveTable).State = dsBrowse) then (Components[I] as TBtrieveTable).Refresh;
    end;
   end;
end;

procedure TdmHTL.btVISBeforePost(DataSet: TDataSet);
begin
  If btVIS.fieldbyName('VisType').AsString='-'    then btVIS.fieldbyName('VisType').AsString := '0';
  If btVIS.fieldbyName('VisDocType').AsString='-' then btVIS.fieldbyName('VisDocType').AsString := '0';
end;

procedure TdmHTL.btTNVBeforePost(DataSet: TDataSet);
begin
  If btTNV.fieldbyName('VisType').AsString='-'    then btTNV.fieldbyName('VisType').AsString := '0';
  If btTNV.fieldbyName('VisDocType').AsString='-' then btTNV.fieldbyName('VisDocType').AsString := '0';
end;

end.
(*
---------------------------------------------
---------------------------------------------
---------------------------------------------
---------------------------------------------

*
bTNH
