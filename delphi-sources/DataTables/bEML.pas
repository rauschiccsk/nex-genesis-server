unit bEML;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEmlNum = 'EmlNum';
  ixCntNum = 'CntNum';
  ixCntPac = 'CntPac';

type
  TEmlBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEmlNum:Str12;          procedure WriteEmlNum (pValue:Str12);
    function  ReadEmlDes:Str90;          procedure WriteEmlDes (pValue:Str90);
    function  ReadEmlDate:TDatetime;     procedure WriteEmlDate (pValue:TDatetime);
    function  ReadEmlTime:TDatetime;     procedure WriteEmlTime (pValue:TDatetime);
    function  ReadCntEml:Str30;          procedure WriteCntEml (pValue:Str30);
    function  ReadCntNum:longint;        procedure WriteCntNum (pValue:longint);
    function  ReadCntPac:longint;        procedure WriteCntPac (pValue:longint);
    function  ReadCntName:Str30;         procedure WriteCntName (pValue:Str30);
    function  ReadSndSta:Str1;           procedure WriteSndSta (pValue:Str1);
    function  ReadDspSta:Str1;           procedure WriteDspSta (pValue:Str1);
    function  ReadEmfNum:word;           procedure WriteEmfNum (pValue:word);
    function  ReadAtcQnt:byte;           procedure WriteAtcQnt (pValue:byte);
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
    function LocateCntNum (pCntNum:longint):boolean;
    function LocateCntPac (pCntPac:longint):boolean;
    function NearestEmlNum (pEmlNum:Str12):boolean;
    function NearestCntNum (pCntNum:longint):boolean;
    function NearestCntPac (pCntPac:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pCntNum:word);
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
    property EmlDate:TDatetime read ReadEmlDate write WriteEmlDate;
    property EmlTime:TDatetime read ReadEmlTime write WriteEmlTime;
    property CntEml:Str30 read ReadCntEml write WriteCntEml;
    property CntNum:longint read ReadCntNum write WriteCntNum;
    property CntPac:longint read ReadCntPac write WriteCntPac;
    property CntName:Str30 read ReadCntName write WriteCntName;
    property SndSta:Str1 read ReadSndSta write WriteSndSta;
    property DspSta:Str1 read ReadDspSta write WriteDspSta;
    property EmfNum:word read ReadEmfNum write WriteEmfNum;
    property AtcQnt:byte read ReadAtcQnt write WriteAtcQnt;
  end;

implementation

constructor TEmlBtr.Create;
begin
  oBtrTable := BtrInit ('EML',gPath.DlsPath,Self);
end;

constructor TEmlBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EML',pPath,Self);
end;

destructor TEmlBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEmlBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEmlBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEmlBtr.ReadEmlNum:Str12;
begin
  Result := oBtrTable.FieldByName('EmlNum').AsString;
end;

procedure TEmlBtr.WriteEmlNum(pValue:Str12);
begin
  oBtrTable.FieldByName('EmlNum').AsString := pValue;
end;

function TEmlBtr.ReadEmlDes:Str90;
begin
  Result := oBtrTable.FieldByName('EmlDes').AsString;
end;

procedure TEmlBtr.WriteEmlDes(pValue:Str90);
begin
  oBtrTable.FieldByName('EmlDes').AsString := pValue;
end;

function TEmlBtr.ReadEmlDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmlDate').AsDateTime;
end;

procedure TEmlBtr.WriteEmlDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmlDate').AsDateTime := pValue;
end;

function TEmlBtr.ReadEmlTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmlTime').AsDateTime;
end;

procedure TEmlBtr.WriteEmlTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmlTime').AsDateTime := pValue;
end;

function TEmlBtr.ReadCntEml:Str30;
begin
  Result := oBtrTable.FieldByName('CntEml').AsString;
end;

procedure TEmlBtr.WriteCntEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CntEml').AsString := pValue;
end;

function TEmlBtr.ReadCntNum:longint;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TEmlBtr.WriteCntNum(pValue:longint);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TEmlBtr.ReadCntPac:longint;
begin
  Result := oBtrTable.FieldByName('CntPac').AsInteger;
end;

procedure TEmlBtr.WriteCntPac(pValue:longint);
begin
  oBtrTable.FieldByName('CntPac').AsInteger := pValue;
end;

function TEmlBtr.ReadCntName:Str30;
begin
  Result := oBtrTable.FieldByName('CntName').AsString;
end;

procedure TEmlBtr.WriteCntName(pValue:Str30);
begin
  oBtrTable.FieldByName('CntName').AsString := pValue;
end;

function TEmlBtr.ReadSndSta:Str1;
begin
  Result := oBtrTable.FieldByName('SndSta').AsString;
end;

procedure TEmlBtr.WriteSndSta(pValue:Str1);
begin
  oBtrTable.FieldByName('SndSta').AsString := pValue;
end;

function TEmlBtr.ReadDspSta:Str1;
begin
  Result := oBtrTable.FieldByName('DspSta').AsString;
end;

procedure TEmlBtr.WriteDspSta(pValue:Str1);
begin
  oBtrTable.FieldByName('DspSta').AsString := pValue;
end;

function TEmlBtr.ReadEmfNum:word;
begin
  Result := oBtrTable.FieldByName('EmfNum').AsInteger;
end;

procedure TEmlBtr.WriteEmfNum(pValue:word);
begin
  oBtrTable.FieldByName('EmfNum').AsInteger := pValue;
end;

function TEmlBtr.ReadAtcQnt:byte;
begin
  Result := oBtrTable.FieldByName('AtcQnt').AsInteger;
end;

procedure TEmlBtr.WriteAtcQnt(pValue:byte);
begin
  oBtrTable.FieldByName('AtcQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmlBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmlBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEmlBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmlBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEmlBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEmlBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEmlBtr.LocateEmlNum (pEmlNum:Str12):boolean;
begin
  SetIndex (ixEmlNum);
  Result := oBtrTable.FindKey([pEmlNum]);
end;

function TEmlBtr.LocateCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TEmlBtr.LocateCntPac (pCntPac:longint):boolean;
begin
  SetIndex (ixCntPac);
  Result := oBtrTable.FindKey([pCntPac]);
end;

function TEmlBtr.NearestEmlNum (pEmlNum:Str12):boolean;
begin
  SetIndex (ixEmlNum);
  Result := oBtrTable.FindNearest([pEmlNum]);
end;

function TEmlBtr.NearestCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

function TEmlBtr.NearestCntPac (pCntPac:longint):boolean;
begin
  SetIndex (ixCntPac);
  Result := oBtrTable.FindNearest([pCntPac]);
end;

procedure TEmlBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEmlBtr.Open;
begin
  oBtrTable.Open(pCntNum);
end;

procedure TEmlBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEmlBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEmlBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEmlBtr.First;
begin
  oBtrTable.First;
end;

procedure TEmlBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEmlBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEmlBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEmlBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEmlBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEmlBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEmlBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEmlBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEmlBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEmlBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEmlBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
