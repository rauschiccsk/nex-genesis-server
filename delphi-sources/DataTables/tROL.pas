unit tROL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRoomNum = '';
  ixRoomCode = 'RoomCode';

type
  TRolTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateRoomCode (pRoomCode:Str15):boolean;

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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRolTmp.Create;
begin
  oTmpTable := TmpInit ('ROL',Self);
end;

destructor TRolTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRolTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRolTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRolTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TRolTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TRolTmp.ReadRoomCode:Str15;
begin
  Result := oTmpTable.FieldByName('RoomCode').AsString;
end;

procedure TRolTmp.WriteRoomCode(pValue:Str15);
begin
  oTmpTable.FieldByName('RoomCode').AsString := pValue;
end;

function TRolTmp.ReadRoomName:Str30;
begin
  Result := oTmpTable.FieldByName('RoomName').AsString;
end;

procedure TRolTmp.WriteRoomName(pValue:Str30);
begin
  oTmpTable.FieldByName('RoomName').AsString := pValue;
end;

function TRolTmp.ReadRoomType:Str1;
begin
  Result := oTmpTable.FieldByName('RoomType').AsString;
end;

procedure TRolTmp.WriteRoomType(pValue:Str1);
begin
  oTmpTable.FieldByName('RoomType').AsString := pValue;
end;

function TRolTmp.ReadBedCnt:longint;
begin
  Result := oTmpTable.FieldByName('BedCnt').AsInteger;
end;

procedure TRolTmp.WriteBedCnt(pValue:longint);
begin
  oTmpTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TRolTmp.ReadAdbCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TRolTmp.WriteAdbCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TRolTmp.ReadFloor:longint;
begin
  Result := oTmpTable.FieldByName('Floor').AsInteger;
end;

procedure TRolTmp.WriteFloor(pValue:longint);
begin
  oTmpTable.FieldByName('Floor').AsInteger := pValue;
end;

function TRolTmp.ReadBlok:longint;
begin
  Result := oTmpTable.FieldByName('Blok').AsInteger;
end;

procedure TRolTmp.WriteBlok(pValue:longint);
begin
  oTmpTable.FieldByName('Blok').AsInteger := pValue;
end;

function TRolTmp.ReadDevice1:Str1;
begin
  Result := oTmpTable.FieldByName('Device1').AsString;
end;

procedure TRolTmp.WriteDevice1(pValue:Str1);
begin
  oTmpTable.FieldByName('Device1').AsString := pValue;
end;

function TRolTmp.ReadDevice2:Str1;
begin
  Result := oTmpTable.FieldByName('Device2').AsString;
end;

procedure TRolTmp.WriteDevice2(pValue:Str1);
begin
  oTmpTable.FieldByName('Device2').AsString := pValue;
end;

function TRolTmp.ReadDevice3:Str1;
begin
  Result := oTmpTable.FieldByName('Device3').AsString;
end;

procedure TRolTmp.WriteDevice3(pValue:Str1);
begin
  oTmpTable.FieldByName('Device3').AsString := pValue;
end;

function TRolTmp.ReadDevice4:Str1;
begin
  Result := oTmpTable.FieldByName('Device4').AsString;
end;

procedure TRolTmp.WriteDevice4(pValue:Str1);
begin
  oTmpTable.FieldByName('Device4').AsString := pValue;
end;

function TRolTmp.ReadDevice5:Str1;
begin
  Result := oTmpTable.FieldByName('Device5').AsString;
end;

procedure TRolTmp.WriteDevice5(pValue:Str1);
begin
  oTmpTable.FieldByName('Device5').AsString := pValue;
end;

function TRolTmp.ReadDevice6:Str1;
begin
  Result := oTmpTable.FieldByName('Device6').AsString;
end;

procedure TRolTmp.WriteDevice6(pValue:Str1);
begin
  oTmpTable.FieldByName('Device6').AsString := pValue;
end;

function TRolTmp.ReadDevice7:Str1;
begin
  Result := oTmpTable.FieldByName('Device7').AsString;
end;

procedure TRolTmp.WriteDevice7(pValue:Str1);
begin
  oTmpTable.FieldByName('Device7').AsString := pValue;
end;

function TRolTmp.ReadDevice8:Str1;
begin
  Result := oTmpTable.FieldByName('Device8').AsString;
end;

procedure TRolTmp.WriteDevice8(pValue:Str1);
begin
  oTmpTable.FieldByName('Device8').AsString := pValue;
end;

function TRolTmp.ReadDevice9:Str1;
begin
  Result := oTmpTable.FieldByName('Device9').AsString;
end;

procedure TRolTmp.WriteDevice9(pValue:Str1);
begin
  oTmpTable.FieldByName('Device9').AsString := pValue;
end;

function TRolTmp.ReadDevice10:Str1;
begin
  Result := oTmpTable.FieldByName('Device10').AsString;
end;

procedure TRolTmp.WriteDevice10(pValue:Str1);
begin
  oTmpTable.FieldByName('Device10').AsString := pValue;
end;

function TRolTmp.ReadBedPrice:double;
begin
  Result := oTmpTable.FieldByName('BedPrice').AsFloat;
end;

procedure TRolTmp.WriteBedPrice(pValue:double);
begin
  oTmpTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TRolTmp.ReadAdbPrice:double;
begin
  Result := oTmpTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TRolTmp.WriteAdbPrice(pValue:double);
begin
  oTmpTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TRolTmp.ReadRoomPrice:double;
begin
  Result := oTmpTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TRolTmp.WriteRoomPrice(pValue:double);
begin
  oTmpTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TRolTmp.ReadRoomPriceF:double;
begin
  Result := oTmpTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TRolTmp.WriteRoomPriceF(pValue:double);
begin
  oTmpTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TRolTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRolTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRolTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRolTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRolTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRolTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRolTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRolTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRolTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRolTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRolTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRolTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRolTmp.ReadExtension:Str5;
begin
  Result := oTmpTable.FieldByName('Extension').AsString;
end;

procedure TRolTmp.WriteExtension(pValue:Str5);
begin
  oTmpTable.FieldByName('Extension').AsString := pValue;
end;

function TRolTmp.ReadDevGsCode1:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode1').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode1(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode1').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode2:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode2').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode2(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode2').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode3:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode3').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode3(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode3').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode4:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode4').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode4(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode4').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode5:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode5').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode5(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode5').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode6:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode6').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode6(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode6').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode7:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode7').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode7(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode7').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode8:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode8').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode8(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode8').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode9:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode9').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode9(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode9').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsCode10:longint;
begin
  Result := oTmpTable.FieldByName('DevGsCode10').AsInteger;
end;

procedure TRolTmp.WriteDevGsCode10(pValue:longint);
begin
  oTmpTable.FieldByName('DevGsCode10').AsInteger := pValue;
end;

function TRolTmp.ReadDevGsPrc1:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc1').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc1(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc1').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc2:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc2').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc2(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc2').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc3:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc3').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc3(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc3').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc4:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc4').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc4(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc4').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc5:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc5').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc5(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc5').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc6:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc6').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc6(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc6').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc7:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc7').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc7(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc7').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc8:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc8').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc8(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc8').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc9:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc9').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc9(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc9').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsPrc10:double;
begin
  Result := oTmpTable.FieldByName('DevGsPrc10').AsFloat;
end;

procedure TRolTmp.WriteDevGsPrc10(pValue:double);
begin
  oTmpTable.FieldByName('DevGsPrc10').AsFloat := pValue;
end;

function TRolTmp.ReadDevGsName1:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName1').AsString;
end;

procedure TRolTmp.WriteDevGsName1(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName1').AsString := pValue;
end;

function TRolTmp.ReadDevGsName2:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName2').AsString;
end;

procedure TRolTmp.WriteDevGsName2(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName2').AsString := pValue;
end;

function TRolTmp.ReadDevGsName3:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName3').AsString;
end;

procedure TRolTmp.WriteDevGsName3(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName3').AsString := pValue;
end;

function TRolTmp.ReadDevGsName4:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName4').AsString;
end;

procedure TRolTmp.WriteDevGsName4(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName4').AsString := pValue;
end;

function TRolTmp.ReadDevGsName5:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName5').AsString;
end;

procedure TRolTmp.WriteDevGsName5(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName5').AsString := pValue;
end;

function TRolTmp.ReadDevGsName6:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName6').AsString;
end;

procedure TRolTmp.WriteDevGsName6(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName6').AsString := pValue;
end;

function TRolTmp.ReadDevGsName7:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName7').AsString;
end;

procedure TRolTmp.WriteDevGsName7(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName7').AsString := pValue;
end;

function TRolTmp.ReadDevGsName8:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName8').AsString;
end;

procedure TRolTmp.WriteDevGsName8(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName8').AsString := pValue;
end;

function TRolTmp.ReadDevGsName9:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName9').AsString;
end;

procedure TRolTmp.WriteDevGsName9(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName9').AsString := pValue;
end;

function TRolTmp.ReadDevGsName10:Str30;
begin
  Result := oTmpTable.FieldByName('DevGsName10').AsString;
end;

procedure TRolTmp.WriteDevGsName10(pValue:Str30);
begin
  oTmpTable.FieldByName('DevGsName10').AsString := pValue;
end;

function TRolTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRolTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRolTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRolTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRolTmp.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oTmpTable.FindKey([pRoomNum]);
end;

function TRolTmp.LocateRoomCode (pRoomCode:Str15):boolean;
begin
  SetIndex (ixRoomCode);
  Result := oTmpTable.FindKey([pRoomCode]);
end;

procedure TRolTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRolTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRolTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRolTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRolTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRolTmp.First;
begin
  oTmpTable.First;
end;

procedure TRolTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRolTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRolTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRolTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRolTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRolTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRolTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRolTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRolTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRolTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRolTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
