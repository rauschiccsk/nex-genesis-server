unit NexClc; //01.07.2000 Rausch Zolt�n

interface

uses
  IcTypes, IcTools, Windows, ComCtrls, DB, Controls, StdCtrls, SysUtils, Forms, ExtCtrls, Classes;

  // Funkcie zaokr�hlenia
  function RndBas(pVal:double):double; // Z�kladn� zaokr�hlenie na 7 desatinn�ch miest

  // Funkcie v�po�tu
  function ClcAvaPrf(pVal,pPrc:double):double;  // Vypo��ta hodnotu bez DPH s prid�van�m zisku k zadanej hodnote
  function ClcAvaDsc(pVal,pPrc:double):double;  // Vypo��ta hodnotu bez DPH s odr�tan�m z�avy od zadanej hodnoty
  function ClcAvaVat(pVal,pPrc:double):double;  // Vypo��ta hodnotu bez DPH s odr�tan�m DPH od zdanej hodoty
  function ClcBvaVat(pVal,pPrc:double):double;  // Vypo��ta hodnotu s DPH s pripo��tan�m DPH k zdanej hodote
  function ClcDscPrc(pBas,pRes:double):double;  // Vypo��ta precentu�lnu hodnotu z�avy (pBas-z�klad;pRes-v�sledok)
  function ClcPrfPrc(pBas,pRes:double):double;  // Vypo��ta precentu�lnu hodnotu zisku (pBas-z�klad;pRes-v�sledok)
  function ClcDvzVal(pVal,pCrs:double):double;  // Vypo��ta zahranien� menu (pVal-tuezmsk� mena;pCrs-kurz)
  function ClcAccVal(pVal,pCrs:double):double;  // Vypo��ta ��tovn� menu (pVal-zahrani�n� mena;pCrs-kurz)
  function ClcPrcVal(pVal,pPrc:double):double;  // Vypo��ta hodnotu zadan�ho percenta

  // Funkcie zaokr�hlenia
(*
  function RndDocAva(pVal:double):double; // Zaokr�hli kumulat�vnu hodnotu dokladu bez DPH
  function RndDocVat(pVal:double):double; // Zaokr�hli kumulat�vnu hodnotu DPH
  function RndDocBva(pVal:double):double; // Zaokr�hli kumulat�vnu hodnotu dokladu s DPH
  function RndItmAva(pVal:double):double; // Zaokr�hli hodnotu polo�ky dokladu bez DPH
  function RndItmBva(pVal:double):double; // Zaokr�hli hodnotu polo�ky dokladu s DPH
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

function ClcDvzVal(pVal,pCrs:double):double;  // Vypo��ta zahranien� menu (pVal-tuezmsk� mena;pCrs-kurz)
begin
  If IsNul(pCrs) then pCrs:=1;
  If pCrs=1 then Result:=pVal else Result:=RndBas(pVal*pCrs);
end;

function ClcAccVal(pVal,pCrs:double):double;  // Vypo��ta ��tovn� menu (pVal-zahrani�n� mena;pCrs-kurz)
begin
  If IsNul(pCrs) then pCrs:=1;
  If pCrs=1 then Result:=pVal else Result:=RndBas(pVal/pCrs);
  Result:=Rd2(Result);
end;

function ClcPrcVal(pVal,pPrc:double):double;  // Vypo��ta hodnotu zadan�ho percenta
begin
  Result:=RndBas(pVal*pPrc/100);
end;

end.

