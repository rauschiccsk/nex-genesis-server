unit BtrHand;

interface

uses
 {IdentCode} BtrStruct,
 {Pervasive} BtrConst, BtrAPI32,
 {Delphi}    Windows,  DB;

 const cbtrOpen:smallint = 0;

function  BtrOpen       (pPathAndTableFileName: string;
                        var pPosBlock: BTR_Position_Block;pOpenMode:smallint): BTR_Status;
//2000.3.29.                          var pClient: CLIENT_ID): BTR_Status;
function  BtrClose      (var pPosBlock: BTR_Position_Block): BTR_Status;
//2000.3.29.                          var pClient: CLIENT_ID): BTR_Status;
//1999.7.16.
function  BtrGetPosition(var pPosBlock: BTR_Position_Block;
                        var pClient: CLIENT_ID; var pPosition: TBtrPosition): BTR_Status;

function  BtrGetDirect  (var pPosition: TBtrPosition;
                        var pPosBlock: BTR_Position_Block;
                        var pBuffer: pointer;
                        var pBufferLen: word;
                        var pKeyNum: smallint;
                        var pClient: CLIENT_ID): BTR_Status;
//1999.7.19.
function  BtrGetCurrent (var pPosBlock: BTR_Position_Block;
                          var pBuffer: pointer;
                          var pBufferLen: word;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID): BTR_Status;
function  BtrGetFirst   (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
function  BtrGetLast    (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
function  BtrGetNext    (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
function  BtrGetPrevious(var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
function  BtrGetEqual   (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID): BTR_Status;
function  BtrGetLE      (var pPosBlock: BTR_Position_Block; //2000.1.12.
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID): BTR_Status;
function  BtrGetGE      (var pPosBlock: BTR_Position_Block; //2000.1.13.
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID): BTR_Status;

function  BtrStat       (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint): BTR_Status;
//2000.3.29.                          var pClient: CLIENT_ID): BTR_Status;

function  BtrUpdate     (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID): BTR_Status;
function  BtrInsert     (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint): BTR_Status;
//2000.3.29.                          var pClient: CLIENT_ID): BTR_Status;
function  BtrDelete     (var pPosBlock: BTR_Position_Block;
                         var pClient: CLIENT_ID): BTR_Status;

function  BtrBegTrans   : BTR_Status;
function  BtrBegTransCC : BTR_Status;
function  BtrBegTransEX : BTR_Status;

function  BtrEndTrans   : BTR_Status;

function  BtrAbortTrans : BTR_Status;
procedure SetAbortTrans;

procedure BtrReset;


function  BtrDataTypeToFieldType(pDataType:byte; pSize:word): TFieldType; //2000.1.8. athelyezve az AgyToolsbol

//2000.3.29.
function  BtrStepNext   (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word): BTR_Status;
function  BtrStepPrev   (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word): BTR_Status;
function  BtrStepFirst  (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word): BTR_Status;
function  BtrStepLast   (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word): BTR_Status;
function  BtrCreate     (var pPosBlock: BTR_Position_Block;
                         var pBuffer;
                         var pBufferLen: word;
                             pPathAndTableFileName: string;
                         var pKeyNum: smallint): BTR_Status;

function  BtrGetNextExt (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
function  BtrGetPrevExt (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;

function  BtrStepNextExt (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pClient: CLIENT_ID): BTR_Status;
function  BtrStepPrevExt (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pClient: CLIENT_ID): BTR_Status;

function BtrVersion (var pPosBlock: BTR_Position_Block;var pVersion:string): BTR_Status;

// 10.11.2003 TIBI
function  BtrGetPercent  (var pPosBlock: BTR_Position_Block;
                          var pBuffer;
                          var pBufferLen: word;
                          var pKeyBuffer;
                          var pKeyNum: smallint;
                          var pClient: CLIENT_ID): BTR_Status;

procedure SetBias (pBias:integer);   // nastavenie biasu pre lockovanie zaznamov pri operaciach GET a Step a BegTrans
procedure ClearBias;                 // nulovanie  biasu pre lockovanie zaznamov pri operaciach GET a Step a BegTrans

var cBTRBIAS   : integer = 0;     // bias pre lockovanie zaznamov pri operaciach GET a Step a BegTrans
    cRunExTrans: boolean = FALSE; // urcuje ci sa bude spustat Exclusiv (TRUE) alebo Concurrent (FALSE) transkcia
    cRunTrans  : byte = 0; // stav transakcie 1-aktivna 2-prerusena 0-neaktivna


implementation

uses btrtools,icVariab;

function GetNexSysPath :string;
begin
  Result := gvSys.SysPath;
end;

procedure SetBias (pBias:integer);
begin
  cBTRBias:=pBias;
end;

procedure ClearBias;
begin
  cBTRBias:=0;
end;

function  BtrCreate;
var mKeyBuffer: string[255];
begin
  mKeyBuffer := pPathAndTableFileName + #0;
  Result := BTRV(B_CREATE,pPosBlock,pBuffer,pBufferLen,mKeyBuffer[1],pKeyNum);
end;

function  BtrStepFirst;
var mKeyBuffer: string[255];
    mKeyNum: smallint;
begin
  mKeyBuffer := '';
  mKeyNum := 0;
  Result := BTRV(cBTRBIAS+B_STEP_FIRST,pPosBlock,pBuffer,pBufferLen,mKeyBuffer,mKeyNum);
end;

function  BtrStepLast;
var mKeyBuffer: string[255];
    mKeyNum: smallint;
begin
  mKeyBuffer := '';
  mKeyNum    := 0;
  Result := BTRV(cBTRBIAS+B_STEP_LAST,pPosBlock,pBuffer,pBufferLen,mKeyBuffer,mKeyNum);
end;

function  BtrStepNext;
var mKeyBuffer: string[255];
    mKeyNum: smallint;
begin
  mKeyBuffer := '';
  mKeyNum    := 0;
  Result := BTRV(cBTRBIAS+B_STEP_NEXT,pPosBlock,pBuffer,pBufferLen,mKeyBuffer,mKeyNum);
end;

function  BtrStepPrev;
var mKeyBuffer: string[255];
    mKeyNum: smallint;
begin
  mKeyBuffer := '';
  mKeyNum    := 0;
  Result := BTRV(cBTRBIAS+B_STEP_PREVIOUS,pPosBlock,pBuffer,
                   pBufferLen,mKeyBuffer,mKeyNum);
end;

function  BtrDataTypeToFieldType(pDataType:byte; pSize:word): TFieldType;
begin
  case pDataType of
    STRING_TYPE   : Result :=  ftString;       //char      1-255
    INTEGER_TYPE  : case pSize of                         //integer	1,2,4,8
                      1:   Result := ftUnknown; //???
                      2:   Result := ftSmallint;
                      4:   Result := ftInteger;
//Len pre Delphi 3.0    8:   Result := ftLargeInt; //???
                      else Result := ftUnknown;
                    end;
    IEEE_TYPE     : case pSize of                         //float 	4,8
                      4:   Result := ftFloat;
                      8:   Result := ftFloat; //1999. 7.29. ftUnknown; //???
                      else Result := ftUnknown;
                    end;
    DATE_TYPE     : Result := ftDate;                     //date      4
    TIME_TYPE     : Result := ftTime;                     //time      4
    DECIMAL_TYPE  : Result := ftBCD;                      //decimal	1-10
    MONEY_TYPE    : Result := ftCurrency;                 //currency	8
    LOGICAL_TYPE  : case pSize of                         //logical   1,2
                      1:   Result := ftBoolean;
                      2:   Result := ftBoolean; //???
                      else Result := ftUnknown;
                    end;
    NUMERIC_TYPE  : Result := ftUnknown;                  //numeric   1-15 dec 0-size
    BFLOAT_TYPE   : Result := ftUnknown;                  //bfloat    4,8
    LSTRING_TYPE  : Result := ftString;                   //lstring   2-255
    ZSTRING_TYPE  : Result := ftString;                   //zstring   2-255
    UNSIGNED_BINARY_TYPE: case pSize of                   //unsigned  1,2,4,8
                      1:   Result := ftWord; //ftUnknown; //???
                      2:   Result := ftWord;
                      4:   Result := ftInteger;  //???
//Len pre Delphi 3.0    8:   Result := ftLargeInt; //???
                      else Result := ftUnknown;
                    end;
    AUTOINCREMENT_TYPE: case pSize of                     //autoinc   2,4
                      2: Result :=ftAutoInc; //???
                      4: Result :=ftAutoInc;
                      else Result := ftUnknown;
                    end;
    STS           : Result := ftUnknown;                  //numericsts 1-15 dec 0-size
    NUMERIC_SA    : Result := ftUnknown;                  //numericsts 1-15 dec 0-size
    CURRENCY_TYPE : Result := ftCurrency; //???           //money      1-10
    TIMESTAMP_TYPE: Result := ftDateTime;                 //timestamp  8
    else  Result := ftUnknown;
  end;
end;

function  BtrDelete(var pPosBlock: BTR_Position_Block; var pClient: CLIENT_ID): BTR_Status;
var mBuffer: string[255];
    mBufferLen: word;
    mKeyBuffer: string[255];
    mKeyNum: smallint;
begin
  mBuffer := '';
  mBufferLen := 0;
  mKeyBuffer := '';
  mKeyNum := 0;
  Result := BTRV(B_DELETE,pPosBlock,mBuffer[1],
                 mBufferLen,mKeyBuffer[1],mKeyNum);
end;

procedure SetAbortTrans;
begin
  If (cRunTrans > 10) then cRunTrans  := 12 else cRunTrans  := 2;
end;

function  BtrBegTrans: BTR_Status;
begin
  If cRunTrans in [1,2,11,12] then begin
    WriteToLogFile(GetNexSysPath+'TRANSACT.LOG','Duplic BegTrans');
    cRunTrans  := 11;
  end else begin
    If cRunExTrans then Result := BtrBegTransEX else Result := BtrBegTransCC;
    cRunTrans  := 1;
  end;
end;

function  BtrBegTransEX: BTR_Status;
var mBufferLen: word;
    mKeyNum: smallint;
    mBuffer   : string[255];
    mKeyBuffer: string[255];
    mPosBlock : string[128];
begin
  mBuffer    := '';
  mKeyBuffer := '';
  mKeyBuffer := '';
  mBufferLen := 0;
  mKeyNum    := 0;
  Result := BTRV(B_Begin_Tran,mPosBlock[1],mBuffer[1],mBufferLen,mKeyBuffer[1],mKeyNum);
end;

function  BtrBegTransCC: BTR_Status;
var mBufferLen: word;
    mKeyNum: smallint;
    mBuffer   : string[255];
    mKeyBuffer: string[255];
    mPosBlock : string[128];
begin
  mBuffer    := '';
  mKeyBuffer := '';
  mKeyBuffer := '';
  mBufferLen := 0;
  mKeyNum    := 0;
  Result := BTRV(1000+cBTRBIAS+B_Begin_Tran,mPosBlock[1],mBuffer[1],mBufferLen,mKeyBuffer[1],mKeyNum);
end;

function  BtrEndTrans: BTR_Status;
var mBufferLen: word;
    mKeyNum: smallint;
    mBuffer   : string[255];
    mKeyBuffer: string[255];
    mPosBlock : string[128];
begin
  mBuffer    := '';
  mKeyBuffer := '';
  mKeyBuffer := '';
  mBufferLen := 0;
  mKeyNum    := 0;
  If (cRunTrans = 2)or(cRunTrans = 12)
    then Result := BtrAbortTrans
    else Result := BTRV(B_End_Tran,mPosBlock[1],mBuffer[1],mBufferLen,mKeyBuffer[1],mKeyNum);
  cRunTrans  := 0;
end;

function  BtrAbortTrans: BTR_Status;
var mBufferLen: word;
    mKeyNum: smallint;
    mBuffer   : string[255];
    mKeyBuffer: string[255];
    mPosBlock : string[128];
begin
  mBuffer    := '';
  mKeyBuffer := '';
  mKeyBuffer := '';
  mBufferLen := 0;
  mKeyNum    := 0;
  Result := BTRV(B_Abort_Tran,mPosBlock[1],mBuffer[1],
                 mBufferLen,mKeyBuffer[1],mKeyNum);
  cRunTrans  := 3;
end;

procedure BtrReset;
var mBufferLen: word;
    mKeyNum: smallint;
    mBuffer   : string[255];
    mKeyBuffer: string[255];
    mPosBlock : string[128];
begin
  mBuffer    := '';
  mKeyBuffer := '';
  mKeyBuffer := #0;
  mBufferLen := 0;
  mKeyNum    := 0;
  BTRV(B_RESET,mPosBlock[1],mBuffer[1],
              mBufferLen,mKeyBuffer[1],mKeyNum);
end;

function  BtrInsert;
begin
  Result := BTRV(B_INSERT,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrUpdate(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status;
begin
  Result := BTRV(B_UPDATE,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrStat;
begin
  Result := BTRV(B_STAT,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrGetEqual(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status;
begin
  Result := BTRV(B_GET_EQUAL,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrGetLE(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status; //2000.1.12.
begin
  Result := BTRV(B_GET_LE,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrGetGE(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status; //2000.1.12.
begin
  Result := BTRV(B_GET_GE,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;


function  BtrGetPrevious(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
begin
  If pOpenMode=-2
    then Result := BtrStepPrev (pPosBlock,pBuffer,pBufferLen)
    else Result := BTRV(cBTRBIAS+B_GET_PREVIOUS,pPosBlock,pBuffer, pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrGetNext(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
begin
  If pOpenMode=-2
    then Result :=BtrStepNext (pPosBlock,pBuffer,pBufferLen)
    else Result := BTRV(cBTRBIAS+B_GET_NEXT,pPosBlock,pBuffer,pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrGetNextExt(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
begin
  If pOpenMode=-2
    then Result := BtrStepNextExt(pPosBlock,pBuffer,pBufferLen,pKeyBuffer,pClient)
    else Result := BTRV(B_GET_NEXT_EXTENDED,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrGetPrevExt(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
begin
  If pOpenMode=-2
    then Result := BtrStepPrevExt(pPosBlock,pBuffer,pBufferLen,pKeyBuffer,pClient)
    else Result := BTRV(B_GET_PREV_EXTENDED,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

function  BtrStepNextExt(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pClient: CLIENT_ID): BTR_Status;
var mKeyNum: smallint;
begin
  mKeyNum:=0;
  Result := BTRV(B_STEP_NEXT_EXT,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,mKeyNum);
end;

function  BtrStepPrevExt(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pClient: CLIENT_ID): BTR_Status;
var mKeyNum: smallint;
begin
  mKeyNum:=0;
  Result := BTRV(B_STEP_PREVIOUS_EXT,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,mKeyNum);
end;

function  BtrGetLast(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
begin
  If pOpenMode=-2
    then Result :=BtrStepLast (pPosBlock,pBuffer,pBufferLen)
    else Result := BTRV(cBTRBIAS+B_GET_LAST,pPosBlock,pBuffer,pBufferLen,pKeyBuffer,pKeyNum);
end;

function BtrGetFirst(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID;pOpenMode:smallint): BTR_Status;
begin
  If pOpenMode=-2
    then Result := BtrStepFirst (pPosBlock,pBuffer,pBufferLen)
    else Result := BTRV(cBTRBIAS+B_GET_FIRST,pPosBlock,pBuffer, pBufferLen,pKeyBuffer,pKeyNum);
end;

function BtrGetCurrent(var pPosBlock: BTR_Position_Block; var pBuffer: pointer; var pBufferLen: word; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status;
var mPosition: TBtrPosition;
begin
  Result := BtrGetPosition(pPosBlock, pClient, mPosition);
  If Result = B_NO_ERROR then begin
//deleted 2000.6.20.      move(mPosition[0], pBuffer^, 4);    ***
    move(mPosition, pBuffer^, 4);
    Result := BtrGetDirect(mPosition, pPosBlock, pBuffer, pBufferLen, pKeyNum, pClient);
  end;
end;

function BtrGetDirect(var pPosition: TBtrPosition; var pPosBlock: BTR_Position_Block; var pBuffer: pointer; var pBufferLen: word; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status;
var mKeyBuf: string[255];
    mAssigned: boolean;
begin
  mKeyBuf := '';
  mAssigned := assigned(pBuffer);
  if not mAssigned then GetMem(pBuffer,pBufferLen);
//  move(pPosition[0], pBuffer^, 4); ***
  move(pPosition, pBuffer^, 4);
  Result := BTRV(B_GET_DIRECT,pPosBlock,pBuffer^,pBufferLen,
                 mKeyBuf[1], //Ez itt mindegy mennyi
                 pKeyNum);
  If not mAssigned then FreeMem(pBuffer,pBufferLen);
end;

function BtrGetPosition(var pPosBlock: BTR_Position_Block; var pClient: CLIENT_ID; var pPosition: TBtrPosition): BTR_Status;
var mDBLen: word;
    mKeyBuf: string[255];
    mKeyNum: smallint;
begin
  mDBLen  := 4;
  mKeyBuf := ''; //nem lenyeges
  mKeyNum := 0;  //nem lenyeges
  //Itt toltodik fel a position
  Result  := BTRV(B_GET_POSITION,pPosBlock,pPosition,mDBLen,
                  mKeyBuf[1],mKeyNum);
end;

function BtrOpen;
var mDataBuffer: array[0..255] of char; //ez a megnyitasnal csak arra kell hogy megadjuk a felhasznalo nevet
    mDataLen: word;
    mKeyBuf: string[255];
begin
//    fillchar(pClient.networkAndNode, sizeof(pClient.networkAndNode), #0);
//    pClient.applicationID := 'WR'+#0; //'MT' + #0;  { must be greater than "AA" }
//    pClient.threadID := MY_THREAD_ID;
{
  FillChar(mDataBuffer,SizeOf(mDataBuffer), #0); // jelen esetben nem adunk nevet
  mDataLen := 0;
  mKeyBuf := pPathAndTableFileName + #0;
  mOpenMode := NORMAL; //64; //ACCELERATED;//NORMAL;
  Result := BTRV(B_OPEN,pPosBlock,mDataBuffer,mDataLen,mKeyBuf[1],mOpenMode);
}
  FillChar(mDataBuffer,SizeOf(mDataBuffer), #0); // jelen esetben nem adunk nevet
  mDataLen := 0;
  mKeyBuf := pPathAndTableFileName + #0;
  Result := BTRV(B_OPEN,pPosBlock,mDataBuffer,mDataLen,mKeyBuf[1],pOpenMode);
end;

function BtrClose;
var mDataBuffer: array[0..1] of char;
    mDataLen: word;   mKeyBuf: string[255];
    mKeyNum: smallint;
begin
  FillChar(mDataBuffer, sizeof(mDataBuffer), #0); // jelen esetben nem adunk nevet
  mDataLen := 0;
  mKeyBuf := #0;
  mKeyNum := 0;
  Result := BTRV(B_CLOSE,pPosBlock,mDataBuffer,mDataLen,
                 mKeyBuf[1],mKeyNum);
end;

function BtrVersion;
type
  TVer= packed record
    Version:word;
    Revision:word;
    Mode:byte;
    Other:string[10];
  end;
var mDataBuffer: TVer;
    mDataLen: word;   mKeyBuf: string[255];
    mKeyNum: smallint;
    mVerInt,mVerFract:string;
begin
  FillChar(mDataBuffer, sizeof(mDataBuffer), #0); // jelen esetben nem adunk nevet
  mDataLen := 15;
  mKeyBuf := #0;
  mKeyNum := 0;
  Result := BTRV(B_VERSION,pPosBlock,mDataBuffer,mDataLen,
                 mKeyBuf[1],mKeyNum);
  Str (mDataBuffer.Version,mVerInt);
  Str (mDataBuffer.Revision,mVerFract);
  pVersion := mVerInt+'.'+mVerFract;
end;

function  BtrGetPercent(var pPosBlock: BTR_Position_Block; var pBuffer; var pBufferLen: word; var pKeyBuffer; var pKeyNum: smallint; var pClient: CLIENT_ID): BTR_Status;
begin
  Result := BTRV(B_GET_PERCENT,pPosBlock,pBuffer,
                 pBufferLen,pKeyBuffer,pKeyNum);
end;

end.
