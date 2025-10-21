unit tPRI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixItmCode = 'ItmCode';
  ixItmName_ = 'ItmName_';

type
  TPriTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadItmCode:Str15;         procedure WriteItmCode (pValue:Str15);
    function  ReadItmName:Str60;         procedure WriteItmName (pValue:Str60);
    function  ReadItmName_:Str60;        procedure WriteItmName_ (pValue:Str60);
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
    function  ReadPrgCmp:double;         procedure WritePrgCmp (pValue:double);
    function  ReadPrgQnt:word;           procedure WritePrgQnt (pValue:word);
    function  ReadLevNum:byte;           procedure WriteLevNum (pValue:byte);
    function  ReadRotNum:word;           procedure WriteRotNum (pValue:word);
    function  ReadParNum:word;           procedure WriteParNum (pValue:word);
    function  ReadItmTyp:Str1;           procedure WriteItmTyp (pValue:Str1);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateItmCode (pItmCode:Str15):boolean;
    function LocateItmName_ (pItmName_:Str60):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ItmCode:Str15 read ReadItmCode write WriteItmCode;
    property ItmName:Str60 read ReadItmName write WriteItmName;
    property ItmName_:Str60 read ReadItmName_ write WriteItmName_;
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
    property PrgCmp:double read ReadPrgCmp write WritePrgCmp;
    property PrgQnt:word read ReadPrgQnt write WritePrgQnt;
    property LevNum:byte read ReadLevNum write WriteLevNum;
    property RotNum:word read ReadRotNum write WriteRotNum;
    property ParNum:word read ReadParNum write WriteParNum;
    property ItmTyp:Str1 read ReadItmTyp write WriteItmTyp;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPriTmp.Create;
begin
  oTmpTable := TmpInit ('PRI',Self);
end;

destructor TPriTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPriTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPriTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPriTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TPriTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TPriTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPriTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPriTmp.ReadItmCode:Str15;
begin
  Result := oTmpTable.FieldByName('ItmCode').AsString;
end;

procedure TPriTmp.WriteItmCode(pValue:Str15);
begin
  oTmpTable.FieldByName('ItmCode').AsString := pValue;
end;

function TPriTmp.ReadItmName:Str60;
begin
  Result := oTmpTable.FieldByName('ItmName').AsString;
end;

procedure TPriTmp.WriteItmName(pValue:Str60);
begin
  oTmpTable.FieldByName('ItmName').AsString := pValue;
end;

function TPriTmp.ReadItmName_:Str60;
begin
  Result := oTmpTable.FieldByName('ItmName_').AsString;
end;

procedure TPriTmp.WriteItmName_(pValue:Str60);
begin
  oTmpTable.FieldByName('ItmName_').AsString := pValue;
end;

function TPriTmp.ReadUniQnt:word;
begin
  Result := oTmpTable.FieldByName('UniQnt').AsInteger;
end;

procedure TPriTmp.WriteUniQnt(pValue:word);
begin
  oTmpTable.FieldByName('UniQnt').AsInteger := pValue;
end;

function TPriTmp.ReadDurDay:word;
begin
  Result := oTmpTable.FieldByName('DurDay').AsInteger;
end;

procedure TPriTmp.WriteDurDay(pValue:word);
begin
  oTmpTable.FieldByName('DurDay').AsInteger := pValue;
end;

function TPriTmp.ReadDurHor:byte;
begin
  Result := oTmpTable.FieldByName('DurHor').AsInteger;
end;

procedure TPriTmp.WriteDurHor(pValue:byte);
begin
  oTmpTable.FieldByName('DurHor').AsInteger := pValue;
end;

function TPriTmp.ReadDurMin:byte;
begin
  Result := oTmpTable.FieldByName('DurMin').AsInteger;
end;

procedure TPriTmp.WriteDurMin(pValue:byte);
begin
  oTmpTable.FieldByName('DurMin').AsInteger := pValue;
end;

function TPriTmp.ReadSumDur:double;
begin
  Result := oTmpTable.FieldByName('SumDur').AsFloat;
end;

procedure TPriTmp.WriteSumDur(pValue:double);
begin
  oTmpTable.FieldByName('SumDur').AsFloat := pValue;
end;

function TPriTmp.ReadSpcDur:double;
begin
  Result := oTmpTable.FieldByName('SpcDur').AsFloat;
end;

procedure TPriTmp.WriteSpcDur(pValue:double);
begin
  oTmpTable.FieldByName('SpcDur').AsFloat := pValue;
end;

function TPriTmp.ReadDocDur:double;
begin
  Result := oTmpTable.FieldByName('DocDur').AsFloat;
end;

procedure TPriTmp.WriteDocDur(pValue:double);
begin
  oTmpTable.FieldByName('DocDur').AsFloat := pValue;
end;

function TPriTmp.ReadPrgDur:double;
begin
  Result := oTmpTable.FieldByName('PrgDur').AsFloat;
end;

procedure TPriTmp.WritePrgDur(pValue:double);
begin
  oTmpTable.FieldByName('PrgDur').AsFloat := pValue;
end;

function TPriTmp.ReadTesDur:double;
begin
  Result := oTmpTable.FieldByName('TesDur').AsFloat;
end;

procedure TPriTmp.WriteTesDur(pValue:double);
begin
  oTmpTable.FieldByName('TesDur').AsFloat := pValue;
end;

function TPriTmp.ReadDebDur:double;
begin
  Result := oTmpTable.FieldByName('DebDur').AsFloat;
end;

procedure TPriTmp.WriteDebDur(pValue:double);
begin
  oTmpTable.FieldByName('DebDur').AsFloat := pValue;
end;

function TPriTmp.ReadAcpDur:double;
begin
  Result := oTmpTable.FieldByName('AcpDur').AsFloat;
end;

procedure TPriTmp.WriteAcpDur(pValue:double);
begin
  oTmpTable.FieldByName('AcpDur').AsFloat := pValue;
end;

function TPriTmp.ReadAdmDur:double;
begin
  Result := oTmpTable.FieldByName('AdmDur').AsFloat;
end;

procedure TPriTmp.WriteAdmDur(pValue:double);
begin
  oTmpTable.FieldByName('AdmDur').AsFloat := pValue;
end;

function TPriTmp.ReadResDur:double;
begin
  Result := oTmpTable.FieldByName('ResDur').AsFloat;
end;

procedure TPriTmp.WriteResDur(pValue:double);
begin
  oTmpTable.FieldByName('ResDur').AsFloat := pValue;
end;

function TPriTmp.ReadSumVal:double;
begin
  Result := oTmpTable.FieldByName('SumVal').AsFloat;
end;

procedure TPriTmp.WriteSumVal(pValue:double);
begin
  oTmpTable.FieldByName('SumVal').AsFloat := pValue;
end;

function TPriTmp.ReadSpcVal:double;
begin
  Result := oTmpTable.FieldByName('SpcVal').AsFloat;
end;

procedure TPriTmp.WriteSpcVal(pValue:double);
begin
  oTmpTable.FieldByName('SpcVal').AsFloat := pValue;
end;

function TPriTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TPriTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TPriTmp.ReadPrgVal:double;
begin
  Result := oTmpTable.FieldByName('PrgVal').AsFloat;
end;

procedure TPriTmp.WritePrgVal(pValue:double);
begin
  oTmpTable.FieldByName('PrgVal').AsFloat := pValue;
end;

function TPriTmp.ReadTesVal:double;
begin
  Result := oTmpTable.FieldByName('TesVal').AsFloat;
end;

procedure TPriTmp.WriteTesVal(pValue:double);
begin
  oTmpTable.FieldByName('TesVal').AsFloat := pValue;
end;

function TPriTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TPriTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TPriTmp.ReadAcpVal:double;
begin
  Result := oTmpTable.FieldByName('AcpVal').AsFloat;
end;

procedure TPriTmp.WriteAcpVal(pValue:double);
begin
  oTmpTable.FieldByName('AcpVal').AsFloat := pValue;
end;

function TPriTmp.ReadAdmVal:double;
begin
  Result := oTmpTable.FieldByName('AdmVal').AsFloat;
end;

procedure TPriTmp.WriteAdmVal(pValue:double);
begin
  oTmpTable.FieldByName('AdmVal').AsFloat := pValue;
end;

function TPriTmp.ReadResVal:double;
begin
  Result := oTmpTable.FieldByName('ResVal').AsFloat;
end;

procedure TPriTmp.WriteResVal(pValue:double);
begin
  oTmpTable.FieldByName('ResVal').AsFloat := pValue;
end;

function TPriTmp.ReadPrgCmp:double;
begin
  Result := oTmpTable.FieldByName('PrgCmp').AsFloat;
end;

procedure TPriTmp.WritePrgCmp(pValue:double);
begin
  oTmpTable.FieldByName('PrgCmp').AsFloat := pValue;
end;

function TPriTmp.ReadPrgQnt:word;
begin
  Result := oTmpTable.FieldByName('PrgQnt').AsInteger;
end;

procedure TPriTmp.WritePrgQnt(pValue:word);
begin
  oTmpTable.FieldByName('PrgQnt').AsInteger := pValue;
end;

function TPriTmp.ReadLevNum:byte;
begin
  Result := oTmpTable.FieldByName('LevNum').AsInteger;
end;

procedure TPriTmp.WriteLevNum(pValue:byte);
begin
  oTmpTable.FieldByName('LevNum').AsInteger := pValue;
end;

function TPriTmp.ReadRotNum:word;
begin
  Result := oTmpTable.FieldByName('RotNum').AsInteger;
end;

procedure TPriTmp.WriteRotNum(pValue:word);
begin
  oTmpTable.FieldByName('RotNum').AsInteger := pValue;
end;

function TPriTmp.ReadParNum:word;
begin
  Result := oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TPriTmp.WriteParNum(pValue:word);
begin
  oTmpTable.FieldByName('ParNum').AsInteger := pValue;
end;

function TPriTmp.ReadItmTyp:Str1;
begin
  Result := oTmpTable.FieldByName('ItmTyp').AsString;
end;

procedure TPriTmp.WriteItmTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmTyp').AsString := pValue;
end;

function TPriTmp.ReadCrtName:str8;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TPriTmp.WriteCrtName(pValue:str8);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TPriTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPriTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPriTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPriTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPriTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPriTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPriTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPriTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPriTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPriTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPriTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPriTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPriTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPriTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPriTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TPriTmp.LocateItmCode (pItmCode:Str15):boolean;
begin
  SetIndex (ixItmCode);
  Result := oTmpTable.FindKey([pItmCode]);
end;

function TPriTmp.LocateItmName_ (pItmName_:Str60):boolean;
begin
  SetIndex (ixItmName_);
  Result := oTmpTable.FindKey([pItmName_]);
end;

procedure TPriTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPriTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPriTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPriTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPriTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPriTmp.First;
begin
  oTmpTable.First;
end;

procedure TPriTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPriTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPriTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPriTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPriTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPriTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPriTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPriTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPriTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPriTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPriTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1901012}
