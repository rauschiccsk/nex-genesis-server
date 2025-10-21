unit OipRcv;

interface

uses
  IcTypes, IcConv, IcTools, NexPath, NexMsg, NexError, NexGlob,
  DocHead, DocItem, DocHand, ParHand, RefFile,
  Dialogs, IniFiles, Forms, Classes, SysUtils, StdCtrls,
  NexBtrTable, NexPxTable, DB;

type
  TOipRcv = class
    ptItem: TNexPxTable;
    constructor Create;
    destructor Destroy; override;
  private
    oSucces: boolean; // TRUE ak operacia bola vykonana uspesne
    oDocNum: Str12; // Cislo dokladu ktorym pracujeme
    oItmQnt: word;  // Pocet polozeek nacitaneho dokladu
    oSndCon: boolean; // Ak je TRUE system posle potvrdenku
    oCommand: ShortString; // Pokyn k specialnemu spracovaniu suboru
    oAddFile: ShortString; // Zoznam prilohovych suborov
    function ConVerifyOk(pFieldList:TStrings;pFile:TIniFile;pHeadTable:TNexBtrTable):boolean; // TRUE ak potvrdenka je sulade s odoslanym dokaldom
    function FilterEqual (pFilter:ShortString; pTable:TNexBtrTable):boolean;  // TRUA ak zaznam zo zadanej dtabaze zhoduje so zadanym filtrom
    procedure WriteToMsg (pDocNum:Str12; pMsgType:Str1); // Ulozi hlasenie do OIT.MSG suboru
    procedure DeleteBtrItem (pItemTable:TNexBtrTable); // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
    procedure AddTmpToItem (pItemTable:TNexBtrTable); // Prida nove polozky do prijemky
    // Spracovanie dokladov
    procedure DeleteDocItem (pItemTable:TNexBtrTable;pDocNum:Str12;pDocField:ShortString); // Vymaze polozky zadaneho dokladu
    procedure LoadDocToItem (pFileName:ShortString;pItemTable:TNexBtrTable;pDocNum:Str12); // Nacita polozky zadaneho dokladu
    // Spracovanie zaznamov
    procedure LoadCodeFrTxt (pFileName:ShortString;pFixedName:Str10;pCodeField:ShortString; var pCodeList:TStrings);
    procedure DeleteRecItem (pItemTable:TNexBtrTable;pCode:longint;pCodeField,pFilter:ShortString); // Vymaze polozky zadanymi PLU zo zadanej tabulky
    procedure DeleteLstItem (pItemTable:TNexBtrTable;pCodeList:TStrings;pCodeField,pFilter:ShortString); // Vymaze polozky zadanymi PLU zo zadanej tabulky
    procedure LoadRecToItem (pFileName:ShortString;pItemTable:TNexBtrTable); // Nacita polozky z prenosoveho suboru do zadanej databaze
  public
    procedure LoadStcFrFile (pFileName:ShortString;pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable);  // Nacita skladove karty z textoveho suboru
    procedure LoadStlFrFile (pFileName:ShortString;pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable;pInfoLine:TLabel);  // Nacita skladove karty z textoveho suboru
    procedure LoadGscFrFile (pFileName:ShortString;pGSCAT,pGSNOTI,pBARCODE:TNexBtrTable);  // Nacita skladovu kartu z textoveho suboru
    procedure LoadPacFrFile (pFileName:ShortString;pPAB,pPABACC,pPACNTC,pPASUBC,pPANOTI:TNexBtrTable);  // Nacita kartu partnera z textoveho suboru
    procedure LoadPlcFrFile (pFileName:ShortString;pPLS,pPLH:TNexBtrTable);  // Nacita kartu partnera z textoveho suboru
    procedure LoadWgiFrFile (pFileName:ShortString;pWGI:TNexBtrTable);  // Nacita vahovy tovar z textoveho suboru
    procedure LoadScsFrFile (pFileName:ShortString;pFGPALST,pFGPADSC:TNexBtrTable);  // Nacita kartu partnera z textoveho suboru

    procedure LoadDocFrFile (pFileName:ShortString;pHeadTable,pItemTable1,pItemTable2,pNotiTable:TNexBtrTable);  // Nacita doklad z textoveho suboru
    procedure LoadConFrFile (pFileName:ShortString;pHeadTable:TNexBtrTable);  // Nacita doklad z textoveho suboru
    procedure LoadAccFrFile (pFileName:ShortString;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o zauctovani dokladu
    procedure LoadPmdFrFile (pFileName:ShortString;pPMI:TNexBtrTable);  // Nacita historiu uhrady faktury
  published
    property Succes:boolean read oSucces;
    property SndCon:boolean read oSndCon;
  end;

implementation

uses DM_LDGDAT;

constructor TOipRcv.Create;
begin
  oDocNum := '';  oItmQnt := 0;   oSndCon := TRUE;
  If not DirectoryExists (gPath.RcvPath) then ForceDirectories (gPath.RcvPath);
  ptItem := TNexPxTable.Create(Application);
end;

destructor TOipRcv.Destroy;
begin
  FreeAndNil (ptItem);
end;

// ************************* PRIVATE METHODS *************************

function TOipRcv.ConVerifyOk(pFieldList:TStrings;pFile:TIniFile;pHeadTable:TNexBtrTable):boolean; // TRUE ak potvrdenka je sulade s odoslanym dokaldom
var mCnt:word; mFieldName:Str20;  mFieldType:TFieldType;
begin
  Result := FALSE;
  If pFieldList.Count>0 then begin
    Result := TRUE;
    mCnt := 0;
    Repeat
      mFieldName := DelSpaces(pFieldList.Strings[mCnt]);
      mFieldType := pHeadTable.FieldByName(mFieldName).DataType;
      case mFieldType of
        ftFloat: begin
                   If mFieldName='FgCourse' then begin
                     If not Eq5 (ValDoub(pFile.ReadString ('HEAD',mFieldName,'')),pHeadTable.FieldByName(mFieldName).AsFloat) then Result := FALSE;
                   end
                   else begin
                     If not Eq2 (ValDoub(pFile.ReadString ('HEAD',mFieldName,'')),pHeadTable.FieldByName(mFieldName).AsFloat) then Result := FALSE;
                   end;
                 end;
         ftDate: If pFile.ReadDate('HEAD',mFieldName,0)<>pHeadTable.FieldByName(mFieldName).AsDateTime then Result := FALSE;
            else begin
                   If pFile.ReadString ('HEAD',mFieldName,'')<>RemLeftSpaces(RemRightSpaces(pHeadTable.FieldByName(mFieldName).AsString)) then Result := FALSE;
                 end;
      end;
      Inc (mCnt);
    until mCnt=pFieldList.Count;
  end;
end;

function TOipRcv.FilterEqual (pFilter:ShortString; pTable:TNexBtrTable):boolean;  // TRUA ak zaznam zo zadanej dtabaze zhoduje so zadanym filtrom
var  mFiltFld,mFiltVal,mFieldName:ShortString;  I:word;
begin
  Result := TRUE;
  If pFilter<>'' then begin
    Result := FALSE;
    mFiltFld := LineElement (pFilter,0,'=');
    mFiltVal := LineElement (pFilter,1,'=');
    For I:=0 to pTable.FieldCount-1 do begin
      try
        mFieldName := pTable.Fields[I].FieldName;
        If mFiltFld=mFieldName then begin
          Result := pTable.FieldByName(mFieldName).AsString=mFiltVal;
        end;
      except end;
    end;
  end;
end;

procedure TOipRcv.WriteToMsg (pDocNum:Str12; pMsgType:Str1); // Ulozi hlasenie do OIT.MSG suboru
begin
  If pMsgType='A' then WriteStrToFile (gPath.SysPath+'OIT.MSG',pDocNum+' - nie je moûnÈ naËÌtaù pretoûe dan˝ doklad je za˙Ëtovan˝.');
end;

procedure TOipRcv.DeleteBtrItem(pItemTable:TNexBtrTable); // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If pItemTable.IndexName<>'DocNum' then pItemTable.IndexName:='DocNum';
  If pItemTable.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      If oCommand='NST' then begin  // Ak je pokyn je k zmene StkStat=N
        If pItemTable.FindField('StkStat')<>nil then begin
          If pItemTable.FindField('StkStat').AsString='N' then pItemTable.Delete;
        end;
      end
      else pItemTable.Delete;
    until (pItemTable.Eof) or (pItemTable.RecordCount=0) or (pItemTable.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TOipRcv.DeleteDocItem (pItemTable:TNexBtrTable;pDocNum:Str12;pDocField:ShortString); // Vymaze polozky zadaneho dokladu
begin
  oItmQnt := 0;
  If pItemTable.IndexName<>pDocField then pItemTable.IndexName:=pDocField;
  If pItemTable.FindKey ([pDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      If oCommand='NST' then begin  // Ak je pokyn je k zmene StkStat=N
        If pItemTable.FindField('StkStat')<>nil then begin
          If pItemTable.FindField('StkStat').AsString='N'
            then pItemTable.Delete
            else pItemTable.Next;
        end;
      end
      else pItemTable.Delete;
    until (pItemTable.Eof) or (pItemTable.RecordCount=0) or (pItemTable.FieldByName(pDocField).AsString<>pDocNum);
  end;
end;

procedure TOipRcv.LoadDocToItem (pFileName:ShortString;pItemTable:TNexBtrTable;pDocNum:Str12); // Nacita polozky zadaneho dokladu
var I:word;  mItems:TDocItem;  mFieldName:Str20;  mFieldType:TFieldType;
begin
  oItmQnt := 0;
  pItemTable.IndexName := 'DoIt';
  mItems := TDocItem.Create;
  mItems.LoadFromFile(pFileName,pItemTable.FixedName);
  If mItems.Count>0 then begin
    mItems.First;
    Repeat
      Inc (oItmQnt);
      If mItems.Line then begin // AK je to riadok s textovym zaznamom
        If pItemTable.FindKey ([pDocNum,mItems.ReadInteger ('ItmNum')])
          then pItemTable.Edit
          else pItemTable.Insert;
        For I:=0 to pItemTable.FieldCount-1 do begin
          try
            mFieldName := pItemTable.Fields[I].FieldName;
            If mItems.FieldExist (mFieldName) then begin
              mFieldType := pItemTable.FieldByName(mFieldName).DataType;
              case mFieldType of
                ftFloat: pItemTable.FieldByName(mFieldName).AsFloat := mItems.ReadFloat (mFieldName);
                 ftDate: pItemTable.FieldByName(mFieldName).AsDateTime := mItems.ReadDate (mFieldName);
                   else  pItemTable.FieldByName(mFieldName).AsString := mItems.ReadString (mFieldName);
              end;
            end;
          except end;
        end;
        pItemTable.FieldByName ('DocNum').AsString := pDocNum;
        If oCommand='NST' then pItemTable.FieldByName ('StkStat').AsString := 'N';
        pItemTable.Post;
      end;
      Application.ProcessMessages;
      mItems.Next;
    until mItems.Eof;
  end;
  FreeAndNil (mItems);
end;

procedure TOipRcv.LoadCodeFrTxt (pFileName:ShortString;pFixedName:Str10;pCodeField:ShortString; var pCodeList:TStrings);
var mItems:TDocItem;  
begin
  mItems := TDocItem.Create;
  mItems.LoadFromFile(pFileName,pFixedName);
  If mItems.Count>0 then begin
    mItems.First;
    Repeat
      If mItems.Line then begin // AK je to riadok s textovym zaznamom
        pCodeList.Add(mItems.ReadString (pCodeField));
      end;
      Application.ProcessMessages;
      mItems.Next;
    until mItems.Eof;
  end;
  FreeAndNil (mItems);
end;

procedure TOipRcv.DeleteRecItem (pItemTable:TNexBtrTable;pCode:longint;pCodeField,pFilter:ShortString); // Vymaze polozky zadanymi PLU zo zadanej tabulky
begin
  If pItemTable.IndexName<>pCodeField then pItemTable.IndexName:=pCodeField;
  If pItemTable.FindKey ([pCode]) then begin
    Repeat
      Application.ProcessMessages;
      If FilterEqual (pFilter,pItemTable)
        then pItemTable.Delete
        else pItemTable.Next;
    until (pItemTable.Eof) or (pItemTable.RecordCount=0) or (pItemTable.FieldByName(pCodeField).AsInteger<>pCode);
  end;
end;

procedure TOipRcv.DeleteLstItem (pItemTable:TNexBtrTable;pCodeList:TStrings;pCodeField,pFilter:ShortString); // Vymaze polozky zadanymi PLU zo zadanej tabulky
var mCode,mCnt:longint;
begin
  If (pCodeList.Count>0) and (pItemTable.RecordCount>0) then begin
    mCnt := 0;
    Repeat
      mCode := ValInt(pCodeList.Strings[mCnt]);
      If pItemTable.IndexName<>pCodeField then pItemTable.IndexName:=pCodeField;
      If pItemTable.FindKey ([mCode]) then begin
        Repeat
          Application.ProcessMessages;
          If FilterEqual (pFilter,pItemTable)
            then pItemTable.Delete
            else pItemTable.Next;
        until (pItemTable.Eof) or (pItemTable.RecordCount=0) or (pItemTable.FieldByName(pCodeField).AsInteger<>mCode);
      end;
      Inc (mCnt);
    until mCnt>=pCodeList.Count;
  end;
end;

procedure TOipRcv.LoadRecToItem (pFileName:ShortString;pItemTable:TNexBtrTable); // Nacita polozky z prenosoveho suboru do zadanej databaze
var I:word;  mItems:TDocItem;  mFieldName:Str20;  mFieldType:TFieldType;
begin
  mItems := TDocItem.Create;
  mItems.LoadFromFile(pFileName,pItemTable.FixedName);
  If mItems.Count>0 then begin
    mItems.First;
    Repeat
      If mItems.Line then begin // AK je to riadok s textovym zaznamom
        pItemTable.Insert;
        For I:=0 to pItemTable.FieldCount-1 do begin
          try
            mFieldName := pItemTable.Fields[I].FieldName;
            mFieldType := pItemTable.FieldByName(mFieldName).DataType;
            case mFieldType of
              ftFloat: pItemTable.FieldByName(mFieldName).AsFloat := mItems.ReadFloat (mFieldName);
               ftDate: pItemTable.FieldByName(mFieldName).AsDateTime := mItems.ReadDate (mFieldName);
                 else  pItemTable.FieldByName(mFieldName).AsString := mItems.ReadString (mFieldName);
            end;
          except end;
        end;
        pItemTable.Post;
      end;
      Application.ProcessMessages;
      mItems.Next;
    until mItems.Eof;
  end;
  FreeAndNil (mItems);
end;

procedure TOipRcv.AddTmpToItem(pItemTable:TNexBtrTable); // Prida nove polozky do dodacieho listu
begin
  pItemTable.Modify := FALSE;
  pItemTable.IndexName:='DoIt';
  ptItem.First;
  Repeat
    If not pItemTable.FindKey ([oDocNum,ptItem.FieldByName('ItmNum').AsInteger]) then begin
      pItemTable.Insert;
      PX_To_BTR (ptItem,pItemTable);
      pItemTable.FieldByName ('DocNum').AsString := oDocNum;
      pItemTable.Post;
    end;
    ptItem.Next;
    Application.ProcessMessages;
  until (ptItem.Eof);
  pItemTable.Modify := TRUE;
end;

// ************************* PUBLIC METHODS *************************

procedure TOipRcv.LoadStcFrFile(pFileName:ShortString;pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable);  // Nacita skladove karty z textoveho suboru
var mGsCode:longint; mParHand:TParHand;  mHead:TDocHead;
begin
  oSucces := FALSE;   oAddFile := '';
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mGsCode := ValInt(copy(pFileName,9,6));
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    // Nacitame udaje skladovej karty
    If pSTK.FindKey([mGsCode])
      then pSTK.Edit
      else pSTK.Insert;
    TXT_To_BTR (gPath.RcvPath+pFileName,pSTK,mHead);
    pSTK.Post;
    FreeAndNil (mHead);
    // Nacitame polozky STM,FIF,STO a STP
    If (oAddFile='') then begin // Posielame vsetky prilohy
      DeleteRecItem (pSTM,mGsCode,'GsCode',''); // Vymaze polozky STM
      LoadRecToItem (gPath.RcvPath+pFileName,pSTM); // Nacita polozky STM
      DeleteRecItem (pFIF,mGsCode,'GsCode',''); // Vymaze polozky FIF
      LoadRecToItem (gPath.RcvPath+pFileName,pFIF); // Nacita polozky FIF
      DeleteRecItem (pSTO,mGsCode,'GsCode',''); // Vymaze polozky STO
      LoadRecToItem (gPath.RcvPath+pFileName,pSTO); // Nacita polozky STO
      DeleteRecItem (pSTP,mGsCode,'GsCode',''); // Vymaze polozky STP
      LoadRecToItem (gPath.RcvPath+pFileName,pSTP); // Nacita polozky STP
    end
    else begin
      mParHand := TParHand.Create;
      mParHand.Line := oAddFile;
      If mParHand.ParExist('STM') then begin
        DeleteRecItem (pSTM,mGsCode,'GsCode',mParHand.ParValue('STM')); // Vymaze polozky STM
        LoadRecToItem (gPath.RcvPath+pFileName,pSTM); // Nacita polozky STM
      end;
      If mParHand.ParExist('FIF') then begin
        DeleteRecItem (pFIF,mGsCode,'GsCode',mParHand.ParValue('FIF')); // Vymaze polozky FIF
        LoadRecToItem (gPath.RcvPath+pFileName,pFIF); // Nacita polozky FIF
      end;
      If mParHand.ParExist('STO') then begin
        DeleteRecItem (pSTO,mGsCode,'GsCode',mParHand.ParValue('STO')); // Vymaze polozky STO
        LoadRecToItem (gPath.RcvPath+pFileName,pSTO); // Nacita polozky STO
      end;
      If mParHand.ParExist('STP') then begin
        DeleteRecItem (pSTP,mGsCode,'GsCode',mParHand.ParValue('STP')); // Vymaze polozky STP
        LoadRecToItem (gPath.RcvPath+pFileName,pSTP); // Nacita polozky STP
      end;
      FreeAndNil (mParHand);
    end;
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

procedure TOipRcv.LoadStlFrFile(pFileName:ShortString;pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable;pInfoLine:TLabel);  // Nacita skladove karty z textoveho suboru
var mParHand:TParHand;  mHead:TDocHead;  mCodeList:TStrings;
begin
  oSucces := FALSE;   oAddFile := '';
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    pInfoLine.Visible := TRUE;
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    FreeAndNil (mHead);
    // Nacitame polozky STK,STM,FIF,STO a STP
    mCodeList := TStringList.Create;
    pInfoLine.Caption := 'NaËÌtanie skladov˝ch kariet';
    LoadCodeFrTxt (gPath.RcvPath+pFileName,'STK','GsCode',mCodeList);
    DeleteLstItem (pSTK,mCodeList,'GsCode',''); // Vymaze polozky STM
    LoadRecToItem (gPath.RcvPath+pFileName,pSTK); // Nacita polozky STM
    If (oAddFile='') then begin // Posielame vsetky prilohy
      pInfoLine.Caption := 'NaËÌtanie skladov˝ch pohybov';
      DeleteLstItem (pSTM,mCodeList,'GsCode',''); // Vymaze polozky STM
      LoadRecToItem (gPath.RcvPath+pFileName,pSTM); // Nacita polozky STM
      pInfoLine.Caption := 'NaËÌtanie FIFO kariet';
      DeleteLstItem (pFIF,mCodeList,'GsCode',''); // Vymaze polozky FIF
      LoadRecToItem (gPath.RcvPath+pFileName,pFIF); // Nacita polozky FIF
      pInfoLine.Caption := 'NaËÌtanie rezerv·ciu a objedn·vok';
      DeleteLstItem (pSTO,mCodeList,'GsCode',''); // Vymaze polozky STO
      LoadRecToItem (gPath.RcvPath+pFileName,pSTO); // Nacita polozky STO
      pInfoLine.Caption := 'NaËÌtanie v˝robn˝ch ËÌsiel';
      DeleteLstItem (pSTP,mCodeList,'GsCode',''); // Vymaze polozky STP
      LoadRecToItem (gPath.RcvPath+pFileName,pSTP); // Nacita polozky STP
    end
    else begin
      mParHand := TParHand.Create;
      mParHand.Line := oAddFile;
      If mParHand.ParExist('STM') then begin
        pInfoLine.Caption := 'NaËÌtanie skladov˝ch pohybov';
        DeleteLstItem (pSTM,mCodeList,'GsCode',mParHand.ParValue('STM')); // Vymaze polozky STM
        LoadRecToItem (gPath.RcvPath+pFileName,pSTM); // Nacita polozky STM
      end;
      If mParHand.ParExist('FIF') then begin
        pInfoLine.Caption := 'NaËÌtanie FIFO kariet';
        DeleteLstItem (pFIF,mCodeList,'GsCode',mParHand.ParValue('FIF')); // Vymaze polozky FIF
        LoadRecToItem (gPath.RcvPath+pFileName,pFIF); // Nacita polozky FIF
      end;
      If mParHand.ParExist('STO') then begin
        pInfoLine.Caption := 'NaËÌtanie rezerv·ciu a objedn·vok';
        DeleteLstItem (pSTO,mCodeList,'GsCode',mParHand.ParValue('STO')); // Vymaze polozky STO
        LoadRecToItem (gPath.RcvPath+pFileName,pSTO); // Nacita polozky STO
      end;
      If mParHand.ParExist('STP') then begin
        pInfoLine.Caption := 'NaËÌtanie v˝robn˝ch ËÌsiel';
        DeleteLstItem (pSTP,mCodeList,'GsCode',mParHand.ParValue('STP')); // Vymaze polozky STP
        LoadRecToItem (gPath.RcvPath+pFileName,pSTP); // Nacita polozky STP
      end;
      FreeAndNil (mParHand);
    end;
    If mCodeList<>nil then FreeAndNil (mCodeList);
    DeleteFile (gPath.RcvPath+pFileName);
    pInfoLine.Visible := FALSE;
  end;
end;

procedure TOipRcv.LoadGscFrFile(pFileName:ShortString;pGSCAT,pGSNOTI,pBARCODE:TNexBtrTable);  // Nacita skladove karty z textoveho suboru
var mGsCode:longint;  mHead:TDocHead;
begin
  oSucces := FALSE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mGsCode := ValInt(copy(pFileName,9,6));
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    // Nacitame udaje tovarovej karty
    If pGSCAT.FindKey([mGsCode])
      then pGSCAT.Edit
      else pGSCAT.Insert;
    TXT_To_BTR (gPath.RcvPath+pFileName,pGSCAT,mHead);
    pGSCAT.Post;
    FreeAndNil (mHead);
    // Nacitame polozky STM a FIF
    DeleteRecItem (pGSNOTI,mGsCode,'GsCode',''); // Vymaze polozky STM
    LoadRecToItem (gPath.RcvPath+pFileName,pGSNOTI); // Nacita polozky STM
    DeleteRecItem (pBARCODE,mGsCode,'GsCode',''); // Vymaze polozky FIF
    LoadRecToItem (gPath.RcvPath+pFileName,pBARCODE); // Nacita polozky FIF
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

procedure TOipRcv.LoadPacFrFile (pFileName:ShortString;pPAB,pPABACC,pPACNTC,pPASUBC,pPANOTI:TNexBtrTable);  // Nacita kartu partnera z textoveho suboru
var mPaCode:longint;  mHead:TDocHead;
begin
  oSucces := FALSE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mPaCode := ValInt(copy(pFileName,9,6));
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    // Nacitame udaje skladovej karty
    If pPAB.FindKey([mPaCode])
      then pPAB.Edit
      else pPAB.Insert;
    TXT_To_BTR (gPath.RcvPath+pFileName,pPAB,mHead);
    pPAB.Post;
    FreeAndNil (mHead);
    // Nacitame polozky STM a FIF
    DeleteRecItem (pPABACC,mPaCode,'PaCode',''); // Vymaze bankove ucty partnera
    LoadRecToItem (gPath.RcvPath+pFileName,pPABACC); // Nacita bankove ucty partnera
    DeleteRecItem (pPACNTC,mPaCode,'PaCode',''); // Vymaze kontakty partnera
    LoadRecToItem (gPath.RcvPath+pFileName,pPACNTC); // Nacita kontakty partnera
    DeleteRecItem (pPASUBC,mPaCode,'PaCode',''); // Vymaze prevadzky partnera
    LoadRecToItem (gPath.RcvPath+pFileName,pPASUBC); // Nacita prevadzky partnera
    DeleteRecItem (pPANOTI,mPaCode,'PaCode',''); // Vymaze poznamky partnera
    LoadRecToItem (gPath.RcvPath+pFileName,pPANOTI); // Nacita poznamky partnera
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

procedure TOipRcv.LoadPlcFrFile (pFileName:ShortString;pPLS,pPLH:TNexBtrTable);  // Nacita kartu partnera z textoveho suboru
var mGsCode:longint;  mHead:TDocHead;
begin
  oSucces := FALSE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mGsCode := ValInt(copy(pFileName,9,6));
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    // Nacitame udaje skladovej karty
    If pPLS.FindKey([mGsCode])
      then pPLS.Edit
      else pPLS.Insert;
    TXT_To_BTR (gPath.RcvPath+pFileName,pPLS,mHead);
    pPLS.Post;
    FreeAndNil (mHead);
    // Nacitame historiu zmeny prdajnych cien
    DeleteRecItem (pPLH,mGsCode,'GsCode',''); // Vymaze historiu zmeny predajnych cien
    LoadRecToItem (gPath.RcvPath+pFileName,pPLH); // Nacita historiu zmeny predajnych cien
    DeleteFile (gPath.RcvPath+pFileName);
    // Ulozime polozku do REF suborov
    gPlsRef := TPlsRef.Create;
    gPlsRef.AddToRefData ('M',pPLS); // Ulozi zaznam z PLS kde stoji kurzor do vsetkych pokladnic, ktore pouzivaju dany cennik
    gPlsRef.SaveToRefFile(pPLS.BookNum,nil);
    FreeAndNil (gPlsRef);
  end;
end;

procedure TOipRcv.LoadWGIFrFile (pFileName:ShortString;pWGI:TNexBtrTable);  // Nacita vahovy tovar
var mGsCode:longint;  mHead:TDocHead;
begin
  oSucces := FALSE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mGsCode := ValInt(copy(pFileName,9,6));
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    FreeAndNil (mHead);
    // Nacitame vahovy tovar
    DeleteRecItem (pWGI,mGsCode,'GsCode','');     // Vymaze
    LoadRecToItem (gPath.RcvPath+pFileName,pWGI); // Nacita 
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

procedure TOipRcv.LoadScsFrFile (pFileName:ShortString;pFGPALST,pFGPADSC:TNexBtrTable);  // Nacita kartu partnera z textoveho suboru
var mPaCode:longint;  mHead:TDocHead;
begin
  oSucces := FALSE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mPaCode := ValInt(copy(pFileName,5,10));
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    // Nacitame udaje skladovej karty
    If pFGPALST.FindKey([mPaCode])
      then pFGPALST.Edit
      else pFGPALST.Insert;
    TXT_To_BTR (gPath.RcvPath+pFileName,pFGPALST,mHead);
    pFGPALST.Post;
    FreeAndNil (mHead);
    // Nacitame historiu zmeny prdajnych cien
    DeleteRecItem (pFGPADSC,mPaCode,'PaCode',''); // Vymaze polozky obchodnych podmienok vybraneho partnera
    LoadRecToItem (gPath.RcvPath+pFileName,pFGPADSC); // Nacita polozky obchodnych podmienok vybraneho partnera
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

procedure TOipRcv.LoadDocFrFile (pFileName:ShortString;pHeadTable,pItemTable1,pItemTable2,pNotiTable:TNexBtrTable);  // Nacita doklad z textoveho suboru
var mHead:TDocHead;  mSerNum:longint;   mDstAcc:Str1;
begin
  oSucces := FALSE;  oSndCon := TRUE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    oCommand := mHead.ReadString ('Command');
    oAddFile := mHead.ReadString ('AddFile');
    // Nacitame udaje skladovej karty
    If pHeadTable.IndexName<>'DocNum' then pHeadTable.IndexName:='DocNum';
    If oCommand='NEWDOC' then begin // Je to presun dokladu - vygenerujeme nove cislo dokladu
      pHeadTable.Last;
      mSerNum := pHeadTable.FieldByName('SerNum').AsInteger+1;
      oDocNum := copy(pHeadTable.FieldByName('DocNum').AsString,1,7)+StrIntZero(mSerNum,5);
    end
    else oDocNum := copy(pFileName,3,12);
    // Zistime ci je zauctovany
    mDstAcc := '';
    If pHeadTable.FindKey([oDocNum]) then begin
      If pHeadTable.FindField('DstAcc')<>nil then mDstAcc := pHeadTable.FieldByName('DstAcc').AsString;
    end;
    // Nacitame doklad
    If mDstAcc<>'A' then begin
      If pHeadTable.FindKey([oDocNum])
        then pHeadTable.Edit
        else pHeadTable.Insert;
      TXT_To_BTR (gPath.RcvPath+pFileName,pHeadTable,mHead);
      If oCommand='NST' then pHeadTable.FieldByName('DstLck').AsInteger := 0; // Ak je nastavena zmena priznaku na neodpocitany odblokujeme doklad
      If oCommand='NEWDOC' then begin // Je to presun dokladu - vygenerujeme nove cislo dokladu
        oSndCon := FALSE;
        pHeadTable.FieldByName ('SerNum').AsInteger := mSerNum;
        pHeadTable.FieldByName ('DocNum').AsString := oDocNum;
      end;
      pHeadTable.Post;
      FreeAndNil (mHead);
      If (oCommand<>'UPDATE') and (oCommand<>'NEWDOC') then begin
        // Vymazeme udaje
        If pItemTable1<>nil then DeleteDocItem (pItemTable1,oDocNum,'DocNum'); // Vymaze polozky dokladu
        If pItemTable2<>nil then DeleteDocItem (pItemTable2,oDocNum,'DocNum'); // Vymaze polozky dokladu
        If pNotiTable<>nil  then DeleteDocItem (pNotiTable,oDocNum,'DocNum');  // Vymaze poznamky dokladu
      end
      else oSndCon := FALSE;
      If pItemTable1<>nil then LoadDocToItem (gPath.RcvPath+pFileName,pItemTable1,oDocNum); // Nacita polozky dokladu
      If pItemTable2<>nil then LoadDocToItem (gPath.RcvPath+pFileName,pItemTable2,oDocNum); // Nacita polozky dokladu
      If pNotiTable<>nil  then LoadDocToItem (gPath.RcvPath+pFileName,pNotiTable,oDocNum);  // Nacita poznamky dokladu
    end
    else WriteToMsg (pHeadTable.FieldByName ('DocNum').AsString,'A');
  end;
end;

procedure TOipRcv.LoadConFrFile (pFileName:ShortString;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o prijati dokladu
var mFieldList:TStrings;  mFile:TIniFile;  mSdfName:ShortString;  mDocNum:Str12;
begin
  mSdfName := pHeadTable.FixedName+'-O.SDF';
  If FileExists (gPath.DefPath+mSdfName) then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+mSdfName);
    If mFieldList.Count>0 then begin
      If FileExists (gPath.RcvPath+pFileName) then begin
        mFile := TIniFile.Create(gPath.RcvPath+pFileName);
        mDocNum := mFile.ReadString ('HEAD','DocNum','');
        pHeadTable.SwapIndex;
        If pHeadTable.IndexName<>'DocNum' then pHeadTable.IndexName := 'DocNum';
        If pHeadTable.FindKey ([mDocNum]) then begin
          If pHeadTable.FindField('SndStat')<>nil then begin // Ak existuje pole SndStat
            pHeadTable.Edit;
            If ConVerifyOk(mFieldList,mFile,pHeadTable)
              then pHeadTable.FieldByName ('SndStat').AsString := 'O'
              else pHeadTable.FieldByName ('SndStat').AsString := 'E';
            pHeadTable.Post;
          end;
        end else MessageDlg('Chyba potvrdenky', mtInformation,[mbOk], 0);
        pHeadTable.RestoreIndex;
        FreeAndNil (mFile);
        DeleteFile (gPath.RcvPath+pFileName);
      end;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+mSdfName);
end;

procedure TOipRcv.LoadAccFrFile (pFileName:ShortString;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o zauctovani dokladu
var mHead:TDocHead;  mCommand:ShortString;
begin
  oSucces := FALSE;
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    oDocNum := copy(pFileName,3,12);
    mHead := TDocHead.Create;
    mHead.LoadFromFile (gPath.RcvPath+pFileName);
    mCommand := mHead.ReadString('Command');
    FreeAndNil (mHead);
    dmLDG.btJOURNAL.Open;
    dmLDG.btJOURNAL.IndexName := 'DocNum';
    DeleteDocItem (dmLDG.btJOURNAL,oDocNum,'DocNum'); // Vymaze polozky zadaneho dokladu
    If mCommand='ACC' then LoadDocToItem (gPath.RcvPath+pFileName,dmLDG.btJOURNAL,oDocNum); // Nacita polozky dokladu
    // Oznacime hlavicku dokladu
    If pHeadTable.IndexName<>'DocNum' then pHeadTable.IndexName:='DocNum';
    If pHeadTable.FindKey([oDocNum]) then begin
      pHeadTable.Edit;
      If oItmQnt>0 then begin
        pHeadTable.FieldByName('DstAcc').AsString := 'A';
        pHeadTable.FieldByName('DstLck').AsInteger := 1;
      end
      else begin
        pHeadTable.FieldByName('DstAcc').AsString := '';
        pHeadTable.FieldByName('DstLck').AsInteger := 0;
      end;
      pHeadTable.Post;
    end;
    dmLDG.btJOURNAL.Close;
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

procedure TOipRcv.LoadPmdFrFile (pFileName:ShortString;pPMI:TNexBtrTable);  // Nacita historiu uhrady faktury
var I:word;  mItems:TDocItem;  mFieldName:Str20;  mFieldType:TFieldType;
    mBookNum:Str5;  mDocNum:Str12;
begin
  oSucces := FALSE;
  oDocNum := copy(pFileName,3,12);
  If FileExists (gPath.RcvPath+pFileName) then begin
    oSucces := TRUE;
    // Vymzeme vsetky uhrady danej faktury
    If pPMI.FindKey ([oDocNum]) then begin
      Repeat
        pPMI.Delete;
        Application.ProcessMessages;
      until (pPMI.Eof) or (pPMI.RecordCount=0) or (pPMI.FieldByName('DocNum').AsString<>oDocNum);
    end;
    // Ulozime nove uhrady
    mItems := TDocItem.Create;
    mItems.LoadFromFile(gPath.RcvPath+pFileName,'PMI');
    If mItems.Count>0 then begin
      mItems.First;
      Repeat
        If mItems.Line then begin // AK je to riadok s textovym zaznamom
          pPMI.Insert;
          For I:=0 to pPMI.FieldCount-1 do begin
            try
              mFieldName := pPMI.Fields[I].FieldName;
              mFieldType := pPMI.FieldByName(mFieldName).DataType;
              case mFieldType of
                ftFloat: pPMI.FieldByName(mFieldName).AsFloat := mItems.ReadFloat (mFieldName);
                 ftDate: pPMI.FieldByName(mFieldName).AsDateTime := mItems.ReadDate (mFieldName);
                   else  pPMI.FieldByName(mFieldName).AsString := mItems.ReadString (mFieldName);
              end;
            except end;
          end;
          pPMI.Post;
        end;                                
        // Prepocitame uhradu na fakture
        mDocNum := pPMI.FieldByName('ConDoc').AsString;
        mBookNum := BookNumFromDocNum (mDocNum);
        If copy(mDocNum,1,2)='OF' then begin // Zaciname s odberatelskymi fakturami
          dmLDG.OpenBook(dmLDG.btICH,mBookNum);  dmLDG.btICH.IndexName := 'DocNum';
          If dmLDG.btICH.FindKey([mDocNum]) then IchPayValRecalc (dmLDG.btICH); // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA
          dmLDG.btICH.Close;
        end;
        If copy(mDocNum,1,2)='DF' then begin // Zaciname s dodavatelskymi fakturami
          dmLDG.OpenBook(dmLDG.btISH,mBookNum);  dmLDG.btISH.IndexName := 'DocNum';
          If dmLDG.btISH.FindKey([mDocNum]) then IshPayValRecalc (dmLDG.btISH); // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA
          dmLDG.btISH.Close;
        end;
        Application.ProcessMessages;
        mItems.Next;
      until mItems.Eof;
    end;
    FreeAndNil (mItems);
    DeleteFile (gPath.RcvPath+pFileName);
  end;
end;

end.
