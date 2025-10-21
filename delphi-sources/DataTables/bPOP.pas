unit bPOP;

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
  TPopBtr = class (TComponent)
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

constructor TPopBtr.Create;
begin
  oBtrTable := BtrInit ('POP',gPath.StkPath,Self);
end;

constructor TPopBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('POP',pPath,Self);
end;

destructor TPopBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPopBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPopBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPopBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPopBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPopBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPopBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPopBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPopBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPopBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TPopBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TPopBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TPopBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TPopBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TPopBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TPopBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TPopBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TPopBtr.ReadRetQnt:double;
begin
  Result := oBtrTable.FieldByName('RetQnt').AsFloat;
end;

procedure TPopBtr.WriteRetQnt(pValue:double);
begin
  oBtrTable.FieldByName('RetQnt').AsFloat := pValue;
end;

function TPopBtr.ReadReoNum:byte;
begin
  Result := oBtrTable.FieldByName('ReoNum').AsInteger;
end;

procedure TPopBtr.WriteReoNum(pValue:byte);
begin
  oBtrTable.FieldByName('ReoNum').AsInteger := pValue;
end;

function TPopBtr.ReadRerNum:byte;
begin
  Result := oBtrTable.FieldByName('RerNum').AsInteger;
end;

procedure TPopBtr.WriteRerNum(pValue:byte);
begin
  oBtrTable.FieldByName('RerNum').AsInteger := pValue;
end;

function TPopBtr.ReadPosOut:Str15;
begin
  Result := oBtrTable.FieldByName('PosOut').AsString;
end;

procedure TPopBtr.WritePosOut(pValue:Str15);
begin
  oBtrTable.FieldByName('PosOut').AsString := pValue;
end;

function TPopBtr.ReadPosRet:Str15;
begin
  Result := oBtrTable.FieldByName('PosRet').AsString;
end;

procedure TPopBtr.WritePosRet(pValue:Str15);
begin
  oBtrTable.FieldByName('PosRet').AsString := pValue;
end;

function TPopBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPopBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPopBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPopBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPopBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPopBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPopBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPopBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPopBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPopBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPopBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPopBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPopBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPopBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPopBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPopBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPopBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPopBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPopBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPopBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPopBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPopBtr.LocatePosOut (pPosOut:Str15):boolean;
begin
  SetIndex (ixPosOut);
  Result := oBtrTable.FindKey([pPosOut]);
end;

function TPopBtr.LocatePosRet (pPosRet:Str15):boolean;
begin
  SetIndex (ixPosRet);
  Result := oBtrTable.FindKey([pPosRet]);
end;

function TPopBtr.LocateDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPoGs);
  Result := oBtrTable.FindKey([pDocNum,pPosOut,pGsCode]);
end;

function TPopBtr.LocateDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPrGs);
  Result := oBtrTable.FindKey([pDocNum,pPosRet,pGsCode]);
end;

function TPopBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPopBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPopBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TPopBtr.NearestPosOut (pPosOut:Str15):boolean;
begin
  SetIndex (ixPosOut);
  Result := oBtrTable.FindNearest([pPosOut]);
end;

function TPopBtr.NearestPosRet (pPosRet:Str15):boolean;
begin
  SetIndex (ixPosRet);
  Result := oBtrTable.FindNearest([pPosRet]);
end;

function TPopBtr.NearestDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPoGs);
  Result := oBtrTable.FindNearest([pDocNum,pPosOut,pGsCode]);
end;

function TPopBtr.NearestDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPrGs);
  Result := oBtrTable.FindNearest([pDocNum,pPosRet,pGsCode]);
end;

procedure TPopBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPopBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPopBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPopBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPopBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPopBtr.First;
begin
  oBtrTable.First;
end;

procedure TPopBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPopBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPopBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPopBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPopBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPopBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPopBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPopBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPopBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPopBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPopBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
