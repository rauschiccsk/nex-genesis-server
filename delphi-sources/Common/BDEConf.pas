unit BDEConf;

interface

uses
  DBTables,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xpComp, StdCtrls;

type PCardinal = ^Cardinal;

type
  TOsGetSharedPtrFunc = function (Par1 : Cardinal; Par2 : PCardinal) : Cardinal; stdcall;

type
  TForm1 = class(TForm)
    xpBitBtn1: TxpBitBtn;
    xpMemo1: TxpMemo;
    xpBitBtn2: TxpBitBtn;
    procedure xpBitBtn1Click(Sender: TObject);
    procedure xpBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.xpBitBtn1Click(Sender: TObject);
var mSession:TSession; mList: TStrings;
begin
  xpMemo1.Clear;
  mList:=TStringList.Create;
  try
    mSession := TSession.Create(nil);
    mSession.AutoSessionName := TRUE;
    mSession.NetFileDir := '';
    mSession.ConfigMode := [];
    mSession.GetConfigParams('\Drivers\PARADOX\INIT', '', mList);
    xpMemo1.Text:=mList.Text;
    mList.Clear;
    mSession.GetConfigParams('\System\INIT', '', mList);
    xpMemo1.Lines.Add('---------------');
    xpMemo1.Text:=xpMemo1.Text+mList.Text;

//    mSession.ModifyConfigParam('\Drivers\PARADOX\INIT', 'NET DIR='+'');
//    mSession.ModifyConfigParam('\System\INIT', 'LOCAL SHARE=TRUE');
//    mSession.SaveConfigFile;
    mSession.Free;
    Session.Active := FALSE;
  except
  end;
  FreeAndNil(mList);
end;

procedure TForm1.xpBitBtn2Click(Sender: TObject);
var
  OsGetSharedPtrFunc : TOsGetSharedPtrFunc;
  base, size : Cardinal;
  lib : HMODULE;
begin
  lib := LoadLibrary('idapi32.dll');
  if lib = 0 then
    ShowMessage('Could not LoadLibrary().')
  else
    try
      OsGetSharedPtrFunc := GetProcAddress(lib, 'OsGetSharedPtr');
      if @OsGetSharedPtrFunc <> nil then
      begin
        OsGetSharedPtrFunc(9, @base);
        OsGetSharedPtrFunc($A, @size);
        ShowMessageFmt('%x %x', [base, size]);
      end
      else
        ShowMessage('Could not GetProcAddress().');
    finally
      FreeLibrary(lib);
    end;
end;

end.


procedure TF_SallySetup.WriteBDEConfig;
var mSession:TIcSession;
begin
  try
    mSession := TIcSession.Create(nil);
    mSession.AutoSessionName := TRUE;
    mSession.NetFileDir := E_RootPath.Text+'SYSTEM\';
    mSession.ConfigMode := [];
    mSession.ModifyConfigParam('\Drivers\PARADOX\INIT', 'NET DIR='+E_RootPath.Text+'SYSTEM\');
    mSession.ModifyConfigParam('\System\INIT', 'LOCAL SHARE=TRUE');
    mSession.SaveConfigFile;
    mSession.Free;
    Session.Active := FALSE;
    M_InstallAdv.Lines.Add ('Konfigurácia databázového ovládaèa.');
    WriteToLog (M_InstallAdv.Lines.Strings[M_InstallAdv.Lines.Count-1]);
  except
    M_InstallAdv.Lines.Add ('Chyba pri konfigurácií databázového ovládaèa.');
    WriteToLog (M_InstallAdv.Lines.Strings[M_InstallAdv.Lines.Count-1]);
    M_End.Lines.Add (M_InstallAdv.Lines.Strings[M_InstallAdv.Lines.Count-1]);
  end;
end;


procedure TIcSession.ModifyConfigParam(pPath, pParam: string);
var mParams: TStringList;
begin
  mParams := TStringList.Create;
  try
    mParams.Add(pParam);
    ModifyConfigParams(pPath, '', mParams);
  finally
    mParams.Free;
  end;
end;


NET DIR=C:\NEXTEMP\
LOCAL SHARE=FALSE
SHAREDMEMSIZE=8192
SHAREDMEMLOCATION=
