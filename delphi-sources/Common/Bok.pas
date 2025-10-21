unit Bok;

interface

uses
  IcTypes, IcVariab, IcConv, NexVar, NexMsg, NexError, LinLst, BasFnc,
  hNXBDEF, hABKDEF, tBOKLST,
  IniFiles, Classes, SysUtils;

type
  TBok=class
    constructor Create;
    destructor Destroy; override;
  private
    oBokLst:TLinLst;
    ohNXBDEF:TNxbdefHnd;
    ohABKDEF:TAbkdefHnd;
    procedure AddBok(pBokNum:Str5;pBokName:Str30;pBokType:Str1);
  public
    otBOKLST:TBoklstTmp;
    oPmdCod:Str3;
    oBoks:Str200;
    procedure LoadBokLst(pPmdCod:Str3;pBokLst:Str200);       // Nacita zoznam knih zadaneho modulu, ktore su zadane v pBokLst, ak pBokLst je prazdny nacita vsetky knihy
    function LoadBoks(pPmdCod:Str3;pBokLst:Str200):boolean;  // Nacita zoznam knih zadaneho modulu, ktore su zadane v pBokLst do otBOKLST, ak pBokLst je prazdny nacita vsetky knihy
    function BokName(pPmdCod:Str3;pBokNum:Str5):Str30; // Udava meno knihy
    function BokType(pPmdCod:Str3;pBokNum:Str5):Str1;  // Udava typ knihy
    function BokActY(pPmdCod:Str3;pBokNum:Str5):boolean; // TRUE ak kniha je zalozena na aktualny rok
    function ReloadBoks:boolean;  // Nacita zoznam knih zadaneho modulu, ktore su zadane v pBokLst do otBOKLST, ak pBokLst je prazdny nacita vsetky knihy

    function BokFirst(pPmdCod:Str3):Str5; overload;// Prva kniha ktora je dostupna pre zadaneho uzivatela
    function BokFirst(pGrpNum:word;pPmdCod:Str3):Str5; overload;// Prva kniha ktora je dostupna pre zadaneho uzivatela
    function BokExist(pPmdCod:Str3):boolean; overload;// TRUE ak pre prihlaseneho uzivatela a zadany modul je nadefinovana aspon jedna kniha
    function BokExist(pGrpNum:word;pPmdCod:Str3):boolean; overload;// TRUE ak pre zadaneho uzivatela a zadany modul je nadefinovana aspon jedna kniha
    function BokExist(pPmdCod:Str3;pBokNum:Str5;pGlobLst:boolean):boolean; overload;// TRUE ak existuje zadana kniha
    function BokAcces(pGrpNum:word;pPmdCod:Str3;pBokNum:Str5):boolean; overload;// TRUE ak pre zadaneho uzivatela je dostupna zadana kniha

    property BokLst:TLinLst read oBokLst write oBokLst;
    property NxbDef:TNxbDefHnd read ohNxbDef write ohNxbDef;
  end;

function PmdBokExist(pPmdCod:Str3;pBokNum:Str5):boolean;

var gBok:TBok;

implementation

uses bABKDEF, bNXBDEF;

function PmdBokExist(pPmdCod:Str3;pBokNum:Str5):boolean;
var mhNXBDEF:TNxbdefHnd;
begin
  mhNXBDEF:=TNxbdefHnd.Create; mhNXBDEF.Open;
  Result:=mhNXBDEF.LocatePmBn(pPmdCod,pBokNum);
  mhNXBDEF.Close; FreeAndNil(mhNXBDEF);
end;

constructor TBok.Create;
begin
  oBokLst:=TLinLst.Create;
  ohNXBDEF:=TNxbdefHnd.Create;   ohNXBDEF.Open;
  ohABKDEF:=TAbkdefHnd.Create;   ohABKDEF.Open;
  otBOKLST:=TBoklstTmp.Create;
  oPmdCod:=''; oBoks:='';
end;

destructor TBok.Destroy;
begin
  FreeAndNil (otBOKLST);
  FreeAndNil (ohABKDEF);
  FreeAndNil (ohNXBDEF);
  FreeAndNil (oBokLst);
end;

// *********************************** PRIVATE *********************************

procedure TBok.AddBok (pBokNum:Str5;pBokName:Str30;pBokType:Str1);
begin
  If not otBOKLST.LocBokNum(pBokNum) then begin
    otBOKLST.Insert;
    otBOKLST.BokNum:=pBokNum;
    otBOKLST.BokNam:=pBokName;
    otBOKLST.Post;
  end;
end;

// *********************************** PUBLIC **********************************

procedure TBok.LoadBokLst(pPmdCod:Str3;pBokLst:Str200);  // Nacita zoznam knih zadaneho modulu, ktore su zadane v pBokLst, ak pBokLst je prazdny nacita vsetky knihy
var mLinLst:TLinLst;
begin
  oPmdCod:=pPmdCod; oBoks:=pBokLst;
  oBokLst.Clear;
  If pBokLst='' then begin  // Nacitame vsetky knihy zadaneho typu
    If ohNXBDEF.LocatePmdMark(pPmdCod) then begin
      Repeat
        oBokLst.AddItm(ohNXBDEF.BookNum);
        ohNXBDEF.Next;
      until ohNXBDEF.Eof or (ohNXBDEF.PmdMark<>pPmdCod);
    end;
  end
  else begin // Ponechame len tie knihy, ktore su zaevidovane
    mLinLst:=TLinLst.Create;
    mLinLst.AddLst(pBokLst);
    If mLinLst.Count>0 then begin
      mLinLst.First;
      Repeat
        If ohNXBDEF.LocatePmBn(pPmdCod,mLinLst.Itm) then oBokLst.AddItm(mLinLst.Itm);
        mLinLst.Next;
      until mLinLst.Eof;
    end;
    FreeAndNil (mLinLst);
  end;
  If cNexStart and (oBokLst.Count=0) and (pBokLst='' ) then begin
    ohNXBDEF.Insert;
    ohNXBDEF.PmdMark:=pPmdCod;
    ohNXBDEF.BookNum:='A-001';
    ohNXBDEF.BookName:=pPmdCod+' A-001 '+gvSys.ActYear;
    ohNXBDEF.BookType:='A';
    ohNXBDEF.Post;
    If not ohABKDEF.LocateGrPmBn(gvSys.LoginGroup,ohNXBDEF.PmdMark,ohNXBDEF.BookNum) then begin
      ohABKDEF.Insert;
      ohABKDEF.GrpNum:=gvSys.LoginGroup;
      ohABKDEF.PmdMark:=ohNXBDEF.PmdMark;
      ohABKDEF.BookNum:=ohNXBDEF.BookNum;
      ohABKDEF.Post;
    end;
    oBokLst.AddItm(ohNXBDEF.BookNum);
  end;
end;

function TBok.LoadBoks(pPmdCod:Str3;pBokLst:Str200):boolean;  // Nacita zoznam knih zadaneho modulu, ktore su zadane v pBokLst do otBOKLST, ak pBokLst je prazdny nacita vsetky knihy
var mLinLst:TLinLst; mBokNum:Str3;
begin
  oPmdCod:=pPmdCod; oBoks:=pBokLst;
  If not otBOKLST.Active then otBOKLST.Open;
  ClrTmpTab(otBOKLST.TmpTable);
  If pBokLst='' then begin  // Nacitame vsetky knihy zadaneho typu
    If ohNXBDEF.LocatePmdMark(pPmdCod) then begin
      Repeat
        AddBok(ohNXBDEF.BookNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
        ohNXBDEF.Next;
      until ohNXBDEF.Eof or (ohNXBDEF.PmdMark<>pPmdCod);
    end;
  end
  else begin // Ponechame len tie knihy, ktore su zaevidovane
    mLinLst:=TLinLst.Create;
    mLinLst.AddLst(pBokLst);
    If mLinLst.Count>0 then begin
      mLinLst.First;
      Repeat
        If ohNXBDEF.LocatePmBn(pPmdCod,mLinLst.Itm) then AddBok(ohNXBDEF.BookNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
        mLinLst.Next;
      until mLinLst.Eof;
    end;
    FreeAndNil (mLinLst);
  end;
  If cNexStart and (otBOKLST.Count=0) and (pBokLst='' ) then begin
    ohNXBDEF.Insert;
    ohNXBDEF.PmdMark:=pPmdCod;
    ohNXBDEF.BookNum:='A-001';
    ohNXBDEF.BookName:=pPmdCod+' A-001 '+gvSys.ActYear;
    ohNXBDEF.BookType:='A';
    ohNXBDEF.Post;
    If not ohABKDEF.LocateGrPmBn(gvSys.LoginGroup,ohNXBDEF.PmdMark,ohNXBDEF.BookNum) then begin
      ohABKDEF.Insert;
      ohABKDEF.GrpNum :=gvSys.LoginGroup;
      ohABKDEF.PmdMark:=ohNXBDEF.PmdMark;
      ohABKDEF.BookNum:=ohNXBDEF.BookNum;
      ohABKDEF.Post;
    end;
    AddBok(ohNXBDEF.BookNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
  end;
  Result:=otBOKLST.Count>0;
end;

function TBok.ReloadBoks: boolean;
var mLinLst:TLinLst; mBokNum:Str3;
begin
  Result:=False;
  If otBOKLST.Active then otBOKLST.Close;
  otBOKLST.Open;
  If (oPmdCod='') then Exit;
  If oBoks='' then begin  // Nacitame vsetky knihy zadaneho typu
    If ohNXBDEF.LocatePmdMark(oPmdCod) then begin
      Repeat
        If oPmdCod='OCB' then begin
          If copy(ohNXBDEF.BookNum,1,1)='A' then begin
            mBokNum:=copy(ohNXBDEF.BookNum,3,3);
            AddBok(mBokNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
          end
        end else AddBok(ohNXBDEF.BookNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
        ohNXBDEF.Next;
      until ohNXBDEF.Eof or (ohNXBDEF.PmdMark<>oPmdCod);
    end;
  end
  else begin // Ponechame len tie knihy, ktore su zaevidovane
    mLinLst:=TLinLst.Create;
    mLinLst.AddLst(oBoks);
    If mLinLst.Count>0 then begin
      mLinLst.First;
      Repeat
        If ohNXBDEF.LocatePmBn(oPmdCod,mLinLst.Itm) then AddBok(ohNXBDEF.BookNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
        mLinLst.Next;
      until mLinLst.Eof;
    end;
    FreeAndNil (mLinLst);
  end;
  If cNexStart and (otBOKLST.Count=0) and (oBoks='') then begin
    ohNXBDEF.Insert;
    ohNXBDEF.PmdMark:=oPmdCod;
    ohNXBDEF.BookNum:='A-001';
    ohNXBDEF.BookName:=oPmdCod+' A-001 '+gvSys.ActYear;
    ohNXBDEF.BookType:='A';
    ohNXBDEF.Post;
    If not ohABKDEF.LocateGrPmBn(gvSys.LoginGroup,ohNXBDEF.PmdMark,ohNXBDEF.BookNum) then begin
      ohABKDEF.Insert;
      ohABKDEF.GrpNum :=gvSys.LoginGroup;
      ohABKDEF.PmdMark:=ohNXBDEF.PmdMark;
      ohABKDEF.BookNum:=ohNXBDEF.BookNum;
      ohABKDEF.Post;
    end;
    AddBok(ohNXBDEF.BookNum,ohNXBDEF.BookName,ohNXBDEF.BookType);
  end;
  Result:=otBOKLST.Count>0;
end;

function TBok.BokName(pPmdCod:Str3;pBokNum:Str5):Str30;
begin
  Result:='';
  If ohNXBDEF.LocatePmBn(pPmdCod,pBokNum) then Result:=ohNXBDEF.BookName;
end;

function TBok.BokType(pPmdCod:Str3;pBokNum:Str5):Str1;  // Udava rok zalozenia knihy
begin
  Result:='';
  If ohNXBDEF.LocatePmBn(pPmdCod,pBokNum) then Result:=ohNXBDEF.BookType;
end;

function TBok.BokActY(pPmdCod:Str3;pBokNum:Str5):boolean; // TRUE ak kniha je zalozena na aktualny rok
begin
  Result:=BokType(pPmdCod,pBokNum)='A';
end;

function TBok.BokFirst (pPmdCod:Str3):Str5; // Prva kniha ktora je dostupna pre zadaneho uzivatela
begin
  Result:='';
  If ohABKDEF.LocateGrPm(gvSys.LoginGroup,pPmdCod) then Result:=ohABKDEF.BookNum;
end;

function TBok.BokExist (pPmdCod:Str3):boolean; // TRUE ak pre zadaneho uzivatela a zadany modul je nadefinovana aspon jedna kniha
begin
  Result:=ohABKDEF.LocateGrPm(gvSys.LoginGroup,pPmdCod);
  If not Result then ShowMsg (ecSysAbkNotDefForActUsr,gvSys.UserName);
end;

function TBok.BokFirst (pGrpNum:word;pPmdCod:Str3):Str5; // Prva kniha ktora je dostupna pre zadaneho uzivatela
begin
  Result:='';
  If ohABKDEF.LocateGrPm(pGrpNum,pPmdCod) then Result:=ohABKDEF.BookNum;
end;

function TBok.BokExist (pGrpNum:word;pPmdCod:Str3):boolean; // TRUE ak pre zadaneho uzivatela a zadany modul je nadefinovana aspon jedna kniha
begin
  Result:=ohABKDEF.LocateGrPm(pGrpNum,pPmdCod);
  If not Result then ShowMsg (ecSysAbkNotDefForActUsr,gvSys.UserName);
end;

function TBok.BokExist (pPmdCod:Str3;pBokNum:Str5;pGlobLst:boolean):boolean; // TRUE ak existuje zadana kniha
begin
  If pGlobLst
    then Result:=ohNXBDEF.LocatePmBn(pPmdCod,pBokNum)  // Hlada vo vsetkych knihach
    else ; // Hlada v knihach uzivatela
end;

function TBok.BokAcces(pGrpNum:word;pPmdCod:Str3;pBokNum:Str5):boolean; // TRUE ak pre zadaneho uzivatela je dostupna zadana kniha
begin
  Result:=ohABKDEF.LocateGrPmBn(pGrpNum,pPmdCod,pBokNum);
end;

end.

