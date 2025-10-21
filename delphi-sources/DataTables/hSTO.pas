unit hSTO;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, bSTO,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TStoHnd = class (TStoBtr)
  private
    function QntCalc(pGsCode:longint;pOrdType,pStkStat:Str1):double;
    function DifCalc(pGsCode:longint;pOrdType,pStkStat:Str1):double;
    // OrdQnt-DlvQnt stk.bdf
    function ORDCalc(pGsCode:longint;pOrdType,pStkStat:Str1):double;
    // OrdQnt-ResQnt-DlvQnt
  public
    procedure Post; overload;
    function OsdQnt(pGsCode:longint):double;
    function OsdResQnt(pGsCode:longint):double;
    function OcdQnt(pGsCode:longint):double;
    function ScdQnt(pGsCode:longint):double;
    function NrsQnt(pGsCode:longint):double;
    function ImrQnt(pGsCode:longint):double;
    function OsrQnt(pGsCode:longint):double;
  published
  end;

implementation

// ******************************** PRIVATE ************************************

function TStoHnd.QntCalc(pGsCode:longint;pOrdType,pStkStat:Str1):double;
begin
  Result := 0;
  Swapstatus;
  If LocateGsOrSt (pGsCode,pOrdType,pStkStat) then begin
    Repeat
      Result := Result+OrdQnt;
      Next;
    until Eof or (GsCode<>pGsCode) or (OrdType<>pOrdType) or (StkStat<>pStkStat);
  end;
  RestoreStatus;
end;

function TStoHnd.DifCalc(pGsCode:longint;pOrdType,pStkStat:Str1):double;
begin
  Result := 0;
  Swapstatus;
  If LocateGsOrSt (pGsCode,pOrdType,pStkStat) then begin
    Repeat
      Result := Result+OrdQnt-DlvQnt;
      Next;
    until Eof or (GsCode<>pGsCode) or (OrdType<>pOrdType) or (StkStat<>pStkStat);
  end;
  RestoreStatus;
end;

function TStoHnd.ORDCalc(pGsCode:longint;pOrdType,pStkStat:Str1):double;
begin
  Result := 0;
  Swapstatus;
  If LocateGsOrSt (pGsCode,pOrdType,pStkStat) then begin
    Repeat
      Result := Result+OrdQnt-ResQnt-DlvQnt;
      Next;
    until Eof or (GsCode<>pGsCode) or (OrdType<>pOrdType) or (StkStat<>pStkStat);
  end;
  RestoreStatus;
end;

// ********************************* PUBLIC ************************************

procedure TStoHnd.Post;
begin
  If IsNul(OrdQnt-DlvQnt) or (OrdQnt<=DlvQnt) then StkStat := 'S';
  inherited ;
end;

function TStoHnd.OcdQnt(pGsCode:longint):double;
begin
  Result := DifCalc(pGsCode,'C','R');
end;

function TStoHnd.ScdQnt(pGsCode:longint):double;
begin
  Result := QntCalc(pGsCode,'X','R');
end;

function TStoHnd.NrsQnt(pGsCode:longint):double;
begin
  Result := QntCalc(pGsCode,'C','N');
  Result := Result+QntCalc(pGsCode,'X','N');
end;

function TStoHnd.ImrQnt(pGsCode:longint):double;
begin
  Result := QntCalc(pGsCode,'M','M');
end;

function TStoHnd.OsrQnt(pGsCode:longint):double;
begin
  Result := QntCalc(pGsCode,'C','O');
  Result := Result+QntCalc(pGsCode,'X','O');
end;

function TStoHnd.OsdQnt(pGsCode: Integer): double;
begin
  Result := 0;
  SwapStatus;
  If LocateGsOrSt (pGsCode,'S','O') then begin
    Repeat
      Result := Result+OrdQnt-DlvQnt;
      Next;
    until Eof or (GsCode<>pGsCode) or (OrdType<>'S') or (StkStat<>'O');
  end;
  RestoreStatus;
end;

function TStoHnd.OsdResQnt(pGsCode: Integer): double;
begin
  Result := 0;
  SwapStatus;
  If LocateGsOrSt (pGsCode,'S','O') then begin
    Repeat
      Result := Result+ResQnt;
      Next;
    until Eof or (GsCode<>pGsCode) or (OrdType<>'S') or (StkStat<>'O');
  end;
  RestoreStatus;
end;

end.
