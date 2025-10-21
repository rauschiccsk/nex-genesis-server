unit TblRef;

interface

uses
  NexBtrTable,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, DB;

type
  PData=^TData;
  TData=record
    Table: TNexBtrTable;
  end;

  TTblRefF=class(TForm)
    Tv_TblLst:TTreeView;
    Timer:TTimer;
    procedure TimerTimer(Sender:TObject);
    procedure FormDestroy(Sender:TObject);
  private
  public
    procedure Add (pTable:TNexBtrTable);
    procedure Del (pTable:TNexBtrTable);
  end;

var gTblRef:TTblRefF;

implementation

{$R *.dfm}


procedure TTblRefF.Add(pTable:TNexBtrTable);
var mNode:TTreeNode;  mData:PData;
begin
  mNode:=Tv_TblLst.Items.Add(nil,pTable.TableName);
  GetMem (mData,SizeOf(TData));
  mData^.Table:=pTable;
  mNode.Data:=mData;
end;

procedure TTblRefF.Del (pTable:TNexBtrTable);
var mNode:TTreeNode;  mData:PData;  I:integer;  mFind:boolean;
begin
  If Tv_TblLst.Items.Count>0 then begin
    I:=-1;
    Repeat
      Inc(I);
      mFind:=Tv_TblLst.Items[I].Text=pTable.TableName;
    until mFind or (I=Tv_TblLst.Items.Count-1);
    If mFind then begin
      mData:=Tv_TblLst.Items[I].Data;
      FreeMem(mData);
      Tv_TblLst.Items[I].Delete;
    end;
  end;
end;

procedure TTblRefF.TimerTimer(Sender:TObject);
var mData:PData;  I:word;
begin
  Timer.Enabled:=FALSE;
  If Tv_TblLst.Items.Count>0 then begin
    For I:=0 to Tv_TblLst.Items.Count-1 do begin
      mData:=Tv_TblLst.Items[I].Data;
      If mData.Table.State=dsBrowse then mData.Table.Refresh;
    end;
  end;
  Timer.Enabled:=TRUE;
end;

procedure TTblRefF.FormDestroy(Sender:TObject);
var mData:PData;  I:word;
begin
  Timer.Enabled:=FALSE;
  If Tv_TblLst.Items.Count>0 then begin
    For I:=0 to Tv_TblLst.Items.Count-1 do begin
      mData:=Tv_TblLst.Items[I].Data;
      FreeMem(mData);
      Tv_TblLst.Items[I].Delete;
    end;
  end;
end;

end.
