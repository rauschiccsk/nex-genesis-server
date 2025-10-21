unit bTPC;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixSndNum = 'SndNum';
  ixStatus = 'Status';

type
  TTpcBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDelUser:Str8;          procedure WriteDelUser (pValue:Str8);
    function  ReadDelDate:TDatetime;     procedure WriteDelDate (pValue:TDatetime);
    function  ReadDelTime:TDatetime;     procedure WriteDelTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSndNum (pSndNum:word):boolean;
    function LocateStatus (pStatus:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pLstNum:word);         
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DelUser:Str8 read ReadDelUser write WriteDelUser;
    property DelDate:TDatetime read ReadDelDate write WriteDelDate;
    property DelTime:TDatetime read ReadDelTime write WriteDelTime;
  end;

implementation

constructor TTpcBtr.Create;
begin
  oBtrTable := BtrInit ('TPC',gPath.StkPath,Self);
end;

destructor  TTpcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTpcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTpcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTpcBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTpcBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTpcBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTpcBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTpcBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TTpcBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TTpcBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTpcBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTpcBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TTpcBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TTpcBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TTpcBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TTpcBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TTpcBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TTpcBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TTpcBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TTpcBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTpcBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TTpcBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TTpcBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TTpcBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TTpcBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TTpcBtr.ReadSndNum:word;
begin
  Result := oBtrTable.FieldByName('SndNum').AsInteger;
end;

procedure TTpcBtr.WriteSndNum(pValue:word);
begin
  oBtrTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TTpcBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTpcBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTpcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTpcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTpcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTpcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTpcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTpcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTpcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTpcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTpcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTpcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTpcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTpcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTpcBtr.ReadDelUser:Str8;
begin
  Result := oBtrTable.FieldByName('DelUser').AsString;
end;

procedure TTpcBtr.WriteDelUser(pValue:Str8);
begin
  oBtrTable.FieldByName('DelUser').AsString := pValue;
end;

function TTpcBtr.ReadDelDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DelDate').AsDateTime;
end;

procedure TTpcBtr.WriteDelDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DelDate').AsDateTime := pValue;
end;

function TTpcBtr.ReadDelTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('DelTime').AsDateTime;
end;

procedure TTpcBtr.WriteDelTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DelTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTpcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTpcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTpcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTpcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTpcBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTpcBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([pGsName_]);
end;

function TTpcBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TTpcBtr.LocateSndNum (pSndNum:word):boolean;
begin
  SetIndex (ixSndNum);
  Result := oBtrTable.FindKey([pSndNum]);
end;

function TTpcBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

procedure TTpcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTpcBtr.Open(pLstNum:word);
begin
  oBtrTable.Open(pLstNum);
end;

procedure TTpcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTpcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTpcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTpcBtr.First;
begin
  oBtrTable.First;
end;

procedure TTpcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTpcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTpcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTpcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTpcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTpcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTpcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTpcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTpcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTpcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTpcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
