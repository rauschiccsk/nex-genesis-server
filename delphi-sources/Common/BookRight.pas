unit BookRight;

interface

uses
  IcTypes, NexMsg, NexError, NexIni, IcVariab;
(*
  function ServiceRight: boolean; // TRUE ak uzivatel ma servisne pristupove prava
  function UserEnable: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Enable
  function UserDelete: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Delete
  function UserModify: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Modify
  function UserPrint: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Print
  function UserService: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Service
*)
  // Pristupove prava ku jednotlivym kniham
  function GetBookRight (pBookType:Str3; pBookNum:Str5): Str30;  // Vrati pristupove prava zadanej knihy pre prihlaseneho uzivatela
  function BookEnable (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo vstupit do zadanej knihy
  function BookInsert (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo pridat nove udaje
  function BookDelete (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo zrusit udaje zo zadanej knihy
  function BookModify (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo modifikovat udaje zo zadanej knihy
  function BookPrint (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
  function BookDocLock (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
  function BookOwnOpen (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
  function BookAllOpen (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
  function BookProperty (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy

implementation

uses
  DM_SYSTEM;

function ServiceRight: boolean;  // TRUE ak uzivatel ma servisne pristupove prava
begin
  Result:=TRUE;
end;

function UserEnable: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Enable
begin
  Result:=Pos ('E',dmSYS.btUSRLST.FieldByName ('GlobRght').AsString)>0;
end;

function UserDelete: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Delete
begin
  Result:=Pos ('D',dmSYS.btUSRLST.FieldByName ('GlobRght').AsString)>0;
end;

function UserModify: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Modify
begin
  Result:=Pos ('M',dmSYS.btUSRLST.FieldByName ('GlobRght').AsString)>0;
end;

function UserPrint: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Print
begin
  Result:=Pos ('P',dmSYS.btUSRLST.FieldByName ('DefRght').AsString)>0;
end;

function UserService: boolean;  // TRUE ak prihlaseny uzivatel ma pristupove pravo Service
begin
  Result:=Pos ('S',dmSYS.btUSRLST.FieldByName ('DefRght').AsString)>0;
end;

function GetBookRight (pBookType:Str3; pBookNum:Str5): Str30;  // Vrati pristupove prava zadanej knihy pre prihlaseneho uzivatela
begin
 If not gIni.ValueExists ('SYSTEM','Rights') then gIni.WriteString ('SYSTEM','Rights','EIDMPVLOA');
 Result:=gIni.ReadString ('SYSTEM','Rights','EIDMPVCOA');
{
  E - Enable - pouzivat danu knihu
  I - Insert - pridavat nove udaje do knihy
  D - Delete - zrusit udaje z danej knihy
  M - Modify - modifikovat udaje danej knihy
  P - Print - Vyhotovit tlacove zostavy z danej knihy
  V - Property - Nastavit vlastnosti danej knihy
  L - DocLock - Automaticky uzatvarat doklad po vytlaceni
  O - OwnOpen - Otvorit vlastne uzatvorene doklady
  A - AllOpen - Otvorit doklady nezavisle od toho kto uzatvoril

  dmSYS.btBKGRGHT.IndexName:='RgBtBn';
  If dmSYS.btBKGRGHT.FindKey ([dmSYS.btUSRLST.FieldByName('RghtGrp').AsInteger,pBookType,pBookNum])
    then Result:=dmSYS.btBKGRGHT.FieldByName ('BookRght').AsString
    else Result:=dmSYS.btUSRLST.FieldByName ('GlobRght').AsString;
}
end;

function BookEnable (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo vstupit do zadanej knihy
begin
  Result:=Pos ('E',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotEnableRight,'');
end;

function BookInsert (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo zrusit udaje zo zadanej knihy
begin
  Result:=Pos ('I',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotInsertRight,'');
end;

function BookDelete (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo zrusit udaje zo zadanej knihy
begin
  Result:=Pos ('D',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotDeleteRight,'');
end;

function BookModify (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo modifikovat udaje zo zadanej knihy
begin
  Result:=Pos ('M',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotModifyRight,'');
end;

function BookPrint (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
begin
  Result:=Pos ('P',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotPrintRight,'');
end;

function BookDocLock (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
begin
  Result:=Pos ('L',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotDocLockRight,'');
end;

function BookOwnOpen (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
begin
  Result:=Pos ('O',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotOwnOpenRight,'');
end;

function BookAllOpen (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
begin
  Result:=Pos ('A',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotAllOpenRight,'');
end;

function BookProperty (pBookType:Str3; pBookNum:Str5; pMsgEnab:boolean): boolean;  // TRUE ak prihlaseny uzivatel ma pravo tlacit udaje zo zadanej knihy
begin
  Result:=Pos ('V',GetBookRight(pBookType,pBookNum)) > 0;
  If pMsgEnab and not Result then ShowMsg (ecSysUsrNotPropertyRight,'');
end;

end.
