(* ************** unit uProp ***************

  property editor in run time  ver. 1.3 for D3

 ******************************************* *)

unit PropEditor;

interface

uses
  PropEdit,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons;

type
  TPropEditor = class(TSpeedButton)
  private
    { Private declarations }
  protected
    procedure Click; override;
    Destructor Destroy; override;
    { Protected declarations }
  public
    { Public declarations }
  published
    procedure Execute;
    procedure Close;
    procedure ExecuteProp(pA:Tobject;pModal:boolean);
    { Published declarations }
  end;

procedure Register;

implementation

Destructor TPropEditor.Destroy;
begin
  Close;
  Inherited Destroy;
End;

procedure TPropEditor.Click;
begin
  inherited Click;
  Execute;
end;

procedure TPropEditor.Close;
begin
  If FF_CompEdit<>nil then begin
    FF_CompEdit.Free;
    FF_CompEdit:=nil;
  end;
end;

procedure TPropEditor.Execute;
begin
  if FF_CompEdit=nil then Application.CreateForm(TFF_CompEdit,FF_CompEdit);
  FF_CompEdit.Execute(Owner,False);
end;

procedure TPropEditor.ExecuteProp(pA:Tobject;pModal:boolean);
begin
  if FF_CompEdit=nil then Application.CreateForm(TFF_CompEdit,FF_CompEdit);
  FF_CompEdit.Execute(TComponent(pA),pModal);
end;

procedure Register;
begin
  RegisterComponents('IcQuickRep', [TPropEditor]);
end;

end.
