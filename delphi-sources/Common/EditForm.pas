unit EditForm;

interface

uses
  LangForm,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IcStand, ComCtrls;

type
  TEditForm1 = class(TLangForm)
    StatusLine: TStatusLine;
    P_Back: TDinamicPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NexForm1: TEditForm1;

implementation

{$R *.DFM}

end.
 