unit bREGCER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegNum = 'RegNum';
  ixUpaCode = 'UpaCode';
  ixUpaName = 'UpaName';
  ixUpaIno = 'UpaIno';
  ixDpaCode = 'DpaCode';

type
  TRegcerBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRegNum:Str12;          procedure WriteRegNum (pValue:Str12);
    function  ReadRegKey:Str20;          procedure WriteRegKey (pValue:Str20);
    function  ReadSystem:Str1;           procedure WriteSystem (pValue:Str1);
    function  ReadSpcMark:Str10;         procedure WriteSpcMark (pValue:Str10);
    function  ReadCerDate:TDatetime;     procedure WriteCerDate (pValue:TDatetime);
    function  ReadUpaCode:longint;       procedure WriteUpaCode (pValue:longint);
    function  ReadUpaName:Str30;         procedure WriteUpaName (pValue:Str30);
    function  ReadUpaName_:Str30;        procedure WriteUpaName_ (pValue:Str30);
    function  ReadUpaRegn:Str60;         procedure WriteUpaRegn (pValue:Str60);
    function  ReadUpaAddr:Str30;         procedure WriteUpaAddr (pValue:Str30);
    function  ReadUpaZip:Str15;          procedure WriteUpaZip (pValue:Str15);
    function  ReadUpaCty:Str3;           procedure WriteUpaCty (pValue:Str3);
    function  ReadUpaCtn:Str30;          procedure WriteUpaCtn (pValue:Str30);
    function  ReadUpaSta:Str2;           procedure WriteUpaSta (pValue:Str2);
    function  ReadUpaStn:Str30;          procedure WriteUpaStn (pValue:Str30);
    function  ReadUpaIno:Str10;          procedure WriteUpaIno (pValue:Str10);
    function  ReadUpaTin:Str15;          procedure WriteUpaTin (pValue:Str15);
    function  ReadUpaVin:Str15;          procedure WriteUpaVin (pValue:Str15);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str30;         procedure WriteWpaName (pValue:Str30);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaStn:Str30;          procedure WriteWpaStn (pValue:Str30);
    function  ReadDpaCode:longint;       procedure WriteDpaCode (pValue:longint);
    function  ReadDpaName:Str30;         procedure WriteDpaName (pValue:Str30);
    function  ReadDpaRegn:Str60;         procedure WriteDpaRegn (pValue:Str60);
    function  ReadDpaZip:Str15;          procedure WriteDpaZip (pValue:Str15);
    function  ReadDpaCty:Str3;           procedure WriteDpaCty (pValue:Str3);
    function  ReadDpaCtn:Str30;          procedure WriteDpaCtn (pValue:Str30);
    function  ReadDpaSta:Str2;           procedure WriteDpaSta (pValue:Str2);
    function  ReadDpaStn:Str30;          procedure WriteDpaStn (pValue:Str30);
    function  ReadDpaIno:Str10;          procedure WriteDpaIno (pValue:Str10);
    function  ReadDpaTin:Str15;          procedure WriteDpaTin (pValue:Str15);
    function  ReadDpaVin:Str15;          procedure WriteDpaVin (pValue:Str15);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDpaAddr:Str30;         procedure WriteDpaAddr (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateRegNum (pRegNum:Str12):boolean;
    function LocateUpaCode (pUpaCode:longint):boolean;
    function LocateUpaName (pUpaName_:Str30):boolean;
    function LocateUpaIno (pUpaIno:Str10):boolean;
    function LocateDpaCode (pDpaCode:longint):boolean;
    function NearestRegNum (pRegNum:Str12):boolean;
    function NearestUpaCode (pUpaCode:longint):boolean;
    function NearestUpaName (pUpaName_:Str30):boolean;
    function NearestUpaIno (pUpaIno:Str10):boolean;
    function NearestDpaCode (pDpaCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
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
    property RegNum:Str12 read ReadRegNum write WriteRegNum;
    property RegKey:Str20 read ReadRegKey write WriteRegKey;
    property System:Str1 read ReadSystem write WriteSystem;
    property SpcMark:Str10 read ReadSpcMark write WriteSpcMark;
    property CerDate:TDatetime read ReadCerDate write WriteCerDate;
    property UpaCode:longint read ReadUpaCode write WriteUpaCode;
    property UpaName:Str30 read ReadUpaName write WriteUpaName;
    property UpaName_:Str30 read ReadUpaName_ write WriteUpaName_;
    property UpaRegn:Str60 read ReadUpaRegn write WriteUpaRegn;
    property UpaAddr:Str30 read ReadUpaAddr write WriteUpaAddr;
    property UpaZip:Str15 read ReadUpaZip write WriteUpaZip;
    property UpaCty:Str3 read ReadUpaCty write WriteUpaCty;
    property UpaCtn:Str30 read ReadUpaCtn write WriteUpaCtn;
    property UpaSta:Str2 read ReadUpaSta write WriteUpaSta;
    property UpaStn:Str30 read ReadUpaStn write WriteUpaStn;
    property UpaIno:Str10 read ReadUpaIno write WriteUpaIno;
    property UpaTin:Str15 read ReadUpaTin write WriteUpaTin;
    property UpaVin:Str15 read ReadUpaVin write WriteUpaVin;
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str30 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaStn:Str30 read ReadWpaStn write WriteWpaStn;
    property DpaCode:longint read ReadDpaCode write WriteDpaCode;
    property DpaName:Str30 read ReadDpaName write WriteDpaName;
    property DpaRegn:Str60 read ReadDpaRegn write WriteDpaRegn;
    property DpaZip:Str15 read ReadDpaZip write WriteDpaZip;
    property DpaCty:Str3 read ReadDpaCty write WriteDpaCty;
    property DpaCtn:Str30 read ReadDpaCtn write WriteDpaCtn;
    property DpaSta:Str2 read ReadDpaSta write WriteDpaSta;
    property DpaStn:Str30 read ReadDpaStn write WriteDpaStn;
    property DpaIno:Str10 read ReadDpaIno write WriteDpaIno;
    property DpaTin:Str15 read ReadDpaTin write WriteDpaTin;
    property DpaVin:Str15 read ReadDpaVin write WriteDpaVin;
    property Notice:Str60 read ReadNotice write WriteNotice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DpaAddr:Str30 read ReadDpaAddr write WriteDpaAddr;
  end;

implementation

constructor TRegcerBtr.Create;
begin
  oBtrTable := BtrInit ('REGCER',gPath.CdwPath,Self);
end;

constructor TRegcerBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('REGCER',pPath,Self);
end;

destructor TRegcerBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRegcerBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRegcerBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRegcerBtr.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

procedure TRegcerBtr.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

function TRegcerBtr.ReadRegKey:Str20;
begin
  Result := oBtrTable.FieldByName('RegKey').AsString;
end;

procedure TRegcerBtr.WriteRegKey(pValue:Str20);
begin
  oBtrTable.FieldByName('RegKey').AsString := pValue;
end;

function TRegcerBtr.ReadSystem:Str1;
begin
  Result := oBtrTable.FieldByName('System').AsString;
end;

procedure TRegcerBtr.WriteSystem(pValue:Str1);
begin
  oBtrTable.FieldByName('System').AsString := pValue;
end;

function TRegcerBtr.ReadSpcMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpcMark').AsString;
end;

procedure TRegcerBtr.WriteSpcMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpcMark').AsString := pValue;
end;

function TRegcerBtr.ReadCerDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CerDate').AsDateTime;
end;

procedure TRegcerBtr.WriteCerDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CerDate').AsDateTime := pValue;
end;

function TRegcerBtr.ReadUpaCode:longint;
begin
  Result := oBtrTable.FieldByName('UpaCode').AsInteger;
end;

procedure TRegcerBtr.WriteUpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('UpaCode').AsInteger := pValue;
end;

function TRegcerBtr.ReadUpaName:Str30;
begin
  Result := oBtrTable.FieldByName('UpaName').AsString;
end;

procedure TRegcerBtr.WriteUpaName(pValue:Str30);
begin
  oBtrTable.FieldByName('UpaName').AsString := pValue;
end;

function TRegcerBtr.ReadUpaName_:Str30;
begin
  Result := oBtrTable.FieldByName('UpaName_').AsString;
end;

procedure TRegcerBtr.WriteUpaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('UpaName_').AsString := pValue;
end;

function TRegcerBtr.ReadUpaRegn:Str60;
begin
  Result := oBtrTable.FieldByName('UpaRegn').AsString;
end;

procedure TRegcerBtr.WriteUpaRegn(pValue:Str60);
begin
  oBtrTable.FieldByName('UpaRegn').AsString := pValue;
end;

function TRegcerBtr.ReadUpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('UpaAddr').AsString;
end;

procedure TRegcerBtr.WriteUpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('UpaAddr').AsString := pValue;
end;

function TRegcerBtr.ReadUpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('UpaZip').AsString;
end;

procedure TRegcerBtr.WriteUpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('UpaZip').AsString := pValue;
end;

function TRegcerBtr.ReadUpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('UpaCty').AsString;
end;

procedure TRegcerBtr.WriteUpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('UpaCty').AsString := pValue;
end;

function TRegcerBtr.ReadUpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('UpaCtn').AsString;
end;

procedure TRegcerBtr.WriteUpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('UpaCtn').AsString := pValue;
end;

function TRegcerBtr.ReadUpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('UpaSta').AsString;
end;

procedure TRegcerBtr.WriteUpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('UpaSta').AsString := pValue;
end;

function TRegcerBtr.ReadUpaStn:Str30;
begin
  Result := oBtrTable.FieldByName('UpaStn').AsString;
end;

procedure TRegcerBtr.WriteUpaStn(pValue:Str30);
begin
  oBtrTable.FieldByName('UpaStn').AsString := pValue;
end;

function TRegcerBtr.ReadUpaIno:Str10;
begin
  Result := oBtrTable.FieldByName('UpaIno').AsString;
end;

procedure TRegcerBtr.WriteUpaIno(pValue:Str10);
begin
  oBtrTable.FieldByName('UpaIno').AsString := pValue;
end;

function TRegcerBtr.ReadUpaTin:Str15;
begin
  Result := oBtrTable.FieldByName('UpaTin').AsString;
end;

procedure TRegcerBtr.WriteUpaTin(pValue:Str15);
begin
  oBtrTable.FieldByName('UpaTin').AsString := pValue;
end;

function TRegcerBtr.ReadUpaVin:Str15;
begin
  Result := oBtrTable.FieldByName('UpaVin').AsString;
end;

procedure TRegcerBtr.WriteUpaVin(pValue:Str15);
begin
  oBtrTable.FieldByName('UpaVin').AsString := pValue;
end;

function TRegcerBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TRegcerBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TRegcerBtr.ReadWpaName:Str30;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TRegcerBtr.WriteWpaName(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TRegcerBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TRegcerBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TRegcerBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TRegcerBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TRegcerBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TRegcerBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TRegcerBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TRegcerBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TRegcerBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TRegcerBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TRegcerBtr.ReadWpaStn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaStn').AsString;
end;

procedure TRegcerBtr.WriteWpaStn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaStn').AsString := pValue;
end;

function TRegcerBtr.ReadDpaCode:longint;
begin
  Result := oBtrTable.FieldByName('DpaCode').AsInteger;
end;

procedure TRegcerBtr.WriteDpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('DpaCode').AsInteger := pValue;
end;

function TRegcerBtr.ReadDpaName:Str30;
begin
  Result := oBtrTable.FieldByName('DpaName').AsString;
end;

procedure TRegcerBtr.WriteDpaName(pValue:Str30);
begin
  oBtrTable.FieldByName('DpaName').AsString := pValue;
end;

function TRegcerBtr.ReadDpaRegn:Str60;
begin
  Result := oBtrTable.FieldByName('DpaRegn').AsString;
end;

procedure TRegcerBtr.WriteDpaRegn(pValue:Str60);
begin
  oBtrTable.FieldByName('DpaRegn').AsString := pValue;
end;

function TRegcerBtr.ReadDpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('DpaZip').AsString;
end;

procedure TRegcerBtr.WriteDpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('DpaZip').AsString := pValue;
end;

function TRegcerBtr.ReadDpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('DpaCty').AsString;
end;

procedure TRegcerBtr.WriteDpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('DpaCty').AsString := pValue;
end;

function TRegcerBtr.ReadDpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('DpaCtn').AsString;
end;

procedure TRegcerBtr.WriteDpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('DpaCtn').AsString := pValue;
end;

function TRegcerBtr.ReadDpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('DpaSta').AsString;
end;

procedure TRegcerBtr.WriteDpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('DpaSta').AsString := pValue;
end;

function TRegcerBtr.ReadDpaStn:Str30;
begin
  Result := oBtrTable.FieldByName('DpaStn').AsString;
end;

procedure TRegcerBtr.WriteDpaStn(pValue:Str30);
begin
  oBtrTable.FieldByName('DpaStn').AsString := pValue;
end;

function TRegcerBtr.ReadDpaIno:Str10;
begin
  Result := oBtrTable.FieldByName('DpaIno').AsString;
end;

procedure TRegcerBtr.WriteDpaIno(pValue:Str10);
begin
  oBtrTable.FieldByName('DpaIno').AsString := pValue;
end;

function TRegcerBtr.ReadDpaTin:Str15;
begin
  Result := oBtrTable.FieldByName('DpaTin').AsString;
end;

procedure TRegcerBtr.WriteDpaTin(pValue:Str15);
begin
  oBtrTable.FieldByName('DpaTin').AsString := pValue;
end;

function TRegcerBtr.ReadDpaVin:Str15;
begin
  Result := oBtrTable.FieldByName('DpaVin').AsString;
end;

procedure TRegcerBtr.WriteDpaVin(pValue:Str15);
begin
  oBtrTable.FieldByName('DpaVin').AsString := pValue;
end;

function TRegcerBtr.ReadNotice:Str60;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TRegcerBtr.WriteNotice(pValue:Str60);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TRegcerBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRegcerBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRegcerBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRegcerBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRegcerBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRegcerBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRegcerBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRegcerBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRegcerBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRegcerBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRegcerBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRegcerBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRegcerBtr.ReadDpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('DpaAddr').AsString;
end;

procedure TRegcerBtr.WriteDpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('DpaAddr').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegcerBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegcerBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRegcerBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegcerBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRegcerBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRegcerBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRegcerBtr.LocateRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindKey([pRegNum]);
end;

function TRegcerBtr.LocateUpaCode (pUpaCode:longint):boolean;
begin
  SetIndex (ixUpaCode);
  Result := oBtrTable.FindKey([pUpaCode]);
end;

function TRegcerBtr.LocateUpaName (pUpaName_:Str30):boolean;
begin
  SetIndex (ixUpaName);
  Result := oBtrTable.FindKey([StrToAlias(pUpaName_)]);
end;

function TRegcerBtr.LocateUpaIno (pUpaIno:Str10):boolean;
begin
  SetIndex (ixUpaIno);
  Result := oBtrTable.FindKey([pUpaIno]);
end;

function TRegcerBtr.LocateDpaCode (pDpaCode:longint):boolean;
begin
  SetIndex (ixDpaCode);
  Result := oBtrTable.FindKey([pDpaCode]);
end;

function TRegcerBtr.NearestRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindNearest([pRegNum]);
end;

function TRegcerBtr.NearestUpaCode (pUpaCode:longint):boolean;
begin
  SetIndex (ixUpaCode);
  Result := oBtrTable.FindNearest([pUpaCode]);
end;

function TRegcerBtr.NearestUpaName (pUpaName_:Str30):boolean;
begin
  SetIndex (ixUpaName);
  Result := oBtrTable.FindNearest([pUpaName_]);
end;

function TRegcerBtr.NearestUpaIno (pUpaIno:Str10):boolean;
begin
  SetIndex (ixUpaIno);
  Result := oBtrTable.FindNearest([pUpaIno]);
end;

function TRegcerBtr.NearestDpaCode (pDpaCode:longint):boolean;
begin
  SetIndex (ixDpaCode);
  Result := oBtrTable.FindNearest([pDpaCode]);
end;

procedure TRegcerBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRegcerBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRegcerBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRegcerBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRegcerBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRegcerBtr.First;
begin
  oBtrTable.First;
end;

procedure TRegcerBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRegcerBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRegcerBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRegcerBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRegcerBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRegcerBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRegcerBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRegcerBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRegcerBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRegcerBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRegcerBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
