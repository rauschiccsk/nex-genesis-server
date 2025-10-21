unit bKSO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItOdOiRf = 'DoItOdOiRf';
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';

type
  TKsoBtr = class (TComponent)
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
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadOutItm:longint;        procedure WriteOutItm (pValue:longint);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadOutDat:TDatetime;      procedure WriteOutDat (pValue:TDatetime);
    function  ReadOutPac:longint;        procedure WriteOutPac (pValue:longint);
    function  ReadRenDoc:Str12;          procedure WriteRenDoc (pValue:Str12);
    function  ReadRenItm:longint;        procedure WriteRenItm (pValue:longint);
    function  ReadRenFif:longint;        procedure WriteRenFif (pValue:longint);
    function  ReadRenVal:double;         procedure WriteRenVal (pValue:double);
    function  ReadRenDat:TDatetime;      procedure WriteRenDat (pValue:TDatetime);
    function  ReadRetDoc:Str12;          procedure WriteRetDoc (pValue:Str12);
    function  ReadRetItm:longint;        procedure WriteRetItm (pValue:longint);
    function  ReadRetDat:TDatetime;      procedure WriteRetDat (pValue:TDatetime);
    function  ReadBuyDoc:Str12;          procedure WriteBuyDoc (pValue:Str12);
    function  ReadBuyItm:longint;        procedure WriteBuyItm (pValue:longint);
    function  ReadBuyFif:longint;        procedure WriteBuyFif (pValue:longint);
    function  ReadBuyVal:double;         procedure WriteBuyVal (pValue:double);
    function  ReadBuyDat:TDatetime;      procedure WriteBuyDat (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
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
    function LocateDoItOdOiRf (pDocNum:Str12;pItmNum:word;pOutDoc:Str12;pOutItm:longint;pRenFif:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function NearestDoItOdOiRf (pDocNum:Str12;pItmNum:word;pOutDoc:Str12;pOutItm:longint;pRenFif:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property OutDoc:Str12 read ReadOutDoc write WriteOutDoc;
    property OutItm:longint read ReadOutItm write WriteOutItm;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property OutDat:TDatetime read ReadOutDat write WriteOutDat;
    property OutPac:longint read ReadOutPac write WriteOutPac;
    property RenDoc:Str12 read ReadRenDoc write WriteRenDoc;
    property RenItm:longint read ReadRenItm write WriteRenItm;
    property RenFif:longint read ReadRenFif write WriteRenFif;
    property RenVal:double read ReadRenVal write WriteRenVal;
    property RenDat:TDatetime read ReadRenDat write WriteRenDat;
    property RetDoc:Str12 read ReadRetDoc write WriteRetDoc;
    property RetItm:longint read ReadRetItm write WriteRetItm;
    property RetDat:TDatetime read ReadRetDat write WriteRetDat;
    property BuyDoc:Str12 read ReadBuyDoc write WriteBuyDoc;
    property BuyItm:longint read ReadBuyItm write WriteBuyItm;
    property BuyFif:longint read ReadBuyFif write WriteBuyFif;
    property BuyVal:double read ReadBuyVal write WriteBuyVal;
    property BuyDat:TDatetime read ReadBuyDat write WriteBuyDat;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TKsoBtr.Create;
begin
  oBtrTable := BtrInit ('KSO',gPath.StkPath,Self);
end;

constructor TKsoBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('KSO',pPath,Self);
end;

destructor TKsoBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TKsoBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TKsoBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TKsoBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TKsoBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TKsoBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TKsoBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TKsoBtr.ReadOutDoc:Str12;
begin
  Result := oBtrTable.FieldByName('OutDoc').AsString;
end;

procedure TKsoBtr.WriteOutDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('OutDoc').AsString := pValue;
end;

function TKsoBtr.ReadOutItm:longint;
begin
  Result := oBtrTable.FieldByName('OutItm').AsInteger;
end;

procedure TKsoBtr.WriteOutItm(pValue:longint);
begin
  oBtrTable.FieldByName('OutItm').AsInteger := pValue;
end;

function TKsoBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TKsoBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TKsoBtr.ReadOutVal:double;
begin
  Result := oBtrTable.FieldByName('OutVal').AsFloat;
end;

procedure TKsoBtr.WriteOutVal(pValue:double);
begin
  oBtrTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TKsoBtr.ReadOutDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDat').AsDateTime;
end;

procedure TKsoBtr.WriteOutDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDat').AsDateTime := pValue;
end;

function TKsoBtr.ReadOutPac:longint;
begin
  Result := oBtrTable.FieldByName('OutPac').AsInteger;
end;

procedure TKsoBtr.WriteOutPac(pValue:longint);
begin
  oBtrTable.FieldByName('OutPac').AsInteger := pValue;
end;

function TKsoBtr.ReadRenDoc:Str12;
begin
  Result := oBtrTable.FieldByName('RenDoc').AsString;
end;

procedure TKsoBtr.WriteRenDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('RenDoc').AsString := pValue;
end;

function TKsoBtr.ReadRenItm:longint;
begin
  Result := oBtrTable.FieldByName('RenItm').AsInteger;
end;

procedure TKsoBtr.WriteRenItm(pValue:longint);
begin
  oBtrTable.FieldByName('RenItm').AsInteger := pValue;
end;

function TKsoBtr.ReadRenFif:longint;
begin
  Result := oBtrTable.FieldByName('RenFif').AsInteger;
end;

procedure TKsoBtr.WriteRenFif(pValue:longint);
begin
  oBtrTable.FieldByName('RenFif').AsInteger := pValue;
end;

function TKsoBtr.ReadRenVal:double;
begin
  Result := oBtrTable.FieldByName('RenVal').AsFloat;
end;

procedure TKsoBtr.WriteRenVal(pValue:double);
begin
  oBtrTable.FieldByName('RenVal').AsFloat := pValue;
end;

function TKsoBtr.ReadRenDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('RenDat').AsDateTime;
end;

procedure TKsoBtr.WriteRenDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RenDat').AsDateTime := pValue;
end;

function TKsoBtr.ReadRetDoc:Str12;
begin
  Result := oBtrTable.FieldByName('RetDoc').AsString;
end;

procedure TKsoBtr.WriteRetDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('RetDoc').AsString := pValue;
end;

function TKsoBtr.ReadRetItm:longint;
begin
  Result := oBtrTable.FieldByName('RetItm').AsInteger;
end;

procedure TKsoBtr.WriteRetItm(pValue:longint);
begin
  oBtrTable.FieldByName('RetItm').AsInteger := pValue;
end;

function TKsoBtr.ReadRetDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('RetDat').AsDateTime;
end;

procedure TKsoBtr.WriteRetDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RetDat').AsDateTime := pValue;
end;

function TKsoBtr.ReadBuyDoc:Str12;
begin
  Result := oBtrTable.FieldByName('BuyDoc').AsString;
end;

procedure TKsoBtr.WriteBuyDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('BuyDoc').AsString := pValue;
end;

function TKsoBtr.ReadBuyItm:longint;
begin
  Result := oBtrTable.FieldByName('BuyItm').AsInteger;
end;

procedure TKsoBtr.WriteBuyItm(pValue:longint);
begin
  oBtrTable.FieldByName('BuyItm').AsInteger := pValue;
end;

function TKsoBtr.ReadBuyFif:longint;
begin
  Result := oBtrTable.FieldByName('BuyFif').AsInteger;
end;

procedure TKsoBtr.WriteBuyFif(pValue:longint);
begin
  oBtrTable.FieldByName('BuyFif').AsInteger := pValue;
end;

function TKsoBtr.ReadBuyVal:double;
begin
  Result := oBtrTable.FieldByName('BuyVal').AsFloat;
end;

procedure TKsoBtr.WriteBuyVal(pValue:double);
begin
  oBtrTable.FieldByName('BuyVal').AsFloat := pValue;
end;

function TKsoBtr.ReadBuyDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('BuyDat').AsDateTime;
end;

procedure TKsoBtr.WriteBuyDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BuyDat').AsDateTime := pValue;
end;

function TKsoBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TKsoBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TKsoBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TKsoBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TKsoBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TKsoBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TKsoBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TKsoBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TKsoBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TKsoBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TKsoBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TKsoBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TKsoBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TKsoBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TKsoBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TKsoBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TKsoBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TKsoBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TKsoBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TKsoBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TKsoBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TKsoBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TKsoBtr.LocateDoItOdOiRf (pDocNum:Str12;pItmNum:word;pOutDoc:Str12;pOutItm:longint;pRenFif:longint):boolean;
begin
  SetIndex (ixDoItOdOiRf);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pOutDoc,pOutItm,pRenFif]);
end;

function TKsoBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TKsoBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TKsoBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TKsoBtr.NearestDoItOdOiRf (pDocNum:Str12;pItmNum:word;pOutDoc:Str12;pOutItm:longint;pRenFif:longint):boolean;
begin
  SetIndex (ixDoItOdOiRf);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pOutDoc,pOutItm,pRenFif]);
end;

function TKsoBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TKsoBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TKsoBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

procedure TKsoBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TKsoBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TKsoBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TKsoBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TKsoBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TKsoBtr.First;
begin
  oBtrTable.First;
end;

procedure TKsoBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TKsoBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TKsoBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TKsoBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TKsoBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TKsoBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TKsoBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TKsoBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TKsoBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TKsoBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TKsoBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1928001}
