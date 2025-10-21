unit Adv;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU SO ZALOHAMI
// *****************************************************************************
// Programové funkcia:
// ---------------
// SPD.BDF SPD.TDF sallycomproc
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, NexIni, NexGlob, NexPath,
  SallyComGlobal, BtrTools,
  Rep, Key, hSPBLST, hSPD, bSPD, hGsCat, hPab, hSPV,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  TAdv=class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    private
      oFrmName:Str15;
    public
      ohSPBLST:TSpblstHnd;
      ohSPD:TSpdHnd;
      ohSPV:TSpvHnd;
      function GetEndVal(pPaCode:longint):double;
      procedure Clc(pPaCode:longint;phSPD:TSpdHnd);
      procedure AddExpDoc (pPaCode:longint;pVatPrc:byte;pExpVal:double;pDocNum:Str12);
      procedure AddIncDoc (pPaCode:longint;pVatPrc:TBytes6;pIncVal,pPrfVal:TValue6;pConDoc,pPayDoc,pVatDoc:Str12;pDescribe:Str60;pPayDate:TDateTime;pPayMode:Str1);
    published
  end;

implementation

constructor TAdv.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  ohSPBLST := TSpblstHnd.Create;  ohSPBLST.Open;
  ohSPD    := TSpdHnd.Create;
  ohSPV    := TSpvHnd.Create;
end;

destructor TAdv.Destroy;
begin
  FreeAndNil (ohSPBLST);
  FreeAndNil (ohSPD);
  FreeAndNil (ohSPV);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

function TAdv.GetEndVal(pPaCode:longint):double;
begin
  Result := 0;
  if ohSPBLST.LocatePaCode(pPaCode) then Result := ohSPBLST.EndVal;
end;

procedure TAdv.Clc(pPaCode:longint;phSPD:TSpdHnd);
var mIncVal,mExpVal:array[1..8] of double;
begin
  If ohSPBLST.LocatePaCode(pPaCode) then begin
    FillChar(mIncVal,SizeOf(mIncVal),#0);
    FillChar(mExpVal,SizeOf(mIncVal),#0);
    If phSPD.Count>0 then begin
      phSPD.First;
      Repeat
        If phSPD.IncNum>0 then begin
          mIncVal[1] := mIncVal[1]+phSPD.DocVal1;
          mIncVal[2] := mIncVal[2]+phSPD.DocVal2;
          mIncVal[3] := mIncVal[3]+phSPD.DocVal3;
        end
        else begin
          mExpVal[1] := mExpVal[1]+phSPD.DocVal1;
          mExpVal[2] := mExpVal[2]+phSPD.DocVal2;
          mExpVal[3] := mExpVal[3]+phSPD.DocVal3;
        end;
        phSPD.Next;
      until phSPD.Eof;
    end;
    ohSPBLST.Edit;
    ohSPBLST.IncVal1 := mIncVal[1];
    ohSPBLST.IncVal2 := mIncVal[2];
    ohSPBLST.IncVal3 := mIncVal[3];
    ohSPBLST.ExpVal1 := mExpVal[1];
    ohSPBLST.ExpVal2 := mExpVal[2];
    ohSPBLST.ExpVal3 := mExpVal[3];
    ohSPBLST.IncVal := mIncVal[1]+mIncVal[2]+mIncVal[3];
    ohSPBLST.ExpVal := mExpVal[1]+mExpVal[2]+mExpVal[3];
    ohSPBLST.EndVal := ohSPBLST.IncVal+ohSPBLST.ExpVal;
    ohSPBLST.Post;
  end;
end;

procedure TAdv.AddExpDoc (pPaCode:longint;pVatPrc:byte;pExpVal:double;pDocNum:Str12);
var mSerNum:word;  mExpNum:word;   mExpVal:double;
begin
  mExpVal := pExpVal*(-1);
  If ohSPD.Active and (ohSPD.BtrTable.ListNum<>pPaCode) then ohSPD.Close;
  If not ohSPD.Active then ohSPD.Open(pPaCode);
  // Vygenerujeme nove chronologice poradove cislo
  ohSPD.SetIndex(ixSerNum);
  ohSPD.Last;
  mSerNum := ohSPD.SerNum+1;
  // Vygenerujeme nove poradove cislo vydajoveho dokladu
  ohSPD.SetIndex(ixExpNum);
  ohSPD.Last;
  mExpNum := ohSPD.ExpNum+1;
  ohSPD.Insert;
  ohSPD.SerNum := mSerNum;
  ohSPD.ExpNum := mExpNum;
  ohSPD.DocNum := 'ZA'+StrIntZero(pPaCode,5)+StrIntZero(mSerNum,5);
  ohSPD.DocDate := Date;
  ohSPD.Describe := '';
  ohSPD.VatPrc1 := gIni.GetVatPrc(1);
  ohSPD.VatPrc2 := gIni.GetVatPrc(2);
  ohSPD.VatPrc3 := gIni.GetVatPrc(3);
  ohSPD.ExpVal := mExpVal;
  case VatGrp(pVatPrc) of
    1: ohSPD.DocVal1 := mExpVal;
    2: ohSPD.DocVal2 := mExpVal;
    3: ohSPD.DocVal3 := mExpVal;
  end;
  ohSPD.DocVal := ohSPD.DocVal1+ohSPD.DocVal2+ohSPD.DocVal3;
  ohSPD.EndVal := GetEndVal(pPaCode)+mExpVal;
  ohSPD.ConDoc := pDocNum;
  ohSPD.PayMode := 'H';
  ohSPD.RspName := gvSys.UserName;
  ohSPD.Post;
  Clc(pPaCode,ohSPD);
end;

procedure TAdv.AddIncDoc;
var mhSpd:TSpdHnd; mhSpbLst: TSpblstHnd; mhPab:TPabHnd; mSpdSn,mSpdIn:longint;
    mVat: array[1..6] of longint; I:longint; mFind:boolean; mS:String;
begin
  If pPayMode='' then pPayMode:='H';
  mhPab:=TPabHnd.Create;mhPab.Open(0);
  If mhPab.LocatePaCode(pPaCode) then begin
    mhSpbLst:=TSpblstHnd.Create;mhSpbLst.Open;
    mhSpd:=TSpdHnd.Create;mhSpd.Open(pPaCode);
    If not mhSpbLst.LocatePaCode(pPaCode) then begin
      mhSpbLst.Insert;
      BTR_To_BTR(mhPab.BtrTable,mhSpbLst.BtrTable);
      mhSpbLst.VatPrc1 := gIni.GetVatPrc(1);
      mhSpbLst.VatPrc2 := gIni.GetVatPrc(2);
      mhSpbLst.VatPrc3 := gIni.GetVatPrc(3);
      mhSpbLst.VatPrc4 := gIni.GetVatPrc(4);
      mhSpbLst.VatPrc5 := gIni.GetVatPrc(5);
      mhSpbLst.VatPrc6 := gIni.GetVatPrc(6);
      mhSpbLst.Post;
    end;
    mFind:=False;
    mhSpd.First;
    while not mFind and not mhSpd.Eof do begin
      mFind:=((pVatDoc='')or(mhSpd.VatDoc=pVatDoc))and((pConDoc='')or(mhSpd.ConDoc=pConDoc))
          and((pPayDoc='')or(mhSpd.PayDoc=pPayDoc));
      mhSpd.Next;
    end;
    If not mFind then begin
      mhSpbLst.Edit;
      For I:=1 to 5 do begin
        If (IsNotNul (pIncval[I])or IsNotNul (pPrfVal[I])) and (pVatPrc[I]<100) then begin
          mFind := FALSE;
          If pVatPrc[I]=mhSpbLst.VatPrc1 then begin
            mFind := TRUE;
            mhSpbLst.IncVal1 := mhSpbLst.IncVal1+pIncval[I];
            mhSpbLst.PrfVal1 := mhSpbLst.PrfVal1+pPrfval[I];
          end;
          If not mFind and (pVatPrc[I]=mhSpbLst.VatPrc2) then begin
            mFind := TRUE;
            mhSpbLst.IncVal2 := mhSpbLst.IncVal2+pIncval[I];
            mhSpbLst.PrfVal2 := mhSpbLst.PrfVal2+pPrfval[I];
          end;
          If not mFind and (pVatPrc[I]=mhSpbLst.VatPrc3) then begin
            mFind := TRUE;
            mhSpbLst.IncVal3 := mhSpbLst.IncVal3+pIncval[I];
            mhSpbLst.PrfVal3 := mhSpbLst.PrfVal3+pPrfval[I];
          end;
          If not mFind and (pVatPrc[I]=mhSpbLst.VatPrc4) then begin
            mFind := TRUE;
            mhSpbLst.IncVal4 := mhSpbLst.IncVal4+pIncval[I];
            mhSpbLst.PrfVal4 := mhSpbLst.PrfVal4+pPrfval[I];
          end;
          If not mFind and (pVatPrc[I]=mhSpbLst.VatPrc5) then begin
            mFind := TRUE;
            mhSpbLst.IncVal5 := mhSpbLst.IncVal5+pIncval[I];
            mhSpbLst.PrfVal5 := mhSpbLst.PrfVal5+pPrfval[I];
          end;
          If not mFind and (pVatPrc[I]=mhSpbLst.VatPrc6) then begin
            mFind := TRUE;
            mhSpbLst.IncVal6 := mhSpbLst.IncVal6+pIncval[I];
            mhSpbLst.PrfVal6 := mhSpbLst.PrfVal6+pPrfval[I];
          end;
          If not mFind then begin
            If not DirectoryExists(gPath.BckPath+'LOGS\ERRS\')
              then ForceDirectories(gPath.BckPath+'LOGS\ERRS\');
            mS:='Prijem zalohovej platby;Neexistujuca sadzba '+IntToStr(pVatPrc[I])+';'
            +pConDoc+';'+IntToStr(pPaCode)+';'+pVatDoc+';'+
            dateToStr(Date)+';'+';'+pPayDoc+';';
            WriteToLogFile(gPath.BckPath+'LOGS\ERRS\NCS.ERR',mS);
          end;
        end;
      end;
      mhSpbLst.IncVal  := mhSpbLst.IncVal1+mhSpbLst.IncVal2+mhSpbLst.IncVal3+mhSpbLst.IncVal4+mhSpbLst.IncVal5;
      mhSpbLst.EndVal  := mhSpbLst.IncVal+mhSpbLst.ExpVal;
      mhSpbLst.PrfVal  := mhSpbLst.PrfVal1+mhSpbLst.PrfVal2+mhSpbLst.PrfVal3+mhSpbLst.PrfVal4+mhSpbLst.PrfVal5;
      mhSpbLst.Post;

      // Ulozime doklad o prijmu zalohy
      mhSpd.LocateSerNum(1); mhSpd.Last; mSpdSn:=mhSpd.SerNum+1;
      mhSpd.LocateIncNum(1); mhSpd.Last; mSpdIn:=mhSpd.IncNum+1;
      mhSpd.Insert;
      mhSpd.SerNum  := mSpdSn;
      mhSpd.IncNum  := mSpdIn;
      mhSpd.DocNum  := GenSeDocNum (pPaCode,mSpdSn);
      mhSpd.DocDate := Date;
      mhSpd.Describe:= pDescribe;
      mhSpd.VatPrc1 := gIni.GetVatPrc(1);
      mhSpd.VatPrc2 := gIni.GetVatPrc(2);
      mhSpd.VatPrc3 := gIni.GetVatPrc(3);
      FillChar (mVat,sizeof(mVat),#0);
      For I:=5 downto 1 do begin
        If (pVatPrc[I]=mhSpd.VatPrc3) then mVat[3] := I;
        If (pVatPrc[I]=mhSpd.VatPrc2) then mVat[2] := I;
        If (pVatPrc[I]=mhSpd.VatPrc1) then mVat[1] := I;
      end;
      If mVat[1]>0 then mhSpd.DocVal1 := pIncVal[mVat[1]];
      If mVat[2]>0 then mhSpd.DocVal2 := pIncVal[mVat[2]];
      If mVat[3]>0 then mhSpd.DocVal3 := pIncVal[mVat[3]];
      If mVat[1]>0 then mhSpd.PrfVal1 := pPrfVal[mVat[1]];
      If mVat[2]>0 then mhSpd.PrfVal2 := pPrfVal[mVat[2]];
      If mVat[3]>0 then mhSpd.PrfVal3 := pPrfVal[mVat[3]];
      mhSpd.DocVal  := mhSpd.DocVal1+mhSpd.DocVal2+mhSpd.DocVal3;
      mhSpd.PrfVal  := mhSpd.PrfVal1+mhSpd.PrfVal2+mhSpd.PrfVal3;
      mhSpd.IncVal  := mhSPBLST.IncVal;
      mhSpd.ExpVal  := mhSPBLST.ExpVal;
      mhSpd.EndVal  := mhSPBLST.EndVal;
      mhSpd.PayMode := pPayMode;
      mhSpd.RspName := '';
      mhSpd.ConDoc  := pConDoc;
      mhSpd.PayDoc  := pPayDoc;
      mhSpd.VatDoc  := pVatDoc;
      mhSpd.PayDate := pPayDate;
      mhSpd.Post;
    end else begin

    end;
    FreeAndNil(mhSpd);FreeAndNil(mhSpbLst);
  end;
  FreeAndNil(mhPab);
end;

end.


