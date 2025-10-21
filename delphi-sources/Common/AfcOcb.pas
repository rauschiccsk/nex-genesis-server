unit AfcOcb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcOcb = class (TAfcBas)
  private
    // ---------------------------- Úpravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocDsc:boolean;    procedure WriteDocDsc(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadDocRnd:boolean;    procedure WriteDocRnd(pValue:boolean);
    function ReadVatChg:boolean;    procedure WriteVatChg(pValue:boolean);
    function ReadSerMod:boolean;    procedure WriteSerMod(pValue:boolean);
    function ReadDatMod:boolean;    procedure WriteDatMod(pValue:boolean);
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadAttLst:boolean;    procedure WriteAttLst(pValue:boolean);

    function ReadOciDel:boolean;    procedure WriteOciDel(pValue:boolean);
    function ReadPrnOcd:boolean;    procedure WritePrnOcd(pValue:boolean);
    function ReadPrnRat:boolean;    procedure WritePrnRat(pValue:boolean);
    function ReadTcdGen:boolean;    procedure WriteTcdGen(pValue:boolean);
    function ReadIcdGen:boolean;    procedure WriteIcdGen(pValue:boolean);

    function ReadFmdGen:boolean;    procedure WriteFmdGen(pValue:boolean);
    function ReadOmdGen:boolean;    procedure WriteOmdGen(pValue:boolean);
    function ReadImdGen:boolean;    procedure WriteImdGen(pValue:boolean);
    function ReadRmdGen:boolean;    procedure WriteRmdGen(pValue:boolean);
    function ReadSpeInc:boolean;    procedure WriteSpeInc(pValue:boolean);
    function ReadOciExp:boolean;    procedure WriteOciExp(pValue:boolean);
    function ReadMneVal:boolean;    procedure WriteMneVal(pValue:boolean);
    function ReadNopOch:boolean;    procedure WriteNopOch(pValue:boolean);
    function ReadNopOci:boolean;    procedure WriteNopOci(pValue:boolean);
    function ReadOciRep:boolean;    procedure WriteOciRep(pValue:boolean);
    function ReadOcdSta:boolean;    procedure WriteOcdSta(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadOciRes:boolean;    procedure WriteOciRes(pValue:boolean);
    function ReadDocCpy:boolean;    procedure WriteDocCpy(pValue:boolean);
    function ReadResFre:boolean;    procedure WriteResFre(pValue:boolean);
    function ReadChgTrm:boolean;    procedure WriteChgTrm(pValue:boolean);
    function ReadMinStc:boolean;    procedure WriteMinStc(pValue:boolean);

    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadCadGen:boolean;    procedure WriteCadGen(pValue:boolean);
    function ReadDpzLst:boolean;    procedure WriteDpzLst(pValue:boolean);
    function ReadExdGen:boolean;    procedure WriteExdGen(pValue:boolean);
    function ReadExpLst:boolean;    procedure WriteExpLst(pValue:boolean);
    function ReadOccDoc:boolean;    procedure WriteOccDoc(pValue:boolean);
    function ReadOccEdi:boolean;    procedure WriteOccEdi(pValue:boolean);
    function ReadPcdGen:boolean;    procedure WritePcdGen(pValue:boolean);
    function ReadPrnMas:boolean;    procedure WritePrnMas(pValue:boolean);
    function ReadResOsd:boolean;    procedure WriteResOsd(pValue:boolean);
    function ReadSpdLst:boolean;    procedure WriteSpdLst(pValue:boolean);
    function ReadShpImp:boolean;    procedure WriteShpImp(pValue:boolean);
    function ReadMntFnc: boolean;   procedure WriteMntFnc(pValue: boolean);
    function ReadSerFnc: boolean;   procedure WriteSerFnc(pValue: boolean);
    // ---------------------------- Prilohy ------------------------------
    function ReadAttAdd:boolean;    procedure WriteAttAdd(pValue:boolean);
    function ReadAttDel:boolean;    procedure WriteAttDel(pValue:boolean);
    function ReadAttMod:boolean;    procedure WriteAttMod(pValue:boolean);
    function ReadAttShw:boolean;    procedure WriteAttShw(pValue:boolean);
    function ReadAttFid:boolean;    procedure WriteAttFid(pValue:boolean);



  public
    // ---------------------- Úpravy -------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property DocDsc:boolean read ReadDocDsc write WriteDocDsc;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property DocRnd:boolean read ReadDocRnd write WriteDocRnd;
    property VatChg:boolean read ReadVatChg write WriteVatChg;
    // --------------------- Zobrazit ------------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property OciDel:boolean read ReadOciDel write WriteOciDel;
    property SpdLst:boolean read ReadSpdLst write WriteSpdLst;
    property OccDoc:boolean read ReadOccDoc write WriteOccDoc;
    property AttLst:boolean read ReadAttLst write WriteAttLst;
    // ---------------------- Tlac ---------------------------
    property PrnOcd:boolean read ReadPrnOcd write WritePrnOcd;
    property PrnRat:boolean read ReadPrnRat write WritePrnRat;
    property PrnMas:boolean read ReadPrnMas write WritePrnMas;
    property ExpLst:boolean read ReadExpLst write WriteExpLst;
    // --------------------- Nastroje ------------------------
    property TcdGen:boolean read ReadTcdGen write WriteTcdGen;
    property IcdGen:boolean read ReadIcdGen write WriteIcdGen;
    property FmdGen:boolean read ReadFmdGen write WriteFmdGen;
    property OmdGen:boolean read ReadOmdGen write WriteOmdGen;
    property ImdGen:boolean read ReadImdGen write WriteImdGen;
    property RmdGen:boolean read ReadRmdGen write WriteRmdGen;
    property SpeInc:boolean read ReadSpeInc write WriteSpeInc;
    property OciExp:boolean read ReadOciExp write WriteOciExp;
    property MneVal:boolean read ReadMneVal write WriteMneVal;
    property NopOch:boolean read ReadNopOch write WriteNopOch;
    property NopOci:boolean read ReadNopOci write WriteNopOci;
    property OciRep:boolean read ReadOciRep write WriteOciRep;
    property OcdSta:boolean read ReadOcdSta write WriteOcdSta;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property OciRes:boolean read ReadOciRes write WriteOciRes;
    property DocCpy:boolean read ReadDocCpy write WriteDocCpy;
    property ResFre:boolean read ReadResFre write WriteResFre;
    property ChgTrm:boolean read ReadChgTrm write WriteChgTrm;
    property MinStc:boolean read ReadMinStc write WriteMinStc;
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property PcdGen:boolean read ReadPcdGen write WritePcdGen;
    property CadGen:boolean read ReadCadGen write WriteCadGen;
    property OccEdi:boolean read ReadOccEdi write WriteOccEdi;
    property ShpImp:boolean read ReadShpImp write WriteShpImp;
    property ExdGen:boolean read ReadExdGen write WriteExdGen;
    property ResOsd:boolean read ReadResOsd write WriteResOsd;
    property DpzLst:boolean read ReadDpzLst write WriteDpzLst;

    property SerMod:boolean read ReadSerMod write WriteSerMod;
    property DatMod:boolean read ReadDatMod write WriteDatMod;
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    property SerFnc:boolean read ReadSerFnc write WriteSerFnc;
    // ---------------------- Prilohy ------------------------
    property AttAdd:boolean read ReadAttAdd write WriteAttAdd;
    property AttDel:boolean read ReadAttDel write WriteAttDel;
    property AttMod:boolean read ReadAttMod write WriteAttMod;
    property AttShw:boolean read ReadAttShw write WriteAttShw;
    property AttFid:boolean read ReadAttFid write WriteAttFid;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  Nástroje ----  Údrzba -------  Servis ------   Polozky ------  Prilohy -----
   cDocAdd = 1;   cSitLst = 20;  cPrnOcd = 40;  cTcdGen = 60;  cMntFnc = 100;  cSerFnc = 120;  cItmAdd = 141;  cAttAdd = 151;
   cDocDel = 2;   cOciDel = 21;  cPrnRat = 41;  cIcdGen = 61;                                  cItmDel = 142;  cAttDel = 152;
   cDocDsc = 3;   cSpdLst = 22;  cPrnMas = 42;  cFmdGen = 62;                                  cItmMod = 143;  cAttMod = 153;
   cDocLck = 4;   cOccDoc = 23;  cExpLst = 43;  cImdGen = 63;                                                  cAttShw = 154;
   cDocUnl = 5;   cAttLst = 24;                 cOmdGen = 64;                                                  cAttFid = 155;
   cDocRnd = 6;                                 cRmdGen = 65;
   cDocMod = 7;                                 cSpeInc = 66;  
   cVatChg = 8;                                 cOciExp = 67;
   cSerMod = 9;                                 cMneVal = 68;
   cDatMod = 10;                                cNopOch = 69;
                                                cNopOci = 70;
                                                cOciRep = 71;
                                                cOcdSta = 72;
                                                cOitSnd = 73;
                                                cOciRes = 74;
                                                cDocCpy = 75;
                                                cResFre = 76;
                                                cChgTrm = 77;
                                                cMinStc = 78;
                                                cPcdGen = 79;
                                                cCadGen = 80;
                                                cOccEdi = 81;
                                                cShpImp = 82;
                                                cExdGen = 83;
                                                cResOsd = 84;
                                                cDpzLst = 85;
// **************************************** OBJECT *****************************************

// ---------------------- Úpravy -------------------------

// ********************************** OCB **************************************

function TAfcOcb.ReadDocAdd:boolean;
begin
  Result := ReadData('OCB',cDocAdd);
end;

procedure TAfcOcb.WriteDocAdd(pValue:boolean);
begin
  WriteData('OCB',cDocAdd,pValue);
end;

function TAfcOcb.ReadDocDel:boolean;
begin
  Result := ReadData('OCB',cDocDel);
end;

procedure TAfcOcb.WriteDocDel(pValue:boolean);
begin
  WriteData('OCB',cDocDel,pValue);
end;

function TAfcOcb.ReadDocDsc:boolean;
begin
  Result := ReadData('OCB',cDocDsc);
end;

procedure TAfcOcb.WriteDocDsc(pValue:boolean);
begin
  WriteData('OCB',cDocDsc,pValue);
end;

function TAfcOcb.ReadDocLck:boolean;
begin
  Result := ReadData('OCB',cDocLck);
end;

procedure TAfcOcb.WriteDocLck(pValue:boolean);
begin
  WriteData('OCB',cDocLck,pValue);
end;

function TAfcOcb.ReadDocUnl:boolean;
begin
  Result := ReadData('OCB',cDocUnl);
end;

procedure TAfcOcb.WriteDocUnl(pValue:boolean);
begin
  WriteData('OCB',cDocUnl,pValue);
end;

function TAfcOcb.ReadDocRnd:boolean;
begin
  Result := ReadData('OCB',cDocRnd);
end;

procedure TAfcOcb.WriteDocRnd(pValue:boolean);
begin
  WriteData('OCB',cDocRnd,pValue);
end;

function TAfcOcb.ReadDocMod:boolean;
begin
  Result := ReadData('OCB',cDocMod);
end;

procedure TAfcOcb.WriteDocMod(pValue:boolean);
begin
  WriteData('OCB',cDocMod,pValue);
end;

function TAfcOcb.ReadVatChg:boolean;
begin
  Result := ReadData('OCB',cVatChg);
end;

procedure TAfcOcb.WriteVatChg(pValue:boolean);
begin
  WriteData('OCB',cVatChg,pValue);
end;

function TAfcOcb.ReadSerMod:boolean;
begin
  Result := ReadData('OCB',cSerMod);
end;

procedure TAfcOcb.WriteSerMod(pValue:boolean);
begin
  WriteData('OCB',cSerMod,pValue);
end;

function TAfcOcb.ReadDatMod:boolean;
begin
  Result := ReadData('OCB',cDatMod);
end;

procedure TAfcOcb.WriteDatMod(pValue:boolean);
begin
  WriteData('OCB',cDatMod,pValue);
end;

function TAfcOcb.ReadSitLst:boolean;
begin
  Result := ReadData('OCB',cSitLst);
end;

procedure TAfcOcb.WriteSitLst(pValue:boolean);
begin
  WriteData('OCB',cSitLst,pValue);
end;

function TAfcOcb.ReadAttLst:boolean;
begin
  Result := ReadData('OCB',cAttLst);
end;

procedure TAfcOcb.WriteAttLst(pValue:boolean);
begin
  WriteData('OCB',cAttLst,pValue);
end;

function TAfcOcb.ReadOciDel:boolean;
begin
  Result := ReadData('OCB',cOciDel);
end;

procedure TAfcOcb.WriteOciDel(pValue:boolean);
begin
  WriteData('OCB',cOciDel,pValue);
end;

function TAfcOcb.ReadPrnOcd:boolean;
begin
  Result := ReadData('OCB',cPrnOcd);
end;

procedure TAfcOcb.WritePrnOcd(pValue:boolean);
begin
  WriteData('OCB',cPrnOcd,pValue);
end;

function TAfcOcb.ReadPrnRat:boolean;
begin
  Result := ReadData('OCB',cPrnRat);
end;

procedure TAfcOcb.WritePrnRat(pValue:boolean);
begin
  WriteData('OCB',cPrnRat,pValue);
end;

function TAfcOcb.ReadTcdGen:boolean;
begin
  Result := ReadData('OCB',cTcdGen);
end;

procedure TAfcOcb.WriteTcdGen(pValue:boolean);
begin
  WriteData('OCB',cTcdGen,pValue);
end;

function TAfcOcb.ReadIcdGen:boolean;
begin
  Result := ReadData('OCB',cTcdGen);
end;

procedure TAfcOcb.WriteIcdGen(pValue:boolean);
begin
  WriteData('OCB',cIcdGen,pValue);
end;

function TAfcOcb.ReadFmdGen:boolean;
begin
  Result := ReadData('OCB',cFmdGen);
end;

procedure TAfcOcb.WriteFmdGen(pValue:boolean);
begin
  WriteData('OCB',cFmdGen,pValue);
end;

function TAfcOcb.ReadOmdGen:boolean;
begin
  Result := ReadData('OCB',cOmdGen);
end;

procedure TAfcOcb.WriteOmdGen(pValue:boolean);
begin
  WriteData('OCB',cOmdGen,pValue);
end;

function TAfcOcb.ReadImdGen:boolean;
begin
  Result := ReadData('OCB',cImdGen);
end;

procedure TAfcOcb.WriteImdGen(pValue:boolean);
begin
  WriteData('OCB',cImdGen,pValue);
end;

function TAfcOcb.ReadRmdGen:boolean;
begin
  Result := ReadData('OCB',cRmdGen);
end;

procedure TAfcOcb.WriteRmdGen(pValue:boolean);
begin
  WriteData('OCB',cRmdGen,pValue);
end;

function TAfcOcb.ReadSpeInc:boolean;
begin
  Result := ReadData('OCB',cSpeInc);
end;

procedure TAfcOcb.WriteSpeInc(pValue:boolean);
begin
  WriteData('OCB',cSpeInc,pValue);
end;

function TAfcOcb.ReadOciExp:boolean;
begin
  Result := ReadData('OCB',cOciExp);
end;

procedure TAfcOcb.WriteOciExp(pValue:boolean);
begin
  WriteData('OCB',cOciExp,pValue);
end;

function TAfcOcb.ReadMneVal:boolean;
begin
  Result := ReadData('OCB',cMneVal);
end;

procedure TAfcOcb.WriteMneVal(pValue:boolean);
begin
  WriteData('OCB',cMneVal,pValue);
end;

function TAfcOcb.ReadNopOch:boolean;
begin
  Result := ReadData('OCB',cNopOch);
end;

procedure TAfcOcb.WriteNopOch(pValue:boolean);
begin
  WriteData('OCB',cNopOch,pValue);
end;

function TAfcOcb.ReadNopOci:boolean;
begin
  Result := ReadData('OCB',cNopOci);
end;

procedure TAfcOcb.WriteNopOci(pValue:boolean);
begin
  WriteData('OCB',cNopOci,pValue);
end;

function TAfcOcb.ReadOciRep:boolean;
begin
  Result := ReadData('OCB',cOciRep);
end;

procedure TAfcOcb.WriteOciRep(pValue:boolean);
begin
  WriteData('OCB',cOciRep,pValue);
end;

function TAfcOcb.ReadOcdSta:boolean;
begin
  Result := ReadData('OCB',cOcdSta);
end;

procedure TAfcOcb.WriteOcdSta(pValue:boolean);
begin
  WriteData('OCB',cOcdSta,pValue);
end;

function TAfcOcb.ReadOitSnd:boolean;
begin
  Result := ReadData('OCB',cOitSnd);
end;

procedure TAfcOcb.WriteOitSnd(pValue:boolean);
begin
  WriteData('OCB',cOitSnd,pValue);
end;

function TAfcOcb.ReadOciRes:boolean;
begin
  Result := ReadData('OCB',cOciRes);
end;

procedure TAfcOcb.WriteOciRes(pValue:boolean);
begin
  WriteData('OCB',cOciRes,pValue);
end;

function TAfcOcb.ReadDocCpy:boolean;
begin
  Result := ReadData('OCB',cDocCpy);
end;

procedure TAfcOcb.WriteDocCpy(pValue:boolean);
begin
  WriteData('OCB',cDocCpy,pValue);
end;

function TAfcOcb.ReadResFre:boolean;
begin
  Result := ReadData('OCB',cResFre);
end;

procedure TAfcOcb.WriteResFre(pValue:boolean);
begin
  WriteData('OCB',cResFre,pValue);
end;

function TAfcOcb.ReadChgTrm:boolean;
begin
  Result := ReadData('OCB',cChgTrm);
end;

procedure TAfcOcb.WriteChgTrm(pValue:boolean);
begin
  WriteData('OCB',cChgTrm,pValue);
end;

function TAfcOcb.ReadMinStc:boolean;
begin
  Result := ReadData('OCB',cMinStc);
end;

procedure TAfcOcb.WriteMinStc(pValue:boolean);
begin
  WriteData('OCB',cMinStc,pValue);
end;

function TAfcOcb.ReadItmAdd:boolean;
begin
  Result := ReadData('OCB',cItmAdd);
end;

procedure TAfcOcb.WriteItmAdd(pValue:boolean);
begin
  WriteData('OCB',cItmAdd,pValue);
end;

function TAfcOcb.ReadItmDel:boolean;
begin
  Result := ReadData('OCB',cItmDel);
end;

procedure TAfcOcb.WriteItmDel(pValue:boolean);
begin
  WriteData('OCB',cItmDel,pValue);
end;

function TAfcOcb.ReadItmMod:boolean;
begin
  Result := ReadData('OCB',cItmMod);
end;

procedure TAfcOcb.WriteItmMod(pValue:boolean);
begin
  WriteData('OCB',cItmMod,pValue);
end;

function TAfcOcb.ReadCadGen: boolean;
begin
  Result := ReadData('OCB',cCadGen);
end;

function TAfcOcb.ReadDpzLst: boolean;
begin
  Result := ReadData('OCB',cDpzLst);
end;

function TAfcOcb.ReadExdGen: boolean;
begin
  Result := ReadData('OCB',cExdGen);
end;

function TAfcOcb.ReadExpLst: boolean;
begin
  Result := ReadData('OCB',cExpLst);
end;

function TAfcOcb.ReadOccDoc: boolean;
begin
  Result := ReadData('OCB',cOccDoc);
end;

function TAfcOcb.ReadOccEdi: boolean;
begin
  Result := ReadData('OCB',cOccEdi);
end;

function TAfcOcb.ReadPcdGen: boolean;
begin
  Result := ReadData('OCB',cPcdGen);
end;

function TAfcOcb.ReadPrnMas: boolean;
begin
  Result := ReadData('OCB',cPrnMas);
end;

function TAfcOcb.ReadResOsd: boolean;
begin
  Result := ReadData('OCB',cResOsd);
end;

function TAfcOcb.ReadSpdLst: boolean;
begin
  Result := ReadData('OCB',cSpdLst);
end;

procedure TAfcOcb.WriteCadGen(pValue: boolean);
begin
  WriteData('OCB',cCadGen,pValue);
end;

procedure TAfcOcb.WriteDpzLst(pValue: boolean);
begin
  WriteData('OCB',cDpzLst,pValue);
end;

procedure TAfcOcb.WriteExdGen(pValue: boolean);
begin
  WriteData('OCB',cExdGen,pValue);
end;

procedure TAfcOcb.WriteExpLst(pValue: boolean);
begin
  WriteData('OCB',cExpLst,pValue);
end;

procedure TAfcOcb.WriteOccDoc(pValue: boolean);
begin
  WriteData('OCB',cOccDoc,pValue);
end;

procedure TAfcOcb.WriteOccEdi(pValue: boolean);
begin
  WriteData('OCB',cOccEdi,pValue);
end;

procedure TAfcOcb.WritePcdGen(pValue: boolean);
begin
  WriteData('OCB',cPcdGen,pValue);
end;

procedure TAfcOcb.WritePrnMas(pValue: boolean);
begin
  WriteData('OCB',cPrnMas,pValue);
end;

procedure TAfcOcb.WriteResOsd(pValue: boolean);
begin
  WriteData('OCB',cResOsd,pValue);
end;

procedure TAfcOcb.WriteSpdLst(pValue: boolean);
begin
  WriteData('OCB',cSpdLst,pValue);
end;

function TAfcOcb.ReadShpImp: boolean;
begin
  Result := ReadData('OCB',cShpImp);
end;

procedure TAfcOcb.WriteShpImp(pValue: boolean);
begin
  WriteData('OCB',cShpImp,pValue);
end;

function TAfcOcb.ReadMntFnc: boolean;
begin
  Result := ReadData('OCB',cMntFnc);
end;

function TAfcOcb.ReadSerFnc: boolean;
begin
  Result := ReadData('OCB',cSerFnc);
end;

procedure TAfcOcb.WriteMntFnc(pValue: boolean);
begin
  WriteData('OCB',cMntFnc,pValue);
end;

procedure TAfcOcb.WriteSerFnc(pValue: boolean);
begin
  WriteData('OCB',cSerFnc,pValue);
end;

// ---------------------------- Prilohy ------------------------------

function TAfcOcb.ReadAttAdd:boolean;
begin
  Result := ReadData('OCB',cAttAdd);
end;

procedure TAfcOcb.WriteAttAdd(pValue:boolean);
begin
  WriteData('OCB',cAttAdd,pValue);
end;

function TAfcOcb.ReadAttDel:boolean;
begin
  Result := ReadData('OCB',cAttDel);
end;

procedure TAfcOcb.WriteAttDel(pValue:boolean);
begin
  WriteData('OCB',cAttDel,pValue);
end;

function TAfcOcb.ReadAttMod:boolean;
begin
  Result := ReadData('OCB',cAttMod);
end;

procedure TAfcOcb.WriteAttMod(pValue:boolean);
begin
  WriteData('OCB',cAttMod,pValue);
end;

function TAfcOcb.ReadAttShw:boolean;
begin
  Result := ReadData('OCB',cAttShw);
end;

procedure TAfcOcb.WriteAttShw(pValue:boolean);
begin
  WriteData('OCB',cAttShw,pValue);
end;

function TAfcOcb.ReadAttFid:boolean;
begin
  Result := ReadData('OCB',cAttFid);
end;

procedure TAfcOcb.WriteAttFid(pValue:boolean);
begin
  WriteData('OCB',cAttFid,pValue);
end;

end.
{MOD 1902010}
