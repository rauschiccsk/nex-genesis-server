unit hNXBDEF;

interface

uses
  IcTypes, NexPath, NexGlob, bNXBDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TNxbdefHnd = class (TNxbdefBtr)
  private
  public
    procedure Del (pPmdMark:Str3);
    procedure DelBok (pPmdMark:Str3;pBokNum:Str5);
    function GetBookName (pPmdMark:Str3;pBookNum:Str5):Str40;
  published
  end;

implementation

procedure TNxbdefHnd.Del (pPmdMark:Str3);
begin
  If LocatePmdMark(pPmdMark) then begin
    Repeat
      Delete;
    until Eof or (PmdMark<>pPmdMark)
  end;
end;

procedure TNxbdefHnd.DelBok(pPmdMark: Str3; pBokNum: Str5);
begin
  If LocatePmBn(pPmdMark,pBokNum) then Delete;
end;

function TNxbdefHnd.GetBookName(pPmdMark: Str3; pBookNum: Str5): Str40;
begin
  Result := '';
  If LocatePmBn (pPmdMark,pBookNum) then Result := BookName;
end;

end.
