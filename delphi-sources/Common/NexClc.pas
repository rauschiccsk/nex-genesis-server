unit NexClc; //01.07.2000 Rausch Zoltán

interface

uses
  IcTypes, IcTools, Windows, ComCtrls, DB, Controls, StdCtrls, SysUtils, Forms, ExtCtrls, Classes;

  // Funkcie zaokrúhlenia
  function RndBas(pVal:double):double; // Základné zaokrúhlenie na 7 desatinných miest

  // Funkcie výpoètu
  function ClcAvaPrf(pVal,pPrc:double):double;  // Vypoèíta hodnotu bez DPH s pridávaním zisku k zadanej hodnote
  function ClcAvaDsc(pVal,pPrc:double):double;  // Vypoèíta hodnotu bez DPH s odrátaním z¾avy od zadanej hodnoty
  function ClcAvaVat(pVal,pPrc:double):double;  // Vypoèíta hodnotu bez DPH s odrátaním DPH od zdanej hodoty
  function ClcBvaVat(pVal,pPrc:double):double;  // Vypoèíta hodnotu s DPH s pripoèítaním DPH k zdanej hodote
  function ClcDscPrc(pBas,pRes:double):double;  // Vypoèíta precentuálnu hodnotu z¾avy (pBas-základ;pRes-výsledok)
  function ClcPrfPrc(pBas,pRes:double):double;  // Vypoèíta precentuálnu hodnotu zisku (pBas-základ;pRes-výsledok)
  function ClcDvzVal(pVal,pCrs:double):double;  // Vypoèíta zahranienú menu (pVal-tuezmská mena;pCrs-kurz)
  function ClcAccVal(pVal,pCrs:double):double;  // Vypoèíta úètovnú menu (pVal-zahranièná mena;pCrs-kurz)
  function ClcPrcVal(pVal,pPrc:double):double;  // Vypoèíta hodnotu zadaného percenta

  // Funkcie zaokrúhlenia
(*
  function RndDocAva(pVal:double):double; // Zaokrúhli kumulatívnu hodnotu dokladu bez DPH
  function RndDocVat(pVal:double):double; // Zaokrúhli kumulatívnu hodnotu DPH
  function RndDocBva(pVal:double):double; // Zaokrúhli kumulatívnu hodnotu dokladu s DPH
  function RndItmAva(pVal:double):double; // Zaokrúhli hodnotu položky dokladu bez DPH
  function RndItmBva(pVal:double):double; // Zaokrúhli hodnotu položky dokladu s DPH
*)
implementation

function RndBas(pVal:double):double;
begin
  Result:=Round(pVal*10000000)/10000000;
end;

function ClcAvaPrf(pVal,pPrc:double):double;
begin
  Result:=RndBas(pVal*(1+pPrc/100));
end;

function ClcAvaDsc(pVal,pPrc:double):double;
begin
  Result:=RndBas(pVal*(1-pPrc/100));
end;

function ClcAvaVat(pVal,pPrc:double):double;
begin
  Result:=RndBas(pVal/(1+pPrc/100));
end;

function ClcBvaVat(pVal,pPrc:double):double;
begin
  Result:=RndBas(pVal*(1+pPrc/100));
end;

function ClcDscPrc(pBas,pRes:double):double;
begin
  Result:=0;
  If IsNotNul(pBas) then Result:=RndBas((1-(pRes/pBas))*100);
end;

function ClcPrfPrc(pBas,pRes:double):double;
begin
  Result:=0;
  If IsNotNul(pBas) then Result:=RndBas((pRes/pBas-1)*100);
end;

function ClcDvzVal(pVal,pCrs:double):double;  // Vypoèíta zahranienú menu (pVal-tuezmská mena;pCrs-kurz)
begin
  If IsNul(pCrs) then pCrs:=1;
  If pCrs=1 then Result:=pVal else Result:=RndBas(pVal*pCrs);
end;

function ClcAccVal(pVal,pCrs:double):double;  // Vypoèíta úètovnú menu (pVal-zahranièná mena;pCrs-kurz)
begin
  If IsNul(pCrs) then pCrs:=1;
  If pCrs=1 then Result:=pVal else Result:=RndBas(pVal/pCrs);
  Result:=Rd2(Result);
end;

function ClcPrcVal(pVal,pPrc:double):double;  // Vypoèíta hodnotu zadaného percenta
begin
  Result:=RndBas(pVal*pPrc/100);
end;

end.

