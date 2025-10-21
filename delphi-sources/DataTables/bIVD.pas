unit bIVD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixDifQnt = 'DifQnt';
  ixDifVal = 'DifVal';
  ixDifStat = 'DifStat';
  ixCPrice = 'CPrice';
  ixGsPc = 'GsPc';

type
  TIvdBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oIvdNum: integer;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadIvQnt:double;          procedure WriteIvQnt (pValue:double);
    function  ReadIvVal:double;          procedure WriteIvVal (pValue:double);
    function  ReadNsQnt:double;          procedure WriteNsQnt (pValue:double);
    function  ReadNsVal:double;          procedure WriteNsVal (pValue:double);
    function  ReadStQnt:double;          procedure WriteStQnt (pValue:double);
    function  ReadStVal:double;          procedure WriteStVal (pValue:double);
    function  ReadCpQnt:double;          procedure WriteCpQnt (pValue:double);
    function  ReadCpVal:double;          procedure WriteCpVal (pValue:double);
    function  ReadEvQnt:double;          procedure WriteEvQnt (pValue:double);
    function  ReadEvVal:double;          procedure WriteEvVal (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadDifStat:Str1;          procedure WriteDifStat (pValue:Str1);
    function  ReadClosed:byte;           procedure WriteClosed (pValue:byte);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
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
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateDifQnt (pDifQnt:double):boolean;
    function LocateDifVal (pDifVal:double):boolean;
    function LocateDifStat (pDifStat:Str1):boolean;
    function LocateCPrice (pCPrice:double):boolean;
    function LocateGsPc (pGsCode:longint;pPosCode:Str15):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str20):boolean;
    function NearestMgCode (pMgCode:word):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestDifQnt (pDifQnt:double):boolean;
    function NearestDifVal (pDifVal:double):boolean;
    function NearestDifStat (pDifStat:Str1):boolean;
    function NearestCPrice (pCPrice:double):boolean;
    function NearestGsPc (pGsCode:longint;pPosCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pIvdNum:integer);
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
    property MgCode:word read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property IvQnt:double read ReadIvQnt write WriteIvQnt;
    property IvVal:double read ReadIvVal write WriteIvVal;
    property NsQnt:double read ReadNsQnt write WriteNsQnt;
    property NsVal:double read ReadNsVal write WriteNsVal;
    property StQnt:double read ReadStQnt write WriteStQnt;
    property StVal:double read ReadStVal write WriteStVal;
    property CpQnt:double read ReadCpQnt write WriteCpQnt;
    property CpVal:double read ReadCpVal write WriteCpVal;
    property EvQnt:double read ReadEvQnt write WriteEvQnt;
    property EvVal:double read ReadEvVal write WriteEvVal;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property DifVal:double read ReadDifVal write WriteDifVal;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property DifStat:Str1 read ReadDifStat write WriteDifStat;
    property Closed:byte read ReadClosed write WriteClosed;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property PosCode:Str15 read ReadPosCode write WritePosCode;
  end;

implementation

constructor TIvdBtr.Create;
begin
  oBtrTable := BtrInit ('IVD',gPath.StkPath,Self);
end;

constructor TIvdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IVD',pPath,Self);
end;

destructor TIvdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIvdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIvdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIvdBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TIvdBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIvdBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TIvdBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TIvdBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TIvdBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TIvdBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TIvdBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TIvdBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TIvdBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TIvdBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TIvdBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TIvdBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TIvdBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TIvdBtr.ReadIvQnt:double;
begin
  Result := oBtrTable.FieldByName('IvQnt').AsFloat;
end;

procedure TIvdBtr.WriteIvQnt(pValue:double);
begin
  oBtrTable.FieldByName('IvQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadIvVal:double;
begin
  Result := oBtrTable.FieldByName('IvVal').AsFloat;
end;

procedure TIvdBtr.WriteIvVal(pValue:double);
begin
  oBtrTable.FieldByName('IvVal').AsFloat := pValue;
end;

function TIvdBtr.ReadNsQnt:double;
begin
  Result := oBtrTable.FieldByName('NsQnt').AsFloat;
end;

procedure TIvdBtr.WriteNsQnt(pValue:double);
begin
  oBtrTable.FieldByName('NsQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadNsVal:double;
begin
  Result := oBtrTable.FieldByName('NsVal').AsFloat;
end;

procedure TIvdBtr.WriteNsVal(pValue:double);
begin
  oBtrTable.FieldByName('NsVal').AsFloat := pValue;
end;

function TIvdBtr.ReadStQnt:double;
begin
  Result := oBtrTable.FieldByName('StQnt').AsFloat;
end;

procedure TIvdBtr.WriteStQnt(pValue:double);
begin
  oBtrTable.FieldByName('StQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadStVal:double;
begin
  Result := oBtrTable.FieldByName('StVal').AsFloat;
end;

procedure TIvdBtr.WriteStVal(pValue:double);
begin
  oBtrTable.FieldByName('StVal').AsFloat := pValue;
end;

function TIvdBtr.ReadCpQnt:double;
begin
  Result := oBtrTable.FieldByName('CpQnt').AsFloat;
end;

procedure TIvdBtr.WriteCpQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadCpVal:double;
begin
  Result := oBtrTable.FieldByName('CpVal').AsFloat;
end;

procedure TIvdBtr.WriteCpVal(pValue:double);
begin
  oBtrTable.FieldByName('CpVal').AsFloat := pValue;
end;

function TIvdBtr.ReadEvQnt:double;
begin
  Result := oBtrTable.FieldByName('EvQnt').AsFloat;
end;

procedure TIvdBtr.WriteEvQnt(pValue:double);
begin
  oBtrTable.FieldByName('EvQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadEvVal:double;
begin
  Result := oBtrTable.FieldByName('EvVal').AsFloat;
end;

procedure TIvdBtr.WriteEvVal(pValue:double);
begin
  oBtrTable.FieldByName('EvVal').AsFloat := pValue;
end;

function TIvdBtr.ReadDifQnt:double;
begin
  Result := oBtrTable.FieldByName('DifQnt').AsFloat;
end;

procedure TIvdBtr.WriteDifQnt(pValue:double);
begin
  oBtrTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadDifVal:double;
begin
  Result := oBtrTable.FieldByName('DifVal').AsFloat;
end;

procedure TIvdBtr.WriteDifVal(pValue:double);
begin
  oBtrTable.FieldByName('DifVal').AsFloat := pValue;
end;

function TIvdBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TIvdBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TIvdBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TIvdBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TIvdBtr.ReadDifStat:Str1;
begin
  Result := oBtrTable.FieldByName('DifStat').AsString;
end;

procedure TIvdBtr.WriteDifStat(pValue:Str1);
begin
  oBtrTable.FieldByName('DifStat').AsString := pValue;
end;

function TIvdBtr.ReadClosed:byte;
begin
  Result := oBtrTable.FieldByName('Closed').AsInteger;
end;

procedure TIvdBtr.WriteClosed(pValue:byte);
begin
  oBtrTable.FieldByName('Closed').AsInteger := pValue;
end;

function TIvdBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIvdBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIvdBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIvdBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIvdBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIvdBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIvdBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIvdBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIvdBtr.ReadOcdQnt:double;
begin
  Result := oBtrTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TIvdBtr.WriteOcdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TIvdBtr.ReadPosCode:Str15;
begin
  Result := oBtrTable.FieldByName('PosCode').AsString;
end;

procedure TIvdBtr.WritePosCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PosCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIvdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIvdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIvdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIvdBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TIvdBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TIvdBtr.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TIvdBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TIvdBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TIvdBtr.LocateDifQnt (pDifQnt:double):boolean;
begin
  SetIndex (ixDifQnt);
  Result := oBtrTable.FindKey([pDifQnt]);
end;

function TIvdBtr.LocateDifVal (pDifVal:double):boolean;
begin
  SetIndex (ixDifVal);
  Result := oBtrTable.FindKey([pDifVal]);
end;

function TIvdBtr.LocateDifStat (pDifStat:Str1):boolean;
begin
  SetIndex (ixDifStat);
  Result := oBtrTable.FindKey([pDifStat]);
end;

function TIvdBtr.LocateCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindKey([pCPrice]);
end;

function TIvdBtr.LocateGsPc (pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixGsPc);
  Result := oBtrTable.FindKey([pGsCode,pPosCode]);
end;

function TIvdBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TIvdBtr.NearestGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TIvdBtr.NearestMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TIvdBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TIvdBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TIvdBtr.NearestDifQnt (pDifQnt:double):boolean;
begin
  SetIndex (ixDifQnt);
  Result := oBtrTable.FindNearest([pDifQnt]);
end;

function TIvdBtr.NearestDifVal (pDifVal:double):boolean;
begin
  SetIndex (ixDifVal);
  Result := oBtrTable.FindNearest([pDifVal]);
end;

function TIvdBtr.NearestDifStat (pDifStat:Str1):boolean;
begin
  SetIndex (ixDifStat);
  Result := oBtrTable.FindNearest([pDifStat]);
end;

function TIvdBtr.NearestCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindNearest([pCPrice]);
end;

function TIvdBtr.NearestGsPc (pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixGsPc);
  Result := oBtrTable.FindNearest([pGsCode,pPosCode]);
end;

procedure TIvdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIvdBtr.Open(pIvdNum:integer);
begin
  oIvdNum:=pIvdNum;
  oBtrTable.Open(pIvdNum);
end;

procedure TIvdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIvdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIvdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIvdBtr.First;
begin
  oBtrTable.First;
end;

procedure TIvdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIvdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIvdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIvdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIvdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIvdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIvdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIvdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIvdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIvdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIvdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
