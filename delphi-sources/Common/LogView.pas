unit LogView;

interface

uses
  NexPath,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin;

type
  TLogView_F = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StrList: TMemo;
    Edit1: TEdit;
    Button1: TButton;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    E_Refresh: TCheckBox;
    E_RefTime: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure E_RefTimeChange(Sender: TObject);
    procedure E_RefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Exexute (pList:TStrings);
    { Public declarations }
  end;

  procedure LogFileView (pList:TStrings);

var
  LogView_F: TLogView_F;

implementation

{$R *.DFM}

procedure LogFileView (pList:TStrings);
begin
  LogView_F:=TLogView_F.Create(Application);
  If pList<> NIL then LogView_F.Exexute(pList);
  LogView_F.ShowModal;
  FreeAndNil(LogView_F);
end;

{ TLogView_F }

procedure TLogView_F.Exexute(pList: TStrings);
begin
  StrList.Lines.AddStrings(pList);
end;

procedure TLogView_F.FormCreate(Sender: TObject);
begin
  Edit1.Text:=gPath.SysPath+'LOG\DocToBok.log';
end;

procedure TLogView_F.Button1Click(Sender: TObject);
begin
  OpenDialog1.FileName:=Edit1.Text;
  If OpenDialog1.Execute then begin
    Edit1.Text:=OpenDialog1.FileName;
    If FileExists(Edit1.Text) then StrList.Lines.LoadFromFile(Edit1.Text);
  end;
end;

procedure TLogView_F.Timer1Timer(Sender: TObject);
begin
  If FileExists(Edit1.Text) then StrList.Lines.LoadFromFile(Edit1.Text);
end;

procedure TLogView_F.E_RefTimeChange(Sender: TObject);
begin
  Timer1.Interval:=E_RefTime.Value*1000;
end;

procedure TLogView_F.E_RefreshClick(Sender: TObject);
begin
  Timer1.Enabled:=E_Refresh.Checked;
end;

end.
