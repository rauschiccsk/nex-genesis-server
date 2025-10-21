unit Wgd;
{$F+}
// *****************************************************************************
// Ovladac textoveho suboru, ktory skuzi na import vahovych
// dokaldov z textovych suborov adresara WGHDOC.
// *****************************************************************************

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, 
  NexGlob, NexMsg, NexPath, NexError, NexIni,
  TxtWrap, TxtCut, TxtFile, Key, Gsi, Doc, tWGHImp, tWGIImp,
  SysUtils, Forms, IcProgressBar, NexPxTable;

type
  TWgd = class
    constructor Create;
    destructor  Destroy; override;
    private
      oGsi:TGsi;
    public
      otWGH:TWGHImpTmp;
      otWGI:TWGIImpTmp;
      procedure LoadDoc(pFileName:ShortString);
      procedure LoadDocLst(pVendor:Str30;pDate1,pDate2:double);
    published
  end;

implementation

uses bGSCAT;

constructor TWgd.Create;
begin
  oGsi := TGsi.Create;
  otWGH := TWghimpTmp.Create;  otWGH.Open;
  otWGI := TWgiimpTmp.Create;  otWGI.Open;
end;

destructor TWgd.Destroy;
begin
  otWGI.Close;otWGH.Close;
  FreeAndNil(otWGI);
  FreeAndNil(otWGH);
  FreeAndNil(oGsi);
end;

// ********************************* PUBLIC ************************************

procedure TWgd.LoadDoc(pFileName:ShortString);
var mFind:boolean;mTxt:TextFile;mErr:TextFile;mS:String;
begin
  //
  otWGI.TmpTable.DelRecs;
  If FileExists(pFileName) then begin
    try
    Assignfile(mErr,ExtractFilePath(pFileName)+'wghdoc.err');
    {$I-} Append(mErr); {$I+} If IOResult<>0 then Rewrite(mErr);

    Assignfile(mTxt,pFileName);
    Reset(mTxt);
    mFind := True;
    ReadLn(mTxt,mS);
    (*
    otWGH.SwapIndex;otWGH.SetIndex(ixVWB);
    otWGH.Insert;
    otWGH.Vendor  := ValInt(Copy(pFileName,1,2));
    otWGH.WgNum   := ValInt(Copy(pFileName,3,1));
    otWGH.BlkNum  := ValInt(Copy(pFileName,4,5));
    otWGH.BlkDate := StrToDate(LineElement(mS,1,';'));
    otWGH.BlkTime := StrToTime(LineElement(mS,2,';'));
    otWGH.ItmCnt := StrToInt(LineElement(mS,3,';'));
    otWGH.BlkVal := StrToFloat(ReplaceStr(LineElement(mS,4,';'),'.',','));
    otWGH.Post;
    *)
    Repeat
      ReadLn(mTxt,mS);
      mFind := oGsi.ohGSCAT.LocateGsCode(StrToInt(LineElement(mS,1,';')));
      otWGI.Insert;
      otWGI.ItmNum := otWGI.Count+1;
      If mFind then BTR_To_PX(oGsi.ohGSCAT.BtrTable,otWGI.TmpTable)
      else begin
        Writeln(mErr,mS);
        ShowMsg (eCom.GscIsNoExist,LineElement(mS,1,';')+' '+LineElement(mS,3,';')+' MJ '+LineElement(mS,4,';')+' €');
      end;
      otWGI.GsQnt := StrToFloat(ReplaceStr(LineElement(mS,3,';'),'.',','));
      otWGI.BPrice := StrToFloat(ReplaceStr(LineElement(mS,4,';'),'.',','));
      otWGI.BValue := otWGI.BPrice*otWGI.GsQnt;
      otWGI.Post;
    until Eof(mTxt);
//    otWGH.RestoreIndex;
    finally
    Close(mTxt);
    Close(mErr);
    end;
  end else ShowMsg (ecSysTxtFileIsNotExist,'');
end;

procedure TWgd.LoadDocLst(pVendor:Str30;pDate1,pDate2:double);
var mFind:boolean;mTxt:TextFile;mS:String;mSR:TSearchRec;
begin
  otWGH.TmpTable.DelRecs;
  if FindFirst(gpath.WghPath+'*.txt',faAnyFile-faVolumeID-faDirectory, mSR) = 0 then
  begin
    repeat
      If LongInInterval(Valint(Copy(mSr.Name,1,2)),pVendor) then begin
        Assignfile(mTxt,gPath.WghPath+mSR.Name);
        Reset(mTxt);
        ReadLn(mTxt,mS);
        If InDateInterval(pDate1,pDate2,StrToDate(LineElement(mS,1,';'))) then begin
          otWGH.Insert;
          otWGH.Vendor  := ValInt(Copy(mSR.Name,1,2));
          otWGH.WgNum   := ValInt(Copy(mSR.Name,3,1));
          otWGH.BlkNum  := ValInt(Copy(mSR.Name,4,5));
          otWGH.BlkDate := StrToDate(LineElement(mS,1,';'));
          otWGH.BlkTime := StrToTime(LineElement(mS,2,';'));
          otWGH.ItmCnt := StrToInt(LineElement(mS,3,';'));
          otWGH.BlkVal := StrToFloat(ReplaceStr(LineElement(mS,4,';'),'.',','));
          otWGH.Post;
        end;
        Close(mTxt);
      end;
    until FindNext(msr) <> 0;
    FindClose(msr);
  end;
end;

// ********************************* PRIVATE ***********************************

end.
