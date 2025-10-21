unit hSAH;

interface

uses
  IcValue, IcTypes, IcTools, IcConv, IcVariab, NexPath, NexGlob, NexIni, DocHand,
  Key, Adv,  bSAH, hSAI, hSAC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSahHnd=class(TSahBtr)
  private
    function GetBokNum:Str5;
  public
    procedure Clc(phSAI:TSaiHnd);   // prepocita hlavicku podla jeho poloziek
    property BokNum:Str5 read GetBokNum;
  published
  end;

implementation

{ TSahHnd }

procedure TSahHnd.Clc(phSAI:TSaiHnd);
var mAValue,mBValue:TValue8;   mCValue,mDscVal,mSvcAva,mDpiBva,mDpeBva,mInfVal,mNsiQnt:double; mInd:boolean;
    mSvcMgc,mDpiMgc,mDpeMgc,mItmQnt,mNsiCnt:longint;   I,mVatQnt:byte;  mServiceMg:longint;  mBokNum:Str5;
begin             
  mDpiMgc:=gKey.Whs.DpiMgc; // Tovarová skupina pre prijaté zálohy
  mDpeMgc:=gKey.Whs.DpeMgc; // Tovarová skupina pre zápoèet zálohy
  mSvcMgc:=gIni.ServiceMg;  // Tovarová skupina, od ktorej sa zaèínajú služby
//  mgKey_SysAdvGsc:=Adv.FndVerAdvGsCode(0,gvSys.DefVatPrc,NIL);
//  mgKey_MarAdvGsc:=gKey.MarAdvGsc;
  mBokNum:=BookNumFromDocNum(DocNum);
  mItmQnt:=0;  mNsiCnt:=0;  mInfVal:=0;
  mCValue:=0;  mDscVal:=0;  mSvcAva:=0;  mDpiBva:=0;  mDpeBva:=0;
  mAValue:=TValue8.Create;  mAValue.Clear;
  mBValue:=TValue8.Create;  mBValue.Clear;
  mAValue.VatPrc[1]:=Round(VatPrc1); mBValue.VatPrc[1]:=Round(VatPrc1);
  mAValue.VatPrc[2]:=Round(VatPrc2); mBValue.VatPrc[2]:=Round(VatPrc2);
  mAValue.VatPrc[3]:=Round(VatPrc3); mBValue.VatPrc[3]:=Round(VatPrc3);
  mAValue.VatPrc[4]:=Round(VatPrc3); mBValue.VatPrc[4]:=Round(VatPrc3);
  mAValue.VatPrc[5]:=Round(VatPrc3); mBValue.VatPrc[5]:=Round(VatPrc3);
  phSAI.SwapIndex;
  If phSAI.LocateDocNum (DocNum) then begin
    Repeat
      Inc(mItmQnt);
      mCValue:=mCValue+phSAI.CValue;
      If phSAI.StkStat='C' then begin
        mNsiQnt:=phSAI.CpSeQnt-phSAI.CpSuQnt;
        If IsNotNul(mNsiQnt) then mInfVal:=mInfVal+phSAI.CPrice*mNsiQnt;
        mDscVal:=mDscVal+phSAI.DscVal;
      end
      else begin
        mNsiQnt:=phSAI.SeQnt-phSAI.SuQnt;
        If IsNotNul(mNsiQnt) then mInfVal:=mInfVal+phSAI.CPrice*mNsiQnt;
        mDscVal:=mDscVal+phSAI.DscVal;
      end;

      If phSAI.MgCode=mDpiMgc then begin
        mDpiBva:=mDpiBva+phSAI.BValue;  // Príjem zálohy
      end else begin
        If phSAI.MgCode=mDpeMgc then begin
          mDpeBva:=mDpeBva+phSAI.BValue;  // Odpoèet zálohy
        end else mSvcAva:=mSvcAva+phSAI.AValue; // Sluzby
      end;
(*
      If phSAI.GsCode<>mgKey_SysAdvGsc then begin
        If phSAI.GsCode<>mgKey_MarAdvGsc then begin
          If phSAI.MgCode<mServiceMg then begin // Tovar
            If IsNotNul(mNsiQnt) then Inc (mNsiCnt); // Pocet nevysporiadanych poloziek
          end
          else mSecVal:=mSecVal+phSAI.AValue; // Sluzby
        end
        else mSpeBvl:=mSpeBvl+phSAI.BValue;  // Odpoèet zálohy
      end
      else mSpiBvl:=mSpiBvl+phSAI.BValue;
*)
      If mAValue.VatGrp(phSAI.VatPrc)=0 then begin // Neexistujuca sadzba DPH
        mVatQnt:=mAValue.VatQnt;
        mAValue.VatPrc[mVatQnt+1]:=phSAI.VatPrc;
        mBValue.VatPrc[mVatQnt+1]:=phSAI.VatPrc;
      end;
      mAValue.Add(phSAI.VatPrc,phSAI.AValue);
      mBValue.Add(phSAI.VatPrc,phSAI.BValue);
      Application.ProcessMessages;
      phSAI.Next;
    until (phSAI.Eof) or (phSAI.DocNum<>DocNum);
  end;
  phSAI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  Edit;
  VatPrc1:=mAValue.VatPrc[1];
  VatPrc2:=mAValue.VatPrc[2];
  VatPrc3:=mAValue.VatPrc[3];
  VatPrc4:=mAValue.VatPrc[4];
  VatPrc5:=mAValue.VatPrc[5];
  If gIni.SpecSetting='CKD'
    then CValue:=mCValue+mInfVal
    else CValue:=mCValue;
  DscVal:=mDscVal;
  AValue:=Rd2(mAValue.Value[0]);
  VatVal:=Rd2(mBValue[0]-mAValue[0]);
  BValue:=Rd2(mBValue.Value[0]);
  If BtrTable.FindField('SpiVal')<>nil then begin
    SpiVat:=Rd2(mDpiBva-(mDpiBva/(1+gIni.GetVatPrc(2)/100)));
    SpeVat:=Rd2(mDpeBva-(mDpeBva/(1+gIni.GetVatPrc(2)/100)));
    SpiVal:=Rd2(mDpiBva-SpiVat);
    SpeVal:=Rd2(mDpeBvA-SpeVat);
    SecVal:=Rd2(mSvcAva);
    GscVal:=AValue-SecVal-(SpeVal)-(SpiVal);
  end;
  AValue1:=mAValue[1];
  AValue2:=mAValue[2];
  AValue3:=mAValue[3];
  AValue4:=mAValue[4];
  AValue5:=mAValue[5];

  VatVal1:=mBValue[1]-mAValue[1];
  VatVal2:=mBValue[2]-mAValue[2];
  VatVal3:=mBValue[3]-mAValue[3];
  VatVal4:=mBValue[4]-mAValue[4];
  VatVal5:=mBValue[5]-mAValue[5];

  BValue1:=mBValue[1];
  BValue2:=mBValue[2];
  BValue3:=mBValue[3];
  BValue4:=mBValue[4];
  BValue5:=mBValue[5];

  DstAcc:=GetDstAcc(DocNum);
  ItmQnt:=mItmQnt;
  NsiCnt:=mNsiCnt;
  Post;
end;

function TSahHnd.GetBokNum: Str5;
begin
  Result:=BtrTable.BookNum;
end;

end.
