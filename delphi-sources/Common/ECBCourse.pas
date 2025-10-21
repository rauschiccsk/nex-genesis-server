unit ECBCourse;

interface

  uses
    IcConv,
    IdHTTP, XMLDoc, XMLIntf,
    DateUtils, Classes, SysUtils, Controls;


  type
    TECBCourse = class

    private
      oError    : byte;
      IdHTTP    : TIdHTTP;
      XMLDoc    : TXMLDocument;

      function    GetRate(pDate:TDate; pCurrency:string):double;
      function    CompareDate (pDate:TDate; pSDate:string;var pEqual:boolean):boolean;

    public
      constructor Create;
      destructor  Destroy; override;

      function    ReadCourse (pDateF:TDate):boolean;

      property    Rate[pDate:TDate; pCurrency:string]:double read GetRate;
      property    Error:byte read oError;
                  // 0 - OK
                  // 1 - Chybý dátum
                  // 2 - Chybná mena
                  // 3 - Kurzový lístok nebol naèítaný
                  // 4 - Vseobecná chyba
    end;

implementation

function    TECBCourse.GetRate(pDate:TDate; pCurrency:string):double;
var mDateNode, mNode:IXMLNode; mDateNodeCnt,mCurrNodeCnt:longint;
  mSDate, mCurr, mRate:string; mFind,mOK, pEqual:boolean;
begin
  Result := 0; mOK := FALSE; mFind := FALSE;
  If XMLDoc.Active then begin
    oError := 4;
    try
      mDateNode := XMLDoc.DocumentElement.ChildNodes.Get(2);
    except end;
    If mDateNode<>nil then begin
      mDateNodeCnt := 0;
      Repeat
        mSDate := mDateNode.ChildNodes.Get(mDateNodeCnt).Attributes['time'];
        If CompareDate (pDate, mSDate, pEqual) then begin
          If pEqual then Inc (mDateNodeCnt);
          mOK := TRUE;
          mCurrNodeCnt := 0;
          try
            mNode := mDateNode.ChildNodes.Get(mDateNodeCnt);
          except end;
          If (mNode<>nil) and (mNode.ChildNodes.Count>0) then begin
            Repeat
              try
                mCurr := mNode.ChildNodes.Get(mCurrNodeCnt).Attributes['currency'];
              except end;
              If mCurr=pCurrency then begin
                try
                  mRate := mNode.ChildNodes.Get(mCurrNodeCnt).Attributes['rate'];
                except end;
                Result := ValDoub(mRate);
                mFind := TRUE;
                oError := 0;
              end else Inc (mCurrNodeCnt);
            until (mCurrNodeCnt>=mNode.ChildNodes.Count) or mFind;
            If not mFind then oError := 1;
          end;
        end else Inc (mDateNodeCnt);
      until (mDateNodeCnt>=mDateNode.ChildNodes.Count) or mOK;
      If not mOK then oError := 2;
    end;
  end else oError := 3;
end;

function    TECBCourse.CompareDate (pDate:TDate; pSDate:string;var pEqual:boolean):boolean;
var mSDate:TDate; mD,mM,mY:word;
begin
  mY := ValInt (Copy (pSDate,1,4));
  mM := ValInt (Copy (pSDate,6,2));
  mD := ValInt (Copy (pSDate,9,2));
  mSDate := EncodeDate(mY, mM, mD);
  pEqual := (pDate=mSDate);
  Result := (pDate>=mSDate);
end;

constructor TECBCourse.Create;
begin
  IdHTTP := TIdHTTP.Create;
  IdHTTP.Request.UserAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';
  XMLDoc := TXMLDocument.Create(TComponent.Create(nil));
  oError := 0;
end;

destructor  TECBCourse.Destroy;
begin
  XMLDoc.Active := FALSE;
  FreeAndNil (XMLDoc);
  FreeAndNil (IdHTTP);
end;

function    TECBCourse.ReadCourse (pDateF:TDate):boolean;
var mS, mURL:string;
begin
  oError := 0;
  If (DaySpan(Date, pDateF)>89)
    then mURL := 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml'
    else mURL := 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml';
  try
    mS := IdHTTP.Get(mURL);
  except end;
  If mS<>'' then begin
    try
      XMLDoc.Active := FALSE;
      XMLDoc.XML.Clear;
      XMLDoc.XML.Add(mS);
      XMLDoc.Active := TRUE;
      Result := XMLDoc.Active;
    except end;
  end;
  If not Result then oError := 3;
end;

end.
