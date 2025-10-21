unit Doc;
{$F+}

// *****************************************************************************
//                   FUNKCIE NA RIADENIE PRISTUPU  K DOKLADOM
// *****************************************************************************
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcVariab, NexMsg, NexGlob, NexError, hOPENDOC, tNOT,
  DocHand,
  ComCtrls, SysUtils, Classes, Forms, NexBtrTable, NexPxTable;

type
  TDoc = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
    public
      ohOPENDOC:TOpendocHnd;
      function Open(pDocNum:Str12):boolean; // Zaregistruje že doklad je otvorený
      procedure Close(pDocNum:Str12); // Vymaze zaznam o registracii ze doklad je otvoreny
      procedure DocLoc(pDocTbl:TNexBtrTable); // Uzamkne doklad na ktorom stoji kurzor v zadanej databaze
      procedure DocUnl(pDocTbl:TNexBtrTable); // Uzamkne doklad na ktorom stoji kurzor v zadanej databaze
    published
  end;

procedure ClrTbl(pTbl:TNexPxTable); // Vyprazdni zadany databazovy subor
procedure Notice(pBtr:TNexBtrTable;pTmp:TNexPxTable;pDocNum:Str12;pNotType:Str1);  // Nacita poznamky do docasneho suboru pre tlac
procedure DocLoc(pDocTbl:TNexBtrTable); // Uzamkne doklad na ktorom stoji kurzor v zadanej databaze
procedure DocUnl(pDocTbl:TNexBtrTable); // Uzamkne doklad na ktorom stoji kurzor v zadanej databaze

procedure LoadNotice(pBtr:TNexBtrTable;pLst:TStrings;pDocNum:Str12;pNotType:Str1); // Nacita poznamky do zoznamu TStrings
procedure SaveNotice(pBtr:TNexBtrTable;pLst:TStrings;pDocNum:Str12;pNotType:Str1); // Nacita poznamky do zoznamu TStrings

function NextSerNum(pYear:Str2;pHed:TNexBtrTable):word; // Nasledujuce volne cislo dokladu na konci zoznamu
function FreeItmNum(pItm:TNexBtrTable;pDocNum:Str12):word; // Prve volne cislo polozky
function NextItmNum(pItm:TNexBtrTable;pDocNum:Str12):word; // Nasledujuce volne cislo polozky na konci zoznamu
function CuttBokNum(pDocNum:Str12):Str5; // Funkcia vrati cislo knihy z cisla zadaneho dokladu

implementation

procedure ClrTbl(pTbl:TNexPxTable); // Vyprazdni zadany databazovy subor
begin
  While pTbl.RecordCount>0 do pTbl.Delete;
end;

procedure Notice (pBTR:TNexBtrTable;pTMP:TNexPxTable;pDocNum:Str12;pNotType:Str1); // Nacita poznamky do docasneho suboru pre tlac
var mLinNum:byte;
begin
  pBTR.IndexName := 'DoNtLn';
  If pBTR.FindKey ([pDocNum,pNotType,0]) then begin
    pTMP.Edit;
    Repeat
      mLinNum := pBTR.FieldByName ('LinNum').AsInteger;
      If mLinNum in [0..9] then begin
        If pBTR.FieldByName ('NotType').AsString=pNotType then begin
          pTMP.FieldByName ('Notice'+pNotType+StrInt(mLinNum,1)).AsString := pBTR.FieldByName ('Notice').AsString;
        end;
      end;
      pBTR.Next;
    until (pBTR.Eof) or (pBTR.FieldByName ('DocNum').AsString<>pDocNum);
    pTMP.Post;
  end;
end;

procedure LoadNotice(pBtr:TNexBtrTable;pLst:TStrings;pDocNum:Str12;pNotType:Str1); overload; // Nacita poznamky do zoznamu TStrings
begin
  pLst.Clear;
  pBTR.IndexName := 'DoNtLn';
  If pBTR.FindKey ([pDocNum,pNotType,0]) then begin
    Repeat
      If pBTR.FieldByName ('NotType').AsString=pNotType then pLst.Add(pBTR.FieldByName ('Notice').AsString);
      pBTR.Next;
    until (pBTR.Eof) or (pBTR.FieldByName ('DocNum').AsString<>pDocNum);
  end;
end;

procedure SaveNotice(pBtr:TNexBtrTable;pLst:TStrings;pDocNum:Str12;pNotType:Str1); // Nacita poznamky do zoznamu TStrings
var mLinNum:byte;
begin
  // Vymazeme poznamky daneho dokladu
  pBtr.SwapIndex;
  pBtr.IndexName := 'DocNum';
  If pBtr.FindKey([pDocNum]) then begin
    Repeat
      If pBTR.FieldByName ('NotType').AsString=pNotType
        then pBtr.Delete
        else pBtr.Next;
    until pBtr.Eof or (pBTR.FieldByName ('DocNum').AsString<>pDocNum);
  end;
  pBtr.RestoreIndex;
  // Ulozime poznamky do databazoveho suboru
  mLinNum := 0;
  If pLst.Count>0 then begin
    Repeat
      pBtr.Insert;
      pBTR.FieldByName ('DocNum').AsString := pDocNum;
      pBTR.FieldByName ('LinNum').AsInteger := mLinNum;
      pBTR.FieldByName ('NotType').AsString := pNotType;
      pBTR.FieldByName ('Notice').AsString := pLst.Strings[mLinNum];
      pBTR.Post;
      Inc(mLinNum);
    until mLinNum=pLst.Count;
  end;
end;

procedure DocLoc (pDocTbl:TNexBtrTable);
var mDoc:TDoc;
begin
  mDoc := TDoc.Create(nil);
  mDoc.DocLoc(pDocTbl);
  FreeAndNil(mDoc);
end;

procedure DocUnl (pDocTbl:TNexBtrTable);
var mDoc:TDoc;
begin
  mDoc := TDoc.Create(nil);
  mDoc.DocUnl(pDocTbl);
  FreeAndNil(mDoc);
end;

// ********************************** OBJEKT ***********************************

constructor TDoc.Create(AOwner: TComponent);
begin
  ohOPENDOC := TOpendocHnd.Create;   ohOPENDOC.Open;
end;

destructor TDoc.Destroy;
begin
  FreeAndNil (ohOPENDOC);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

function TDoc.Open(pDocNum:Str12):boolean; // Zaregistruje že doklad je otvorený
begin
  Result := FALSE;
  If not ohOPENDOC.LocateDocNum(pDocNum) then begin // Zaregistrujeme ze doklad je otvoreny
    ohOPENDOC.Insert;
    ohOPENDOC.DocNum := pDocNum;
    ohOPENDOC.UserName := gvSys.UserName;
    ohOPENDOC.OpenUser := gvSys.LoginName;
    ohOPENDOC.OpenDate := Date;
    ohOPENDOC.OpenTime := Time;
    ohOPENDOC.Post;
  end
  else begin // Ak doklad je otvoreny
    If ohOPENDOC.OpenUser<>gvSys.LoginName then begin
      Result := TRUE; // Doklad je otvoreny
      ShowMsg (ecSysDocIsUseAnyUser,ohOPENDOC.UserName);
    end
    else Result := FALSE; //Vstupuje do dokladu ten isty uzivatel, ktory uzatvoril
  end;
end;

procedure TDoc.Close(pDocNum:Str12); // Vymaze zaznam o registracii ze doklad je otvoreny
begin
  If ohOPENDOC.LocateDocNum(pDocNum) then ohOPENDOC.Delete;
end;

procedure TDoc.DocLoc(pDocTbl:TNexBtrTable); // Uzamkne doklad na ktorom stoji kurzor v zadanej databaze
begin
  If (pDocTbl.RecordCount>0) then begin
    If pDocTbl.FieldByName('DstLck').AsInteger=0 then begin
      If AskYes (aCom.YourCanLocDoc,'') then begin
        pDocTbl.Edit;
        pDocTbl.FieldByName('DstLck').AsInteger := 1;
        pDocTbl.Post;
      end;
    end
    else ShowMsg (eCom.ThisDocIsLoc,'');
  end;
end;

procedure TDoc.DocUnl(pDocTbl:TNexBtrTable); // Uzamkne doklad na ktorom stoji kurzor v zadanej databaze
begin
  If (pDocTbl.RecordCount>0) then begin
    If pDocTbl.FieldByName('DstLck').AsInteger=1 then begin
      If AskYes (aCom.YourCanUnlDoc,'') then begin
        pDocTbl.Edit;
        pDocTbl.FieldByName('DstLck').AsInteger := 0;
        pDocTbl.Post;
      end;
    end
    else ShowMsg (eCom.ThisDocIsUnl,'');
  end;
end;

function NextSerNum(pYear:Str2;pHed:TNexBtrTable):word; // Nasledujuce volne cislo dokladu na konci zoznamu
begin
  Result:=GetDocNextYearSerNum(pHed,pYear);
end;

function FreeItmNum(pItm:TNexBtrTable;pDocNum:Str12):word; // Prve volne cislo polozky
var mItmNum:word;  mFind:boolean;
begin
  Result := 0;
  pItm.SwapIndex;
  pItm.IndexName := 'DoIt';
  If pItm.FindKey([pDocNum,1]) then begin
    mItmNum := 0;
    Repeat
      Inc (mItmNum);
      mFind := mItmNum<pItm.FieldByName('ItmNum').AsInteger;
      If mItmNum>pItm.FieldByName('ItmNum').AsInteger then mItmNum := pItm.FieldByName('ItmNum').AsInteger;
      pItm.Next;
    until Eof or mFind or (pItm.FieldByName('DocNum').AsString<>pDocNum);
    If mFind
      then Result := mItmNum
      else Result := mItmNum+1;
  end
  else Result := 1;
  pItm.RestoreIndex;
end;

function NextItmNum(pItm:TNexBtrTable;pDocNum:Str12):word; // Nasledujuce volne cislo polozky na konci zoznamu
begin
  pItm.SwapIndex;
  pItm.IndexName := 'DoIt';
  If not pItm.FindNearest([pDocNum,65000]) then pItm.Last;
  If not pItm.IsLastRec or (pItm.FieldByName('DocNum').AsString<>pDocNum) then pItm.Prior;
  If pItm.FieldByName('DocNum').AsString=pDocNum
    then Result := pItm.FieldByName('ItmNum').AsInteger+1
    else Result := 1;
  pItm.RestoreIndex;
end;

function CuttBokNum(pDocNum:Str12):Str5; // Funkcia vrati cislo knihy z cisla zadaneho dokladu
begin
  Result := BookNumFromDocNum(pDocNum);
end;

end.


