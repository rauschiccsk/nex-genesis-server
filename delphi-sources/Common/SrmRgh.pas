unit SrmRgh;

interface

uses
  IcTypes, IcTools,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TSrmRgh=class
  private
    oUsgRgh:Str255;
    // ---------------------------- ⁄pravy -------------------------------
    function GetDocAdd:boolean;       procedure SetDocAdd(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    // ---------------------------- TlaË ---------------------------------
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------
  public
  published
    property UsgRgh:Str255 read oUsgRgh write oUsgRgh;

    // ---------------------------- ⁄pravy -------------------------------
    property DocAdd:boolean read GetDocAdd write SetDocAdd;
    // ---------------------------- Zobraziù -----------------------------
    // ---------------------------- TlaË ---------------------------------
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------
  end;

implementation

uses dUSGRGH;

const
   // =============================================
   //                 HLAVI»KA DOKLADU
   // =============================================
   // ------------------- ⁄pravy ------------------
   cDocAdd=01;  // Pridaù nov˝ doklad
   cDocDel=02;  // Zruöiù vybran˝ doklad
   cDocMod=03;  // Opraviù vybran˝ doklad
   cDocLck=04;  // Uzamkn˙ù vybran˝ doklad
   cDocUnl=05;  // Odomkn˙ù vybran˝ doklad
   cDocOut=06;  // Vydaù poloûky zo skladu
   cDocInc=07;  // Prijaù poloûky na sklad
   // ------------------ Zobraziù -----------------
   cItmLst=11;  // Poloûky vybranÈho dokladu
   // -------------------- TlaË -------------------
   cPrnOud=21;  // TlaË skladovej v˝dajky
   cPrnInd=21;  // TlaË prÌjemky v˝dajky
   // ------------------ N·stroje -----------------
   // ------------------- ⁄drûba ------------------
   // ------------------- Servis ------------------
   // =============================================
   //                 POLOéKY DOKLADU
   // =============================================
   // ------------------- ⁄pravy ------------------
   cItmAdd=101; // Pridaù nov˝ doklad
   cItmDel=102; // Zruöiù vybran˝ doklad
   cItmMod=103; // Opraviù vybran˝ doklad
   cItmOut=104; // Vydaù poloûku zo skladu
   cItmInc=105; // Prijaù poloûku na sklad
// ******************************** OBJECT *************************************

// ******************************** PUBLIC *************************************

// ******************************** PRIVATE ************************************
// -------------------------------- ⁄pravy -------------------------------------
function TSrmRgh.GetDocAdd:boolean;
begin
  Result:=oUsgRgh[cDocAdd]=#1;
end;

procedure TSrmRgh.SetDocAdd(pValue:boolean);
begin
  If pValue then oUsgRgh[cDocAdd]:=#1
            else oUsgRgh[cDocAdd]:='.';
end;

// -------------------------------- Zobraziù -----------------------------------
// -------------------------------- TlaË ---------------------------------------
// -------------------------------- N·stroje -----------------------------------
// -------------------------------- ⁄drûba -------------------------------------

end.
