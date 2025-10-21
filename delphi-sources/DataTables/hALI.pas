unit hALI;

interface         

uses
  IcTypes, IcTools, NexPath, NexGlob, Key, Plc, bALI, 
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAliHnd = class (TAliBtr)
  private
  public
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
    procedure Del(pDocNum:Str12);
    procedure SetAgBValue(pAgBValue:double);
    procedure SetAsBValue(pAsBValue:double);
  published
  end;

implementation

function TAliHnd.FreeItmNum(pDocNum:Str12):word;
var mItmNum:word;  mFind:boolean;
begin
  Result := 0;
  SwapIndex;
  If LocateDoIt(pDocNum,1) then begin
    mItmNum := 0;
    Repeat
      Inc (mItmNum);
      mFind := mItmNum<ItmNum;
      If mItmNum>ItmNum then mItmNum := ItmNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum);
    If mFind
      then Result := mItmNum
      else Result := mItmNum+1;
  end
  else Result := 1;
  RestoreIndex;
end;

function TAliHnd.NextItmNum(pDocNum:Str12):word;
begin
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := ItmNum+1
    else Result := 1;
end;

procedure TAliHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TAliHnd.SetAgBValue(pAgBValue:double);
begin
  If gKey.AlbRndBva[BtrTable.BookNum] then begin // Zaokruhluju sa hodnoty s DPH
    AgBValue := RdX(pAgBValue,gKey.AlbAgvFrc[BtrTable.BookNum]);
    AgBPrice := RdX(AgBValue/GsQnt,gKey.AlbAgpFrc[BtrTable.BookNum]);
    AgAValue := gPlc.ClcAPrice(VatPrc,AgBValue,gKey.SysNrdFrc);
    AgAPrice := RdX(AgAValue/GsQnt,gKey.SysNrdFrc);
  end
  else begin // Zaoruhluju sa hodnoty bez DPH
    AgBValue := RdX(pAgBValue,gKey.SysNrdFrc);
    AgBPrice := RdX(AgBValue/GsQnt,gKey.SysNrdFrc);
    AgAValue := gPlc.ClcAPrice(VatPrc,AgBValue,gKey.AlbAgvFrc[BtrTable.BookNum]);
    AgAPrice := RdX(AgAValue/GsQnt,gKey.AlbAgpFrc[BtrTable.BookNum]);
  end;
end;

procedure TAliHnd.SetAsBValue(pAsBValue:double);
begin
  If gKey.AlbRndBva[BtrTable.BookNum] then begin // Zaokruhluju sa hodnoty s DPH
    AsBValue := RdX(pAsBValue,gKey.AlbAsvFrc[BtrTable.BookNum]);
    AsBPrice := RdX(AsBValue/GsQnt,gKey.AlbAspFrc[BtrTable.BookNum]);
    AsAValue := gPlc.ClcAPrice(VatPrc,AsBValue,gKey.SysNrdFrc);
    AsAPrice := RdX(AsAValue/GsQnt,gKey.SysNrdFrc);
  end
  else begin // Zaoruhluju sa hodnoty bez DPH
    AsBValue := RdX(pAsBValue,gKey.SysNrdFrc);
    AsBPrice := RdX(AsBValue/GsQnt,gKey.SysNrdFrc);
    AsAValue := gPlc.ClcAPrice(VatPrc,AsBValue,gKey.AlbAsvFrc[BtrTable.BookNum]);
    AsAPrice := RdX(AsAValue/GsQnt,gKey.AlbAspFrc[BtrTable.BookNum]);
  end;
  If IsNul(DscPrc) then begin
    AsDValue := AsAValue;
    AsHValue := AsBValue;
  end
  else begin
    If gKey.AlbRndBva[BtrTable.BookNum] then begin // Zaokruhluju sa hodnoty s DPH
      AsHValue := RdX(AsBValue/(1-DscPrc/100),gKey.AlbAspFrc[BtrTable.BookNum]);
      AsDValue := gPlc.ClcAPrice(VatPrc,AsHValue,gKey.SysNrdFrc);
    end
    else begin // Zaoruhluju sa hodnoty bez DPH
      AsHValue := RdX(AsBValue/(1-DscPrc/100),gKey.SysNrdFrc);
      AsDValue := gPlc.ClcAPrice(VatPrc,AsHValue,gKey.SysNrdFrc);
    end;
  end;
  If gKey.AlbRndBva[BtrTable.BookNum] then begin // Zaokruhluju sa hodnoty s DPH
    AsDPrice := RdX(AsDValue/GsQnt,gKey.SysNrdFrc);
    AsHPrice := RdX(AsHValue/GsQnt,gKey.AlbAspFrc[BtrTable.BookNum]);
  end
  else begin // Zaoruhluju sa hodnoty bez DPH
    AsDPrice := RdX(AsDValue/GsQnt,gKey.AlbAspFrc[BtrTable.BookNum]);
    AsHPrice := RdX(AsHValue/GsQnt,gKey.SysNrdFrc);
  end;
end;

end.
