unit bPRI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixItmCode = 'ItmCode';
  ixDoRo = 'DoRo';
  ixDoPn = 'DoPn';
  ixDoLe = 'DoLe';

type
  TPriBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadItmCode:Str15;         procedure WriteItmCode (pValue:Str15);
    function  ReadItmName:Str60;         procedure WriteItmName (pValue:Str60);
    function  ReadUniQnt:word;           procedure WriteUniQnt (pValue:word);
    function  ReadDurDay:word;           procedure WriteDurDay (pValue:word);
    function  ReadDurHor:byte;           procedure WriteDurHor (pValue:byte);
    function  ReadDurMin:byte;           procedure WriteDurMin (pValue:byte);
    function  ReadSumDur:double;         procedure WriteSumDur (pValue:double);
    function  ReadSpcDur:double;         procedure WriteSpcDur (pValue:double);
    function  ReadDocDur:double;         procedure WriteDocDur (pValue:double);
    function  ReadPrgDur:double;         procedure WritePrgDur (pValue:double);
    function  ReadTesDur:double;         procedure WriteTesDur (pValue:double);
    function  ReadDebDur:double;         procedure WriteDebDur (pValue:double);
    function  ReadAcpDur:double;         procedure WriteAcpDur (pValue:double);
    function  ReadAdmDur:double;         procedure WriteAdmDur (pValue:double);
    function  ReadResDur:double;         procedure WriteResDur (pValue:double);
    function  ReadSumVal:double;         procedure WriteSumVal (pValue:double);
    function  ReadSpcVal:double;         procedure WriteSpcVal (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadPrgVal:double;         procedure WritePrgVal (pValue:double);
    function  ReadTesVal:double;         procedure WriteTesVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadAcpVal:double;         procedure WriteAcpVal (pValue:double);
    function  ReadAdmVal:double;         procedure WriteAdmVal (pValue:double);
    function  ReadResVal:double;         procedure WriteResVal (pValue:double);
    function  ReadLevNum:byte;           procedure WriteLevNum (pValue:byte);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadRotNum:word;           procedure WriteRotNum (pValue:word);
    function  ReadParNum:word;           procedure WriteParNum (pValue:word);
    function  ReadItmTyp:Str1;           procedure WriteItmTyp (pValue:Str1);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPrgCmp:double;         procedure WritePrgCmp (pValue:double);
    function  ReadPrgQnt:word;           procedure WritePrgQnt (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmCode (pItmCode:Str15):boolean;
    function LocateDoRo (pDocNum:Str12;pRotNum:word):boolean;
    function LocateDoPn (pDocNum:Str12;pParNum:word):boolean;
    function LocateDoLe (pDocNum:Str12;pLevNum:byte):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestItmCode (pItmCode:Str15):boolean;
    function NearestDoRo (pDocNum:Str12;pRotNum:word):boolean;
    function NearestDoPn (pDocNum:Str12;pParNum:word):boolean;
    function NearestDoLe (pDocNum:Str12;pLevNum:byte):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ItmCode:Str15 read ReadItmCode write WriteItmCode;
    property ItmName:Str60 read ReadItmName write WriteItmName;
    property UniQnt:word read ReadUniQnt write WriteUniQnt;
    property DurDay:word read ReadDurDay write WriteDurDay;
    property DurHor:byte read ReadDurHor write WriteDurHor;
    property DurMin:byte read ReadDurMin write WriteDurMin;
    property SumDur:double read ReadSumDur write WriteSumDur;
    property SpcDur:double read ReadSpcDur write WriteSpcDur;
    property DocDur:double read ReadDocDur write WriteDocDur;
    property PrgDur:double read ReadPrgDur write WritePrgDur;
    property TesDur:double read ReadTesDur write WriteTesDur;
    property DebDur:double read ReadDebDur write WriteDebDur;
    property AcpDur:double read ReadAcpDur write WriteAcpDur;
    property AdmDur:double read ReadAdmDur write WriteAdmDur;
    property ResDur:double read ReadResDur write WriteResDur;
    property SumVal:double read ReadSumVal write WriteSumVal;
    property SpcVal:double read ReadSpcVal write WriteSpcVal;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property PrgVal:double read ReadPrgVal write WritePrgVal;
    property TesVal:double read ReadTesVal write WriteTesVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property AcpVal:double read ReadAcpVal write WriteAcpVal;
    property AdmVal:double read ReadAdmVal write WriteAdmVal;
    property ResVal:double read ReadResVal write WriteResVal;
    property LevNum:byte read ReadLevNum write WriteLevNum;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property RotNum:word read ReadRotNum write WriteRotNum;
    property ParNum:word read ReadParNum write WriteParNum;
    property ItmTyp:Str1 read ReadItmTyp write WriteItmTyp;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PrgCmp:double read ReadPrgCmp write WritePrgCmp;
    property PrgQnt:word read ReadPrgQnt write WritePrgQnt;
  end;

implementation

constructor TPriBtr.Create;
begin
  oBtrTable := BtrInit ('PRI',gPath.DlsPath,Self);
end;

constructor TPriBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRI',pPath,Self);
end;

destructor TPriBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPriBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPriBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPriBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPriBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPriBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPriBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPriBtr.ReadItmCode:Str15;
begin
  Result := oBtrTable.FieldByName('ItmCode').AsString;
end;

procedure TPriBtr.WriteItmCode(pValue:Str15);
begin
  oBtrTable.FieldByName('ItmCode').AsString := pValue;
end;

function TPriBtr.ReadItmName:Str60;
begin
  Result := oBtrTable.FieldByName('ItmName').AsString;
end;

procedure TPriBtr.WriteItmName(pValue:Str60);
begin
  oBtrTable.FieldByName('ItmName').AsString := pValue;
end;

function TPriBtr.ReadUniQnt:word;
begin
  Result := oBtrTable.FieldByName('UniQnt').AsInteger;
end;

procedure TPriBtr.WriteUniQnt(pValue:word);
begin
  oBtrTable.FieldByName('UniQnt').AsInteger := pValue;
end;

function TPriBtr.ReadDurDay:word;
begin
  Result := oBtrTable.FieldByName('DurDay').AsInteger;
end;

procedure TPriBtr.WriteDurDay(pValue:word);
begin
  oBtrTable.FieldByName('DurDay').AsInteger := pValue;
end;

function TPriBtr.ReadDurHor:byte;
begin
  Result := oBtrTable.FieldByName('DurHor').AsInteger;
end;

procedure TPriBtr.WriteDurHor(pValue:byte);
begin
  oBtrTable.FieldByName('DurHor').AsInteger := pValue;
end;

function TPriBtr.ReadDurMin:byte;
begin
  Result := oBtrTable.FieldByName('DurMin').AsInteger;
end;

procedure TPriBtr.WriteDurMin(pValue:byte);
begin
  oBtrTable.FieldByName('DurMin').AsInteger := pValue;
end;

function TPriBtr.ReadSumDur:double;
begin
  Result := oBtrTable.FieldByName('SumDur').AsFloat;
end;

procedure TPriBtr.WriteSumDur(pValue:double);
begin
  oBtrTable.FieldByName('SumDur').AsFloat := pValue;
end;

function TPriBtr.ReadSpcDur:double;
begin
  Result := oBtrTable.FieldByName('SpcDur').AsFloat;
end;

procedure TPriBtr.WriteSpcDur(pValue:double);
begin
  oBtrTable.FieldByName('SpcDur').AsFloat := pValue;
end;

function TPriBtr.ReadDocDur:double;
begin
  Result := oBtrTable.FieldByName('DocDur').AsFloat;
end;

procedure TPriBtr.WriteDocDur(pValue:double);
begin
  oBtrTable.FieldByName('DocDur').AsFloat := pValue;
end;

function TPriBtr.ReadPrgDur:double;
begin
  Result := oBtrTable.FieldByName('PrgDur').AsFloat;
end;

procedure TPriBtr.WritePrgDur(pValue:double);
begin
  oBtrTable.FieldByName('PrgDur').AsFloat := pValue;
end;

function TPriBtr.ReadTesDur:double;
begin
  Result := oBtrTable.FieldByName('TesDur').AsFloat;
end;

procedure TPriBtr.WriteTesDur(pValue:double);
begin
  oBtrTable.FieldByName('TesDur').AsFloat := pValue;
end;

function TPriBtr.ReadDebDur:double;
begin
  Result := oBtrTable.FieldByName('DebDur').AsFloat;
end;

procedure TPriBtr.WriteDebDur(pValue:double);
begin
  oBtrTable.FieldByName('DebDur').AsFloat := pValue;
end;

function TPriBtr.ReadAcpDur:double;
begin
  Result := oBtrTable.FieldByName('AcpDur').AsFloat;
end;

procedure TPriBtr.WriteAcpDur(pValue:double);
begin
  oBtrTable.FieldByName('AcpDur').AsFloat := pValue;
end;

function TPriBtr.ReadAdmDur:double;
begin
  Result := oBtrTable.FieldByName('AdmDur').AsFloat;
end;

procedure TPriBtr.WriteAdmDur(pValue:double);
begin
  oBtrTable.FieldByName('AdmDur').AsFloat := pValue;
end;

function TPriBtr.ReadResDur:double;
begin
  Result := oBtrTable.FieldByName('ResDur').AsFloat;
end;

procedure TPriBtr.WriteResDur(pValue:double);
begin
  oBtrTable.FieldByName('ResDur').AsFloat := pValue;
end;

function TPriBtr.ReadSumVal:double;
begin
  Result := oBtrTable.FieldByName('SumVal').AsFloat;
end;

procedure TPriBtr.WriteSumVal(pValue:double);
begin
  oBtrTable.FieldByName('SumVal').AsFloat := pValue;
end;

function TPriBtr.ReadSpcVal:double;
begin
  Result := oBtrTable.FieldByName('SpcVal').AsFloat;
end;

procedure TPriBtr.WriteSpcVal(pValue:double);
begin
  oBtrTable.FieldByName('SpcVal').AsFloat := pValue;
end;

function TPriBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TPriBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TPriBtr.ReadPrgVal:double;
begin
  Result := oBtrTable.FieldByName('PrgVal').AsFloat;
end;

procedure TPriBtr.WritePrgVal(pValue:double);
begin
  oBtrTable.FieldByName('PrgVal').AsFloat := pValue;
end;

function TPriBtr.ReadTesVal:double;
begin
  Result := oBtrTable.FieldByName('TesVal').AsFloat;
end;

procedure TPriBtr.WriteTesVal(pValue:double);
begin
  oBtrTable.FieldByName('TesVal').AsFloat := pValue;
end;

function TPriBtr.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TPriBtr.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TPriBtr.ReadAcpVal:double;
begin
  Result := oBtrTable.FieldByName('AcpVal').AsFloat;
end;

procedure TPriBtr.WriteAcpVal(pValue:double);
begin
  oBtrTable.FieldByName('AcpVal').AsFloat := pValue;
end;

function TPriBtr.ReadAdmVal:double;
begin
  Result := oBtrTable.FieldByName('AdmVal').AsFloat;
end;

procedure TPriBtr.WriteAdmVal(pValue:double);
begin
  oBtrTable.FieldByName('AdmVal').AsFloat := pValue;
end;

function TPriBtr.ReadResVal:double;
begin
  Result := oBtrTable.FieldByName('ResVal').AsFloat;
end;

procedure TPriBtr.WriteResVal(pValue:double);
begin
  oBtrTable.FieldByName('ResVal').AsFloat := pValue;
end;

function TPriBtr.ReadLevNum:byte;
begin
  Result := oBtrTable.FieldByName('LevNum').AsInteger;
end;

procedure TPriBtr.WriteLevNum(pValue:byte);
begin
  oBtrTable.FieldByName('LevNum').AsInteger := pValue;
end;

function TPriBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TPriBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TPriBtr.ReadRotNum:word;
begin
  Result := oBtrTable.FieldByName('RotNum').AsInteger;
end;

procedure TPriBtr.WriteRotNum(pValue:word);
begin
  oBtrTable.FieldByName('RotNum').AsInteger := pValue;
end;

function TPriBtr.ReadParNum:word;
begin
  Result := oBtrTable.FieldByName('ParNum').AsInteger;
end;

procedure TPriBtr.WriteParNum(pValue:word);
begin
  oBtrTable.FieldByName('ParNum').AsInteger := pValue;
end;

function TPriBtr.ReadItmTyp:Str1;
begin
  Result := oBtrTable.FieldByName('ItmTyp').AsString;
end;

procedure TPriBtr.WriteItmTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmTyp').AsString := pValue;
end;

function TPriBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TPriBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TPriBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPriBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPriBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPriBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPriBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPriBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPriBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPriBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPriBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPriBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPriBtr.ReadPrgCmp:double;
begin
  Result := oBtrTable.FieldByName('PrgCmp').AsFloat;
end;

procedure TPriBtr.WritePrgCmp(pValue:double);
begin
  oBtrTable.FieldByName('PrgCmp').AsFloat := pValue;
end;

function TPriBtr.ReadPrgQnt:word;
begin
  Result := oBtrTable.FieldByName('PrgQnt').AsInteger;
end;

procedure TPriBtr.WritePrgQnt(pValue:word);
begin
  oBtrTable.FieldByName('PrgQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPriBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPriBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPriBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPriBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPriBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPriBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPriBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPriBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPriBtr.LocateItmCode (pItmCode:Str15):boolean;
begin
  SetIndex (ixItmCode);
  Result := oBtrTable.FindKey([pItmCode]);
end;

function TPriBtr.LocateDoRo (pDocNum:Str12;pRotNum:word):boolean;
begin
  SetIndex (ixDoRo);
  Result := oBtrTable.FindKey([pDocNum,pRotNum]);
end;

function TPriBtr.LocateDoPn (pDocNum:Str12;pParNum:word):boolean;
begin
  SetIndex (ixDoPn);
  Result := oBtrTable.FindKey([pDocNum,pParNum]);
end;

function TPriBtr.LocateDoLe (pDocNum:Str12;pLevNum:byte):boolean;
begin
  SetIndex (ixDoLe);
  Result := oBtrTable.FindKey([pDocNum,pLevNum]);
end;

function TPriBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPriBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPriBtr.NearestItmCode (pItmCode:Str15):boolean;
begin
  SetIndex (ixItmCode);
  Result := oBtrTable.FindNearest([pItmCode]);
end;

function TPriBtr.NearestDoRo (pDocNum:Str12;pRotNum:word):boolean;
begin
  SetIndex (ixDoRo);
  Result := oBtrTable.FindNearest([pDocNum,pRotNum]);
end;

function TPriBtr.NearestDoPn (pDocNum:Str12;pParNum:word):boolean;
begin
  SetIndex (ixDoPn);
  Result := oBtrTable.FindNearest([pDocNum,pParNum]);
end;

function TPriBtr.NearestDoLe (pDocNum:Str12;pLevNum:byte):boolean;
begin
  SetIndex (ixDoLe);
  Result := oBtrTable.FindNearest([pDocNum,pLevNum]);
end;

procedure TPriBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPriBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPriBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPriBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPriBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPriBtr.First;
begin
  oBtrTable.First;
end;

procedure TPriBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPriBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPriBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPriBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPriBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPriBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPriBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPriBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPriBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPriBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPriBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1901012}
