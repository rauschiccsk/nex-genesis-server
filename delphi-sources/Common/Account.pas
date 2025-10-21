unit Account;

interface

uses
  IcTypes, IcConst, IcVariab, IcTools, IcConv, JrnAcc, Oac,
  Dialogs, Classes, Forms, SysUtils, NexBtrTable;

  procedure DelDocFromJrn (pDocNum:Str12); // Vymaze uctovne zapisiy zadaneho dokladu z dennika UZ
//  procedure DocAccount (pHEAD:TNexBtrTable;pShow:boolean); // Rozuctuje zadany doklad
  procedure DocAccount (pHEAD:TNexBtrTable;pShow:boolean;Sender:TComponent); // Rozuctuje zadany doklad

implementation

//************************** APPLIC *****************************

procedure DelDocFromJrn (pDocNum:Str12); // Vymaze uctovne zapisiy zadaneho dokladu z dennika UZ
begin
  If gvSys.EasLdg then begin // Jednoduche uctovnictvo
(*    F_FjrAccF := TF_FjrAccF.Create(Application);
    F_FjrAccF.DelDoc (pDocNum);
    FreeAndNil (F_FjrAccF);*)
  end
  else begin // Podvojne uctovnictvo
    F_JrnAccF := TF_JrnAccF.Create(Application);
    F_JrnAccF.DelDoc (pDocNum);
    FreeAndNil (F_JrnAccF);
  end;
end;
(*
procedure DocAccount (pHEAD:TNexBtrTable;pShow:boolean); // Rozuctuje zadany doklad
begin
  If gvSys.EasLdg then begin // Jednoduche uctovnictvo
    F_FjrAccF := TF_FjrAccF.Create(NIL);
    F_FjrAccF.Execute (pHEAD,pShow);
    FreeAndNil (F_FjrAccF);
  end
  else begin // Podvojne uctovnictvo
    F_JrnAccF := TF_JrnAccF.Create(NIL);
    F_JrnAccF.Execute (pHEAD,pShow);
    FreeAndNil (F_JrnAccF);
  end;
end;
*)
procedure DocAccount;
begin
  If gvSys.EasLdg then begin // Jednoduche uctovnictvo
(*    F_FjrAccF := TF_FjrAccF.Create(Sender);
    F_FjrAccF.Execute (pHEAD,pShow);
    FreeAndNil (F_FjrAccF);*)
  end
  else begin // Podvojne uctovnictvo
    F_JrnAccF := TF_JrnAccF.Create(Sender);
    F_JrnAccF.Execute (pHEAD,pShow);
    If (Sender is TForm) then begin
      If (Sender as TForm).Visible and (Sender as TForm).Enabled
        then (Sender as TForm).SetFocus
    end else Beep;
    FreeAndNil (F_JrnAccF);
  end;
end;

end.


(*
*********************************************************************
*********************** ROZDIEL UHRADY FAKTUR ***********************
*********************************************************************
AccVal+PdfVal = InvVal - Hodnota faktury
1. BV:  100.00  PD: -0.10   OF:   99.90  faktura   648
2.                          DF:  -99.90  dobropis  648
3.              PD:  0.10   OF:  100.10  faktura   548
4.                          DF: -100.10  dobropis  548

5. BV: -100.00  PD: -0.10   OF: -100.10  dobropis  648
6.                          DF:  100.10  faktura   648
7.              PD:  0.10   OF:  -99.90  dobropis  548
8.                          DF:   99.90  faktura   548

Rozuctovanie:
       ------- PayVal>0 -------            ------- PayVal<0 -------
1. OF  221       100.00    0.00     5. OD  221         0.00  100.00
       311         0.00   99.90            311       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

2. DD  221       100.00    0.00     6. DF  221         0.00  100.00
       321       -99.90    0.00            321       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

3. OF  221       100.00    0.00     7. OD  221         0.00  100.00
       311         0.00  100.10            311        99.90    0.00
       548         0.10    0.00            548         0.10    0.00

4. DD  221       100.00    0.00     8. DF  221         0.00  100.00
       321      -100.10    0.00            321        99.90    0.00
       548         0.10    0.00            548         0.10    0.00

*********************************************************************
********************** KURZOVY ROZDIEL Z UHRADY *********************
*********************************************************************
AccVal+PdfVal = InvVal - Hodnota faktury
1. BV:  1000.00  CR: -50.00  OF: 663
2.                           DF: 663
3.               CR:  50.00  OF: 563
4.                           DF: 563

5. BV: -1000.00  CR: -50.10  OF: 648
6.                           DF: 648
7.               CR:  50.10  OF: 548
8.                           DF: 548

Rozuctovanie:
       ------- CrdVal>0 -------            ------- CrdVal<0 -------
1. OF  221      1000.00    0.00     5. OD  221         0.00  100.00
       311         0.00   99.90            311       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

2. DD  221       100.00    0.00     6. DF  221         0.00  100.00
       321       -99.90    0.00            321       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

3. OF  221       100.00    0.00     7. OD  221         0.00  100.00
       311         0.00  100.10            311        99.90    0.00
       548         0.10    0.00            548         0.10    0.00

4. DD  221       100.00    0.00     8. DF  221         0.00  100.00
       321      -100.10    0.00            321        99.90    0.00
       548         0.10    0.00            548         0.10    0.00
*)

{MOD 1901007}
