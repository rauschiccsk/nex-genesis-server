unit SrmRgh;

interface

uses
  IcTypes, IcTools,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TSrmRgh=class
  private
    oUsgRgh:Str255;
    // ---------------------------- �pravy -------------------------------
    function GetDocAdd:boolean;       procedure SetDocAdd(pValue:boolean);
    // ---------------------------- Zobrazi� -----------------------------
    // ---------------------------- Tla� ---------------------------------
    // ---------------------------- N�stroje -----------------------------
    // ---------------------------- �dr�ba -------------------------------
  public
  published
    property UsgRgh:Str255 read oUsgRgh write oUsgRgh;

    // ---------------------------- �pravy -------------------------------
    property DocAdd:boolean read GetDocAdd write SetDocAdd;
    // ---------------------------- Zobrazi� -----------------------------
    // ---------------------------- Tla� ---------------------------------
    // ---------------------------- N�stroje -----------------------------
    // ---------------------------- �dr�ba -------------------------------
  end;

implementation

uses dUSGRGH;

const
   // =============================================
   //                 HLAVI�KA DOKLADU
   // =============================================
   // ------------------- �pravy ------------------
   cDocAdd=01;  // Prida� nov� doklad
   cDocDel=02;  // Zru�i� vybran� doklad
   cDocMod=03;  // Opravi� vybran� doklad
   cDocLck=04;  // Uzamkn�� vybran� doklad
   cDocUnl=05;  // Odomkn�� vybran� doklad
   cDocOut=06;  // Vyda� polo�ky zo skladu
   cDocInc=07;  // Prija� polo�ky na sklad
   // ------------------ Zobrazi� -----------------
   cItmLst=11;  // Polo�ky vybran�ho dokladu
   // -------------------- Tla� -------------------
   cPrnOud=21;  // Tla� skladovej v�dajky
   cPrnInd=21;  // Tla� pr�jemky v�dajky
   // ------------------ N�stroje -----------------
   // ------------------- �dr�ba ------------------
   // ------------------- Servis ------------------
   // =============================================
   //                 POLO�KY DOKLADU
   // =============================================
   // ------------------- �pravy ------------------
   cItmAdd=101; // Prida� nov� doklad
   cItmDel=102; // Zru�i� vybran� doklad
   cItmMod=103; // Opravi� vybran� doklad
   cItmOut=104; // Vyda� polo�ku zo skladu
   cItmInc=105; // Prija� polo�ku na sklad
// ******************************** OBJECT *************************************

// ******************************** PUBLIC *************************************

// ******************************** PRIVATE ************************************
// -------------------------------- �pravy -------------------------------------
function TSrmRgh.GetDocAdd:boolean;
begin
  Result:=oUsgRgh[cDocAdd]=#1;
end;

procedure TSrmRgh.SetDocAdd(pValue:boolean);
begin
  If pValue then oUsgRgh[cDocAdd]:=#1
            else oUsgRgh[cDocAdd]:='.';
end;

// -------------------------------- Zobrazi� -----------------------------------
// -------------------------------- Tla� ---------------------------------------
// -------------------------------- N�stroje -----------------------------------
// -------------------------------- �dr�ba -------------------------------------

end.
