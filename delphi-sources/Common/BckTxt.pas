unit BckTxt;

interface

uses
  Registry,
  EncodeIni, ZipMstr,
  IcConv, IcVariab, NexPath, BtrTable, NexBtrTable,
  Dialogs, SysUtils, Classes, Windows, Forms;

  type
  TArchType = (cArch, cPrn, cDel);

  TBckTxtData = record
    ArchBckOn:boolean;
    DelBckOn :boolean;
    PrnBckOn :boolean;
    EncodeTxt:boolean;
    AutoZip  :boolean;
    ZipPasw  :string;
  end;

  TBckTxt = class

  private
    oIni      : TEncodeIniFile;
    oCompName : string;
    oArchType : TArchType;
    oBckCntTbl: TBtrieveTable;

    procedure WriteDocToTxtFile (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string);

    procedure WriteSystemData (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string);
    procedure WriteHeadData (pHead:TBtrieveTable);
    procedure WriteItmData (pItm:TBtrieveTable;pNum:longint;pDocNum:string);
    function  GetFileCnt (pFile,pDocNum,pType:string):string;
    procedure ReadComputerName;

    procedure ZIPMessage(Sender: TObject; ErrCode: Integer; Message: string);
  public
    constructor Create (pArchType:TArchType;pEncode:boolean);
    destructor Destroy; override;

    procedure  WriteDocToTxt (pHead,pItm:TBtrieveTable;pFrmName,pOperation:string); overload;
    procedure  WriteDocToTxt (pHead,pItm1,pItm2:TBtrieveTable;pFrmName,pOperation:string); overload;
    procedure  WriteDocToTxt (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string); overload;
  end;

procedure WriteDocToTxt (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string;pArchType:TArchType);

procedure WriteDocToArc (pHead,pItm1:TBtrieveTable;pFrmName,pOperation:string); overload;
procedure WriteDocToArc (pHead,pItm1,pItm2:TBtrieveTable;pFrmName,pOperation:string); overload;
procedure WriteDocToArc (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string); overload;

procedure WriteDocToDel (pHead,pItm1:TBtrieveTable;pFrmName:string); overload;
procedure WriteDocToDel (pHead,pItm1,pItm2:TBtrieveTable;pFrmName:string); overload;
procedure WriteDocToDel (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName:string); overload;

procedure WriteDocToPrn (pHead,pItm1:TBtrieveTable;pFrmName:string); overload;
procedure WriteDocToPrn (pHead,pItm1,pItm2:TBtrieveTable;pFrmName:string); overload;
procedure WriteDocToPrn (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName:string); overload;

var
  gBckTxtZip: TZipMaster;
  gBckTxtData: TBckTxtData;

implementation

procedure WriteDocToTxt (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string;pArchType:TArchType);
var mTxtBck:TBckTxt;
begin
  mTxtBck := TBckTxt.Create(pArchType,FALSE);
  mTxtBck.WriteDocToTxtFile(pHead,pItm1,pItm2,pItm3,pFrmName,pOperation);
  FreeAndNil (mTxtBck);
end;

procedure WriteDocToArc (pHead,pItm1:TBtrieveTable;pFrmName,pOperation:string);
begin
  If gBckTxtData.ArchBckOn then WriteDocToTxt (pHead,pItm1,nil,nil,pFrmName,pOperation,cArch);
end;

procedure WriteDocToArc (pHead,pItm1,pItm2:TBtrieveTable;pFrmName,pOperation:string);
begin
  If gBckTxtData.ArchBckOn then WriteDocToTxt (pHead,pItm1,pItm2,nil,pFrmName,pOperation,cArch);
end;

procedure WriteDocToArc (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string);
begin
  If gBckTxtData.ArchBckOn then WriteDocToTxt (pHead,pItm1,pItm2,pItm3,pFrmName,pOperation,cArch);
end;

procedure WriteDocToDel (pHead,pItm1:TBtrieveTable;pFrmName:string);
begin
  If gBckTxtData.DelBckOn then WriteDocToTxt (pHead,pItm1,nil,nil,pFrmName,'DEL',cDel);
end;

procedure WriteDocToDel (pHead,pItm1,pItm2:TBtrieveTable;pFrmName:string);
begin
  If gBckTxtData.DelBckOn then WriteDocToTxt (pHead,pItm1,pItm2,nil,pFrmName,'DEL',cDel);
end;

procedure WriteDocToDel (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName:string);
begin
  If gBckTxtData.DelBckOn then WriteDocToTxt (pHead,pItm1,pItm2,pItm3,pFrmName,'DEL',cDel);
end;

procedure WriteDocToPrn (pHead,pItm1:TBtrieveTable;pFrmName:string);
begin
  If gBckTxtData.PrnBckOn then WriteDocToTxt (pHead,pItm1,nil,nil,pFrmName,'PRN',cPrn);
end;

procedure WriteDocToPrn (pHead,pItm1,pItm2:TBtrieveTable;pFrmName:string);
begin
  If gBckTxtData.PrnBckOn then WriteDocToTxt (pHead,pItm1,pItm2,nil,pFrmName,'PRN',cPrn);
end;

procedure WriteDocToPrn (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName:string);
begin
  If gBckTxtData.PrnBckOn then WriteDocToTxt (pHead,pItm1,pItm2,pItm3,pFrmName,'PRN',cPrn);
end;

// ***************************************************************************
procedure TBckTxt.WriteDocToTxtFile (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string);
var mFile,mDocNum,mPath,mType,mCntS,mSubDir:string;
begin
  mDocNum := pHead.FieldByName ('DocNum').AsString;
  case oArchType of
    cPrn: mSubDir := 'PRNDAT';
    cDel: mSubDir := 'DELDAT';
    else mSubDir := 'ARCDAT';
  end;
  mPath := gPath.NydPath+'BCKTXT\'+mSubDir+'\'+Copy (mDocNum,1,7)+'\';
  If not DirectoryExists(mPath) then ForceDirectories (mPath);
  case oArchType of
    cPrn: mType := 'P';
    cDel: mType := 'D';
    else mType := 'A';
  end;
  mFile := mPath+mDocNum+'.'+mType;
  mCntS := GetFileCnt (mFile,mDocNum,mType);
  mFile := mFile+mCntS;
  oIni := TEncodeIniFile.Create(mFile,FALSE);
  oIni.Encode := gBckTxtData.EncodeTxt;
  WriteSystemData (pHead,pItm1,pItm2,pItm3,pFrmName,pOperation);
  WriteHeadData(pHead);
  If pItm1<>nil then WriteItmData(pItm1,1,mDocNum);
  If pItm2<>nil then WriteItmData(pItm2,2,mDocNum);
  If pItm3<>nil then WriteItmData(pItm3,3,mDocNum);
  oIni.SaveFile;
  FreeAndNil (oIni);
  If gBckTxtData.AutoZip then begin
    gBckTxtZip.FSpecArgs.Clear;
    If gBckTxtData.ZipPasw<>'' then begin
      gBckTxtZip.AddOptions := gBckTxtZip.AddOptions+[AddEncrypt];
      gBckTxtZip.Password := gBckTxtData.ZipPasw;
    end;
    case oArchType of
      cPrn: mSubDir := 'PRNZIP';
      cDel: mSubDir := 'DELZIP';
      else mSubDir := 'ARCZIP';
    end;
    mPath := gPath.NydPath+'BCKTXT\'+mSubDir+'\'+Copy (mDocNum,1,7)+'\';
    If not DirectoryExists(mPath) then ForceDirectories (mPath);
    gBckTxtZip.ZipFileName := mPath+mDocNum+'_'+mType+mCntS+'.ZIP';
    gBckTxtZip.FSpecArgs.Add (mFile);
    try gBckTxtZip.Add; except  end;
    If FileExists (gBckTxtZip.ZipFileName) then SysUtils.DeleteFile(mFile);
  end;
end;

procedure TBckTxt.WriteSystemData (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string);
begin
  oIni.WriteString('SYSTEM','PCName',oCompName);
  oIni.WriteString('SYSTEM','FrmName',pFrmName);
  oIni.WriteString('SYSTEM','Operation',pOperation);
  If pHead<>nil then oIni.WriteString('SYSTEM','Path',pHead.DataBaseName);
  oIni.WriteString('SYSTEM','ModName',gvSys.LoginName);
  oIni.WriteString('SYSTEM','UserName',gvSys.UserName);
  oIni.WriteDate('SYSTEM','ModDate',Date);
  oIni.WriteTime('SYSTEM','ModTime',Time);
  oIni.WriteString('SYSTEM','NexVer',cPrgVer);
  oIni.WriteString('SYSTEM','ActYear',gvSys.ActYear);
  oIni.WriteString('SYSTEM','ActOrgName',gvSys.ActOrgName);
  If pHead<>nil then oIni.WriteString('SYSTEM','HeadTable',pHead.TableName);
  If pItm1<>nil then oIni.WriteString('SYSTEM','Itm1Table',pItm1.TableName);
  If pItm2<>nil then oIni.WriteString('SYSTEM','Itm2Table',pItm2.TableName);
  If pItm3<>nil then oIni.WriteString('SYSTEM','Itm3Table',pItm3.TableName);
end;

procedure TBckTxt.WriteHeadData (pHead:TBtrieveTable);
var mS:string; I:longint;
begin
  mS := '';
  For I:=0 to pHead.Fields.Count-1 do begin
    If mS<>'' then mS := mS+';';
    mS := mS+pHead.Fields.Fields[I].FieldName;
  end;
  oIni.WriteString('HEAD','Fields',mS);
  mS := '';
  For I:=0 to pHead.Fields.Count-1 do begin
    If mS<>'' then mS := mS+';';
    mS := mS+pHead.Fields.Fields[I].AsString;
  end;
  oIni.WriteString('HEAD','Item',mS);
end;

procedure TBckTxt.WriteItmData (pItm:TBtrieveTable;pNum:longint;pDocNum:string);
var mS:string; I,mItmNum:longint; mTbl:TBtrieveTable;
begin
  If pItm.RecordCount>0 then begin
    mTbl := TBtrieveTable.Create(nil);
    mTbl.DataBaseName := pItm.DataBaseName;
    mTbl.TableName := pItm.TableName;
    mTbl.FixedName := pItm.FixedName;
    mTbl.DefPath := pItm.DefPath;
    mTbl.DefName := pItm.DefName;
    mTbl.Open;
    mTbl.IndexName := 'DocNum';
    If mTbl.FindKey([pDocNum]) then begin
      mS := '';
      For I:=0 to mTbl.Fields.Count-1 do begin
        If mS<>'' then mS := mS+';';
        mS := mS+mTbl.Fields.Fields[I].FieldName;
      end;
      oIni.WriteString('ITM'+StrInt(pNum,0),'Fields',mS);
      mItmNum := 0;
      Repeat
        mS := ''; Inc (mItmNum);
        For I:=0 to mTbl.Fields.Count-1 do begin
          If mS<>'' then mS := mS+';';
          mS := mS+mTbl.Fields.Fields[I].AsString;
        end;
        oIni.WriteString('ITM'+StrInt(pNum,0),'Item'+StrInt(mItmNum,0),mS);
        Application.ProcessMessages;
        mTbl.Next;
      until mTbl.Eof or (mTbl.FieldByName('DocNum').AsString<>pDocNum);
    end;
    mTbl.Close;
    FreeAndNil (mTbl);
  end;
end;

function  TBckTxt.GetFileCnt (pFile,pDocNum,pType:string):string;
var mSR: TSearchRec; mCnt:longint; mSL:TStringList; mS:string; mNew:boolean;
begin
  mNew := TRUE;
  If oBckCntTbl.FindKey([pDocNum,pType]) then begin
    mCnt := oBckCntTbl.FieldByName ('Cnt').AsInteger+1;
    mNew := FileExists(pFile+StrIntZero (mCnt,3));
  end;
  If mNew then begin
    mCnt := 1;
    If FindFirst(pFile+'*', faAnyFile,mSR)=0 then begin
      mSL := TStringList.Create;
      Repeat
        mSL.Add (ExtractFileExt(mSR.Name));
      until FindNext(mSR) <> 0;
      SysUtils.FindClose(mSR);
      If mSL.Count>0 then begin
        mSL.Sort;
        mS := Copy (mSL.Strings[mSL.Count-1],3,3);
        mCnt := ValInt (mS)+1;
      end;
      FreeAndNil (mSL);
    end;
  end;
  If oBckCntTbl.FindKey([pDocNum,pType]) then oBckCntTbl.Edit  else oBckCntTbl.Insert;
  oBckCntTbl.FieldByName('DocNum').AsString := pDocNum;
  oBckCntTbl.FieldByName('Type').AsString := pType;
  oBckCntTbl.FieldByName('Cnt').AsInteger := mCnt;
  oBckCntTbl.Post;

  Result := StrIntZero (mCnt,3);
end;

procedure TBckTxt.ReadComputerName;
var mR:TRegistry;
begin
  mR := TRegistry.Create;
  mR.RootKey := HKEY_LOCAL_MACHINE;
  If mR.OpenKey('\System\CurrentControlSet\control\ComputerName\ComputerName\',TRUE) then begin
    If mR.ValueExists ('ComputerName') then oCompName := mR.ReadString ('ComputerName');
  end;
  mR.Destroy;
end;

procedure TBckTxt.ZIPMessage(Sender: TObject; ErrCode: Integer; Message: String);
begin
  If ErrCode>0 then ShowMessage (Message+','+StrInt (ErrCode,0));
end;

constructor TBckTxt.Create (pArchType:TArchType;pEncode:boolean);
begin
  oArchType := pArchType;
  ReadComputerName;
  oBckCntTbl := TBtrieveTable.Create(nil);
  oBckCntTbl.DataBaseName := gPath.SysPath;
  oBckCntTbl.TableName := 'BCKCNT';
  oBckCntTbl.DefName := 'BCKCNT.BDF';
  oBckCntTbl.DefPath := gPath.DefPath;
  oBckCntTbl.AutoCreate := TRUE;
  oBckCntTbl.Open;
  If gBckTxtData.AutoZip then begin
    gBckTxtZip := TZipMaster.Create(nil);
    gBckTxtZip.OnMessage := ZIPMessage;
    gBckTxtZip.AddCompLevel := 6;
  end;
end;

destructor TBckTxt.Destroy;
begin
  oBckCntTbl.Close;
  FreeAndNil (oBckCntTbl);
  inherited;
end;

procedure  TBckTxt.WriteDocToTxt (pHead,pItm:TBtrieveTable;pFrmName,pOperation:string);
begin
  WriteDocToTxtFile (pHead,pItm,nil,nil,pFrmName,pOperation);
end;

procedure  TBckTxt.WriteDocToTxt (pHead,pItm1,pItm2:TBtrieveTable;pFrmName,pOperation:string);
begin
  WriteDocToTxtFile (pHead,pItm1,pItm2,nil,pFrmName,pOperation);
end;

procedure  TBckTxt.WriteDocToTxt (pHead,pItm1,pItm2,pItm3:TBtrieveTable;pFrmName,pOperation:string);
begin
  WriteDocToTxtFile (pHead,pItm1,pItm2,pItm3,pFrmName,pOperation);
end;

begin
  gBckTxtData.ArchBckOn := TRUE;
  gBckTxtData.DelBckOn  := TRUE;
  gBckTxtData.PrnBckOn  := TRUE;
  gBckTxtData.EncodeTxt := FALSE;
  gBckTxtData.AutoZip   := TRUE;
  gBckTxtData.ZipPasw   := '';
end.
