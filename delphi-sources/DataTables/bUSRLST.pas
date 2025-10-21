unit bUSRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLoginName = 'LoginName';
  ixLnLo = 'LnLo';
  ixSmaIdc = 'SmaIdc';

type
  TUsrlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLoginName:Str8;        procedure WriteLoginName (pValue:Str8);
    function  ReadLoginOwnr:Str20;       procedure WriteLoginOwnr (pValue:Str20);
    function  ReadUserName:Str30;        procedure WriteUserName (pValue:Str30);
    function  ReadLanguage:Str2;         procedure WriteLanguage (pValue:Str2);
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadDefSet1:word;          procedure WriteDefSet1 (pValue:word);
    function  ReadDefSet2:word;          procedure WriteDefSet2 (pValue:word);
    function  ReadDefSet3:word;          procedure WriteDefSet3 (pValue:word);
    function  ReadDefSet4:byte;          procedure WriteDefSet4 (pValue:byte);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadMaxDsc:byte;           procedure WriteMaxDsc (pValue:byte);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSmaIdc:Str10;          procedure WriteSmaIdc (pValue:Str10);
    function  ReadUsrNum:word;           procedure WriteUsrNum (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateLoginName (pLoginName:Str8):boolean;
    function LocateLnLo (pLoginName:Str8;pLoginOwnr:Str20):boolean;
    function LocateSmaIdc (pSmaIdc:Str10):boolean;
    function NearestLoginName (pLoginName:Str8):boolean;
    function NearestLnLo (pLoginName:Str8;pLoginOwnr:Str20):boolean;
    function NearestSmaIdc (pSmaIdc:Str10):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property LoginName:Str8 read ReadLoginName write WriteLoginName;
    property LoginOwnr:Str20 read ReadLoginOwnr write WriteLoginOwnr;
    property UserName:Str30 read ReadUserName write WriteUserName;
    property Language:Str2 read ReadLanguage write WriteLanguage;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property DefSet1:word read ReadDefSet1 write WriteDefSet1;
    property DefSet2:word read ReadDefSet2 write WriteDefSet2;
    property DefSet3:word read ReadDefSet3 write WriteDefSet3;
    property DefSet4:byte read ReadDefSet4 write WriteDefSet4;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property MaxDsc:byte read ReadMaxDsc write WriteMaxDsc;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SmaIdc:Str10 read ReadSmaIdc write WriteSmaIdc;
    property UsrNum:word read ReadUsrNum write WriteUsrNum;
  end;

implementation

constructor TUsrlstBtr.Create;
begin
  oBtrTable := BtrInit ('USRLST',gPath.SysPath,Self);
end;

constructor TUsrlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('USRLST',pPath,Self);
end;

destructor TUsrlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TUsrlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TUsrlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TUsrlstBtr.ReadLoginName:Str8;
begin
  Result := oBtrTable.FieldByName('LoginName').AsString;
end;

procedure TUsrlstBtr.WriteLoginName(pValue:Str8);
begin
  oBtrTable.FieldByName('LoginName').AsString := pValue;
end;

function TUsrlstBtr.ReadLoginOwnr:Str20;
begin
  Result := oBtrTable.FieldByName('LoginOwnr').AsString;
end;

procedure TUsrlstBtr.WriteLoginOwnr(pValue:Str20);
begin
  oBtrTable.FieldByName('LoginOwnr').AsString := pValue;
end;

function TUsrlstBtr.ReadUserName:Str30;
begin
  Result := oBtrTable.FieldByName('UserName').AsString;
end;

procedure TUsrlstBtr.WriteUserName(pValue:Str30);
begin
  oBtrTable.FieldByName('UserName').AsString := pValue;
end;

function TUsrlstBtr.ReadLanguage:Str2;
begin
  Result := oBtrTable.FieldByName('Language').AsString;
end;

procedure TUsrlstBtr.WriteLanguage(pValue:Str2);
begin
  oBtrTable.FieldByName('Language').AsString := pValue;
end;

function TUsrlstBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TUsrlstBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TUsrlstBtr.ReadDefSet1:word;
begin
  Result := oBtrTable.FieldByName('DefSet1').AsInteger;
end;

procedure TUsrlstBtr.WriteDefSet1(pValue:word);
begin
  oBtrTable.FieldByName('DefSet1').AsInteger := pValue;
end;

function TUsrlstBtr.ReadDefSet2:word;
begin
  Result := oBtrTable.FieldByName('DefSet2').AsInteger;
end;

procedure TUsrlstBtr.WriteDefSet2(pValue:word);
begin
  oBtrTable.FieldByName('DefSet2').AsInteger := pValue;
end;

function TUsrlstBtr.ReadDefSet3:word;
begin
  Result := oBtrTable.FieldByName('DefSet3').AsInteger;
end;

procedure TUsrlstBtr.WriteDefSet3(pValue:word);
begin
  oBtrTable.FieldByName('DefSet3').AsInteger := pValue;
end;

function TUsrlstBtr.ReadDefSet4:byte;
begin
  Result := oBtrTable.FieldByName('DefSet4').AsInteger;
end;

procedure TUsrlstBtr.WriteDefSet4(pValue:byte);
begin
  oBtrTable.FieldByName('DefSet4').AsInteger := pValue;
end;

function TUsrlstBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TUsrlstBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TUsrlstBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TUsrlstBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TUsrlstBtr.ReadMaxDsc:byte;
begin
  Result := oBtrTable.FieldByName('MaxDsc').AsInteger;
end;

procedure TUsrlstBtr.WriteMaxDsc(pValue:byte);
begin
  oBtrTable.FieldByName('MaxDsc').AsInteger := pValue;
end;

function TUsrlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TUsrlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TUsrlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TUsrlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TUsrlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TUsrlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TUsrlstBtr.ReadSmaIdc:Str10;
begin
  Result := oBtrTable.FieldByName('SmaIdc').AsString;
end;

procedure TUsrlstBtr.WriteSmaIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('SmaIdc').AsString := pValue;
end;

function TUsrlstBtr.ReadUsrNum:word;
begin
  Result := oBtrTable.FieldByName('UsrNum').AsInteger;
end;

procedure TUsrlstBtr.WriteUsrNum(pValue:word);
begin
  oBtrTable.FieldByName('UsrNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUsrlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUsrlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TUsrlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUsrlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TUsrlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TUsrlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TUsrlstBtr.LocateLoginName (pLoginName:Str8):boolean;
begin
  SetIndex (ixLoginName);
  Result := oBtrTable.FindKey([pLoginName]);
end;

function TUsrlstBtr.LocateLnLo (pLoginName:Str8;pLoginOwnr:Str20):boolean;
begin
  SetIndex (ixLnLo);
  Result := oBtrTable.FindKey([pLoginName,pLoginOwnr]);
end;

function TUsrlstBtr.LocateSmaIdc (pSmaIdc:Str10):boolean;
begin
  SetIndex (ixSmaIdc);
  Result := oBtrTable.FindKey([pSmaIdc]);
end;

function TUsrlstBtr.NearestLoginName (pLoginName:Str8):boolean;
begin
  SetIndex (ixLoginName);
  Result := oBtrTable.FindNearest([pLoginName]);
end;

function TUsrlstBtr.NearestLnLo (pLoginName:Str8;pLoginOwnr:Str20):boolean;
begin
  SetIndex (ixLnLo);
  Result := oBtrTable.FindNearest([pLoginName,pLoginOwnr]);
end;

function TUsrlstBtr.NearestSmaIdc (pSmaIdc:Str10):boolean;
begin
  SetIndex (ixSmaIdc);
  Result := oBtrTable.FindNearest([pSmaIdc]);
end;

procedure TUsrlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TUsrlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TUsrlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TUsrlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TUsrlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TUsrlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TUsrlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TUsrlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TUsrlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TUsrlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TUsrlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TUsrlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TUsrlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TUsrlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TUsrlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TUsrlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TUsrlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
