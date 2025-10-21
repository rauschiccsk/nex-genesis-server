unit hICH;

interface

uses
  IcTypes, IcConv, IcTools, IcValue, NexPath, NexGlob, NexIni, Key, DocHand,
  bICH, hICI, hDEBREG,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIchHnd = class (TIchBtr)
  private
  public
    procedure Insert; overload;

    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    procedure Del(pDocNum:Str12);
    procedure Clc(phICI:TIciHnd);

    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

uses bICI;

function TIchHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TIchHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result:=GenIcDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TIchHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result:=0;
  case pVatGrp of
    1: Result:=VatPrc1;
    2: Result:=VatPrc2;
    3: Result:=VatPrc3;
    4: Result:=VatPrc4;
    5: Result:=VatPrc5;
  end;
end;

procedure TIchHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

procedure TIchHnd.Insert;
begin
  inherited ;
  VatPrc1:=gIni.GetVatPrc(1);
  VatPrc2:=gIni.GetVatPrc(2);
  VatPrc3:=gIni.GetVatPrc(3);
  VatPrc4:=gIni.GetVatPrc(4);
  VatPrc5:=gIni.GetVatPrc(5);
end;

procedure TIchHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TIchHnd.Clc(phICI:TIciHnd);
var mItmQnt:longint; mDstPair:Str1; mBonNum,mVatQnt,I:byte; mSpMark:Str10; mWeight,mVolume,mQntSum,mCctVal:double;
    mAcCValue,mAcDValue,mAcDscVal,mAcPValue,mEyCrdVal,mAcRndVat,mAcRndVal,mFgRndVat,mFgRndVal:double;
    mFgCourse,mFgCValue,mFgDValue,mFgDBValue,mFgDscVal,mFgDscBVal,mFgPValue,mFgHdsVal:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;
begin
  mItmQnt:=0;    mSpMark:='';   mBonNum:=0;    mQntSum:=0;    mCctVal:=0;
  mAcCValue:=0;  mAcDValue:=0;  mAcDscVal:=0;  mAcPValue:=0;
  mFgCValue:=0;  mFgDValue:=0;  mFgDscVal:=0;  mFgPValue:=0;
  mEyCrdVal:=0;  mFgHdsVal:=0;  mAcRndVal:=0;  mAcRndVat:=0;  mFgRndVal:=0;  mFgRndVat:=0;
  mFgDBValue:=0; mFgDscBVal:=0; mWeight:=0;    mVolume:=0;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=VatPrc[I];
    mAcBValue.VatPrc[I]:=VatPrc[I];
    mFgAValue.VatPrc[I]:=VatPrc[I];
    mFgBValue.VatPrc[I]:=VatPrc[I];
  end;
  mDstPair:='N';
  phICI.SwapIndex;
  If phICI.LocateDocNum(DocNum) then begin
    mDstPair:='Q';
    Repeat
      Inc (mItmQnt);
      If phICI.GsCode<>gKey.Sys.TrvGsc then begin
        mWeight:=mWeight+phICI.Weight*phICI.GsQnt;
        mVolume:=mVolume+phICI.Volume*phICI.GsQnt;
        mQntSum:=mQntSum+phICI.GsQnt;
      end;
      mAcCValue:=mAcCValue+phICI.AcCValue;
      mAcRndVat:=mAcRndVat+phICI.AcRndVat;
      mAcRndVal:=mAcRndVal+phICI.AcRndVal;
      mFgCValue:=mFgCValue+phICI.FgCValue;
      mFgDValue:=mFgDValue+phICI.FgDValue;
      mFgDscVal:=mFgDscVal+phICI.FgDscVal;
      mFgHdsVal:=mFgHdsVal+phICI.FgHdsVal;
      mFgRndVat:=mFgRndVat+phICI.FgRndVat;
      mFgRndVal:=mFgRndVal+phICI.FgRndVal;
      mFgDBValue:=mFgDBValue+Rd2(phICI.FgDValue*(1+phICI.VatPrc/100));
      mFgDscBVal:=mFgDscBVal+Rd2(phICI.FgDscVal*(1+phICI.VatPrc/100));
      If phICI.CctVat=1 then mCctVal:=mCctVal+phICI.AcAValue;
      If phICI.OcdNum='PROFORMA' then begin
        mAcPValue:=mAcPValue+phICI.AcAValue*(-1);
        mFgPValue:=mFgPValue+phICI.FgAValue*(-1);
      end;
      If mAcAValue.VatGrp(phICI.VatPrc)=0 then begin // Neexistujuca sadzba DPH
        mVatQnt:=mAcAValue.VatQnt;
        If mVatQnt<3 then begin
          mAcAValue.VatPrc[mVatQnt+1]:=phICI.VatPrc;
          mAcBValue.VatPrc[mVatQnt+1]:=phICI.VatPrc;
          mFgAValue.VatPrc[mVatQnt+1]:=phICI.VatPrc;
          mFgBValue.VatPrc[mVatQnt+1]:=phICI.VatPrc;
        end;
      end;
      mAcAValue.Add (phICI.VatPrc,phICI.AcAValue+phICI.AcRndVal-phICI.AcRndVat);
      mAcBValue.Add (phICI.VatPrc,phICI.AcBValue+phICI.AcRndVal);
      mFgAValue.Add (phICI.VatPrc,phICI.FgAValue+phICI.FgRndVal-phICI.FgRndVat);
      mFgBValue.Add (phICI.VatPrc,phICI.FgBValue+phICI.FgRndVal);
      If (phICI.MgCode<gIni.GetServiceMg) and ((phICI.Status='N') or (phICI.Status='')) then mDstPair:='N';
      If (phICI.SpMark<>'') then mSpMark:=phICI.SpMark;
      If (phICI.BonNum<>0) then mBonNum:=phICI.BonNum;
      phICI.Next;
    until (phICI.Eof) or (phICI.DocNum<>DocNum);
  end;
  phICI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  mFgCourse:=FgCourse;
  If IsNul (mFgCourse) then mFgCourse:=1;
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(VatDoc));
  Edit;
  If IsNotNul (mFgDValue+mFgPValue)
    then DscPrc:=Rd2 ((mFgDscVal/(mFgDValue+mFgPValue))*100)
    else DscPrc:=0;
  VatPrc1:=mAcAValue.VatPrc[1];
  VatPrc2:=mAcAValue.VatPrc[2];
  VatPrc3:=mAcAValue.VatPrc[3];
  VatPrc4:=mAcAValue.VatPrc[4];
  VatPrc5:=mAcAValue.VatPrc[5];

  AcCValue:=mAcCValue;
  FgCValue:=mFgCValue;
  FgDValue:=mFgDValue;
  FgDBValue:=mFgDBValue;   // * zmenit na FgHValue
  FgDscBVal:=mFgDscBVal;
  FgDscVal:=mFgDscVal;
  FgHdsVal:=mFgHdsVal;
  FgAValue:=mFgAValue.Value[0];
  FgBValue:=mFgBValue.Value[0];
  FgVatVal:=FgBValue-FgAValue;
  FgAValue1:=mFgAValue.Value[1];
  FgAValue2:=mFgAValue.Value[2];
  FgAValue3:=mFgAValue.Value[3];
  FgAValue4:=mFgAValue.Value[4];
  FgAValue5:=mFgAValue.Value[5];

  FgBValue1:=mFgBValue.Value[1];
  FgBValue2:=mFgBValue.Value[2];
  FgBValue3:=mFgBValue.Value[3];
  FgBValue4:=mFgBValue.Value[4];
  FgBValue5:=mFgBValue.Value[5];

  AcDValue:=Rd2(mFgDValue/mFgCourse+mAcRndVal-mAcRndVat);
  AcDscVal:=Rd2(mFgDscVal/mFgCourse);
  AcAValue:=Rd2(mAcAValue.Value[0]);
  AcBValue:=Rd2(mAcBValue.Value[0]);
  AcVatVal:=Rd2(AcBValue-AcAValue);
  AcAValue1:=Rd2(mFgAValue.Value[1]/mFgCourse);
  AcAValue2:=Rd2(mFgAValue.Value[2]/mFgCourse);
  AcAValue3:=Rd2(mFgAValue.Value[3]/mFgCourse);
  AcAValue4:=Rd2(mFgAValue.Value[4]/mFgCourse);
  AcAValue5:=Rd2(mFgAValue.Value[5]/mFgCourse);

  AcBValue1:=Rd2(mFgBValue.Value[1]/mFgCourse);
  AcBValue2:=Rd2(mFgBValue.Value[2]/mFgCourse);
  AcBValue3:=Rd2(mFgBValue.Value[3]/mFgCourse);
  AcBValue4:=Rd2(mFgBValue.Value[4]/mFgCourse);
  AcBValue5:=Rd2(mFgBValue.Value[5]/mFgCourse);

  AcPValue:=Rd2(mFgPValue/mFgCourse);
  CctVal:=Rd2(mCctval);
  FgPValue:=mFgPValue;
  EyCrdVal:=mEyCrdVal;
  AcRndVat:=mAcRndVat;
  AcRndVal:=mAcRndVal;
  FgRndVat:=mFgRndVat;
  FgRndVal:=mFgRndVal;
  If IsNotNul (mFgAValue.Value[0])
    then HdsPrc:=Rd2 ((mFgHdsVal/(mFgHdsVal+mFgAValue.Value[0]))*100)
    else HdsPrc:=0;
  ItmQnt:=mItmQnt;
  DstPair:=mDstPair;
  AcEndVal:=AcBValue-AcPayVal-EyCrdVal;
  FgEndVal:=FgBValue-FgPayVal;
  DstPay:=byte(Eq2(AcEndVal,0) and Eq2(FgEndVal,0));
  Weight:=mWeight;
  Volume:=mVolume;
  QntSum:=mQntSum;
  SpMark:=mSpMark;
  BonNum:=mBonNum;
  Post;
  FreeAndNil (mAcAValue);    FreeAndNil (mFgAValue);
  FreeAndNil (mAcBValue);    FreeAndNil (mFgBValue);
  If ghDEBREG=nil then ghDEBREG:=TDebregHnd.Create;
  If not ghDEBREG.Active then ghDEBREG.Open;
  ghDEBREG.AddDoc(PaCode,DocNum,FgEndVal,ExpDate);
end;

end.
