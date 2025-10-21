unit tEMLREG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEmlNum = '';
  ixSndCnt = 'SndCnt';
  ixSndPac = 'SndPac';
  ixRcvCnt = 'RcvCnt';
  ixRcvPac = 'RcvPac';

type
  TEmlregTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateEmlNum (pEmlNum:Str12):boolean;
    function LocateSndCnt (pSndCnt:longint):boolean;
    function LocateSndPac (pSndPac:longint):boolean;
    function LocateRcvCnt (pRcvCnt:longint):boolean;
    function LocateRcvPac (pRcvPac:longint):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
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

constructor TEmlregTmp.Create;
begin
  oTmpTable := TmpInit ('EMLREG',Self);
end;

destructor TEmlregTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEmlregTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TEmlregTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TEmlregTmp.ReadEmlNum:Str12;
begin
  Result := oTmpTable.FieldByName('EmlNum').AsString;
end;

procedure TEmlregTmp.WriteEmlNum(pValue:Str12);
begin
  oTmpTable.FieldByName('EmlNum').AsString := pValue;
end;

function TEmlregTmp.ReadEmlDes:Str90;
begin
  Result := oTmpTable.FieldByName('EmlDes').AsString;
end;

procedure TEmlregTmp.WriteEmlDes(pValue:Str90);
begin
  oTmpTable.FieldByName('EmlDes').AsString := pValue;
end;

function TEmlregTmp.ReadSndEml:Str30;
begin
  Result := oTmpTable.FieldByName('SndEml').AsString;
end;

procedure TEmlregTmp.WriteSndEml(pValue:Str30);
begin
  oTmpTable.FieldByName('SndEml').AsString := pValue;
end;

function TEmlregTmp.ReadSndCnt:longint;
begin
  Result := oTmpTable.FieldByName('SndCnt').AsInteger;
end;

procedure TEmlregTmp.WriteSndCnt(pValue:longint);
begin
  oTmpTable.FieldByName('SndCnt').AsInteger := pValue;
end;

function TEmlregTmp.ReadSndPac:longint;
begin
  Result := oTmpTable.FieldByName('SndPac').AsInteger;
end;

procedure TEmlregTmp.WriteSndPac(pValue:longint);
begin
  oTmpTable.FieldByName('SndPac').AsInteger := pValue;
end;

function TEmlregTmp.ReadSndName:Str30;
begin
  Result := oTmpTable.FieldByName('SndName').AsString;
end;

procedure TEmlregTmp.WriteSndName(pValue:Str30);
begin
  oTmpTable.FieldByName('SndName').AsString := pValue;
end;

function TEmlregTmp.ReadSndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SndDate').AsDateTime;
end;

procedure TEmlregTmp.WriteSndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TEmlregTmp.ReadSndTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('SndTime').AsDateTime;
end;

procedure TEmlregTmp.WriteSndTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndTime').AsDateTime := pValue;
end;

function TEmlregTmp.ReadSndSta:Str1;
begin
  Result := oTmpTable.FieldByName('SndSta').AsString;
end;

procedure TEmlregTmp.WriteSndSta(pValue:Str1);
begin
  oTmpTable.FieldByName('SndSta').AsString := pValue;
end;

function TEmlregTmp.ReadRcvEml:Str30;
begin
  Result := oTmpTable.FieldByName('RcvEml').AsString;
end;

procedure TEmlregTmp.WriteRcvEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RcvEml').AsString := pValue;
end;

function TEmlregTmp.ReadRcvCnt:longint;
begin
  Result := oTmpTable.FieldByName('RcvCnt').AsInteger;
end;

procedure TEmlregTmp.WriteRcvCnt(pValue:longint);
begin
  oTmpTable.FieldByName('RcvCnt').AsInteger := pValue;
end;

function TEmlregTmp.ReadRcvPac:longint;
begin
  Result := oTmpTable.FieldByName('RcvPac').AsInteger;
end;

procedure TEmlregTmp.WriteRcvPac(pValue:longint);
begin
  oTmpTable.FieldByName('RcvPac').AsInteger := pValue;
end;

function TEmlregTmp.ReadRcvName:Str30;
begin
  Result := oTmpTable.FieldByName('RcvName').AsString;
end;

procedure TEmlregTmp.WriteRcvName(pValue:Str30);
begin
  oTmpTable.FieldByName('RcvName').AsString := pValue;
end;

function TEmlregTmp.ReadRcvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RcvDate').AsDateTime;
end;

procedure TEmlregTmp.WriteRcvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RcvDate').AsDateTime := pValue;
end;

function TEmlregTmp.ReadRcvTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('RcvTime').AsDateTime;
end;

procedure TEmlregTmp.WriteRcvTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RcvTime').AsDateTime := pValue;
end;

function TEmlregTmp.ReadAtcQnt:byte;
begin
  Result := oTmpTable.FieldByName('AtcQnt').AsInteger;
end;

procedure TEmlregTmp.WriteAtcQnt(pValue:byte);
begin
  oTmpTable.FieldByName('AtcQnt').AsInteger := pValue;
end;

function TEmlregTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TEmlregTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmlregTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TEmlregTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TEmlregTmp.LocateEmlNum (pEmlNum:Str12):boolean;
begin
  SetIndex (ixEmlNum);
  Result := oTmpTable.FindKey([pEmlNum]);
end;

function TEmlregTmp.LocateSndCnt (pSndCnt:longint):boolean;
begin
  SetIndex (ixSndCnt);
  Result := oTmpTable.FindKey([pSndCnt]);
end;

function TEmlregTmp.LocateSndPac (pSndPac:longint):boolean;
begin
  SetIndex (ixSndPac);
  Result := oTmpTable.FindKey([pSndPac]);
end;

function TEmlregTmp.LocateRcvCnt (pRcvCnt:longint):boolean;
begin
  SetIndex (ixRcvCnt);
  Result := oTmpTable.FindKey([pRcvCnt]);
end;

function TEmlregTmp.LocateRcvPac (pRcvPac:longint):boolean;
begin
  SetIndex (ixRcvPac);
  Result := oTmpTable.FindKey([pRcvPac]);
end;

procedure TEmlregTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TEmlregTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEmlregTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEmlregTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEmlregTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEmlregTmp.First;
begin
  oTmpTable.First;
end;

procedure TEmlregTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEmlregTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEmlregTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEmlregTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEmlregTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEmlregTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEmlregTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEmlregTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEmlregTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEmlregTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TEmlregTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
