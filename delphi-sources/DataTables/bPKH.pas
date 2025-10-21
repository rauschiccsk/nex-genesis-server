unit bPKH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixStSn = 'StSn';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixOcdNum = 'OcdNum';
  ixSended = 'Sended';

type
  TPkhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  Readx_Status1:Str1;        procedure Writex_Status1 (pValue:Str1);
    function  Readx_Status2:Str1;        procedure Writex_Status2 (pValue:Str1);
    function  Readx_Status3:Str1;        procedure Writex_Status3 (pValue:Str1);
    function  Readx_Status4:Str1;        procedure Writex_Status4 (pValue:Str1);
    function  Readx_Status5:Str1;        procedure Writex_Status5 (pValue:Str1);
    function  Readx_Status6:Str1;        procedure Writex_Status6 (pValue:Str1);
    function  Readx_Status7:Str1;        procedure Writex_Status7 (pValue:Str1);
    function  Readx_Status8:Str1;        procedure Writex_Status8 (pValue:Str1);
    function  Readx_Status9:Str1;        procedure Writex_Status9 (pValue:Str1);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  Readx_Status12:Str1;       procedure Writex_Status12 (pValue:Str1);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  Readx_SItemQnt:word;       procedure Writex_SItemQnt (pValue:word);
    function  Readx_LItemQnt:word;       procedure Writex_LItemQnt (pValue:word);
    function  ReadDstLck:boolean;        procedure WriteDstLck (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOcdNum:Str20;          procedure WriteOcdNum (pValue:Str20);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  Readx_SSmName:Str30;       procedure Writex_SSmName (pValue:Str30);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  Readx_DSmName:Str30;       procedure Writex_DSmName (pValue:Str30);
    function  Readx_AccMth:Str4;         procedure Writex_AccMth (pValue:Str4);
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
    function LocateStSn (pStkNum:word;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateOcdNum (pOcdNum:Str20):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestStSn (pStkNum:word;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestOcdNum (pOcdNum:Str20):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property x_Status1:Str1 read Readx_Status1 write Writex_Status1;
    property x_Status2:Str1 read Readx_Status2 write Writex_Status2;
    property x_Status3:Str1 read Readx_Status3 write Writex_Status3;
    property x_Status4:Str1 read Readx_Status4 write Writex_Status4;
    property x_Status5:Str1 read Readx_Status5 write Writex_Status5;
    property x_Status6:Str1 read Readx_Status6 write Writex_Status6;
    property x_Status7:Str1 read Readx_Status7 write Writex_Status7;
    property x_Status8:Str1 read Readx_Status8 write Writex_Status8;
    property x_Status9:Str1 read Readx_Status9 write Writex_Status9;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property Sended:boolean read ReadSended write WriteSended;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property x_Status12:Str1 read Readx_Status12 write Writex_Status12;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property x_SItemQnt:word read Readx_SItemQnt write Writex_SItemQnt;
    property x_LItemQnt:word read Readx_LItemQnt write Writex_LItemQnt;
    property DstLck:boolean read ReadDstLck write WriteDstLck;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OcdNum:Str20 read ReadOcdNum write WriteOcdNum;
    property ActPosM:longint read ReadActPos write WriteActPos;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property x_SSmName:Str30 read Readx_SSmName write Writex_SSmName;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property x_DSmName:Str30 read Readx_DSmName write Writex_DSmName;
    property x_AccMth:Str4 read Readx_AccMth write Writex_AccMth;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TPkhBtr.Create;
begin
  oBtrTable := BtrInit ('PKH',gPath.StkPath,Self);
end;

constructor TPkhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PKH',pPath,Self);
end;

destructor TPkhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPkhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPkhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPkhBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPkhBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPkhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPkhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPkhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPkhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPkhBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TPkhBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TPkhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPkhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPkhBtr.Readx_Status1:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status1').AsString;
end;

procedure TPkhBtr.Writex_Status1(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status1').AsString := pValue;
end;

function TPkhBtr.Readx_Status2:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status2').AsString;
end;

procedure TPkhBtr.Writex_Status2(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status2').AsString := pValue;
end;

function TPkhBtr.Readx_Status3:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status3').AsString;
end;

procedure TPkhBtr.Writex_Status3(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status3').AsString := pValue;
end;

function TPkhBtr.Readx_Status4:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status4').AsString;
end;

procedure TPkhBtr.Writex_Status4(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status4').AsString := pValue;
end;

function TPkhBtr.Readx_Status5:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status5').AsString;
end;

procedure TPkhBtr.Writex_Status5(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status5').AsString := pValue;
end;

function TPkhBtr.Readx_Status6:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status6').AsString;
end;

procedure TPkhBtr.Writex_Status6(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status6').AsString := pValue;
end;

function TPkhBtr.Readx_Status7:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status7').AsString;
end;

procedure TPkhBtr.Writex_Status7(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status7').AsString := pValue;
end;

function TPkhBtr.Readx_Status8:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status8').AsString;
end;

procedure TPkhBtr.Writex_Status8(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status8').AsString := pValue;
end;

function TPkhBtr.Readx_Status9:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status9').AsString;
end;

procedure TPkhBtr.Writex_Status9(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status9').AsString := pValue;
end;

function TPkhBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TPkhBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TPkhBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TPkhBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPkhBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TPkhBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TPkhBtr.Readx_Status12:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status12').AsString;
end;

procedure TPkhBtr.Writex_Status12(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status12').AsString := pValue;
end;

function TPkhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPkhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPkhBtr.Readx_SItemQnt:word;
begin
  Result := oBtrTable.FieldByName('x_SItemQnt').AsInteger;
end;

procedure TPkhBtr.Writex_SItemQnt(pValue:word);
begin
  oBtrTable.FieldByName('x_SItemQnt').AsInteger := pValue;
end;

function TPkhBtr.Readx_LItemQnt:word;
begin
  Result := oBtrTable.FieldByName('x_LItemQnt').AsInteger;
end;

procedure TPkhBtr.Writex_LItemQnt(pValue:word);
begin
  oBtrTable.FieldByName('x_LItemQnt').AsInteger := pValue;
end;

function TPkhBtr.ReadDstLck:boolean;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger=1;
end;

procedure TPkhBtr.WriteDstLck(pValue:boolean);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := BoolToByte(pValue);
end;

function TPkhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPkhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPkhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPkhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPkhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPkhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPkhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPkhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPkhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPkhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPkhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPkhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPkhBtr.ReadOcdNum:Str20;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TPkhBtr.WriteOcdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TPkhBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TPkhBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TPkhBtr.ReadScSmCode:word;
begin
  Result := oBtrTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TPkhBtr.WriteScSmCode(pValue:word);
begin
  oBtrTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TPkhBtr.Readx_SSmName:Str30;
begin
  Result := oBtrTable.FieldByName('x_SSmName').AsString;
end;

procedure TPkhBtr.Writex_SSmName(pValue:Str30);
begin
  oBtrTable.FieldByName('x_SSmName').AsString := pValue;
end;

function TPkhBtr.ReadTgSmCode:word;
begin
  Result := oBtrTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TPkhBtr.WriteTgSmCode(pValue:word);
begin
  oBtrTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TPkhBtr.Readx_DSmName:Str30;
begin
  Result := oBtrTable.FieldByName('x_DSmName').AsString;
end;

procedure TPkhBtr.Writex_DSmName(pValue:Str30);
begin
  oBtrTable.FieldByName('x_DSmName').AsString := pValue;
end;

function TPkhBtr.Readx_AccMth:Str4;
begin
  Result := oBtrTable.FieldByName('x_AccMth').AsString;
end;

procedure TPkhBtr.Writex_AccMth(pValue:Str4);
begin
  oBtrTable.FieldByName('x_AccMth').AsString := pValue;
end;

function TPkhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TPkhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPkhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPkhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPkhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPkhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPkhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TPkhBtr.LocateStSn (pStkNum:word;pSerNum:longint):boolean;
begin
  SetIndex (ixStSn);
  Result := oBtrTable.FindKey([pStkNum,pSerNum]);
end;

function TPkhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPkhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TPkhBtr.LocateOcdNum (pOcdNum:Str20):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TPkhBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TPkhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TPkhBtr.NearestStSn (pStkNum:word;pSerNum:longint):boolean;
begin
  SetIndex (ixStSn);
  Result := oBtrTable.FindNearest([pStkNum,pSerNum]);
end;

function TPkhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPkhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TPkhBtr.NearestOcdNum (pOcdNum:Str20):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TPkhBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TPkhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPkhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPkhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPkhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPkhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPkhBtr.First;
begin
  oBtrTable.First;
end;

procedure TPkhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPkhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPkhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPkhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPkhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPkhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPkhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPkhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPkhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPkhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPkhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
