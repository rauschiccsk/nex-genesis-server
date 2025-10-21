unit RepManager;

interface

uses
  RepManager_Form,
  DB, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TRepManager = class(TComponent)
  private
    { Private declarations }
    oFormSettingsFolder: string;
    oFileNameMask: string; //1999.10.8.
    oFileExtensionMask: string; //1999.10.8.

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    function  Execute(pHead,pItem:TDataSet): boolean;
    procedure EndExecute;
    procedure LoadSetting(pForm: TForm; pFormSettingsFolder, pSettingName: string);
  published
    { Published declarations }
    property FSFolder: string read oFormSettingsFolder write oFormSettingsFolder;
    property FSFileNameMask: string read oFileNameMask write oFileNameMask;
    property FSFileExtensionMask: string read oFileExtensionMask write oFileExtensionMask;
  end;

procedure Register;

implementation

constructor TRepManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSFileNameMask := '*';
  FSFileExtensionMask := '*';
end;


function TRepManager.Execute(pHead,pItem:TDataSet): boolean;
  begin
    if F_RepManager = nil then Application.CreateForm(TF_RepManager, F_RepManager);
    F_RepManager.Execute(pHead,pItem,Owner as TForm, oFormSettingsFolder, oFileNameMask, oFileExtensionMask);
  end;

procedure TRepManager.LoadSetting(pForm: TForm; pFormSettingsFolder, pSettingName: string);
  begin
    if F_RepManager = nil then Application.CreateForm(TF_RepManager, F_RepManager);
    F_RepManager.LoadSetting(pForm,pFormSettingsFolder, pSettingName);
  end;

procedure TRepManager.EndExecute;
  begin
    F_RepManager.EndExecute;
  end;

procedure Register;
begin
  RegisterComponents('IcQuickRep', [TRepManager]);
end;

end.



