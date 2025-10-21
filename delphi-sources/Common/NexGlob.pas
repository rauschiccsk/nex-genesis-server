unit NexGlob;

interface

uses
  IcTypes, IcConv, IcTools, IcDate, IcVariab, DocHead, TxtCut, NexPath, NexMsg, NexError,
  BtrTable, NexBtrTable, NexPxTable, NexPxbTable, SysUtils, Classes, Dialogs, Forms;

  function AskDelItm:boolean; // Dotaz ci vymazat danu polozku
  function DocVatGrp (pVatPrc,pVatPrc1,pVatPrc2,pVatPrc3,pVatPrc4:double): byte;
  // Urèí, že zadaná sadzba pVatPrc do ktorej skupiny patrí
  function VatQnt (pVatPrc1,pVatPrc2,pVatPrc3,pVatPrc4:byte): byte;
  // Hodnota funkcie je pocet pouzitych danovych skupin
  function VatGrp (pVatPrc:double): byte;
  // Urèí, že zadaná sadzba pVatPrc do ktorej skupiny patrí
  function VatKoef (pVatPrc:double): double;
  // Hodnota funkcie je koeficient DPH. Napr. Ak DPH je 23% koeficient bude 1.23
  function UserName (pLoginName:Str8):Str30; // Cele meno uzivatela
  function IsGsCode (pBarCode:Str15):boolean; // TRUE ak pBarCode obsahuje ciarku alebo bodku
  function BankCode (pContoNum:Str30):Str4; // Numericky smerovaci kod banky z cisla bankoveho uctu
  function BankConto (pContoNum:Str30):Str30; // Cislo bankoveho uctu  z cisla bankoveho uctu
  function MyContoFind (pContoNum:Str30):boolean; //
  function SelfDvzName (pDvzName:Str3):boolean; // TRUE ak zadana mena je uctovna mena
  function GetFgCourse (pDvzName:Str3; pDocDate:TDateTime; pFgCourse:double):double; // Vrati v pFgCourse z kurzoveho listku na dany datum
  function GetNameByCode (pTable:TNexBtrTable; pCode:longint; pIndexName,pFieldName:ShortString):ShortString; // Hodonotou funkcie je nazov polozky ktory je ulozeny pdo zadanym kodom

  function ElementExist (pLine,pElement:ShortString): boolean;
  function ElementValue (pLine,pIdent:ShortString): ShortString;
  function IdentExist (pLine,pIdent:ShortString): boolean; // TRUE ak v pLine existuje pIdent
  function IdentValue (pLine,pIdent:ShortString): ShortString; // pLine=IDENT[definicia] hodnota funkcia je text "definicia"

  procedure ChangeDocDate (pTable:TNexBtrTable;pIndexName,pDateField:Str20;pDocNum:Str12;pDocDate:TDateTime);  // Zmeni DocDate v zadanej tabulke pre zadany doklad
  procedure ChangeDateInPmi (pDocNum:Str12;pPayDate:TDateTime);  // Zmeni datum v denniku uhrad

  // Databazove operacie
  procedure DelFromDbLst (pFileName:Str12); // Vymaze zadany subor zo zoznamu DBLST

  function BtrInit (pTableName,pPath:ShortString;Sender:TComponent):TNexBtrTable; // Inicializácia pre BDF súbory
  function DatInit (pTabNam,pTabDir:ShortString;Sender:TComponent):TNexBtrTable;  // Inicializácia pre DDF súbory
  function TmpInit (pTableName:ShortString;Sender:TComponent):TNexPxTable;
  function PxbInit (pTableName,pPath:ShortString;Sender:TComponent):TNexPxbTable;
  procedure BTR_To_PX (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Premiestni polozky BTR s[boru do PX
  procedure ITM_To_PX (pBtTable:TNexBtrTable; pPxTable:TNexPxTable;pFgCourse:double); // Premiestni polozky BTR s[boru do PX

  procedure PX_To_BTR (pPxTable:TNexPxTable; pBtTable:TNexBtrTable); // Premiestni polozky BTR s[boru do PX
  procedure PX_To_PX (pPxTable1,pPxTable2:TNexPxTable); // Premiestni polozky PX s[boru do PX

  procedure ITM_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable; pDocNum:Str12); // Ulozi vseobecne polia poloziek do docasneho suboru
  procedure DOC_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi vseobecne polia hlaviciek do docasneho suboru
  procedure BTR_To_BTR (pScTable,pTgTable:TNexBtrTable);  // Ulozi identicke polia zo zdrojovej do celovej databaze
  procedure BTRT_To_BTRT(pScTable,pTgTable:TBtrieveTable);  // Ulozi identicke polia zo zdrojovej do celovej databaze
  procedure TXT_To_BTR (pFileName:ShortString;pTable:TNexBtrTable; pHead:TDocHead); // Nacita jeden rekord z textoveho suboru do databaze
  function  Ver_BTR_FldChg (pScTable,pTgTable:TNexBtrTable;pIndFld,pFld:String):String;  // Porovna dve tabulky na zadane polia

  function BookExist (pBookTable:TNexBtrTable;pBookNum:Str5):boolean;
  procedure GsCat_SearchFields (pType:byte;pCnt:integer;pFldname:Str30;pSrchStr:Str30;var pPositions: String;var pCount:longint;pUperCase:byte);

  procedure SetLoginNameGroup (pValue: Str20);
  function  LocateDocLastYearSerNum(pTable:TNexBtrTable;pYear:Str2):boolean;
  function  GetDocNextYearSerNum(pTable:TNexBtrTable;pYear:Str2):longint;
  function  GetDocFreeYearSerNum(pTable:TNexBtrTable;pYear:Str2):longint;
  function  LocateYearSerNum(pTable:TNexBtrTable;pYear:Str2;pSerNum:longint;pSwapIndex:boolean):boolean;
  function  LocateDocNum(pTable:TNexBtrTable;pDocNum:Str12;pSwapIndex:boolean):boolean;
  function  YearDocNumMod(pDocNum:Str12;pDate:TDateTime):boolean;

implementation

uses
  DM_SYSTEM, DM_DLSDAT, DM_STKDAT, DM_LDGDAT,
  DocHand, IBAN,
  NexVar, NexIni, BtrTools, DB;

procedure SetLoginNameGroup (pValue: Str20);
begin
  If not dmSYS.btUsrGrp.Active then dmSYS.btUsrGrp.Open;
  If dmSYS.btUSRLST.indexname<>'LoginName' then dmSYS.btUSRLST.indexname:='LoginName';
  If dmSYS.btUSRLst.FindKey([pValue]) then gvSys.LoginGroup:=dmSYS.btUSRLST.FieldByName('GrpNum').AsInteger;
  If (pValue='ADMIN')or(pValue='SADMIN')or(pValue='SERVICE') then begin
    gvSys.LoginGroup:=0;
    If not dmSYS.btUsrGrp.FindKey([gvSys.LoginGroup]) then begin
      // UsrGrp.bdf
      dmSYS.btUsrGrp.Insert;
      dmSYS.btUsrGrp.FieldByName ('GrpNum').AsInteger := 0;
      dmSYS.btUsrGrp.FieldByName ('GrpName').AsString := 'Administrator';
      dmSYS.btUsrGrp.FieldByName ('Language').AsString := gvSys.Language;
      dmSYS.btUsrGrp.FieldByName ('GrpLev').AsInteger := 0;
      dmSYS.btUsrGrp.FieldByName ('MaxDsc').AsInteger := 0;
      dmSYS.btUsrGrp.FieldByName ('MinPrf').AsInteger := 0;
      dmSYS.btUsrGrp.FieldByName ('DefSet1').AsInteger := 65535;
      dmSYS.btUsrGrp.FieldByName ('DefSet2').AsInteger := 65535;
      dmSYS.btUsrGrp.FieldByName ('DefSet3').AsInteger := 65535;
      dmSYS.btUsrGrp.FieldByName ('DefSet4').AsInteger := 255;
      dmSYS.btUsrGrp.Post;
    end;
  end;
  dmSYS.btUsrGrp.FindKey([gvSys.LoginGroup]);
end;

function AskDelItm:boolean; // Dotaz ci vymazat danu polozku
begin
  Result := AskYes (acSysYourCanDeleteItm,'');
end;

function DocVatGrp (pVatPrc,pVatPrc1,pVatPrc2,pVatPrc3,pVatPrc4:double): byte;
begin
  Result := 0;
  If pVatPrc=pVatPrc1 then Result := 1;
  If pVatPrc=pVatPrc2 then Result := 2;
  If pVatPrc=pVatPrc3 then Result := 3;
  If pVatPrc=pVatPrc4 then Result := 4;
end;

function VatQnt (pVatPrc1,pVatPrc2,pVatPrc3,pVatPrc4:byte): byte;
begin
  Result := 0;
  If pVatPrc1<>100 then Inc (Result);
  If pVatPrc2<>100 then Inc (Result);
  If pVatPrc3<>100 then Inc (Result);
  If pVatPrc4<>100 then Inc (Result);
end;

function VatGrp (pVatPrc:double): byte;
var I:byte;
begin
  Result := 0;
  If pVatPrc=0 then Result := 1;
  If pVatPrc=5 then Result := 2;
  If pVatPrc=19 then Result := 3;
  If pVatPrc=23 then Result := 4;
end;

function VatKoef (pVatPrc:double): double;
begin
  Result := 1+pVatPrc/100;
end;

function UserName (pLoginName:Str8):Str30; // Cele meno uzivatela
var mMyOp:boolean;
begin
  Result := pLoginName;
  mMyOp := not dmSYS.btUSRLST.Active;
  If mMyOp
    then dmSYS.btUSRLST.Open
    else dmSYS.btUSRLST.SwapStatus;
  If dmSYS.btUSRLST.IndexName<>'LoginName' then dmSYS.btUSRLST.IndexName := 'LoginName';
  If dmSYS.btUSRLST.FindKey ([pLoginName]) then Result := dmSYS.btUSRLST.FieldByName ('UserName').AsString;
  If mMyOp
    then dmSYS.btUSRLST.Close
    else dmSYS.btUSRLST.RestoreStatus;
end;

function IsGsCode (pBarCode:Str15):boolean; // TRUE ak pBarCode obsahuje ciarku alebo bodku
begin
  Result := (pBarCode[1]='.') or (pBarCode[1]=',');
end;

function BankCode (pContoNum:Str30):Str4; // Numericky smerovaci kod banky z cisla bankoveho uctu
var mPos:byte;mFind:boolean;mKTO,mBLZ,mSta:String;
begin
  Result := '';mFind:=False;
  If (Pos('/',pContoNum)=0)and not IsNumChar(pContoNum[1]) then begin
    mFind:=IsIban(pContoNum);
    If mFind then begin
      EncodeIBAN(pContoNum,mSta,mKTO,mBLZ);
      Result:=mBLZ;
    end;
  end;
  If not mFind then begin
    mPos := Pos('/',pContoNum);
    If mPos>0 then Result := copy (pContoNum,mPos+1,4);
  end;
end;

function BankConto (pContoNum:Str30):Str30; // Cislo bankoveho uctu  z cisla bankoveho uctu
var mPos:byte;
begin
  Result:=pContoNum;
  mPos:=Pos('/',pContoNum);
  If mPos>0 then Result:=copy(pContoNum,1,mPos-1);
end;

function MyContoFind (pContoNum:Str30):boolean; //
begin
  Result := False;
  If not dmSYS.btMYCONTO.Active then exit;
  dmSYS.btMYCONTO.First;
  while not Result and not dmSYS.btMYCONTO.Eof do begin
    Result:=(dmSYS.btMYCONTO.FieldByName('ContoNum').AsString=pContoNum)
         or (dmSYS.btMYCONTO.FieldByName('IbanCode').AsString=pContoNum);
    If not Result then dmSYS.btMYCONTO.Next;       
  end;
end;

function SelfDvzName (pDvzName:Str3):boolean; // TRUE ak zadana mena je uctovna mena
begin
  Result := UpString(pDvzName)=UpString(gIni.SelfDvzName);
end;

function GetFgCourse (pDvzName:Str3; pDocDate:TDateTime; pFgCourse:double):double; // Vrati v pFgCourse z kurzoveho listku na dany datum
var mMyOp:boolean;  mFieldName:Str3;
begin
  Result := pFgCourse;
  If IsNul(pFgCourse) then begin
    mMyOp := not dmLDG.btCRSHIS.Active;
    If mMyOp then dmLDG.btCRSHIS.Open;
    If dmLDG.btCRSHIS.IndexName<>'CrsDate' then dmLDG.btCRSHIS.IndexName := 'CrsDate';
    If dmLDG.btCRSHIS.FindKey([pDocDate]) then begin
      mFieldName := UpString(pDvzName);
      If dmLDG.btCRSHIS.FindField(mFieldName)<>nil then Result := dmLDG.btCRSHIS.FieldByName(mFieldName).AsFloat;
    end;
    If mMyOp then dmLDG.btCRSHIS.Close;
  end;
end;

function GetNameByCode (pTable:TNexBtrTable; pCode:longint; pIndexName,pFieldName:ShortString):ShortString; // Hodonotou funkcie je nazov polozky ktory je ulozeny pdo zadanym kodom
begin
  Result := '';
  If pTable.IndexName<>pIndexName then pTable.IndexName := pIndexName;
  If pTable.FindKey([pCode]) then Result := pTable.FieldByname (pFieldName).AsString;
end;

function ElementExist (pLine,pElement:ShortString): boolean;
var mCut:TTxtCut;  mCnt:byte;
begin
  Result := FALSE;
  If pLine<>'' then begin
    mCut := TTxtCut.Create;
    mCut.SetDelimiter('');  mCut.SetSeparator(',');
    mCut.SetStr(pLine);
    If mCut.Count>0 then begin
      mCnt := 0;
      Repeat
        Inc (mCnt);
        Result := UpString(mCut.GetText(mCnt))=UpString(pElement);
      until (mCnt>=mCut.Count) or Result;
    end;
  end;
end;

function ElementValue (pLine,pIdent:ShortString): ShortString;
var mCut:TTxtCut;  mCnt:byte;  mIdent,mValue:ShortString;
begin
  Result := '';
  If pLine<>'' then begin
    mCut := TTxtCut.Create;
    mCut.SetDelimiter('');  mCut.SetSeparator(',');
    mCut.SetStr(pLine);
    If mCut.Count>0 then begin
      mCnt := 0;
      Repeat
        Inc (mCnt);
        mIdent := LineElement (mCut.GetText(mCnt),0,'=');
        mValue := LineElement (mCut.GetText(mCnt),1,'=');
        If UpString(mIdent)=UpString(pIdent) then Result := mValue;
      until (mCnt>=mCut.Count) or (Result<>'');
    end;
  end;
end;

function IdentExist (pLine,pIdent:ShortString): boolean;
begin
  Result := Pos(pIdent,pLine)>0;
end;

function IdentValue (pLine,pIdent:ShortString): ShortString;
var mCut:TTxtCut;  mCnt:byte;  mIdent,mValue:ShortString;
begin
  Result := '';
  If pLine<>'' then begin
    mCut := TTxtCut.Create;
    mCut.SetDelimiter('');  mCut.SetSeparator(',');
    mCut.SetStr(pLine);
    If mCut.Count>0 then begin
      mCnt := 0;
      Repeat
        Inc (mCnt);
        If IdentExist (mCut.GetText(mCnt),pIdent) then begin
          mIdent := LineElement (mCut.GetText(mCnt),0,'=');
          mValue := LineElement (mCut.GetText(mCnt),1,'=');
        end;
        If UpString(mIdent)=UpString(pIdent) then Result := mValue;
      until (mCnt>=mCut.Count) or (Result<>'');
    end;
  end;
end;

procedure ChangeDocDate (pTable:TNexBtrTable;pIndexName,pDateField:Str20;pDocNum:Str12;pDocDate:TDateTime);  // Zmeni DocDate v zadanej tabulke pre zadany doklad
var mMyOp:boolean;
begin
  mMyOp := not pTable.Active;
  If mMyOp then pTable.Open
           else pTable.SwapStatus;
  pTable.IndexName := pIndexName;
  pTable.FindNearest([pDocNum]);
  If pTable.FieldByName('DocNum').AsString=pDocNum then begin
    Repeat
      If pTable.FieldByName(pDateField).AsDateTime<>pDocDate then begin
        pTable.Edit;
        pTable.FieldByName(pDateField).AsDateTime := pDocDate;
        pTable.Post;
      end;
      Application.ProcessMessages;
      pTable.Next;
    until pTable.Eof or (pTable.FieldByName('DocNum').AsString<>pDocNum);
  end;
  If mMyOp then pTable.Close
           else pTable.RestoreStatus;
end;

procedure ChangeDateInPmi (pDocNum:Str12;pPayDate:TDateTime);  // Zmeni datum v denniku uhrad
var mMyOp:boolean;  mBookNum:Str5;  mDocType:Str2;
begin
(*
  mMyOp := not dmLDG.btPMI.Active;
  If mMyOp then dmLDG.OpenBook(dmLDG.btPMI,YearL(pPayDate))
           else dmLDG.btPMI.SwapStatus;
  dmLDG.btPMI.IndexName := 'DoItSt';
  dmLDG.btPMI.FindNearest([pDocNum]);
  If dmLDG.btPMI.FieldByName('DocNum').AsString=pDocNum then begin
    Repeat
      If dmLDG.btPMI.FieldByName('PayDate').AsDateTime<>pPayDate then begin
        dmLDG.btPMI.Edit;
        dmLDG.btPMI.FieldByName('PayDate').AsDateTime := pPayDate;
        dmLDG.btPMI.Post;
        mDocType := copy(dmLDG.btPMI.FieldByName('ConDoc').AsString,1,2);
        mBookNum := BookNumFromDocNum(dmLDG.btPMI.FieldByName('ConDoc').AsString);
        If mDocType='DF' then begin
          dmLDG.OpenBook(dmLDG.btISH,mBookNum);
          dmLDG.btISH.IndexName := 'DocNum';
          If dmLDG.btISH.FindKey ([dmLDG.btPMI.FieldByName('ConDoc').AsString]) then begin
            dmLDG.btISH.Edit;
            dmLDG.btISH.FieldByName ('PayDate').AsDateTime := pPayDate;
            dmLDG.btISH.Post;
          end;
          dmLDG.btISH.Close;
        end;
        If mDocType='OF' then begin
          dmLDG.OpenBook(dmLDG.btICH,mBookNum);
          dmLDG.btICH.IndexName := 'DocNum';
          If dmLDG.btICH.FindKey ([dmLDG.btPMI.FieldByName('ConDoc').AsString]) then begin
            dmLDG.btICH.Edit;
            dmLDG.btICH.FieldByName ('PayDate').AsDateTime := pPayDate;
            dmLDG.btICH.Post;
          end;
          dmLDG.btICH.Close;
        end;
      end;
      Application.ProcessMessages;
      dmLDG.btPMI.Next;
    until dmLDG.btPMI.Eof or (dmLDG.btPMI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  If mMyOp then dmLDG.btPMI.Close
           else dmLDG.btPMI.RestoreStatus;
*)           
end;

procedure DelFromDbLst (pFileName:Str12); // Vymaze zadany subor zo zoznamu DBLST
var mMyOp:boolean;
begin
  mMyOp := not dmSYS.btDBLST.Active;
  If mMyOp then dmSYS.btDBLST.Open;
  dmSYS.btDBLST.IndexName := 'DbName';
  If dmSYS.btDBLST.FindKey([UpString(pFileName)]) then dmSYS.btDBLST.Delete;
  If mMyOp then dmSYS.btDBLST.Close;
end;

function BtrInit (pTableName,pPath:ShortString;Sender:TComponent):TNexBtrTable;
begin
  Result := TNexBtrTable.Create(Sender);
  Result.DataBaseName := pPath;
  Result.FixedName := pTableName;
  Result.TableName := pTableName;
  Result.DefPath := gPath.DefPath;
  Result.DefName := pTableName+'.BDF';
end;

function DatInit(pTabNam,pTabDir:ShortString;Sender:TComponent):TNexBtrTable;
begin
  Result:=TNexBtrTable.Create(Sender);
  Result.DataBaseName:=pTabDir;
  Result.FixedName:=pTabNam;
  Result.TableName:=pTabNam;
  Result.DefPath:=gPath.DefPath;
  Result.DefName:=pTabNam+'.DDF';
end;

function TmpInit (pTableName:ShortString; Sender:TComponent):TNexPxTable;
begin
  Result := TNexPxTable.Create(Sender);
  Result.FixName := pTableName;
  Result.TableName := pTableName;
  Result.DefPath := gPath.DefPath;
  Result.DefName := pTableName+'.TDF';
end;

function PxbInit (pTableName,pPath:ShortString;Sender:TComponent):TNexPxbTable;
begin
  Result := TNexPxbTable.Create(Sender);
  Result.DataBaseName := pPath;
  Result.TableName := pTableName;
  Result.DefPath := gPath.DefPath;
  Result.DefName := pTableName+'.BDF';
end;

procedure BTR_To_PX (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Premiestni polozky BTR s[boru do PX
var I:word;  mFieldName:string;  mFieldType:TFieldType;
begin
  If pPxTable.FindField('RowNum')<>nil then begin
    If pPxTable.FieldByName('RowNum').AsInteger=0 then pPxTable.FieldByName('RowNum').AsInteger := pPxTable.RecordCount+1;
  end;
  For I:= 0 to pBtTable.FieldCount-1 do begin
    mFieldName := pBtTable.Fields[I].FieldName;
    mFieldType := pBtTable.FieldByName(mFieldName).DataType;
    If pPxTable.FindField(mFieldName)<>nil then begin
      If (mFieldType=ftDateTime) then begin
        // Ak pole je datum a v BTR je nula potom nulu nezapiseme do PX
        If pBtTable.FieldByName(mFieldName).AsDateTime>0 then pPxTable.FieldByName(mFieldName).AsDateTime := pBtTable.FieldByName(mFieldName).AsDateTime;
      end
      else pPxTable.FieldByName(mFieldName).AsString := pBtTable.FieldByName(mFieldName).AsString;
    end;
  end;
  If pPxTable.FindField('ActPos')<>nil then pPxTable.FieldByName('ActPos').AsInteger := pBtTable.ActPos;
end;

procedure ITM_To_PX (pBtTable:TNexBtrTable; pPxTable:TNexPxTable;pFgCourse:double); // Premiestni polozky BTR s[boru do PX
var mGsQnt:double;   // Course:double;
begin
  BTR_To_PX (pBtTable,pPxTable);
  // Doplnime hodnotu HValue ak tam este nie
  If pPxTable.FindField('FgHValue')<>nil then begin
    If IsNul (pPxTable.FieldByName('FgHValue').AsFloat) then pPxTable.FieldByName('FgHValue').AsFloat := pPxTable.FieldByName('FgDValue').AsFloat*(1+pPxTable.FieldByName('VatPrc').AsInteger/100);
  end;
  // Vypocet ceny za MJ
  mGsQnt := 0;
  If pPxTable.FindField('GsQnt')<>nil then mGsQnt := pPxTable.FieldByName('GsQnt').AsFloat;
  If IsNotNul (mGsQnt) then begin // Ak mnozstvo nie je nula vypocitame jednotkove ceny
    // Uctovna mena
    pPxTable.FieldByName('AcCPrice').AsFloat := RoundCPrice(pPxTable.FieldByName('AcCValue').AsFloat/mGsQnt);
    // Vyuctovacia mena
    If pFgCourse=1 then begin
      pPxTable.FieldByName('FgCPrice').AsFloat := RoundCPrice(pPxTable.FieldByName('FgCValue').AsFloat/mGsQnt);
      pPxTable.FieldByName('FgDPrice').AsFloat := Rd3 (pPxTable.FieldByName('FgDValue').AsFloat/mGsQnt);
      pPxTable.FieldByName('FgAPrice').AsFloat := Rd3 (pPxTable.FieldByName('FgAValue').AsFloat/mGsQnt);
      pPxTable.FieldByName('FgBPrice').AsFloat := Rd3 (pPxTable.FieldByName('FgBValue').AsFloat/mGsQnt);
    end
    else begin
      pPxTable.FieldByName('FgCPrice').AsFloat := pPxTable.FieldByName('FgCValue').AsFloat/mGsQnt;
      pPxTable.FieldByName('FgDPrice').AsFloat := pPxTable.FieldByName('FgDValue').AsFloat/mGsQnt;
      pPxTable.FieldByName('FgAPrice').AsFloat := pPxTable.FieldByName('FgAValue').AsFloat/mGsQnt;
      pPxTable.FieldByName('FgBPrice').AsFloat := pPxTable.FieldByName('FgBValue').AsFloat/mGsQnt;
    end;
  end;
  // Vypocet zlavy
  pPxTable.FieldByName('FgDscVal').AsFloat := pPxTable.FieldByName('FgDValue').AsFloat-pPxTable.FieldByName('FgAValue').AsFloat;
end;

procedure PX_To_BTR (pPxTable:TNexPxTable; pBtTable:TNexBtrTable); // Premiestni polozky BTR s[boru do PX
var I:word;  mFieldName,mFld:ShortString; mFieldType:TFieldType;
begin
  For I:= 0 to pPxTable.FieldCount-1 do begin
    mFieldName := pPxTable.Fields[I].FieldName;
    mFld := Uppercase(mFieldName); // 2009.04.06
    If (mFld<>'CRTUSER') and (mFld<>'CRTDATE') and (mFld<>'CRTTIME') and (mFld<>'MODUSER') and (mFld<>'MODDATE') and (mFld<>'MODTIME') then begin
      If pBtTable.FindField(mFieldName)<>nil then begin
        try
          mFieldType := pBtTable.FieldByName(mFieldName).DataType;
          If (mFieldType=ftInteger) or (mFieldType=ftWord) then begin
            pBtTable.FieldByName(mFieldName).AsInteger := pPxTable.FieldByName(mFieldName).AsInteger
          end else begin
            If mFieldType=ftFloat
              then pBtTable.FieldByName(mFieldName).AsFloat := pPxTable.FieldByName(mFieldName).AsFloat
              else pBtTable.FieldByName(mFieldName).AsString := pPxTable.FieldByName(mFieldName).AsString;
          end;
        except end;
      end;
    end;  
  end;
end;

procedure PX_To_PX (pPxTable1,pPxTable2:TNexPxTable); // Premiestni polozky PX s[boru do PX
var I:word;  mFieldName:string; mFieldType:TFieldType;
begin
  For I:= 0 to pPxTable1.FieldCount-1 do begin
    mFieldName := pPxTable1.Fields[I].FieldName;
    If pPxTable2.FindField(mFieldName)<>nil then begin
      try
        mFieldType := pPxTable2.FieldByName(mFieldName).DataType;
        If (mFieldType=ftInteger) or (mFieldType=ftWord) then begin
          pPxTable2.FieldByName(mFieldName).AsInteger := pPxTable1.FieldByName(mFieldName).AsInteger
        end else begin
          If mFieldType=ftFloat
            then pPxTable2.FieldByName(mFieldName).AsFloat := pPxTable1.FieldByName(mFieldName).AsFloat
            else pPxTable2.FieldByName(mFieldName).AsString := pPxTable1.FieldByName(mFieldName).AsString;
        end;
      except end;
    end;
  end;
end;

procedure ITM_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable; pDocNum:Str12); // Ulozi polozky zadaneho dokladu do docasneho suboru
begin
  pBtTable.SwapStatus;
  pBtTable.IndexName := 'DocNum';
  If pBtTable.FindKey([pDocNum]) then begin
    Repeat
      pPxTable.Insert;
      BTR_To_PX (pBtTable,pPxTable);
      pPxTable.Post;
      Application.ProcessMessages;
      pBtTable.Next;
    until pBtTable.Eof or (pBtTable.FieldByName('DocNum').AsString<>pDocNum);
  end;
  pBtTable.RestoreStatus;
end;

procedure DOC_To_TMP(pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi vseobecne polia hlaviciek do docasneho suboru
begin
  pPxTable.FieldByName('SerNum').AsInteger := pBtTable.FieldByName('SerNum').AsInteger;
  pPxTable.FieldByName('DocNum').AsString := pBtTable.FieldByName('DocNum').AsString;
  pPxTable.FieldByName('ExtNum').AsString := pBtTable.FieldByName('ExtNum').AsString;
  pPxTable.FieldByName('OcdNum').AsString := pBtTable.FieldByName('OcdNum').AsString;
  pPxTable.FieldByName('DocDate').AsDateTime := pBtTable.FieldByName('DocDate').AsDateTime;
  pPxTable.FieldByName('StkNum').AsInteger := pBtTable.FieldByName('StkNum').AsInteger;
  pPxTable.FieldByName('PaCode').AsInteger := pBtTable.FieldByName('PaCode').AsInteger;
  pPxTable.FieldByName('PaName').AsString := pBtTable.FieldByName('PaName').AsString;
  pPxTable.FieldByName('RegName').AsString := pBtTable.FieldByName('RegName').AsString;
  pPxTable.FieldByName('RegIno').AsString := pBtTable.FieldByName('RegIno').AsString;
  pPxTable.FieldByName('RegTin').AsString := pBtTable.FieldByName('RegTin').AsString;
  pPxTable.FieldByName('RegVin').AsString := pBtTable.FieldByName('RegVin').AsString;
  pPxTable.FieldByName('RegAddr').AsString := pBtTable.FieldByName('RegAddr').AsString;
  pPxTable.FieldByName('RegSta').AsString := pBtTable.FieldByName('RegSta').AsString;
  pPxTable.FieldByName('RegCty').AsString := pBtTable.FieldByName('RegCty').AsString;
  pPxTable.FieldByName('RegCtn').AsString := pBtTable.FieldByName('RegCtn').AsString;
  pPxTable.FieldByName('RegZip').AsString := pBtTable.FieldByName('RegZip').AsString;
  pPxTable.FieldByName('PayCode').AsString := pBtTable.FieldByName('PayCode').AsString;
  pPxTable.FieldByName('PayName').AsString := pBtTable.FieldByName('PayName').AsString;
  pPxTable.FieldByName('SpaCode').AsInteger := pBtTable.FieldByName('SpaCode').AsInteger;
  pPxTable.FieldByName('WpaCode').AsInteger := pBtTable.FieldByName('WpaCode').AsInteger;
  pPxTable.FieldByName('WpaName').AsString := pBtTable.FieldByName('WpaName').AsString;
  pPxTable.FieldByName('WpaAddr').AsString := pBtTable.FieldByName('WpaAddr').AsString;
  pPxTable.FieldByName('WpaSta').AsString := pBtTable.FieldByName('WpaSta').AsString;
  pPxTable.FieldByName('WpaCty').AsString := pBtTable.FieldByName('WpaCty').AsString;
  pPxTable.FieldByName('WpaCtn').AsString := pBtTable.FieldByName('WpaCtn').AsString;
  pPxTable.FieldByName('WpaZip').AsString := pBtTable.FieldByName('WpaZip').AsString;
  pPxTable.FieldByName('TrsCode').AsString := pBtTable.FieldByName('TrsCode').AsString;
  pPxTable.FieldByName('TrsName').AsString := pBtTable.FieldByName('TrsName').AsString;
  pPxTable.FieldByName('RspName').AsString := pBtTable.FieldByName('RspName').AsString;
  pPxTable.FieldByName('PlsNum').AsInteger := pBtTable.FieldByName('PlsNum').AsInteger;
  pPxTable.FieldByName('DscPrc').AsFloat := pBtTable.FieldByName('DscPrc').AsFloat;
  pPxTable.FieldByName('VatPrc1').AsInteger := pBtTable.FieldByName('VatPrc1').AsInteger;
  pPxTable.FieldByName('VatPrc2').AsInteger := pBtTable.FieldByName('VatPrc2').AsInteger;
  pPxTable.FieldByName('VatPrc3').AsInteger := pBtTable.FieldByName('VatPrc3').AsInteger;

  pPxTable.FieldByName('AcDvzName').AsString := pBtTable.FieldByName('AcDvzName').AsString;
  pPxTable.FieldByName('AcCValue').AsFloat := pBtTable.FieldByName('AcCValue').AsFloat;
  pPxTable.FieldByName('AcDValue').AsFloat := pBtTable.FieldByName('AcDValue').AsFloat;
  pPxTable.FieldByName('AcDscVal').AsFloat := pBtTable.FieldByName('AcDscVal').AsFloat;
  pPxTable.FieldByName('AcAValue').AsFloat := pBtTable.FieldByName('AcAValue').AsFloat;
  pPxTable.FieldByName('AcVatVal').AsFloat := pBtTable.FieldByName('AcVatVal').AsFloat;
  pPxTable.FieldByName('AcBValue').AsFloat := pBtTable.FieldByName('AcBValue').AsFloat;
  pPxTable.FieldByName('AcAValue1').AsFloat := pBtTable.FieldByName('AcAValue1').AsFloat;
  pPxTable.FieldByName('AcAValue2').AsFloat := pBtTable.FieldByName('AcAValue2').AsFloat;
  pPxTable.FieldByName('AcAValue3').AsFloat := pBtTable.FieldByName('AcAValue3').AsFloat;
  pPxTable.FieldByName('AcBValue1').AsFloat := pBtTable.FieldByName('AcBValue1').AsFloat;
  pPxTable.FieldByName('AcBValue2').AsFloat := pBtTable.FieldByName('AcBValue2').AsFloat;
  pPxTable.FieldByName('AcBValue3').AsFloat := pBtTable.FieldByName('AcBValue3').AsFloat;
  pPxTable.FieldByName('FgDvzName').AsString := pBtTable.FieldByName('FgDvzName').AsString;
  pPxTable.FieldByName('FgCourse').AsFloat := pBtTable.FieldByName('FgCourse').AsFloat;
  pPxTable.FieldByName('FgCValue').AsFloat := pBtTable.FieldByName('FgCValue').AsFloat;
  pPxTable.FieldByName('FgDValue').AsFloat := pBtTable.FieldByName('FgDValue').AsFloat;
  pPxTable.FieldByName('FgDscVal').AsFloat := pBtTable.FieldByName('FgDscVal').AsFloat;
  pPxTable.FieldByName('FgAValue').AsFloat := pBtTable.FieldByName('FgAValue').AsFloat;
  pPxTable.FieldByName('FgVatVal').AsFloat := pBtTable.FieldByName('FgVatVal').AsFloat;
  pPxTable.FieldByName('FgBValue').AsFloat := pBtTable.FieldByName('FgBValue').AsFloat;
  pPxTable.FieldByName('FgAValue1').AsFloat := pBtTable.FieldByName('FgAValue1').AsFloat;
  pPxTable.FieldByName('FgAValue2').AsFloat := pBtTable.FieldByName('FgAValue2').AsFloat;
  pPxTable.FieldByName('FgAValue3').AsFloat := pBtTable.FieldByName('FgAValue3').AsFloat;
  pPxTable.FieldByName('FgBValue1').AsFloat := pBtTable.FieldByName('FgBValue1').AsFloat;
  pPxTable.FieldByName('FgBValue2').AsFloat := pBtTable.FieldByName('FgBValue2').AsFloat;
  pPxTable.FieldByName('FgBValue3').AsFloat := pBtTable.FieldByName('FgBValue3').AsFloat;
  pPxTable.FieldByName('DlrCode').AsInteger := pBtTable.FieldByName('DlrCode').AsInteger;
  pPxTable.FieldByName('VatDoc').AsInteger := pBtTable.FieldByName('VatDoc').AsInteger;
  pPxTable.FieldByName('PrnCnt').AsInteger := pBtTable.FieldByName('PrnCnt').AsInteger;
  pPxTable.FieldByName('ItmQnt').AsInteger := pBtTable.FieldByName('ItmQnt').AsInteger;
  pPxTable.FieldByName('DstLck').AsInteger := pBtTable.FieldByName('DstLck').AsInteger;
  pPxTable.FieldByName('DstCls').AsInteger := pBtTable.FieldByName('DstCls').AsInteger;
  pPxTable.FieldByName('Sended').AsInteger := pBtTable.FieldByName('Sended').AsInteger;
  pPxTable.FieldByName('CrtUser').AsString := pBtTable.FieldByName('CrtUser').AsString;
  pPxTable.FieldByName('CrtDate').AsDateTime := pBtTable.FieldByName('CrtDate').AsDateTime;
  pPxTable.FieldByName('CrtTime').AsDateTime := pBtTable.FieldByName('CrtTime').AsDateTime;
  pPxTable.FieldByName('ModNum').AsInteger := pBtTable.FieldByName('ModNum').AsInteger;
  pPxTable.FieldByName('ModUser').AsString := pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime := pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime := pBtTable.FieldByName('ModTime').AsDateTime;
  pPxTable.FieldByName('ActPos').AsInteger := pBtTable.ActPos;
end;

procedure BTR_To_BTR (pScTable,pTgTable:TNexBtrTable);  // Ulozi identicke polia zo zdrojovej do celovej databaze
var I:word;  mFieldName,mFld:ShortString;
begin
  For I:= 0 to pScTable.FieldCount-1 do begin
    mFieldName := pScTable.Fields[I].FieldName;
    If pTgTable.FindField(mFieldName)<>nil then begin
      mFld := Uppercase(mFieldName); // 2009.04.06
      If (mFld<>'CRTUSER') and (mFld<>'CRTDATE') and (mFld<>'CRTTIME') and (mFld<>'MODUSER') and (mFld<>'MODDATE') and (mFld<>'MODTIME') then begin
        pTgTable.FieldByName(mFieldName).AsString := pScTable.FieldByName(mFieldName).AsString;
      end;
    end;
  end;
end;

procedure BTRT_To_BTRT (pScTable,pTgTable:TBtrieveTable);  // Ulozi identicke polia zo zdrojovej do celovej databaze
var I:word;  mFieldName,mFld:ShortString;
begin
  For I:= 0 to pScTable.FieldCount-1 do begin
    mFieldName := pScTable.Fields[I].FieldName;
    If pTgTable.FindField(mFieldName)<>nil then begin
      mFld := Uppercase(mFieldName); // 2009.04.06
      If (mFld<>'CRTUSER') and (mFld<>'CRTDATE') and (mFld<>'CRTTIME') and (mFld<>'MODUSER') and (mFld<>'MODDATE') and (mFld<>'MODTIME') then begin
        pTgTable.FieldByName(mFieldName).AsString := pScTable.FieldByName(mFieldName).AsString;
      end;
    end;
  end;
end;

procedure TXT_To_BTR (pFileName:ShortString;pTable:TNexBtrTable; pHead:TDocHead); // Nacita jeden rekord z textoveho suboru do databaze
var I:word;   mFieldName:Str20;  mFieldType:TFieldType;
    mHeadSdf:ShortString;      mFieldList:TStrings;
begin
  mHeadSdf := pHead.ReadString ('HeadSdf');
  mFieldList := TStringList.Create;
  mFieldList.Clear;
  If mHeadSdf='' then begin // Ak nie je zadany zoznam poli posielame vsetku polia databaze
    For I:=0 to pTable.FieldCount-1 do
      mFieldList.Add (pTable.Fields[I].FieldName);
  end
  else begin  // Nacitame definicny subor prenosu *.SDF
    If FileExists (gPath.DefPath+mHeadSdf)
      then mFieldList.LoadFromFile(gPath.DefPath+mHeadSdf)
      else MessageDlg ('Neexistuúci súbor: '+gPath.DefPath+mHeadSdf, mtInformation,[mbOk],0);
  end;
  For I:=0 to mFieldList.Count-1 do begin
    try
      mFieldName := mFieldList.Strings[I];
      If pHead.FieldExist(mFieldName) then begin
        mFieldType := pTable.FieldByName(mFieldName).DataType;
        case mFieldType of
          ftFloat: pTable.FieldByName(mFieldName).AsFloat := pHead.ReadFloat (mFieldName);
           ftDate: pTable.FieldByName(mFieldName).AsDateTime := pHead.ReadDate (mFieldName);
             else  pTable.FieldByName(mFieldName).AsString := pHead.ReadString (mFieldName);
        end;
      end;
    except end;
  end;
  FreeAndNil (mFieldList);
end;

function BookExist (pBookTable:TNexBtrTable;pBookNum:Str5):boolean;
var mMyOp:boolean;
begin
  mMyOp := not pBookTable.Active;
  If mMyOp then pBookTable.Open;
  pBookTable.IndexName := 'BookNum';
  Result := pBookTable.FindKey([pBookNum]);
  If mMyOp then pBookTable.Close;
end;

procedure GsCat_SearchFields (pType:byte;pCnt:integer;pFldname:Str30;pSrchStr:Str30;var pPositions: String;var pCount:longint;pUperCase:byte);
begin
   dmSTK.btGSCAT.SearchFields(pType,pCnt,dmSTK.btGSCAT.FieldDefs.Find(pFldname).FieldNo-1,pSrchStr,pPositions,pCount,pUperCase);
end;

function  LocateDocLastYearSerNum(pTable:TNexBtrTable;pYear:Str2):boolean;
var mY:Str2; mL:String;
begin
  Result:=False;
  If pYear='' then pYear:=gvSys.ActYear2;
  pTable.IndexName:='YearSerNum';
  If (pTable.IndexName<>'YearSerNum')or(pTable.FindField('Year')=NIL)or(pTable.FindField('SerNum')=NIL)then
  begin
    mL:='GetDocNextYearSerNum';
    If (pTable.IndexName<>'YearSerNum') then mL:=mL+'Index YearSerNum not Exist;';
    If (pTable.FindField('Year')=NIL)  then mL:=mL+'Field Year not Exist;';
    If (pTable.FindField('SerNum')=NIL)then mL:=mL+'Field SerNum not Exist;';
    mL:=mL+pTable.TableName+';';
    WriteToLogFile(gPath.SysPath+'LOG\YEARSERN.LOG',mL);
  end else begin
    mY:=StrIntZero(valint(pYear)+1,2);
    If not pTable.FindNearest([mY,0]) then pTable.Last;
    If pYear<>pTable.FieldByName('Year').AsString then pTable.Prior;
    If pYear=pTable.FieldByName('Year').AsString
      then Result := True
      else Result := False;
  end;
end;

function  GetDocNextYearSerNum(pTable:TNexBtrTable;pYear:Str2):longint;
var mY:Str2; mL:String;
begin
  Result:=1;
  If pYear='' then pYear:=gvSys.ActYear2;
  pTable.IndexName:='YearSerNum';
  If (pTable.IndexName<>'YearSerNum')or(pTable.FindField('Year')=NIL)or(pTable.FindField('SerNum')=NIL)then
  begin
    mL:='GetDocNextYearSerNum';
    If (pTable.IndexName<>'YearSerNum') then mL:=mL+'Index YearSerNum not Exist;';
    If (pTable.FindField('Year')=NIL)  then mL:=mL+'Field Year not Exist;';
    If (pTable.FindField('SerNum')=NIL)then mL:=mL+'Field SerNum not Exist;';
    mL:=mL+pTable.TableName+';';
    WriteToLogFile(gPath.SysPath+'LOG\YEARSERN.LOG',mL);
  end else begin
    pTable.SwapStatus;
    mY:=StrIntZero(valint(pYear)+1,2);
    If not pTable.FindNearest([mY,0]) then pTable.Last;
    If pYear<>pTable.FieldByName('Year').AsString then pTable.Prior;
    If pYear=pTable.FieldByName('Year').AsString
      then Result := pTable.FieldByName('SerNum').AsInteger+1
      else Result:=1;
    pTable.RestoreStatus;
  end;
end;

function  GetDocFreeYearSerNum(pTable:TNexBtrTable;pYear:Str2):longint;
var mY:Str2; mL:String; mFind:boolean; mSerNum:longint;
begin
  mSerNum:=0;
  If pYear='' then pYear:=gvSys.ActYear2;
  pTable.IndexName:='YearSerNum';
  If (pTable.IndexName<>'YearSerNum')or(pTable.FindField('Year')=NIL)or(pTable.FindField('SerNum')=NIL)then
  begin
    mL:='GetDocFreeYearSerNum';
    If (pTable.IndexName<>'YearSerNum') then mL:=mL+'Index YearSerNum not Exist;';
    If (pTable.FindField('Year')=NIL)  then mL:=mL+'Field Year not Exist;';
    If (pTable.FindField('SerNum')=NIL)then mL:=mL+'Field SerNum not Exist;';
    mL:=mL+pTable.TableName+';';
    WriteToLogFile(gPath.SysPath+'LOG\YEARSERN.LOG',mL);
  end else begin
    pTable.SwapStatus;
    mY:=StrIntZero(valint(pYear)+1,2);
    If not pTable.FindNearest([mY,0]) then pTable.Last;
    mFind := FALSE;   mSerNum := 0;
    Repeat
      If pTable.FieldByName ('Year').AsString=mY then begin
        Inc (mSerNum);
        If pTable.FieldByName ('SerNum').AsInteger>mSerNum then begin
          mFind := TRUE;
        end
        else mSerNum := pTable.FieldByName ('SerNum').AsInteger;
        If mFind then begin
        end else pTable.Next;
      end else pTable.Next;
    until pTable.Eof or mFind;
    pTable.RestoreStatus;
  end;
end;

function  LocateYearSerNum(pTable:TNexBtrTable;pYear:Str2;pSerNum:longint;pSwapIndex:boolean):boolean;
var mL:String;
begin
  Result:=False;
//  If pSwapStatus then pTable.SwapStatus;
  If pSwapIndex then pTable.SwapIndex;
  If pYear='' then pYear:=gvSys.ActYear2;
  pTable.IndexName:='YearSerNum';
  If (pTable.IndexName<>'YearSerNum')or(pTable.FindField('Year')=NIL)or(pTable.FindField('SerNum')=NIL)then
  begin
    mL:='LocateYearSerNum';
    If (pTable.IndexName<>'YearSerNum') then mL:=mL+'Index YearSerNum not Exist;';
    If (pTable.FindField('Year')=NIL)  then mL:=mL+'Field Year not Exist;';
    If (pTable.FindField('SerNum')=NIL)then mL:=mL+'Field SerNum not Exist;';
    mL:=mL+pTable.TableName+';';
    WriteToLogFile(gPath.SysPath+'LOG\YEARSERN.LOG',mL);
  end else begin
    Result:=pTable.FindKey([pYear,pSerNum]);
  end;
//  If pSwapStatus then pTable.RestoreStatus;
  If pSwapIndex then pTable.RestoreIndex;
end;

function  LocateDocNum(pTable:TNexBtrTable;pDocNum:Str12;pSwapIndex:boolean):boolean;
var mL:String;
begin
  Result:=False;
  If pSwapIndex then pTable.SwapIndex;
  pTable.IndexName:='DocNum';
  If (pTable.IndexName<>'DocNum')or(pTable.FindField('DocNum')=NIL)then
  begin
    mL:='LocateDocNum';
    If (pTable.IndexName<>'DocNum') then mL:=mL+'Index DocNum not Exist;';
    If (pTable.FindField('DocNum')=NIL)then mL:=mL+'Field DocNum not Exist;';
    mL:=mL+pTable.TableName+';';
    WriteToLogFile(gPath.SysPath+'LOG\DOCNUM.LOG',mL);
  end else begin
    Result:=pTable.FindKey([pDocNum]);
  end;
  If pSwapIndex then pTable.RestoreIndex;
end;

function  YearDocNumMod(pDocNum:Str12;pDate:TDateTime):boolean;
begin
  Result:=YearS(Date)<>YearFromDocNum(pDocNum);
end;

function  Ver_BTR_FldChg (pScTable,pTgTable:TNexBtrTable;pIndFld,pFld:String):String;  // Porovna dve tabulky na zadane polia
var I:word;  mFieldName,mFld:ShortString;
begin
  Result:='';
  pFld:=UpperCase(pFld);If pfld<>'' then pFld:=pFld+'|';
  For I:= 0 to pScTable.FieldCount-1 do begin
    mFieldName := pScTable.Fields[I].FieldName;
    If ((pFld='')or(Pos(UpperCase(mFieldName)+'|',pFld)>0))and(pTgTable.FindField(mFieldName)<>nil) then begin
      mFld := Uppercase(mFieldName); // 2009.04.06
      If (mFld<>'CRTUSER') and (mFld<>'CRTDATE') and (mFld<>'CRTTIME') and (mFld<>'MODUSER') and (mFld<>'MODDATE') and (mFld<>'MODTIME') then begin
        If pTgTable.FieldByName(mFieldName).AsString <> pScTable.FieldByName(mFieldName).AsString
          then Result:=Result+'|'+mFieldName+'='+pTgTable.FieldByName(mFieldName).AsString+'>>>'+pScTable.FieldByName(mFieldName).AsString;
      end;
    end;
  end;
  If Result<>'' then Result:=Copy(Result,2,Length(Result));
  If (Result<>'')and(pIndFld<>'')and(pScTable.FindField(pIndFld)<>nil)and(pTgTable.FindField(pIndFld)<>nil)
    then Result:=pIndFld+'='+pTgTable.FieldByName(pIndFld).AsString+'>>>'+pScTable.FieldByName(pIndFld).AsString+'|'+Result;
end;

end.
{MOD 1901002}
