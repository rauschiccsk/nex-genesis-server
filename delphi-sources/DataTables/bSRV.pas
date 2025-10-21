unit bSRV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSrvCode = 'SrvCode';
  ixGsName = 'GsName';
  ixNGsCode = 'NGsCode';

type
  TSrvBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSrvCode:longint;       procedure WriteSrvCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadDaily:Str1;            procedure WriteDaily (pValue:Str1);
    function  ReadQntMod:Str1;           procedure WriteQntMod (pValue:Str1);
    function  ReadNGsCode:longint;       procedure WriteNGsCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadDvzName:Str3;          procedure WriteDvzName (pValue:Str3);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSrvCode (pSrvCode:longint):boolean;
    function LocateGsName (pGsName_:Str15):boolean;
    function LocateNGsCode (pNGsCode:longint):boolean;
    function NearestSrvCode (pSrvCode:longint):boolean;
    function NearestGsName (pGsName_:Str15):boolean;
    function NearestNGsCode (pNGsCode:longint):boolean;

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
    property SrvCode:longint read ReadSrvCode write WriteSrvCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Daily:Str1 read ReadDaily write WriteDaily;
    property QntMod:Str1 read ReadQntMod write WriteQntMod;
    property NGsCode:longint read ReadNGsCode write WriteNGsCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos1:longint read ReadActPos write WriteActPos;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
  end;

implementation

constructor TSrvBtr.Create;
begin
  oBtrTable := BtrInit ('SRV',gPath.HtlPath,Self);
end;

constructor TSrvBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SRV',pPath,Self);
end;

destructor TSrvBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSrvBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSrvBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSrvBtr.ReadSrvCode:longint;
begin
  Result := oBtrTable.FieldByName('SrvCode').AsInteger;
end;

procedure TSrvBtr.WriteSrvCode(pValue:longint);
begin
  oBtrTable.FieldByName('SrvCode').AsInteger := pValue;
end;

function TSrvBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrvBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrvBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSrvBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSrvBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TSrvBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TSrvBtr.ReadVatPrc:double;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsFloat;
end;

procedure TSrvBtr.WriteVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TSrvBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TSrvBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TSrvBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TSrvBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TSrvBtr.ReadDaily:Str1;
begin
  Result := oBtrTable.FieldByName('Daily').AsString;
end;

procedure TSrvBtr.WriteDaily(pValue:Str1);
begin
  oBtrTable.FieldByName('Daily').AsString := pValue;
end;

function TSrvBtr.ReadQntMod:Str1;
begin
  Result := oBtrTable.FieldByName('QntMod').AsString;
end;

procedure TSrvBtr.WriteQntMod(pValue:Str1);
begin
  oBtrTable.FieldByName('QntMod').AsString := pValue;
end;

function TSrvBtr.ReadNGsCode:longint;
begin
  Result := oBtrTable.FieldByName('NGsCode').AsInteger;
end;

procedure TSrvBtr.WriteNGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('NGsCode').AsInteger := pValue;
end;

function TSrvBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TSrvBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TSrvBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSrvBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrvBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrvBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrvBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrvBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrvBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSrvBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrvBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrvBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrvBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrvBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSrvBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TSrvBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TSrvBtr.ReadDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('DvzName').AsString;
end;

procedure TSrvBtr.WriteDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrvBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrvBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSrvBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrvBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSrvBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSrvBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSrvBtr.LocateSrvCode (pSrvCode:longint):boolean;
begin
  SetIndex (ixSrvCode);
  Result := oBtrTable.FindKey([pSrvCode]);
end;

function TSrvBtr.LocateGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TSrvBtr.LocateNGsCode (pNGsCode:longint):boolean;
begin
  SetIndex (ixNGsCode);
  Result := oBtrTable.FindKey([pNGsCode]);
end;

function TSrvBtr.NearestSrvCode (pSrvCode:longint):boolean;
begin
  SetIndex (ixSrvCode);
  Result := oBtrTable.FindNearest([pSrvCode]);
end;

function TSrvBtr.NearestGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TSrvBtr.NearestNGsCode (pNGsCode:longint):boolean;
begin
  SetIndex (ixNGsCode);
  Result := oBtrTable.FindNearest([pNGsCode]);
end;

procedure TSrvBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSrvBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSrvBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSrvBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSrvBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSrvBtr.First;
begin
  oBtrTable.First;
end;

procedure TSrvBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSrvBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSrvBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSrvBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSrvBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSrvBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSrvBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSrvBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSrvBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSrvBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSrvBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
