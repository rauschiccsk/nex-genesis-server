unit BookBckTxt;

interface

uses
  BckTxt,
  BtrTable, NexBtrTable,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, xpComp, StdCtrls, ExtCtrls, ZipMstr;

type
  TF_BookBckTxt = class(TForm)
    xpSinglePanel1: TxpSinglePanel;
    xpMemo1: TxpMemo;
    B_Backup: TxpBitBtn;
    B_Cancel: TxpBitBtn;
    PB_Ind: TProgressBar;
    procedure B_BackupClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
  private
    oExit      : boolean;
    oType      : byte;
    oFrmName   : string;
    oHead      : TBtrieveTable;
    oItm1      : TNexBtrTable;
    oItm2      : TNexBtrTable;
    oItm3      : TNexBtrTable;
    { Private declarations }
  public
    procedure Execute (pHead,pItm1,pItm2,pItm3:TNexBtrTable;pType:byte;pFrmName:string);
    { Public declarations }
  end;

  procedure ExecuteBookBckTxt (pHead,pItm1:TNexBtrTable;pType:byte;pFrmName:string); overload;
  procedure ExecuteBookBckTxt (pHead,pItm1,pItm2:TNexBtrTable;pType:byte;pFrmName:string); overload;
  procedure ExecuteBookBckTxt (pHead,pItm1,pItm2,pItm3:TNexBtrTable;pType:byte;pFrmName:string); overload;

var
  F_BookBckTxt: TF_BookBckTxt;


implementation

{$R *.dfm}

procedure ExecuteBookBckTxt (pHead,pItm1:TNexBtrTable;pType:byte;pFrmName:string);
begin
  ExecuteBookBckTxt (pHead,nil,nil,pType,pFrmName);
end;

procedure ExecuteBookBckTxt (pHead,pItm1,pItm2:TNexBtrTable;pType:byte;pFrmName:string);
begin
  ExecuteBookBckTxt (pHead,pItm1,nil,pType,pFrmName);
end;

procedure ExecuteBookBckTxt (pHead,pItm1,pItm2,pItm3:TNexBtrTable;pType:byte;pFrmName:string);
var  mR: TF_BookBckTxt;
begin
  mR := TF_BookBckTxt.Create(nil);
  mR.Execute(pHead,pItm1,pItm2,pItm3,pType,pFrmName);
  FreeAndNil (mR);
end;

procedure TF_BookBckTxt.Execute (pHead,pItm1,pItm2,pItm3:TNexBtrTable;pType:byte;pFrmName:string);
begin
  oType := pType;
  oFrmName := pFrmName;
  oItm1 := pItm1;
  oItm2 := pItm2;
  oItm3 := pItm3;
  oHead := TBtrieveTable.Create(nil);
  oHead.DataBaseName := pHead.DataBaseName;
  oHead.TableName := pHead.TableName;
  oHead.FixedName := pHead.FixedName;
  oHead.DefPath := pHead.DefPath;
  oHead.DefName := pHead.DefName;
  oHead.Open;
  oHead.IndexName := pHead.IndexName;
  oHead.GotoPos (pHead.ActPos);
  ShowModal;
end;

procedure TF_BookBckTxt.B_BackupClick(Sender: TObject);
var mTxtBck:TBckTxt;
begin
  oExit := FALSE;
  mTxtBck := TBckTxt.Create(cArch,FALSE);
  oHead.First;
  PB_Ind.Max := oHead.RecordCount; PB_Ind.Position := 0;
  Repeat
    mTxtBck.WriteDocToTxt(oHead,oItm1,oItm2,oItm3,oFrmName,'SERVICE');
    PB_Ind.Position := PB_Ind.Position+1;
    Application.ProcessMessages;
    oHead.Next;
  until oHead.Eof or oExit;
  FreeAndNil (mTxtBck);
  Close;
end;

procedure TF_BookBckTxt.B_CancelClick(Sender: TObject);
begin
  oExit := TRUE;
end;

end.
