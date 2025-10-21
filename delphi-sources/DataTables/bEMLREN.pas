unit bEMLREN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEmlNum = 'EmlNum';
  ixSndCnt = 'SndCnt';
  ixSndPac = 'SndPac';
  ixRcvCnt = 'RcvCnt';
  ixRcvPac = 'RcvPac';

type
  TEmlrenBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEmlNum:Str12;          procedure WriteEmlNum (pValue:Str12);
    function  ReadEmlDes:Str90;          procedure WriteEmlDes (pValue:Str90);
    function  ReadSndEml:Str30;          procedure WriteSndEml (pValue:Str30);
    function  ReadSndCnt:longint;        procedure WriteSndCnt (pValue:longint);
    function  ReadSndPac:longint;        procedure WriteSndPac (pValue:longint);
    function  ReadSndName:Str30;         procedure WriteSndName (pValue:Str30);
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadSndTime:TDatetime;     procedure WriteSndTime (pValue:TDatetime);
    function  ReadSndSta:Str1;           procedure WriteSndSta (pValue:Str1);
    function  ReadRcvEml:Str30;          procedure WriteRcvEml (pValue:Str30);
    function  ReadRcvCnt:longint;        procedure WriteRcvCnt (pValue:longint);
    function  ReadRcvPac:longint;        procedure WriteRcvPac (pValue:longint);
    function  ReadRcvName:Str30;         procedure WriteRcvName (pValue:Str30);
    function  ReadRcvDate:TDatetime;     procedure WriteRcvDate (pValue:TDatetime);
    function  ReadRcvTime:TDatetime;     procedure WriteRcvTime (pValue:TDatetime);
    function  ReadAtcQnt:byte;           procedure WriteAtcQnt (pValue:byte);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEmlNum (pEmlNum:Str12):boolean;
    function LocateSndCnt (pSndCnt:longint):boolean;
    function LocateSndPac (pSndPac:longint):boolean;
    function LocateRcvCnt (pRcvCnt:longint):boolean;
    function LocateRcvPac (pRcvPac:longint):boolean;
    function NearestEmlNum (pEmlNum:Str12):boolean;
    function NearestSndCnt (pSndCnt:longint):boolean;
    function NearestSndPac (pSndPac:longint):boolean;
    function NearestRcvCnt (pRcvCnt:longint):boolean;
    function NearestRcvPac (pRcvPac:longint):boolean;

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
    property EmlNum:Str12 read ReadEmlNum write WriteEmlNum;
    property EmlDes:Str90 read ReadEmlDes write WriteEmlDes;
    property SndEml:Str30 read ReadSndEml write WriteSndEml;
    property SndCnt:longint read ReadSndCnt write WriteSndCnt;
    property SndPac:longint read ReadSndPac write WriteSndPac;
    property SndName:Str30 read ReadSndName write WriteSndName;
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property SndTime:TDatetime read ReadSndTime write WriteSndTime;
    property SndSta:Str1 read ReadSndSta write WriteSndSta;
    property RcvEml:Str30 read ReadRcvEml write WriteRcvEml;
    property RcvCnt:longint read ReadRcvCnt write WriteRcvCnt;
    property RcvPac:longint read ReadRcvPac write WriteRcvPac;
    property RcvName:Str30 read ReadRcvName write WriteRcvName;
    property RcvDate:TDatetime read ReadRcvDate write WriteRcvDate;
    property RcvTime:TDatetime read ReadRcvTime write WriteRcvTime;
    property AtcQnt:byte read ReadAtcQnt write WriteAtcQnt;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
  end;

implementation

constructor TEmlrenBtr.Create;
begin
  oBtrTable := BtrInit ('EMLREN',gPath.SysPath,Self);
end;

constructor TEmlrenBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EMLREN',pPath,Self);
end;

destructor TEmlrenBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEmlrenBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEmlrenBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEmlrenBtr.ReadEmlNum:Str12;
begin
  Result := oBtrTable.FieldByName('EmlNum').AsString;
end;

procedure TEmlrenBtr.WriteEmlNum(pValue:Str12);
begin
  oBtrTable.FieldByName('EmlNum').AsString := pValue;
end;

function TEmlrenBtr.ReadEmlDes:Str90;
begin
  Result := oBtrTable.FieldByName('EmlDes').AsString;
end;

procedure TEmlrenBtr.WriteEmlDes(pValue:Str90);
begin
  oBtrTable.FieldByName('EmlDes').AsString := pValue;
end;

function TEmlrenBtr.ReadSndEml:Str30;
begin
  Result := oBtrTable.FieldByName('SndEml').AsString;
end;

procedure TEmlrenBtr.WriteSndEml(pValue:Str30);
begin
  oBtrTable.FieldByName('SndEml').AsString := pValue;
end;

function TEmlrenBtr.ReadSndCnt:longint;
begin
  Result := oBtrTable.FieldByName('SndCnt').AsInteger;
end;

procedure TEmlrenBtr.WriteSndCnt(pValue:longint);
begin
  oBtrTable.FieldByName('SndCnt').AsInteger := pValue;
end;

function TEmlrenBtr.ReadSndPac:longint;
begin
  Result := oBtrTable.FieldByName('SndPac').AsInteger;
end;

procedure TEmlrenBtr.WriteSndPac(pValue:longint);
begin
  oBtrTable.FieldByName('SndPac').AsInteger := pValue;
end;

function TEmlrenBtr.ReadSndName:Str30;
begin
  Result := oBtrTable.FieldByName('SndName').AsString;
end;

procedure TEmlrenBtr.WriteSndName(pValue:Str30);
begin
  oBtrTable.FieldByName('SndName').AsString := pValue;
end;

function TEmlrenBtr.ReadSndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndDate').AsDateTime;
end;

procedure TEmlrenBtr.WriteSndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TEmlrenBtr.ReadSndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndTime').AsDateTime;
end;

procedure TEmlrenBtr.WriteSndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndTime').AsDateTime := pValue;
end;

function TEmlrenBtr.ReadSndSta:Str1;
begin
  Result := oBtrTable.FieldByName('SndSta').AsString;
end;

procedure TEmlrenBtr.WriteSndSta(pValue:Str1);
begin
  oBtrTable.FieldByName('SndSta').AsString := pValue;
end;

function TEmlrenBtr.ReadRcvEml:Str30;
begin
  Result := oBtrTable.FieldByName('RcvEml').AsString;
end;

procedure TEmlrenBtr.WriteRcvEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RcvEml').AsString := pValue;
end;

function TEmlrenBtr.ReadRcvCnt:longint;
begin
  Result := oBtrTable.FieldByName('RcvCnt').AsInteger;
end;

procedure TEmlrenBtr.WriteRcvCnt(pValue:longint);
begin
  oBtrTable.FieldByName('RcvCnt').AsInteger := pValue;
end;

function TEmlrenBtr.ReadRcvPac:longint;
begin
  Result := oBtrTable.FieldByName('RcvPac').AsInteger;
end;

procedure TEmlrenBtr.WriteRcvPac(pValue:longint);
begin
  oBtrTable.FieldByName('RcvPac').AsInteger := pValue;
end;

function TEmlrenBtr.ReadRcvName:Str30;
begin
  Result := oBtrTable.FieldByName('RcvName').AsString;
end;

procedure TEmlrenBtr.WriteRcvName(pValue:Str30);
begin
  oBtrTable.FieldByName('RcvName').AsString := pValue;
end;

function TEmlrenBtr.ReadRcvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RcvDate').AsDateTime;
end;

procedure TEmlrenBtr.WriteRcvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RcvDate').AsDateTime := pValue;
end;

function TEmlrenBtr.ReadRcvTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('RcvTime').AsDateTime;
end;

procedure TEmlrenBtr.WriteRcvTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RcvTime').AsDateTime := pValue;
end;

function TEmlrenBtr.ReadAtcQnt:byte;
begin
  Result := oBtrTable.FieldByName('AtcQnt').AsInteger;
end;

procedure TEmlrenBtr.WriteAtcQnt(pValue:byte);
begin
  oBtrTable.FieldByName('AtcQnt').AsInteger := pValue;
end;

function TEmlrenBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TEmlrenBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmlrenBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmlrenBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEmlrenBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmlrenBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEmlrenBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEmlrenBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEmlrenBtr.LocateEmlNum (pEmlNum:Str12):boolean;
begin
  SetIndex (ixEmlNum);
  Result := oBtrTable.FindKey([pEmlNum]);
end;

function TEmlrenBtr.LocateSndCnt (pSndCnt:longint):boolean;
begin
  SetIndex (ixSndCnt);
  Result := oBtrTable.FindKey([pSndCnt]);
end;

function TEmlrenBtr.LocateSndPac (pSndPac:longint):boolean;
begin
  SetIndex (ixSndPac);
  Result := oBtrTable.FindKey([pSndPac]);
end;

function TEmlrenBtr.LocateRcvCnt (pRcvCnt:longint):boolean;
begin
  SetIndex (ixRcvCnt);
  Result := oBtrTable.FindKey([pRcvCnt]);
end;

function TEmlrenBtr.LocateRcvPac (pRcvPac:longint):boolean;
begin
  SetIndex (ixRcvPac);
  Result := oBtrTable.FindKey([pRcvPac]);
end;

function TEmlrenBtr.NearestEmlNum (pEmlNum:Str12):boolean;
begin
  SetIndex (ixEmlNum);
  Result := oBtrTable.FindNearest([pEmlNum]);
end;

function TEmlrenBtr.NearestSndCnt (pSndCnt:longint):boolean;
begin
  SetIndex (ixSndCnt);
  Result := oBtrTable.FindNearest([pSndCnt]);
end;

function TEmlrenBtr.NearestSndPac (pSndPac:longint):boolean;
begin
  SetIndex (ixSndPac);
  Result := oBtrTable.FindNearest([pSndPac]);
end;

function TEmlrenBtr.NearestRcvCnt (pRcvCnt:longint):boolean;
begin
  SetIndex (ixRcvCnt);
  Result := oBtrTable.FindNearest([pRcvCnt]);
end;

function TEmlrenBtr.NearestRcvPac (pRcvPac:longint):boolean;
begin
  SetIndex (ixRcvPac);
  Result := oBtrTable.FindNearest([pRcvPac]);
end;

procedure TEmlrenBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEmlrenBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TEmlrenBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEmlrenBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEmlrenBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEmlrenBtr.First;
begin
  oBtrTable.First;
end;

procedure TEmlrenBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEmlrenBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEmlrenBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEmlrenBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEmlrenBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEmlrenBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEmlrenBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEmlrenBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEmlrenBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEmlrenBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEmlrenBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
