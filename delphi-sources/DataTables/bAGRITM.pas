unit bAGRITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAnPaGs = 'AnPaGs';
  ixPaGs = 'PaGs';
  ixPaCode = 'PaCode';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixSended = 'Sended';

type
  TAgritmBtr = class (TComponent)
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
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGscKfc:double;         procedure WriteGscKfc (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadDvzName:Str3;          procedure WriteDvzName (pValue:Str3);
    function  ReadCsName:Str60;          procedure WriteCsName (pValue:Str60);
    function  ReadCsCode:Str15;          procedure WriteCsCode (pValue:Str15);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
//    function  ReadMinPrf:double;         procedure WriteMinPrf (pValue:double);
    function  ReadAgdNum:Str20;          procedure WriteAgdNum (pValue:Str20);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateAnPaGs (pAgdNum:Str20;pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestAnPaGs (pAgdNum:Str20;pPaCode:longint;pGsCode:longint):boolean;
    function NearestPaGs (pPaCode:longint;pGsCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str20):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GscKfc:double read ReadGscKfc write WriteGscKfc;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
    property CsName:Str60 read ReadCsName write WriteCsName;
    property CsCode:Str15 read ReadCsCode write WriteCsCode;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DscType:Str1 read ReadDscType write WriteDscType;
//    property MinPrf:double read ReadMinPrf write WriteMinPrf;
    property AgdNum:Str20 read ReadAgdNum write WriteAgdNum;
  end;

implementation

constructor TAgritmBtr.Create;
begin
  oBtrTable := BtrInit ('AGRITM',gPath.StkPath,Self);
end;

constructor TAgritmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AGRITM',pPath,Self);
end;

destructor TAgritmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAgritmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAgritmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAgritmBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAgritmBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAgritmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TAgritmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAgritmBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TAgritmBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TAgritmBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TAgritmBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TAgritmBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TAgritmBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TAgritmBtr.ReadGscKfc:double;
begin
  Result := oBtrTable.FieldByName('GscKfc').AsFloat;
end;

procedure TAgritmBtr.WriteGscKfc(pValue:double);
begin
  oBtrTable.FieldByName('GscKfc').AsFloat := pValue;
end;

function TAgritmBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TAgritmBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TAgritmBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TAgritmBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TAgritmBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TAgritmBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TAgritmBtr.ReadDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('DvzName').AsString;
end;

procedure TAgritmBtr.WriteDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzName').AsString := pValue;
end;

function TAgritmBtr.ReadCsName:Str60;
begin
  Result := oBtrTable.FieldByName('CsName').AsString;
end;

procedure TAgritmBtr.WriteCsName(pValue:Str60);
begin
  oBtrTable.FieldByName('CsName').AsString := pValue;
end;

function TAgritmBtr.ReadCsCode:Str15;
begin
  Result := oBtrTable.FieldByName('CsCode').AsString;
end;

procedure TAgritmBtr.WriteCsCode(pValue:Str15);
begin
  oBtrTable.FieldByName('CsCode').AsString := pValue;
end;

function TAgritmBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TAgritmBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TAgritmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAgritmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAgritmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAgritmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAgritmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAgritmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAgritmBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TAgritmBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAgritmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAgritmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAgritmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAgritmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAgritmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAgritmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAgritmBtr.ReadDscType:Str1;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TAgritmBtr.WriteDscType(pValue:Str1);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;
(*
function TAgritmBtr.ReadMinPrf:double;
begin
  Result := oBtrTable.FieldByName('MinPrf').AsFloat;
end;

procedure TAgritmBtr.WriteMinPrf(pValue:double);
begin
  oBtrTable.FieldByName('MinPrf').AsFloat := pValue;
end;
*)
function TAgritmBtr.ReadAgdNum:Str20;
begin
  Result := oBtrTable.FieldByName('AgdNum').AsString;
end;

procedure TAgritmBtr.WriteAgdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('AgdNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAgritmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAgritmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAgritmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAgritmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAgritmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAgritmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAgritmBtr.LocateAnPaGs (pAgdNum:Str20;pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixAnPaGs);
  Result := oBtrTable.FindKey([pAgdNum,pPaCode,pGsCode]);
end;

function TAgritmBtr.LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oBtrTable.FindKey([pPaCode,pGsCode]);
end;

function TAgritmBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAgritmBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TAgritmBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TAgritmBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TAgritmBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TAgritmBtr.NearestAnPaGs (pAgdNum:Str20;pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixAnPaGs);
  Result := oBtrTable.FindNearest([pAgdNum,pPaCode,pGsCode]);
end;

function TAgritmBtr.NearestPaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oBtrTable.FindNearest([pPaCode,pGsCode]);
end;

function TAgritmBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAgritmBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TAgritmBtr.NearestGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TAgritmBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TAgritmBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TAgritmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAgritmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAgritmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAgritmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAgritmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAgritmBtr.First;
begin
  oBtrTable.First;
end;

procedure TAgritmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAgritmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAgritmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAgritmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAgritmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAgritmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAgritmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAgritmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAgritmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAgritmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAgritmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1915001}
