unit bBCSPAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixRegIno = 'RegIno';
  ixSended = 'Sended';

type
  TBcspalBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadSmlName:Str10;         procedure WriteSmlName (pValue:Str10);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadItmQmt:word;           procedure WriteItmQmt (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadReliab:longint;        procedure WriteReliab (pValue:longint);
    function  ReadRatDay:longint;        procedure WriteRatDay (pValue:longint);
    function  ReadOsdVal:double;         procedure WriteOsdVal (pValue:double);
    function  ReadPayDsc:double;         procedure WritePayDsc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateRegIno (pRegIno:Str15):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestRegIno (pRegIno:Str15):boolean;
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
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property SmlName:Str10 read ReadSmlName write WriteSmlName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property ItmQmt:word read ReadItmQmt write WriteItmQmt;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property Reliab:longint read ReadReliab write WriteReliab;
    property RatDay:longint read ReadRatDay write WriteRatDay;
    property OsdVal:double read ReadOsdVal write WriteOsdVal;
    property PayDsc:double read ReadPayDsc write WritePayDsc;
  end;

implementation

constructor TBcspalBtr.Create;
begin
  oBtrTable := BtrInit ('BCSPAL',gPath.StkPath,Self);
end;

constructor TBcspalBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('BCSPAL',pPath,Self);
end;

destructor TBcspalBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TBcspalBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TBcspalBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TBcspalBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TBcspalBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TBcspalBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TBcspalBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TBcspalBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TBcspalBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TBcspalBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TBcspalBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TBcspalBtr.ReadSmlName:Str10;
begin
  Result := oBtrTable.FieldByName('SmlName').AsString;
end;

procedure TBcspalBtr.WriteSmlName(pValue:Str10);
begin
  oBtrTable.FieldByName('SmlName').AsString := pValue;
end;

function TBcspalBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TBcspalBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TBcspalBtr.ReadItmQmt:word;
begin
  Result := oBtrTable.FieldByName('ItmQmt').AsInteger;
end;

procedure TBcspalBtr.WriteItmQmt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQmt').AsInteger := pValue;
end;

function TBcspalBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TBcspalBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TBcspalBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TBcspalBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBcspalBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBcspalBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBcspalBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBcspalBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TBcspalBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TBcspalBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TBcspalBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TBcspalBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TBcspalBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBcspalBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBcspalBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBcspalBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TBcspalBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TBcspalBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TBcspalBtr.ReadReliab:longint;
begin
  Result := oBtrTable.FieldByName('Reliab').AsInteger;
end;

procedure TBcspalBtr.WriteReliab(pValue:longint);
begin
  oBtrTable.FieldByName('Reliab').AsInteger := pValue;
end;

function TBcspalBtr.ReadRatDay:longint;
begin
  Result := oBtrTable.FieldByName('RatDay').AsInteger;
end;

procedure TBcspalBtr.WriteRatDay(pValue:longint);
begin
  oBtrTable.FieldByName('RatDay').AsInteger := pValue;
end;

function TBcspalBtr.ReadOsdVal:double;
begin
  Result := oBtrTable.FieldByName('OsdVal').AsFloat;
end;

procedure TBcspalBtr.WriteOsdVal(pValue:double);
begin
  oBtrTable.FieldByName('OsdVal').AsFloat := pValue;
end;

function TBcspalBtr.ReadPayDsc:double;
begin
  Result := oBtrTable.FieldByName('PayDsc').AsFloat;
end;

procedure TBcspalBtr.WritePayDsc(pValue:double);
begin
  oBtrTable.FieldByName('PayDsc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBcspalBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBcspalBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TBcspalBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBcspalBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TBcspalBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TBcspalBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TBcspalBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TBcspalBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TBcspalBtr.LocateRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindKey([pRegIno]);
end;

function TBcspalBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TBcspalBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TBcspalBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TBcspalBtr.NearestRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindNearest([pRegIno]);
end;

function TBcspalBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TBcspalBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TBcspalBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TBcspalBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TBcspalBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TBcspalBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TBcspalBtr.First;
begin
  oBtrTable.First;
end;

procedure TBcspalBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TBcspalBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TBcspalBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TBcspalBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TBcspalBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TBcspalBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TBcspalBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TBcspalBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TBcspalBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TBcspalBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TBcspalBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1908001}
