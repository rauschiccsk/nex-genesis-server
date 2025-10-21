{*************************************************************************
**
**  Copyright 1997, Pervasive Software Inc. All Rights Reserved
**
*************************************************************************}
{***********************************************************************
   SQLAPI32.PAS
      This is the Pascal unit for Scalable SQL to be called by a Borland
      Delphi applications on 32-bit Windows NT and Windows 95.

************************************************************************}
UNIT SqlApi32;

INTERFACE
{***********************************************************************
   The following types are needed for use with 'XQLCallback'.
************************************************************************}
TYPE
   SQL_YIELD_T = RECORD
      iSessionID : WORD;
   END;

   BTRV_YIELD_T = RECORD
      iOpCode           : WORD;
      bClientIDlastFour : ARRAY[ 1..4 ] OF BYTE;
   END;

   BTI_CB_INFO_T = RECORD
      typex : WORD;
      size  : WORD;
      case u: Boolean of
         False: ( sYield : SQL_YIELD_T );
         True:  ( bYield : BTRV_YIELD_T );
   END;

   BTI_CB_FUNC_PTR_T = FUNCTION(
                          VAR bCallbackInfo : BTI_CB_INFO_T;
                          VAR bUserData )   : WORD;

   BTI_CB_FUNC_PTR_PTR_T = ^BTI_CB_FUNC_PTR_T;
{***********************************************************************
   SESSION MANAGEMENT PRIMITIVES
      The following primitives are required by applications which
      want to use multiple SQL logins:
         xGetSessionID
         xPutSessionID
************************************************************************}
   FUNCTION xGetSessionID(
               VAR iSessionID : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xPutSessionID(
               iSessionID : SMALLINT ) : SMALLINT; STDCALL;

{***********************************************************************
   MISCELLANEOUS FUNCTIONS
      XQLCallback                    ( MS Windows )
      xShareSessionID                ( MS Windows )
      SQLGetCountDatabaseNames       ( MS Windows )
      SQLGetCountRemoteDatabaseNames ( MS Windows )
      SQLGetDatabaseNames            ( MS Windows )
      SQLGetRemoteDatabaseNames      ( MS Windows )
      SQLUnloadDBNames               ( MS Windows )
************************************************************************}
   FUNCTION XQLCallback(
               iAction                   : WORD;
               iOption                   : WORD;
               fCallBackFunction         : BTI_CB_FUNC_PTR_T;
               fPreviousCallBackFunction : BTI_CB_FUNC_PTR_PTR_T;
           VAR bUserData;
           VAR bPreviousUserData         : POINTER ) : SMALLINT; STDCALL;

   FUNCTION xShareSessionID(
               VAR tChangeCount : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION SQLGetCountDatabaseNames(
              VAR tCount : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION SQLGetCountRemoteDatabaseNames(
              VAR tCount : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION SQLGetDatabaseNames(
              VAR tBufLen  : LONGINT;
                  bDataBuf : PCHAR ) : SMALLINT; STDCALL;

   FUNCTION SQLGetRemoteDatabaseNames(
              VAR tBufLen  : LONGINT;
                  bDataBuf : PCHAR ) : SMALLINT; STDCALL;

   FUNCTION SQLUnloadDBNAMES(
              iReserved : SMALLINT ) : SMALLINT; STDCALL;

{***********************************************************************
   SQL-LEVEL FUNCTIONS
      XQLCursor     XQLFetch    XQLSPUtility   XQLVersion
      XQLCompile    XQLFormat   XQLStatus      XQLConvert
      XQLDescribe   XQLFree     XQLStop        XQLValidate
      XQLExec       XQLLogin    XQLSubst       XQLMask
                    XQLLogout
***********************************************************************}
   FUNCTION XQLCursor(
               VAR iCursorID : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION XQLCompile(
               iCursorID     : SMALLINT;
           VAR tStatementLen : SMALLINT;
           VAR sStatement )  : SMALLINT; STDCALL;

   FUNCTION XQLDescribe(
               iCursorID   : SMALLINT;
               tPosition   : SMALLINT;
           VAR iDataType   : SMALLINT;
           VAR tSize       : SMALLINT;
           VAR tDecPlaces  : SMALLINT;
           VAR tDisplayLen : SMALLINT;
           VAR tNameLen    : SMALLINT;
               sName       : PCHAR ) : SMALLINT; STDCALL;

    FUNCTION XQLExec(
                iCursorID : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION XQLFetch(
               iCursorID  : SMALLINT;
               iOption    : SMALLINT;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf;
           VAR lCount     : LONGINT;
               iASCIIFlag : SMALLINT;
               iSpacing   : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION XQLFormat(
               iCursorID : SMALLINT;
               tPosition : SMALLINT;
               tMaskLen  : SMALLINT;
           VAR sMask   ) : SMALLINT; STDCALL;

   FUNCTION XQLFree(
               iCursorID : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION XQLLogin(
               VAR sUser;
               VAR sPassword;
               VAR sDDPath;
               VAR sDataPath;
               VAR sReserved;
                   iFeaturesUsed : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION XQLLogout : SMALLINT; STDCALL;

   FUNCTION XQLSPUtility(
               iCursorID       : SMALLINT;
               iOption         : SMALLINT;
           VAR tStatementCount : SMALLINT;
           VAR tStatementExec  : SMALLINT;
           VAR tBufLen         : SMALLINT;
           VAR bDataBuf )      : SMALLINT; STDCALL;

   FUNCTION XQLStatus(
               iCursor : SMALLINT;
               iOption : SMALLINT;
           VAR sStatBuf ) : SMALLINT; STDCALL;

   FUNCTION XQLStop : SMALLINT; STDCALL;

   FUNCTION XQLSubst(
               iCursorID : SMALLINT;
               tCount    : SMALLINT;
               tNameLen  : SMALLINT;
           VAR sVarNames;
               tTextLen  : SMALLINT;
           VAR sValueText ) : SMALLINT; STDCALL;

   FUNCTION XQLVersion(
               VAR sVersion ) : SMALLINT; STDCALL;

   FUNCTION XQLConvert(
               iOption  : SMALLINT;
               iType    : SMALLINT;
               tSize    : SMALLINT;
               tDec     : SMALLINT;
               tdSize   : SMALLINT;
           VAR sValue;
           VAR sRetVal;
           VAR sMask;
               sJustify : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION XQLValidate(
               VAR tCount     : SMALLINT;
               VAR sFieldName;
                   tBufLen    : SMALLINT;
               VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION XQLMask(
               iOption : SMALLINT;
               iType   : SMALLINT;
               tSize   : SMALLINT;
               tDec    : SMALLINT;
           VAR tLen    : SMALLINT;
           VAR sMask ) : SMALLINT; STDCALL;

{***********************************************************************
   HISTORICAL RELATIONAL PRIMITIVES
      The following functions will be phased out over time.  They
      are included here to support existing applications.  New applications
      should not use these functions.

      xCompute    xOrder         xDD            xAccess
      xDescribe   xRemall        xDDAttr        xPassword
      xMovefld    xRemove        xDDModify      xSecurity
      xFetch      xReset         xDDCreate      xUser
      xField      xRestrict      xDDDrop        xChar
      xFree       xStop          xDDField       xVersion
      xInsert     xTrans         xDDFile        xStatus
      xJoin       xStore         xDDIndex       xConvert
      xLogin      xRecall        xDDPath        xValidate
      xLogout     xUpdate        xDDView        xMask
      xNew        xUpdall
***********************************************************************}
   FUNCTION xCompute(
               iCursorID  : SMALLINT;
           VAR sFldName;
               iFldType   : SMALLINT;
               tFldLen    : SMALLINT;
               tDecPlaces : SMALLINT;
           VAR tExpLen    : SMALLINT;
           VAR sExpression ) : SMALLINT; STDCALL;

   FUNCTION xDescribe(
               iCursorID  : SMALLINT;
               iOption    : SMALLINT;
           VAR tBufLen    : SMALLINT;
               tPosition  : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xMovefld(
               iCursorID     : SMALLINT;
               tFromPosition : SMALLINT;
               tToPosition   : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xFetch(
               iCursorID    : SMALLINT;
           VAR tBufLen      : SMALLINT;
               iOption      : SMALLINT;
           VAR lRecordCount : LONGINT;
           VAR lRejectCount : LONGINT;
           VAR bDataBuf  )  : SMALLINT; STDCALL;

   FUNCTION xField(
               iCursorID   : SMALLINT;
               iOption     : SMALLINT;
               tPosition   : SMALLINT;
           VAR tCount      : SMALLINT;
           VAR sFldNames ) : SMALLINT; STDCALL;

   FUNCTION xFree(
               iCursorID : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xInsert(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
           VAR lRecordCount : LONGINT;
           VAR bDataBuf )   : SMALLINT; STDCALL;

   FUNCTION xJoin(
               iCursorID    : SMALLINT;
           VAR sSecFile;
           VAR sOwner;
               iOption      : SMALLINT;
               tPriFldCount : SMALLINT;
           VAR sPriFlds;
               tSecFldCount : SMALLINT;
           VAR sSecFlds )   : SMALLINT; STDCALL;

   FUNCTION xLogin(
           VAR sUser;
           VAR sPassword;
           VAR sDDPath;
           VAR sDataPath;
           VAR sReserved;
               iFeaturesUsed : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xLogout : SMALLINT; STDCALL;

   FUNCTION xNew(
           VAR iCursorID : SMALLINT;
           VAR sFileName;
           VAR sOwner;
               iOpenMode : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xOrder(
               iCursorID : SMALLINT;
               tCount    : SMALLINT;
           VAR sOrder )  : SMALLINT; STDCALL;

   FUNCTION xRemall(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
               iOption      : SMALLINT;
           VAR lRecordCount : LONGINT;
               lRejectCount : LONGINT ) : SMALLINT; STDCALL;

   FUNCTION xRemove(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
           VAR lRecordCount : LONGINT ) : SMALLINT; STDCALL;

   FUNCTION xReset(
           VAR sReserved ) : SMALLINT; STDCALL;

   FUNCTION xRestrict(
               iCursorID : SMALLINT;
               iOption   : SMALLINT;
           VAR tExpLen   : SMALLINT;
           VAR sExpression ) : SMALLINT; STDCALL;

   FUNCTION xStop : SMALLINT; STDCALL;

   FUNCTION xTrans(
               iOption : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xStore(
               iCursorID : SMALLINT;
           VAR sViewName;
               tTextLen  : SMALLINT;
           VAR sText )   : SMALLINT; STDCALL;

   FUNCTION xRecall(
           VAR iCursorID   : SMALLINT;
           VAR sViewName;
               tOwnerCount : SMALLINT;
           VAR sOwner;
               iOpenMode   : SMALLINT;
           VAR tTextLen    : SMALLINT;
           VAR sText )     : SMALLINT; STDCALL;

   FUNCTION xUpdate(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
           VAR lRecordCount : LONGINT;
           VAR bDataBuf )   : SMALLINT; STDCALL;

   FUNCTION xUpdall(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
               iOption      : SMALLINT;
           VAR lRecordCount : LONGINT;
           VAR lRejectCount : LONGINT;
               tFldCount    : SMALLINT;
           VAR sUpdateFld;
           VAR sReplaceFld ) : SMALLINT; STDCALL;

   FUNCTION xDD(
           VAR sPathName;
               iOption : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xDDAttr(
                iOption    : SMALLINT;
            VAR sFldName;
                iAttrType  : SMALLINT;
            VAR tBufLen    : SMALLINT;
            VAR sAttrBuf ) : SMALLINT; STDCALL;

   FUNCTION xDDModify(
               iOption     : SMALLINT;
           VAR sFileName;
               iCreate    : SMALLINT;
           VAR sPathName;
           VAR sOwner;
               iOwnerFlag : SMALLINT;
               tFldCount  : SMALLINT;
           VAR bFldBuf;
               tIndxCount : SMALLINT;
           VAR bIndxBuf ) : SMALLINT; STDCALL;

   FUNCTION xDDCreate(
               iOption           : SMALLINT;
           VAR sFileName;
               iCreate           : SMALLINT;
           VAR sPathName;
           VAR sOwner;
               iOwnerFlag        : SMALLINT;
               tFldCount         : SMALLINT;
           VAR bFldBuf;
               tIndxCount        : SMALLINT;
           VAR bIndxBuf;
               tBufLen           : SMALLINT;
           VAR bCreateParmsBuf ) : SMALLINT; STDCALL;

   FUNCTION xDDDrop(
           VAR sName;
               iType   : SMALLINT;
               iDelete : SMALLINT ) : SMALLINT; STDCALL;

    FUNCTION xDDField(
                iOption    : SMALLINT;
            VAR tCount     : SMALLINT;
            VAR sFldNames;
            VAR tBufLen    : SMALLINT;
            VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xDDFile(
               iOption    : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR sFileNames;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xDDIndex(
               iOption    : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR sIndexName;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xDDPath(
               iOption     : SMALLINT;
           VAR sPathName ) : SMALLINT; STDCALL;

   FUNCTION xDDView(
           VAR tCount     : SMALLINT;
           VAR sViewName;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xAccess(
           VAR sMstrPswd;
           VAR sUser;
               iOption    : SMALLINT;
               iAccRights : SMALLINT;
           VAR sFileName;
           VAR tCount     : SMALLINT;
           VAR sFldNames;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xPassword(
           VAR sUser;
           VAR sPassword ) : SMALLINT; STDCALL;

   FUNCTION xSecurity(
           VAR sMstrPswd;
               iOption : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xUser(
           VAR sMstPswd;
               iOption    : SMALLINT;
           VAR sUser;
           VAR sPassword;
               iFlags     : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xChar(
               iOption : SMALLINT;
               iType   : SMALLINT;
           VAR cCharacter ) : SMALLINT; STDCALL;

   FUNCTION xVersion(
           VAR sVersion ) : SMALLINT; STDCALL;

   FUNCTION xStatus(
               iCursorID  : SMALLINT;
               iOption    : SMALLINT;
           VAR tLen       : SMALLINT;
           VAR sStatBuf ) : SMALLINT; STDCALL;

   FUNCTION xConvert(
               iOption  : SMALLINT;
               iType    : SMALLINT;
               tSize    : SMALLINT;
               tDec     : SMALLINT;
               tDSize   : SMALLINT;
           VAR sValue;
           VAR sRetVal;
           VAR sMask;
               iJustify : SMALLINT ) : SMALLINT; STDCALL;

   FUNCTION xValidate(
           VAR tCount     : SMALLINT;
           VAR sFieldName;
               tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;

   FUNCTION xMask(
               iOption : SMALLINT;
               iType   : SMALLINT;
               tSize   : SMALLINT;
               iDec    : SMALLINT;
           VAR tLen    : SMALLINT;
           VAR sMask ) : SMALLINT; STDCALL;

{***********************************************************************
   PASCAL IMPLEMENTATION SECTION
************************************************************************}
IMPLEMENTATION

{***********************************************************************
   SESSION MANAGEMENT PRIMITIVES
************************************************************************}
   FUNCTION xGetSessionID(
               VAR iSessionID : SMALLINT ) : SMALLINT; STDCALL;
               external 'WSSQL32.DLL' name 'xGetSessionID';

   FUNCTION xPutSessionID(
               iSessionID : SMALLINT ) : SMALLINT; STDCALL;
               external 'WSSQL32.DLL' name 'xPutSessionID';

{***********************************************************************
   MISCELLANEOUS FUNCTIONS
************************************************************************}
   FUNCTION XQLCallback(
               iAction                   : WORD;
               iOption                   : WORD;
               fCallBackFunction         : BTI_CB_FUNC_PTR_T;
               fPreviousCallBackFunction : BTI_CB_FUNC_PTR_PTR_T;
           VAR bUserData;
           VAR bPreviousUserData         : POINTER ) : SMALLINT; STDCALL;
               external 'WSSQL32.DLL' name 'XQLCallback';

   FUNCTION xShareSessionID(
               VAR tChangeCount : SMALLINT ) : SMALLINT; STDCALL;
               external 'WSSQL32.DLL' name 'xShareSessionID';

   FUNCTION SQLGetCountDatabaseNames(
              VAR tCount : SMALLINT ) : SMALLINT; STDCALL;
              external 'WDBNM32.DLL' name 'SQLGetCountDatabaseNames';

   FUNCTION SQLGetCountRemoteDatabaseNames(
              VAR tCount : SMALLINT ) : SMALLINT; STDCALL;
              external 'WDBNM32.DLL' name 'SQLGetCountRemoteDatabaseNames';

   FUNCTION SQLGetDatabaseNames(
              VAR tBufLen  : LONGINT;
                  bDataBuf : PCHAR ) : SMALLINT; STDCALL;
              external 'WDBNM32.DLL' name 'SQLGetDatabaseNames';

   FUNCTION SQLGetRemoteDatabaseNames(
              VAR tBufLen  : LONGINT;
                  bDataBuf : PCHAR ) : SMALLINT; STDCALL;
              external 'WDBNM32.DLL' name 'SQLGetRemoteDatabaseNames';

   FUNCTION SQLUnloadDBNames(
              iReserved : SMALLINT ) : SMALLINT; STDCALL;
              external 'WDBNM32.DLL' name 'SQLUnloadDBNames';

{***********************************************************************
   SQL-LEVEL FUNCTIONS
***********************************************************************}
   FUNCTION XQLCursor(
               VAR iCursorID : SMALLINT ) : SMALLINT; STDCALL;
               external 'WSSQL32.DLL' name 'XQLCursor';

   FUNCTION XQLCompile(
               iCursorID     : SMALLINT;
           VAR tStatementLen : SMALLINT;
           VAR sStatement )  : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLCompile';

   FUNCTION XQLDescribe(
               iCursorID   : SMALLINT;
               tPosition   : SMALLINT;
           VAR iDataType   : SMALLINT;
           VAR tSize       : SMALLINT;
           VAR tDecPlaces  : SMALLINT;
           VAR tDisplayLen : SMALLINT;
           VAR tNameLen    : SMALLINT;
               sName       : PCHAR ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLDescribe';

    FUNCTION XQLExec(
                iCursorID : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLExec';

   FUNCTION XQLFetch(
               iCursorID  : SMALLINT;
               iOption    : SMALLINT;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf;
           VAR lCount     : LONGINT;
               iASCIIFlag : SMALLINT;
               iSpacing   : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLFetch';

   FUNCTION XQLFormat(
               iCursorID : SMALLINT;
               tPosition : SMALLINT;
               tMaskLen  : SMALLINT;
           VAR sMask   ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLFormat';

   FUNCTION XQLFree(
               iCursorID : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLFree';

   FUNCTION XQLLogin(
               VAR sUser;
               VAR sPassword;
               VAR sDDPath;
               VAR sDataPath;
               VAR sReserved;
                   iFeaturesUsed : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLLogin';

   FUNCTION XQLLogout : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLLogout';

   FUNCTION XQLSPUtility(
               iCursorID       : SMALLINT;
               iOption         : SMALLINT;
           VAR tStatementCount : SMALLINT;
           VAR tStatementExec  : SMALLINT;
           VAR tBufLen         : SMALLINT;
           VAR bDataBuf )      : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLSPUtility';

   FUNCTION XQLStatus(
               iCursor : SMALLINT;
               iOption : SMALLINT;
           VAR sStatBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLStatus';

   FUNCTION XQLStop : SMALLINT; STDCALL;
            external 'WSSQL32.DLL' name 'XQLStop';

   FUNCTION XQLSubst(
               iCursorID : SMALLINT;
               tCount    : SMALLINT;
               tNameLen  : SMALLINT;
           VAR sVarNames;
               tTextLen  : SMALLINT;
           VAR sValueText ) : SMALLINT; STDCALL;
            external 'WSSQL32.DLL' name 'XQLSubst';

   FUNCTION XQLVersion(
               VAR sVersion ) : SMALLINT; STDCALL;
            external 'WSSQL32.DLL' name 'XQLVersion';

   FUNCTION XQLConvert(
               iOption  : SMALLINT;
               iType    : SMALLINT;
               tSize    : SMALLINT;
               tDec     : SMALLINT;
               tdSize   : SMALLINT;
           VAR sValue;
           VAR sRetVal;
           VAR sMask;
               sJustify : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLConvert';

   FUNCTION XQLValidate(
               VAR tCount     : SMALLINT;
               VAR sFieldName;
                   tBufLen    : SMALLINT;
               VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLValidate';

   FUNCTION XQLMask(
               iOption : SMALLINT;
               iType   : SMALLINT;
               tSize   : SMALLINT;
               tDec    : SMALLINT;
           VAR tLen    : SMALLINT;
           VAR sMask ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'XQLMask';

{***********************************************************************
   HISTORICAL RELATIONAL PRIMITIVES
***********************************************************************}
   FUNCTION xCompute(
               iCursorID  : SMALLINT;
           VAR sFldName;
               iFldType   : SMALLINT;
               tFldLen    : SMALLINT;
               tDecPlaces : SMALLINT;
           VAR tExpLen    : SMALLINT;
           VAR sExpression ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xCompute';

   FUNCTION xDescribe(
               iCursorID  : SMALLINT;
               iOption    : SMALLINT;
           VAR tBufLen    : SMALLINT;
               tPosition  : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDescribe';

   FUNCTION xMovefld(
               iCursorID     : SMALLINT;
               tFromPosition : SMALLINT;
               tToPosition   : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xMovefld';

   FUNCTION xFetch(
               iCursorID    : SMALLINT;
           VAR tBufLen      : SMALLINT;
               iOption      : SMALLINT;
           VAR lRecordCount : LONGINT;
           VAR lRejectCount : LONGINT;
           VAR bDataBuf  )  : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xFetch';

   FUNCTION xField(
               iCursorID   : SMALLINT;
               iOption     : SMALLINT;
               tPosition   : SMALLINT;
           VAR tCount      : SMALLINT;
           VAR sFldNames ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xField';

   FUNCTION xFree(
               iCursorID : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xFree';

   FUNCTION xInsert(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
           VAR lRecordCount : LONGINT;
           VAR bDataBuf )   : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xInsert';

   FUNCTION xJoin(
               iCursorID    : SMALLINT;
           VAR sSecFile;
           VAR sOwner;
               iOption      : SMALLINT;
               tPriFldCount : SMALLINT;
           VAR sPriFlds;
               tSecFldCount : SMALLINT;
           VAR sSecFlds )   : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xJoin';

   FUNCTION xLogin(
           VAR sUser;
           VAR sPassword;
           VAR sDDPath;
           VAR sDataPath;
           VAR sReserved;
               iFeaturesUsed : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xLogin';

   FUNCTION xLogout : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xLogout';

   FUNCTION xNew(
           VAR iCursorID : SMALLINT;
           VAR sFileName;
           VAR sOwner;
               iOpenMode : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xNew';

   FUNCTION xOrder(
               iCursorID : SMALLINT;
               tCount    : SMALLINT;
           VAR sOrder )  : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xOrder';

   FUNCTION xRemall(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
               iOption      : SMALLINT;
           VAR lRecordCount : LONGINT;
               lRejectCount : LONGINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xRemall';

   FUNCTION xRemove(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
           VAR lRecordCount : LONGINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xRemove';

   FUNCTION xReset(
           VAR sReserved ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xReset';

   FUNCTION xRestrict(
               iCursorID : SMALLINT;
               iOption   : SMALLINT;
           VAR tExpLen   : SMALLINT;
           VAR sExpression ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xRestrict';

   FUNCTION xStop : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xStop';

   FUNCTION xTrans(
               iOption : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xTrans';

   FUNCTION xStore(
               iCursorID : SMALLINT;
           VAR sViewName;
               tTextLen  : SMALLINT;
           VAR sText )   : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xStore';

   FUNCTION xRecall(
           VAR iCursorID   : SMALLINT;
           VAR sViewName;
               tOwnerCount : SMALLINT;
           VAR sOwner;
               iOpenMode   : SMALLINT;
           VAR tTextLen    : SMALLINT;
           VAR sText )     : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xRecall';

   FUNCTION xUpdate(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
           VAR lRecordCount : LONGINT;
           VAR bDataBuf )   : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xUpdate';

   FUNCTION xUpdall(
               iCursorID    : SMALLINT;
           VAR tFileCount   : SMALLINT;
           VAR sFileNames;
               iOption      : SMALLINT;
           VAR lRecordCount : LONGINT;
           VAR lRejectCount : LONGINT;
               tFldCount    : SMALLINT;
           VAR sUpdateFld;
           VAR sReplaceFld ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xUpdall';

   FUNCTION xDD(
           VAR sPathName;
               iOption : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDD';

   FUNCTION xDDAttr(
                iOption    : SMALLINT;
            VAR sFldName;
                iAttrType  : SMALLINT;
            VAR tBufLen    : SMALLINT;
            VAR sAttrBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDAttr';

   FUNCTION xDDModify(
               iOption     : SMALLINT;
           VAR sFileName;
               iCreate    : SMALLINT;
           VAR sPathName;
           VAR sOwner;
               iOwnerFlag : SMALLINT;
               tFldCount  : SMALLINT;
           VAR bFldBuf;
               tIndxCount : SMALLINT;
           VAR bIndxBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDModify';

   FUNCTION xDDCreate(
               iOption           : SMALLINT;
           VAR sFileName;
               iCreate           : SMALLINT;
           VAR sPathName;
           VAR sOwner;
               iOwnerFlag        : SMALLINT;
               tFldCount         : SMALLINT;
           VAR bFldBuf;
               tIndxCount        : SMALLINT;
           VAR bIndxBuf;
               tBufLen           : SMALLINT;
           VAR bCreateParmsBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDCreate';

   FUNCTION xDDDrop(
           VAR sName;
               iType   : SMALLINT;
               iDelete : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDDrop';

    FUNCTION xDDField(
                iOption    : SMALLINT;
            VAR tCount     : SMALLINT;
            VAR sFldNames;
            VAR tBufLen    : SMALLINT;
            VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDField';

   FUNCTION xDDFile(
               iOption    : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR sFileNames;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDFile';

   FUNCTION xDDIndex(
               iOption    : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR sIndexName;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDIndex';

   FUNCTION xDDPath(
               iOption     : SMALLINT;
           VAR sPathName ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDPath';

   FUNCTION xDDView(
           VAR tCount     : SMALLINT;
           VAR sViewName;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xDDView';

   FUNCTION xAccess(
           VAR sMstrPswd;
           VAR sUser;
               iOption    : SMALLINT;
               iAccRights : SMALLINT;
           VAR sFileName;
           VAR tCount     : SMALLINT;
           VAR sFldNames;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xAccess';

   FUNCTION xPassword(
           VAR sUser;
           VAR sPassword ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xPassword';

   FUNCTION xSecurity(
           VAR sMstrPswd;
               iOption : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xSecurity';

   FUNCTION xUser(
           VAR sMstPswd;
               iOption    : SMALLINT;
           VAR sUser;
           VAR sPassword;
               iFlags     : SMALLINT;
           VAR tCount     : SMALLINT;
           VAR tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xUser';

   FUNCTION xChar(
               iOption : SMALLINT;
               iType   : SMALLINT;
           VAR cCharacter ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xChar';

   FUNCTION xVersion(
           VAR sVersion ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xVersion';

   FUNCTION xStatus(
               iCursorID  : SMALLINT;
               iOption    : SMALLINT;
           VAR tLen       : SMALLINT;
           VAR sStatBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xStatus';

   FUNCTION xConvert(
               iOption  : SMALLINT;
               iType    : SMALLINT;
               tSize    : SMALLINT;
               tDec     : SMALLINT;
               tDSize   : SMALLINT;
           VAR sValue;
           VAR sRetVal;
           VAR sMask;
               iJustify : SMALLINT ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xConvert';

   FUNCTION xValidate(
           VAR tCount     : SMALLINT;
           VAR sFieldName;
               tBufLen    : SMALLINT;
           VAR bDataBuf ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xValidate';

   FUNCTION xMask(
               iOption : SMALLINT;
               iType   : SMALLINT;
               tSize   : SMALLINT;
               iDec    : SMALLINT;
           VAR tLen    : SMALLINT;
           VAR sMask ) : SMALLINT; STDCALL;
           external 'WSSQL32.DLL' name 'xMask';

END.

