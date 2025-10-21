unit BsmPrp;
// =============================================================================
//                    PREDVOLEN… NASTAVENIA PRE BANKOV… V›PISY
// -----------------------------------------------------------------------------
// ****************************** POPIS PARAMETROV *****************************
// -----------------------------------------------------------------------------
//                          NASTAVENIA PRE VäETKY KNIHY
// ClrEmp - Farba pr·zdnych bankov˝ch v˝pisov
// ClrErr - Farba nedokonËen˝ch bankov˝ch v˝pisov
// ClrNac - Farba neza˙Ëtovan˝ch bankov˝ch v˝pisov
// ClrAcc - Farba za˙Ëtovan˝ch bankov˝ch v˝pisov
// ClrCrd - Farba poloûky prich·dzaj˙cej platby
// ClrDeb - Farba poloûky odch·dzaj˙cej platby
// ClrSum - Farba poloûky s˙hrnnej platby
// AccSnt - Syntytick· Ëasù ˙Ëtu pre nerozpoznanÈ poloûky elektron. bankovnÌctva
// AccAnl - Analytick· Ëasù ˙Ëtu pre nerozpoznanÈ poloûky elektron. bankovnÌctva
// -----------------------------------------------------------------------------
//                             Z¡KLADN… ⁄DAJE KNIHY
// BokNam[BokNum] - N·zov knihy
// DvzNam[BokNum] - Mena bankovÈho ˙Ëtu
// BanIba[BokNum] - IBAN bankovÈho ˙Ëtu
// BanNam[BokNum] - N·zov banky
// -----------------------------------------------------------------------------
//                        BEZPE»NOSTN¡ OCHRANA DOKLAODV
// PrnCls[BokNum] - Automaticky uzamkn˙ù doklad po jeho vytlaËenÌ
// UlcRsn[BokNum] - Povinne zad·vaù dÙvod odblokovania dokladu
// MthDoc[BokNum] - Ak parameter je zapnut˝ v˝pisy bud˙ mesaËnÈ in·Ë dennÈ
// NotVer[BokNum] - Ak parameter je zapnut˝ nebude kontrolovan˝ koneËn˝ stav
//                  v˝pisu s kumulatÌvnou hodnotou poloûie a koneËn˝ stav vûdy
//                  bude prepoËÌtan˝ pri zmene bankovÈho v˝pisu.
// -----------------------------------------------------------------------------
//                        FINAN»N… ⁄DAJE BANKOV…HO ⁄»TU
// AccBeg[BokNum] - PoËiatoËn˝ stav ˙Ëtu v ˙Ëtovnej mene
// PayBeg[BokNum] - PoËiatoËn˝ stav ˙Ëtu v mene bankovÈho ˙Ëtu
// MaxDif[BokNum] - Maxim·lna hodnota roydielu ˙hrady v mene bankovÈho ˙Ëtu
// -----------------------------------------------------------------------------
//                     PREDVOLEN… NASTAVENIA PRE ⁄»TOVNÕCTVO
// AccSnt[BokNum] - Syntytick· Ëasù ˙Ëtu banky
// AccAnl[BokNum] - Analytick· Ëasù ˙Ëtu banky
// AutAcc[BokNum] - AutomatickÈ roz˙Ëtovanie bankovÈho v˝pisu
// WriNum[BokNum] - Predvolen· prev·dzkov· jednotka danej knihy
// -----------------------------------------------------------------------------
//                          ELEKTRONICK… BANKOVNÕCTVO
// EbaTyp[BokNum] - Typ pouûÌtÈho elektronickÈho bankovnÌctva (SEPA,...)
// EbaDir[BokNum] - Adres·r elektronickÈho bankovÈho v˝pisu
// -----------------------------------------------------------------------------
//                                R›CHLE POLOéKY
// PayDes[ButNum] - Textov˝ popis poloûky
// PayVal[ButNum] - Hodnota poloûky
// PaySnt[ButNum] - ⁄Ëtovnej predpis poloûky - syntetick· Ëasù ˙Ëtu
// PayAnl[ButNum] - ⁄Ëtovnej predpis poloûky - analytick· Ëasù ˙Ëtu
// -----------------------------------------------------------------------------
// ********************************* POZN¡MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST”RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[23.02.19] - vytvorenie unitu
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, UsrFnc,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TBsmPrp=class
  private
    // -------------------- Nastavenia pre vöetky knihy  -----------------------
    function GetClrEmp:integer;   procedure SetClrEmp(pValue:integer);
    function GetClrErr:integer;   procedure SetClrErr(pValue:integer);
    function GetClrNac:integer;   procedure SetClrNac(pValue:integer);
    function GetClrAcc:integer;   procedure SetClrAcc(pValue:integer);
    function GetClrCrd:integer;   procedure SetClrCrd(pValue:integer);
    function GetClrDeb:integer;   procedure SetClrDeb(pValue:integer);
    function GetClrSum:integer;   procedure SetClrSum(pValue:integer);
    function GetNidSnt:Str3;      procedure SetNidSnt(pValue:Str3);
    function GetNidAnl:Str6;      procedure SetNidAnl(pValue:Str6);
    // ---------------------------- Nastavenia pre vybran˙ knihy  -----------------------------
    function GetBokNam(pBokNum:Str3):Str50;   procedure SetBokNam(pBokNum:Str3;pValue:Str50);
    function GetDvzNam(pBokNum:Str3):Str3;    procedure SetDvzNam(pBokNum:Str3;pValue:Str3);
    function GetBanIba(pBokNum:Str3):Str30;   procedure SetBanIba(pBokNum:Str3;pValue:Str30);
    function GetBanNam(pBokNum:Str3):Str30;   procedure SetBanNam(pBokNum:Str3;pValue:Str30);
    // ---------------------------- BezpeËnostn· ochrana dokladov -----------------------------
    function GetPrnCls(pBokNum:Str3):boolean; procedure SetPrnCls(pBokNum:Str3;pValue:boolean);
    function GetUlcRsn(pBokNum:Str3):boolean; procedure SetUlcRsn(pBokNum:Str3;pValue:boolean);
    function GetMthDoc(pBokNum:Str3):boolean; procedure SetMthDoc(pBokNum:Str3;pValue:boolean);
    function GetNotVer(pBokNum:Str3):boolean; procedure SetNotVer(pBokNum:Str3;pValue:boolean);
    // ---------------------------- FinanËnÈ ˙daje bankovÈho ˙Ëtu -----------------------------
    function GetAccBeg(pBokNum:Str3):double;  procedure SetAccBeg(pBokNum:Str3;pValue:double);
    function GetPayBeg(pBokNum:Str3):double;  procedure SetPayBeg(pBokNum:Str3;pValue:double);
    function GetMaxDif(pBokNum:Str3):double;  procedure SetMaxDif(pBokNum:Str3;pValue:double);
    // ------------------------ PredvolenÈ nastavenia pre ˙ËtovnÌctvo -------------------------
    function GetAccSnt(pBokNum:Str3):Str3;    procedure SetAccSnt(pBokNum:Str3;pValue:Str3);
    function GetAccAnl(pBokNum:Str3):Str6;    procedure SetAccAnl(pBokNum:Str3;pValue:Str6);
    function GetAutAcc(pBokNum:Str3):boolean; procedure SetAutAcc(pBokNum:Str3;pValue:boolean);
    function GetWriNum(pBokNum:Str3):word;    procedure SetWriNum(pBokNum:Str3;pValue:word);
    // ------------------------------ ElektronickÈ bankovnÌctvo -------------------------------
    function GetEbaTyp(pBokNum:Str3):byte;    procedure SetEbaTyp(pBokNum:Str3;pValue:byte);
    function GetEbaDir(pBokNum:Str3):Str250;  procedure SetEbaDir(pBokNum:Str3;pValue:Str250);
    // ----------------------------------- R˝chle poloûky -------------------------------------
    function GetPayDes(pBokNum:Str3;pButNum:byte):Str60;   procedure SetPayDes(pBokNum:Str3;pButNum:byte;pValue:Str60);
    function GetPayVal(pBokNum:Str3;pButNum:byte):double;  procedure SetPayVal(pBokNum:Str3;pButNum:byte;pValue:double);
    function GetPaySnt(pBokNum:Str3;pButNum:byte):Str3;    procedure SetPaySnt(pBokNum:Str3;pButNum:byte;pValue:Str3);
    function GetPayAnl(pBokNum:Str3;pButNum:byte):Str6;    procedure SetPayAnl(pBokNum:Str3;pButNum:byte;pValue:Str6);
  public
    // -------------------- Nastavenia pre vöetky knihy  -----------------------
    property ClrEmp:integer read GetClrEmp write SetClrEmp;
    property ClrErr:integer read GetClrErr write SetClrErr;
    property ClrNac:integer read GetClrNac write SetClrNac;
    property ClrAcc:integer read GetClrAcc write SetClrAcc;
    property ClrCrd:integer read GetClrCrd write SetClrCrd;
    property ClrDeb:integer read GetClrDeb write SetClrDeb;
    property ClrSum:integer read GetClrSum write SetClrSum;
    property NidSnt:Str3 read GetNidSnt write SetNidSnt;
    property NidAnl:Str6 read GetNidAnl write SetNidAnl;
    // -------------------- Nastavenia pre vybran˙ knihy  ----------------------
    property BokNam[pBokNum:Str3]:Str50 read GetBokNam write SetBokNam;
    property DvzNam[pBokNum:Str3]:Str3 read GetDvzNam write SetDvzNam;
    property BanIba[pBokNum:Str3]:Str30 read GetBanIba write SetBanIba;
    property BanNam[pBokNum:Str3]:Str30 read GetBanNam write SetBanNam;
    // ------------------- BezpeËnostn· ochrana dokladov -----------------------
    property PrnCls[pBokNum:Str3]:boolean read GetPrnCls write SetPrnCls;
    property UlcRsn[pBokNum:Str3]:boolean read GetUlcRsn write SetUlcRsn;
    property MthDoc[pBokNum:Str3]:boolean read GetMthDoc write SetMthDoc;
    property NotVer[pBokNum:Str3]:boolean read GetNotVer write SetNotVer;
    // ------------------- FinanËnÈ ˙daje bankovÈho ˙Ëtu -----------------------
    property AccBeg[pBokNum:Str3]:double read GetAccBeg write SetAccBeg;
    property PayBeg[pBokNum:Str3]:double read GetPayBeg write SetPayBeg;
    property MaxDif[pBokNum:Str3]:double read GetMaxDif write SetMaxDif;
    // ---------------- PredvolenÈ nastavenia pre ˙ËtovnÌctvo ------------------
    property AccSnt[pBokNum:Str3]:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl[pBokNum:Str3]:Str6 read GetAccAnl write SetAccAnl;
    property AutAcc[pBokNum:Str3]:boolean read GetAutAcc write SetAutAcc;
    property WriNum[pBokNum:Str3]:word read GetWriNum write SetWriNum;
    // -------------------------------------------------------------------------
    property EbaTyp[pBokNum:Str3]:byte read GetEbaTyp write SetEbaTyp;
    property EbaDir[pBokNum:Str3]:Str250 read GetEbaDir write SetEbaDir;
    // --------------------------- R˝chle poloûky ------------------------------
    property PayDes[pBokNum:Str3;pButNum:byte]:Str60 read GetPayDes write SetPayDes;
    property PayVal[pBokNum:Str3;pButNum:byte]:double read GetPayVal write SetPayVal;
    property PaySnt[pBokNum:Str3;pButNum:byte]:Str3 read GetPaySnt write SetPaySnt;
    property PayAnl[pBokNum:Str3;pButNum:byte]:Str6 read GetPayAnl write SetPayAnl;
  end;

implementation

uses ePRPLST;

// ******************************** PRIVATE ************************************

function TBsmPrp.GetClrEmp:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrEmp',TColor(clGray));
end;

procedure TBsmPrp.SetClrEmp(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrEmp',pValue);
end;

function TBsmPrp.GetClrErr:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrErr',TColor(clRed));
end;

procedure TBsmPrp.SetClrErr(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrErr',pValue);
end;

function TBsmPrp.GetClrNac:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrNac',TColor(clBlue));
end;

procedure TBsmPrp.SetClrNac(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrNac',pValue);
end;

function TBsmPrp.GetClrAcc:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrAcc',TColor(clBlack));
end;

procedure TBsmPrp.SetClrAcc(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrAcc',pValue);
end;

function TBsmPrp.GetClrCrd:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrCrd',TColor(clBlack));
end;

procedure TBsmPrp.SetClrCrd(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrCrd',pValue);
end;

function TBsmPrp.GetClrDeb:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrDeb',TColor(clRed));
end;

procedure TBsmPrp.SetClrDeb(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrDeb',pValue);
end;

function TBsmPrp.GetClrSum:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM','','ClrSum',TColor(clBlue));
end;

procedure TBsmPrp.SetClrSum(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('BSM','','ClrSum',pValue);
end;

function TBsmPrp.GetBokNam(pBokNum:Str3):Str50;
begin
  Result:='';
  If gUsr.ohBOKLST.LocPmBn('BSM',pBokNum) then Result:=gUsr.ohBOKLST.BokNam;
end;

function TBsmPrp.GetNidSnt:Str3;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM','','NidSnt','');
end;

procedure TBsmPrp.SetNidSnt(pValue:Str3);
begin
  gUsr.ohPRPLST.WriteString('BSM','','NidSnt',pValue);
end;

function TBsmPrp.GetNidAnl:Str6;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM','','NidAnl','');
end;

procedure TBsmPrp.SetNidAnl(pValue:Str6);
begin
  gUsr.ohPRPLST.WriteString('BSM','','NidAnl',pValue);
end;

procedure TBsmPrp.SetBokNam(pBokNum:Str3;pValue:Str50);
begin
  With gUsr do begin
    If ohBOKLST.LocPmBn('BSM',pBokNum) then begin
      If ohBOKLST.BokNam<>pValue then begin
        ohBOKLST.Edit;
        ohBOKLST.BokNam:=pValue;
        ohBOKLST.Post;
      end;
    end else begin
      ohBOKLST.Insert;
      ohBOKLST.PmdCod:='BSM';
      ohBOKLST.BokNum:=pBokNum;
      ohBOKLST.BokNam:=pValue;
      ohBOKLST.CrtUsr:=gUsr.UsrLog;
      ohBOKLST.CrtUsn:=gUsr.UsrNam;
      ohBOKLST.CrtDte:=Date;
      ohBOKLST.CrtTim:=Time;
      ohBOKLST.Post;
    end;
  end;
end;

function TBsmPrp.GetDvzNam(pBokNum:Str3):Str3;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,'DvzNam','EUR');
end;

procedure TBsmPrp.SetDvzNam(pBokNum:Str3;pValue:Str3);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,'DvzNam',pValue);
end;

function TBsmPrp.GetBanIba(pBokNum:Str3):Str30;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,'BanIba','');
end;

procedure TBsmPrp.SetBanIba(pBokNum:Str3;pValue:Str30);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,'BanIba',pValue);
end;

function TBsmPrp.GetBanNam(pBokNum:Str3):Str30;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,'BanNam','');
end;

procedure TBsmPrp.SetBanNam(pBokNum:Str3;pValue:Str30);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,'BanNam',pValue);
end;

function TBsmPrp.GetPrnCls(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('BSM',pBokNum,'PrnCls',FALSE);
end;

procedure TBsmPrp.SetPrnCls(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('BSM',pBokNum,'PrnCls',pValue);
end;

function TBsmPrp.GetUlcRsn(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('BSM',pBokNum,'UlcRsn',FALSE);
end;

procedure TBsmPrp.SetUlcRsn(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('BSM',pBokNum,'UlcRsn',pValue);
end;

function TBsmPrp.GetMthDoc(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('BSM',pBokNum,'MthDoc',FALSE);
end;

procedure TBsmPrp.SetMthDoc(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('BSM',pBokNum,'MthDoc',pValue);
end;

function TBsmPrp.GetNotVer(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('BSM',pBokNum,'NotVer',FALSE);
end;

procedure TBsmPrp.SetNotVer(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('BSM',pBokNum,'NotVer',pValue);
end;

function TBsmPrp.GetAccBeg(pBokNum:Str3):double;
begin
  Result:=gUsr.ohPRPLST.ReadFloat('BSM',pBokNum,'RepOdn',0,2);
end;

procedure TBsmPrp.SetAccBeg(pBokNum:Str3;pValue:double);
begin
  gUsr.ohPRPLST.WriteFloat('BSM',pBokNum,'AccBeg',pValue,2);
end;

function TBsmPrp.GetPayBeg(pBokNum:Str3):double;
begin
  Result:=gUsr.ohPRPLST.ReadFloat('BSM',pBokNum,'PayBeg',0,2);
end;

procedure TBsmPrp.SetPayBeg(pBokNum:Str3;pValue:double);
begin
  gUsr.ohPRPLST.WriteFloat('BSM',pBokNum,'PayBeg',pValue,2);
end;

function TBsmPrp.GetMaxDif(pBokNum:Str3):double;
begin
  Result:=gUsr.ohPRPLST.ReadFloat('BSM',pBokNum,'MaxDif',0,2);
end;

procedure TBsmPrp.SetMaxDif(pBokNum:Str3;pValue:double);
begin
  gUsr.ohPRPLST.WriteFloat('BSM',pBokNum,'MaxDif',pValue,2);
end;

function TBsmPrp.GetAccSnt(pBokNum:Str3):Str3;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,'AccSnt','');
end;

procedure TBsmPrp.SetAccSnt(pBokNum:Str3;pValue:Str3);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,'AccSnt',pValue);
end;

function TBsmPrp.GetAccAnl(pBokNum:Str3):Str6;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,'AccAnl','');
end;

procedure TBsmPrp.SetAccAnl(pBokNum:Str3;pValue:Str6);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,'AccAnl',pValue);
end;

function TBsmPrp.GetAutAcc(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('BSM',pBokNum,'AutAcc',TRUE);
end;

procedure TBsmPrp.SetAutAcc(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('BSM',pBokNum,'AutAcc',pValue);
end;

function TBsmPrp.GetWriNum(pBokNum:Str3):word;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM',pBokNum,'WriNum',0);
end;

procedure TBsmPrp.SetWriNum(pBokNum:Str3;pValue:word);
begin
  gUsr.ohPRPLST.WriteInteger('BSM',pBokNum,'WriNum',pValue);
end;

function TBsmPrp.GetEbaTyp(pBokNum:Str3):byte;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('BSM',pBokNum,'EbaTyp',0);
end;

procedure TBsmPrp.SetEbaTyp(pBokNum:Str3;pValue:byte);
begin
  gUsr.ohPRPLST.WriteInteger('BSM',pBokNum,'EbaTyp',pValue);
end;

function TBsmPrp.GetEbaDir(pBokNum:Str3):Str250;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,'EbaDir','');
end;

procedure TBsmPrp.SetEbaDir(pBokNum:Str3;pValue:Str250);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,'EbaDir',pValue);
end;

function TBsmPrp.GetPayDes(pBokNum:Str3;pButNum:byte):Str60;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,StrIntZero(pButNum,2),'PayDes','');
end;

procedure TBsmPrp.SetPayDes(pBokNum:Str3;pButNum:byte;pValue:Str60);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,StrIntZero(pButNum,2),'PayDes',pValue);
end;

function TBsmPrp.GetPayVal(pBokNum:Str3;pButNum:byte):double;
begin
  Result:=gUsr.ohPRPLST.ReadFloat('BSM',pBokNum,StrIntZero(pButNum,2),'PayVal',0,2);
end;

procedure TBsmPrp.SetPayVal(pBokNum:Str3;pButNum:byte;pValue:double);
begin
  gUsr.ohPRPLST.WriteFloat('BSM',pBokNum,StrIntZero(pButNum,2),'PayVal',pValue,2);
end;

function TBsmPrp.GetPaySnt(pBokNum:Str3;pButNum:byte):Str3;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,StrIntZero(pButNum,2),'PaySnt','');
end;

procedure TBsmPrp.SetPaySnt(pBokNum:Str3;pButNum:byte;pValue:Str3);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,StrIntZero(pButNum,2),'PaySnt',pValue);
end;

function TBsmPrp.GetPayAnl(pBokNum:Str3;pButNum:byte):Str6;
begin
  Result:=gUsr.ohPRPLST.ReadString('BSM',pBokNum,StrIntZero(pButNum,2),'PayAnl','');
end;

procedure TBsmPrp.SetPayAnl(pBokNum:Str3;pButNum:byte;pValue:Str6);
begin
  gUsr.ohPRPLST.WriteString('BSM',pBokNum,StrIntZero(pButNum,2),'PayAnl',pValue);
end;

// ********************************* PUBLIC ************************************

end.


