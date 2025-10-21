unit bPLD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixMgGs = 'MgGs';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixProfit = 'Profit';
  ixAPrice = 'APrice';
  ixBPrice = 'BPrice';
  ixChgItm = 'ChgItm';
  ixDisFlag = 'DisFlag';
  ixAction = 'Action';
  ixSended = 'Sended';

type
  TPldBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadUPrice:double;         procedure WriteUPrice (pValue:double);
    function  ReadOrdPrn:byte;           procedure WriteOrdPrn (pValue:byte);
    function  ReadOpenGs:byte;           procedure WriteOpenGs (pValue:byte);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadChgItm:Str1;           procedure WriteChgItm (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateProfit (pProfit:double):boolean;
    function LocateAPrice (pAPrice:double):boolean;
    function LocateBPrice (pBPrice:double):boolean;
    function LocateChgItm (pChgItm:Str1):boolean;
    function LocateDisFlag (pDisFlag:byte):boolean;
    function LocateAction (pAction:Str1):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str20):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestProfit (pProfit:double):boolean;
    function NearestAPrice (pAPrice:double):boolean;
    function NearestBPrice (pBPrice:double):boolean;
    function NearestChgItm (pChgItm:Str1):boolean;
    function NearestDisFlag (pDisFlag:byte):boolean;
    function NearestAction (pAction:Str1):boolean;
    function NearestSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pPlsNum:word);
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property Profit:double read ReadProfit write WriteProfit;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property UPrice:double read ReadUPrice write WriteUPrice;
    property OrdPrn:byte read ReadOrdPrn write WriteOrdPrn;
    property OpenGs:byte read ReadOpenGs write WriteOpenGs;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property ChgItm:Str1 read ReadChgItm write WriteChgItm;
    property Action:Str1 read ReadAction write WriteAction;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPldBtr.Create;
begin
  oBtrTable := BtrInit ('PLD',gPath.StkPath,Self);
end;

constructor TPldBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PLD',pPath,Self);
end;

destructor TPldBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPldBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPldBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPldBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPldBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPldBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TPldBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TPldBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TPldBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TPldBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TPldBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPldBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TPldBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TPldBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TPldBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TPldBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TPldBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TPldBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TPldBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TPldBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TPldBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TPldBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPldBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPldBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TPldBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TPldBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TPldBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TPldBtr.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DrbMust').AsInteger);
end;

procedure TPldBtr.WriteDrbMust(pValue:boolean);
begin
  oBtrTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TPldBtr.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('PdnMust').AsInteger);
end;

procedure TPldBtr.WritePdnMust(pValue:boolean);
begin
  oBtrTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TPldBtr.ReadGrcMth:word;
begin
  Result := oBtrTable.FieldByName('GrcMth').AsInteger;
end;

procedure TPldBtr.WriteGrcMth(pValue:word);
begin
  oBtrTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TPldBtr.ReadProfit:double;
begin
  Result := oBtrTable.FieldByName('Profit').AsFloat;
end;

procedure TPldBtr.WriteProfit(pValue:double);
begin
  oBtrTable.FieldByName('Profit').AsFloat := pValue;
end;

function TPldBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TPldBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TPldBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TPldBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TPldBtr.ReadUPrice:double;
begin
  Result := oBtrTable.FieldByName('UPrice').AsFloat;
end;

procedure TPldBtr.WriteUPrice(pValue:double);
begin
  oBtrTable.FieldByName('UPrice').AsFloat := pValue;
end;

function TPldBtr.ReadOrdPrn:byte;
begin
  Result := oBtrTable.FieldByName('OrdPrn').AsInteger;
end;

procedure TPldBtr.WriteOrdPrn(pValue:byte);
begin
  oBtrTable.FieldByName('OrdPrn').AsInteger := pValue;
end;

function TPldBtr.ReadOpenGs:byte;
begin
  Result := oBtrTable.FieldByName('OpenGs').AsInteger;
end;

procedure TPldBtr.WriteOpenGs(pValue:byte);
begin
  oBtrTable.FieldByName('OpenGs').AsInteger := pValue;
end;

function TPldBtr.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DisFlag').AsInteger);
end;

procedure TPldBtr.WriteDisFlag(pValue:boolean);
begin
  oBtrTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TPldBtr.ReadChgItm:Str1;
begin
  Result := oBtrTable.FieldByName('ChgItm').AsString;
end;

procedure TPldBtr.WriteChgItm(pValue:Str1);
begin
  oBtrTable.FieldByName('ChgItm').AsString := pValue;
end;

function TPldBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TPldBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TPldBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TPldBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPldBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPldBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPldBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPldBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPldBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPldBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPldBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPldBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPldBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPldBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPldBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPldBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPldBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPldBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPldBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPldBtr.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindKey([pMgCode,pGsCode]);
end;

function TPldBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TPldBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TPldBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TPldBtr.LocateProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oBtrTable.FindKey([pProfit]);
end;

function TPldBtr.LocateAPrice (pAPrice:double):boolean;
begin
  SetIndex (ixAPrice);
  Result := oBtrTable.FindKey([pAPrice]);
end;

function TPldBtr.LocateBPrice (pBPrice:double):boolean;
begin
  SetIndex (ixBPrice);
  Result := oBtrTable.FindKey([pBPrice]);
end;

function TPldBtr.LocateChgItm (pChgItm:Str1):boolean;
begin
  SetIndex (ixChgItm);
  Result := oBtrTable.FindKey([pChgItm]);
end;

function TPldBtr.LocateDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindKey([pDisFlag]);
end;

function TPldBtr.LocateAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oBtrTable.FindKey([pAction]);
end;

function TPldBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TPldBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TPldBtr.NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindNearest([pMgCode,pGsCode]);
end;

function TPldBtr.NearestGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TPldBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TPldBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TPldBtr.NearestProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oBtrTable.FindNearest([pProfit]);
end;

function TPldBtr.NearestAPrice (pAPrice:double):boolean;
begin
  SetIndex (ixAPrice);
  Result := oBtrTable.FindNearest([pAPrice]);
end;

function TPldBtr.NearestBPrice (pBPrice:double):boolean;
begin
  SetIndex (ixBPrice);
  Result := oBtrTable.FindNearest([pBPrice]);
end;

function TPldBtr.NearestChgItm (pChgItm:Str1):boolean;
begin
  SetIndex (ixChgItm);
  Result := oBtrTable.FindNearest([pChgItm]);
end;

function TPldBtr.NearestDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindNearest([pDisFlag]);
end;

function TPldBtr.NearestAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oBtrTable.FindNearest([pAction]);
end;

function TPldBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TPldBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPldBtr.Open(pPlsNum:word);
begin
  oBtrTable.Open(pPlsNum);
end;

procedure TPldBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPldBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPldBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPldBtr.First;
begin
  oBtrTable.First;
end;

procedure TPldBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPldBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPldBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPldBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPldBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPldBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPldBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPldBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPldBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPldBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPldBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1925001}
