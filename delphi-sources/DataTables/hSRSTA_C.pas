unit hSrsta_c;

interface

uses
  IcTypes, NexPath, NexGlob, bSrsta_c,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TSrsta_cHnd = class (TSrsta_cBtr)
  private
    function  ReadInvQnt:smallint;           procedure WriteInvQnt (pValue:smallint);
  public
  published
    property InvQnt:smallint read ReadInvQnt write WriteInvQnt;
  end;

implementation

function TSrsta_cHnd.ReadInvQnt:smallint;
begin
  If BtrTable.FindField('InvQnt')<> NIL
    then Result := Round(BtrTable.FieldByName('InvQnt').AsFloat)
    else Result := ModNum;
end;

procedure TSrsta_cHnd.WriteInvQnt(pValue:smallint);
begin
  If BtrTable.FindField('InvQnt')<> NIL
    then BtrTable.FieldByName('InvQnt').AsFloat:=pValue
    else ModNum := pValue;
end;

end.
