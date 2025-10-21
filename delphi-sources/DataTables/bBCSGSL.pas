unit bBCSGSL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaGs = 'PaGs';
  ixPaSc = 'PaSc';
  ixPaBa = 'PaBa';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixSupCode = 'SupCode';
  ixMgCode = 'MgCode';
  ixGaName = 'GaName';
  ixGuName = 'GuName';

type
  TBcsgslBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSupCode:Str15;         procedure WriteSupCode (pValue:Str15);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadOrdSta:Str1;           procedure WriteOrdSta (pValue:Str1);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadRatDay:longint;        procedure WriteRatDay (pValue:longint);
    function  ReadGaName:Str90;          procedure WriteGaName (pValue:Str90);
    function  ReadGaName_:Str90;         procedure WriteGaName_ (pValue:Str90);
    function  ReadGuName:Str90;          procedure WriteGuName (pValue:Str90);
    function  ReadGuName_:Str90;         procedure WriteGuName_ (pValue:Str90);
    function  ReadMinOsq:double;         procedure WriteMinOsq (pValue:double);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadAprice:double;         procedure WriteAprice (pValue:double);
    function  ReadEplNum:Str15;          procedure WriteEplNum (pValue:Str15);
    function  ReadEplDate:TDatetime;     procedure WriteEplDate (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaSc (pPaCode:longint;pSupCode:Str15):boolean;
    function LocatePaBa (pPaCode:longint;pBarCode:Str15):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSupCode (pSupCode:Str15):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGaName (pGaName_:Str90):boolean;
    function LocateGuName (pGuName_:Str90):boolean;
    function NearestPaGs (pPaCode:longint;pGsCode:longint):boolean;
    function NearestPaSc (pPaCode:longint;pSupCode:Str15):boolean;
    function NearestPaBa (pPaCode:longint;pBarCode:Str15):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str30):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestSupCode (pSupCode:Str15):boolean;
    function NearestMgCode (pMgCode:longint):boolean;
    function NearestGaName (pGaName_:Str90):boolean;
    function NearestGuName (pGuName_:Str90):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SupCode:Str15 read ReadSupCode write WriteSupCode;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property OrdSta:Str1 read ReadOrdSta write WriteOrdSta;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property RatDay:longint read ReadRatDay write WriteRatDay;
    property GaName:Str90 read ReadGaName write WriteGaName;
    property GaName_:Str90 read ReadGaName_ write WriteGaName_;
    property GuName:Str90 read ReadGuName write WriteGuName;
    property GuName_:Str90 read ReadGuName_ write WriteGuName_;
    property MinOsq:double read ReadMinOsq write WriteMinOsq;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property Aprice:double read ReadAprice write WriteAprice;
    property EplNum:Str15 read ReadEplNum write WriteEplNum;
    property EplDate:TDatetime read ReadEplDate write WriteEplDate;
  end;

implementation

constructor TBcsgslBtr.Create;
begin
  oBtrTable := BtrInit ('BCSGSL',gPath.StkPath,Self);
end;

constructor TBcsgslBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('BCSGSL',pPath,Self);
end;

destructor TBcsgslBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TBcsgslBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TBcsgslBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TBcsgslBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TBcsgslBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TBcsgslBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TBcsgslBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TBcsgslBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TBcsgslBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TBcsgslBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TBcsgslBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TBcsgslBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TBcsgslBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TBcsgslBtr.ReadSupCode:Str15;
begin
  Result := oBtrTable.FieldByName('SupCode').AsString;
end;

procedure TBcsgslBtr.WriteSupCode(pValue:Str15);
begin
  oBtrTable.FieldByName('SupCode').AsString := pValue;
end;

function TBcsgslBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TBcsgslBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TBcsgslBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TBcsgslBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBcsgslBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBcsgslBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBcsgslBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBcsgslBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TBcsgslBtr.ReadOrdSta:Str1;
begin
  Result := oBtrTable.FieldByName('OrdSta').AsString;
end;

procedure TBcsgslBtr.WriteOrdSta(pValue:Str1);
begin
  oBtrTable.FieldByName('OrdSta').AsString := pValue;
end;

function TBcsgslBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TBcsgslBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TBcsgslBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBcsgslBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBcsgslBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBcsgslBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TBcsgslBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TBcsgslBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TBcsgslBtr.ReadRatDay:longint;
begin
  Result := oBtrTable.FieldByName('RatDay').AsInteger;
end;

procedure TBcsgslBtr.WriteRatDay(pValue:longint);
begin
  oBtrTable.FieldByName('RatDay').AsInteger := pValue;
end;

function TBcsgslBtr.ReadGaName:Str90;
begin
  Result := oBtrTable.FieldByName('GaName').AsString;
end;

procedure TBcsgslBtr.WriteGaName(pValue:Str90);
begin
  oBtrTable.FieldByName('GaName').AsString := pValue;
end;

function TBcsgslBtr.ReadGaName_:Str90;
begin
  Result := oBtrTable.FieldByName('GaName_').AsString;
end;

procedure TBcsgslBtr.WriteGaName_(pValue:Str90);
begin
  oBtrTable.FieldByName('GaName_').AsString := pValue;
end;

function TBcsgslBtr.ReadGuName:Str90;
begin
  Result := oBtrTable.FieldByName('GuName').AsString;
end;

procedure TBcsgslBtr.WriteGuName(pValue:Str90);
begin
  oBtrTable.FieldByName('GuName').AsString := pValue;
end;

function TBcsgslBtr.ReadGuName_:Str90;
begin
  Result := oBtrTable.FieldByName('GuName_').AsString;
end;

procedure TBcsgslBtr.WriteGuName_(pValue:Str90);
begin
  oBtrTable.FieldByName('GuName_').AsString := pValue;
end;

function TBcsgslBtr.ReadMinOsq:double;
begin
  Result := oBtrTable.FieldByName('MinOsq').AsFloat;
end;

procedure TBcsgslBtr.WriteMinOsq(pValue:double);
begin
  oBtrTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TBcsgslBtr.ReadGrcMth:word;
begin
  Result := oBtrTable.FieldByName('GrcMth').AsInteger;
end;

procedure TBcsgslBtr.WriteGrcMth(pValue:word);
begin
  oBtrTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TBcsgslBtr.ReadAprice:double;
begin
  Result := oBtrTable.FieldByName('Aprice').AsFloat;
end;

procedure TBcsgslBtr.WriteAprice(pValue:double);
begin
  oBtrTable.FieldByName('Aprice').AsFloat := pValue;
end;

function TBcsgslBtr.ReadEplNum:Str15;
begin
  Result := oBtrTable.FieldByName('EplNum').AsString;
end;

procedure TBcsgslBtr.WriteEplNum(pValue:Str15);
begin
  oBtrTable.FieldByName('EplNum').AsString := pValue;
end;

function TBcsgslBtr.ReadEplDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EplDate').AsDateTime;
end;

procedure TBcsgslBtr.WriteEplDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EplDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBcsgslBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBcsgslBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TBcsgslBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBcsgslBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TBcsgslBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TBcsgslBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TBcsgslBtr.LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oBtrTable.FindKey([pPaCode,pGsCode]);
end;

function TBcsgslBtr.LocatePaSc (pPaCode:longint;pSupCode:Str15):boolean;
begin
  SetIndex (ixPaSc);
  Result := oBtrTable.FindKey([pPaCode,pSupCode]);
end;

function TBcsgslBtr.LocatePaBa (pPaCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixPaBa);
  Result := oBtrTable.FindKey([pPaCode,pBarCode]);
end;

function TBcsgslBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TBcsgslBtr.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TBcsgslBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TBcsgslBtr.LocateSupCode (pSupCode:Str15):boolean;
begin
  SetIndex (ixSupCode);
  Result := oBtrTable.FindKey([pSupCode]);
end;

function TBcsgslBtr.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TBcsgslBtr.LocateGaName (pGaName_:Str90):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindKey([StrToAlias(pGaName_)]);
end;

function TBcsgslBtr.LocateGuName (pGuName_:Str90):boolean;
begin
  SetIndex (ixGuName);
  Result := oBtrTable.FindKey([StrToAlias(pGuName_)]);
end;

function TBcsgslBtr.NearestPaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oBtrTable.FindNearest([pPaCode,pGsCode]);
end;

function TBcsgslBtr.NearestPaSc (pPaCode:longint;pSupCode:Str15):boolean;
begin
  SetIndex (ixPaSc);
  Result := oBtrTable.FindNearest([pPaCode,pSupCode]);
end;

function TBcsgslBtr.NearestPaBa (pPaCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixPaBa);
  Result := oBtrTable.FindNearest([pPaCode,pBarCode]);
end;

function TBcsgslBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TBcsgslBtr.NearestGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TBcsgslBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TBcsgslBtr.NearestSupCode (pSupCode:Str15):boolean;
begin
  SetIndex (ixSupCode);
  Result := oBtrTable.FindNearest([pSupCode]);
end;

function TBcsgslBtr.NearestMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TBcsgslBtr.NearestGaName (pGaName_:Str90):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindNearest([pGaName_]);
end;

function TBcsgslBtr.NearestGuName (pGuName_:Str90):boolean;
begin
  SetIndex (ixGuName);
  Result := oBtrTable.FindNearest([pGuName_]);
end;

procedure TBcsgslBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TBcsgslBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TBcsgslBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TBcsgslBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TBcsgslBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TBcsgslBtr.First;
begin
  oBtrTable.First;
end;

procedure TBcsgslBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TBcsgslBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TBcsgslBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TBcsgslBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TBcsgslBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TBcsgslBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TBcsgslBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TBcsgslBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TBcsgslBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TBcsgslBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TBcsgslBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1922001}
