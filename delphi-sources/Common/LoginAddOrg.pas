unit LoginAddOrg;

interface

uses
  EncodeIni, LoginUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xpComp, StdCtrls, Grids;

type
  TF_LoginAddOrg = class(TForm)
    L_FirmaName: TxpLabel;
    E_FirmaName: TxpEdit;
    L_Path: TxpLabel;
    E_Path: TxpEdit;
    B_Path: TxpBitBtn;
    B_OK: TxpBitBtn;
    B_Cancel: TxpBitBtn;
    OD_Path: TOpenDialog;
    procedure B_CancelClick(Sender: TObject);
    procedure B_OKClick(Sender: TObject);
    procedure B_PathClick(Sender: TObject);
  private
    oIniFile  : string;
  public
    procedure Execute (pIniFile:string);
  end;

var
  F_LoginAddOrg: TF_LoginAddOrg;

implementation

{$R *.dfm}

procedure TF_LoginAddOrg.Execute (pIniFile:string);
begin
 oIniFile := pIniFile;
 E_Path.Text := GetNEXRunRoot;
 If E_Path.Text='' then E_Path.Text := 'C:\NEX\';
 ShowModal;
end;

procedure TF_LoginAddOrg.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_LoginAddOrg.B_OKClick(Sender: TObject);
var mIni:TEncodeIniFile; mErr:longint; mGrp:string;
begin
  If (E_FirmaName.Text<>'') and (E_Path.Text<>'') then begin
    mIni := TEncodeIniFile.Create(oIniFile, FALSE, FALSE, 30000, mErr);
    mIni.Encode := cOrgLstEncode;
    If mErr=0 then begin
      mGrp := 'ORG_01';
      If not mIni.SectionExists(mGrp) then begin
        mIni.WriteString(mGrp, 'Name', E_FirmaName.Text);
        mIni.WriteString(mGrp, 'Years', 'ACT');
        mIni.WriteString(mGrp, 'YearsEnab', 'ACT');
        If Copy (E_Path.Text, Length (E_Path.Text), 1)<>'\' then E_Path.Text := E_Path.Text+'\';
        mIni.WriteString(mGrp, 'Path', E_Path.Text);
        mIni.WriteString(mGrp, 'ModUser', '');
        mIni.WriteString(mGrp, 'ModDate', FormatDateTime ('dd.mm.yyyy', Date));
        mIni.WriteString(mGrp, 'ModTime', FormatDateTime ('hh:nn:ss', Time));
      end;
    end;
    FreeAndNil (mIni);
    Close;
  end;
end;

procedure TF_LoginAddOrg.B_PathClick(Sender: TObject);
begin
  OD_Path.InitialDir := E_Path.Text;
  OD_Path.FileName := '*.*';
  OD_Path.DefaultExt := '*.*';
  OD_Path.Filter := '*.*';
  If OD_Path.Execute then begin
    E_Path.Text := ExtractFilePath (OD_Path.FileName);
  end;
end;

end.
