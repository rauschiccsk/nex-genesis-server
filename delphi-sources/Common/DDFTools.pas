unit DDFTools; //by Laci 1999.6.17.
//Ez a unit a Btrieve DDF kezelot fogja tarolni
(*
CREATE TABLE msgdis USING 'C:\NEX\YEAR2007\SYSTEM\MSGDIS.BTR'
 LogUser varchar (9)  ,
 MsgCode uinteger (4)  ,
 SlctBut utinyint (1)  ,
 CrtDate usmallint (2)  ,
 CrtTime uinteger (4) )
 WITH INDEX ( LogUser UNIQUE SEG  , MsgCode UNIQUE )


CREATE TABLE msgdis USING '\MSGDIS.BTR'
(LogUser varchar(9),
 MsgCode uinteger,
 SlctBut utinyint,
 CrtDate usmallint,
 CrtTime uinteger)#
CREATE INDEX I_MsgDis_1 on msgdis (LogUser, MsgCode)

CREATE TABLE msgdis using '\msgdis.btr'
(unnamed_0 VARCHAR(9) NOT NULL,
unnamed_1 UINTEGER NOT NULL,
unnamed_2 UTINYINT NOT NULL,
unnamed_3 USMALLINT NOT NULL,
unnamed_4 UINTEGER NOT NULL)#
CREATE INDEX index_1 ON msgdis(unnamed_0 , unnamed_1 )#
*)

interface


uses
  {AgySoft}   IcTools, BtrStruct, BtrTools, BtrHand,
  {Pervasive} BtrConst, BtrAPI32, sqlapi32,
  {Delphi}    classes, SysUtils;

type
  TDDFIndexFields = array [1..cMaxIndexesNumBtr] of record
    IndexName  :string;
    IndexFields:string;
  end;

const
  cFILE_DDF  = 'file.ddf';
  cFIELD_DDF = 'field.ddf';
  cINDEX_DDF = 'index.ddf';
  cSUCCESS   =  0;
  cFAILURE   = -1;
var
  cUserID    : CHAR = #0;
  cPassword  : CHAR = #0;
  cReserved  : CHAR = #0;

  cAP        : CHAR = #39; //Ez az apostrof (')


//protected
  function  GetFileID(pDDFPAth: string; pTableName: string): integer;

//public
  function  ReadDDFFile(pDDFPAth: string; pTableName: string; var pBuffer: PFile_DDF_Rec): BTR_Status;
  function  ReadDDFField(pDDFPAth: string; pTableName: string; var pFieldList: TList): BTR_Status;
  function  ReadDDFIndex(pDDFPAth: string; pTableName: string; var pList: TList): BTR_Status;

  function  ReadStatistics(pDDFPAth: string; pTableName: string; var pFileSpecs: FILE_SPECS; var pKeySpecList: TList): BTR_Status;

  function  BtrTableNameToFileName(pDDFPAth: string; pTableName: string):string;

  function  WriteDDFFile(pDDFPAth: string; var pBuffer: PFile_DDF_Rec): BTR_Status;
  function  WriteDDFField(pDDFPAth: string; var pFieldList: TList): BTR_Status;
  function  WriteDDFIndex(pDDFPAth: string; var pList: TList): BTR_Status;

  function  GetFreeFileID(pDDFPAth: string): integer;
  function  GetFreeFieldID(pDDFPAth: string): integer;

  function  DEF_To_DDF(pDefFile: string; pBTRFile: string; pDDFPAth: string):boolean;

  //procedure DEF_To_File(pDDFPAth: string; pBTRFile: string; pDefFile: string; var pFileDDFRecBuf: PFile_DDF_Rec);
  procedure DEF_To_FieldList(pDEFList: TStringList; var pFieldList: TList; pFileID: word; pFieldID: word;var pFullList:TStringlist);
  procedure DEF_To_IndexList(pDEFList: TStringList; var pFieldList: TList; var pIndexList: TList);
  procedure DEF_To_IndexNames(pDEFList: TStringList; var pIndexList: string);

  procedure SetNewFileDDFRec(pID: word; pName: string; pLoc: string; var pFileDDFRecBuf: PFile_DDF_Rec);

  procedure DEFTableToTableNameAndTableType(pTable: string; var pTableName: string; var pTableType: string);
  procedure DEFFieldToFieldNameAndFieldType(pField: string; var pFieldName: string; var pFieldType: string;var pFullName:string);
  procedure DEFFieldTypeToBTRDataTypeAndSize(pFieldType: string; var pDataType: byte; var pSize: word; var pICCDataType: byte); //plusz meg visszaadja az ICC DataTypet is
  procedure DEFFieldTypeToSQLType           (pFieldType: string; var pSqlType: string;var pSize: word);

  procedure INDStrToIndexFields(pINDStr: string; var pIndexFieldsStr: string; var pIndexNameStr: string);
  procedure GLBStrToGlobalFlags(pGLBStr: string; var pGlobalFlagsStr: string);
  procedure SEGStrToSegmentFlags(pSEGStr: string; var pSegmentFlagsStr: string);

  procedure FlagsStrToFlags(pFlagsStr: string; var pFlags: word);
  function  FindByNameFieldID(pFieldList: TList; pFieldNameStr: string): PField_DDF_Rec;

  procedure BTRXQLCompile(pDDFPath: string; pBTRPath: string; pSQLString: string);
  procedure DEF_To_SQL(pDEFFile: string; var pSQLString: string);
  procedure DEF_To_Lists(pDEFFile: string; var pFL,pIL:TStrings);
  procedure FlagsToSQLFlags(pFlags: word; var pSQLFlags: string);

  procedure ValidateFieldName(var pFieldNameStr: string);

  procedure ClearDDFIndex; //29.10.2003 Tibi - vynuluje premennú uDDFIndexFields
//moved to AgyTo  function  TableName_To_DefFileName(pTableName: string):string;

var
  uDDFIndexQnt:longint;
  uDDFIndexFields:TDDFIndexFields;

implementation


//*******************************
// Mintapelda a Tabla crealashoz
//*******************************
{CREATE TABLE Room USING 'Room.mkd'
   (
     Building_Name CHAR(25) CASE,
     Number UNSIGNED(4),
     Capacity INTEGER(2),
     "Type" CHAR(20) CASE
   )
 WITH INDEX
   (
     Building_Name SEG, Number UNIQUE,
     "Type"
   )
}
{moved to AgyTo
function  TableName_To_DefFileName(pTableName: string):string;
  begin   // Pl. PART001 -> dPART.DEF
     while (pTableName[length(pTableName)] in ['0'..'9']) do delete(pTableName,length(pTableName),1);
     Result := 'd'+pTableName+'.DEF';
  end;
}
procedure ValidateFieldName(var pFieldNameStr: string);
  begin
    if (length(pFieldNameStr) > 0) then begin
      if (pFieldNameStr[1] = '_') then begin
        delete(pFieldNameStr, 1, 1);
        pFieldNameStr := pFieldNameStr + '_';
      end;
    end;
  end;


procedure FlagsToSQLFlags(pFlags: word; var pSQLFlags: string);
  begin
    pSQLFlags := '';
    if not ((pFlags and KFLG_DUP) > 0) then pSQLFlags := pSQLFlags + 'UNIQUE ';
    if (pFlags and KFLG_MODX) > 0 then pSQLFlags := pSQLFlags + 'MOD ';
    if (pFlags and KFLG_NUL) > 0 then pSQLFlags := pSQLFlags + 'NULL ';
    if (pFlags and KFLG_SEG) > 0 then pSQLFlags := pSQLFlags + 'SEG ';
    if (pFlags and KFLG_DESC_KEY) > 0 then pSQLFlags := pSQLFlags + 'DESC ';
    if (pFlags and KFLG_NOCASE_KEY) > 0 then pSQLFlags := pSQLFlags + 'CASE ';
    {ami kimaradt:  |  |  |  | ASC |  |  }
  end;

procedure DEF_To_SQL(pDEFFile: string; var pSQLString: string);
  var
    mDEFList: TStringList;
    mTableFileNameStr: string;
    mTableNameStr: string;
    mTableTypeStr: string;
    mFieldNameStr: string;
    mFieldTypeStr: string;
    mStr         : string;
    mDataType    : byte;
    mICCDataType : byte;
    mSize        : word;
    mINDStr      : string;
    mGLBStr      : string;
    mSEGStr      : string;
    mIndexFieldsStr : string;
    mIndexNameStr   : string;
    mGlobalFlagsStr : string;
    mSegmentFlagsStr: string;
    mLEN, i         : integer;
    mGlobalFlags    : word;
    mLocalFlags     : word;
    mFirstSegment   : boolean;
    mFirstField     : boolean;
    mSQLFlags       : string;
    mFullName       : string;
    mSQLType        : string;
  begin
    ClearDDFIndex;
    pSQLString := '';
    mFirstSegment := TRUE;
    mFirstField := TRUE;
    mDEFList := TStringList.Create;
    try
      mDEFList.LoadFromFile(pDEFFile);
      mStr := mDEFList[0];
      if (mDEFList.Count > 0) then mDEFList.Delete(0);
      if (mDEFList.Count > 0) then mDEFList.Delete(0);

      DEFTableToTableNameAndTableType(mStr, mTableFileNameStr, mTableTypeStr);
      mTableNameStr := copy(mTableFileNameStr,1,pos('.', mTableFileNameStr)-1);
      mTableNameStr := lowercase(mTableNameStr);
      pSQLString := 'CREATE TABLE ' + mTableNameStr + ' USING '+cAP + mTableFileNameStr + cAP+ ' ';
      // Elso sor Ok

      pSQLString := pSQLString + '( ';
      while (mDEFList.Count > 0) and (mDEFList[0] <> '') do begin
        mStr := mDEFList[0];
        mDEFList.Delete(0);

        DEFFieldToFieldNameAndFieldType(mStr, mFieldNameStr, mFieldTypeStr,mFullName);
        DEFFieldTypeToBTRDataTypeAndSize(mFieldTypeStr, mDataType, mSize, mICCDataType);
        DEFFieldTypeToSqlType(mFieldTypeStr, mSqlType, mSize);
        if mFirstField then begin
//          pSQLString := pSQLString + mFieldNameStr + ' ' + cKeyToSQL[mDataType] +' ('+IntToStr(mSize)+') ';
          If mSize>0
            then pSQLString := pSQLString + mFieldNameStr + ' ' + mSQLType +' ('+IntToStr(mSize)+') '
            else pSQLString := pSQLString + mFieldNameStr + ' ' + mSQLType;
          mFirstField := FALSE;
        end else begin
//          pSQLString := pSQLString + ' , ' + mFieldNameStr + ' ' + cKeyToSQL[mDataType] +' ('+IntToStr(mSize)+') '; //+ ' ' + 'CASE';
          If mSize>0
            then pSQLString := pSQLString + ' , ' + mFieldNameStr + ' ' + mSQLType +' ('+IntToStr(mSize)+') '
            else pSQLString := pSQLString + ' , ' + mFieldNameStr + ' ' + mSQLType;
        end;
      end;
      if (mDEFList.Count > 0) then mDEFList.Delete(0);
      pSQLString := pSQLString + ') ';
      // Field sorok Ok

//      pSQLString := pSQLString + 'WITH INDEX ( ';
      pSQLString := pSQLString + '#'+#13+#10;
      while (mDEFList.Count > 3) do begin
        mINDStr := mDEFList[0]; mDEFList.Delete(0);
        mGLBStr := mDEFList[0]; mDEFList.Delete(0);
        mSEGStr := mDEFList[0]; mDEFList.Delete(0);
        mStr    := mDEFList[0]; mDEFList.Delete(0);

        INDStrToIndexFields(mINDStr, mIndexFieldsStr, mIndexNameStr); // pl "MGCode,GSCode" & "MgGS"
        GLBStrToGlobalFlags(mGLBStr, mGlobalFlagsStr);  // pl visszatero ertek "cModif+cDuplic+cInsensit"
        SEGStrToSegmentFlags(mSEGStr, mSegmentFlagsStr); // pl visszatero ertek "cModif+cDuplic|cModif+cDuplic"
        pSQLString := pSQLString + 'CREATE INDEX '+mTableNameStr+'_'+mIndexnameStr+'ON '+mTableNameStr+'( ';
        //ures stringel ter vissza ez egyenlore meg nem biztos hogy mukodni fog;

        mLEN := LineElementNum(mIndexFieldsStr, ',');
        if (mLEN > 0) then begin
          FlagsStrToFlags(mGlobalFlagsStr, mGlobalFlags);
          mGlobalFlags := mGlobalFlags or KFLG_EXTTYPE_KEY; //mivel ez mindig be van allitva
          for i := 0 to mLEN-1 do begin
            mFieldNameStr := LineElement(mIndexFieldsStr, i, ',');
            ValidateFieldName(mFieldNameStr); // Ez ellenorzi es kijavitja a field namekat pl '_GSName' -> 'GSName_'
            //mLocalFlagsStr := LineElement(mSegmentFlagsStr, i, '|');
            //FlagsStrToFlags(mLocalFlagsStr, mLocalFlags); //egyenlore itt onak kell lennie
            mLocalFlags := 0; // mivel meg nem mukodik rendesen a SEGStrToSegmentFlags eljaras
            if (i < mLEN - 1) then  mLocalFlags := mLocalFlags or KFLG_SEG; //tehat nem az utolso szegnnems
            mLocalFlags := mLocalFlags or mGlobalFlags;
            if (mLocalFlags and KFLG_MANUAL_KEY)>0 then begin
            end;
            if  (mLocalFlags and KFLG_NOCASE_KEY) > 0 then begin
//              FindByNameFieldID(pFieldList, mFieldNameStr)^.Xe_Flags := 0;
            end;
            //mLocalFlags :=  mLocalFlags and 511;
            FlagsToSQLFlags(mLocalFlags, mSQLFlags);
            if mFirstSegment then begin
              pSQLString := pSQLString + mFieldNameStr + ' ' + mSQLFlags;
              mFirstSegment := FALSE;
            end else begin
              pSQLString := pSQLString + ' , ' + mFieldNameStr + ' ' + mSQLFlags;
            end;
          end;
        end;
        pSQLString := pSQLString + ')#'+#13+#10;
      end;

//      pSQLString := pSQLString + ')';
    except end;
    mDEFList.Free;
  end;

procedure DEF_To_Lists(pDEFFile: string; var pFL,pIL:TStrings);
  var
    mDEFList: TStringList;
    mTableFileNameStr: string;
    mTableNameStr: string;
    mTableTypeStr: string;
    mFieldNameStr: string;
    mFieldTypeStr: string;
    mStr         : string;
    mDataType    : byte;
    mICCDataType : byte;
    mSize        : word;
    mINDStr      : string;
    mGLBStr      : string;
    mSEGStr      : string;
    mIndexFieldsStr : string;
    mIndexNameStr   : string;
    mGlobalFlagsStr : string;
    mSegmentFlagsStr: string;
    mLEN, i         : integer;
    mGlobalFlags    : word;
    mLocalFlags     : word;
    mFirstSegment   : boolean;
    mFirstField     : boolean;
    mSQLFlags       : string;
    mFullName       : string;
    mSQLType        : string;
  begin
    pIL.Clear;pFL.Clear;
    mFirstSegment := TRUE;
    mFirstField := TRUE;
    mDEFList := TStringList.Create;
    try
      mDEFList.LoadFromFile(pDEFFile);
      mStr := mDEFList[0];
      if (mDEFList.Count > 0) then mDEFList.Delete(0);
      if (mDEFList.Count > 0) then mDEFList.Delete(0);

      while (mDEFList.Count > 0) and (mDEFList[0] <> '') do begin
        mStr := mDEFList[0];
        mDEFList.Delete(0);

        DEFFieldToFieldNameAndFieldType(mStr, mFieldNameStr, mFieldTypeStr,mFullName);
        DEFFieldTypeToBTRDataTypeAndSize(mFieldTypeStr, mDataType, mSize, mICCDataType);
        DEFFieldTypeToSqlType(mFieldTypeStr, mSqlType, mSize);
        pFL.Add(mFieldNameStr+'|'+mFieldTypeStr+'|'+mFullName)
      end;
      if (mDEFList.Count > 0) then mDEFList.Delete(0);
      while (mDEFList.Count >= 3) do begin
        mINDStr := mDEFList[0]; mDEFList.Delete(0);
        mGLBStr := mDEFList[0]; mDEFList.Delete(0);
        mSEGStr := mDEFList[0]; mDEFList.Delete(0);
        If pos('=',mINDStr)=0 then begin
          mINDStr:=mINDStr+'='+RemSpaces(Copy(mINDStr,4,100));
        end;
        If mDEFList.Count>=1 then begin mStr := mDEFList[0]; mDEFList.Delete(0) end else mStr:='';

        INDStrToIndexFields(mINDStr, mIndexFieldsStr, mIndexNameStr); // pl "MGCode,GSCode" & "MgGS"
        GLBStrToGlobalFlags(mGLBStr, mGlobalFlagsStr);  // pl visszatero ertek "cModif+cDuplic+cInsensit"
        SEGStrToSegmentFlags(mSEGStr, mSegmentFlagsStr); // pl visszatero ertek "cModif+cDuplic|cModif+cDuplic"
        mFieldNameStr:=mIndexFieldsStr;
        mIndexFieldsStr:='';
        for mLen:=0 to LineElementNum(mFieldNameStr,',')-1 do begin
          mFieldTypeStr:=LineElement(mFieldNameStr,mLen,',');ValidateFieldName(mFieldTypeStr);
          mIndexFieldsStr:=mIndexFieldsStr+','+mFieldTypeStr;
        end;
        Delete (mIndexFieldsStr,1,1);
        pIL.Add(mIndexnameStr+'|'+mIndexFieldsStr)
      end;
    except end;
    mDEFList.Free;
  end;

procedure BTRXQLCompile(pDDFPath: string; pBTRPath: string; pSQLString: string);
  var
    mDDpath      : string[30];      { IMPORTANT }
    mDatapath    : string[30];      { IMPORTANT }
    mStatus      : smallint;
    mCursorID    : smallint;
    mSQLSring    : string;      { IMPORTANT }
    mSQLSringLen : smallint;
    mCursorIDFlag: boolean;
    mLoginFlag   : boolean;
  begin
    mDDpath   := pDDFPath + #0; //'c:\pvsw\demodata';
    mDatapath := pBTRPath + #0; //'c:\pvsw\demodata';
    mSQLSring := pSQLString; //'SELECT * from person where ID = 101135758 ' + #0;

    mCursorIDFlag := FALSE;

    mStatus := XQLLogin(
                   cUserID,
                   cPassword,
                   mDDpath[1],
                   mDatapath[1],
                   cReserved,
                   1);

    if mStatus <> cSUCCESS then begin
      mStatus    := cFAILURE;
      mLoginFlag :=  FALSE;
    end else begin
      mLoginFlag := TRUE;
    end;


    if (mStatus = cSUCCESS) then begin

      mStatus := XQLCursor (mCursorID);

      if mStatus <> cSUCCESS then begin
        mStatus       := cFAILURE;
        mCursorIDFlag := FALSE;
      end else begin
        mCursorIDFlag := TRUE;
      end;
    end;


    if (mStatus = cSUCCESS) then begin
      mSQLSringLen   := length (mSQLSring);
      mStatus := XQLCompile(
                   mCursorID,
                   mSQLSringLen,
                   mSQLSring[1]);


      if mStatus > cSUCCESS then begin
        mStatus := cFAILURE;
      end else begin
        mStatus := cSUCCESS;
      end;
    end;


    if mCursorIDFlag then begin
      mStatus := XQLFree(mCursorID);
    end;
    if mLoginFlag then begin
      mStatus := XQLLogout;
    end;
  end;


function  FindByNameFieldID(pFieldList: TList; pFieldNameStr: string): PField_DDF_Rec;
  var
    mFieldDDFRecBuf: PField_DDF_Rec;
    mName,mName_: string;
    i, j: integer;
  begin
    Result := nil;
    pFieldNameStr := uppercase(pFieldNameStr);
    if not assigned(pFieldList) then exit;
    if (pFieldList.Count > 0) then begin
      i := 0;
      repeat
        mFieldDDFRecBuf := pFieldList.Items[i];
        mName := '';
        j := 0;
        while (j < 20)  and (mFieldDDFRecBuf^.Xe_Name[j] <> ' ') do begin
          mName := mName + mFieldDDFRecBuf^.Xe_Name[j];
          inc(j);
        end;
        mName := uppercase(mName);
        If pFieldNameStr[1]='_' then mName_:='_'+Copy(mName,1,Length(mName)-1) else mName_:=mName;
        inc(i);
      until (i >= pFieldList.Count) or (mName = pFieldNameStr) or (mName_ = pFieldNameStr);
      if (mName = pFieldNameStr) or (mName_ = pFieldNameStr) then begin
        Result := mFieldDDFRecBuf;
      end;
    end;
  end;

procedure FlagsStrToFlags(pFlagsStr: string; var pFlags: word);
  var
    mLEN, i: integer;
    mFlagStr: string;
  begin
    // pl "cModif+cDuplic+cInsensit" -> 234
    // figyelni kell meg a vissza teresnel az insenzitivre es arra hogy segmens e?

    pFlags := 0;
    mLEN := LineElementNum(pFlagsStr, '+');
    if (mLEN > 0) then begin
      for i:= 0 to mLEN -1 do begin
        mFlagStr := LineElement(pFlagsStr, i, '+');

        {case}   if mFlagStr = 'cDuplic' then begin
          pFlags := pFlags or KFLG_DUP;
        end else if mFlagStr = 'cModif' then begin
          pFlags := pFlags or KFLG_MODX;
        end else if mFlagStr = 'cBinar' then begin  //no ezt csak en talaltam ki de ez mindig nnullla
          pFlags := pFlags or KFLG_BIN;
        end else if mFlagStr = 'cNullAll' then begin
          pFlags := pFlags or KFLG_NUL;
        end else if mFlagStr = 'cAltSeq' then begin
          pFlags := pFlags or KFLG_ALT;
        end else if mFlagStr = 'cDescend' then begin
          pFlags := pFlags or KFLG_DESC_KEY;
        end else if mFlagStr = 'cReDuplic' then begin
          pFlags := pFlags or KFLG_REPEAT_DUPS_KEY;
        end else if mFlagStr = 'cNullAny' then begin
          pFlags := pFlags or KFLG_MANUAL_KEY;
        end else if mFlagStr = 'cInsensit' then begin
          pFlags := pFlags or KFLG_NOCASE_KEY;
        end;{caseend}

      end;
    end;
  end;

procedure INDStrToIndexFields(pINDStr: string; var pIndexFieldsStr: string; var pIndexNameStr: string);
var mPos:byte;
begin
  // Pl.   "  IND MGCode,GSCode=MgGS" -> "MGCode,GSCode" & "ixMgGS"
  // Az MgGS bol azert lett ixMgGS mert nem lehet ugyanolyan indexname es fieldname
  pIndexFieldsStr := '';
  pIndexNameStr   := '';
  mPos := Pos('IND',pINDStr);   //RZ 25.07.2002
  If mPos>0 then begin // Ak v riadku je slovo IND
    pINDStr := RemSpaces (pINDStr);  //RZ 25.07.2002
    Delete(pINDStr, 1, 4);
    if LineElementNum(pIndStr, '=') > 1 then begin
      pIndexFieldsStr := LineElement(pINDStr, 0, '=');
      pIndexNameStr   := LineElement(pINDStr, 1, '=');
    end else begin
      pIndexFieldsStr := pINDStr;   // ide esetleg egy remspaces kene
    end;
    If uDDFIndexQnt<cMaxIndexesNumBtr then begin
      Inc (uDDFIndexQnt);
      uDDFIndexFields[uDDFIndexQnt].IndexName := pIndexNameStr;
      uDDFIndexFields[uDDFIndexQnt].IndexFields := ReplaceStr (pIndexFieldsStr,',',';');
    end;
  end;

end;

procedure GLBStrToGlobalFlags(pGLBStr: string; var pGlobalFlagsStr: string);
  begin
    // Pl. "  GLB cModif+cDuplic" -> "cModif+cDuplic"
    pGlobalFlagsStr := '';
    if copy(pGLBStr, 1, 6) = '  GLB ' then begin
      delete(pGLBStr, 1, 6);
      pGlobalFlagsStr := pGLBStr;
    end;
  end;

procedure SEGStrToSegmentFlags(pSEGStr: string; var pSegmentFlagsStr: string);
  begin
    // Pl. "  SEG PaPCode(cModif+cDuplic) PaSCode(cModif+cDuplic)" -> "cModif+cDuplic|cModif+cDuplic"
    //de itt muszaj lenne ellenorizni azt is hogy milyen sorrendben vannak
    pSegmentFlagsStr := '';
    // egenlore ez meg nincs kesz //???
  end;

procedure DEFTableToTableNameAndTableType(pTable: string; var pTableName: string; var pTableType: string);
  var
    mTN: boolean;
    i: integer;
  begin
    pTableName := '';
    pTableType := '';
    mTN := TRUE;
    for i:=1 to length(pTable) do begin
      if pTable[i]<>' ' then begin
        if mTN
          then pTableName := pTableName + pTable[i]
          else pTableType := pTableType + pTable[i];
      end else begin
        if pTableName <> '' then mTN := FALSE;
      end;
    end;
  end;


procedure DEFFieldToFieldNameAndFieldType(pField: string; var pFieldName: string; var pFieldType: string;var pFullName:string);
var  {mFN: boolean; i: integer;} mPos:byte;
begin
  pField := RemLeftSpaces (pField);  //Odstanime zbytocne medzery z lavej strany
  mPos := Pos(' ',pField)-1; // Koniec nazvu pola
  pFieldName := copy (pField,1,mPos);
  Delete (pField,1,mPos);  // Vymazeme nazov pola
  pField := RemLeftSpaces (pField);  //Odstanime zbytocne medzery z lavej strany
  If Pos(' ',pField)>0
    then mPos := Pos(' ',pField)-1 // Koniec typu pola
    else mPos := 0;
  If mPos=0 then mPos := 255;
  pFieldType := copy (pField,1,mPos);
  If POS(';',pField)>0
    then pFullName := Copy (pField,POS(';',pField)+1,255)
    else pFullName := '';
{
  pFieldName := '';
  pFieldType := '';
  mFN := TRUE;
  for i:=1 to length(pField) do begin
    if pField[i]<>' ' then begin
      if mFN
        then pFieldName := pFieldName + pField[i]
        else pFieldType := pFieldType + pField[i];
    end else begin
      if pFieldName <> '' then mFN := FALSE;
    end;
  end;
}
  ValidateFieldName(pFieldName);
end;

procedure DEFFieldTypeToBTRDataTypeAndSize(pFieldType: string; var pDataType: byte; var pSize: word; var pICCDataType: byte);
  var
    mFT: string;
    mLN: string;
    i: integer;
  begin
    pFieldType := LowerCase(pFieldType);
    mFT := '';
    mLN := '';
    for i := 1 to length(pFieldType) do begin
      if pFieldType[i] in ['0'..'9']
        then mLN := mLN + pFieldType[i]
        else mFT := mFT + pFieldType[i];
    end;

    if (mFT = 'longint') then begin
      pDataType    := UNSIGNED_BINARY_TYPE;
      pSize        := 4;
      pICCDataType := UNSIGNED_BINARY_TYPE;
    end else if (mFT = 'word') then begin
      pDataType    := UNSIGNED_BINARY_TYPE;
      pSize        := 2;
      pICCDataType := UNSIGNED_BINARY_TYPE;
    end else if (mFT = 'str') then begin
      pDataType    := LSTRING_TYPE;
      pSize        := StrToInt(mLN)+1;
      pICCDataType := LSTRING_TYPE;
    end else if (mFT = 'string') then begin
      pDataType    := LSTRING_TYPE;
      pSize        := 255;
      pICCDataType := LSTRING_TYPE;
    end else if (mFT = 'byte') then begin
      pDataType    := STRING_TYPE;
      pSize        := 1;
      pICCDataType := UNSIGNED_BINARY_TYPE;
    end else if (mFT = 'char') then begin
      pDataType    := STRING_TYPE;
      pSize        := 1;
      pICCDataType := STRING_TYPE;
    end else if (mFT = 'double') then begin
      pDataType    := IEEE_TYPE;
      pSize        := 8;
      pICCDataType := IEEE_TYPE;
    end else if (mFT = 'integer') then begin
      pDataType    := INTEGER_TYPE;
      pSize        := 2;
      pICCDataType := INTEGER_TYPE;
    end else if (mFT = 'single') then begin
      pDataType    := BFLOAT_TYPE;
      pSize        := 4;
      pICCDataType := BFLOAT_TYPE;
    end else if (mFT = 'intauto') then begin
      pDataType    := AUTOINCREMENT_TYPE;
      pSize        := 2;
      pICCDataType := AUTOINCREMENT_TYPE;
    end else if (mFT = 'longauto') then begin
      pDataType    := AUTOINCREMENT_TYPE;
      pSize        := 4;
      pICCDataType := AUTOINCREMENT_TYPE;
    end else if (mFT = 'timetype') then begin
      pDataType    := UNSIGNED_BINARY_TYPE;
      pSize        := 4;
      pICCDataType := TIME_TYPE;
    end else if (mFT = 'datetype') then begin
      pDataType    := UNSIGNED_BINARY_TYPE;
      pSize        := 2;
      pICCDataType := DATE_TYPE;
    end
  end;

procedure DEFFieldTypeToSQLType(pFieldType: string; var pSQLType: string; var pSize: word);
  var
    mFT: string;
    mLN: string;
    i: integer;
  begin
    pFieldType := LowerCase(pFieldType);
    mFT := '';
    mLN := '';
    for i := 1 to length(pFieldType) do begin
      if pFieldType[i] in ['0'..'9']
        then mLN := mLN + pFieldType[i]
        else mFT := mFT + pFieldType[i];
    end;

    if (mFT = 'longint') then begin
      pSQLType     := 'uinteger';
      pSize        := 0;
    end else if (mFT = 'word') then begin
      pSQLType     := 'usmallint';
      pSize        := 0;
    end else if (mFT = 'str') then begin
      pSQLType     := 'varchar';
      pSize        := StrToInt(mLN)+1;
    end else if (mFT = 'string') then begin
      pSQLType     := 'varchar';
      pSize        := 255;
    end else if (mFT = 'byte') then begin
      pSQLType     := 'utinyint';
      pSize        := 0;
    end else if (mFT = 'char') then begin
      pSQLType     := 'char';
      pSize        := 1;
    end else if (mFT = 'double') then begin
      pSQLType     := 'float';
      pSize        := 0;
    end else if (mFT = 'integer') then begin
      pSQLType     := 'usmallint';
      pSize        := 0;
    end else if (mFT = 'single') then begin
      pSQLType     := 'float';
      pSize        := 0;
    end else if (mFT = 'intauto') then begin
      pSQLType     := 'usmallint';
      pSize        := 0;
    end else if (mFT = 'longauto') then begin
      pSQLType     := 'uinteger';
      pSize        := 0;
    end else if (mFT = 'timetype') then begin
      pSQLType     := 'uinteger';
      pSize        := 0;
    end else if (mFT = 'datetype') then begin
      pSQLType     := 'usmallint';
      pSize        := 0;
    end
  end;

procedure SetNewFileDDFRec(pID: word; pName: string; pLoc: string; var pFileDDFRecBuf: PFile_DDF_Rec);
  begin
    pFileDDFRecBuf^.Xf_Id := pID;

    fillchar(pFileDDFRecBuf^.Xf_Name, sizeof(pFileDDFRecBuf^.Xf_Name), ' ');
    move(pName[1], pFileDDFRecBuf^.Xf_Name, length(pName));


    fillchar(pFileDDFRecBuf^.Xf_Loc, sizeof(pFileDDFRecBuf^.Xf_Loc), ' ');
    move(pLoc[1], pFileDDFRecBuf^.Xf_Loc, length(pLoc));

    pFileDDFRecBuf^.Xf_Flags := 0;

    fillchar(pFileDDFRecBuf^.Xf_Reserved, sizeof(pFileDDFRecBuf^.Xf_Reserved), ' ');
  end;

procedure DEF_To_FieldList(pDEFList: TStringList; var pFieldList: TList; pFileID: word; pFieldID: word;var pFullList:TStringlist);
  var
    mFieldDDFRecBuf: PField_DDF_Rec;
    mID            : integer;
    mDataType      : byte;
    mICCDataType   : byte;
    mOffset,
    mSize          : word;
    mStr           : string;
    mFieldName,mFullName,
    mFieldType     : string;
  begin
    mID := pFieldID;
    mOffset := 0;
    pFullList.Clear;
    while (pDEFList.Count > 0) and (pDEFList[0] <> '') do begin
      mStr := pDEFList[0];
      pDEFList.Delete(0);

      DEFFieldToFieldNameAndFieldType(mStr, mFieldName, mFieldType,mFullName);
      DEFFieldTypeToBTRDataTypeAndSize(mFieldType, mDataType, mSize, mICCDataType);
      pFullList.Add(mFullName);

      GetMem(mFieldDDFRecBuf,sizeof(mFieldDDFRecBuf^));


      if (pFileID = $FFFF) // csak akkor ha nem less kiirvs ddf fileba csak a komponens initfield defjebekerul ezt jelzi a $FFFF
        then mFieldDDFRecBuf^.Xe_Id := mICCDataType
        else mFieldDDFRecBuf^.Xe_Id := mID;
      mFieldDDFRecBuf^.Xe_File     := pFileID;
      fillchar(mFieldDDFRecBuf^.Xe_Name, sizeof(mFieldDDFRecBuf^.Xe_Name), ' ');
      move(mFieldName[1], mFieldDDFRecBuf^.Xe_Name, length(mFieldName));
      mFieldDDFRecBuf^.Xe_DataType := mDataType;
      mFieldDDFRecBuf^.Xe_Offset   := mOffset;
      mFieldDDFRecBuf^.Xe_Size     := mSize;
      mFieldDDFRecBuf^.Xe_Dec      := 0; // byte;
      if mDataType in [STRING_TYPE, LSTRING_TYPE, ZSTRING_TYPE]
        then mFieldDDFRecBuf^.Xe_Flags    := 1
        else mFieldDDFRecBuf^.Xe_Flags    := 0; // word;

      pFieldList.Add(mFieldDDFRecBuf);

      inc(mOffset,mSize);
      inc(mID);
    end;
    if (pDEFList.Count > 0) then pDEFList.Delete(0);
  end;

procedure DEF_To_IndexList(pDEFList: TStringList; var pFieldList: TList; var pIndexList: TList);
  var
    mFieldDDFRecBuf: PField_DDF_Rec;
    mIndexDDFRecBuf: PIndex_DDF_Rec;
    mFileID : word;
    mFreeFieldID: word;
    mINDStr : string;
    mGLBStr : string;
    mSEGStr : string;
    mStr    : string;
    i       : word;
    mNumber : word;
    mIndexFieldsStr: string;
    mIndexNameStr  : string;
    mGlobalFlagsStr: string;
    mSegmentFlagsStr: string;
    mLEN  : integer;
    mGlobalFlags : word;
    mLocalFlags  : word;
    mFieldNameStr: string;
    mFieldID: word;
  begin
    ClearDDFIndex;
    mFieldDDFRecBuf := pFieldList[pFieldList.Count-1];
    mFileID         := mFieldDDFRecBuf^.Xe_File;
    mFreeFieldID    := mFieldDDFRecBuf^.Xe_Id + 1; //ez lessz az elso ures ID
    mNumber         := 0; //Ez itt az index number kezdo erteke
    while (pDEFList.Count > 3) do begin
      mINDStr := pDEFList[0]; pDEFList.Delete(0);
      mGLBStr := pDEFList[0]; pDEFList.Delete(0);
      mSEGStr := pDEFList[0]; pDEFList.Delete(0);
      mStr    := pDEFList[0]; pDEFList.Delete(0);

      INDStrToIndexFields(mINDStr, mIndexFieldsStr, mIndexNameStr); // pl "MGCode,GSCode" & "MgGS"
      GLBStrToGlobalFlags(mGLBStr, mGlobalFlagsStr);  // pl visszatero ertek "cModif+cDuplic+cInsensit"
      SEGStrToSegmentFlags(mSEGStr, mSegmentFlagsStr); // pl visszatero ertek "cModif+cDuplic|cModif+cDuplic"
      //ures stringel ter vissza ez egyenlore meg nem biztos hogy mukodni fog;

      mLEN := LineElementNum(mIndexFieldsStr, ',');
      if (mLEN > 0) then begin
        FlagsStrToFlags(mGlobalFlagsStr, mGlobalFlags);
        mGlobalFlags := mGlobalFlags or KFLG_EXTTYPE_KEY; //mivel ez mindig be van allitva
        for i := 0 to mLEN-1 do begin
          if (i < mLEN-1) then  mGlobalFlags := mGlobalFlags or KFLG_SEG; //tehat nem az utolso szegnnems
          mFieldNameStr := LineElement(mIndexFieldsStr, i, ',');
          mFieldID := FindByNameFieldID(pFieldList, mFieldNameStr)^.Xe_Id;
          //mLocalFlagsStr := LineElement(mSegmentFlagsStr, i, '|');
          //FlagsStrToFlags(mLocalFlagsStr, mLocalFlags); //egyenlore itt onak kell lennie
          mLocalFlags := 0; // mivel meg nem mukodik rendesen a SEGStrToSegmentFlags eljaras
          mLocalFlags := mLocalFlags or mGlobalFlags;
          if (mLocalFlags and KFLG_MANUAL_KEY)>0 then begin
          end;
          if  (mLocalFlags and KFLG_NOCASE_KEY) >0 then begin
            FindByNameFieldID(pFieldList, mFieldNameStr)^.Xe_Flags := 0;
          end;
          mLocalFlags :=  mLocalFlags and 511;

          GetMem(mIndexDDFRecBuf, sizeof(mIndexDDFRecBuf^));
          mIndexDDFRecBuf^.Xi_File   := mFileID;
          mIndexDDFRecBuf^.Xi_Field  := mFieldID;
          mIndexDDFRecBuf^.Xi_Number := mNumber;
          mIndexDDFRecBuf^.Xi_Part   := i;
          mIndexDDFRecBuf^.Xi_Flags  := mLocalFlags;

          pIndexList.Add(mIndexDDFRecBuf);
        end;
      end;

      if (mIndexNameStr <> '') then begin
        //itt kerul bejegyzesre a Fieldszek koze az index name;
        GetMem(mFieldDDFRecBuf,sizeof(mFieldDDFRecBuf^));

        mFieldDDFRecBuf^.Xe_Id       := mFreeFieldID;
        mFieldDDFRecBuf^.Xe_File     := mFileID;
        fillchar(mFieldDDFRecBuf^.Xe_Name, sizeof(mFieldDDFRecBuf^.Xe_Name), ' ');
        move(mIndexNameStr[1], mFieldDDFRecBuf^.Xe_Name, length(mIndexNameStr));
        mFieldDDFRecBuf^.Xe_DataType := 255;
        mFieldDDFRecBuf^.Xe_Offset   := mNumber;
        mFieldDDFRecBuf^.Xe_Size     := 0;
        mFieldDDFRecBuf^.Xe_Dec      := 0;
        mFieldDDFRecBuf^.Xe_Flags    := 0;

        pFieldList.Add(mFieldDDFRecBuf);

        inc(mFreeFieldID);
      end;
      inc(mNumber); // Johet a kovetkezo index
    end;
  end;

procedure DEF_To_IndexNames(pDEFList: TStringList; var pIndexList: string);
var
  mINDStr : string;
  mGLBStr : string;
  mSEGStr : string;
  mStr    : string;
  mNumber : word;
  mIndexFieldsStr: string;
  mIndexNameStr  : string;
  mGlobalFlagsStr: string;
  mSegmentFlagsStr: string;
begin
  ClearDDFIndex;
  mNumber     := 0;
  pIndexList  := '';

  while (pDEFList.Count >= 3) do begin
    While (pDEFList.Count>0) and (RemLeftSpaces (pDEFList[0])='') do begin
      pDEFList.Delete(0);
    end;

    If pDEFList.Count >= 3 then begin
      mINDStr := pDEFList[0]; pDEFList.Delete(0);
      mGLBStr := pDEFList[0]; pDEFList.Delete(0);
      mSEGStr := pDEFList[0]; pDEFList.Delete(0);

      INDStrToIndexFields(mINDStr, mIndexFieldsStr, mIndexNameStr); // pl "MGCode,GSCode" & "MgGS"
      GLBStrToGlobalFlags(mGLBStr, mGlobalFlagsStr);  // pl visszatero ertek "cModif+cDuplic+cInsensit"
      SEGStrToSegmentFlags(mSEGStr, mSegmentFlagsStr); // pl visszatero ertek "cModif+cDuplic|cModif+cDuplic"

      if (mIndexNameStr <> '')  then pIndexList:=pIndexList+';'+mIndexNameStr
                                else pIndexList:=pIndexList+';'+'Ix'+IntToStr(mNumber);
      inc(mNumber);
    end;
  end;
  Delete (pIndexList,1,1);
end;

function  DEF_To_DDF(pDefFile: string; pBTRFile: string; pDDFPAth: string):boolean;
  var
    mFileDDFRecBuf: PFile_DDF_Rec;
    mFieldList    : TList;
    mIndexList    : TList;
    mDEFList      : TStringList;
    mName,mLoc    : string;
    mFileID,
    mFieldID      : word;
    mFullList     : TStringList;
  begin
    GetMem(mFileDDFRecBuf,sizeof(mFileDDFRecBuf^));
    mFieldList := TList.Create;
    mIndexList := TList.Create;
    mDEFList := TStringList.Create;
    mFullList := TStringList.Create;

    try
      mDEFList.LoadFromFile(pDefFile);

      mFileID := GetFreeFileID(pDDFPAth);
      mFieldID := GetFreeFieldID(pDDFPAth);

      //DEF_To_File(pDefFile, mFileDDFRecBuf);
      mName   := ExtractOnlyFileName(pBTRFile);
      mLoc    := ExtractFileName(pBTRFile);
      SetNewFileDDFRec(mFileID, mName, mLoc, mFileDDFRecBuf);
      if (mDEFList.Count > 0) then mDEFList.Delete(0); //Kitorli az elso sort
      if (mDEFList.Count > 0) then mDEFList.Delete(0); //Kitorli a masodik sort
      //****************************************


      DEF_To_FieldList(mDEFList, mFieldList, mFileID, mFieldID,mFullList);
      DEF_To_IndexList(mDEFList, mFieldList, mIndexList);

      WriteDDFFile(pDDFPAth, mFileDDFRecBuf);//: BTR_Status;
      WriteDDFField(pDDFPAth, mFieldList);//: BTR_Status;
      WriteDDFIndex(pDDFPAth, mIndexList);//: BTR_Status;
    except end;
    mFullList.Free;
    mDEFList.Free;
    mIndexList.Free;
    mFieldList.Free;
    FreeMem(mFileDDFRecBuf);
  end;

function  GetFreeFileID(pDDFPAth: string): integer;
  var
    mDataLen  : word;
    mKeyBuf   : word;
    mKeyNum   : smallint;
    mPosBlock : BTR_Position_Block;
    mClient   : CLIENT_ID;
    mBuffer   : TFile_DDF_Rec;
  begin
    Result := BtrOpen(pDDFPAth+'\'+cFILE_DDF, mPosBlock, cbtrOpen);
    if Result = 0 then begin
       mDataLen := sizeof(mBuffer);
       mKeyBuf := 0;
       mKeyNum := 0; //ID szerinti kereses;
       Result := BTRVID( B_GET_LAST,
                         mPosBlock,
                         mBuffer,
                         mDataLen,
                         mKeyBuf,
                         mKeyNum,
                         mClient);
      if Result = 0 then begin
        Result := mKeyBuf + 1;    //az utolsonal egyel tobb lesz a visszateresi erteke
      end else Result := -Result; //a BTRieve negativ hibakoddal ter vissza
      BTRClose(mPosBlock);
    end;
  end;

function  GetFreeFieldID(pDDFPAth: string): integer;
  var
    mDataLen  : word;
    mKeyBuf   : word;
    mKeyNum   : smallint;
    mPosBlock : BTR_Position_Block;
    mClient   : CLIENT_ID;
    mBuffer   : TField_DDF_Rec;
  begin
    Result := BtrOpen(pDDFPAth+'\'+cFIELD_DDF, mPosBlock,cbtrOpen);
    if Result = 0 then begin
       mDataLen := sizeof(mBuffer);
       mKeyBuf := 0;
       mKeyNum := 0; //ID szerinti kereses;
       Result := BTRVID( B_GET_LAST,
                         mPosBlock,
                         mBuffer,
                         mDataLen,
                         mKeyBuf,
                         mKeyNum,
                         mClient);
      if Result = 0 then begin
        Result := mKeyBuf + 1;    //az utolsonal egyel tobb lesz a visszateresi erteke
      end else Result := -Result; //a BTRieve negativ hibakoddal ter vissza
      BTRClose(mPosBlock);
    end;
  end;

function  WriteDDFFile(pDDFPAth: string; var pBuffer: PFile_DDF_Rec): BTR_Status;
  var
    mDataLen  : word;
    mKeyBuf   : word;
    mKeyNum   : smallint;
    mPosBlock : BTR_Position_Block;
    mClient   : CLIENT_ID;
    mBuffer   : PFile_DDF_Rec;
    mOperation: integer;
  begin
    if not assigned(pBuffer) then exit;
    Result := BtrOpen(pDDFPAth+'\'+cFILE_DDF, mPosBlock,cbtrOpen);
    if Result = 0 then begin
      mDataLen := sizeof(pBuffer^);
      GetMem(mBuffer,mDataLen);
      fillchar(mKeyBuf, sizeof(mKeyBuf), ' ');
      mKeyBuf := pBuffer^.Xf_Id;
      mKeyNum := 0; //ID szerinti kereses;
      Result := BTRVID( B_GET_EQUAL,
                        mPosBlock,
                        mBuffer^,
                        mDataLen,
                        mKeyBuf,
                        mKeyNum,
                        mClient);

      case Result of
        B_NO_ERROR            : mOperation := B_UPDATE;
        B_KEY_VALUE_NOT_FOUND : mOperation := B_INSERT;
        else mOperation := 0;
      end;
      if mOperation <> 0 then begin
        Result := BTRVID( mOperation,
                          mPosBlock,
                          pBuffer^,
                          mDataLen,
                          mKeyBuf,
                          mKeyNum,
                          mClient);
      end;
      FreeMem(mBuffer);
      BTRClose(mPosBlock);
    end;
  end;

function  WriteDDFField(pDDFPAth: string; var pFieldList: TList): BTR_Status;
  var
    mDataLen  : word;
    mKeyBuf   : word;
    mKeyNum   : smallint;
    mPosBlock : BTR_Position_Block;
    mClient   : CLIENT_ID;
    mBuffer   : PField_DDF_Rec;
    mOperation: integer;
    i         : integer;
  begin
    if not assigned(pFieldList) then exit;
    Result := BtrOpen(pDDFPAth+'\'+cFIELD_DDF, mPosBlock,cbtrOpen);
    if Result = 0 then begin
      mDataLen := sizeof(mBuffer^);
      GetMem(mBuffer,mDataLen);
      for i := 0 to pFieldList.Count -1 do begin
        mKeyBuf := PField_DDF_Rec(pFieldList.Items[i])^.Xe_Id;
        mKeyNum := 0; //ID szerinti kereses;
        Result := BTRVID( B_GET_EQUAL,
                          mPosBlock,
                          mBuffer^,
                          mDataLen,
                          mKeyBuf,
                          mKeyNum,
                          mClient);

        case Result of
          B_NO_ERROR            : mOperation := B_UPDATE;
          B_KEY_VALUE_NOT_FOUND : mOperation := B_INSERT;
          else mOperation := 0;
        end;
        if mOperation <> 0 then begin
          Result := BTRVID( mOperation,
                            mPosBlock,
                            pFieldList.Items[i]^,
                            mDataLen,
                            mKeyBuf,
                            mKeyNum,
                            mClient);
        end;
      end;
      FreeMem(mBuffer);
      BTRClose(mPosBlock);
    end;
  end;

function  WriteDDFIndex(pDDFPAth: string; var pList: TList): BTR_Status;
  var
    mDataLen  : word;
    mKeyBuf   : packed record Xi_File, Xi_Number, Xi_Part: word end;
    mKeyNum   : smallint;
    mPosBlock : BTR_Position_Block;
    mClient   : CLIENT_ID;
    mBuffer   : PIndex_DDF_Rec;
    mOperation: integer;
    i         : integer;
  begin
    if not assigned(pList) then exit;
    Result := BtrOpen(pDDFPAth+'\'+cINDEX_DDF, mPosBlock,cbtrOpen);
    if Result = 0 then begin
      mDataLen := sizeof(mBuffer^);
      GetMem(mBuffer,mDataLen);
      for i := 0 to pList.Count -1 do begin
        mKeyBuf.Xi_File   := PIndex_DDF_Rec(pList.Items[i])^.Xi_File;
        mKeyBuf.Xi_Number := PIndex_DDF_Rec(pList.Items[i])^.Xi_Number;
        mKeyBuf.Xi_Part   := PIndex_DDF_Rec(pList.Items[i])^.Xi_Part;
        mKeyNum := 2; //File;Index;Part szerinti kereses;
        Result := BTRVID( B_GET_EQUAL,
                          mPosBlock,
                          mBuffer^,
                          mDataLen,
                          mKeyBuf,
                          mKeyNum,
                          mClient);

        case Result of
          B_NO_ERROR            : mOperation := B_UPDATE;
          B_KEY_VALUE_NOT_FOUND : mOperation := B_INSERT;
          else mOperation := 0;
        end;
        if mOperation <> 0 then begin
          Result := BTRVID( mOperation,
                            mPosBlock,
                            pList.Items[i]^,
                            mDataLen,
                            mKeyBuf,
                            mKeyNum,
                            mClient);
        end;
      end;
      FreeMem(mBuffer);
      BTRClose(mPosBlock);
    end;
  end;

function  ReadStatistics(pDDFPAth: string; pTableName: string; var pFileSpecs: FILE_SPECS; var pKeySpecList: TList): BTR_Status;
  var
    mFileName: string;
    mBuffer  : STAT_REC;
    mDataLen : word;
    mKeyBuf  : string[255];
    mKeyNum  : smallint;
    mI       : integer;
    mPBufferKeySpecs: P_KEY_SPECS;
    mPosBlock: BTR_Position_Block;
    mClient  : CLIENT_ID;
  begin
    mFileName := BtrTableNameToFileName(pDDFPAth, pTableName);
    Result := BtrOpen(pDDFPAth+'\'+mFileName, mPosBlock,cbtrOpen);
    if Result = 0 then begin
      mDataLen := sizeof(mBuffer);
      mKeyNum  := 0;
      Result := BTRVID(B_STAT,
                       mPosBlock,
                       mBuffer,
                       mDataLen,
                       mKeyBuf[1],
                       mKeyNum,
                       mClient);

      if Result = B_NO_ERROR then begin
        pFileSpecs := mBuffer.FileSpecs;
        if not assigned(pKeySpecList) then pKeySpecList := TList.Create;
        for mI := 0 to mBuffer.FileSpecs.SegmentCount-1 do begin
          GetMem(mPBufferKeySpecs,sizeof(KEY_SPECS));
          mPBufferKeySpecs^ := mBuffer.KeySpecs[mI];
        end;
      end;
      BtrClose(mPosBlock);
    end;
  end;

function  GetFileID(pDDFPAth: string; pTableName: string): integer;
  var
    mBuffer: PFile_DDF_Rec;
  begin
    mBuffer:=nil;
    if 0 = ReadDDFFile(pDDFPAth, pTableName, mBuffer) then begin
      Result := mBuffer^.Xf_Id;
    end else begin
      Result := -1;
    end;
    FreeMem(mBuffer);
  end;

function  BtrTableNameToFileName(pDDFPAth: string; pTableName: string):string;
var
  mBuffer: PFile_DDF_Rec;
  i: integer;
begin
  mBuffer:=nil;
  Result := '';
  if 0 = ReadDDFFile(pDDFPAth, pTableName, mBuffer) then begin
    Result := pDDFPAth + '\';
    i:=0;
    while (i < 64) and (mBuffer^.Xf_Loc[i] <> ' ') do begin
      Result := Result + mBuffer^.Xf_Loc[i];
      inc(i);
    end;
  end;
  FreeMem(mBuffer);
end;

function  ReadDDFFile(pDDFPAth: string; pTableName: string; var pBuffer: PFile_DDF_Rec): BTR_Status;
  var
    mDataLen : word;
    mKeyBuf  : string[255];
    mKeyNum  : smallint;
    mPosBlock: BTR_Position_Block;
    mClient  : CLIENT_ID;
  begin
    Result := BtrOpen(pDDFPAth+'\'+cFILE_DDF, mPosBlock,cbtrOpen);
    if Result = 0 then begin
      mDataLen := sizeof(pBuffer^);
      if not assigned(pBuffer) then GetMem(pBuffer,mDataLen);
      fillchar(mKeyBuf, sizeof(mKeyBuf), ' ');
      mKeyBuf := pTableName;
      mKeyNum := 1; //Name szerinti kereses;
      Result := BTRVID( B_GET_EQUAL,
                        mPosBlock,
                        pBuffer^,
                        mDataLen,
                        mKeyBuf[1],
                        mKeyNum,
                        mClient);
      BTRClose(mPosBlock);
    end;
  end;

function  ReadDDFField(pDDFPAth: string; pTableName: string; var pFieldList: TList): BTR_Status;
  var
    mFile      : integer;
    mDataLen   : word;
    mKeyNum    : smallint;
    mBuffer    : PField_DDF_Rec;
    mKeyBuff    : packed record a,b: word; c: byte end;
    mPosBlock: BTR_Position_Block;
    mClient  : CLIENT_ID;
  begin
    mFile := GetFileID(pDDFPAth, pTableName);
    Result := 0;
    if mFile >= 0 then begin
      mKeyBuff.a:= mFile;
      mKeyBuff.b:= 0;
      mKeyBuff.c:= 0;
      Result := BtrOpen(pDDFPAth+'\'+cFIELD_DDF, mPosBlock,cbtrOpen);
      if Result = 0 then begin
        mDataLen := sizeof(TField_DDF_Rec);
        GetMem(mBuffer,mDataLen);
        mKeyNum := 4;
        Result := BTRVID( B_GET_GE, //EQUAL
                          mPosBlock,
                          mBuffer^,
                          mDataLen,
                          mKeyBuff,
                          mKeyNum,
                          mClient);
        if Result = 0 then begin
          if not Assigned(pFieldList) then pFieldList := TList.Create;
          while (Result = 0)  and (mKeyBuff.a = mFile) do begin
            pFieldList.Add(mBuffer);
            GetMem(mBuffer,mDataLen);
            Result := BTRVID( B_GET_NEXT,
                              mPosBlock,
                              mBuffer^,
                              mDataLen,
                              mKeyBuff,
                              mKeyNum,
                              mClient);
          end;
        end;
        BTRClose(mPosBlock);
      end;
    end else Result := -1;
  end;

function  ReadDDFIndex(pDDFPAth: string; pTableName: string; var pList: TList): BTR_Status;
  var
    mFile       : integer;
    mDataLen    : word;
    mKeyNum     : smallint;
    mBuffer     : PIndex_DDF_Rec;
    mKeyBuff    : packed record Xi_File, Xi_Number, Xi_Part: word end;
    mPosBlock: BTR_Position_Block;
    mClient  : CLIENT_ID;
  begin
    mFile := GetFileID(pDDFPAth, pTableName);
    if mFile >= 0 then begin
      mKeyBuff.Xi_File   := mFile;
      mKeyBuff.Xi_Number := 0;
      mKeyBuff.Xi_Part   := 0;
      Result := BtrOpen(pDDFPAth+'\'+cINDEX_DDF, mPosBlock,cbtrOpen);
      if Result = 0 then begin
        mDataLen := sizeof(TIndex_DDF_Rec);
        GetMem(mBuffer,mDataLen);
        mKeyNum := 2;
        Result := BTRVID( B_GET_GE, //EQUAL
                          mPosBlock,
                          mBuffer^,
                          mDataLen,
                          mKeyBuff,
                          mKeyNum,
                          mClient);
        if Result = 0 then begin
          if not Assigned(pList) then pList := TList.Create;
          while (Result = 0)  and (mKeyBuff.Xi_File = mFile) do begin
            pList.Add(mBuffer);
            GetMem(mBuffer,mDataLen);
            Result := BTRVID( B_GET_NEXT,
                              mPosBlock,
                              mBuffer^,
                              mDataLen,
                              mKeyBuff,
                              mKeyNum,
                              mClient);
          end;
        end;
        BTRClose(mPosBlock);
      end;
    end;
  end;

procedure ClearDDFIndex;
var I:longint;
begin
  uDDFIndexQnt := 0;
  For I:=1 to cMaxIndexesNumBtr do begin
    uDDFIndexFields[I].IndexName := '';
    uDDFIndexFields[I].IndexFields := '';
  end;
end;

end.
