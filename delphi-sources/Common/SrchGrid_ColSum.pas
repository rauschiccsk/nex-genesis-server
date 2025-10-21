unit SrchGrid_ColSum;

interface

uses
  {NEX} BtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StdCtrls, ExtCtrls;

type
  TF_CalcFldInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    Label9: TLabel;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute (pTable:TBTrieveTable;pType:byte;pFld:TField;pSum:double;pCount:longint);
  end;

var
  F_CalcFldInfo: TF_CalcFldInfo;

implementation

{$R *.DFM}

procedure TF_CalcFldInfo.Execute (pTable:TBTrieveTable;pType:byte;pFld:TField;pSum:double;pCount:longint);
begin
  case pType of
    1: caption:='S��et polo�iek od vybran�ho z�znamu';
    2: caption:='S��et polo�iek po vybran� z�znam';
  else caption:='S��et polo�iek v�etk�ch z�znamov';
  end;
  If pTable.Filtered then Caption:=Caption+' (filtrovanej datab�zy)';
  Label5.Caption:=pFld.FieldName;
  Label9.Caption:=IntToStr(pFld.FieldNo)+' :';
  If pSum>=0 then begin
    Label6.Caption:=IntToStr(pCount);
    Label7.Caption:=FloatToStr(pSum);
    Label8.Caption:=FloatToStr(pSum/pCount);
  end else begin
    Label6.Caption:='polo�ka nie je numerick�';
    Label7.Caption:=Label6.Caption;
    Label8.Caption:=Label6.Caption;
  end;
  ShowModal;
end;

procedure TF_CalcFldInfo.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TF_CalcFldInfo.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Close;
end;

end.
