unit GscSrch;
// *****************************************************************************
//                        VYHLADAVAC TOVOAROVYC KARIET
// *****************************************************************************

interface

uses
  LangForm, IcTypes, IcTools, IcConv, NexMsg, NexError, NexIni, NexGlob, 
  hGSCKEY, hGSCAT, tGSCKEY,
  StkGlob, CasIni, IcStand, IcButtons, IcEditors, CmpTools, DbSrGrid,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  AdvGrid, SrchGrid, TableView, ActnList, DB, xpComp, ToolWin;

type
  TGscSrchV = class(TLangForm)
    ActionList: TActionList;
    A_Exi: TAction;
    ToolBar1: TToolBar;
    B_Exi: TToolButton;
    ToolButton3: TToolButton;
    Tv_GscSrch: TTableView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Tv_GscSrchSelected(Sender: TObject);
    procedure A_ExiExecute(Sender: TObject);
  private
    ohGSCAT:TGscatHnd;
    ohGSCKEY:TGsckeyHnd;
    otGSCKEY:TGsckeyTmp;
    procedure TmpClear;
  public
    function Srch(pSrchKey:Str30):Str30;
  end;

implementation

{$R *.DFM}

procedure TGscSrchV.FormCreate(Sender: TObject);
begin
  ohGSCAT := TGscatHnd.Create;ohGSCAT.Open;
  ohGSCKEY := TGsckeyHnd.Create;  ohGSCKEY.Open;
  otGSCKEY := nil;
end;

procedure TGscSrchV.FormDestroy(Sender: TObject);
begin
  If otGSCKEY<>nil then FreeAndNil (otGSCKEY);
  FreeAndNil (ohGSCKEY);
  FreeAndNil (ohGSCAT);
end;

function TGscSrchV.Srch(pSrchKey:Str30):Str30;
begin
  Result := pSrchKey;
  TmpClear;
  If pSrchKey<>'' then begin
    If ohGSCKEY.LocateSrchKey(pSrchKey) then begin
      Repeat
        If ohGSCAT.LocateGsCode(ohGSCKEY.GsCode) then begin
          If otGSCKEY=nil then begin
            otGSCKEY := TGsckeyTmp.Create;
            otGSCKEY.Open;
          end;
          If not otGSCKEY.LocateGsCode(ohGSCAT.GsCode) then begin
            otGSCKEY.Insert;
            BTR_To_PX(ohGSCAT.BtrTable,otGSCKEY.TmpTable);
            otGSCKEY.Post;
          end;
        end;
        Application.ProcessMessages;
        ohGSCKEY.Next;
      until ohGSCKEY.Eof or (ohGSCKEY.SrchKey<>pSrchKey);
    end;
    If otGSCKEY<>nil then begin
      If otGSCKEY.Count>1 then begin
        Tv_GscSrch.DataSet := otGSCKEY.TmpTable;
        ShowModal;
        If Accept then Result := '.'+StrInt(otGSCKEY.GsCode,0);
      end
      else Result := '.'+StrInt(ohGSCAT.GsCode,0);
    end;
  end;
end;

// ******************************** PRIVATE ************************************

procedure TGscSrchV.TmpClear;
begin
  If otGSCKEY<>nil then begin
    If otGSCKEY.Count>0 then begin
      Repeat
        otGSCKEY.Delete;
      until otGSCKEY.Count=0;
    end;
  end;
end;

procedure TGscSrchV.Tv_GscSrchSelected(Sender: TObject);
begin
  Accept := TRUE;
  Close;
end;

procedure TGscSrchV.A_ExiExecute(Sender: TObject);
begin
  Close;
end;

end.
{MOD 1804003}
{MOD 1805020}
