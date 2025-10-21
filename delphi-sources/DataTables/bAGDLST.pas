unit bAGDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaAd = 'PaAd';
  ixPaCode = 'PaCode';
  ixAgdNum = 'AgdNum';
  ixAgdDes = 'AgdDes';

type
  TAgdlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadAgdNum:Str20;          procedure WriteAgdNum (pValue:Str20);
    function  ReadAgdDes:Str90;          procedure WriteAgdDes (pValue:Str90);
    function  ReadAgdDes_:Str90;         procedure WriteAgdDes_ (pValue:Str90);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadIseDay:word;           procedure WriteIseDay (pValue:word);
    function  ReadMinPrf:double;         procedure WriteMinPrf (pValue:double);
    function  ReadSigData:Str60;         procedure WriteSigData (pValue:Str60);
    function  ReadSigName:Str20;         procedure WriteSigName (pValue:Str20);
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
    function LocatePaAd (pPaCode:longint;pAgdNum:Str20):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateAgdNum (pAgdNum:Str20):boolean;
    function LocateAgdDes (pAgdDes_:Str90):boolean;
    function NearestPaAd (pPaCode:longint;pAgdNum:Str20):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestAgdNum (pAgdNum:Str20):boolean;
    function NearestAgdDes (pAgdDes_:Str90):boolean;

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
    property AgdNum:Str20 read ReadAgdNum write WriteAgdNum;
    property AgdDes:Str90 read ReadAgdDes write WriteAgdDes;
    property AgdDes_:Str90 read ReadAgdDes_ write WriteAgdDes_;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property IseDay:word read ReadIseDay write WriteIseDay;
    property MinPrf:double read ReadMinPrf write WriteMinPrf;
    property SigData:Str60 read ReadSigData write WriteSigData;
    property SigName:Str20 read ReadSigName write WriteSigName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAgdlstBtr.Create;
begin
  oBtrTable := BtrInit ('AGDLST',gPath.StkPath,Self);
end;

constructor TAgdlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AGDLST',pPath,Self);
end;

destructor TAgdlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAgdlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAgdlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAgdlstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAgdlstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAgdlstBtr.ReadAgdNum:Str20;
begin
  Result := oBtrTable.FieldByName('AgdNum').AsString;
end;

procedure TAgdlstBtr.WriteAgdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('AgdNum').AsString := pValue;
end;

function TAgdlstBtr.ReadAgdDes:Str90;
begin
  Result := oBtrTable.FieldByName('AgdDes').AsString;
end;

procedure TAgdlstBtr.WriteAgdDes(pValue:Str90);
begin
  oBtrTable.FieldByName('AgdDes').AsString := pValue;
end;

function TAgdlstBtr.ReadAgdDes_:Str90;
begin
  Result := oBtrTable.FieldByName('AgdDes_').AsString;
end;

procedure TAgdlstBtr.WriteAgdDes_(pValue:Str90);
begin
  oBtrTable.FieldByName('AgdDes_').AsString := pValue;
end;

function TAgdlstBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAgdlstBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAgdlstBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAgdlstBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAgdlstBtr.ReadIseDay:word;
begin
  Result := oBtrTable.FieldByName('IseDay').AsInteger;
end;

procedure TAgdlstBtr.WriteIseDay(pValue:word);
begin
  oBtrTable.FieldByName('IseDay').AsInteger := pValue;
end;

function TAgdlstBtr.ReadMinPrf:double;
begin
  Result := oBtrTable.FieldByName('MinPrf').AsFloat;
end;

procedure TAgdlstBtr.WriteMinPrf(pValue:double);
begin
  oBtrTable.FieldByName('MinPrf').AsFloat := pValue;
end;

function TAgdlstBtr.ReadSigData:Str60;
begin
  Result := oBtrTable.FieldByName('SigData').AsString;
end;

procedure TAgdlstBtr.WriteSigData(pValue:Str60);
begin
  oBtrTable.FieldByName('SigData').AsString := pValue;
end;

function TAgdlstBtr.ReadSigName:Str20;
begin
  Result := oBtrTable.FieldByName('SigName').AsString;
end;

procedure TAgdlstBtr.WriteSigName(pValue:Str20);
begin
  oBtrTable.FieldByName('SigName').AsString := pValue;
end;

function TAgdlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAgdlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAgdlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAgdlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAgdlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAgdlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAgdlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAgdlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAgdlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAgdlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAgdlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAgdlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAgdlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAgdlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAgdlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAgdlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAgdlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAgdlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAgdlstBtr.LocatePaAd (pPaCode:longint;pAgdNum:Str20):boolean;
begin
  SetIndex (ixPaAd);
  Result := oBtrTable.FindKey([pPaCode,pAgdNum]);
end;

function TAgdlstBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAgdlstBtr.LocateAgdNum (pAgdNum:Str20):boolean;
begin
  SetIndex (ixAgdNum);
  Result := oBtrTable.FindKey([pAgdNum]);
end;

function TAgdlstBtr.LocateAgdDes (pAgdDes_:Str90):boolean;
begin
  SetIndex (ixAgdDes);
  Result := oBtrTable.FindKey([StrToAlias(pAgdDes_)]);
end;

function TAgdlstBtr.NearestPaAd (pPaCode:longint;pAgdNum:Str20):boolean;
begin
  SetIndex (ixPaAd);
  Result := oBtrTable.FindNearest([pPaCode,pAgdNum]);
end;

function TAgdlstBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAgdlstBtr.NearestAgdNum (pAgdNum:Str20):boolean;
begin
  SetIndex (ixAgdNum);
  Result := oBtrTable.FindNearest([pAgdNum]);
end;

function TAgdlstBtr.NearestAgdDes (pAgdDes_:Str90):boolean;
begin
  SetIndex (ixAgdDes);
  Result := oBtrTable.FindNearest([pAgdDes_]);
end;

procedure TAgdlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAgdlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAgdlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAgdlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAgdlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAgdlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAgdlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAgdlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAgdlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAgdlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAgdlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAgdlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAgdlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAgdlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAgdlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAgdlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAgdlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1915001}
