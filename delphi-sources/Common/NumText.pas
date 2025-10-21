unit NumText;

interface

uses
  IcTypes, IcConv;

const
           c0: Str20 = 'nula';
           c1: Str20 = 'jedna';
           c2: Str20 = 'dva';
           c3: Str20 = 'tri';
           c4: Str20 = 'štyri';
           c5: Str20 = 'pä';
           c6: Str20 = 'šes';
           c7: Str20 = 'sedem';
           c8: Str20 = 'osem';
           c9: Str20 = 'devä';
          c10: Str20 = 'desa';
          c11: Str20 = 'jedenás';
          c12: Str20 = 'dvanás';
          c13: Str20 = 'trinás';
          c14: Str20 = 'štrnás';
          c15: Str20 = 'pätnás';
          c16: Str20 = 'šesnás';
          c17: Str20 = 'sedemnás';
          c18: Str20 = 'osemnás';
          c19: Str20 = 'devänás';
          c20: Str20 = 'dvadsa';
          c30: Str20 = 'tridsa';
          c40: Str20 = 'štyridsa';
          c50: Str20 = 'pädesiat';
          c60: Str20 = 'šesdesiat';
          c70: Str20 = 'sedemdesiat';
          c80: Str20 = 'osemdesiat';
          c90: Str20 = 'devädesiat';
         cx00: Str20 = 'sto';
         c200: Str20 = 'dvesto';
        c1000: Str20 = 'tisíc';
     c1000000: Str20 = 'milión';
     c2000000: Str20 = 'dvamilióny';
     c3000000: Str20 = 'trimilióny';
     c4000000: Str20 = 'štyrimilióny';
     cx000000: Str20 = 'miliónov';
  c1000000000: Str20 = 'jednamiliarda';
  c2000000000: Str20 = 'dvemiliardy';
  c3000000000: Str20 = 'trimiliardy';
  c4000000000: Str20 = 'štyrimiliardy';
  cx000000000: Str20 = 'miliard';

  function  ConvNumToText (pNum:double):Str200;
  function  CopyLastNum   (pS:Str10):Str1;
  function  ConvNum19     (pS:Str10):Str200;
  function  ConvNum99     (pS:Str10):Str200;
  function  ConvNum999    (pS:Str10):Str200;

implementation

  FUNCTION   ConvNumToText;
    var
      mFrac:string;
      mInt :string;
      mNum :string;
      mS   :string;
      mN   :byte;
      mANum:double;
    BEGIN
      mFrac := '';
      mInt  := '';
      mANum := abs(pNum);
      If mANum>=0 then begin
        If Frac (mANum)>0 then mFrac := '  '+StrInt (Round (Frac (mANum)*100),0)+'/100';
        Str (Trunc (mANum),mNum);
        If ValInt (mNum)=0
        then mInt := c0
        else begin
  {miliard}
          If Length (mNum)>=10 then begin
            mS := Copy (mNum,1,Length (mNum)-9);
            If ValInt (mS)<100 then begin
              mN := ValInt (mS);
              case mN of
                1: mInt := mInt+c1000000000;
                2: mInt := mInt+c2000000000;
                3: mInt := mInt+c3000000000;
                4: mInt := mInt+c4000000000;
                else mInt := mInt+ConvNum999 (mS)+cx000000000;
              end;
            end;
            Delete (mNum,1,Length (mNum)-9);
          end;
  {miliony}
          If (Length (mNum)>=7) and (ValInt (mNum)>0) then begin
            mS := Copy (mNum,1,Length (mNum)-6);
            If ValInt (mS)<=4 then begin
              mN := ValInt (mS);
              case mN of
                1: mInt := mInt+c1000000;
                2: mInt := mInt+c2000000;
                3: mInt := mInt+c3000000;
                4: mInt := mInt+c4000000;
              end;
            end else mInt := mInt+ConvNum999 (mS)+cx000000;
            Delete (mNum,1,Length (mNum)-6);
          end;
  {tisicky}
          If (Length (mNum)>=4) and (ValInt (mNum)>0) then begin
            mS := Copy (mNum,1,Length (mNum)-3);
            If ValInt (mS)=1
            then mInt := mInt+c1000
            else mInt := mInt+ConvNum999 (mS)+c1000;
            Delete (mNum,1,Length (mNum)-3);
          end;
  {stovky}
          If (Length (mNum)<=3) and (ValInt (mNum)>0) then begin
            mInt := mInt+ConvNum999 (mNum);
            Delete (mNum,1,1);
          end;

        end;
      end;
      if pNum>0 then ConvNumToText := mInt+mFrac else ConvNumToText := '-'+mInt+mFrac;
    END;     { *** ConvNumToText *** }

  FUNCTION   CopyLastNum;
    BEGIN
      CopyLastNum := Copy (pS,Length (pS),1);
    END;     { *** CopyLastNum *** }

  FUNCTION   ConvNum19;
    var
      mN:byte;
      mS:string;
    BEGIN
      mS := '';
      mN := ValInt (pS);
      case mN of
        1: mS := c1;
        2: mS := c2;
        3: mS := c3;
        4: mS := c4;
        5: mS := c5;
        6: mS := c6;
        7: mS := c7;
        8: mS := c8;
        9: mS := c9;
       10: mS := c10;
       11: mS := c11;
       12: mS := c12;
       13: mS := c13;
       14: mS := c14;
       15: mS := c15;
       16: mS := c16;
       17: mS := c17;
       18: mS := c18;
       19: mS := c19;
      end;
      ConvNum19 := mS;
    END;     { *** ConvNum19 *** }

  FUNCTION   ConvNum99;
    var
      mN:byte;
      mS:string;
    BEGIN
      mS := '';
      mN := ValInt (pS);
      case mN of
         1..19: mS := ConvNum19 (pS);
            20: mS := c20;
        21..29: mS := c20+ConvNum19 (CopyLastNum (pS));
            30: mS := c30;
        31..39: mS := c30+ConvNum19 (CopyLastNum (pS));
            40: mS := c40;
        41..49: mS := c40+ConvNum19 (CopyLastNum (pS));
            50: mS := c50;
        51..59: mS := c50+ConvNum19 (CopyLastNum (pS));
            60: mS := c60;
        61..69: mS := c60+ConvNum19 (CopyLastNum (pS));
            70: mS := c70;
        71..79: mS := c70+ConvNum19 (CopyLastNum (pS));
            80: mS := c80;
        81..89: mS := c80+ConvNum19 (CopyLastNum (pS));
            90: mS := c90;
        91..99: mS := c90+ConvNum19 (CopyLastNum (pS));
      end;
      ConvNum99 := mS;
    END;     { *** ConvNum99 *** }

  FUNCTION   ConvNum999;
    var
      mN:byte;
      mS:Str100;
    BEGIN
      mN := ValInt (Copy (pS,1,1));
      mS := '';
      If Length (pS)=3 then begin
        case mN of
          1: mS := mS+cx00;
          2: mS := mS+c200;
          3..9: mS := mS+ConvNum19 (Copy (pS,1,1))+cx00;
        end;
        Delete (pS,1,1);
      end;
      mS := mS+ConvNum99 (pS);
      ConvNum999 := mS;
    END;     { *** ConvNum999 *** }

end.