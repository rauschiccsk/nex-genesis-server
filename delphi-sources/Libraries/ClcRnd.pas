unit ClcRnd;
{$F+}
// *****************************************************************************
// **********             VZORCE V›POCçU A ZAOKR⁄HLENIA               **********
// *****************************************************************************
interface

uses
  IcTypes, IcVariab, IcConv, SysUtils, Forms;      

type
  TClcRnd=class
    private

//      function Rnd(pValue:double;pRndTyp,pRndFrc,pRndMod:byte):double;
    public
      function RndBas(pValue:double):double;  // Z·kladnÈ zaokr˙hlenie na 7 desatinn˝ch miest
      function RndDec(pValue:double;pFrac:byte):double; // ZaokruhlÌ prvÈ desatinnÈ miesto  na celÈ ËÌslo
      function RndVal(pValue:double;pRndTyp:Str1):double;
//      function DocRnd(pValue:double;pRndTyp:byte;pRndMod:Str1):double;
      procedure SetClcRnd(pValue:Str15);
    published
  end;

implementation

// ********************************* PRIVATE ***********************************

function TClcRnd.RndBas(pValue:double):double;
begin
  Result:=Round(pValue*10000000)/10000000;
end;

function TClcRnd.RndDec(pValue:double;pFrac:byte):double; // ZaokruhlÌ prvÈ desatinnÈ miesto  na celÈ ËÌslo
var mInt:Int64;  mDec:Str7;   mDig,mTrn,I:byte;   mChr:Str1;  mSig:integer;
begin
  If pValue<0 then mSig:=-1 else mSig:=1;
  pValue:=Abs(pValue);
  mInt:=Round(pValue);
//  mDec:=StrIntZero(Round(Frac(pValue)*Exp(7*Ln(10))),7);
  mDec:=StrIntZero(Round(Frac(pValue)*10000000),7);
  For I:=7 downto pFrac+1 do begin
    mDig:=ValInt(mDec[I]);
    If mDig<5 then mTrn:=0 else mTrn:=1;
    mDec[I]:='0';
    mDig:=ValInt(mDec[I-1]);
    mChr:=StrInt(mDig+mTrn,1);
    mDec[I-1]:=mChr[1];
  end;
  Result:=(mInt+ValInt(mDec)/10000000)*mSig;
end;

function Rnd(pVal:double;pTyp,pFrc,pMod:byte):double;
var mN,mRnd,mInt:double;  mSig,mVal:integer;
begin
(*
  If (Abs(pVal)<100000000) then begin
    mSig:=Sign(pVal);
    pVal:=Abs(pVal);
    mInt:=0;
    If pFrc>0 then begin
      mInt:=Int(pVal);
      pVal:=Frac(pVal);
    end;
    mRnd:=pVal;
    case pTyp of
      1: begin
           mN:=Sq(10,pFrc);
           case pMod of
             cStand: begin
                       mNum:=Round(RoundOK (pNum*N+0.00001));
                       mRnd:=mNum/N;
                     end;
              cDown: mRound:=Int(pNum*N)/N;
                cUp: If not Eq2(pNum,RoundOK(pNum)) then mRound:=Int(pNum*N+1)/N;
           end;
         end;
      5: begin
           mN:=Sq(10,pFrc-1);
           case pMod of                           Round
             cStand: mRnd:=Int(pVal*mN*2+0.5)/(2*mN);
              cDown: mRnd:=Int(pVal*mN*2)/(2*mN);
                cUp: begin
                       If pNum<>Int(pNum*N*2+0.5)/(2*N) then mRound:=Int(pNum*N*2+1)/(2*N);
                     end;
           end;
         end;
    end;
    If pFract>0 then mRound:=mRound+mInt;
  end else begin
    mSign:=1;
    mRound:=0;
  end;
  RoundOff:=mRound*mSign;
*)  
end;

function TClcRnd.RndVal(pValue:double;pRndTyp:Str1):double;
var mN,mInt,mValue:double;  mFract:integer;
begin
// X bez
  If pRndTyp[1] in ['0'..'9']
    then mFract:=ValInt(PrndTyp)
    else begin
      If pRndTyp='A' then mFract:=1;  // 10.00
      If pRndTyp='B' then mFract:=1;  //  5.00
    end;
  mN:=Exp(mFract*Ln(10));
  mValue:=(pValue*mN)/mN;
  mInt:=Int(mValue);
  If Frac(Abs(mValue))>=0.5 then begin
    If mValue>0
      then mInt:=mInt+1
      else mInt:=mInt-1;
  end;
  Result:=ValDoub(StrDoub(mValue,0,mFract));
end;

// ********************************** PUBLIC ***********************************

procedure TClcRnd.SetClcRnd(pValue:Str15);
begin
end;

end.


