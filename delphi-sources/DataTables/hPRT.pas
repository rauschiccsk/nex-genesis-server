unit hPRT; 

interface

uses
  IcTypes, NexPath, NexGlob, bPRT,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPrtHnd = class (TPrtBtr)
  private
  public
    procedure Add(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word;pLinTxt:Str250);
    procedure Del(pDocNum:Str12); overload;
    procedure Del(pDocNum:Str12;pItmNum:word); overload;
    procedure Del(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1); overload;
  published
  end;

implementation

procedure TPrtHnd.Add(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word;pLinTxt:Str250);
begin
  Insert;
  DocNum:=pDocNum;
  ItmNum:=pItmNum;
  TxtTyp:=pTxtTyp;
  LinNum:=pLinNum;
  LinTxt:=pLinTxt;
  Post;
end;

procedure TPrtHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TPrtHnd.Del(pDocNum:Str12;pItmNum:word);
begin
  While LocateDoIt(pDocNum,pItmNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TPrtHnd.Del(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1);
begin
  While LocateDoItTy(pDocNum,pItmNum,pTxtTyp) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
{MOD 1810004}
