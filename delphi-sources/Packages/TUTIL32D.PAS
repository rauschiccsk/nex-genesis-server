unit TUTIL32D;

interface

uses Windows, Bde, DbiTypes;

{ TUtility (TUVerifyTable) Session Options }
const
  TU_Append_Errors = 1;
  TU_No_Secondary  = 2;
  TU_No_Warnings   = 4;
  TU_Header_Only   = 8;
  TU_Dialog_Hide   = 16;
  TU_No_Lock       = 32;

{ TUtility type definitions }
type
  hTUses  = Word;
  phTUses = ^hTUses;
  { Verify Callback processes }
  TUVerifyProcess = (TUVerifyHeader, TUVerifyIndex, TUVerifyData, TUVerifySXHeader,
                     TUVerifySXIndex, TUVerifySXData, TUVerifySXIntegrity,
                     TUVerifyTableName, TURebuild);
  { Call back info for Verify Callback function }
  TUVerifyCallBack = record
    PercentDone: word;
    TableName: DBIPath;
    Process: TUVerifyProcess;
    CurrentIndex: word;
    TotalIndex: word;
  end;

  TTUDInit = function (var hTUSession: hTUses): DBIResult;  stdcall;
  TTUDVerifyTable = function (hTUSession: hTUses; pszTableName, pszDriverType, pszErrTableName, pszPassword: PChar; iOptions: integer; var piErrorLevel: Integer): DBIResult; stdcall;
  TTUDRebuildTable = function (hTUSession: hTUses; pszTableName, pszDriverType, pszBackupTableName, pszKeyviolName, pszProblemTableName: PChar; pCrDesc: pCRTblDesc): DBIResult; stdcall;
  TTUDGetCRTblDescCount = function (hTUSession: hTUses; pszTableName: PChar; var iFldCount, iIdxCount, iSecRecCount, iValChkCount, iRintCount, iOptParams, iOptDataLen: word): DBIResult; stdcall;
  TTUDFillCRTblDesc = function (hTUSession: hTUses; pCrDesc: pCRTblDesc; pszTableName, pszPassword: PChar): DBIResult; stdcall;
  TTUDFillCURProps = function (hTUSession: hTUses; pszTableName: PChar; var tblProps: CURProps): DBIResult; stdcall;
  TTUDGetExtTblProps = function (hTUSession: hTUses; pszTableName: PChar; var pTS: TimeStamp; var pbReadOnly: Boolean): DBIResult; stdcall;
  TTUDExit = function (hTUSession: hTUses): DBIResult; stdcall;
  TTUDGetErrorString = function (iErrorcode: DBIResult; pszError: PChar): DBIResult; stdcall;


procedure LoadTUDLL (pPath:string);
procedure UnloadTUDLL;

var
  TUDInit:TTUDInit;
  TUDVerifyTable:TTUDVerifyTable;
  TUDRebuildTable:TTUDRebuildTable;
  TUDGetCRTblDescCount:TTUDGetCRTblDescCount;
  TUDFillCRTblDesc:TTUDFillCRTblDesc;
  TUDFillCURProps:TTUDFillCURProps;
  TUDGetExtTblProps:TTUDGetExtTblProps;
  TUDExit:TTUDExit;
  TUDGetErrorString:TTUDGetErrorString;

implementation

const
  TU32 = 'TUTIL32.DLL';

var TUHandle:HWND;

procedure LoadTUDLL (pPath:string);
begin
  If TUHandle>HInstance_Error then UnloadTUDLL;
  TUHandle := LoadLibrary(PChar(pPath+TU32));
  If TUHandle>HInstance_Error then begin
    @TUDInit := GetProcAddress(TUHandle, 'TUInit');
    @TUDVerifyTable := GetProcAddress(TUHandle, 'TUVerifyTable');
    @TUDRebuildTable := GetProcAddress(TUHandle, 'TURebuildTable');
    @TUDGetCRTblDescCount := GetProcAddress(TUHandle, 'TUGetCRTblDescCount');
    @TUDFillCRTblDesc := GetProcAddress(TUHandle, 'TUFillCRTblDesc');
    @TUDFillCURProps := GetProcAddress(TUHandle, 'TUFillCURProps');
    @TUDGetExtTblProps := GetProcAddress(TUHandle, 'TUGetExtTblProps');
    @TUDExit := GetProcAddress(TUHandle, 'TUExit');
    @TUDGetErrorString := GetProcAddress(TUHandle, 'TUGetErrorString');
  end;
end;

procedure UnloadTUDLL;
begin
  TUDInit := nil;
  TUDVerifyTable := nil;
  TUDRebuildTable := nil;
  TUDGetCRTblDescCount := nil;
  TUDFillCRTblDesc := nil;
  TUDFillCURProps := nil;
  TUDGetExtTblProps := nil;
  TUDExit := nil;
  TUDGetErrorString := nil;
  If TUHandle>HInstance_Error then FreeLibrary(TUHandle);
  TUHandle := 0;
end;

end.
