unit hGSNOTI;

interface

uses
  IcTypes, NexPath, NexGlob, bGSNOTI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TGsnotiHnd = class (TGsnotiBtr)
  private
  public
    procedure Del (pGsCode:longint);
    procedure Add (pGsCode:longint;pTxtLst:TStrings);
    procedure Get (pGsCode:longint;pTxtLst:TStrings);
  published
  end;

implementation

procedure TGsnotiHnd.Del (pGsCode:longint);
begin
  While LocateGsCode(pGsCode) do Delete;
end;

procedure TGsnotiHnd.Add (pGsCode:longint;pTxtLst:TStrings);
var I:word;
begin
  Del (pGsCode);
  If pTxtLst.Count>0 then begin
    For I:=0 to pTxtLst.Count-1 do begin
      Insert;
      GsCode := pGsCode;
      Notice := pTxtLst.Strings[I];
      Post;
    end;
  end;
end;

procedure TGsnotiHnd.Get (pGsCode:longint;pTxtLst:TStrings);
begin
  pTxtLst.Clear;
  If LocateGsCode(pGsCode) then begin
    Repeat
      pTxtLst.Add(Notice);
      Next;
    until Eof or (GsCode<>pGsCode);
  end;
end;

end.
