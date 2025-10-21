unit bTNR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixTnRnDa = 'TnRnDa';

type
  TTnrBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadDate:TDatetime;        procedure WriteDate (pValue:TDatetime);
    function  ReadRoomCode:Str15;        procedure WriteRoomCode (pValue:Str15);
    function  ReadBedCnt:longint;        procedure WriteBedCnt (pValue:longint);
    function  ReadAdbCnt:longint;        procedure WriteAdbCnt (pValue:longint);
    function  ReadRoomPrice:double;      procedure WriteRoomPrice (pValue:double);
    function  ReadRoomDscPrc:double;     procedure WriteRoomDscPrc (pValue:double);
    function  ReadRoomPriceF:double;     procedure WriteRoomPriceF (pValue:double);
    function  ReadFood1:longint;         procedure WriteFood1 (pValue:longint);
    function  ReadFood2:longint;         procedure WriteFood2 (pValue:longint);
    function  ReadFood3:longint;         procedure WriteFood3 (pValue:longint);
    function  ReadFood4:longint;         procedure WriteFood4 (pValue:longint);
    function  ReadFood5:longint;         procedure WriteFood5 (pValue:longint);
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
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateTnRnDa (pTentNum:longint;pRoomNum:longint;pDate:TDatetime):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function NearestTnRnDa (pTentNum:longint;pRoomNum:longint;pDate:TDatetime):boolean;

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
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property Date:TDatetime read ReadDate write WriteDate;
    property RoomCode:Str15 read ReadRoomCode write WriteRoomCode;
    property BedCnt:longint read ReadBedCnt write WriteBedCnt;
    property AdbCnt:longint read ReadAdbCnt write WriteAdbCnt;
    property RoomPrice:double read ReadRoomPrice write WriteRoomPrice;
    property RoomDscPrc:double read ReadRoomDscPrc write WriteRoomDscPrc;
    property RoomPriceF:double read ReadRoomPriceF write WriteRoomPriceF;
    property Food1:longint read ReadFood1 write WriteFood1;
    property Food2:longint read ReadFood2 write WriteFood2;
    property Food3:longint read ReadFood3 write WriteFood3;
    property Food4:longint read ReadFood4 write WriteFood4;
    property Food5:longint read ReadFood5 write WriteFood5;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TTnrBtr.Create;
begin
  oBtrTable := BtrInit ('TNR',gPath.HtlPath,Self);
end;

constructor TTnrBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNR',pPath,Self);
end;

destructor TTnrBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTnrBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTnrBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTnrBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnrBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnrBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnrBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnrBtr.ReadDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('Date').AsDateTime;
end;

procedure TTnrBtr.WriteDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('Date').AsDateTime := pValue;
end;

function TTnrBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TTnrBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TTnrBtr.ReadBedCnt:longint;
begin
  Result := oBtrTable.FieldByName('BedCnt').AsInteger;
end;

procedure TTnrBtr.WriteBedCnt(pValue:longint);
begin
  oBtrTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TTnrBtr.ReadAdbCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TTnrBtr.WriteAdbCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TTnrBtr.ReadRoomPrice:double;
begin
  Result := oBtrTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TTnrBtr.WriteRoomPrice(pValue:double);
begin
  oBtrTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TTnrBtr.ReadRoomDscPrc:double;
begin
  Result := oBtrTable.FieldByName('RoomDscPrc').AsFloat;
end;

procedure TTnrBtr.WriteRoomDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('RoomDscPrc').AsFloat := pValue;
end;

function TTnrBtr.ReadRoomPriceF:double;
begin
  Result := oBtrTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TTnrBtr.WriteRoomPriceF(pValue:double);
begin
  oBtrTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TTnrBtr.ReadFood1:longint;
begin
  Result := oBtrTable.FieldByName('Food1').AsInteger;
end;

procedure TTnrBtr.WriteFood1(pValue:longint);
begin
  oBtrTable.FieldByName('Food1').AsInteger := pValue;
end;

function TTnrBtr.ReadFood2:longint;
begin
  Result := oBtrTable.FieldByName('Food2').AsInteger;
end;

procedure TTnrBtr.WriteFood2(pValue:longint);
begin
  oBtrTable.FieldByName('Food2').AsInteger := pValue;
end;

function TTnrBtr.ReadFood3:longint;
begin
  Result := oBtrTable.FieldByName('Food3').AsInteger;
end;

procedure TTnrBtr.WriteFood3(pValue:longint);
begin
  oBtrTable.FieldByName('Food3').AsInteger := pValue;
end;

function TTnrBtr.ReadFood4:longint;
begin
  Result := oBtrTable.FieldByName('Food4').AsInteger;
end;

procedure TTnrBtr.WriteFood4(pValue:longint);
begin
  oBtrTable.FieldByName('Food4').AsInteger := pValue;
end;

function TTnrBtr.ReadFood5:longint;
begin
  Result := oBtrTable.FieldByName('Food5').AsInteger;
end;

procedure TTnrBtr.WriteFood5(pValue:longint);
begin
  oBtrTable.FieldByName('Food5').AsInteger := pValue;
end;

function TTnrBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTnrBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnrBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnrBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnrBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnrBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnrBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTnrBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnrBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnrBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnrBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnrBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnrBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnrBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTnrBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnrBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTnrBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTnrBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTnrBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTnrBtr.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnrBtr.LocateTnRnDa (pTentNum:longint;pRoomNum:longint;pDate:TDatetime):boolean;
begin
  SetIndex (ixTnRnDa);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum,pDate]);
end;

function TTnrBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTnrBtr.NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum]);
end;

function TTnrBtr.NearestTnRnDa (pTentNum:longint;pRoomNum:longint;pDate:TDatetime):boolean;
begin
  SetIndex (ixTnRnDa);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum,pDate]);
end;

procedure TTnrBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTnrBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTnrBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTnrBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTnrBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTnrBtr.First;
begin
  oBtrTable.First;
end;

procedure TTnrBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTnrBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTnrBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTnrBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTnrBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTnrBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTnrBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTnrBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTnrBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTnrBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTnrBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
