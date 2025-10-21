unit hDEBREG;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, bDEBREG,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TDebregHnd=class (TDebregBtr)
  private
  public
    procedure AddDoc(pPaCode:longint;pDocNum:Str12;pDebVal:double;pExpDat:TDateTime);
  published
  end;

  var ghDEBREG:TDebregHnd;

implementation

procedure TDebregHnd.AddDoc(pPaCode:longint;pDocNum:Str12;pDebVal:double;pExpDat:TDateTime);
begin
  If IsNul(pDebVal) then begin // Vymažeme záznam
    If LocateDocNum(pDocNum) then Delete;
  end else begin  // Pridáme záznam
    If not LocateDocNum(pDocNum) then begin
      Insert;
      PaCode:=pPaCode;
      DocNum:=pDocNum;
      DebVal:=pDebVal;
      ExpDat:=pExpDat;
      Post;
    end else begin
      If (PaCode<>pPaCode) or (DebVal<>pDebVal) or (ExpDat<>pExpDat) then begin
        Edit;
        PaCode:=pPaCode;
        DebVal:=pDebVal;
        ExpDat:=pExpDat;
        Post;
      end;
    end;
  end;
end;

end.
{MOD 1919001}
