unit bTOP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixPosOut = 'PosOut';
  ixPosRet = 'PosRet';
  ixDoPoGs = 'DoPoGs';
  ixDoPrGs = 'DoPrGs';

type
  TTopBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadRetQnt:double;         procedure WriteRetQnt (pValue:double);
    function  ReadReoNum:byte;           procedure WriteReoNum (pValue:byte);
    function  ReadRerNum:byte;           procedure WriteRerNum (pValue:byte);
    function  ReadPosOut:Str15;          procedure WritePosOut (pValue:Str15);
    function  ReadPosRet:Str15;          procedure WritePosRet (pValue:Str15);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePosOut (pPosOut:Str15):boolean;
    function LocatePosRet (pPosRet:Str15):boolean;
    function LocateDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
    function LocateDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPosOut (pPosOut:Str15):boolean;
    function NearestPosRet (pPosRet:Str15):boolean;
    function NearestDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
    function NearestDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property RetQnt:double read ReadRetQnt write WriteRetQnt;
    property ReoNum:byte read ReadReoNum write WriteReoNum;
    property RerNum:byte read ReadRerNum write WriteRerNum;
    property PosOut:Str15 read ReadPosOut write WritePosOut;
    property PosRet:Str15 read ReadPosRet write WritePosRet;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TTopBtr.Create;
begin
  oBtrTable := BtrInit ('TOP',gPath.StkPath,Self);
end;

constructor TTopBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TOP',pPath,Self);
end;

destructor TTopBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTopBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTopBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTopBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTopBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTopBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTopBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTopBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTopBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTopBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTopBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTopBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTopBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTopBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TTopBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TTopBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TTopBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TTopBtr.ReadRetQnt:double;
begin
  Result := oBtrTable.FieldByName('RetQnt').AsFloat;
end;

procedure TTopBtr.WriteRetQnt(pValue:double);
begin
  oBtrTable.FieldByName('RetQnt').AsFloat := pValue;
end;

function TTopBtr.ReadReoNum:byte;
begin
  Result := oBtrTable.FieldByName('ReoNum').AsInteger;
end;

procedure TTopBtr.WriteReoNum(pValue:byte);
begin
  oBtrTable.FieldByName('ReoNum').AsInteger := pValue;
end;

function TTopBtr.ReadRerNum:byte;
begin
  Result := oBtrTable.FieldByName('RerNum').AsInteger;
end;

procedure TTopBtr.WriteRerNum(pValue:byte);
begin
  oBtrTable.FieldByName('RerNum').AsInteger := pValue;
end;

function TTopBtr.ReadPosOut:Str15;
begin
  Result := oBtrTable.FieldByName('PosOut').AsString;
end;

procedure TTopBtr.WritePosOut(pValue:Str15);
begin
  oBtrTable.FieldByName('PosOut').AsString := pValue;
end;

function TTopBtr.ReadPosRet:Str15;
begin
  Result := oBtrTable.FieldByName('PosRet').AsString;
end;

procedure TTopBtr.WritePosRet(pValue:Str15);
begin
  oBtrTable.FieldByName('PosRet').AsString := pValue;
end;

function TTopBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTopBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTopBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTopBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTopBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTopBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTopBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTopBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTopBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTopBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTopBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTopBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTopBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTopBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTopBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTopBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTopBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTopBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTopBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTopBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTopBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTopBtr.LocatePosOut (pPosOut:Str15):boolean;
begin
  SetIndex (ixPosOut);
  Result := oBtrTable.FindKey([pPosOut]);
end;

function TTopBtr.LocatePosRet (pPosRet:Str15):boolean;
begin
  SetIndex (ixPosRet);
  Result := oBtrTable.FindKey([pPosRet]);
end;

function TTopBtr.LocateDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPoGs);
  Result := oBtrTable.FindKey([pDocNum,pPosOut,pGsCode]);
end;

function TTopBtr.LocateDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPrGs);
  Result := oBtrTable.FindKey([pDocNum,pPosRet,pGsCode]);
end;

function TTopBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TTopBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTopBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TTopBtr.NearestPosOut (pPosOut:Str15):boolean;
begin
  SetIndex (ixPosOut);
  Result := oBtrTable.FindNearest([pPosOut]);
end;

function TTopBtr.NearestPosRet (pPosRet:Str15):boolean;
begin
  SetIndex (ixPosRet);
  Result := oBtrTable.FindNearest([pPosRet]);
end;

function TTopBtr.NearestDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPoGs);
  Result := oBtrTable.FindNearest([pDocNum,pPosOut,pGsCode]);
end;

function TTopBtr.NearestDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPrGs);
  Result := oBtrTable.FindNearest([pDocNum,pPosRet,pGsCode]);
end;

procedure TTopBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTopBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTopBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTopBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTopBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTopBtr.First;
begin
  oBtrTable.First;
end;

procedure TTopBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTopBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTopBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTopBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTopBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTopBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTopBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTopBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTopBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTopBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTopBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
