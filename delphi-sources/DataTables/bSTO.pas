unit bSTO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixGsOrSt = 'GsOrSt';
  ixGsCode = 'GsCode';
  ixGsOrStPa = 'GsOrStPa';
  ixAcqMode = 'AcqMode';
  ixStkStat = 'StkStat';
  ixOdOi = 'OdOi';

type
  TStoBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadOrdType:Str1;          procedure WriteOrdType (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadAcqMode:Str1;          procedure WriteAcqMode (pValue:Str1);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadCnfDate:TDatetime;     procedure WriteCnfDate (pValue:TDatetime);
    function  ReadRqdDate:TDatetime;     procedure WriteRqdDate (pValue:TDatetime);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:longint;        procedure WriteOsdItm (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsOrSt (pGsCode:longint;pOrdType:Str1;pStkStat:Str1):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsOrStPa (pGsCode:longint;pOrdType:Str1;pStkStat:Str1;pPaCode:longint):boolean;
    function LocateAcqMode (pAcqMode:Str1):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateOdOi (pOsdNum:Str12;pOsdItm:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestGsOrSt (pGsCode:longint;pOrdType:Str1;pStkStat:Str1):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsOrStPa (pGsCode:longint;pOrdType:Str1;pStkStat:Str1;pPaCode:longint):boolean;
    function NearestAcqMode (pAcqMode:Str1):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestOdOi (pOsdNum:Str12;pOsdItm:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pStkNum:word);
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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property OrdType:Str1 read ReadOrdType write WriteOrdType;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property AcqMode:Str1 read ReadAcqMode write WriteAcqMode;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property CnfDate:TDatetime read ReadCnfDate write WriteCnfDate;
    property RqdDate:TDatetime read ReadRqdDate write WriteRqdDate;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:longint read ReadOsdItm write WriteOsdItm;
  end;

implementation

constructor TStoBtr.Create;
begin
  oBtrTable := BtrInit ('STO',gPath.StkPath,Self);
end;

constructor TStoBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STO',pPath,Self);
end;

destructor TStoBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStoBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStoBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStoBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TStoBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TStoBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStoBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStoBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStoBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStoBtr.ReadOrdType:Str1;
begin
  Result := oBtrTable.FieldByName('OrdType').AsString;
end;

procedure TStoBtr.WriteOrdType(pValue:Str1);
begin
  oBtrTable.FieldByName('OrdType').AsString := pValue;
end;

function TStoBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TStoBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStoBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TStoBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TStoBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TStoBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TStoBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TStoBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TStoBtr.ReadAcqMode:Str1;
begin
  Result := oBtrTable.FieldByName('AcqMode').AsString;
end;

procedure TStoBtr.WriteAcqMode(pValue:Str1);
begin
  oBtrTable.FieldByName('AcqMode').AsString := pValue;
end;

function TStoBtr.ReadResQnt:double;
begin
  Result := oBtrTable.FieldByName('ResQnt').AsFloat;
end;

procedure TStoBtr.WriteResQnt(pValue:double);
begin
  oBtrTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TStoBtr.ReadNrsQnt:double;
begin
  Result := oBtrTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TStoBtr.WriteNrsQnt(pValue:double);
begin
  oBtrTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TStoBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TStoBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TStoBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TStoBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStoBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStoBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStoBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStoBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TStoBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStoBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStoBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStoBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStoBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStoBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TStoBtr.ReadCnfDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CnfDate').AsDateTime;
end;

procedure TStoBtr.WriteCnfDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CnfDate').AsDateTime := pValue;
end;

function TStoBtr.ReadRqdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RqdDate').AsDateTime;
end;

procedure TStoBtr.WriteRqdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RqdDate').AsDateTime := pValue;
end;

function TStoBtr.ReadOsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OsdNum').AsString;
end;

procedure TStoBtr.WriteOsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OsdNum').AsString := pValue;
end;

function TStoBtr.ReadOsdItm:longint;
begin
  Result := oBtrTable.FieldByName('OsdItm').AsInteger;
end;

procedure TStoBtr.WriteOsdItm(pValue:longint);
begin
  oBtrTable.FieldByName('OsdItm').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStoBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStoBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStoBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStoBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStoBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStoBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStoBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TStoBtr.LocateGsOrSt (pGsCode:longint;pOrdType:Str1;pStkStat:Str1):boolean;
begin
  SetIndex (ixGsOrSt);
  Result := oBtrTable.FindKey([pGsCode,pOrdType,pStkStat]);
end;

function TStoBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStoBtr.LocateGsOrStPa (pGsCode:longint;pOrdType:Str1;pStkStat:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixGsOrStPa);
  Result := oBtrTable.FindKey([pGsCode,pOrdType,pStkStat,pPaCode]);
end;

function TStoBtr.LocateAcqMode (pAcqMode:Str1):boolean;
begin
  SetIndex (ixAcqMode);
  Result := oBtrTable.FindKey([pAcqMode]);
end;

function TStoBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TStoBtr.LocateOdOi (pOsdNum:Str12;pOsdItm:longint):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindKey([pOsdNum,pOsdItm]);
end;

function TStoBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TStoBtr.NearestGsOrSt (pGsCode:longint;pOrdType:Str1;pStkStat:Str1):boolean;
begin
  SetIndex (ixGsOrSt);
  Result := oBtrTable.FindNearest([pGsCode,pOrdType,pStkStat]);
end;

function TStoBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStoBtr.NearestGsOrStPa (pGsCode:longint;pOrdType:Str1;pStkStat:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixGsOrStPa);
  Result := oBtrTable.FindNearest([pGsCode,pOrdType,pStkStat,pPaCode]);
end;

function TStoBtr.NearestAcqMode (pAcqMode:Str1):boolean;
begin
  SetIndex (ixAcqMode);
  Result := oBtrTable.FindNearest([pAcqMode]);
end;

function TStoBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TStoBtr.NearestOdOi (pOsdNum:Str12;pOsdItm:longint):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindNearest([pOsdNum,pOsdItm]);
end;

procedure TStoBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStoBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TStoBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStoBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStoBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStoBtr.First;
begin
  oBtrTable.First;
end;

procedure TStoBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStoBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStoBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStoBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStoBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStoBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStoBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStoBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStoBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStoBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStoBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
