unit QRep2_;

interface

uses
  IcConv,
  NexBtrTable, NexPxTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, QuickRpt, Qrctrls, StdCtrls, QuickRep, Grids, ImgList, Db,
  DBTables, TeeProcs, TeEngine, Chart, DBChart, QrTee, Series, OleCtnrs,
  QRPrntr;

type
  TF_QR = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitTables (pItem,pNoti,pSpec:TNexPxTable;pMain:TNexBtrTable;pSysBtr, pHedBtr, pItmBtr, pSpcBtr:TNexBtrTable; pSysTmp, pHedTmp, pItmTmp, pSpcTmp:TNexPxTable);
    procedure FreeTables;
  end;

var
  F_QR: TF_QR;

implementation

uses BtrTable;

{$R *.DFM}

procedure TF_QR.InitTables (pItem,pNoti,pSpec:TNexPxTable;pMain:TNexBtrTable;pSysBtr, pHedBtr, pItmBtr, pSpcBtr:TNexBtrTable; pSysTmp, pHedTmp, pItmTmp, pSpcTmp:TNexPxTable);
var mHeadTbl,mItemTbl,mNotiTbl,mSpecTbl:TNexPxTable; mMainTbl:TNexBtrTable;
    mSysBtr, mHedBtr, mItmBtr, mSpcBtr:TNexBtrTable; mSysTmp, mHedTmp, mItmTmp, mSpcTmp:TNexPxTable;
begin
  If (FindComponent('T_MainTable') as TNexBtrTable)=nil then begin
    mMainTbl := TNexBtrTable.Create(Self);
    mMainTbl.Name := 'T_MainTable';
  end;
  If (pMain<>nil) and pMain.Active then begin
    (FindComponent('T_MainTable') as TNexBtrTable).DataBaseName := pMain.DataBaseName;
    (FindComponent('T_MainTable') as TNexBtrTable).TableName := pMain.TableName;
    (FindComponent('T_MainTable') as TNexBtrTable).DefPath := pMain.DefPath;
    (FindComponent('T_MainTable') as TNexBtrTable).DefName := pMain.DefName;
    (FindComponent('T_MainTable') as TNexBtrTable).IndexName := pMain.IndexName;
    (FindComponent('T_MainTable') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_MainTable') as TNexBtrTable).IndexName := pMain.IndexName;
    (FindComponent('T_MainTable') as TNexBtrTable).GotoPos(pMain.ActPos);
  end;

  If (FindComponent('T_ItemTable') as TNexPxTable)=nil then begin
    mItemTbl := TNexPxTable.Create(Self);
    mItemTbl.Name := 'T_ItemTable';
  end;
  If (pItem<>nil) and pItem.Active then begin
    (FindComponent('T_ItemTable') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_ItemTable') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_ItemTable') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_ItemTable') as TNexPxTable).DataBaseName := pItem.DataBaseName;
    (FindComponent('T_ItemTable') as TNexPxTable).TableName := pItem.TableName;
    (FindComponent('T_ItemTable') as TNexPxTable).DefPath := pItem.DefPath;
    (FindComponent('T_ItemTable') as TNexPxTable).DefName := pItem.DefName;
    (FindComponent('T_ItemTable') as TNexPxTable).IndexName := pItem.IndexName;
    (FindComponent('T_ItemTable') as TNexPxTable).Active := TRUE;
    (FindComponent('T_ItemTable') as TNexPxTable).IndexName := pItem.IndexName;
    (FindComponent('T_ItemTable') as TNexPxTable).GotoBookmark(pItem.GetBookmark);
  end;

  If (FindComponent('T_NotiTable') as TNexPxTable)=nil then begin
    mNotiTbl := TNexPxTable.Create(Self);
    mNotiTbl.Name := 'T_NotiTable';
  end;
  If (pNoti<>nil) and pNoti.Active then begin
    (FindComponent('T_NotiTable') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_NotiTable') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_NotiTable') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_NotiTable') as TNexPxTable).DataBaseName := pNoti.DataBaseName;
    (FindComponent('T_NotiTable') as TNexPxTable).TableName := pNoti.TableName;
    (FindComponent('T_NotiTable') as TNexPxTable).DefPath := pNoti.DefPath;
    (FindComponent('T_NotiTable') as TNexPxTable).DefName := pNoti.DefName;
    (FindComponent('T_NotiTable') as TNexPxTable).IndexName := pNoti.IndexName;
    (FindComponent('T_NotiTable') as TNexPxTable).Active := TRUE;
    (FindComponent('T_NotiTable') as TNexPxTable).IndexName := pNoti.IndexName;
    (FindComponent('T_NotiTable') as TNexPxTable).GotoBookmark(pNoti.GetBookmark);
  end;

  If (FindComponent('T_SpecTable') as TNexPxTable)=nil then begin
    mSpecTbl := TNexPxTable.Create(Self);
    mSpecTbl.Name := 'T_SpecTable';
  end;
  If (pSpec<>nil) and pSpec.Active then begin
    (FindComponent('T_SpecTable') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_SpecTable') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_SpecTable') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_SpecTable') as TNexPxTable).DataBaseName := pSpec.DataBaseName;
    (FindComponent('T_SpecTable') as TNexPxTable).TableName := pSpec.TableName;
    (FindComponent('T_SpecTable') as TNexPxTable).DefPath := pSpec.DefPath;
    (FindComponent('T_SpecTable') as TNexPxTable).DefName := pSpec.DefName;
    (FindComponent('T_SpecTable') as TNexPxTable).IndexName := pSpec.IndexName;
    (FindComponent('T_SpecTable') as TNexPxTable).Active := TRUE;
    (FindComponent('T_SpecTable') as TNexPxTable).IndexName := pSpec.IndexName;
    (FindComponent('T_SpecTable') as TNexPxTable).GotoBookmark(pSpec.GetBookmark);
  end;

  If (FindComponent('T_SysTmp') as TNexPxTable)=nil then begin
    mSysTmp := TNexPxTable.Create(Self);
    mSysTmp.Name := 'T_SysTmp';
  end;
  If (pSysTmp<>nil) and pSysTmp.Active then begin
    (FindComponent('T_SysTmp') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).DataBaseName := pSysTmp.DataBaseName;
    (FindComponent('T_SysTmp') as TNexPxTable).TableName := pSysTmp.TableName;
    (FindComponent('T_SysTmp') as TNexPxTable).DefPath := pSysTmp.DefPath;
    (FindComponent('T_SysTmp') as TNexPxTable).DefName := pSysTmp.DefName;
    (FindComponent('T_SysTmp') as TNexPxTable).IndexName := pSysTmp.IndexName;
    (FindComponent('T_SysTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_SysTmp') as TNexPxTable).IndexName := pSysTmp.IndexName;
    (FindComponent('T_SysTmp') as TNexPxTable).GotoBookmark(pSysTmp.GetBookmark);
  end;

  If (FindComponent('T_ItmTmp') as TNexPxTable)=nil then begin
    mItmTmp := TNexPxTable.Create(Self);
    mItmTmp.Name := 'T_ItmTmp';
  end;
  If (pItmTmp<>nil) and pItmTmp.Active then begin
    (FindComponent('T_ItmTmp') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).DataBaseName := pItmTmp.DataBaseName;
    (FindComponent('T_ItmTmp') as TNexPxTable).TableName := pItmTmp.TableName;
    (FindComponent('T_ItmTmp') as TNexPxTable).DefPath := pItmTmp.DefPath;
    (FindComponent('T_ItmTmp') as TNexPxTable).DefName := pItmTmp.DefName;
    (FindComponent('T_ItmTmp') as TNexPxTable).IndexName := pItmTmp.IndexName;
    (FindComponent('T_ItmTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_ItmTmp') as TNexPxTable).IndexName := pItmTmp.IndexName;
    (FindComponent('T_ItmTmp') as TNexPxTable).GotoBookmark(pItmTmp.GetBookmark);
  end;

  If (FindComponent('T_HedTmp') as TNexPxTable)=nil then begin
    mHedTmp := TNexPxTable.Create(Self);
    mHedTmp.Name := 'T_HedTmp';
  end;
  If (pHedTmp<>nil) and pHedTmp.Active then begin
    (FindComponent('T_HedTmp') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).DataBaseName := pHedTmp.DataBaseName;
    (FindComponent('T_HedTmp') as TNexPxTable).TableName := pHedTmp.TableName;
    (FindComponent('T_HedTmp') as TNexPxTable).DefPath := pHedTmp.DefPath;
    (FindComponent('T_HedTmp') as TNexPxTable).DefName := pHedTmp.DefName;
    (FindComponent('T_HedTmp') as TNexPxTable).IndexName := pHedTmp.IndexName;
    (FindComponent('T_HedTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_HedTmp') as TNexPxTable).IndexName := pHedTmp.IndexName;
    (FindComponent('T_HedTmp') as TNexPxTable).GotoBookmark(pHedTmp.GetBookmark);
  end;

  If (FindComponent('T_SpcTmp') as TNexPxTable)=nil then begin
    mSpcTmp := TNexPxTable.Create(Self);
    mSpcTmp.Name := 'T_SpcTmp';
  end;
  If (pSpcTmp<>nil) and pSpcTmp.Active then begin
    (FindComponent('T_SpcTmp') as TNexPxTable).AutoDelete := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).AutoCreate := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).DataBaseName := pSpcTmp.DataBaseName;
    (FindComponent('T_SpcTmp') as TNexPxTable).TableName := pSpcTmp.TableName;
    (FindComponent('T_SpcTmp') as TNexPxTable).DefPath := pSpcTmp.DefPath;
    (FindComponent('T_SpcTmp') as TNexPxTable).DefName := pSpcTmp.DefName;
    (FindComponent('T_SpcTmp') as TNexPxTable).IndexName := pSpcTmp.IndexName;
    (FindComponent('T_SpcTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_SpcTmp') as TNexPxTable).IndexName := pSpcTmp.IndexName;
    (FindComponent('T_SpcTmp') as TNexPxTable).GotoBookmark(pSpcTmp.GetBookmark);
  end;

  If (FindComponent('T_SysBtr') as TNexBtrTable)=nil then begin
    mSysBtr := TNexBtrTable.Create(Self);
    mSysBtr.Name := 'T_SysBtr';
  end;
  If (pSysBtr<>nil) and pSysBtr.Active then begin
    (FindComponent('T_SysBtr') as TNexBtrTable).DataBaseName := pSysBtr.DataBaseName;
    (FindComponent('T_SysBtr') as TNexBtrTable).TableName := pSysBtr.TableName;
    (FindComponent('T_SysBtr') as TNexBtrTable).DefPath := pSysBtr.DefPath;
    (FindComponent('T_SysBtr') as TNexBtrTable).DefName := pSysBtr.DefName;
    (FindComponent('T_SysBtr') as TNexBtrTable).IndexName := pSysBtr.IndexName;
    (FindComponent('T_SysBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_SysBtr') as TNexBtrTable).IndexName := pSysBtr.IndexName;
    (FindComponent('T_SysBtr') as TNexBtrTable).GotoPos(pSysBtr.ActPos);
  end;

  If (FindComponent('T_ItmBtr') as TNexBtrTable)=nil then begin
    mItmBtr := TNexBtrTable.Create(Self);
    mItmBtr.Name := 'T_ItmBtr';
  end;
  If (pItmBtr<>nil) and pItmBtr.Active then begin
    (FindComponent('T_ItmBtr') as TNexBtrTable).DataBaseName := pItmBtr.DataBaseName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).TableName := pItmBtr.TableName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).DefPath := pItmBtr.DefPath;
    (FindComponent('T_ItmBtr') as TNexBtrTable).DefName := pItmBtr.DefName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).IndexName := pItmBtr.IndexName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_ItmBtr') as TNexBtrTable).IndexName := pItmBtr.IndexName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).GotoPos(pItmBtr.ActPos);
  end;

  If (FindComponent('T_HedBtr') as TNexBtrTable)=nil then begin
    mHedBtr := TNexBtrTable.Create(Self);
    mHedBtr.Name := 'T_HedBtr';
  end;
  If (pHedBtr<>nil) and pHedBtr.Active then begin
    (FindComponent('T_HedBtr') as TNexBtrTable).DataBaseName := pHedBtr.DataBaseName;
    (FindComponent('T_HedBtr') as TNexBtrTable).TableName := pHedBtr.TableName;
    (FindComponent('T_HedBtr') as TNexBtrTable).DefPath := pHedBtr.DefPath;
    (FindComponent('T_HedBtr') as TNexBtrTable).DefName := pHedBtr.DefName;
    (FindComponent('T_HedBtr') as TNexBtrTable).IndexName := pHedBtr.IndexName;
    (FindComponent('T_HedBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_HedBtr') as TNexBtrTable).IndexName := pHedBtr.IndexName;
    (FindComponent('T_HedBtr') as TNexBtrTable).GotoPos(pHedBtr.ActPos);
  end;

  If (FindComponent('T_SpcBtr') as TNexBtrTable)=nil then begin
    mSpcBtr := TNexBtrTable.Create(Self);
    mSpcBtr.Name := 'T_SpcBtr';
  end;
  If (pSpcBtr<>nil) and pSpcBtr.Active then begin
    (FindComponent('T_SpcBtr') as TNexBtrTable).DataBaseName := pSpcBtr.DataBaseName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).TableName := pSpcBtr.TableName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).DefPath := pSpcBtr.DefPath;
    (FindComponent('T_SpcBtr') as TNexBtrTable).DefName := pSpcBtr.DefName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).IndexName := pSpcBtr.IndexName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_SpcBtr') as TNexBtrTable).IndexName := pSpcBtr.IndexName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).GotoPos(pSpcBtr.ActPos);
  end;

end;

procedure TF_QR.FreeTables;
begin
  If (FindComponent('T_MainTable') as TNexBtrTable)<>nil then begin
    (FindComponent('T_MainTable') as TNexBtrTable).Active := FALSE;
    (FindComponent('T_MainTable') as TNexBtrTable).DataBaseName := '';
    (FindComponent('T_MainTable') as TNexBtrTable).TableName := '';
    (FindComponent('T_MainTable') as TNexBtrTable).DefPath := '';
    (FindComponent('T_MainTable') as TNexBtrTable).DefName := '';
    (FindComponent('T_MainTable') as TNexBtrTable).FieldDefs.Clear;
    (FindComponent('T_MainTable') as TNexBtrTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_HeadTable') as TNexPxTable)<>nil then begin
    (FindComponent('T_HeadTable') as TNexPxTable).Active := FALSE;
    (FindComponent('T_HeadTable') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_HeadTable') as TNexPxTable).TableName := '';
    (FindComponent('T_HeadTable') as TNexPxTable).DefPath := '';
    (FindComponent('T_HeadTable') as TNexPxTable).DefName := '';
    (FindComponent('T_HeadTable') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_HeadTable') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_ItemTable') as TNexPxTable)<>nil then begin
    (FindComponent('T_ItemTable') as TNexPxTable).Active := FALSE;
    (FindComponent('T_ItemTable') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_ItemTable') as TNexPxTable).TableName := '';
    (FindComponent('T_ItemTable') as TNexPxTable).DefPath := '';
    (FindComponent('T_ItemTable') as TNexPxTable).DefName := '';
    (FindComponent('T_ItemTable') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_ItemTable') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_NotiTable') as TNexPxTable)<>nil then begin
    (FindComponent('T_NotiTable') as TNexPxTable).Active := FALSE;
    (FindComponent('T_NotiTable') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_NotiTable') as TNexPxTable).TableName := '';
    (FindComponent('T_NotiTable') as TNexPxTable).DefPath := '';
    (FindComponent('T_NotiTable') as TNexPxTable).DefName := '';
    (FindComponent('T_NotiTable') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_NotiTable') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_SpecTable') as TNexPxTable)<>nil then begin
    (FindComponent('T_SpecTable') as TNexPxTable).Active := FALSE;
    (FindComponent('T_SpecTable') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_SpecTable') as TNexPxTable).TableName := '';
    (FindComponent('T_SpecTable') as TNexPxTable).DefPath := '';
    (FindComponent('T_SpecTable') as TNexPxTable).DefName := '';
    (FindComponent('T_SpecTable') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_SpecTable') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_SysTmp') as TNexPxTable)<>nil then begin
    (FindComponent('T_SysTmp') as TNexPxTable).Active := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_SysTmp') as TNexPxTable).TableName := '';
    (FindComponent('T_SysTmp') as TNexPxTable).DefPath := '';
    (FindComponent('T_SysTmp') as TNexPxTable).DefName := '';
    (FindComponent('T_SysTmp') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_SysTmp') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_ItmTmp') as TNexPxTable)<>nil then begin
    (FindComponent('T_ItmTmp') as TNexPxTable).Active := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_ItmTmp') as TNexPxTable).TableName := '';
    (FindComponent('T_ItmTmp') as TNexPxTable).DefPath := '';
    (FindComponent('T_ItmTmp') as TNexPxTable).DefName := '';
    (FindComponent('T_ItmTmp') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_ItmTmp') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_HedTmp') as TNexPxTable)<>nil then begin
    (FindComponent('T_HedTmp') as TNexPxTable).Active := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_HedTmp') as TNexPxTable).TableName := '';
    (FindComponent('T_HedTmp') as TNexPxTable).DefPath := '';
    (FindComponent('T_HedTmp') as TNexPxTable).DefName := '';
    (FindComponent('T_HedTmp') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_HedTmp') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_SpcTmp') as TNexPxTable)<>nil then begin
    (FindComponent('T_SpcTmp') as TNexPxTable).Active := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).DataBaseName := '';
    (FindComponent('T_SpcTmp') as TNexPxTable).TableName := '';
    (FindComponent('T_SpcTmp') as TNexPxTable).DefPath := '';
    (FindComponent('T_SpcTmp') as TNexPxTable).DefName := '';
    (FindComponent('T_SpcTmp') as TNexPxTable).FieldDefs.Clear;
    (FindComponent('T_SpcTmp') as TNexPxTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_SysBtr') as TNexBtrTable)<>nil then begin
    (FindComponent('T_SysBtr') as TNexBtrTable).Active := FALSE;
    (FindComponent('T_SysBtr') as TNexBtrTable).DataBaseName := '';
    (FindComponent('T_SysBtr') as TNexBtrTable).TableName := '';
    (FindComponent('T_SysBtr') as TNexBtrTable).DefPath := '';
    (FindComponent('T_SysBtr') as TNexBtrTable).DefName := '';
    (FindComponent('T_SysBtr') as TNexBtrTable).FieldDefs.Clear;
    (FindComponent('T_SysBtr') as TNexBtrTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_ItmBtr') as TNexBtrTable)<>nil then begin
    (FindComponent('T_ItmBtr') as TNexBtrTable).Active := FALSE;
    (FindComponent('T_ItmBtr') as TNexBtrTable).DataBaseName := '';
    (FindComponent('T_ItmBtr') as TNexBtrTable).TableName := '';
    (FindComponent('T_ItmBtr') as TNexBtrTable).DefPath := '';
    (FindComponent('T_ItmBtr') as TNexBtrTable).DefName := '';
    (FindComponent('T_ItmBtr') as TNexBtrTable).FieldDefs.Clear;
    (FindComponent('T_ItmBtr') as TNexBtrTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_HedBtr') as TNexBtrTable)<>nil then begin
    (FindComponent('T_HedBtr') as TNexBtrTable).Active := FALSE;
    (FindComponent('T_HedBtr') as TNexBtrTable).DataBaseName := '';
    (FindComponent('T_HedBtr') as TNexBtrTable).TableName := '';
    (FindComponent('T_HedBtr') as TNexBtrTable).DefPath := '';
    (FindComponent('T_HedBtr') as TNexBtrTable).DefName := '';
    (FindComponent('T_HedBtr') as TNexBtrTable).FieldDefs.Clear;
    (FindComponent('T_HedBtr') as TNexBtrTable).IndexDefs.Clear;
  end;

  If (FindComponent('T_SpcBtr') as TNexBtrTable)<>nil then begin
    (FindComponent('T_SpcBtr') as TNexBtrTable).Active := FALSE;
    (FindComponent('T_SpcBtr') as TNexBtrTable).DataBaseName := '';
    (FindComponent('T_SpcBtr') as TNexBtrTable).TableName := '';
    (FindComponent('T_SpcBtr') as TNexBtrTable).DefPath := '';
    (FindComponent('T_SpcBtr') as TNexBtrTable).DefName := '';
    (FindComponent('T_SpcBtr') as TNexBtrTable).FieldDefs.Clear;
    (FindComponent('T_SpcBtr') as TNexBtrTable).IndexDefs.Clear;
  end;

end;

end.
