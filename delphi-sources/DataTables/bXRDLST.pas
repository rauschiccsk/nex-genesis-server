unit bXRDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDat = 'DocDat';

type
  TXrdlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadMthNum:byte;           procedure WriteMthNum (pValue:byte);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:Str60;          procedure WriteStkNum (pValue:Str60);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadXlsNam:Str30;          procedure WriteXlsNam (pValue:Str30);
    function  ReadBegDat1:TDatetime;     procedure WriteBegDat1 (pValue:TDatetime);
    function  ReadEndDat1:TDatetime;     procedure WriteEndDat1 (pValue:TDatetime);
    function  ReadBegDat2:TDatetime;     procedure WriteBegDat2 (pValue:TDatetime);
    function  ReadEndDat2:TDatetime;     procedure WriteEndDat2 (pValue:TDatetime);
    function  ReadBegDat3:TDatetime;     procedure WriteBegDat3 (pValue:TDatetime);
    function  ReadEndDat3:TDatetime;     procedure WriteEndDat3 (pValue:TDatetime);
    function  ReadBegDat4:TDatetime;     procedure WriteBegDat4 (pValue:TDatetime);
    function  ReadEndDat4:TDatetime;     procedure WriteEndDat4 (pValue:TDatetime);
    function  ReadBegDat5:TDatetime;     procedure WriteBegDat5 (pValue:TDatetime);
    function  ReadEndDat5:TDatetime;     procedure WriteEndDat5 (pValue:TDatetime);
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
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDat (pDocDat:TDatetime):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDat (pDocDat:TDatetime):boolean;

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
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property MthNum:byte read ReadMthNum write WriteMthNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:Str60 read ReadStkNum write WriteStkNum;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property XlsNam:Str30 read ReadXlsNam write WriteXlsNam;
    property BegDat1:TDatetime read ReadBegDat1 write WriteBegDat1;
    property EndDat1:TDatetime read ReadEndDat1 write WriteEndDat1;
    property BegDat2:TDatetime read ReadBegDat2 write WriteBegDat2;
    property EndDat2:TDatetime read ReadEndDat2 write WriteEndDat2;
    property BegDat3:TDatetime read ReadBegDat3 write WriteBegDat3;
    property EndDat3:TDatetime read ReadEndDat3 write WriteEndDat3;
    property BegDat4:TDatetime read ReadBegDat4 write WriteBegDat4;
    property EndDat4:TDatetime read ReadEndDat4 write WriteEndDat4;
    property BegDat5:TDatetime read ReadBegDat5 write WriteBegDat5;
    property EndDat5:TDatetime read ReadEndDat5 write WriteEndDat5;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TXrdlstBtr.Create;
begin
  oBtrTable := BtrInit ('XRDLST',gPath.StkPath,Self);
end;

constructor TXrdlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('XRDLST',pPath,Self);
end;

destructor TXrdlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TXrdlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TXrdlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TXrdlstBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TXrdlstBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TXrdlstBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TXrdlstBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TXrdlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TXrdlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TXrdlstBtr.ReadExtNum:Str20;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TXrdlstBtr.WriteExtNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TXrdlstBtr.ReadDocDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDat').AsDateTime;
end;

procedure TXrdlstBtr.WriteDocDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadMthNum:byte;
begin
  Result := oBtrTable.FieldByName('MthNum').AsInteger;
end;

procedure TXrdlstBtr.WriteMthNum(pValue:byte);
begin
  oBtrTable.FieldByName('MthNum').AsInteger := pValue;
end;

function TXrdlstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TXrdlstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TXrdlstBtr.ReadStkNum:Str60;
begin
  Result := oBtrTable.FieldByName('StkNum').AsString;
end;

procedure TXrdlstBtr.WriteStkNum(pValue:Str60);
begin
  oBtrTable.FieldByName('StkNum').AsString := pValue;
end;

function TXrdlstBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TXrdlstBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TXrdlstBtr.ReadXlsNam:Str30;
begin
  Result := oBtrTable.FieldByName('XlsNam').AsString;
end;

procedure TXrdlstBtr.WriteXlsNam(pValue:Str30);
begin
  oBtrTable.FieldByName('XlsNam').AsString := pValue;
end;

function TXrdlstBtr.ReadBegDat1:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat1').AsDateTime;
end;

procedure TXrdlstBtr.WriteBegDat1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat1').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadEndDat1:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat1').AsDateTime;
end;

procedure TXrdlstBtr.WriteEndDat1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat1').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadBegDat2:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat2').AsDateTime;
end;

procedure TXrdlstBtr.WriteBegDat2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat2').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadEndDat2:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat2').AsDateTime;
end;

procedure TXrdlstBtr.WriteEndDat2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat2').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadBegDat3:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat3').AsDateTime;
end;

procedure TXrdlstBtr.WriteBegDat3(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat3').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadEndDat3:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat3').AsDateTime;
end;

procedure TXrdlstBtr.WriteEndDat3(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat3').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadBegDat4:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat4').AsDateTime;
end;

procedure TXrdlstBtr.WriteBegDat4(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat4').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadEndDat4:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat4').AsDateTime;
end;

procedure TXrdlstBtr.WriteEndDat4(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat4').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadBegDat5:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat5').AsDateTime;
end;

procedure TXrdlstBtr.WriteBegDat5(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat5').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadEndDat5:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat5').AsDateTime;
end;

procedure TXrdlstBtr.WriteEndDat5(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat5').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TXrdlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TXrdlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TXrdlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TXrdlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TXrdlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TXrdlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TXrdlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TXrdlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TXrdlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrdlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrdlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TXrdlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrdlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TXrdlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TXrdlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TXrdlstBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TXrdlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TXrdlstBtr.LocateDocDat (pDocDat:TDatetime):boolean;
begin
  SetIndex (ixDocDat);
  Result := oBtrTable.FindKey([pDocDat]);
end;

function TXrdlstBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TXrdlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TXrdlstBtr.NearestDocDat (pDocDat:TDatetime):boolean;
begin
  SetIndex (ixDocDat);
  Result := oBtrTable.FindNearest([pDocDat]);
end;

procedure TXrdlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TXrdlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TXrdlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TXrdlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TXrdlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TXrdlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TXrdlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TXrdlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TXrdlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TXrdlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TXrdlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TXrdlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TXrdlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TXrdlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TXrdlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TXrdlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TXrdlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1922001}
