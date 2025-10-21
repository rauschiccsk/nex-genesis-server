unit bIVI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIvlNum = 'IvlNum';
  ixIlIt = 'IlIt';
  ixIlGs = 'IlGs';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixDifType = 'DifType';
  ixGsPc = 'GsPc';
  ixIlGsPc = 'IlGsPc';

type
  TIviBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oIvdNum: integer;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadIvlNum:word;           procedure WriteIvlNum (pValue:word);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadIvQnt1:double;         procedure WriteIvQnt1 (pValue:double);
    function  ReadIvQnt2:double;         procedure WriteIvQnt2 (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadIvQnt:double;          procedure WriteIvQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadClosed:byte;           procedure WriteClosed (pValue:byte);
    function  ReadDifType:Str1;          procedure WriteDifType (pValue:Str1);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
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
    function LocateIvlNum (pIvlNum:word):boolean;
    function LocateIlIt (pIvlNum:word;pItmNum:word):boolean;
    function LocateIlGs (pIvlNum:word;pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateDifType (pDifType:Str1):boolean;
    function LocateGsPc (pGsCode:longint;pPosCode:Str15):boolean;
    function LocateIlGsPc (pIvlNum:word;pGsCode:longint;pPosCode:Str15):boolean;
    function NearestIvlNum (pIvlNum:word):boolean;
    function NearestIlIt (pIvlNum:word;pItmNum:word):boolean;
    function NearestIlGs (pIvlNum:word;pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestDifType (pDifType:Str1):boolean;
    function NearestGsPc (pGsCode:longint;pPosCode:Str15):boolean;
    function NearestIlGsPc (pIvlNum:word;pGsCode:longint;pPosCode:Str15):boolean;

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
    property IvlNum:word read ReadIvlNum write WriteIvlNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property IvQnt1:double read ReadIvQnt1 write WriteIvQnt1;
    property IvQnt2:double read ReadIvQnt2 write WriteIvQnt2;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property IvQnt:double read ReadIvQnt write WriteIvQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Closed:byte read ReadClosed write WriteClosed;
    property DifType:Str1 read ReadDifType write WriteDifType;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PosCode:Str15 read ReadPosCode write WritePosCode;
  end;

implementation

constructor TIviBtr.Create;
begin
  oBtrTable := BtrInit ('IVI',gPath.StkPath,Self);
end;

constructor TIviBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IVI',pPath,Self);
end;

destructor TIviBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIviBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIviBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIviBtr.ReadIvlNum:word;
begin
  Result := oBtrTable.FieldByName('IvlNum').AsInteger;
end;

procedure TIviBtr.WriteIvlNum(pValue:word);
begin
  oBtrTable.FieldByName('IvlNum').AsInteger := pValue;
end;

function TIviBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIviBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIviBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TIviBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIviBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TIviBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TIviBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TIviBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TIviBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TIviBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TIviBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TIviBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TIviBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TIviBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TIviBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TIviBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TIviBtr.ReadIvQnt1:double;
begin
  Result := oBtrTable.FieldByName('IvQnt1').AsFloat;
end;

procedure TIviBtr.WriteIvQnt1(pValue:double);
begin
  oBtrTable.FieldByName('IvQnt1').AsFloat := pValue;
end;

function TIviBtr.ReadIvQnt2:double;
begin
  Result := oBtrTable.FieldByName('IvQnt2').AsFloat;
end;

procedure TIviBtr.WriteIvQnt2(pValue:double);
begin
  oBtrTable.FieldByName('IvQnt2').AsFloat := pValue;
end;

function TIviBtr.ReadDifQnt:double;
begin
  Result := oBtrTable.FieldByName('DifQnt').AsFloat;
end;

procedure TIviBtr.WriteDifQnt(pValue:double);
begin
  oBtrTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TIviBtr.ReadIvQnt:double;
begin
  Result := oBtrTable.FieldByName('IvQnt').AsFloat;
end;

procedure TIviBtr.WriteIvQnt(pValue:double);
begin
  oBtrTable.FieldByName('IvQnt').AsFloat := pValue;
end;

function TIviBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TIviBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TIviBtr.ReadClosed:byte;
begin
  Result := oBtrTable.FieldByName('Closed').AsInteger;
end;

procedure TIviBtr.WriteClosed(pValue:byte);
begin
  oBtrTable.FieldByName('Closed').AsInteger := pValue;
end;

function TIviBtr.ReadDifType:Str1;
begin
  Result := oBtrTable.FieldByName('DifType').AsString;
end;

procedure TIviBtr.WriteDifType(pValue:Str1);
begin
  oBtrTable.FieldByName('DifType').AsString := pValue;
end;

function TIviBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIviBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIviBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIviBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIviBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIviBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIviBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIviBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIviBtr.ReadPosCode:Str15;
begin
  Result := oBtrTable.FieldByName('PosCode').AsString;
end;

procedure TIviBtr.WritePosCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PosCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIviBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIviBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIviBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIviBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIviBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIviBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIviBtr.LocateIvlNum (pIvlNum:word):boolean;
begin
  SetIndex (ixIvlNum);
  Result := oBtrTable.FindKey([pIvlNum]);
end;

function TIviBtr.LocateIlIt (pIvlNum:word;pItmNum:word):boolean;
begin
  SetIndex (ixIlIt);
  Result := oBtrTable.FindKey([pIvlNum,pItmNum]);
end;

function TIviBtr.LocateIlGs (pIvlNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixIlGs);
  Result := oBtrTable.FindKey([pIvlNum,pGsCode]);
end;

function TIviBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TIviBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TIviBtr.LocateDifType (pDifType:Str1):boolean;
begin
  SetIndex (ixDifType);
  Result := oBtrTable.FindKey([pDifType]);
end;

function TIviBtr.LocateGsPc (pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixGsPc);
  Result := oBtrTable.FindKey([pGsCode,pPosCode]);
end;

function TIviBtr.LocateIlGsPc (pIvlNum:word;pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixIlGsPc);
  Result := oBtrTable.FindKey([pIvlNum,pGsCode,pPosCode]);
end;

function TIviBtr.NearestIvlNum (pIvlNum:word):boolean;
begin
  SetIndex (ixIvlNum);
  Result := oBtrTable.FindNearest([pIvlNum]);
end;

function TIviBtr.NearestIlIt (pIvlNum:word;pItmNum:word):boolean;
begin
  SetIndex (ixIlIt);
  Result := oBtrTable.FindNearest([pIvlNum,pItmNum]);
end;

function TIviBtr.NearestIlGs (pIvlNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixIlGs);
  Result := oBtrTable.FindNearest([pIvlNum,pGsCode]);
end;

function TIviBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TIviBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TIviBtr.NearestDifType (pDifType:Str1):boolean;
begin
  SetIndex (ixDifType);
  Result := oBtrTable.FindNearest([pDifType]);
end;

function TIviBtr.NearestGsPc (pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixGsPc);
  Result := oBtrTable.FindNearest([pGsCode,pPosCode]);
end;

function TIviBtr.NearestIlGsPc (pIvlNum:word;pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixIlGsPc);
  Result := oBtrTable.FindNearest([pIvlNum,pGsCode,pPosCode]);
end;

procedure TIviBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIviBtr.Open(pIvdNum:integer);
begin
  oIvdNum := pIvdNum;
  oBtrTable.Open(pIvdNum);
end;

procedure TIviBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIviBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIviBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIviBtr.First;
begin
  oBtrTable.First;
end;

procedure TIviBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIviBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIviBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIviBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIviBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIviBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIviBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIviBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIviBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIviBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIviBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
