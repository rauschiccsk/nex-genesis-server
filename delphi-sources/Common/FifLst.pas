unit FifLst;
{$F+}
// =============================================================================
//                          ZOZNA FIFO KARIET PRE V�DAJ
// -----------------------------------------------------------------------------
// Tento objek sl��i ako pam�ov� tabulka (data�za ulo�en� v opera�nej pam�ti).
// Jednotliv� z�znamy (recordy) s� ulo�en� formou textov�ho re�azca (csv), kde
// jednotliv� polia s� oddelen� od seba bodko�iatkou. �trukt�ra z�znamu je:
// � 1. oFifNum - ��slo fifo karty
// � 2. oDocNum - intern� ��slo dokladu pr�jmu
// � 3. oItmNum - poradov� ��slo polo�ky dokladu pr�jmu
// � 4. oIncApc - cena pr�jmu (n�kupn� cena bez DPH)
// � 5. oActPrq - aktu�lna voln� z�soba da danej fifokarte
// � 6. oOutPrq - mno�stvo, ktor� bude vydan� z danej fifo karty
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// CsvMovDat - prekonvertuje �daje textov�ho riadku (csv) do datov�ho form�tu,
//             ktor� potom bud� pr�stupn� cez property.
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[29.12.2018] - Nov� objekt (RZ)
// =============================================================================


interface

uses
  IcTypes, IcConst, IcConv, IcTools, TxtWrap, LinLst,
  ComCtrls, SysUtils, Classes, Forms;

type
  TFifLst=class(TComponent)
    constructor Create;
    destructor  Destroy;
    private
      function GetCount:word;
      function GetEof:boolean;
      function GetBof:boolean;

      procedure CsvMovDat;
    public
      oLinLst:TLinLst;  // Zoznam textov�ch riadkov
      oTxtWrp:TTxtWrap;
      oFifNum:longint;
      oDocNum:Str12;
      oItmNum:longint;
      oIncApc:double;
      oActPrq:double;
      oOutPrq:double;
      procedure First;
      procedure Last;
      procedure Next;
      procedure Prior;

      procedure AddItmDat(pFifNum:longint;pDocNum:Str12;pItmNum:longint;pIncApc,pActPrq,pOutPrq:double);
    published
      property Count:word read GetCount;
      property Eof:boolean read GetEof;
      property Bof:boolean read GetBof;

      property FifNum:longint read oFifNum;
      property DocNum:Str12 read oDocNum;
      property ItmNum:longint read oItmNum;
      property IncApc:double read oIncApc;
      property ActPrq:double read oActPrq;
      property OutPrq:double read oOutPrq;
  end;

implementation

// ********************************** OBJECT ***********************************

constructor TFifLst.Create;
begin
  oLinLst:=TLinLst.Create;
  oTxtWrp:=TTxtWrap.Create;
end;

destructor TFifLst.Destroy;
begin
  FreeAndNil(oLinLst);
  FreeAndNil(oTxtWrp);
end;

// ********************************* PRIVATE ***********************************

function TFifLst.GetCount:word;
begin
  Result:=oLinLst.Count;
end;

function TFifLst.GetEof:boolean;
begin
  Result:=oLinLst.Eof;
  CsvMovDat;
end;

function TFifLst.GetBof:boolean;
begin
  Result:=oLinLst.Bof;
  CsvMovDat;
end;

procedure TFifLst.CsvMovDat;
var mLinDat:ShortString;  // D�tov� riadok (record)
begin
  mLinDat:=oLinLst.Itm;
  oFifNum:=ValInt(LineElement(mLinDat,1,';'));
  oDocNum:=LineElement(mLinDat,2,';');
  oItmNum:=ValInt(LineElement(mLinDat,3,';'));
  oIncApc:=ValDoub(LineElement(mLinDat,4,';'));
  oActPrq:=ValDoub(LineElement(mLinDat,5,';'));
  oOutPrq:=ValDoub(LineElement(mLinDat,6,';'));
end;

// ********************************** PUBLIC ***********************************

procedure TFifLst.First;
begin
  oLinLst.First;
  CsvMovDat;
end;

procedure TFifLst.Last;
begin
  oLinLst.Last;
  CsvMovDat;
end;

procedure TFifLst.Next;
begin
  oLinLst.Next;
  CsvMovDat;
end;

procedure TFifLst.Prior;
begin
  oLinLst.Prior;
  CsvMovDat;
end;

procedure TFifLst.AddItmDat(pFifNum:longint;pDocNum:Str12;pItmNum:longint;pIncApc,pActPrq,pOutPrq:double);
begin
  oTxtWrp.ClearWrap;
  oTxtWrp.SetSeparator(';');
  oTxtWrp.SetNum(pFifNum,0);
  oTxtWrp.SetText(pDocNum,12);
  oTxtWrp.SetNum(pItmNum,0);
  oTxtWrp.SetReal(pIncApc,0,5);
  oTxtWrp.SetReal(pActPrq,0,5);
  oTxtWrp.SetReal(pOutPrq,0,5);
  oLinLst.AddItm(oTxtWrp.GetWrapText);
end;

end.
