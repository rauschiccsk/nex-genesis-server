unit pBOKLST;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, hABKDEF, hNXBDEF, hUsrLst,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable, Forms;

const
  ixBookNum='';
  ixBokName_='BokName_';

type
  TBoklstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    oPmdMark : Str3;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadBokNum:Str5;          procedure WriteBokNum (pValue:Str5);
    function  ReadBokName:Str30;        procedure WriteBokName (pValue:Str30);
    function  ReadBokName_:Str30;        procedure WriteBokName_ (pValue:Str30);
    function  ReadBokType:Str1;          procedure WriteBokType (pValue:Str1);
  public
    function  BokActYear:boolean;
    procedure LoadToTmp (pPmdMark:Str3); overload;
    procedure LoadToTmp (pLogName:Str8;pPmdMark:Str3); overload;
    procedure LoadToTmpPath(pPath:Str80;pPmdMark:Str3); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBookNum (pBookNum:Str5):boolean;
    function LocateBokName_ (pBokName_:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property BokNum:Str5 read ReadBokNum write WriteBokNum;
    property BokName:Str30 read ReadBokName write WriteBokName;
    property BokName_:Str30 read ReadBokName_ write WriteBokName_;
    property BokType:Str1 read ReadBokType write WriteBokType;
    property PmdMark:Str3 read oPmdMark;
  end;

implementation

uses bNXBDEF;

constructor TBoklstTmp.Create;
begin
  oTmpTable:=TmpInit('BOKLST',Self);
end;

destructor  TBoklstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBoklstTmp.ReadCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TBoklstTmp.ReadBokNum:Str5;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TBoklstTmp.WriteBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBoklstTmp.ReadBokName:Str30;
begin
  Result:=oTmpTable.FieldByName('BokName').AsString;
end;

procedure TBoklstTmp.WriteBokName(pValue:Str30);
begin
  oTmpTable.FieldByName('BokName').AsString:=pValue;
end;

function TBoklstTmp.ReadBokName_:Str30;
begin
  Result:=oTmpTable.FieldByName('BokName_').AsString;
end;

procedure TBoklstTmp.WriteBokName_(pValue:Str30);
begin
  oTmpTable.FieldByName('BokName_').AsString:=pValue;
end;

function TBoklstTmp.ReadBokType:Str1;
begin
  Result:=oTmpTable.FieldByName('BokType').AsString;
end;

procedure TBoklstTmp.WriteBokType(pValue:Str1);
begin
  oTmpTable.FieldByName('BokType').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBoklstTmp.Eof: boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TBoklstTmp.Active: boolean;
begin
  Result:=oTmpTable.Active;
end;

function TBoklstTmp.LocateBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result:=oTmpTable.FindKey([pBookNum]);
end;

function TBoklstTmp.LocateBokName_ (pBokName_:Str30):boolean;
begin
  SetIndex (ixBokName_);
  Result:=oTmpTable.FindKey([pBokName_]);
end;

procedure TBoklstTmp.LoadToTmp (pPmdMark:Str3);
var mhNXBDEF:TNxbdefHnd;
begin
  oPmdMark:=pPmdMark;
  If not oTmpTable.Active then oTmpTable.Open;
  oTmpTable.DelRecs;
  mhNXBDEF:=TNxbdefHnd.Create;  mhNXBDEF.Open;
  If mhNXBDEF.LocatePmdMark (pPmdMark) then begin
    Repeat
      If not oTmpTable.FindKey([mhNXBDEF.BookNum]) then begin
      oTmpTable.Insert;
      BokNum:=mhNXBDEF.BookNum;
      BokName:=mhNXBDEF.BookName;
      BokType:=mhNXBDEF.BookType;
      oTmpTable.Post;
      end
      else beep;
      Application.ProcessMessages;
      mhNXBDEF.Next;
    until mhNXBDEF.Eof or (mhNXBDEF.PmdMark<>pPmdMark);
  end;
  FreeAndNil (mhNXBDEF);
  oTmpTable.First;
end;

procedure TBoklstTmp.LoadToTmp (pLogName:Str8;pPmdMark:Str3);
var mhABKDEF:TAbkdefHnd;  mhNXBDEF:TNxbdefHnd;  mhUsrLst:TUsrlstHnd;
begin
  oPmdMark:=pPmdMark;
  oTmpTable.DelRecs;
  mhNXBDEF:=TNxbdefHnd.Create;  mhNXBDEF.Open;
  mhABKDEF:=TAbkdefHnd.Create;  mhABKDEF.Open;
  mhUsrLst:=TUsrlstHnd.Create;  mhUsrLst.Open;
  If mhUsrLst.LocateLoginName(pLogName) and mhABKDEF.LocateGrPm (mhUsrLst.GrpNum,pPmdMark) then begin
    Repeat
      If not oTmpTable.FindKey([mhNXBDEF.BookNum]) then begin
      oTmpTable.Insert;
      BokNum:=mhABKDEF.BookNum;
      BokName:=mhNXBDEF.GetBookName(pPmdMark,mhABKDEF.BookNum);
      BokType:=mhNXBDEF.BookType;
      oTmpTable.Post;
      end
      else beep;
      Application.ProcessMessages;
      mhABKDEF.Next;
    until mhABKDEF.Eof or (mhABKDEF.GrpNum<>mhUsrLst.GrpNum) or (mhABKDEF.PmdMark<>pPmdMark);
  end;
  FreeAndNil (mhUsrLst);
  FreeAndNil (mhABKDEF);
  FreeAndNil (mhNXBDEF);
end;

procedure TBoklstTmp.LoadToTmpPath (pPath:Str80;pPmdMark:Str3);
var mhNXBDEF:TNxbdefHnd;
begin
  oPmdMark:=pPmdMark;
  oTmpTable.DelRecs;
  mhNXBDEF:=TNxbdefHnd.Create(pPath);  mhNXBDEF.Open;
  If mhNXBDEF.LocatePmdMark (pPmdMark) then begin
    Repeat
      If not oTmpTable.FindKey([mhNXBDEF.BookNum]) then begin
      oTmpTable.Insert;
      BokNum:=mhNXBDEF.BookNum;
      BokName:=mhNXBDEF.BookName;
      BokType:=mhNXBDEF.BookType;
      oTmpTable.Post;
      end
      else beep;
      Application.ProcessMessages;
      mhNXBDEF.Next;
    until mhNXBDEF.Eof or (mhNXBDEF.PmdMark<>pPmdMark);
  end;
  FreeAndNil (mhNXBDEF);
  oTmpTable.First;
end;

procedure TBoklstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TBoklstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBoklstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBoklstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBoklstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBoklstTmp.First;
begin
  oTmpTable.First;
end;

procedure TBoklstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBoklstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBoklstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBoklstTmp.Post;
begin
  oTmpTable.Post;
end;

procedure TBoklstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBoklstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBoklstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBoklstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBoklstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

function TBoklstTmp.BokActYear: boolean;
begin
  Result:=Copy(BokNum,1,1)='A';
end;

end.
