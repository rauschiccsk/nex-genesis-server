unit DBSrGrid_GridSum;

interface

uses
  IcTools, IcConv, CompTxt,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TSumType = (stAll, stTo, stFrom, stSel);

  TF_GridSum = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    BB_OK: TBitBtn;
    L_Items: TLabel;
    L_Value: TLabel;
    L_Avg: TLabel;
    Label1: TLabel;
    L_Field: TLabel;
    L_Min: TLabel;
    L_Max: TLabel;
    procedure BB_OKClick(Sender: TObject);
    procedure BB_OKKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure  Execute (pType:TSumType;pFld:string;pIt:integer;pVal,pMin,pMax:double);
    { Public declarations }
  end;

var
  F_GridSum: TF_GridSum;

procedure ExecuteGridSum (pType:TSumType;pFld:string;pIt:integer;pVal,pMin,pMax:double);

implementation

{$R *.DFM}

procedure ExecuteGridSum (pType:TSumType;pFld:string;pIt:integer;pVal,pMin,pMax:double);
begin
  F_GridSum := TF_GridSum.Create (Application);
  F_GridSum.Execute (pType,pFld,pIt,pVal,pMin,pMax);
  F_GridSum.Free; F_GridSum := nil;
end;

procedure  TF_GridSum.Execute (pType:TSumType;pFld:string;pIt:integer;pVal,pMin,pMax:double);
begin
  case pType of
    stAll : F_GridSum.Caption := ctGridSum_HeadS;
    stTo  : F_GridSum.Caption := ctGridSum_HeadD;
    stFrom: F_GridSum.Caption := ctGridSum_HeadO;
    stSel : F_GridSum.Caption := ctGridSum_HeadSel;
  end;
  L_Field.Caption := pFld;
  L_Items.Caption := StrInt (pIt,0);
  L_Value.Caption   := StrRealSepar (pVal,0,3,TRUE);
  If pIt>0
    then L_Avg.Caption := StrRealSepar (pVal/pIt,0,3,TRUE)
    else L_Avg.Caption := StrRealSepar (0,0,3,TRUE);
  L_Min.Caption   := StrRealSepar (pMin,0,3,TRUE);
  L_Max.Caption   := StrRealSepar (pMax,0,3,TRUE);
  Label1.Caption := ctGridSum_FldText;
  Label2.Caption := ctGridSum_ItmNum;
  Label3.Caption := ctGridSum_Val;
  Label4.Caption := ctGridSum_Avg;
  Label5.Caption := ctGridSum_Min;
  Label6.Caption := ctGridSum_Max;
  ShowModal;
end;

procedure TF_GridSum.BB_OKClick(Sender: TObject);
begin
  Close;
end;

procedure TF_GridSum.BB_OKKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_ESCAPE then Close;
end;

end.

