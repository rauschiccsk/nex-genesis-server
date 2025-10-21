unit bWRILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWriNum = 'WriNum';
  ixWriName = 'WriName';

type
  TWrilstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadWriName:Str30;         procedure WriteWriName (pValue:Str30);
    function  ReadWriName_:Str30;        procedure WriteWriName_ (pValue:Str30);
    function  ReadWriAddr:Str30;         procedure WriteWriAddr (pValue:Str30);
    function  ReadWriSta:Str2;           procedure WriteWriSta (pValue:Str2);
    function  ReadWriCty:Str3;           procedure WriteWriCty (pValue:Str3);
    function  ReadWriZip:Str15;          procedure WriteWriZip (pValue:Str15);
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadRemote:Str1;           procedure WriteRemote (pValue:Str1);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateWriNum (pWriNum:word):boolean;
    function LocateWriName (pWriName_:Str30):boolean;
    function NearestWriNum (pWriNum:word):boolean;
    function NearestWriName (pWriName_:Str30):boolean;

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
    property WriNum:word read ReadWriNum write WriteWriNum;
    property WriName:Str30 read ReadWriName write WriteWriName;
    property WriName_:Str30 read ReadWriName_ write WriteWriName_;
    property WriAddr:Str30 read ReadWriAddr write WriteWriAddr;
    property WriSta:Str2 read ReadWriSta write WriteWriSta;
    property WriCty:Str3 read ReadWriCty write WriteWriCty;
    property WriZip:Str15 read ReadWriZip write WriteWriZip;
    property CntNum:word read ReadCntNum write WriteCntNum;
    property ModNum:word read ReadModNum write WriteModNum;
    property Remote:Str1 read ReadRemote write WriteRemote;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TWrilstBtr.Create;
begin
  oBtrTable := BtrInit ('WRILST',gPath.DlsPath,Self);
end;

constructor TWrilstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WRILST',pPath,Self);
end;

destructor TWrilstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWrilstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWrilstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWrilstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TWrilstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TWrilstBtr.ReadWriName:Str30;
begin
  Result := oBtrTable.FieldByName('WriName').AsString;
end;

procedure TWrilstBtr.WriteWriName(pValue:Str30);
begin
  oBtrTable.FieldByName('WriName').AsString := pValue;
end;

function TWrilstBtr.ReadWriName_:Str30;
begin
  Result := oBtrTable.FieldByName('WriName_').AsString;
end;

procedure TWrilstBtr.WriteWriName_(pValue:Str30);
begin
  oBtrTable.FieldByName('WriName_').AsString := pValue;
end;

function TWrilstBtr.ReadWriAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WriAddr').AsString;
end;

procedure TWrilstBtr.WriteWriAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WriAddr').AsString := pValue;
end;

function TWrilstBtr.ReadWriSta:Str2;
begin
  Result := oBtrTable.FieldByName('WriSta').AsString;
end;

procedure TWrilstBtr.WriteWriSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WriSta').AsString := pValue;
end;

function TWrilstBtr.ReadWriCty:Str3;
begin
  Result := oBtrTable.FieldByName('WriCty').AsString;
end;

procedure TWrilstBtr.WriteWriCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WriCty').AsString := pValue;
end;

function TWrilstBtr.ReadWriZip:Str15;
begin
  Result := oBtrTable.FieldByName('WriZip').AsString;
end;

procedure TWrilstBtr.WriteWriZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WriZip').AsString := pValue;
end;

function TWrilstBtr.ReadCntNum:word;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TWrilstBtr.WriteCntNum(pValue:word);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TWrilstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TWrilstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TWrilstBtr.ReadRemote:Str1;
begin
  Result := oBtrTable.FieldByName('Remote').AsString;
end;

procedure TWrilstBtr.WriteRemote(pValue:Str1);
begin
  oBtrTable.FieldByName('Remote').AsString := pValue;
end;

function TWrilstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWrilstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWrilstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWrilstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWrilstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWrilstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWrilstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWrilstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWrilstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWrilstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWrilstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWrilstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWrilstBtr.LocateWriNum (pWriNum:word):boolean;
begin
  SetIndex (ixWriNum);
  Result := oBtrTable.FindKey([pWriNum]);
end;

function TWrilstBtr.LocateWriName (pWriName_:Str30):boolean;
begin
  SetIndex (ixWriName);
  Result := oBtrTable.FindKey([StrToAlias(pWriName_)]);
end;

function TWrilstBtr.NearestWriNum (pWriNum:word):boolean;
begin
  SetIndex (ixWriNum);
  Result := oBtrTable.FindNearest([pWriNum]);
end;

function TWrilstBtr.NearestWriName (pWriName_:Str30):boolean;
begin
  SetIndex (ixWriName);
  Result := oBtrTable.FindNearest([pWriName_]);
end;

procedure TWrilstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWrilstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TWrilstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWrilstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWrilstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWrilstBtr.First;
begin
  oBtrTable.First;
end;

procedure TWrilstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWrilstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWrilstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWrilstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWrilstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWrilstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWrilstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWrilstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWrilstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWrilstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWrilstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1904017}
