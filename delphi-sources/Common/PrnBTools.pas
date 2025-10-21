unit PrnBTools;

interface

uses
  {IdentCode} IcConv,IcTools,dm_PrnTmp,
              BtrTable, NexBtrTable,DBFTable, PxTable,  NexPxTable,
     {Delphi} Classes,  SysUtils,   Windows,
              Messages, Variants,   Graphics, Controls, Forms;

     procedure CopyBtrTablesToPrnTmp (pStr:string);
     // kopirovanie komponentov z datamodulov do datamudulu dmPRNTMP pre tlac
     // parameter pStr je v tvare "datamodul1=databaza1,databaza2,...|datamodul2=databaza1,...
     // napr 'dmSTK=btMGLST,btSTKLST,ptCUSGSL|dmCAB=btCassas|btTB'
     procedure DelBtrTablesInPrnTmp;
     // zrusenie komponentov z datamodulu dmPRNTMP pre tlac

implementation

procedure CopyBtrTablesToPrnTmp;
var
  mS,mDM,mTBL                   : string;
  mI,mJ,mL                      : byte;
  mNBT                          : TNexBtrTable;
  mDT                           : TDbfTable;
  mBT                           : TBtrieveTable;
  mPT                           : TPxTable;
  mNPT                          : TNexPxTable;
begin
  dmPRNTmp := TdmPRNTmp.Create (Application);
  for mI:=0 to LineElementNum(pStr,'|')-1 do begin
    mS:=LineElement(pStr,mI,'|');
    mL :=Pos('=',mS);
    mDM:=system.Copy(mS,1,mL-1);
    If  (Application.FindComponent(mDM)<>NIL)
    and (Application.FindComponent(mDM) is TDatamodule) then begin
      mS:=Copy(mS,mL+1,Length(mS)-mL);
      for mJ:=0 to LineElementNum(mS,',') do begin
        mTbl:=LineElement(mS,mJ,',');
        If ((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl)<>NIL) then begin
          if (Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl)is TNexBtrTable then begin
            mNBT:=TNexBtrTable.Create(dmPrnTmp);
//            mNBT.Owner:=         Application.FindComponent(mDM) as TDatamodule;
            mNBT.Name           :=mTbl;
            mNBT.Archive        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).Archive;
            mNBT.AutoCreate     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).AutoCreate;
            mNBT.DataBaseName   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).DataBaseName;
            mNBT.DefName        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).DefName;
            mNBT.DefPath        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).DefPath;
            mNBT.DosStrings     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).DosStrings;
            mNBT.FixedName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).FixedName;
            mNBT.TableName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).TableName;
            mNBT.TableNameExt   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).TableNameExt;
            mNBT.IndexFieldNames:=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).IndexFieldNames;
            mNBT.IndexName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).IndexName;
            mNBT.Modify         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).Modify;
            mNBT.StoreDefs      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).StoreDefs;
            mNBT.ShowErrMsg     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).ShowErrMsg;
            mNBT.Sended         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).Sended;
            mNBT.Filter         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).Filter;
            mNBT.Filtered       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexBtrTable).Filtered;
            mNBT.Active:=TRUE;
          end else if (Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl)is TNexPxTable then begin
            mNPT:=TNexPxTable.Create(dmPrnTmp);
//            mNPT.Owner:=         Application.FindComponent(mDM) as TDatamodule;
            mNPT.Name           :=mTbl;
            mNPT.AutoCalcFields :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).AutoCalcFields;
            mNPT.AutoCreate     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).AutoCreate;
            mNPT.AutoDelete     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).AutoDelete;
            mNPT.DefName        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).DefName;
            mNPT.DefPath        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).DefPath;
            mNPT.FixName        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).FixName;
            mNPT.AutoTableName  :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).AutoTableName;
            mNPT.AutoRefresh    :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).AutoRefresh;
            mNPT.CachedUpdates  :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).CachedUpdates;
            mNPT.DataBaseName   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).DataBaseName;
            mNPT.DefaultIndex   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).DefaultIndex;
            mNPT.Exclusive      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).Exclusive;
            mNPT.Filter         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).Filter;
            mNPT.Filtered       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).Filtered;
            mNPT.IndexFieldNames:=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).IndexFieldNames;
            mNPT.IndexName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).IndexName;
            mNPT.ObjectView     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).ObjectView;
            mNPT.ReadOnly       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).ReadOnly;
            mNPT.StoreDefs      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).StoreDefs;
            mNPT.TableName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).TableName;
            mNPT.TableType      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).TableType;
            mNPT.UpdateMode     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TNexPxTable).UpdateMode;
            mNPT.Active:=TRUE;
          end else if (Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl)is TPxTable then begin
            mPT:=TPxTable.Create(dmPrnTmp);
//            mPT.Owner:=         Application.FindComponent(mDM) as TDatamodule;
            mPT.Name           :=mTbl;
            mPT.AutoCalcFields :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).AutoCalcFields;
            mPT.AutoRefresh    :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).AutoRefresh;
            mPT.CachedUpdates  :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).CachedUpdates;
            mPT.DataBaseName   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).DataBaseName;
            mPT.DefaultIndex   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).DefaultIndex;
            mPT.Exclusive      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).Exclusive;
            mPT.Filter         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).Filter;
            mPT.Filtered       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).Filtered;
            mPT.IndexFieldNames:=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).IndexFieldNames;
            mPT.IndexName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).IndexName;
            mPT.ObjectView     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).ObjectView;
            mPT.ReadOnly       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).ReadOnly;
            mPT.StoreDefs      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).StoreDefs;
            mPT.TableName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).TableName;
            mPT.TableType      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).TableType;
            mPT.UpdateMode     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TPxTable).UpdateMode;
            mPT.Active:=TRUE;
          end else if (Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl)is TDbfTable then begin
            mDT:=TDbfTable.Create(dmPrnTmp);
//            mDT.Owner:=         Application.FindComponent(mDM) as TDatamodule;
            mDT.Name           :=mTbl;
            mDT.AutoCalcFields :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).AutoCalcFields;
            mDT.AutoRefresh    :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).AutoRefresh;
            mDT.CachedUpdates  :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).CachedUpdates;
            mDT.DataBaseName   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).DataBaseName;
            mDT.DefaultIndex   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).DefaultIndex;
            mDT.Exclusive      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).Exclusive;
            mDT.Filter         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).Filter;
            mDT.Filtered       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).Filtered;
            mDT.IndexFieldNames:=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).IndexFieldNames;
            mDT.IndexName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).IndexName;
            mDT.ObjectView     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).ObjectView;
            mDT.ReadOnly       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).ReadOnly;
            mDT.StoreDefs      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).StoreDefs;
            mDT.TableName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).TableName;
            mDT.TableType      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).TableType;
            mDT.UpdateMode     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TDbfTable).UpdateMode;
            mDT.Active:=TRUE;
          end else if (Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl)is TBtrieveTable then begin
            mBT:=TBtrieveTable.Create(dmPrnTmp);
//            mBT.Owner:=         Application.FindComponent(mDM) as TDatamodule;
            mBT.Name           :=mTbl;
            mBT.Archive        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).Archive;
            mBT.AutoCreate     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).AutoCreate;
            mBT.DataBaseName   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).DataBaseName;
            mBT.DefName        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).DefName;
            mBT.DefPath        :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).DefPath;
            mBT.DosStrings     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).DosStrings;
            mBT.FixedName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).FixedName;
            mBT.TableName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).TableName;
            mBT.TableNameExt   :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).TableNameExt;
            mBT.IndexFieldNames:=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).IndexFieldNames;
            mBT.IndexName      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).IndexName;
            mBT.Modify         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).Modify;
            mBT.StoreDefs      :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).StoreDefs;
            mBT.ShowErrMsg     :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).ShowErrMsg;
            mBT.Sended         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).Sended;
            mBT.Filter         :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).Filter;
            mBT.Filtered       :=((Application.FindComponent(mDM) as TDatamodule ).FindComponent(mTbl) as TBtrieveTable).Filtered;
            mBT.Active:=TRUE;
          end;
        end;
      end;
    end;
  end;
end;

procedure DelBtrTablesInPrnTmp;
var
  mTBL                   : string;
  mI,mJ                  : byte;
begin
  mJ:=dmPrnTmp.ComponentCount;
  for mI:=1 to mJ do begin
    mTbl:=dmPrnTmp.Components[mJ-mI].Name;
    If (dmPrnTmp.FindComponent(mTbl)<>NIL) then begin
      if dmPrnTmp.FindComponent(mTbl)is TNexBtrTable then begin
        (dmPrnTmp.FindComponent(mTbl) as TNexBtrTable).Active:=FALSE;
        (dmPrnTmp.FindComponent(mTbl) as TNexBtrTable).Free;
      end else if dmPrnTmp.FindComponent(mTbl)is TNexPxTable then begin
        (dmPrnTmp.FindComponent(mTbl) as TNexPxTable).Active:=FALSE;
        (dmPrnTmp.FindComponent(mTbl) as TNexPxTable).Free
      end else if dmPrnTmp.FindComponent(mTbl)is TPxTable then begin
        (dmPrnTmp.FindComponent(mTbl) as TPxTable).Active:=FALSE;
        (dmPrnTmp.FindComponent(mTbl) as TPxTable).Free;
      end else if dmPrnTmp.FindComponent(mTbl)is TDbfTable then begin
        (dmPrnTmp.FindComponent(mTbl) as TDbfTable).Active:=False;
        (dmPrnTmp.FindComponent(mTbl) as TDbfTable).Free
      end else if dmPrnTmp.FindComponent(mTbl)is TBtrieveTable then begin
        (dmPrnTmp.FindComponent(mTbl) as TBtrieveTable).Active:=False;
        (dmPrnTmp.FindComponent(mTbl) as TBtrieveTable).Free;
      end else (dmPrnTmp.FindComponent(mTbl) as TComponent).Free;
    end;
  end;
  FreeandNil(dmPRNTMP);
end;

end.
