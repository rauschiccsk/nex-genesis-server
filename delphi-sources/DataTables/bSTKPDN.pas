unit bSTKPDN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrdNum = 'PrdNum';
  ixPnSt = 'PnSt';
  ixPnStGc = 'PnStGc';
  ixGsCode = 'GsCode';
  ixOdOi = 'OdOi';

type
  TStkpdnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPrdNum:Str30;          procedure WritePrdNum (pValue:Str30);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadInpDoc:Str12;          procedure WriteInpDoc (pValue:Str12);
    function  ReadInpItm:word;           procedure WriteInpItm (pValue:word);
    function  ReadInpDat:TDatetime;      procedure WriteInpDat (pValue:TDatetime);
    function  ReadInpFif:longint;        procedure WriteInpFif (pValue:longint);
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadOutItm:word;           procedure WriteOutItm (pValue:word);
    function  ReadOutDat:TDatetime;      procedure WriteOutDat (pValue:TDatetime);
    function  ReadCrtUsr:Str8;           procedure WriteCrtUsr (pValue:Str8);
    function  ReadCrtDat:TDatetime;      procedure WriteCrtDat (pValue:TDatetime);
    function  ReadCrtTim:TDatetime;      procedure WriteCrtTim (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePrdNum (pPrdNum:Str30):boolean;
    function LocatePnSt (pPrdNum:Str30;pStatus:Str1):boolean;
    function LocatePnStGc (pPrdNum:Str30;pStatus:Str1;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateOdOi (pOutDoc:Str12;pOutItm:word):boolean;
    function NearestPrdNum (pPrdNum:Str30):boolean;
    function NearestPnSt (pPrdNum:Str30;pStatus:Str1):boolean;
    function NearestPnStGc (pPrdNum:Str30;pStatus:Str1;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestOdOi (pOutDoc:Str12;pOutItm:word):boolean;

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
    property PrdNum:Str30 read ReadPrdNum write WritePrdNum;
    property Status:Str1 read ReadStatus write WriteStatus;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property InpDoc:Str12 read ReadInpDoc write WriteInpDoc;
    property InpItm:word read ReadInpItm write WriteInpItm;
    property InpDat:TDatetime read ReadInpDat write WriteInpDat;
    property InpFif:longint read ReadInpFif write WriteInpFif;
    property OutDoc:Str12 read ReadOutDoc write WriteOutDoc;
    property OutItm:word read ReadOutItm write WriteOutItm;
    property OutDat:TDatetime read ReadOutDat write WriteOutDat;
    property CrtUsr:Str8 read ReadCrtUsr write WriteCrtUsr;
    property CrtDat:TDatetime read ReadCrtDat write WriteCrtDat;
    property CrtTim:TDatetime read ReadCrtTim write WriteCrtTim;
  end;

implementation

constructor TStkpdnBtr.Create;
begin
  oBtrTable := BtrInit ('STKPDN',gPath.StkPath,Self);
end;

constructor TStkpdnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STKPDN',pPath,Self);
end;

destructor TStkpdnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStkpdnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStkpdnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStkpdnBtr.ReadPrdNum:Str30;
begin
  Result := oBtrTable.FieldByName('PrdNum').AsString;
end;

procedure TStkpdnBtr.WritePrdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('PrdNum').AsString := pValue;
end;

function TStkpdnBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TStkpdnBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TStkpdnBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStkpdnBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStkpdnBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkpdnBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TStkpdnBtr.ReadInpDoc:Str12;
begin
  Result := oBtrTable.FieldByName('InpDoc').AsString;
end;

procedure TStkpdnBtr.WriteInpDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('InpDoc').AsString := pValue;
end;

function TStkpdnBtr.ReadInpItm:word;
begin
  Result := oBtrTable.FieldByName('InpItm').AsInteger;
end;

procedure TStkpdnBtr.WriteInpItm(pValue:word);
begin
  oBtrTable.FieldByName('InpItm').AsInteger := pValue;
end;

function TStkpdnBtr.ReadInpDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('InpDat').AsDateTime;
end;

procedure TStkpdnBtr.WriteInpDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('InpDat').AsDateTime := pValue;
end;

function TStkpdnBtr.ReadInpFif:longint;
begin
  Result := oBtrTable.FieldByName('InpFif').AsInteger;
end;

procedure TStkpdnBtr.WriteInpFif(pValue:longint);
begin
  oBtrTable.FieldByName('InpFif').AsInteger := pValue;
end;

function TStkpdnBtr.ReadOutDoc:Str12;
begin
  Result := oBtrTable.FieldByName('OutDoc').AsString;
end;

procedure TStkpdnBtr.WriteOutDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('OutDoc').AsString := pValue;
end;

function TStkpdnBtr.ReadOutItm:word;
begin
  Result := oBtrTable.FieldByName('OutItm').AsInteger;
end;

procedure TStkpdnBtr.WriteOutItm(pValue:word);
begin
  oBtrTable.FieldByName('OutItm').AsInteger := pValue;
end;

function TStkpdnBtr.ReadOutDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDat').AsDateTime;
end;

procedure TStkpdnBtr.WriteOutDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDat').AsDateTime := pValue;
end;

function TStkpdnBtr.ReadCrtUsr:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkpdnBtr.WriteCrtUsr(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUsr').AsString := pValue;
end;

function TStkpdnBtr.ReadCrtDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDat').AsDateTime;
end;

procedure TStkpdnBtr.WriteCrtDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDat').AsDateTime := pValue;
end;

function TStkpdnBtr.ReadCrtTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkpdnBtr.WriteCrtTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTim').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkpdnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStkpdnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStkpdnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStkpdnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStkpdnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStkpdnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStkpdnBtr.LocatePrdNum (pPrdNum:Str30):boolean;
begin
  SetIndex (ixPrdNum);
  Result := oBtrTable.FindKey([pPrdNum]);
end;

function TStkpdnBtr.LocatePnSt (pPrdNum:Str30;pStatus:Str1):boolean;
begin
  SetIndex (ixPnSt);
  Result := oBtrTable.FindKey([pPrdNum,pStatus]);
end;

function TStkpdnBtr.LocatePnStGc (pPrdNum:Str30;pStatus:Str1;pGsCode:longint):boolean;
begin
  SetIndex (ixPnStGc);
  Result := oBtrTable.FindKey([pPrdNum,pStatus,pGsCode]);
end;

function TStkpdnBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStkpdnBtr.LocateOdOi (pOutDoc:Str12;pOutItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindKey([pOutDoc,pOutItm]);
end;

function TStkpdnBtr.NearestPrdNum (pPrdNum:Str30):boolean;
begin
  SetIndex (ixPrdNum);
  Result := oBtrTable.FindNearest([pPrdNum]);
end;

function TStkpdnBtr.NearestPnSt (pPrdNum:Str30;pStatus:Str1):boolean;
begin
  SetIndex (ixPnSt);
  Result := oBtrTable.FindNearest([pPrdNum,pStatus]);
end;

function TStkpdnBtr.NearestPnStGc (pPrdNum:Str30;pStatus:Str1;pGsCode:longint):boolean;
begin
  SetIndex (ixPnStGc);
  Result := oBtrTable.FindNearest([pPrdNum,pStatus,pGsCode]);
end;

function TStkpdnBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStkpdnBtr.NearestOdOi (pOutDoc:Str12;pOutItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindNearest([pOutDoc,pOutItm]);
end;

procedure TStkpdnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStkpdnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TStkpdnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStkpdnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStkpdnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStkpdnBtr.First;
begin
  oBtrTable.First;
end;

procedure TStkpdnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStkpdnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStkpdnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStkpdnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStkpdnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStkpdnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStkpdnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStkpdnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStkpdnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStkpdnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStkpdnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
