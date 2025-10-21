{*************************************************************************
**
**  Copyright 1982-1998 Pervasive Software Inc. All Rights Reserved
**
*************************************************************************}
{***********************************************************************
  BTRAPI32.PAS
    This is the Pascal unit for MS Windows Btrieve to be called by
    Delphi for Windows NT or Windows 95.

************************************************************************}
UNIT btrapi32;

INTERFACE
{***********************************************************************
  The following types are needed for use with 'BTRCALLBACK'.
************************************************************************}
TYPE
  SQL_YIELD_T = PACKED RECORD
     iSessionID : WORD;
  END;

  BTRV_YIELD_T = PACKED RECORD
    iOpCode           : WORD;
    bClientIDlastFour : ARRAY[ 1..4 ] OF BYTE;
  END;

  BTI_CB_INFO_T = PACKED RECORD
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
  PLATFORM-INDEPENDENT FUNCTIONS
    BTRV and BTRVID are the same on all platforms for which they have
    an implementation.  We recommend that you use only these two
    functions with Btrieve 6.x client components, and then issue
    the B_STOP operation prior to exiting your application.
************************************************************************}
  FUNCTION BTRV(
                 operation      : WORD;
             VAR positionBlock;
             VAR dataBuffer;
             VAR dataLen        : WORD;
             VAR keyBuffer;
                 keyNumber      : SMALLINT ) : SMALLINT;

  FUNCTION BTRVID(
                 operation      : WORD;
             VAR positionBlock;
             VAR dataBuffer;
             VAR dataLen        : WORD;
             VAR keyBuffer;
                 keyNumber      : SMALLINT;
             VAR clientID )     : SMALLINT;

{***********************************************************************
  PLATFORM-SPECIFIC FUNCTIONS
    These APIs are specific to the MS Windows platform.  With the
    exception of BTRCALLBACK, we recommend that you use either
    BTRV or BTRVID, shown above.  Slight performance gains can be
    achieved by using BTRCALL or BTRCALLID.
************************************************************************}
  FUNCTION BTRCALL(
                   operation   : WORD;
             VAR posblk;
             VAR databuf;
             VAR datalen       : longInt;
             VAR keybuf;
                 keylen        : BYTE;
                 keynum        : BYTE ) : SMALLINT; FAR;
             STDCALL;

  FUNCTION BTRCALLID(
                 operation      : WORD;
             VAR posblk;
             VAR databuf;
             VAR datalen    : longInt;
             VAR keybuf;
                 keylen         : BYTE;
                 keynum         : BYTE;
             VAR clientID ) : SMALLINT; FAR;
             STDCALL;

{***********************************************************************
   BTRCALLBACK - Used to register call-back function to Btrieve.
************************************************************************}
  FUNCTION BTRCALLBACK(
                 iAction                   : WORD;
                 iOption                   : WORD;
                 fCallBackFunction         : BTI_CB_FUNC_PTR_T;
                 fPreviousCallBackFunction : BTI_CB_FUNC_PTR_PTR_T;
             VAR bUserData;
             VAR bPreviousUserData         : POINTER;
             VAR bClientID )               : SMALLINT;
             STDCALL;

{***********************************************************************
   HISTORICAL FUNCTIONS
   These APIs were needed prior to Btrieve 6.x client
   components.  Older applications may still call these functions,
   and the Btrieve Windows 6.x client component will work correctly.
   New applications using the 6.x client components do NOT have to
   call these functions.
************************************************************************}
  FUNCTION BTRVINIT( VAR initializationString ) : SMALLINT;
  FUNCTION BTRVSTOP : SMALLINT;
  FUNCTION BRQSHELLINIT( VAR initializationString ): SMALLINT;

IMPLEMENTATION
{***********************************************************************
  PLATFORM-SPECIFIC FUNCTIONS
    These APIs are specific to the MS Windows platform.  With the
    exception of BTRCALLBACK, we recommend that you use either
    BTRV or BTRVID, shown above.  Slight performance gains can be
    achieved by using BTRCALL or BTRCALLID.
************************************************************************}
  FUNCTION BTRCALL(
                   operation   : WORD;
             VAR posblk;
             VAR databuf;
             VAR datalen       : longInt;
             VAR keybuf;
                 keylen        : BYTE;
                 keynum        : BYTE ) : SMALLINT; FAR;
             STDCALL;
             external 'W3BTRV7.DLL' name 'BTRCALL';

  FUNCTION BTRCALLID(
                 operation      : WORD;
             VAR posblk;
             VAR databuf;
             VAR datalen    : longInt;
             VAR keybuf;
                 keylen         : BYTE;
                 keynum         : BYTE;
             VAR clientID ) : SMALLINT; FAR;
             STDCALL;
             external 'W3BTRV7.DLL'  name 'BTRCALLID';

  FUNCTION BTRCALLBACK(
                 iAction                   : WORD;
                 iOption                   : WORD;
                 fCallBackFunction         : BTI_CB_FUNC_PTR_T;
                 fPreviousCallBackFunction : BTI_CB_FUNC_PTR_PTR_T;
             VAR bUserData;
             VAR bPreviousUserData         : POINTER;
             VAR bClientID )               : SMALLINT;
             STDCALL;
             external 'W3BTRV7.DLL'  name 'BTRCALLBACK';

  { Implementation of BTRV }
  FUNCTION BTRV(
                 operation     : WORD;
             VAR positionBlock;
             VAR dataBuffer;
             VAR dataLen        : WORD;
             VAR keyBuffer;
                 keyNumber      : SMALLINT ): SMALLINT;

  VAR
    keyLen: BYTE;
    dataLenParm       : longInt;
    dataPack          : array[1..2] of word absolute dataLenParm;

  BEGIN
    keyLen:= 255;                       {maximum key length}
    dataLenParm := dataLen;
    BTRV := BTRCALL(
              operation,
              positionBlock,
              dataBuffer,
              dataLenParm,
              keyBuffer,
              keyLen,
              keyNumber );

    dataLen := dataPack[1];

  END; {BTRV}

  { Implementation of BTRVID }
  FUNCTION BTRVID(
                 operation      : WORD;
             VAR positionBlock;
             VAR dataBuffer;
             VAR dataLen        : WORD;
             VAR keyBuffer;
                 keyNumber      : SMALLINT;
             VAR clientID )     : SMALLINT;
  VAR
    KeyLen : Byte;
    VAR dataLenParm : longInt;
    dataPack : array[1..2] of word absolute dataLenParm;

  BEGIN
    dataLenParm := dataLen;
    KeyLen:= 255;                       {maximum key length}
    BTRVID := BTRCALLID(
                operation,
                positionBlock,
                dataBuffer,
                dataLenParm,
                keyBuffer,
                keyLen,
                keyNumber,clientID );

    dataLen := dataPack[1];

  END; {BTRVID}

  FUNCTION WBSHELLINIT(
             VAR initializationString ): SMALLINT; FAR;
             STDCALL;
             external 'W3BTRV7.DLL' name 'WBSHELLINIT';

  FUNCTION WBRQSHELLINIT(
             VAR initializationString ): SMALLINT; FAR;
             external 'W3BTRV7.DLL' name 'WBRQSHELLINIT';

  FUNCTION WBTRVINIT(
             VAR intializationString): SMALLINT; FAR;
             STDCALL;
             external 'W3BTRV7.DLL' name 'WBTRVINIT';

  FUNCTION WBTRVSTOP: SMALLINT; FAR;
             STDCALL;
             external 'W3BTRV7.DLL' name 'WBTRVSTOP';

  { Implementation of BTRVINIT }
  FUNCTION BTRVINIT( VAR initializationString ): SMALLINT;
  BEGIN
    BTRVINIT := WBTRVINIT( initializationString );
  END;

  { Implementation of BTRVSTOP }
  FUNCTION BTRVSTOP: SMALLINT;
  BEGIN
    BTRVSTOP:= WBTRVSTOP;
  END;

   { Implementation of BRQSHELLINIT }
  FUNCTION BRQSHELLINIT( VAR initializationString ): SMALLINT;
  BEGIN
    BRQSHELLINIT:= WBRQSHELLINIT( initializationString );
  END;

END.
