unit LoginUtils;

interface

  uses
    IcTools, IcConv,
    EncodeIni, Windows, SysUtils, Classes;

  const
    cOrgLstFile:string = 'orglst.ini';
    cWSSetFile:string = 'wsset.ini';
    cOrgLstEncode:boolean = FALSE;
    cActYearText:string = 'aktuálny';
    cGldService:boolean=FALSE;

  type
    TDataObj = class (TObject)
    private
      oData : string;
      oData2: string;
      oCheck: boolean;
    public
      constructor Create(AOwner: TComponent);
      destructor Destroy;
    published
      property Data:string read oData write oData;
      property Data2:string read oData2 write oData2;
      property Check:boolean read oCheck write oCheck;
    end;

    TOrgLst = class
    end;

  function GetNEXComputerName:string;
  function GetWinUserName:string;
  function GetNEXRunRoot:string;

implementation

// TDataObj
constructor TDataObj.Create(AOwner: TComponent);
begin
  oData := '';
end;

destructor TDataObj.Destroy;
begin
end;


function GetNEXComputerName:string;
var mSize:dword; mBuff: array[0..255] of char; mS:string;
begin
  Result := '';
  mSize := 256;
  mS := 'nopc';
  If GetComputerName(mBuff, mSize) then mS := mBuff;
  Result := ReplaceStr (ReplaceStr (mS, '~', '-'), '_', '-');

  mSize := 256;
  mS := 'noname';
  If GetUserName(mBuff, mSize) then mS := mBuff;
  Result := Result+'~'+ReplaceStr (ReplaceStr (mS, '~', '-'), '_', '-');
end;

function GetWinUserName:string;
var mSize:dword; mBuff: array[0..255] of char; mS:string;
begin
  mSize := 256;
  mS := 'noname';
  If GetUserName(mBuff, mSize) then mS := mBuff;
  Result := ReplaceStr (ReplaceStr (mS, '~', '-'), '_', '-');
end;

function GetNEXRunRoot:string;
var mPath, mS:string; mLst:TStringList;
begin
  Result := '';
  mPath := UpString(ExtractFilePath (ParamStr (0)));
  mLst := TStringList.Create;
  mLst.Text := ReplaceStr(mPath, '\', #13+#10);
  If mLst.Count>2 then begin
    If (mLst.Strings[mLst.Count-1]='SYSTEM') and (Pos ('YEAR', mLst.Strings[mLst.Count-2])=1) then begin
      mS := '\'+mLst.Strings[mLst.Count-2]+'\'+mLst.Strings[mLst.Count-1];
      Result := Copy (mPath, 1, Pos (mS, mPath));
    end;
  end;
  FreeAndNil (mLst);
end;

end.
