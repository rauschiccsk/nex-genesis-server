unit ItgLog;

interface

uses
  IcTypes, NexPath, NexGlob, hITGLOG,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TItgLog = class
    constructor Create;
    destructor  Destroy; override;
  private
    ohITGLOG:TItglogHnd;
  public
    procedure Add(pScDocNum:Str12;pScItmNum:word;pTgDocNum:Str12;pTgItmNum:word;pFrmName:Str15);
  published
  end;

implementation

constructor TItgLog.Create;
begin
  ohITGLOG := TItglogHnd.Create;  ohITGLOG.Open;
end;

destructor  TItgLog.Destroy;
begin
  FreeAndNil (ohITGLOG);
end;

procedure TItgLog.Add(pScDocNum:Str12;pScItmNum:word;pTgDocNum:Str12;pTgItmNum:word;pFrmName:Str15);
begin
  ohITGLOG.Insert;
  ohITGLOG.ScDocNum := pScDocNum;
  ohITGLOG.ScItmNum := pScItmNum;
  ohITGLOG.TgDocNum := pTgDocNum;
  ohITGLOG.TgItmNum := pTgItmNum;
  ohITGLOG.FrmName := pFrmName;
  ohITGLOG.Post;
end;

end.
