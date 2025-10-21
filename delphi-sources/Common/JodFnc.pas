unit JodFnc;
{$F+}

// *****************************************************************************
//                     ZBIERKA FUNKCII S PRACOVN�MI �KOLMI
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktor� umo�nia pr�stup k pracovn�m funkciam z
// in�ch programov�ch modulov.
//
// Programov� funkcia:
// ---------------
// Add - zalo�� pre zadaneho pracovnikanovy pracovny ukol
// *****************************************************************************


interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, Bok, Key,
  hJOB, hABKDEF,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TJodFnc = class
    constructor Create;
    destructor  Destroy; override;
    private
      function DetBokNum (pLogName:Str8):Str5;
    public
      procedure Add (pTrgUsl,pRegUsl:Str8;pDocDesc:Str80);
    published
  end;

implementation

constructor TJodFnc.Create;
begin
end;

destructor TJodFnc.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

function TJodFnc.DetBokNum (pLogName:Str8):Str5;
var mhABKDEF:TAbkdefHnd;
begin
  Result := '';
  mhABKDEF := TAbkdefHnd.Create;   mhABKDEF.Open;
  If mhABKDEF. LocateLnPm(gvSys.LoginName,'JOB') then begin
    Repeat
      If gKey.JobOwnUsl[mhABKDEF.BookNum]=pLogName then Result := mhABKDEF.BookNum;
      Application.ProcessMessages;
      mhABKDEF.Next;
    until mhABKDEF.Eof or (mhABKDEF.LogName<>gvSys.LoginName) or (mhABKDEF.PmdMark<>'JOB');
  end;
  FreeAndNil (mhABKDEF);
end;

// ********************************** PUBLIC ***********************************

procedure TJodFnc.Add (pTrgUsl,pRegUsl:Str8;pDocDesc:Str80);
var mBokNum:Str5;  mhJOB:TJobHnd;  mSerNum:longint;
begin
  mBokNum := DetBokNum (pTrgUsl);
  If mBokNum<>'' then begin // Nasli sme knihy pracovnych ukolov uzivatela komu chcema zalozit novy ukol
    mhJOB := TJobHnd.Create; mhJOB.Open(mBokNum);
    mSerNum := mhJOB.NextSerNum;
    mhJOB.Insert;
    mhJOB.SerNum := mSerNum;
    mhJOB.DocNum := mhJOB.GenDocNum(mBokNum,mSerNum);
    mhJOB.RegDate := Date;
    mhJOB.RegTime := Time;
    mhJOB.DocDesc := pDocDesc;
    mhJOB.RegUsl := pRegUsl;
    mhJOB.Post;
    FreeAndNil (mhJOB);
  end;
end;

end.
