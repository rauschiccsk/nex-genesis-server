unit ImageView;

interface
{THIS UNIT WAS BORROWED FROM THE BORLAND DEMOS AND MODIFIED}
uses Windows, Classes, Graphics, Forms, Controls,
  FileCtrl, StdCtrls, ExtCtrls, Buttons, Spin, ComCtrls;

type
  TFF_Image = class(TForm)
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    FileEdit: TEdit;
    UpDownGroup: TGroupBox;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    DisabledGrp: TGroupBox;
    SpeedButton2: TSpeedButton;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    FileListBox1: TFileListBox;
    Label2: TLabel;
    ViewBtn: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    FilterComboBox1: TFilterComboBox;
    GlyphCheck: TCheckBox;
    StretchCheck: TCheckBox;
    UpDownEdit: TEdit;
    UpDown1: TUpDown;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FileListBox1Click(Sender: TObject);
    procedure ViewBtnClick(Sender: TObject);
    procedure ViewAsGlyph(const FileExt: string);
    procedure GlyphCheckClick(Sender: TObject);
    procedure StretchCheckClick(Sender: TObject);
    procedure FileEditKeyPress(Sender: TObject; var Key: Char);
    procedure UpDownEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FormCaption: string;
  Public
    Procedure SetMasks(Const FilterMask : String;
                       Const EditMask   : String;
                       Const ListMask   : String);
    Procedure IconsOnly;
    Procedure BmpsOnly(IsGlyph : Boolean);
  end;

var
  FF_Image: TFF_Image;

implementation

uses SysUtils,ImageShow;

{$R *.DFM}

procedure TFF_Image.FileListBox1Click(Sender: TObject);
var
  FileExt: string[4];
begin
  FileExt := UpperCase(ExtractFileExt(FileListBox1.Filename));
  if (FileExt = '.BMP') or (FileExt = '.ICO') or (FileExt = '.WMF') or
    (FileExt = '.EMF') then
  begin
    Image1.Picture.LoadFromFile(FileListBox1.Filename);
    Caption := FormCaption + ExtractFilename(FileListBox1.Filename);
    if (FileExt = '.BMP') then
    begin
      Caption := Caption +
        Format(' (%d x %d)', [Image1.Picture.Width, Image1.Picture.Height]);
      F_ViewImage.Image1.Picture := Image1.Picture;
      F_ViewImage.Caption := Caption;
      if GlyphCheck.Checked then ViewAsGlyph(FileExt);
    end;
    if FileExt = '.ICO' then Icon := Image1.Picture.Icon;
    if (FileExt = '.WMF') or (FileExt = '.EMF') then
      F_ViewImage.Image1.Picture.Metafile := Image1.Picture.Metafile;
  end;
end;

procedure TFF_Image.GlyphCheckClick(Sender: TObject);
begin
  ViewAsGlyph(UpperCase(ExtractFileExt(FileListBox1.Filename)));
end;
procedure TFF_Image.ViewBtnClick(Sender: TObject);
begin
  F_ViewImage.HorzScrollBar.Range := Image1.Picture.Width;
  F_ViewImage.VertScrollBar.Range := Image1.Picture.Height;
  F_ViewImage.Caption := Caption;
  F_ViewImage.ShowModal;
  F_ViewImage.WindowState := wsNormal;
end;
procedure TFF_Image.ViewAsGlyph(const FileExt: string);
begin
  if GlyphCheck.Checked and (FileExt = '.BMP') then
  begin
    SpeedButton1.Glyph := Image1.Picture.Bitmap;
    SpeedButton2.Glyph := Image1.Picture.Bitmap;
    UpDown1.Position := SpeedButton1.NumGlyphs;
    BitBtn1.Glyph := Image1.Picture.Bitmap;
    BitBtn2.Glyph := Image1.Picture.Bitmap;
    UpDown1.Enabled := True;
    UpDownEdit.Enabled := True;
    Label2.Enabled := True;
  end
  else begin
    SpeedButton1.Glyph := nil;
    SpeedButton2.Glyph := nil;
    BitBtn1.Glyph := nil;
    BitBtn2.Glyph := nil;
    UpDown1.Enabled := False;
    UpDownEdit.Enabled := False;
    Label2.Enabled := False;
  end;
end;

procedure TFF_Image.UpDownEditChange(Sender: TObject);
begin
  SpeedButton1.NumGlyphs := UpDown1.Position;
  SpeedButton2.NumGlyphs := UpDown1.Position;
end;

procedure TFF_Image.StretchCheckClick(Sender: TObject);
begin
  Image1.Stretch := StretchCheck.Checked;
end;

procedure TFF_Image.FileEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FileListBox1.ApplyFilePath(FileEdit.Text);
    Key := #0;
  end;
end;

procedure TFF_Image.FormCreate(Sender: TObject);
begin
  if F_ViewImage=nil then Application.CreateForm(TF_ViewImage,F_ViewImage); // tungli
  FormCaption := Caption + ' - ';
end;

Procedure TFF_Image.SetMasks(Const FilterMask : String;
                              Const EditMask   : String;
                              Const ListMask   : String);
begin
  FilterComboBox1.Filter:=FilterMask;
  FileEdit.Text:=EditMask;
  FileListBox1.Mask:=ListMask;
end;
Procedure TFF_Image.IconsOnly;
begin
  SetMasks('Icon Files(*.ico)*.ico','*.ico','*.ico');
  FileEdit.Enabled:=False;
  FilterCombobox1.Enabled:=False;
  ViewBtn.Enabled:=False;
  GlyphCheck.Enabled:=False;
  StretchCheck.Enabled:=False;
  ViewAsGlyph('.ICO');
end;
Procedure TFF_Image.BmpsOnly(IsGlyph : Boolean);
begin
  SetMasks('Bitmap Files(*.bmp)*.bmp','*.bmp','*.bmp');
  FileEdit.Enabled:=False;
  FilterCombobox1.Enabled:=False;
  If IsGlyph then
  begin
    GlyphCheck.Checked:=True;
    ViewAsGlyph('.BMP');
  end
  else
    ViewAsGlyph('.ICO');
end;
procedure TFF_Image.FormHide(Sender: TObject);
begin
  SetMasks(
  'Image Files (*.bmp, *.ico, *.wmf, *.emf)|'+
  '*.bmp;*.ico;*.wmf;*.emf|Bitmap Files (*.bmp)|'+
  '*.bmp|Icons (*.ico)|*.ico|Metafiles (*.wmf, *.emf)|*.wmf;*.emf|All files (*.*)|*.*',
  '*.bmp;*.ico;*.wmf;*.emf','*.bmp;*.ico;*.wmf;*.emf');
  ViewAsGlyph('.ICO');
  FileEdit.Enabled:=True;
  FilterCombobox1.Enabled:=True;
  GlyphCheck.Enabled:=True;
  StretchCheck.Enabled:=True;
  UpDownEdit.Enabled:=True;
  UpDown1.Enabled:=True;
  ViewBtn.Enabled:=False;
end;

procedure TFF_Image.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if F_ViewImage<>nil then begin   // tungli all
    F_ViewImage.Free;
    F_ViewImage:=nil;
  end;
end;

end.
