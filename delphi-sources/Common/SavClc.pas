unit SavClc;
{$F+}

// *****************************************************************************
//               VÝPOÈET HODNOT POLOŽIEK PRE ODBYTOVE DOKLADY
// *****************************************************************************

interface

uses
  IcTypes, IcVariab, IcConst, IcConv, IcTools, DocHand, NexGlob, NexPath, Key,
  SysUtils, Classes, Forms;

type
  TSavClc = class
    constructor Create;
    destructor  Destroy; override;
    private
      oGsQnt:double;     // Množstvo tovaru
      oVatPrc:byte;      // Percentuálna sadzba DPH
      oDscPrc:double;    // Percentuálna hodnota z¾avy
      oFgCourse:double;  // Kurz vyúètovacej meny
      oAcDValue:double;  // PC bez DPH pred zlavou v uctovnej mene
      oAcHValue:double;  // PC s DPH pred zlavou v uctovnej mene
      oAcDscVal:double;  // Hodnota zlavy z PC bez DPH v uctovnej mene
      oAcHscVal:double;  // Hodnota zlavy z PC s DPH v uctovnej mene
      oAcAValue:double;  // PC bez DPH po zlave v uctovnej mene
      oAcBValue:double;  // PC s DPH po zlave v uctovnej mene
      oRdAValue:double;  // Zaokruhlovaci rozdiel pre hodnotu bez DPH
      oRdBValue:double;  // Zaokruhlovaci rozdiel pre hodnotu bez DPH

      oFgDPrice:double;  // PC/MJ bez DPH pred zlavou vo vyuctovnej mene
      oFgHPrice:double;  // PC/MJ s DPH pred zlavou vo vyuctovnej mene
      oFgAPrice:double;  // PC/MJ bez DPH po zlave vo vyuctovnej mene
      oFgBPrice:double;  // PC/MJ s DPH po zlave vo vyuctovnej mene

      oFgDValue:double;  // PC bez DPH pred zlavou vo vyuctovnej mene
      oFgHValue:double;  // PC s DPH pred zlavou vo vyuctovnej mene
      oFgDscVal:double;  // Hodnota zlavy z PC bez DPH vo vyuctovnej mene
      oFgHscVal:double;  // Hodnota zlavy z PC s DPH vo vyuctovnej mene
      oFgAValue:double;  // PC bez DPH po zlave vo vyuctovnej mene
      oFgBValue:double;  // PC s DPH po zlave vo vyuctovnej mene

      procedure AcValClc; // Vypoèíta uètovné hodnoty podla kurzu vyúètovacej meny
      procedure FgPceClc; // Vypoèíta jednotkove ceny vo vyuctovacej mene
      procedure SetFgDPrice(pPrice:double);
      procedure SetFgHPrice(pPrice:double);
      procedure SetFgAPrice(pPrice:double);
      procedure SetFgBPrice(pPrice:double);
      procedure SetFgAValue(pValue:double);
      procedure SetFgBValue(pValue:double);
    public
      property GsQnt:double read oGsQnt write oGsQnt;
      property VatPrc:byte read oVatPrc write oVatPrc;
      property DscPrc:double read oDscPrc write oDscPrc;
      property FgCourse:double write oFgCourse;
      // Jednotkové ceny položky
      property FgDPrice:double read oFgDPrice write SetFgDPrice;
      property FgHPrice:double read oFgHPrice write SetFgHPrice;
      property FgAPrice:double read oFgAPrice write SetFgAPrice;
      property FgBPrice:double read oFgBPrice write SetFgBPrice;
      // Uètovné hodnoty položky
      property AcDValue:double read oAcDValue;
      property AcHValue:double read oAcHValue;
      property AcDscVal:double read oAcDscVal;
      property AcHscVal:double read oAcHscVal;
      property AcAValue:double read oAcAValue;
      property AcBValue:double read oAcBValue;
      property RdAValue:double read oRdAValue;
      property RdBValue:double read oRdBValue;
      // Vyúètovacie hodnoty položky
      property FgDValue:double read oFgDValue;
      property FgHValue:double read oFgHValue;
      property FgDscVal:double read oFgDscVal;
      property FgHscVal:double read oFgHscVal;
      property FgAValue:double read oFgAValue write SetFgAValue;
      property FgBValue:double read oFgBValue write SetFgBValue;
  end;

  // prepocet UM a VM so zaokruhlenim na zadany pocet desatinnych miest
  function ClcAcFromFg_ (pFgValue,pFgCourse:double;pFrac:byte):double;
  function ClcFgFromAc_ (pAcValue,pFgCourse:double;pFrac:byte):double;
  // prepocet PC UM a VM so zaokruhlenim na pocet desatinnych miest SysAcvFrc reps. SysFgvFrc
  function ClcAcFromFgC (pFgValue,pFgCourse:double):double;
  function ClcFgFromAcC (pAcValue,pFgCourse:double):double;
  // prepocet PC/ks VM z UM so zaokruhlenim na pocet desatinnych miest SysFgpFrc
  function ClcFgFromAcP (pAcValue,pFgCourse:double):double;
  // prepocet NC UM a VM so zaokruhlenim na pocet desatinnych miest StvRndFrc
  function ClcAcFromFgS (pFgValue,pFgCourse:double):double;
  function ClcFgFromAcS (pAcValue,pFgCourse:double):double;
  // prepocet UM a VM so zaokruhlenim na 2 desatinne miesta
  function ClcAcFromFg2 (pFgValue,pFgCourse:double):double;
  function ClcFgFromAc2 (pAcValue,pFgCourse:double):double;
  // prepocet UM a VM bez zaokruhlenia
  function ClcAcFromFgN (pFgValue,pFgCourse:double):double;
  function ClcFgFromAcN (pAcValue,pFgCourse:double):double;

  function ClcAcFromPy (pPyValue,pPyCourse:double):double;
  function ClcPyFromAc (pAcValue,pPyCourse:double):double;

  function ClcCrsFromAc (pAcValue,pFgValue:double):double;

  function RoundFgABPrice (pNumber:double):double;
  function RoundFgABValue (pNumber:double):double;
  function RoundAcABValue (pNumber:double):double;

  implementation


function RoundFgABPrice (pNumber:double):double;
begin
  Result := Roundx (pNumber,gKey.SysFgpFrc);
end;

function RoundFgABValue (pNumber:double):double;
begin
  Result := Roundx (pNumber,gKey.SysFgvFrc);
end;

function RoundAcABValue (pNumber:double):double;
begin
  Result := Roundx (pNumber,gKey.SysAcvFrc);
end;

function ClcAcFromFg_ (pFgValue,pFgCourse:double;pFrac:byte):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pFgValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pFgValue*pFgCourse)  // Do 31.12.2008
        else Result := Rd(pFgValue/pFgCourse,pFrac,cStand); // Od 01.01.2009
    end;
end;

function ClcFgFromAc_ (pAcValue,pFgCourse:double;pFrac:byte):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pFgCourse)  // Do 31.12.2008
        else Result := Rd(pAcValue*pFgCourse,pFrac,cStand); // Od 01.01.2009
    end;
end;

function ClcAcFromFgC (pFgValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pFgValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pFgValue*pFgCourse)  // Do 31.12.2008
        else Result := Rd(pFgValue/pFgCourse,gKey.SysAcvFrc,cStand); // Od 01.01.2009
    end;
end;

function ClcFgFromAcC (pAcValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pFgCourse)  // Do 31.12.2008
        else Result := Rd(pAcValue*pFgCourse,gKey.SysFgvFrc,cStand); // Od 01.01.2009
    end;
end;

function ClcFgFromAcP (pAcValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pFgCourse)  // Do 31.12.2008
        else Result := Rd(pAcValue*pFgCourse,gKey.SysFgpFrc,cStand); // Od 01.01.2009
    end;
end;

function ClcAcFromFgS (pFgValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pFgValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pFgValue*pFgCourse)  // Do 31.12.2008
        else Result := Rd(pFgValue/pFgCourse,gvSys.StvRndFrc,cStand); // Od 01.01.2009
    end;
end;

function ClcFgFromAcS (pAcValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pFgCourse)  // Do 31.12.2008
        else Result := Rd(pAcValue*pFgCourse,gvSys.StvRndFrc,cStand); // Od 01.01.2009
    end;
end;

function ClcAcFromFg2 (pFgValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pFgValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pFgValue*pFgCourse)  // Do 31.12.2008
        else Result := Rd2(pFgValue/pFgCourse); // Od 01.01.2009
    end;
end;

function ClcFgFromAc2 (pAcValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pFgCourse)  // Do 31.12.2008
        else Result := Rd2(pAcValue*pFgCourse); // Od 01.01.2009
    end;
end;

function ClcAcFromFgN (pFgValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pFgValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := pFgValue*pFgCourse  // Do 31.12.2008
        else Result := pFgValue/pFgCourse; // Od 01.01.2009
    end;
end;

function ClcFgFromAcN (pAcValue,pFgCourse:double):double;
begin
  If IsNul(pFgCourse) then pFgCourse := 1;
  If pFgCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := pAcValue/pFgCourse  // Do 31.12.2008
        else Result := pAcValue*pFgCourse; // Od 01.01.2009
    end;
end;

function ClcAcFromPy (pPyValue,pPyCourse:double):double;
begin
  If IsNul(pPyCourse) then pPyCourse := 1;
  If pPyCourse=1
    then Result := pPyValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pPyValue*pPyCourse)  // Do 31.12.2008
        else Result := Rd2(pPyValue/pPyCourse); // Od 01.01.2009
    end;
end;

function ClcPyFromAc (pAcValue,pPyCourse:double):double;
begin
  If IsNul(pPyCourse) then pPyCourse := 1;
  If pPyCourse=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pPyCourse)  // Do 31.12.2008
        else Result := Rd2(pAcValue*pPyCourse); // Od 01.01.2009
    end;
end;

function ClcCrsFromAc (pAcValue,pFgValue:double):double;
begin
  If IsNul(pFgValue) then pFgValue := 1;
  If pFgValue=1
    then Result := pAcValue
    else begin
      If gvSys.ActYear<='2008'
        then Result := Rd2(pAcValue/pFgValue)  // Do 31.12.2008
        else Result := Rd2(pFgValue/pAcValue); // Od 01.01.2009
    end;
end;

// *****************************************************************************

constructor TSavClc.Create;
begin
  //
end;

destructor TSavClc.Destroy;
begin
  //
end;

// ********************************* PRIVATE ***********************************

procedure TSavClc.AcValClc; // Vypoèíta uètovné hodnoty podla kurzu vyúètovacej meny
begin
  oAcDValue := Rd(ClcAcFromFgC(oFgDValue,oFgCourse),gKey.SysAcvFrc,cStand);
  oAcHValue := Rd(ClcAcFromFgC(oFgHValue,oFgCourse),gKey.SysAcvFrc,cStand);
  oAcDscVal := Rd(ClcAcFromFgC(oFgDscVal,oFgCourse),gKey.SysAcvFrc,cStand);
  oAcHscVal := Rd(ClcAcFromFgC(oFgHscVal,oFgCourse),gKey.SysAcvFrc,cStand);
  oAcAValue := Rd(ClcAcFromFgC(oFgAValue,oFgCourse),gKey.SysAcvFrc,cStand);
  oAcBValue := Rd(ClcAcFromFgC(oFgBValue,oFgCourse),gKey.SysAcvFrc,cStand);
end;

procedure TSavClc.FgPceClc; // Vypoèíta jednotkove ceny vo vyuctovacej mene
begin
  If IsNotNul(oGsQnt) then begin
    oFgDPrice := Rd(oFgDValue/oGsQnt,gKey.SysFgpFrc,cStand);
    oFgHPrice := Rd(oFgHValue/oGsQnt,gKey.SysFgpFrc,cStand);
    oFgAPrice := Rd(oFgAValue/oGsQnt,gKey.SysFgpFrc,cStand);
    oFgBPrice := Rd(oFgBValue/oGsQnt,gKey.SysFgpFrc,cStand);
  end;
end;

procedure TSavClc.SetFgDPrice(pPrice:double);
begin
  oFgDPrice := Rd(pPrice,gKey.SysFgpFrc,cStand);
  oFgDValue := Rd(oFgDPrice*oGsQnt,gKey.SysAcvFrc,cStand);
  oFgAValue := Rd(oFgDValue*(1-oDscPrc/100),gKey.SysFgvFrc,cStand);
  oFgHValue := Rd(oFgDValue*(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgBValue := Rd(oFgAValue*(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgDscVal := Rd(oFgDValue-oFgAValue,gKey.SysFgvFrc,cStand);
  oFgHscVal := Rd(oFgHValue-oFgBValue,gKey.SysFgvFrc,cStand);

  FgPceClc; // Vypoèíta jednotkove ceny vo vyuctovacej mene
  AcValClc; // Vypoèíta uètovné hodnoty podla kurzu vyúètovacej meny
end;

procedure TSavClc.SetFgHPrice(pPrice:double);
begin
  oFgHPrice := Rd(pPrice,gKey.SysFgpFrc,cStand);
  oFgHValue := Rd(oFgHPrice*oGsQnt,gKey.SysFgvFrc,cStand);
  oFgBValue := Rd(oFgHValue*(1-oDscPrc/100),gKey.SysFgvFrc,cStand);
  oFgDValue := Rd(oFgHValue/(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgAValue := Rd(oFgBValue/(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgDscVal := Rd(oFgDValue-oFgAValue,gKey.SysFgvFrc,cStand);
  oFgHscVal := Rd(oFgHValue-oFgBValue,gKey.SysFgvFrc,cStand);

  FgPceClc; // Vypoèíta jednotkove ceny vo vyuctovacej mene
  AcValClc; // Vypoèíta uètovné hodnoty podla kurzu vyúètovacej meny
end;

procedure TSavClc.SetFgAPrice(pPrice:double);
begin
  oFgAPrice := Rd(pPrice,gKey.SysFgpFrc,cStand);
  oFgAValue := Rd(oFgAPrice*oGsQnt,gKey.SysFgvFrc,cStand);
  SetFgAValue(oFgAValue);
end;

procedure TSavClc.SetFgBPrice(pPrice:double);
begin
  oFgBPrice := Rd(pPrice,gKey.SysFgpFrc,cStand);
  oFgBValue := Rd(oFgBPrice*oGsQnt,gKey.SysFgvFrc,cStand);
  SetFgBValue(oFgBValue);
end;

procedure TSavClc.SetFgAValue(pValue:double);
begin
  oFgAValue := Rd(pValue,gKey.SysFgvFrc,cStand);
  If oDscPrc=100 then begin
    oFgDValue := Rd(oFgAValue,gKey.SysFgvFrc,cStand);
    oFgAValue := 0;
  end else oFgDValue := Rd(oFgAValue/(1-oDscPrc/100),gKey.SysFgvFrc,cStand);
  oFgHValue := Rd(oFgDValue*(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgBValue := Rd(oFgAValue*(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgDscVal := Rd(oFgDValue-oFgAValue,gKey.SysFgvFrc,cStand);
  oFgHscVal := Rd(oFgHValue-oFgBValue,gKey.SysFgvFrc,cStand);
  FgPceClc; // Vypoèíta jednotkove ceny vo vyuctovacej mene
  AcValClc; // Vypoèíta uètovné hodnoty podla kurzu vyúètovacej meny
end;

procedure TSavClc.SetFgBValue(pValue:double);
begin
  oFgBValue := Rd(pValue,gKey.SysFgvFrc,cStand);
  If oDscPrc=100 then begin
    oFgHValue := Rd(oFgBValue,gKey.SysFgvFrc,cStand);
    oFgBValue := 0;
  end else oFgHValue := Rd(oFgBValue/(1-oDscPrc/100),gKey.SysFgvFrc,cStand);
  oFgDValue := Rd(oFgHValue/(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgAValue := Rd(oFgBValue/(1+oVatPrc/100),gKey.SysFgvFrc,cStand);
  oFgDscVal := Rd(oFgDValue-oFgAValue,gKey.SysFgvFrc,cStand);
  oFgHscVal := Rd(oFgHValue-oFgBValue,gKey.SysFgvFrc,cStand);

  FgPceClc; // Vypoèíta jednotkove ceny vo vyuctovacej mene
  AcValClc; // Vypoèíta uètovné hodnoty podla kurzu vyúètovacej meny
end;

// ********************************** PUBLIC ***********************************

end.
{MOD 1905015}