unit NexMsgs;

interface

uses
  MsgLst, IcTypes, NexText, NexMsg, NexError, NexGlob,
  Classes;

  procedure EmptyField (pFields:TStrings);  // Niektore z povinne vyplnenych poli nie sudane

  procedure MsgThisDocIsReserved (pCrtUser:Str8);

implementation

procedure EmptyField (pFields:TStrings);  // Niektore z povinne vyplnenych poli nie sudane
begin
  gNT.SetSection ('MESSAGES');
  F_MsgLstF := TF_MsgLstF.Create(Nil);
  F_MsgLstF.SetWinTitle (gNT.GetText('Attention','Upozornenie'));
  F_MsgLstF.SetMsgTitle (gNT.GetText('Warning','POZOR'));
  F_MsgLstF.AddMsgLine ('');
  F_MsgLstF.AddMsgLine (gNT.GetText('EmptyFldMsg1','Nie s� vyplnen� v�etky potrebn� polia.'));
  F_MsgLstF.AddMsgLine (gNT.GetText('EmptyFldMsg2','Dopl�te pros�m ch�baj�ce �daje!'));
  F_MsgLstF.SetLstTitle (gNT.GetText('EmptyLstTitle','Zoznam nevyplnen�ch pol�'));
  F_MsgLstF.Execute (pFields);
  F_MsgLstF.Free;
end;

procedure MsgThisDocIsReserved (pCrtUser:Str8);
begin
  ShowMsg (ecSysThisDocIsReserved,UserName(pCrtUser));
end;


end.
