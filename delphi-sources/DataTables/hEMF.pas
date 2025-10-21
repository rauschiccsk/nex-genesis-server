unit hEmf;

interface

uses
  IcTypes, NexPath, NexGlob, bEmf,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TEmfHnd = class (TEmfBtr)
  private
  public
    procedure Open(pCntNum:word);override;
  published
  end;

implementation

{ TEmfHnd }

procedure TEmfHnd.Open(pCntNum: word);
begin
  inherited Open(pCntNum);
  If not LocateEmfNum(0) then begin
    Insert;
    EmfNum:=0;EmfName:='Doru�en� po�ta';
    Post;
  end;
  If not LocateEmfNum(1) then begin
    Insert;
    EmfNum:=1;EmfName:='Na odoslanie';
    Post;
  end;
  If not LocateEmfNum(2) then begin
    Insert;
    EmfNum:=2;EmfName:='Odoslan� po�ta';
    Post;
  end;
  If not LocateEmfNum(3) then begin
    Insert;
    EmfNum:=3;EmfName:='Koncepty';
    Post;
  end;
  If not LocateEmfNum(4) then begin
    Insert;
    EmfNum:=4;EmfName:='Archivovan� po�ta';
    Post;
  end;
  If not LocateEmfNum(5) then begin
    Insert;
    EmfNum:=5;EmfName:='Zru�en� po�ta';
    Post;
  end;
end;

end.
