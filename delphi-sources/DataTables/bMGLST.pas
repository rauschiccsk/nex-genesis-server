unit bMGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMgCode = 'MgCode';
  ixMgName = 'MgName';
  ixProfit = 'Profit';
  ixParent = 'Parent';
  ixSended = 'Sended';
  ixEshop1 = 'Eshop1';
  ixEshop2 = 'Eshop2';
  ixEshop3 = 'Eshop3';
  ixEshop4 = 'Eshop4';
  ixEshop5 = 'Eshop5';

type
  TMglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadMgName_:Str15;         procedure WriteMgName_ (pValue:Str15);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadParent:longint;        procedure WriteParent (pValue:longint);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPrfPrc1:double;        procedure WritePrfPrc1 (pValue:double);
    function  ReadPrfPrc2:double;        procedure WritePrfPrc2 (pValue:double);
    function  ReadPrfPrc3:double;        procedure WritePrfPrc3 (pValue:double);
    function  ReadDscPrc1:double;        procedure WriteDscPrc1 (pValue:double);
    function  ReadDscPrc2:double;        procedure WriteDscPrc2 (pValue:double);
    function  ReadDscPrc3:double;        procedure WriteDscPrc3 (pValue:double);
    function  ReadEshop1:byte;           procedure WriteEshop1 (pValue:byte);
    function  ReadEshop2:byte;           procedure WriteEshop2 (pValue:byte);
    function  ReadEshop3:byte;           procedure WriteEshop3 (pValue:byte);
    function  ReadEshop4:byte;           procedure WriteEshop4 (pValue:byte);
    function  ReadEshop5:byte;           procedure WriteEshop5 (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateMgName (pMgName_:Str15):boolean;
    function LocateProfit (pProfit:double):boolean;
    function LocateParent (pParent:longint):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateEshop1 (pEshop1:byte):boolean;
    function LocateEshop2 (pEshop2:byte):boolean;
    function LocateEshop3 (pEshop3:byte):boolean;
    function LocateEshop4 (pEshop4:byte):boolean;
    function LocateEshop5 (pEshop5:byte):boolean;
    function NearestMgCode (pMgCode:longint):boolean;
    function NearestMgName (pMgName_:Str15):boolean;
    function NearestProfit (pProfit:double):boolean;
    function NearestParent (pParent:longint):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestEshop1 (pEshop1:byte):boolean;
    function NearestEshop2 (pEshop2:byte):boolean;
    function NearestEshop3 (pEshop3:byte):boolean;
    function NearestEshop4 (pEshop4:byte):boolean;
    function NearestEshop5 (pEshop5:byte):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property MgName_:Str15 read ReadMgName_ write WriteMgName_;
    property Profit:double read ReadProfit write WriteProfit;
    property Parent:longint read ReadParent write WriteParent;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PrfPrc1:double read ReadPrfPrc1 write WritePrfPrc1;
    property PrfPrc2:double read ReadPrfPrc2 write WritePrfPrc2;
    property PrfPrc3:double read ReadPrfPrc3 write WritePrfPrc3;
    property DscPrc1:double read ReadDscPrc1 write WriteDscPrc1;
    property DscPrc2:double read ReadDscPrc2 write WriteDscPrc2;
    property DscPrc3:double read ReadDscPrc3 write WriteDscPrc3;
    property Eshop1:byte read ReadEshop1 write WriteEshop1;
    property Eshop2:byte read ReadEshop2 write WriteEshop2;
    property Eshop3:byte read ReadEshop3 write WriteEshop3;
    property Eshop4:byte read ReadEshop4 write WriteEshop4;
    property Eshop5:byte read ReadEshop5 write WriteEshop5;
  end;

implementation

constructor TMglstBtr.Create;
begin
  oBtrTable := BtrInit ('MGLST',gPath.StkPath,Self);
end;

constructor TMglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MGLST',pPath,Self);
end;

destructor TMglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMglstBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TMglstBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TMglstBtr.ReadMgName:Str30;
begin
  Result := oBtrTable.FieldByName('MgName').AsString;
end;

procedure TMglstBtr.WriteMgName(pValue:Str30);
begin
  oBtrTable.FieldByName('MgName').AsString := pValue;
end;

function TMglstBtr.ReadMgName_:Str15;
begin
  Result := oBtrTable.FieldByName('MgName_').AsString;
end;

procedure TMglstBtr.WriteMgName_(pValue:Str15);
begin
  oBtrTable.FieldByName('MgName_').AsString := pValue;
end;

function TMglstBtr.ReadProfit:double;
begin
  Result := oBtrTable.FieldByName('Profit').AsFloat;
end;

procedure TMglstBtr.WriteProfit(pValue:double);
begin
  oBtrTable.FieldByName('Profit').AsFloat := pValue;
end;

function TMglstBtr.ReadParent:longint;
begin
  Result := oBtrTable.FieldByName('Parent').AsInteger;
end;

procedure TMglstBtr.WriteParent(pValue:longint);
begin
  oBtrTable.FieldByName('Parent').AsInteger := pValue;
end;

function TMglstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TMglstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TMglstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TMglstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TMglstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMglstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMglstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMglstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMglstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMglstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TMglstBtr.ReadPrfPrc1:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc1').AsFloat;
end;

procedure TMglstBtr.WritePrfPrc1(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc1').AsFloat := pValue;
end;

function TMglstBtr.ReadPrfPrc2:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc2').AsFloat;
end;

procedure TMglstBtr.WritePrfPrc2(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc2').AsFloat := pValue;
end;

function TMglstBtr.ReadPrfPrc3:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc3').AsFloat;
end;

procedure TMglstBtr.WritePrfPrc3(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc3').AsFloat := pValue;
end;

function TMglstBtr.ReadDscPrc1:double;
begin
  Result := oBtrTable.FieldByName('DscPrc1').AsFloat;
end;

procedure TMglstBtr.WriteDscPrc1(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc1').AsFloat := pValue;
end;

function TMglstBtr.ReadDscPrc2:double;
begin
  Result := oBtrTable.FieldByName('DscPrc2').AsFloat;
end;

procedure TMglstBtr.WriteDscPrc2(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc2').AsFloat := pValue;
end;

function TMglstBtr.ReadDscPrc3:double;
begin
  Result := oBtrTable.FieldByName('DscPrc3').AsFloat;
end;

procedure TMglstBtr.WriteDscPrc3(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc3').AsFloat := pValue;
end;

function TMglstBtr.ReadEshop1:byte;
begin
  Result := oBtrTable.FieldByName('Eshop1').AsInteger;
end;

procedure TMglstBtr.WriteEshop1(pValue:byte);
begin
  oBtrTable.FieldByName('Eshop1').AsInteger := pValue;
end;

function TMglstBtr.ReadEshop2:byte;
begin
  Result := oBtrTable.FieldByName('Eshop2').AsInteger;
end;

procedure TMglstBtr.WriteEshop2(pValue:byte);
begin
  oBtrTable.FieldByName('Eshop2').AsInteger := pValue;
end;

function TMglstBtr.ReadEshop3:byte;
begin
  Result := oBtrTable.FieldByName('Eshop3').AsInteger;
end;

procedure TMglstBtr.WriteEshop3(pValue:byte);
begin
  oBtrTable.FieldByName('Eshop3').AsInteger := pValue;
end;

function TMglstBtr.ReadEshop4:byte;
begin
  Result := oBtrTable.FieldByName('Eshop4').AsInteger;
end;

procedure TMglstBtr.WriteEshop4(pValue:byte);
begin
  oBtrTable.FieldByName('Eshop4').AsInteger := pValue;
end;

function TMglstBtr.ReadEshop5:byte;
begin
  Result := oBtrTable.FieldByName('Eshop5').AsInteger;
end;

procedure TMglstBtr.WriteEshop5(pValue:byte);
begin
  oBtrTable.FieldByName('Eshop5').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMglstBtr.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TMglstBtr.LocateMgName (pMgName_:Str15):boolean;
begin
  SetIndex (ixMgName);
  Result := oBtrTable.FindKey([StrToAlias(pMgName_)]);
end;

function TMglstBtr.LocateProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oBtrTable.FindKey([pProfit]);
end;

function TMglstBtr.LocateParent (pParent:longint):boolean;
begin
  SetIndex (ixParent);
  Result := oBtrTable.FindKey([pParent]);
end;

function TMglstBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TMglstBtr.LocateEshop1 (pEshop1:byte):boolean;
begin
  SetIndex (ixEshop1);
  Result := oBtrTable.FindKey([pEshop1]);
end;

function TMglstBtr.LocateEshop2 (pEshop2:byte):boolean;
begin
  SetIndex (ixEshop2);
  Result := oBtrTable.FindKey([pEshop2]);
end;

function TMglstBtr.LocateEshop3 (pEshop3:byte):boolean;
begin
  SetIndex (ixEshop3);
  Result := oBtrTable.FindKey([pEshop3]);
end;

function TMglstBtr.LocateEshop4 (pEshop4:byte):boolean;
begin
  SetIndex (ixEshop4);
  Result := oBtrTable.FindKey([pEshop4]);
end;

function TMglstBtr.LocateEshop5 (pEshop5:byte):boolean;
begin
  SetIndex (ixEshop5);
  Result := oBtrTable.FindKey([pEshop5]);
end;

function TMglstBtr.NearestMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TMglstBtr.NearestMgName (pMgName_:Str15):boolean;
begin
  SetIndex (ixMgName);
  Result := oBtrTable.FindNearest([pMgName_]);
end;

function TMglstBtr.NearestProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oBtrTable.FindNearest([pProfit]);
end;

function TMglstBtr.NearestParent (pParent:longint):boolean;
begin
  SetIndex (ixParent);
  Result := oBtrTable.FindNearest([pParent]);
end;

function TMglstBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TMglstBtr.NearestEshop1 (pEshop1:byte):boolean;
begin
  SetIndex (ixEshop1);
  Result := oBtrTable.FindNearest([pEshop1]);
end;

function TMglstBtr.NearestEshop2 (pEshop2:byte):boolean;
begin
  SetIndex (ixEshop2);
  Result := oBtrTable.FindNearest([pEshop2]);
end;

function TMglstBtr.NearestEshop3 (pEshop3:byte):boolean;
begin
  SetIndex (ixEshop3);
  Result := oBtrTable.FindNearest([pEshop3]);
end;

function TMglstBtr.NearestEshop4 (pEshop4:byte):boolean;
begin
  SetIndex (ixEshop4);
  Result := oBtrTable.FindNearest([pEshop4]);
end;

function TMglstBtr.NearestEshop5 (pEshop5:byte):boolean;
begin
  SetIndex (ixEshop5);
  Result := oBtrTable.FindNearest([pEshop5]);
end;

procedure TMglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TMglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TMglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
