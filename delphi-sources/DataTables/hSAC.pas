unit hSAC;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, bSAC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSacHnd = class (TSacBtr)
  private
    function GetBokNum: Str5;
  public
    procedure Post; overload;
    function NextSerNum(pDocNum:Str12):word;
  published
    property BokNum:Str5 read GetBokNum;
  end;

implementation

function TSacHnd.GetBokNum: Str5;
begin
  Result := BtrTable.BookNum;
end;

function TSacHnd.NextSerNum(pDocNum: Str12): word;
begin
  Result:=1;
  If NearestDnSn (pDocNum,65500) then begin
    If not Eof then Prior else Last;
  end else begin
    Last;
  end;
  If DocNum=pDocNum then Result:=SacNum+1;
end;

procedure TSacHnd.Post;
begin
  If MgCode>gvSys.SecMgc then ItmType := 'W';
  inherited ;
end;

end.
