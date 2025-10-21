unit bROL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRoomNum = 'RoomNum';
  ixRoomCode = 'RoomCode';

type
  TRolBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadRoomCode:Str15;        procedure WriteRoomCode (pValue:Str15);
    function  ReadRoomName:Str30;        procedure WriteRoomName (pValue:Str30);
    function  ReadRoomType:Str1;         procedure WriteRoomType (pValue:Str1);
    function  ReadBedCnt:longint;        procedure WriteBedCnt (pValue:longint);
    function  ReadAdbCnt:longint;        procedure WriteAdbCnt (pValue:longint);
    function  ReadFloor:longint;         procedure WriteFloor (pValue:longint);
    function  ReadBlok:longint;          procedure WriteBlok (pValue:longint);
    function  ReadDevice1:Str1;          procedure WriteDevice1 (pValue:Str1);
    function  ReadDevice2:Str1;          procedure WriteDevice2 (pValue:Str1);
    function  ReadDevice3:Str1;          procedure WriteDevice3 (pValue:Str1);
    function  ReadDevice4:Str1;          procedure WriteDevice4 (pValue:Str1);
    function  ReadDevice5:Str1;          procedure WriteDevice5 (pValue:Str1);
    function  ReadDevice6:Str1;          procedure WriteDevice6 (pValue:Str1);
    function  ReadDevice7:Str1;          procedure WriteDevice7 (pValue:Str1);
    function  ReadDevice8:Str1;          procedure WriteDevice8 (pValue:Str1);
    function  ReadDevice9:Str1;          procedure WriteDevice9 (pValue:Str1);
    function  ReadDevice10:Str1;         procedure WriteDevice10 (pValue:Str1);
    function  ReadBedPrice:double;       procedure WriteBedPrice (pValue:double);
    function  ReadAdbPrice:double;       procedure WriteAdbPrice (pValue:double);
    function  ReadRoomPrice:double;      procedure WriteRoomPrice (pValue:double);
    function  ReadRoomPriceF:double;     procedure WriteRoomPriceF (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadExtension:Str5;        procedure WriteExtension (pValue:Str5);
    function  ReadDevGsCode1:longint;    procedure WriteDevGsCode1 (pValue:longint);
    function  ReadDevGsCode2:longint;    procedure WriteDevGsCode2 (pValue:longint);
    function  ReadDevGsCode3:longint;    procedure WriteDevGsCode3 (pValue:longint);
    function  ReadDevGsCode4:longint;    procedure WriteDevGsCode4 (pValue:longint);
    function  ReadDevGsCode5:longint;    procedure WriteDevGsCode5 (pValue:longint);
    function  ReadDevGsCode6:longint;    procedure WriteDevGsCode6 (pValue:longint);
    function  ReadDevGsCode7:longint;    procedure WriteDevGsCode7 (pValue:longint);
    function  ReadDevGsCode8:longint;    procedure WriteDevGsCode8 (pValue:longint);
    function  ReadDevGsCode9:longint;    procedure WriteDevGsCode9 (pValue:longint);
    function  ReadDevGsCode10:longint;   procedure WriteDevGsCode10 (pValue:longint);
    function  ReadDevGsPrc1:double;      procedure WriteDevGsPrc1 (pValue:double);
    function  ReadDevGsPrc2:double;      procedure WriteDevGsPrc2 (pValue:double);
    function  ReadDevGsPrc3:double;      procedure WriteDevGsPrc3 (pValue:double);
    function  ReadDevGsPrc4:double;      procedure WriteDevGsPrc4 (pValue:double);
    function  ReadDevGsPrc5:double;      procedure WriteDevGsPrc5 (pValue:double);
    function  ReadDevGsPrc6:double;      procedure WriteDevGsPrc6 (pValue:double);
    function  ReadDevGsPrc7:double;      procedure WriteDevGsPrc7 (pValue:double);
    function  ReadDevGsPrc8:double;      procedure WriteDevGsPrc8 (pValue:double);
    function  ReadDevGsPrc9:double;      procedure WriteDevGsPrc9 (pValue:double);
    function  ReadDevGsPrc10:double;     procedure WriteDevGsPrc10 (pValue:double);
    function  ReadDevGsName1:Str30;      procedure WriteDevGsName1 (pValue:Str30);
    function  ReadDevGsName2:Str30;      procedure WriteDevGsName2 (pValue:Str30);
    function  ReadDevGsName3:Str30;      procedure WriteDevGsName3 (pValue:Str30);
    function  ReadDevGsName4:Str30;      procedure WriteDevGsName4 (pValue:Str30);
    function  ReadDevGsName5:Str30;      procedure WriteDevGsName5 (pValue:Str30);
    function  ReadDevGsName6:Str30;      procedure WriteDevGsName6 (pValue:Str30);
    function  ReadDevGsName7:Str30;      procedure WriteDevGsName7 (pValue:Str30);
    function  ReadDevGsName8:Str30;      procedure WriteDevGsName8 (pValue:Str30);
    function  ReadDevGsName9:Str30;      procedure WriteDevGsName9 (pValue:Str30);
    function  ReadDevGsName10:Str30;     procedure WriteDevGsName10 (pValue:Str30);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadRes1:byte;             procedure WriteRes1 (pValue:byte);
    function  ReadRes2:word;             procedure WriteRes2 (pValue:word);
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
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateRoomCode (pRoomCode:Str15):boolean;
    function NearestRoomNum (pRoomNum:longint):boolean;
    function NearestRoomCode (pRoomCode:Str15):boolean;

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
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property RoomCode:Str15 read ReadRoomCode write WriteRoomCode;
    property RoomName:Str30 read ReadRoomName write WriteRoomName;
    property RoomType:Str1 read ReadRoomType write WriteRoomType;
    property BedCnt:longint read ReadBedCnt write WriteBedCnt;
    property AdbCnt:longint read ReadAdbCnt write WriteAdbCnt;
    property Floor:longint read ReadFloor write WriteFloor;
    property Blok:longint read ReadBlok write WriteBlok;
    property Device1:Str1 read ReadDevice1 write WriteDevice1;
    property Device2:Str1 read ReadDevice2 write WriteDevice2;
    property Device3:Str1 read ReadDevice3 write WriteDevice3;
    property Device4:Str1 read ReadDevice4 write WriteDevice4;
    property Device5:Str1 read ReadDevice5 write WriteDevice5;
    property Device6:Str1 read ReadDevice6 write WriteDevice6;
    property Device7:Str1 read ReadDevice7 write WriteDevice7;
    property Device8:Str1 read ReadDevice8 write WriteDevice8;
    property Device9:Str1 read ReadDevice9 write WriteDevice9;
    property Device10:Str1 read ReadDevice10 write WriteDevice10;
    property BedPrice:double read ReadBedPrice write WriteBedPrice;
    property AdbPrice:double read ReadAdbPrice write WriteAdbPrice;
    property RoomPrice:double read ReadRoomPrice write WriteRoomPrice;
    property RoomPriceF:double read ReadRoomPriceF write WriteRoomPriceF;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Extension:Str5 read ReadExtension write WriteExtension;
    property DevGsCode1:longint read ReadDevGsCode1 write WriteDevGsCode1;
    property DevGsCode2:longint read ReadDevGsCode2 write WriteDevGsCode2;
    property DevGsCode3:longint read ReadDevGsCode3 write WriteDevGsCode3;
    property DevGsCode4:longint read ReadDevGsCode4 write WriteDevGsCode4;
    property DevGsCode5:longint read ReadDevGsCode5 write WriteDevGsCode5;
    property DevGsCode6:longint read ReadDevGsCode6 write WriteDevGsCode6;
    property DevGsCode7:longint read ReadDevGsCode7 write WriteDevGsCode7;
    property DevGsCode8:longint read ReadDevGsCode8 write WriteDevGsCode8;
    property DevGsCode9:longint read ReadDevGsCode9 write WriteDevGsCode9;
    property DevGsCode10:longint read ReadDevGsCode10 write WriteDevGsCode10;
    property DevGsPrc1:double read ReadDevGsPrc1 write WriteDevGsPrc1;
    property DevGsPrc2:double read ReadDevGsPrc2 write WriteDevGsPrc2;
    property DevGsPrc3:double read ReadDevGsPrc3 write WriteDevGsPrc3;
    property DevGsPrc4:double read ReadDevGsPrc4 write WriteDevGsPrc4;
    property DevGsPrc5:double read ReadDevGsPrc5 write WriteDevGsPrc5;
    property DevGsPrc6:double read ReadDevGsPrc6 write WriteDevGsPrc6;
    property DevGsPrc7:double read ReadDevGsPrc7 write WriteDevGsPrc7;
    property DevGsPrc8:double read ReadDevGsPrc8 write WriteDevGsPrc8;
    property DevGsPrc9:double read ReadDevGsPrc9 write WriteDevGsPrc9;
    property DevGsPrc10:double read ReadDevGsPrc10 write WriteDevGsPrc10;
    property DevGsName1:Str30 read ReadDevGsName1 write WriteDevGsName1;
    property DevGsName2:Str30 read ReadDevGsName2 write WriteDevGsName2;
    property DevGsName3:Str30 read ReadDevGsName3 write WriteDevGsName3;
    property DevGsName4:Str30 read ReadDevGsName4 write WriteDevGsName4;
    property DevGsName5:Str30 read ReadDevGsName5 write WriteDevGsName5;
    property DevGsName6:Str30 read ReadDevGsName6 write WriteDevGsName6;
    property DevGsName7:Str30 read ReadDevGsName7 write WriteDevGsName7;
    property DevGsName8:Str30 read ReadDevGsName8 write WriteDevGsName8;
    property DevGsName9:Str30 read ReadDevGsName9 write WriteDevGsName9;
    property DevGsName10:Str30 read ReadDevGsName10 write WriteDevGsName10;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property Res1:byte read ReadRes1 write WriteRes1;
    property Res2:word read ReadRes2 write WriteRes2;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
  end;

implementation

constructor TRolBtr.Create;
begin
  oBtrTable := BtrInit ('ROL',gPath.HtlPath,Self);
end;

constructor TRolBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ROL',pPath,Self);
end;

destructor TRolBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRolBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRolBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRolBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TRolBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TRolBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TRolBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TRolBtr.ReadRoomName:Str30;
begin
  Result := oBtrTable.FieldByName('RoomName').AsString;
end;

procedure TRolBtr.WriteRoomName(pValue:Str30);
begin
  oBtrTable.FieldByName('RoomName').AsString := pValue;
end;

function TRolBtr.ReadRoomType:Str1;
begin
  Result := oBtrTable.FieldByName('RoomType').AsString;
end;

procedure TRolBtr.WriteRoomType(pValue:Str1);
begin
  oBtrTable.FieldByName('RoomType').AsString := pValue;
end;

function TRolBtr.ReadBedCnt:longint;
begin
  Result := oBtrTable.FieldByName('BedCnt').AsInteger;
end;

procedure TRolBtr.WriteBedCnt(pValue:longint);
begin
  oBtrTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TRolBtr.ReadAdbCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TRolBtr.WriteAdbCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TRolBtr.ReadFloor:longint;
begin
  Result := oBtrTable.FieldByName('Floor').AsInteger;
end;

procedure TRolBtr.WriteFloor(pValue:longint);
begin
  oBtrTable.FieldByName('Floor').AsInteger := pValue;
end;

function TRolBtr.ReadBlok:longint;
begin
  Result := oBtrTable.FieldByName('Blok').AsInteger;
end;

procedure TRolBtr.WriteBlok(pValue:longint);
begin
  oBtrTable.FieldByName('Blok').AsInteger := pValue;
end;

function TRolBtr.ReadDevice1:Str1;
begin
  Result := oBtrTable.FieldByName('Device1').AsString;
end;

procedure TRolBtr.WriteDevice1(pValue:Str1);
begin
  oBtrTable.FieldByName('Device1').AsString := pValue;
end;

function TRolBtr.ReadDevice2:Str1;
begin
  Result := oBtrTable.FieldByName('Device2').AsString;
end;

procedure TRolBtr.WriteDevice2(pValue:Str1);
begin
  oBtrTable.FieldByName('Device2').AsString := pValue;
end;

function TRolBtr.ReadDevice3:Str1;
begin
  Result := oBtrTable.FieldByName('Device3').AsString;
end;

procedure TRolBtr.WriteDevice3(pValue:Str1);
begin
  oBtrTable.FieldByName('Device3').AsString := pValue;
end;

function TRolBtr.ReadDevice4:Str1;
begin
  Result := oBtrTable.FieldByName('Device4').AsString;
end;

procedure TRolBtr.WriteDevice4(pValue:Str1);
begin
  oBtrTable.FieldByName('Device4').AsString := pValue;
end;

function TRolBtr.ReadDevice5:Str1;
begin
  Result := oBtrTable.FieldByName('Device5').AsString;
end;

procedure TRolBtr.WriteDevice5(pValue:Str1);
begin
  oBtrTable.FieldByName('Device5').AsString := pValue;
end;

function TRolBtr.ReadDevice6:Str1;
begin
  Result := oBtrTable.FieldByName('Device6').AsString;
end;

procedure TRolBtr.WriteDevice6(pValue:Str1);
begin
  oBtrTable.FieldByName('Device6').AsString := pValue;
end;

function TRolBtr.ReadDevice7:Str1;
begin
  Result := oBtrTable.FieldByName('Device7').AsString;
end;

procedure TRolBtr.WriteDevice7(pValue:Str1);
begin
  oBtrTable.FieldByName('Device7').AsString := pValue;
end;

function TRolBtr.ReadDevice8:Str1;
begin
  Result := oBtrTable.FieldByName('Device8').AsString;
end;

procedure TRolBtr.WriteDevice8(pValue:Str1);
begin
  oBtrTable.FieldByName('Device8').AsString := pValue;
end;

function TRolBtr.ReadDevice9:Str1;
begin
  Result := oBtrTable.FieldByName('Device9').AsString;
end;

procedure TRolBtr.WriteDevice9(pValue:Str1);
begin
  oBtrTable.FieldByName('Device9').AsString := pValue;
end;

function TRolBtr.ReadDevice10:Str1;
begin
  Result := oBtrTable.FieldByName('Device10').AsString;
end;

procedure TRolBtr.WriteDevice10(pValue:Str1);
begin
  oBtrTable.FieldByName('Device10').AsString := pValue;
end;

function TRolBtr.ReadBedPrice:double;
begin
  Result := oBtrTable.FieldByName('BedPrice').AsFloat;
end;

procedure TRolBtr.WriteBedPrice(pValue:double);
begin
  oBtrTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TRolBtr.ReadAdbPrice:double;
begin
  Result := oBtrTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TRolBtr.WriteAdbPrice(pValue:double);
begin
  oBtrTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TRolBtr.ReadRoomPrice:double;
begin
  Result := oBtrTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TRolBtr.WriteRoomPrice(pValue:double);
begin
  oBtrTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TRolBtr.ReadRoomPriceF:double;
begin
  Result := oBtrTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TRolBtr.WriteRoomPriceF(pValue:double);
begin
  oBtrTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TRolBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRolBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRolBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRolBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRolBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRolBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRolBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRolBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRolBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRolBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRolBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRolBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRolBtr.ReadExtension:Str5;
begin
  Result := oBtrTable.FieldByName('Extension').AsString;
end;

procedure TRolBtr.WriteExtension(pValue:Str5);
begin
  oBtrTable.FieldByName('Extension').AsString := pValue;
end;

function TRolBtr.ReadDevGsCode1:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode1').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode1(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode1').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode2:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode2').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode2(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode2').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode3:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode3').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode3(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode3').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode4:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode4').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode4(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode4').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode5:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode5').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode5(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode5').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode6:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode6').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode6(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode6').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode7:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode7').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode7(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode7').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode8:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode8').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode8(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode8').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode9:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode9').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode9(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode9').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsCode10:longint;
begin
  Result := oBtrTable.FieldByName('DevGsCode10').AsInteger;
end;

procedure TRolBtr.WriteDevGsCode10(pValue:longint);
begin
  oBtrTable.FieldByName('DevGsCode10').AsInteger := pValue;
end;

function TRolBtr.ReadDevGsPrc1:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc1').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc1(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc1').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc2:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc2').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc2(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc2').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc3:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc3').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc3(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc3').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc4:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc4').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc4(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc4').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc5:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc5').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc5(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc5').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc6:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc6').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc6(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc6').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc7:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc7').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc7(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc7').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc8:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc8').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc8(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc8').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc9:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc9').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc9(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc9').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsPrc10:double;
begin
  Result := oBtrTable.FieldByName('DevGsPrc10').AsFloat;
end;

procedure TRolBtr.WriteDevGsPrc10(pValue:double);
begin
  oBtrTable.FieldByName('DevGsPrc10').AsFloat := pValue;
end;

function TRolBtr.ReadDevGsName1:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName1').AsString;
end;

procedure TRolBtr.WriteDevGsName1(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName1').AsString := pValue;
end;

function TRolBtr.ReadDevGsName2:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName2').AsString;
end;

procedure TRolBtr.WriteDevGsName2(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName2').AsString := pValue;
end;

function TRolBtr.ReadDevGsName3:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName3').AsString;
end;

procedure TRolBtr.WriteDevGsName3(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName3').AsString := pValue;
end;

function TRolBtr.ReadDevGsName4:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName4').AsString;
end;

procedure TRolBtr.WriteDevGsName4(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName4').AsString := pValue;
end;

function TRolBtr.ReadDevGsName5:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName5').AsString;
end;

procedure TRolBtr.WriteDevGsName5(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName5').AsString := pValue;
end;

function TRolBtr.ReadDevGsName6:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName6').AsString;
end;

procedure TRolBtr.WriteDevGsName6(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName6').AsString := pValue;
end;

function TRolBtr.ReadDevGsName7:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName7').AsString;
end;

procedure TRolBtr.WriteDevGsName7(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName7').AsString := pValue;
end;

function TRolBtr.ReadDevGsName8:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName8').AsString;
end;

procedure TRolBtr.WriteDevGsName8(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName8').AsString := pValue;
end;

function TRolBtr.ReadDevGsName9:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName9').AsString;
end;

procedure TRolBtr.WriteDevGsName9(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName9').AsString := pValue;
end;

function TRolBtr.ReadDevGsName10:Str30;
begin
  Result := oBtrTable.FieldByName('DevGsName10').AsString;
end;

procedure TRolBtr.WriteDevGsName10(pValue:Str30);
begin
  oBtrTable.FieldByName('DevGsName10').AsString := pValue;
end;

function TRolBtr.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DisFlag').AsInteger);
end;

procedure TRolBtr.WriteDisFlag(pValue:boolean);
begin
  oBtrTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TRolBtr.ReadRes1:byte;
begin
  Result := oBtrTable.FieldByName('Res1').AsInteger;
end;

procedure TRolBtr.WriteRes1(pValue:byte);
begin
  oBtrTable.FieldByName('Res1').AsInteger := pValue;
end;

function TRolBtr.ReadRes2:word;
begin
  Result := oBtrTable.FieldByName('Res2').AsInteger;
end;

procedure TRolBtr.WriteRes2(pValue:word);
begin
  oBtrTable.FieldByName('Res2').AsInteger := pValue;
end;

function TRolBtr.ReadDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('DvzName').AsString;
end;

procedure TRolBtr.WriteDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRolBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRolBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRolBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRolBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRolBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRolBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRolBtr.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindKey([pRoomNum]);
end;

function TRolBtr.LocateRoomCode (pRoomCode:Str15):boolean;
begin
  SetIndex (ixRoomCode);
  Result := oBtrTable.FindKey([pRoomCode]);
end;

function TRolBtr.NearestRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindNearest([pRoomNum]);
end;

function TRolBtr.NearestRoomCode (pRoomCode:Str15):boolean;
begin
  SetIndex (ixRoomCode);
  Result := oBtrTable.FindNearest([pRoomCode]);
end;

procedure TRolBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRolBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRolBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRolBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRolBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRolBtr.First;
begin
  oBtrTable.First;
end;

procedure TRolBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRolBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRolBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRolBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRolBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRolBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRolBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRolBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRolBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRolBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRolBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
