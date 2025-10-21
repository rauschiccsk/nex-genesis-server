unit StrListEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TSedForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StrList: TMemo;
    BitBtn3: TBitBtn;
    procedure B_PrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Exexute (pList:TStrings);
    { Public declarations }
  end;

  procedure StrListEditExecute (pList:TStrings);

var
  SedForm: TSedForm;

implementation

uses DB, tDirMoi, NexPxTable, Rep;

{$R *.DFM}

procedure StrListEditExecute (pList:TStrings);
begin
  SedForm:=TSedForm.Create(NIL);
  SedForm.Exexute(pList);
  SedForm.ShowModal;
  FreeAndNil(SedForm);
end;

{ TSedForm }

procedure TSedForm.Exexute(pList: TStrings);
begin
  StrList.Lines.AddStrings(pList);
end;

procedure TSedForm.B_PrintClick(Sender: TObject);
var mRep:TRep; ptLine:TDirmoiTmp; mI:integer;
begin
  If StrList.Lines.Count=0 then Exit;
  ptLine:=TDirmoiTmp.Create;
  ptLine.Open;

  for mI:=0 to StrList.Lines.Count-1 do begin
    ptLine.Insert;
    ptLine.RowNum :=mI;
    ptLine.ModDes :=StrList.Lines[mI];
    ptLine.Post;
  end;

  mRep := TRep.Create(Self);
  mRep.ItmTmp := ptLine.TmpTable;
  mRep.Execute ('LINES');
  FreeAndNil (mRep);

  ptLine.Close;
  FreeAndNil(ptLine);
end;

end.
{MOD 1806003}
{MOD 1806008}

