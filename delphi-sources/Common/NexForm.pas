unit NexForm;

interface

uses
  LangForm,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TNexForm = class(TLangForm)
  private
    oSaveClick: boolean;
    function SaveOK: boolean;
  public
    procedure NewItem;
    procedure Execute;
    procedure LoadData;
    procedure SaveData;
    function SaveClick: boolean;
  end;

var
  NexForm1: TNexForm;

implementation

{$R *.DFM}

function TNexForm.SaveOk: boolean;
begin
end;

procedure TNexForm.NewItem;
begin
  oSaveClick := FALSE;
  FormClear;
end;

procedure TNexForm.Execute;
begin
  ShowModal;
end;

procedure TNexForm.LoadData;
begin
end;

procedure TNexForm.SaveData;
begin
  If SaveOk then begin
    oSaveClick := TRUE
    // Ulozit udaje
  end;
end;

function TNexForm.SaveClick: boolean;
begin
  Result := oSaveClick;
end;

end.
