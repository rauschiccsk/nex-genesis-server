unit NBSCourse;

interface

  uses
    IcConv, IcTypes,
    IdHTTP, XMLDoc, XMLIntf,
    Classes, SysUtils, Controls;

  type
    TData = array [1..100] of record
              Country: Str30;
              CCode  : Str3;
              Course : double;
            end;

    TNBSCourse = class (TComponent)
      IdHTTP    : TIdHTTP;
      XMLDoc    : TXMLDocument;

    private
      oFileName  :string;
      oCountryQnt:longint;
      oCourseDate:TDate;
      oNumber    :longint;
      oData      :TData;

      oCountry   :Str30;
      oCCode     :Str3;
      oCourse    :double;

      procedure  FillData;
    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      function  ReadActCourse:boolean;  //Naèíta posledné kurzy
      function  ReadCourse (pDate:TDateTime):boolean; //Naèíta kurzy na vybraný dátum

      function  FindByName (pCountry:string):boolean; //Vyh¾adá kurz pod¾a názvu štátu
      function  FindByCode (pCCode:string):boolean;   //Vyh¾adá kurz pod¾a kódu štátu
      function  FindByNum  (pNum:longint):boolean;    //Vyh¾adá kurz pod¾a poradového èísla

      procedure SaveCourseList (pPath:string);
    published
      property  FileName:string read oFileName write oFileName;
      property  CourseDate:TDate read oCourseDate write oCourseDate;
      property  CountryQnt:longint read oCountryQnt write oCountryQnt;
      property  Number:longint read oNumber write oNumber;

      property  Country:Str30 read oCountry write oCountry;
      property  CCode:Str3    read oCCode write oCCode;
      property  Course:double read oCourse write oCourse;
    end;

implementation

procedure  TNBSCourse.FillData;
var I:longint;  ANode : IXMLNode; mY,mM,mD:word;
  mS:string;
begin
  oNumber     := 0;
  oCourseDate := 0;

  oCountryQnt := 0;
  For I:=1 to 100 do begin
    oData[I].Country := '';
    oData[I].CCode := '';
    oData[I].Course := 0;
  end;
  ANode := XMLDoc.DocumentElement.ChildNodes.FindNode ('validFrom');
  If ANode<>nil then begin
    mS := ANode.NodeValue;
    mY := ValInt (Copy (mS,1,4));
    mM := ValInt (Copy (mS,6,2));
    mD := ValInt (Copy (mS,9,2));
    oFileName := 'KL'+Copy (StrInt (mY,0),3,2)+StrIntZero (mM,2)+StrIntZero (mD,2)+'.XML';
    oCourseDate := EncodeDate (mY,mM,mD);
  end;
  ANode := XMLDoc.DocumentElement.ChildNodes.FindNode ('number');
  If ANode<>nil then begin
    mS := ANode.NodeValue;
    oNumber := ValInt (mS);
  end;
  ANode := XMLDoc.DocumentElement.ChildNodes.FindNode ('rateList');
  If ANode<>nil then begin
    oCountryQnt := ANode.ChildNodes.Count;
    ANode := ANode.ChildNodes.Get(0);
    If oCountryQnt>0 then begin
      I := 0;
      Repeat
        Inc (I);
        try
          oData[I].Country := ANode.ChildNodes['country'].Text;
          oData[I].CCode := ANode.ChildNodes['ccyCode'].Text;
          oData[I].Course := ValDoub (ANode.ChildNodes['value'].Text)/ValDoub (ANode.ChildNodes['amount'].Text);
        except end;
        ANode := ANode.NextSibling;
      until ANode = nil;
    end;
  end;
end;

constructor TNBSCourse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  IdHTTP := TIdHTTP.Create;
  IdHTTP.Request.UserAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';

  XMLDoc := TXMLDocument.Create(Self);
end;

destructor  TNBSCourse.Destroy;
begin
  XMLDoc.Active := FALSE;
  FreeAndNil (XMLDoc);
  FreeAndNil (IdHTTP);

  inherited Destroy;
end;

function    TNBSCourse.ReadActCourse:boolean;
var mS:string;
begin
  mS := '';
  Result := FALSE;
  try
    mS := IdHTTP.Get('http://www.nbs.sk/KL/AKTKLSL.XML');
  except end;
  If mS<>'' then begin
    try
      XMLDoc.Active := FALSE;
      XMLDoc.XML.Clear;
      XMLDoc.XML.Add(mS);
      XMLDoc.Active := TRUE;
      FillData;
      XMLDoc.Active := FALSE;
      Result := TRUE;
    except end;
  end;
end;

function    TNBSCourse.ReadCourse (pDate:TDateTime):boolean;
var mY,mM,mD:word; mLink, mS:string; mSY,mSM,mSD:string;
begin
  DecodeDate(pDate, mY, mM, mD);
  mSY := StrIntZero (mY,4);
  mSM := StrIntZero (mM,2);
  mSD := StrIntZero (mD,2);
  mLink := 'http://www.nbs.sk/KL/KLSL'+mSY+'/KL'+Copy (mSY,3,2)+mSM+mSD+'.XML';
  mS := '';
  Result := FALSE;
  try
    mS := IdHTTP.Get(mLink);
  except end;
  If mS<>'' then begin
    try
      XMLDoc.Active := FALSE;
      XMLDoc.XML.Clear;
      XMLDoc.XML.Add(mS);
      XMLDoc.Active := TRUE;
      FillData;
      XMLDoc.Active := FALSE;
      Result := TRUE;
    except end;
  end;
end;

function  TNBSCourse.FindByName (pCountry:string):boolean;
var I:longint; mFind:boolean;
begin
  Result := FALSE;
  If oCountryQnt>0 then begin
    I := 0;
    Repeat
      Inc (I);
      mFind := (oData[I].Country=pCountry);
    until mFind or (I>=oCountryQnt);
    If mFind then begin
      oCountry  := oData[I].Country;
      oCCode    := oData[I].CCode;
      oCourse   := oData[I].Course;
      Result := TRUE;
    end;
  end;
end;

function  TNBSCourse.FindByCode (pCCode:string):boolean;
var I:longint; mFind:boolean;
begin
  Result := FALSE;
  If oCountryQnt>0 then begin
    I := 0;
    Repeat
      Inc (I);
      mFind := (oData[I].CCode=pCCode);
    until mFind or (I>=oCountryQnt);
    If mFind then begin
      oCountry  := oData[I].Country;
      oCCode    := oData[I].CCode;
      oCourse   := oData[I].Course;
      Result := TRUE;
    end;
  end;
end;

function  TNBSCourse.FindByNum  (pNum:longint):boolean;
begin
  Result := FALSE;
  If oCountryQnt>0 then begin
    If pNum in [1..oCountryQnt] then begin
      oCountry  := oData[pNum].Country;
      oCCode    := oData[pNum].CCode;
      oCourse   := oData[pNum].Course;
      Result    := TRUE;
    end;
  end;
end;

procedure TNBSCourse.SaveCourseList (pPath:string);
begin
  XMLDoc.Active := TRUE;
  XMLDoc.SaveToFile(pPath+oFileName);
  XMLDoc.Active := FALSE;
end;

end.
