unit bXRH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';

type
  TXrhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPerName1:Str30;        procedure WritePerName1 (pValue:Str30);
    function  ReadBegDate1:TDatetime;    procedure WriteBegDate1 (pValue:TDatetime);
    function  ReadEndDate1:TDatetime;    procedure WriteEndDate1 (pValue:TDatetime);
    function  ReadPerName2:Str30;        procedure WritePerName2 (pValue:Str30);
    function  ReadBegDate2:TDatetime;    procedure WriteBegDate2 (pValue:TDatetime);
    function  ReadEndDate2:TDatetime;    procedure WriteEndDate2 (pValue:TDatetime);
    function  ReadPerName3:Str30;        procedure WritePerName3 (pValue:Str30);
    function  ReadBegDate3:TDatetime;    procedure WriteBegDate3 (pValue:TDatetime);
    function  ReadEndDate3:TDatetime;    procedure WriteEndDate3 (pValue:TDatetime);
    function  ReadPerName4:Str30;        procedure WritePerName4 (pValue:Str30);
    function  ReadBegDate4:TDatetime;    procedure WriteBegDate4 (pValue:TDatetime);
    function  ReadEndDate4:TDatetime;    procedure WriteEndDate4 (pValue:TDatetime);
    function  ReadPerName5:Str30;        procedure WritePerName5 (pValue:Str30);
    function  ReadBegDate5:TDatetime;    procedure WriteBegDate5 (pValue:TDatetime);
    function  ReadEndDate5:TDatetime;    procedure WriteEndDate5 (pValue:TDatetime);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadXlsName:Str30;         procedure WriteXlsName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PerName1:Str30 read ReadPerName1 write WritePerName1;
    property BegDate1:TDatetime read ReadBegDate1 write WriteBegDate1;
    property EndDate1:TDatetime read ReadEndDate1 write WriteEndDate1;
    property PerName2:Str30 read ReadPerName2 write WritePerName2;
    property BegDate2:TDatetime read ReadBegDate2 write WriteBegDate2;
    property EndDate2:TDatetime read ReadEndDate2 write WriteEndDate2;
    property PerName3:Str30 read ReadPerName3 write WritePerName3;
    property BegDate3:TDatetime read ReadBegDate3 write WriteBegDate3;
    property EndDate3:TDatetime read ReadEndDate3 write WriteEndDate3;
    property PerName4:Str30 read ReadPerName4 write WritePerName4;
    property BegDate4:TDatetime read ReadBegDate4 write WriteBegDate4;
    property EndDate4:TDatetime read ReadEndDate4 write WriteEndDate4;
    property PerName5:Str30 read ReadPerName5 write WritePerName5;
    property BegDate5:TDatetime read ReadBegDate5 write WriteBegDate5;
    property EndDate5:TDatetime read ReadEndDate5 write WriteEndDate5;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property XlsName:Str30 read ReadXlsName write WriteXlsName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TXrhBtr.Create;
begin
  oBtrTable := BtrInit ('XRH',gPath.StkPath,Self);
end;

constructor TXrhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('XRH',pPath,Self);
end;

destructor TXrhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TXrhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TXrhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TXrhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TXrhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TXrhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TXrhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TXrhBtr.ReadExtNum:Str20;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TXrhBtr.WriteExtNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TXrhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TXrhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TXrhBtr.ReadPerName1:Str30;
begin
  Result := oBtrTable.FieldByName('PerName1').AsString;
end;

procedure TXrhBtr.WritePerName1(pValue:Str30);
begin
  oBtrTable.FieldByName('PerName1').AsString := pValue;
end;

function TXrhBtr.ReadBegDate1:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate1').AsDateTime;
end;

procedure TXrhBtr.WriteBegDate1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate1').AsDateTime := pValue;
end;

function TXrhBtr.ReadEndDate1:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate1').AsDateTime;
end;

procedure TXrhBtr.WriteEndDate1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate1').AsDateTime := pValue;
end;

function TXrhBtr.ReadPerName2:Str30;
begin
  Result := oBtrTable.FieldByName('PerName2').AsString;
end;

procedure TXrhBtr.WritePerName2(pValue:Str30);
begin
  oBtrTable.FieldByName('PerName2').AsString := pValue;
end;

function TXrhBtr.ReadBegDate2:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate2').AsDateTime;
end;

procedure TXrhBtr.WriteBegDate2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate2').AsDateTime := pValue;
end;

function TXrhBtr.ReadEndDate2:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate2').AsDateTime;
end;

procedure TXrhBtr.WriteEndDate2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate2').AsDateTime := pValue;
end;

function TXrhBtr.ReadPerName3:Str30;
begin
  Result := oBtrTable.FieldByName('PerName3').AsString;
end;

procedure TXrhBtr.WritePerName3(pValue:Str30);
begin
  oBtrTable.FieldByName('PerName3').AsString := pValue;
end;

function TXrhBtr.ReadBegDate3:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate3').AsDateTime;
end;

procedure TXrhBtr.WriteBegDate3(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate3').AsDateTime := pValue;
end;

function TXrhBtr.ReadEndDate3:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate3').AsDateTime;
end;

procedure TXrhBtr.WriteEndDate3(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate3').AsDateTime := pValue;
end;

function TXrhBtr.ReadPerName4:Str30;
begin
  Result := oBtrTable.FieldByName('PerName4').AsString;
end;

procedure TXrhBtr.WritePerName4(pValue:Str30);
begin
  oBtrTable.FieldByName('PerName4').AsString := pValue;
end;

function TXrhBtr.ReadBegDate4:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate4').AsDateTime;
end;

procedure TXrhBtr.WriteBegDate4(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate4').AsDateTime := pValue;
end;

function TXrhBtr.ReadEndDate4:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate4').AsDateTime;
end;

procedure TXrhBtr.WriteEndDate4(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate4').AsDateTime := pValue;
end;

function TXrhBtr.ReadPerName5:Str30;
begin
  Result := oBtrTable.FieldByName('PerName5').AsString;
end;

procedure TXrhBtr.WritePerName5(pValue:Str30);
begin
  oBtrTable.FieldByName('PerName5').AsString := pValue;
end;

function TXrhBtr.ReadBegDate5:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate5').AsDateTime;
end;

procedure TXrhBtr.WriteBegDate5(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate5').AsDateTime := pValue;
end;

function TXrhBtr.ReadEndDate5:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate5').AsDateTime;
end;

procedure TXrhBtr.WriteEndDate5(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate5').AsDateTime := pValue;
end;

function TXrhBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TXrhBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TXrhBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TXrhBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TXrhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TXrhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TXrhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TXrhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TXrhBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TXrhBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TXrhBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TXrhBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TXrhBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TXrhBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TXrhBtr.ReadXlsName:Str30;
begin
  Result := oBtrTable.FieldByName('XlsName').AsString;
end;

procedure TXrhBtr.WriteXlsName(pValue:Str30);
begin
  oBtrTable.FieldByName('XlsName').AsString := pValue;
end;

function TXrhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TXrhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TXrhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TXrhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TXrhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TXrhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TXrhBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TXrhBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TXrhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TXrhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TXrhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TXrhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TXrhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TXrhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TXrhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TXrhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TXrhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TXrhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TXrhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TXrhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TXrhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TXrhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TXrhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TXrhBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TXrhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TXrhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TXrhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TXrhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TXrhBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

procedure TXrhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TXrhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TXrhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TXrhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TXrhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TXrhBtr.First;
begin
  oBtrTable.First;
end;

procedure TXrhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TXrhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TXrhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TXrhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TXrhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TXrhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TXrhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TXrhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TXrhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TXrhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TXrhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
