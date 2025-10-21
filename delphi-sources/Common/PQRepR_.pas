unit PQRepR_;

interface

uses
  NexBtrTable, NexPxTable,
  QuickRpt, Qrctrls, QuickRep,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TF_Rep = class(TForm)
    QRImage1: TQRImage;
  private
    { Private declarations }
  public
    procedure InitTables (pItem,pNoti,pSpec:TNexPxTable;pMain:TNexBtrTable;pSysBtr, pHedBtr, pItmBtr, pSpcBtr:TNexBtrTable; pSysTmp, pHedTmp, pItmTmp, pSpcTmp:TNexPxTable);
    { Public declarations }
  end;

var
  F_Rep: TF_Rep;

implementation

uses BtrTable;

{$R *.DFM}

procedure TF_Rep.InitTables (pItem,pNoti,pSpec:TNexPxTable;pMain:TNexBtrTable;pSysBtr, pHedBtr, pItmBtr, pSpcBtr:TNexBtrTable; pSysTmp, pHedTmp, pItmTmp, pSpcTmp:TNexPxTable);
begin
  If (FindComponent('T_MainTable') as TNexBtrTable)<>nil then begin
    If pMain<>nil then begin
      If pMain.Active then begin
        (FindComponent('T_MainTable') as TNexBtrTable).DataBaseName := pMain.DataBaseName;
        (FindComponent('T_MainTable') as TNexBtrTable).TableName := pMain.TableName;
        (FindComponent('T_MainTable') as TNexBtrTable).DefPath := pMain.DefPath;
        (FindComponent('T_MainTable') as TNexBtrTable).DefName := pMain.DefName;
        (FindComponent('T_MainTable') as TNexBtrTable).Active := TRUE;
        (FindComponent('T_MainTable') as TNexBtrTable).IndexName := pMain.IndexName;
        (FindComponent('T_MainTable') as TNexBtrTable).GotoPos(pMain.ActPos);
      end;
    end;
  end;
  If (FindComponent('T_ItemTable') as TNexPxTable)<>nil then begin
    If pItem<>nil then begin
      If pItem.Active then begin
        (FindComponent('T_ItemTable') as TNexPxTable).AutoDelete    := FALSE;
        (FindComponent('T_ItemTable') as TNexPxTable).AutoTableName := FALSE;
        (FindComponent('T_ItemTable') as TNexPxTable).AutoCreate    := FALSE;
        (FindComponent('T_ItemTable') as TNexPxTable).DataBaseName  := pItem.DataBaseName;
        (FindComponent('T_ItemTable') as TNexPxTable).TableName     := pItem.TableName;
        (FindComponent('T_ItemTable') as TNexPxTable).DefPath       := pItem.DefPath;
        (FindComponent('T_ItemTable') as TNexPxTable).DefName       := pItem.DefName;
        (FindComponent('T_ItemTable') as TNexPxTable).Active        := TRUE;
        (FindComponent('T_ItemTable') as TNexPxTable).IndexName := pItem.IndexName;
        (FindComponent('T_ItemTable') as TNexPxTable).GotoBookmark(pItem.GetBookmark);
      end;
    end;
  end;
  If (FindComponent('T_NotiTable') as TNexPxTable)<>nil then begin
    If pNoti<>nil then begin
      If pNoti.Active then begin
        (FindComponent('T_NotiTable') as TNexPxTable).AutoDelete    := FALSE;
        (FindComponent('T_NotiTable') as TNexPxTable).AutoTableName := FALSE;
        (FindComponent('T_NotiTable') as TNexPxTable).AutoCreate    := FALSE;
        (FindComponent('T_NotiTable') as TNexPxTable).DataBaseName := pNoti.DataBaseName;
        (FindComponent('T_NotiTable') as TNexPxTable).TableName := pNoti.TableName;
        (FindComponent('T_NotiTable') as TNexPxTable).DefPath := pNoti.DefPath;
        (FindComponent('T_NotiTable') as TNexPxTable).DefName := pNoti.DefName;
        (FindComponent('T_NotiTable') as TNexPxTable).Active := TRUE;
        (FindComponent('T_NotiTable') as TNexPxTable).IndexName := pNoti.IndexName;
        (FindComponent('T_NotiTable') as TNexPxTable).GotoBookmark(pNoti.GetBookmark);
      end;
    end;
  end;
  If (FindComponent('T_SpecTable') as TNexPxTable)<>nil then begin
    If pSpec<>nil then begin
      If pSpec.Active then begin
        (FindComponent('T_SpecTable') as TNexPxTable).AutoDelete    := FALSE;
        (FindComponent('T_SpecTable') as TNexPxTable).AutoTableName := FALSE;
        (FindComponent('T_SpecTable') as TNexPxTable).AutoCreate    := FALSE;
        (FindComponent('T_SpecTable') as TNexPxTable).DataBaseName := pSpec.DataBaseName;
        (FindComponent('T_SpecTable') as TNexPxTable).TableName := pSpec.TableName;
        (FindComponent('T_SpecTable') as TNexPxTable).DefPath := pSpec.DefPath;
        (FindComponent('T_SpecTable') as TNexPxTable).DefName := pSpec.DefName;
        (FindComponent('T_SpecTable') as TNexPxTable).Active := TRUE;
        (FindComponent('T_SpecTable') as TNexPxTable).IndexName := pSpec.IndexName;
        (FindComponent('T_SpecTable') as TNexPxTable).GotoBookmark(pSpec.GetBookmark);
      end;
    end;
  end;
  If (FindComponent('T_SysTmp')<>nil) and (pSysTmp<>nil) and pSysTmp.Active then begin
    (FindComponent('T_SysTmp') as TNexPxTable).AutoDelete    := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).AutoCreate    := FALSE;
    (FindComponent('T_SysTmp') as TNexPxTable).DataBaseName := pSysTmp.DataBaseName;
    (FindComponent('T_SysTmp') as TNexPxTable).TableName := pSysTmp.TableName;
    (FindComponent('T_SysTmp') as TNexPxTable).DefPath := pSysTmp.DefPath;
    (FindComponent('T_SysTmp') as TNexPxTable).DefName := pSysTmp.DefName;
    (FindComponent('T_SysTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_SysTmp') as TNexPxTable).IndexName := pSysTmp.IndexName;
    (FindComponent('T_SysTmp') as TNexPxTable).GotoBookmark(pSysTmp.GetBookmark);
  end;
  If (FindComponent('T_ItmTmp')<>nil) and (pItmTmp<>nil) and pItmTmp.Active then begin
    (FindComponent('T_ItmTmp') as TNexPxTable).AutoDelete    := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).AutoCreate    := FALSE;
    (FindComponent('T_ItmTmp') as TNexPxTable).DataBaseName := pItmTmp.DataBaseName;
    (FindComponent('T_ItmTmp') as TNexPxTable).TableName := pItmTmp.TableName;
    (FindComponent('T_ItmTmp') as TNexPxTable).DefPath := pItmTmp.DefPath;
    (FindComponent('T_ItmTmp') as TNexPxTable).DefName := pItmTmp.DefName;
    (FindComponent('T_ItmTmp') as TNexPxTable).IndexName := pItmTmp.IndexName;
    (FindComponent('T_ItmTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_ItmTmp') as TNexPxTable).IndexName := pItmTmp.IndexName;
    (FindComponent('T_ItmTmp') as TNexPxTable).GotoBookmark(pItmTmp.GetBookmark);
  end;
  If (FindComponent('T_HedTmp')<>nil) and (pHedTmp<>nil) and pHedTmp.Active then begin
    (FindComponent('T_HedTmp') as TNexPxTable).AutoDelete    := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).AutoCreate    := FALSE;
    (FindComponent('T_HedTmp') as TNexPxTable).DataBaseName := pHedTmp.DataBaseName;
    (FindComponent('T_HedTmp') as TNexPxTable).TableName := pHedTmp.TableName;
    (FindComponent('T_HedTmp') as TNexPxTable).DefPath := pHedTmp.DefPath;
    (FindComponent('T_HedTmp') as TNexPxTable).DefName := pHedTmp.DefName;
    (FindComponent('T_HedTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_HedTmp') as TNexPxTable).IndexName := pHedTmp.IndexName;
    (FindComponent('T_HedTmp') as TNexPxTable).GotoBookmark(pHedTmp.GetBookmark);
  end;
  If (FindComponent('T_SpcTmp')<>nil) and (pSpcTmp<>nil) and pSpcTmp.Active then begin
    (FindComponent('T_SpcTmp') as TNexPxTable).AutoDelete    := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).AutoTableName := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).AutoCreate    := FALSE;
    (FindComponent('T_SpcTmp') as TNexPxTable).DataBaseName := pSpcTmp.DataBaseName;
    (FindComponent('T_SpcTmp') as TNexPxTable).TableName := pSpcTmp.TableName;
    (FindComponent('T_SpcTmp') as TNexPxTable).DefPath := pSpcTmp.DefPath;
    (FindComponent('T_SpcTmp') as TNexPxTable).DefName := pSpcTmp.DefName;
    (FindComponent('T_SpcTmp') as TNexPxTable).Active := TRUE;
    (FindComponent('T_SpcTmp') as TNexPxTable).IndexName := pSpcTmp.IndexName;
    (FindComponent('T_SpcTmp') as TNexPxTable).GotoBookmark(pSpcTmp.GetBookmark);
  end;
  If (FindComponent('T_SysBtr')<>nil) and (pSysBtr<>nil) and pSysBtr.Active then begin
    (FindComponent('T_SysBtr') as TNexBtrTable).DataBaseName := pSysBtr.DataBaseName;
    (FindComponent('T_SysBtr') as TNexBtrTable).TableName := pSysBtr.TableName;
    (FindComponent('T_SysBtr') as TNexBtrTable).DefPath := pSysBtr.DefPath;
    (FindComponent('T_SysBtr') as TNexBtrTable).DefName := pSysBtr.DefName;
    (FindComponent('T_SysBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_SysBtr') as TNexBtrTable).IndexName := pSysBtr.IndexName;
    (FindComponent('T_SysBtr') as TNexBtrTable).GotoPos(pSysBtr.ActPos);
  end;
  If (FindComponent('T_ItmBtr')<>nil) and (pItmBtr<>nil) and pItmBtr.Active then begin
    (FindComponent('T_ItmBtr') as TNexBtrTable).DataBaseName := pItmBtr.DataBaseName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).TableName := pItmBtr.TableName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).TableNameExt := pItmBtr.TableNameExt;
    (FindComponent('T_ItmBtr') as TNexBtrTable).DefPath := pItmBtr.DefPath;
    (FindComponent('T_ItmBtr') as TNexBtrTable).DefName := pItmBtr.DefName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_ItmBtr') as TNexBtrTable).IndexName := pItmBtr.IndexName;
    (FindComponent('T_ItmBtr') as TNexBtrTable).Filter := pItmBtr.Filter;
    (FindComponent('T_ItmBtr') as TNexBtrTable).Filtered := pItmBtr.Filtered;
    (FindComponent('T_ItmBtr') as TNexBtrTable).GotoPos(pItmBtr.ActPos);
    If pItmBtr.Filtered then begin
      (FindComponent('T_ItmBtr') as TNexBtrTable).Filter:=pItmBtr.Filter;
      (FindComponent('T_ItmBtr') as TNexBtrTable).Filtered:=pItmBtr.Filtered;
    end;
  end;
  If (FindComponent('T_HedBtr')<>nil) and (pHedBtr<>nil) and pHedBtr.Active then begin
    (FindComponent('T_HedBtr') as TNexBtrTable).DataBaseName := pHedBtr.DataBaseName;
    (FindComponent('T_HedBtr') as TNexBtrTable).TableName := pHedBtr.TableName;
    (FindComponent('T_HedBtr') as TNexBtrTable).DefPath := pHedBtr.DefPath;
    (FindComponent('T_HedBtr') as TNexBtrTable).DefName := pHedBtr.DefName;
    (FindComponent('T_HedBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_HedBtr') as TNexBtrTable).IndexName := pHedBtr.IndexName;
    (FindComponent('T_HedBtr') as TNexBtrTable).Filter := pHedBtr.Filter;
    (FindComponent('T_HedBtr') as TNexBtrTable).Filtered := pHedBtr.Filtered;
    (FindComponent('T_HedBtr') as TNexBtrTable).GotoPos(pHedBtr.ActPos);
  end;
  If (FindComponent('T_SpcBtr')<>nil) and (pSpcBtr<>nil) and pSpcBtr.Active then begin
    (FindComponent('T_SpcBtr') as TNexBtrTable).DataBaseName := pSpcBtr.DataBaseName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).TableName := pSpcBtr.TableName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).DefPath := pSpcBtr.DefPath;
    (FindComponent('T_SpcBtr') as TNexBtrTable).DefName := pSpcBtr.DefName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).Active := TRUE;
    (FindComponent('T_SpcBtr') as TNexBtrTable).IndexName := pSpcBtr.IndexName;
    (FindComponent('T_SpcBtr') as TNexBtrTable).Filter := pSpcBtr.Filter;
    (FindComponent('T_SpcBtr') as TNexBtrTable).Filtered := pSpcBtr.Filtered;
    (FindComponent('T_SpcBtr') as TNexBtrTable).GotoPos(pSpcBtr.ActPos);
  end;

end;

end.
