unit QRepF_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, StdCtrls, Buttons;

type
  TF_Functions = class(TForm)
    SG_Functions: TStringGrid;
    Panel1: TPanel;
    BB_OK: TBitBtn;
    BB_Cancel: TBitBtn;
    BB_Insert: TBitBtn;
    BB_Delete: TBitBtn;
    procedure BB_OKClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure BB_InsertClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
  private
    oSave    : boolean;
    { Private declarations }
  public
    function Execute:boolean;
    { Public declarations }
  end;

var
  F_Functions: TF_Functions;

implementation

{$R *.DFM}

function TF_Functions.Execute:boolean;
begin
  oSave := FALSE;
  ShowModal;
  Result := oSave;
end;

procedure TF_Functions.BB_OKClick(Sender: TObject);
begin
       oSave := TRUE;
  Close;
end;

procedure TF_Functions.BB_CancelClick(Sender: TObject);
begin
  oSave := FALSE;
  Close;
end;

procedure TF_Functions.BB_InsertClick(Sender: TObject);
begin
  SG_Functions.RowCount := SG_Functions.RowCount+1;
  SG_Functions.Row := SG_Functions.RowCount-1;
  SG_Functions.Col := 0;
  SG_Functions.SetFocus;
end;

procedure TF_Functions.BB_DeleteClick(Sender: TObject);
var I:longint;
begin
  If SG_Functions.RowCount>1 then begin
    If SG_Functions.Row<>SG_Functions.RowCount-1 then begin
      For I:=SG_Functions.Row+1  to SG_Functions.RowCount-1 do begin
        SG_Functions.Cells[0,I-1] := SG_Functions.Cells[0,I];
        SG_Functions.Cells[1,I-1] := SG_Functions.Cells[1,I];
      end;
    end;
    SG_Functions.Cells[0,SG_Functions.RowCount-1] := '';
    SG_Functions.Cells[1,SG_Functions.RowCount-1] := '';
    If SG_Functions.RowCount>2 then SG_Functions.RowCount := SG_Functions.RowCount-1;
    SG_Functions.SetFocus;
  end;
end;

end.
