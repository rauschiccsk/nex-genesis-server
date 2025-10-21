unit DatabankingSLSP;

interface

  uses
    IcTypes, IcConv, IcTools,Dialogs,
    IdHTTP, IdSSLOpenSSL, IdException, XMLDoc, 
    DateUtils, Classes, SysUtils, Forms;

  const
    cWriteLogFile: boolean = TRUE;

  type
    TAccounts = array [1..20] of record
                  Id               :Str12; //id ��tu
                  Iban             :Str20; //IBAN ��tu
                  AccType          :Str10; //typ ��tu
                  Name             :Str30; //n�zov ��tu
                  Name_www         :Str30; //n�zov ��tu pre www
                  Prefix           :Str10; //pred��slo ��tu
                  Number           :Str10; //��slo ��tu
                  Currency         :Str3;  //mena
                  Balance          :Str10; //��tovn� zostatok
                  MinBalance       :Str10; //minim�lny zostatok
                  DispBalanceEUR   :Str10; //disponibiln� zostatok v euro
                  Rate             :Str10; //kurz pou�it� na prepo�et do euro
                  DispBalance      :Str10; //disponibiln� zostatok
                  Prohibitions     :Str10; //suma z�kazov
                  Pledge           :Str10; //suma vinkul�ci�
                  Rezervations     :Str10; //suma rezerv�ci�
                  Blocking         :Str10; //suma blok�ci�
                  Date             :Str20; //d�tum zostatku
                  LastTurnover     :Str20; //posledn� pohyb
                end;

    TTurnOver = array [1..5000] of record
                  Value     : double;   //suma
                  TransDate : TDateTime;//d�tum transakcie
                  Prefix    : Str10;    //pred��slo proti��tu
                  Account   : Str20;    //��slo proti��tu
                  BankCode  : Str4;     //k�d banky
                  Name      : Str30;    //n�zov proti��tu
                  CSymb     : Str10;    //kon�tantn� symbol
                  VSymb     : Str10;    //variabiln� symbol
                  SSymb     : Str10;    //�pecifick� symbol
                  Note      : Str30;    //poznamka
                  TType     : byte;     //typ obratu pozri ��seln�k typy obratov
                                        //(0 -Ostatn�, 1 - Poplatky, 2 - Kartov� oper�cie, 3 - Pr�kazy cez Telebanking, 4 - ZPS
                  Rate      : double;   //kurz
                  Balance   : double;   //zostatok
                  Statement : longint;  //��slo v�pisu
                end;

    TPayList = array [1..500] of record
                  Id        : Str10;   //id polo�ky
                  Status    : Str10;   //stav
                  Prefix    : Str10;    //pred��slo proti��tu
                  Account   : Str20;    //��slo proti��tu
                  BankCode  : Str4;     //k�d banky
                  CSymb     : Str10;     //kon�tantn� symbol
                  VSymb     : Str10;    //variabiln� symbol
                  SSymb     : Str10;    //�pecifick� symbol
                  Value     : double;   //suma
                  Currency  : Str3;     //mena
                  Note      : Str30;    //poznamka
               end;


    TCertData = record
                  FromAcc: Str10;  // z ��tu
                  ToAcc  : Str20;  // na ��et
                  SSymb  : Str10;  // �pecifick� symbol
                  Value  : Str15;  // suma
                  OPCode : Str10;  // k�d oper�cie
                end;

    TDatabankingSLSP = class (TComponent)

    private
      IdHTTP          : TIdHTTP;
      IdSSLIOHSOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
      XMLDoc          : TXMLDocument;

      oUserID         : Str20;
      oTap            : byte;
      oAutc           : Str20;
      oAc             : Str20;
      oPwd            : Str20;
      oLng2           : Str5;

      oAccTitle       : Str30;
      oAccName        : Str30;
      oAccSurname     : Str30;
      oErrID          : string;
      oErrText        : string;

      oAccQnt         : byte;
      oTurnOverQnt    : longint;
      oPayListQnt     : longint;

      oAddPay_Prefix  :string;
      oAddPay_Number  :string;
      oAddPay_BankCode:string;
      oAddPay_CSymb   :string;
      oAddPay_VSymb   :string;
      oAddPay_SSymb   :string;
      oAddPay_Value   :double;
      oAddPay_Currency:string;
      oAddPay_Note    :string;
      oAddPay_ActPay  :boolean;
      oAddPay_Date    :TDateTime;
      oAddPay_Cancel  :boolean;
      oAddPay_Repeat  :boolean;
      oAddPay_RepeatDay:byte;
      oAddPay_Quick   :boolean;
      oDefDelay       : longint;

      procedure Delay (pMSec:longint);
      function  FindAccountNum (pAccNum:string):byte;
      function  GetHTTPS (pS:string):string;

      procedure WriteToLog (pCom,pAns:string);
    public
      oAccounts       : TAccounts;
      oTurnOver       : TTurnOver;
      oPayList        : TPayList;
      oCertData       : TCertData;

      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      function  Inintialization:boolean;   //inicializ�cia komunik�cie
      function  Login:boolean;             //Prihl�senie do Internetbankingu
      function  AccountList:boolean;       //Preh�ad ��tov
      function  AccInfo (pAccNum:string):boolean; //V�ber ��tu

      function  TurnOvers (pFDate,pLDate:TDateTime):boolean; //Preh�ad obratov

      function  InitPay:boolean;           //Inicializ�cia zadania hrmadnej platby
      procedure SetDefPayData;             //Nastav� z�kladn� parametre
      function  AddPay:boolean;            //Pridanie
      function  ReadPayList:boolean;       //zoznam platieb ur�en�ch na hromadn� podp�sanie
      function  CertVerify:boolean;        //na��tanie kontroln�ch �dajov na certifik�ciu
      function  Certifycation:boolean;     //certifik�cia hromadnej platby

      function  Logout:boolean;
    published
      property UserID:Str20 read oUserID write oUserID;   //identifika�n� ��slo klienta
      property Tap:byte read oTap write oTap;             //druh autentifik�cie (eok=1, password=2) default "1"
      property Autc:Str20 read oAutc write oAutc;         //EOK k�d v pr�pade tap=1
      property Ac:Str20 read oAC write oAc;               //pr�zdny parameter, pr�padne hodnota synchroniza�n�ho po��tadla pre EOK (nepovinne)
      property Pwd:Str20 read oPwd write oPwd;            //heslo v pr�pade tap=2
      property Lng2:Str5 read oLng2 write oLng2;          //vo�ba jazyka, texty bud� vo zvolenom jazyku, neovplyv�uje n�zvy elementov v xml. Povolen� hodnoty s� "en", "sk" a pr�zdna hodnota (predvolen� jazyk klienta). default "sk"

      property AccTitle:Str30 read oAccTitle write oAccTitle;       //Titul
      property AccName:Str30 read oAccName write oAccName;          //Meno
      property AccSurname:Str30 read oAccSurname write oAccSurname; //Priezvisko

      property ErrID:string read oErrId write oErrID;               //K�d chybov�ho hl�senia
      property ErrText:string read oErrtext write oErrText;         //Text chybov�ho hl�senia

      property AccQnt:byte read oAccQnt write oAccQnt;                   //Po�et ��tov
      property TurnOverQnt:longint read oTurnOverQnt write oTurnOverQnt; //Po�et na��tan�ch obratov�ch pohybov
      property PayListQnt:longint read oPayListQnt write oPayListQnt;    //Po�et na��tan�ch �hrad pre certifik�ciu

      //pridanie platby
      property AddPay_Prefix:string read oAddPay_Prefix write oAddPay_Prefix; //pred��slo ��tu
      property AddPay_Number:string read oAddPay_Number write oAddPay_Number; //��slo ��tu
      property AddPay_BankCode:string read oAddPay_BankCode write oAddPay_BankCode; //k�d banky
      property AddPay_CSymb:string read oAddPay_CSymb write oAddPay_CSymb; //kon�tantn� symbol
      property AddPay_VSymb:string read oAddPay_VSymb write oAddPay_VSymb; //variabiln� symbol
      property AddPay_SSymb:string read oAddPay_SSymb write oAddPay_SSymb; //�pecifick� symbol
      property AddPay_Value:double read oAddPay_Value write oAddPay_Value; //suma
      property AddPay_Currency:string read oAddPay_Currency write oAddPay_Currency; //mena
      property AddPay_Note:string read oAddPay_Note write oAddPay_Note; //pozn�mka
      property AddPay_ActPay:boolean read oAddPay_ActPay write oAddPay_ActPay; //typ �hrady (Aktu�lny - Bud�ci)
      property AddPay_Date:TDateTime read oAddPay_Date write oAddPay_Date; //d�tum valuty
      property AddPay_Cancel:boolean read oAddPay_Cancel write oAddPay_Cancel; //pr�znak odvolate�n�
      property AddPay_Repeat:boolean read oAddPay_Repeat write oAddPay_Repeat; //pr�znak po�et opakovan�
      property AddPay_RepeatDay:byte read oAddPay_RepeatDay write oAddPay_RepeatDay; //po�et dn� pri opakovan�
      property AddPay_Quick:boolean read oAddPay_Quick write oAddPay_Quick; //zr�chlen� platba
    end;

implementation

uses XMLIntf;

procedure TDatabankingSLSP.Delay (pMSec:longint);
var mTime:TDateTime;
begin
  mTime := IncMilliSecond (Now, pMSec);
  While Now<mTime do begin
    Application.ProcessMessages;
  end;
end;

function  TDatabankingSLSP.FindAccountNum (pAccNum:string):byte;
var mCnt:byte;
begin
  Result := 0;
  pAccNum := AlignLeftBy (pAccNum, 10, '0');
  If oAccQnt>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
    until (mCnt>=oAccQnt) or (pAccNum=oAccounts[mCnt].Number);
    If pAccNum=oAccounts[mCnt].Number then Result := mCnt;
  end;
end;

function  TDatabankingSLSP.GetHTTPS (pS:string):string;
var mCnt:longint; mOK:boolean; mS:string;
begin
  mCnt := 0;
  Repeat
    mOK := TRUE;
    Delay (oDefDelay);
    try
      mS := IdHTTP.Get (pS);
    except
      on EIdConnClosedGracefully do mOK := FALSE;
    end;
    If not mOK then Delay (oDefDelay);
    Inc (mCnt);
  until mOK or (mCnt>10);
  If mOK
    then Result := mS
    else Result := '';
end;

procedure TDatabankingSLSP.WriteToLog (pCom,pAns:string);
var mT:TextFile; mFile:string;
begin
  mFile := ExtractFilePath(ParamStr (0))+'BANKING.TXT';
  AssignFile (mT,mFile);
  If FileExists(mFile)
    then Append (mT)
    else Rewrite (mT);
  WriteLn (mT,'');
  WriteLn (mT,pCom);
  WriteLn (mT,pAns);
  CloseFile (mT);
end;

constructor TDatabankingSLSP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  IdSSLIOHSOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  IdHTTP := TIdHTTP.Create;
  IdHTTP.Request.UserAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';
  IdHTTP.IOHandler := IdSSLIOHSOpenSSL;
  IdSSLIOHSOpenSSL.SSLOptions.Method:=sslvTLSv1;     // Opravene dna 02.10.2014
//  IdSSLIOHSOpenSSL.SSLOptions.Method := sslvSSLv3;

  XMLDoc := TXMLDocument.Create(Self);

  oUserID := '';
  oTap := 1;
  oAutc := '';
  oAc := '';
  oPwd := '';
  oLng2 := 'sk';

  oDefDelay := 50;
end;

destructor  TDatabankingSLSP.Destroy;
begin
  XMLDoc.Active := FALSE;
  FreeAndNil (XMLDoc);
  FreeAndNil (IdHTTP);
  FreeAndNil (IdSSLIOHSOpenSSL);

  inherited Destroy;
end;

function  TDatabankingSLSP.Inintialization:boolean;
var mS,mErr:string;
begin
  mErr := '';
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/ibxindex.xml');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/ibxindex.xml', mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mErr := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0).NodeName;
    except end;
    XMLDoc.Active := FALSE;
  except end;
  Result := (mErr='ok');
end;

function  TDatabankingSLSP.Login:boolean;
var mS, mRes:string;
  ANode: IXMLNode;
begin
  Result := FALSE;
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/login/ibxlogin.xml?user_id='+oUserID+'&tap='+StrInt(oTap,0)+'&autc='+oAutc+'&ac='+oAc+'&pwd='+oPwd+'&lng2='+oLng2);
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/login/ibxlogin.xml?user_id='+oUserID+'&tap='+StrInt(oTap,0)+'&autc='+oAutc+'&ac='+oAc+'&pwd='+oPwd+'&lng2='+oLng2, mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
      If mRes='result' then begin
        ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
        oAccTitle := ANode.ChildNodes['title'].Text;
        oAccName := ANode.ChildNodes['name'].Text;
        oAccSurname := ANode.ChildNodes['surname'].Text;
        oErrID := '';
        oErrText := '';
        Result := TRUE;
      end else begin
        If mRes='error' then begin
          ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
          oErrID := ANode.ChildNodes['id'].Text;
          oErrText := ANode.ChildNodes['text'].Text;
        end;
      end;
    except end;
    XMLDoc.Active := FALSE;
  except end;
end;

function  TDatabankingSLSP.AccountList:boolean;
var mS:string; ANode: IXMLNode; mCnt:byte;
begin
  Result := FALSE;
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/accounts/ibxaccounts.xml');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/accounts/ibxaccounts.xml', mS);
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
// Star� sp�sob. Zmenili to  cca. od 1.4.2007
//    ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);

    ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(1);
    oAccQnt := 0;
    If ANode<>nil then begin
      Result := TRUE;
      oAccQnt := ANode.ChildNodes.Count;
      ANode := ANode.ChildNodes.Get(0);
      mCnt := 0;
      Repeat
        Inc (mCnt);
        oAccounts[mCnt].Id := ANode.ChildNodes['account-id'].Text;
        oAccounts[mCnt].Iban := ANode.ChildNodes['account-iban'].Text;
        oAccounts[mCnt].AccType := ANode.ChildNodes['account-type'].Text;
        oAccounts[mCnt].Name := ANode.ChildNodes['account-name'].Text;
        oAccounts[mCnt].Name_www := ANode.ChildNodes['account-name-www'].Text;
        oAccounts[mCnt].Prefix := ANode.ChildNodes['account-prefix'].Text;
        oAccounts[mCnt].Number := ANode.ChildNodes['account-number'].Text;
        oAccounts[mCnt].Currency := ANode.ChildNodes['currency'].Text;
        oAccounts[mCnt].Balance := ANode.ChildNodes['balance'].Text;
        oAccounts[mCnt].MinBalance := ANode.ChildNodes['min-balance'].Text;
        oAccounts[mCnt].DispBalanceEUR := ANode.ChildNodes['disp_balance_eur'].Text;
        oAccounts[mCnt].Rate := ANode.ChildNodes['rate'].Text;
        oAccounts[mCnt].DispBalance := ANode.ChildNodes['disponible-balance'].Text;
        oAccounts[mCnt].Prohibitions := ANode.ChildNodes['prohibitions'].Text;
        oAccounts[mCnt].Pledge := ANode.ChildNodes['pledge'].Text;
        oAccounts[mCnt].Rezervations := ANode.ChildNodes['rezervations'].Text;
        oAccounts[mCnt].Blocking := ANode.ChildNodes['blocking'].Text;
        oAccounts[mCnt].Date := ANode.ChildNodes['date'].Text;
        oAccounts[mCnt].LastTurnover := ANode.ChildNodes['last-turnover'].Text;
        ANode := ANode.NextSibling;
      until ANode = nil;
    end;
    XMLDoc.Active := FALSE;
  except end;
end;

function  TDatabankingSLSP.AccInfo (pAccNum:string):boolean;
var mCnt:byte; mS,mRes:string; ANode: IXMLNode;
begin
  Result := FALSE;
  mCnt := FindAccountNum (pAccNum);
  If mCnt>0 then begin
    try
      mS := GetHTTPS ('https://ib.slsp.sk/ebanking/accinfo/ibxaccinfo.xml?uid='+oAccounts[mCnt].Id+'&utyp='+oAccounts[mCnt].AccType+'&ucis='+oAccounts[mCnt].Number+'&uprcis='+oAccounts[mCnt].Prefix);
      If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/accinfo/ibxaccinfo.xml?uid='+oAccounts[mCnt].Id+'&utyp='+oAccounts[mCnt].AccType+'&ucis='+oAccounts[mCnt].Number+'&uprcis='+oAccounts[mCnt].Prefix, mS);
//                                                  accinfo/ibxaccinfo.xml?uid=930002740319          &utyp=0                          &ucis=0182250886                &uprcis=000000

      XMLDoc.Active := FALSE;
      XMLDoc.XML.Clear;
      XMLDoc.XML.Add(mS);
      XMLDoc.Active := TRUE;
      try
        mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
        If mRes='result' then begin
          ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
          oErrID := '';
          oErrText := '';
          Result := TRUE;
        end else begin
          If mRes='error' then begin
            ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
            oErrID := ANode.ChildNodes['id'].Text;
            oErrText := ANode.ChildNodes['text'].Text;
          end;
        end;
      except end;
      XMLDoc.Active := FALSE;
    except end;
  end;
end;

function  TDatabankingSLSP.TurnOvers (pFDate,pLDate:TDateTime):boolean;
var mS,mS1,mS2,mSCom,mErr,mRes:string; mCnt,J:longint;    mText:Str20;
  StartItemNode, ANode : IXMLNode;
  mFDate,mLDate:string; mEnd:boolean;
begin
  mErr := '';
  try
    mFDate := ReplaceStr (DateToStr (pFDate),' ','');
    mLDate := ReplaceStr (DateToStr (pLDate),' ','');
    mEnd := FALSE;
    mS1 := 'https://ib.slsp.sk/ebanking/accto/ibxtofilter.xml?no_f_no_do='+mLDate+'&no_f_no_od='+mFDate+'&no_s_how_much=show10&'
          +'no_f_predcislo=&no_f_cislo=&no_f_banka=&no_f_vs=&no_f_ks=&no_f_ss=&no_f_amount1=&no_f_amount2=&no_c_poplatky=1&'
          +'dir=';
    mS2 := '&no_s_amounts=amntnone&no_c_karty=1&no_c_ebprik=1&no_c_ostatne=1&no_c_kreditne=1&no_c_debetne=1&'
          +'no_c_zps=1&no_c_tps=1&no_c_prior=1&currency=all';
    mSCom := '';
    mCnt := 0;
    Repeat
      mS := GetHTTPS (mS1+mSCom+mS2);
      If cWriteLogFile then WriteToLog (mS1+mSCom+mS2, mS);
      XMLDoc.XML.Clear;
      XMLDoc.XML.Add(mS);
      XMLDoc.Active := TRUE;
      mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
      If mRes='result' then begin
// Star� sp�sob. Zmenili to  cca. od 1.4.2007
//       StartItemNode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
        StartItemNode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(1);
        oTurnOverQnt := StartItemNode.ChildNodes.Count;
        J := 0;
        Repeat
          ANode := StartItemNode.ChildNodes.Get(J);
          oTurnOver[mCnt+1].Value := ValDoub (ANode.ChildNodes['amount'].Text);
          oTurnOver[mCnt+1].TransDate := StrToDateTime (ANode.ChildNodes['trans-date'].Text);
          oTurnOver[mCnt+1].Prefix := ANode.ChildNodes['counter-prefix'].Text;
          oTurnOver[mCnt+1].Account := ANode.ChildNodes['counter-account'].Text;
          oTurnOver[mCnt+1].BankCode := ANode.ChildNodes['counter-bank'].Text;
          oTurnOver[mCnt+1].Name := ANode.ChildNodes['counter-name'].Text;
//          oTurnOver[mCnt+1].CSymb := Copy(ANode.ChildNodes['constant-symb'].Text,7,4);   // uz je to na 4 miesta
          oTurnOver[mCnt+1].CSymb := ANode.ChildNodes['constant-symb'].Text;
          oTurnOver[mCnt+1].VSymb := ANode.ChildNodes['variable-symb'].Text;
          oTurnOver[mCnt+1].SSymb := ANode.ChildNodes['spec-symb'].Text;
          oTurnOver[mCnt+1].Note := ANode.ChildNodes['note'].Text;
          oTurnOver[mCnt+1].TType := ValInt (ANode.ChildNodes['type'].Text);
          oTurnOver[mCnt+1].Rate := ValDoub (ANode.ChildNodes['rate'].Text);
          oTurnOver[mCnt+1].Balance := ValDoub (ANode.ChildNodes['balance'].Text);
          oTurnOver[mCnt+1].Statement := ValInt (ANode.ChildNodes['statement'].Text);
          Inc (mCnt); Inc (J);
        until (J>=oTurnOverQnt);
        If (oTurnOverQnt/10)<>(oTurnOverQnt div 10) then begin
          mEnd := TRUE;
          Result := TRUE;
        end;
      end else begin
        If mRes='error' then begin
          If mCnt>0 then begin
            mEnd := TRUE;
            Result := TRUE;
          end else begin
            mEnd := TRUE;
            ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
            oErrID := ANode.ChildNodes['id'].Text;
            oErrText := ANode.ChildNodes['text'].Text;
          end;
        end;
      end;
      mSCom := 'next';
    until mEnd;
    oTurnOverQnt := mCnt;
  except end;
end;

function  TDatabankingSLSP.InitPay:boolean;
var mS,mErr:string;
begin
  mErr := '';
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/payment/ibxpay.xml');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/payment/ibxpay.xml', mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mErr := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0).NodeName;
    except end;
    XMLDoc.Active := FALSE;
  except end;
  Result := (mErr='ok');
end;

procedure TDatabankingSLSP.SetDefPayData;
begin
  oAddPay_Prefix    := '';
  oAddPay_Number    := '';
  oAddPay_BankCode  := '';
  oAddPay_CSymb     := '';
  oAddPay_VSymb     := '';
  oAddPay_SSymb     := '';
  oAddPay_Value     := 0;
  oAddPay_Currency  := 'SKK';
  oAddPay_Note      := '';
  oAddPay_ActPay    := TRUE;
  oAddPay_Date      := 0;
  oAddPay_Cancel    := FALSE;
  oAddPay_Repeat    := FALSE;
  oAddPay_RepeatDay := 0;
  oAddPay_Quick     := FALSE;
end;

function  TDatabankingSLSP.AddPay:boolean;
var mS,mCom,mRes:string;
  mTypu, mDate, mCancel, mRepeat, mRepeatDay, mQuick:string;
  StartItemNode, ANode : IXMLNode;
  mId,mStatus,mAmount:string;
begin
  Result := FALSE;
    If oAddPay_ActPay
      then mTypu := '0' else mTypu := '2';
    If oAddPay_Date=0
      then mDate := '' else mDate := DateToStr (oAddPay_Date);
    If oAddPay_Cancel
      then mCancel := '1' else mCancel := '0';
    If oAddPay_Repeat
      then mRepeat := '1' else mRepeat := '0';
    If oAddPay_RepeatDay=0
      then mRepeatDay := '' else mRepeatDay := StrInt (oAddPay_RepeatDay,0);
    If oAddPay_Quick
      then mQuick := '1' else mQuick := '0';
    mCom := 'https://ib.slsp.sk/ebanking/payment/ibxmasspayadd.xml?pu_predcislo='+oAddPay_Prefix
          +'&pu_cislo='+oAddPay_Number
          +'&pu_kbanky='+oAddPay_BankCode
          +'&ks='+oAddPay_CSymb
          +'&vs='+oAddPay_VSymb
          +'&ss='+oAddPay_SSymb
          +'&suma='+StrDoub (oAddPay_Value,0,2)
          +'&mena='+oAddPay_Currency
          +'&poznamka='+oAddPay_Note
          +'&typu='+mTypu
          +'&datum_valuty='+mDate
          +'&odvol='+mCancel
          +'&opak='+mRepeat
          +'&opak_dni='+mRepeatDay
          +'&sprava_pre_banku=&pay_back='
          +'&zrpr='+mQuick
          +'&pa=1';
  If cWriteLogFile then WriteToLog ('!!!!!!!!', mCom);
  try
    mS := GetHTTPS (mCom);
    If cWriteLogFile then WriteToLog (mCom, mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
      If mRes='result' then begin
// Star� sp�sob. Zmenili to  cca. od 1.4.2007
//        ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0).ChildNodes.Get(0);
        ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(1).ChildNodes.Get(0);
        mId := ANode.ChildNodes['id'].Text;
        mStatus := ANode.ChildNodes['status'].Text;
        mAmount := ANode.ChildNodes['amount'].Text;
        oErrID := '';
        oErrText := '';
        Result := TRUE;
      end else begin
        If mRes='error' then begin
          ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
          oErrID := ANode.ChildNodes['id'].Text;
          oErrText := ANode.ChildNodes['text'].Text;
        end;
      end;
    except end;
    XMLDoc.Active := FALSE;
  except end;
end;

function  TDatabankingSLSP.ReadPayList:boolean;
var mS,mRes:string;
  StartItemNode, ANode : IXMLNode;
  I:longint;
begin
  Result := FALSE;
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/payment/ibxmasspaylist.xml');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/payment/ibxmasspaylist.xml', mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
      If mRes='result' then begin
// Star� sp�sob. Zmenili to  cca. od 1.4.2007
//        StartItemNode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
        StartItemNode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(1);
        oPayListQnt := StartItemNode.ChildNodes.Count-1;
        I := 1;
        Repeat
          ANode := StartItemNode.ChildNodes.Get(I);
          If ANode.NodeName='list' then begin
            oPayList[I].Id := ANode.ChildNodes['id'].Text;
            oPayList[I].Status := ANode.ChildNodes['status'].Text;
            oPayList[I].Prefix := ANode.ChildNodes['counter-prefix'].Text;
            oPayList[I].Account := ANode.ChildNodes['counter-account'].Text;
            oPayList[I].BankCode := ANode.ChildNodes['counter-bank'].Text;
            oPayList[I].CSymb := ANode.ChildNodes['constant-symb'].Text;
            oPayList[I].VSymb := ANode.ChildNodes['variable-symb'].Text;
            oPayList[I].SSymb := ANode.ChildNodes['spec-symb'].Text;
            oPayList[I].Value := ValDoub (ANode.ChildNodes['amount'].Text);
            oPayList[I].Currency := ANode.ChildNodes['currency'].Text;
            oPayList[I].Note := ANode.ChildNodes['notice'].Text;
          end;
          Inc (I);
        until I>oPayListQnt;
        oErrID := '';
        oErrText := '';
        Result := TRUE;
      end else begin
        If mRes='error' then begin
          ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
          oErrID := ANode.ChildNodes['id'].Text;
          oErrText := ANode.ChildNodes['text'].Text;
        end;
      end;
    except end;
    XMLDoc.Active := FALSE;
  except end;
end;

function  TDatabankingSLSP.CertVerify:boolean;
var mS,mRes:string;
  StartItemNode, ANode : IXMLNode;
begin
  Result := FALSE;
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/payment/ibxmasspayconf.xml?pa=1');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/payment/ibxmasspayconf.xml?pa=1', mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
      If mRes='result' then begin
// Star� sp�sob. Zmenili to  cca. od 1.4.2007
//        ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0).ChildNodes.Get(0);
        ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(1).ChildNodes.Get(1);
        oCertData.FromAcc := ANode.ChildNodes['from-account'].Text;
        oCertData.ToAcc := ANode.ChildNodes['to-account'].Text;
        oCertData.SSymb := ANode.ChildNodes['spec-symb'].Text;
        oCertData.Value := ANode.ChildNodes['amount'].Text;
        oCertData.OPCode := ANode.ChildNodes['operation-code'].Text;
        Result := TRUE;
      end else begin
        If mRes='error' then begin
          ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
          oErrID := ANode.ChildNodes['id'].Text;
          oErrText := ANode.ChildNodes['text'].Text;
        end;
      end;
    except end;
    XMLDoc.Active := FALSE;
  except end;
end;

function  TDatabankingSLSP.Certifycation:boolean;
var mS,mRes:string;
  StartItemNode, ANode : IXMLNode;
begin
  Result := FALSE;
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/payment/ibxmasspayconf2.xml?sign_1='+oAutc+'&eok_1='+oUserID+'&pa=1');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/payment/ibxmasspayconf2.xml?sign_1='+oAutc+'&eok_1='+oUserID+'&pa=1', mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    mRes := XMLDoc.DocumentElement.ChildNodes.Get(0).NodeName;
    If mRes='result' then begin
// Star� sp�sob. Zmenili to  cca. od 1.4.2007
//      ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
      ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(1);
      oErrID := ANode.ChildNodes['payment-result'].Text;
      oErrText := ANode.ChildNodes['text'].Text;
      Result := TRUE;
    end else begin
      If mRes='error' then begin
        ANode := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes.Get(0);
        oErrID := ANode.ChildNodes['id'].Text;
        oErrText := ANode.ChildNodes['text'].Text;
      end;
    end;
    XMLDoc.Active := FALSE;
  except end;
end;

function  TDatabankingSLSP.Logout:boolean;
var mS,mErr:string;
begin
  mErr := '';
  try
    mS := GetHTTPS ('https://ib.slsp.sk/ebanking/logout/ibxlogoutyes.xml');
    If cWriteLogFile then WriteToLog ('https://ib.slsp.sk/ebanking/logout/ibxlogoutyes.xml', mS);
    XMLDoc.Active := FALSE;
    XMLDoc.XML.Clear;
    XMLDoc.XML.Add(mS);
    XMLDoc.Active := TRUE;
    try
      mErr := XMLDoc.DocumentElement.ChildNodes.Get(0).ChildNodes['logout'].Text;
    except end;
    XMLDoc.Active := FALSE;
  except end;
  Result := (mErr='logout OK');
end;

end.
{MOD 1908001}
