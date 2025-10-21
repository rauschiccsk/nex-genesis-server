unit EdiFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, eEDIDOC, eEDIITM, eEDINOT, eEDIREG,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TEdiFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohEDIDOC:TEdidocHne;  // Došlé elektronické faktúry - hlavièky
    ohEDIITM:TEdiitmHne;  // Došlé elektronické faktúry - položky
    ohEDINOT:TEdinotHne;  // Došlé elektronické faktúry - poznámky
    ohEDIREG:TEdiregHne;  // Došlé elektronické faktúry - register

    procedure ClcActDoc;                 // Prepoèíta hlavièkové údaje aktuálneho dokladu
    procedure ClcSlcDoc(pExtNum:Str12);  // Prepoèíta hlavièkové údaje zadaného dokladu
  end;

implementation

uses dEDIITM;

constructor TEdiFnc.Create;
begin
  ohEDIDOC:=TEdidocHne.Create;
  ohEDIITM:=TEdiitmHne.Create;
  ohEDINOT:=TEdinotHne.Create;
  ohEDIREG:=TEdiregHne.Create;
end;

destructor TEdiFnc.Destroy;
begin
  FreeAndNil(ohEDIREG);
  FreeAndNil(ohEDINOT);
  FreeAndNil(ohEDIITM);
  FreeAndNil(ohEDIDOC);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TEdiFnc.ClcActDoc;  // Prepoèíta hlavièkové údaje aktuálneho dokladu
var mDocAva,mDocBva:double; mItmQnt,mNidQnt:word;
begin
  mDocAva:=0;  mDocBva:=0;  mItmQnt:=0;  mNidQnt:=0;
  If ohEDIITM.LocExtNum(ohEDIDOC.ExtNum) then begin
    Repeat
      mDocAva:=mDocAva+ohEDIITM.DlvAva;
      mDocBva:=mDocBva+ohEDIITM.DlvAva;
      mItmQnt:=mItmQnt+1;
      If ohEDIITM.ProNum=0 then mNidQnt:=mNidQnt+1;
      Application.ProcessMessages;
      ohEDIITM.Next;
    until ohEDIITM.Eof or (ohEDIITM.ExtNum<>ohEDIDOC.ExtNum);
  end;
  ohEDIDOC.Edit;
  ohEDIDOC.DocAva:=mDocAva;
  ohEDIDOC.DocBva:=mDocBva;
  ohEDIDOC.ItmQnt:=mItmQnt;
  ohEDIDOC.NidQnt:=mNidQnt;
  ohEDIDOC.Post;
end;

procedure TEdiFnc.ClcSlcDoc(pExtNum:Str12);  // Prepoèíta hlavièkové údaje zadaného dokladu
begin
  If ohEDIDOC.LocExtNum(pExtNum) then ClcActDoc;
end;

end.


