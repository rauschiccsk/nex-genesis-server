unit AfcBas;

interface

uses
  IcTypes, IcVariab, IcTools, NexPath, NexGlob, hAFCDEF, hUsrLst,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcBas = class (TComponent)
    constructor Create(phAFCDEF:TAfcdefHnd); overload;
    destructor  Destroy; override;
  private
    oMyOp:boolean;
    oGrpNum:word;
    oBokNum:Str5;
    ohAFCDEF:TAfcdefHnd;
  public
  published
    function ReadData(pPmdMark:Str6;pFncCode:byte):boolean;
    procedure WriteData(pPmdMark:Str6;pFncCode:byte;pValue:boolean);

    property GrpNum:word write oGrpNum;
    property BokNum:Str5 write oBokNum;
  end;

implementation

constructor TAfcBas.Create(phAFCDEF:TAfcdefHnd);
begin
  oMyOp := phAFCDEF=nil;
  If oMyOp then begin
    ohAFCDEF := TAfcdefHnd.Create;  ohAFCDEF.Open;
  end
  else ohAFCDEF := phAFCDEF;
end;

destructor TAfcBas.Destroy;
begin
  If oMyOp then FreeAndNil(ohAFCDEF);
end;

// *************************************** PRIVATE ********************************************

function TAfcBas.ReadData(pPmdMark:Str6;pFncCode:byte):boolean;
var mAcsCtrl:Str250;
begin
  If (oGrpNum=0) or cNexStart
    then Result := TRUE
    else begin
      Result := FALSE;
      If ohAFCDEF.LocateGrPmBn(oGrpNum,pPmdMark,oBokNum) then begin
        mAcsCtrl := ohAFCDEF.AcsCtrl;
        If Length(mAcsCtrl)>=pFncCode then Result := mAcsCtrl[pFncCode]='X';
      end;
    end;
end;

procedure TAfcBas.WriteData(pPmdMark:Str6;pFncCode:byte;pValue:boolean);
var mAcsCtrl:Str250;
begin
  If pFncCode=255 then begin
    If pValue
      then mAcsCtrl := FillStr ('',250,'X')
      else mAcsCtrl := FillStr ('',250,'.');
    If ohAFCDEF.LocateGrPmBn(oGrpNum,pPmdMark,oBokNum) then begin
      ohAFCDEF.Edit;
      ohAFCDEF.AcsCtrl := mAcsCtrl;
      ohAFCDEF.Post;
    end
    else begin
      ohAFCDEF.Insert;
      ohAFCDEF.GrpNum  := oGrpNum;
      ohAFCDEF.PmdMark := pPmdMark;
      ohAFCDEF.BookNum := oBokNum;
      ohAFCDEF.AcsCtrl := mAcsCtrl;
      ohAFCDEF.Post;
    end;
  end else begin
    If ohAFCDEF.LocateGrPmBn(oGrpNum,pPmdMark,oBokNum) then begin
      mAcsCtrl := ohAFCDEF.AcsCtrl;
      If mAcsCtrl='' then mAcsCtrl := FillStr ('',250,'.');
      If pValue
        then mAcsCtrl[pFncCode] := 'X'
        else mAcsCtrl[pFncCode] := '.';
      ohAFCDEF.Edit;
      ohAFCDEF.AcsCtrl := mAcsCtrl;
      ohAFCDEF.Post;
    end
    else begin
      mAcsCtrl := FillStr ('',250,'.');
      If pValue
        then mAcsCtrl[pFncCode] := 'X'
        else mAcsCtrl[pFncCode] := '.';
      ohAFCDEF.Insert;
      ohAFCDEF.GrpNum  := oGrpNum;
      ohAFCDEF.PmdMark := pPmdMark;
      ohAFCDEF.BookNum := oBokNum;
      ohAFCDEF.AcsCtrl := mAcsCtrl;
      ohAFCDEF.Post;
    end;
  end;
end;

// ------------------------------- PRIVATE -------------------------------------

end.
