unit hSCVSRH;

interface

uses
  IcTypes, NexPath, NexGlob, bSCVSRH,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TScvsrhHnd=class (TScvsrhBtr)
  private
  public
    procedure Del(pEquNum:Str20);
    procedure Add(pEquNum:Str20;pSrhKey:Str30;pKeyTyp:Str1);
  published
  end;

implementation

procedure TScvsrhHnd.Del(pEquNum:Str20);
begin
  If LocateEquNum(pEquNum) then begin
    Repeat
      Delete;
    until Eof or (EquNum<>pEquNum);
  end;
end;

procedure TScvsrhHnd.Add(pEquNum:Str20;pSrhKey:Str30;pKeyTyp:Str1);
begin
  If (pEquNum<>'') and (pSrhKey<>'') then begin
    Insert;
    EquNum:=pEquNum;
    SrhKey:=pSrhKey;
    KeyTyp:=pKeyTyp;
    Post;
  end;
end;

end.
{MOD 1916001}
