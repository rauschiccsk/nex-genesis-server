unit tOCIVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOdOi = '';
  ixGsCode = 'GsCode';

type
  TOciverTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadOcdCrtUser:Str8;       procedure WriteOcdCrtUser (pValue:Str8);
    function  ReadOcdCrtDate:TDatetime;  procedure WriteOcdCrtDate (pValue:TDatetime);
    function  ReadOcdCrtTime:TDatetime;  procedure WriteOcdCrtTime (pValue:TDatetime);
    function  ReadOcdModUser:Str8;       procedure WriteOcdModUser (pValue:Str8);
    function  ReadOcdModDate:TDatetime;  procedure WriteOcdModDate (pValue:TDatetime);
    function  ReadOcdModTime:TDatetime;  procedure WriteOcdModTime (pValue:TDatetime);
    function  ReadOcdStat:Str1;          procedure WriteOcdStat (pValue:Str1);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadOsdCrtUser:Str8;       procedure WriteOsdCrtUser (pValue:Str8);
    function  ReadOsdCrtDate:TDatetime;  procedure WriteOsdCrtDate (pValue:TDatetime);
    function  ReadOsdCrtTime:TDatetime;  procedure WriteOsdCrtTime (pValue:TDatetime);
    function  ReadOsdModUser:Str8;       procedure WriteOsdModUser (pValue:Str8);
    function  ReadOsdModDate:TDatetime;  procedure WriteOsdModDate (pValue:TDatetime);
    function  ReadOsdModTime:TDatetime;  procedure WriteOsdModTime (pValue:TDatetime);
    function  ReadOsdStat:Str1;          procedure WriteOsdStat (pValue:Str1);
    function  ReadTsdNum:Str12;          procedure WriteTsdNum (pValue:Str12);
    function  ReadTsdItm:word;           procedure WriteTsdItm (pValue:word);
    function  ReadTsdCrtUser:Str8;       procedure WriteTsdCrtUser (pValue:Str8);
    function  ReadTsdCrtDate:TDatetime;  procedure WriteTsdCrtDate (pValue:TDatetime);
    function  ReadTsdCrtTime:TDatetime;  procedure WriteTsdCrtTime (pValue:TDatetime);
    function  ReadTsdModUser:Str8;       procedure WriteTsdModUser (pValue:Str8);
    function  ReadTsdModDate:TDatetime;  procedure WriteTsdModDate (pValue:TDatetime);
    function  ReadTsdModTime:TDatetime;  procedure WriteTsdModTime (pValue:TDatetime);
    function  ReadTsdStat:Str1;          procedure WriteTsdStat (pValue:Str1);
    function  ReadTimNum:Str12;          procedure WriteTimNum (pValue:Str12);
    function  ReadTimItm:word;           procedure WriteTimItm (pValue:word);
    function  ReadTimCrtUser:Str8;       procedure WriteTimCrtUser (pValue:Str8);
    function  ReadTimCrtDate:TDatetime;  procedure WriteTimCrtDate (pValue:TDatetime);
    function  ReadTimCrtTime:TDatetime;  procedure WriteTimCrtTime (pValue:TDatetime);
    function  ReadTimModUser:Str8;       procedure WriteTimModUser (pValue:Str8);
    function  ReadTimModDate:TDatetime;  procedure WriteTimModDate (pValue:TDatetime);
    function  ReadTimModTime:TDatetime;  procedure WriteTimModTime (pValue:TDatetime);
    function  ReadTimStat:Str1;          procedure WriteTimStat (pValue:Str1);
    function  ReadStoCrtUser:Str8;       procedure WriteStoCrtUser (pValue:Str8);
    function  ReadStoCrtDate:TDatetime;  procedure WriteStoCrtDate (pValue:TDatetime);
    function  ReadStoCrtTime:TDatetime;  procedure WriteStoCrtTime (pValue:TDatetime);
    function  ReadStoModUser:Str8;       procedure WriteStoModUser (pValue:Str8);
    function  ReadStoModDate:TDatetime;  procedure WriteStoModDate (pValue:TDatetime);
    function  ReadStoModTime:TDatetime;  procedure WriteStoModTime (pValue:TDatetime);
    function  ReadStoStat:Str1;          procedure WriteStoStat (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadOrdType:Str1;          procedure WriteOrdType (pValue:Str1);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadAcqMode:Str1;          procedure WriteAcqMode (pValue:Str1);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTcdCrtUser:Str8;       procedure WriteTcdCrtUser (pValue:Str8);
    function  ReadTcdCrtDate:TDatetime;  procedure WriteTcdCrtDate (pValue:TDatetime);
    function  ReadTcdCrtTime:TDatetime;  procedure WriteTcdCrtTime (pValue:TDatetime);
    function  ReadTcdModUser:Str8;       procedure WriteTcdModUser (pValue:Str8);
    function  ReadTcdModDate:TDatetime;  procedure WriteTcdModDate (pValue:TDatetime);
    function  ReadTcdModTime:TDatetime;  procedure WriteTcdModTime (pValue:TDatetime);
    function  ReadTcdStat:Str1;          procedure WriteTcdStat (pValue:Str1);
    function  ReadTcdQnt:double;         procedure WriteTcdQnt (pValue:double);
    function  ReadTodNum:Str12;          procedure WriteTodNum (pValue:Str12);
    function  ReadTodItm:word;           procedure WriteTodItm (pValue:word);
    function  ReadTodCrtUser:Str8;       procedure WriteTodCrtUser (pValue:Str8);
    function  ReadTodCrtDate:TDatetime;  procedure WriteTodCrtDate (pValue:TDatetime);
    function  ReadTodCrtTime:TDatetime;  procedure WriteTodCrtTime (pValue:TDatetime);
    function  ReadTodModUser:Str8;       procedure WriteTodModUser (pValue:Str8);
    function  ReadTodModDate:TDatetime;  procedure WriteTodModDate (pValue:TDatetime);
    function  ReadTodModTime:TDatetime;  procedure WriteTodModTime (pValue:TDatetime);
    function  ReadTodStat:Str1;          procedure WriteTodStat (pValue:Str1);
    function  ReadTodQnt:double;         procedure WriteTodQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateOdOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property OcdCrtUser:Str8 read ReadOcdCrtUser write WriteOcdCrtUser;
    property OcdCrtDate:TDatetime read ReadOcdCrtDate write WriteOcdCrtDate;
    property OcdCrtTime:TDatetime read ReadOcdCrtTime write WriteOcdCrtTime;
    property OcdModUser:Str8 read ReadOcdModUser write WriteOcdModUser;
    property OcdModDate:TDatetime read ReadOcdModDate write WriteOcdModDate;
    property OcdModTime:TDatetime read ReadOcdModTime write WriteOcdModTime;
    property OcdStat:Str1 read ReadOcdStat write WriteOcdStat;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property OsdCrtUser:Str8 read ReadOsdCrtUser write WriteOsdCrtUser;
    property OsdCrtDate:TDatetime read ReadOsdCrtDate write WriteOsdCrtDate;
    property OsdCrtTime:TDatetime read ReadOsdCrtTime write WriteOsdCrtTime;
    property OsdModUser:Str8 read ReadOsdModUser write WriteOsdModUser;
    property OsdModDate:TDatetime read ReadOsdModDate write WriteOsdModDate;
    property OsdModTime:TDatetime read ReadOsdModTime write WriteOsdModTime;
    property OsdStat:Str1 read ReadOsdStat write WriteOsdStat;
    property TsdNum:Str12 read ReadTsdNum write WriteTsdNum;
    property TsdItm:word read ReadTsdItm write WriteTsdItm;
    property TsdCrtUser:Str8 read ReadTsdCrtUser write WriteTsdCrtUser;
    property TsdCrtDate:TDatetime read ReadTsdCrtDate write WriteTsdCrtDate;
    property TsdCrtTime:TDatetime read ReadTsdCrtTime write WriteTsdCrtTime;
    property TsdModUser:Str8 read ReadTsdModUser write WriteTsdModUser;
    property TsdModDate:TDatetime read ReadTsdModDate write WriteTsdModDate;
    property TsdModTime:TDatetime read ReadTsdModTime write WriteTsdModTime;
    property TsdStat:Str1 read ReadTsdStat write WriteTsdStat;
    property TimNum:Str12 read ReadTimNum write WriteTimNum;
    property TimItm:word read ReadTimItm write WriteTimItm;
    property TimCrtUser:Str8 read ReadTimCrtUser write WriteTimCrtUser;
    property TimCrtDate:TDatetime read ReadTimCrtDate write WriteTimCrtDate;
    property TimCrtTime:TDatetime read ReadTimCrtTime write WriteTimCrtTime;
    property TimModUser:Str8 read ReadTimModUser write WriteTimModUser;
    property TimModDate:TDatetime read ReadTimModDate write WriteTimModDate;
    property TimModTime:TDatetime read ReadTimModTime write WriteTimModTime;
    property TimStat:Str1 read ReadTimStat write WriteTimStat;
    property StoCrtUser:Str8 read ReadStoCrtUser write WriteStoCrtUser;
    property StoCrtDate:TDatetime read ReadStoCrtDate write WriteStoCrtDate;
    property StoCrtTime:TDatetime read ReadStoCrtTime write WriteStoCrtTime;
    property StoModUser:Str8 read ReadStoModUser write WriteStoModUser;
    property StoModDate:TDatetime read ReadStoModDate write WriteStoModDate;
    property StoModTime:TDatetime read ReadStoModTime write WriteStoModTime;
    property StoStat:Str1 read ReadStoStat write WriteStoStat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property OrdType:Str1 read ReadOrdType write WriteOrdType;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property AcqMode:Str1 read ReadAcqMode write WriteAcqMode;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TcdCrtUser:Str8 read ReadTcdCrtUser write WriteTcdCrtUser;
    property TcdCrtDate:TDatetime read ReadTcdCrtDate write WriteTcdCrtDate;
    property TcdCrtTime:TDatetime read ReadTcdCrtTime write WriteTcdCrtTime;
    property TcdModUser:Str8 read ReadTcdModUser write WriteTcdModUser;
    property TcdModDate:TDatetime read ReadTcdModDate write WriteTcdModDate;
    property TcdModTime:TDatetime read ReadTcdModTime write WriteTcdModTime;
    property TcdStat:Str1 read ReadTcdStat write WriteTcdStat;
    property TcdQnt:double read ReadTcdQnt write WriteTcdQnt;
    property TodNum:Str12 read ReadTodNum write WriteTodNum;
    property TodItm:word read ReadTodItm write WriteTodItm;
    property TodCrtUser:Str8 read ReadTodCrtUser write WriteTodCrtUser;
    property TodCrtDate:TDatetime read ReadTodCrtDate write WriteTodCrtDate;
    property TodCrtTime:TDatetime read ReadTodCrtTime write WriteTodCrtTime;
    property TodModUser:Str8 read ReadTodModUser write WriteTodModUser;
    property TodModDate:TDatetime read ReadTodModDate write WriteTodModDate;
    property TodModTime:TDatetime read ReadTodModTime write WriteTodModTime;
    property TodStat:Str1 read ReadTodStat write WriteTodStat;
    property TodQnt:double read ReadTodQnt write WriteTodQnt;
  end;

implementation

constructor TOciverTmp.Create;
begin
  oTmpTable := TmpInit ('OCIVER',Self);
end;

destructor TOciverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOciverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOciverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOciverTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOciverTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TOciverTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TOciverTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TOciverTmp.ReadOcdCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('OcdCrtUser').AsString;
end;

procedure TOciverTmp.WriteOcdCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('OcdCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadOcdCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OcdCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteOcdCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadOcdCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('OcdCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteOcdCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadOcdModUser:Str8;
begin
  Result := oTmpTable.FieldByName('OcdModUser').AsString;
end;

procedure TOciverTmp.WriteOcdModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('OcdModUser').AsString := pValue;
end;

function TOciverTmp.ReadOcdModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OcdModDate').AsDateTime;
end;

procedure TOciverTmp.WriteOcdModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadOcdModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('OcdModTime').AsDateTime;
end;

procedure TOciverTmp.WriteOcdModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadOcdStat:Str1;
begin
  Result := oTmpTable.FieldByName('OcdStat').AsString;
end;

procedure TOciverTmp.WriteOcdStat(pValue:Str1);
begin
  oTmpTable.FieldByName('OcdStat').AsString := pValue;
end;

function TOciverTmp.ReadOsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TOciverTmp.WriteOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString := pValue;
end;

function TOciverTmp.ReadOsdItm:word;
begin
  Result := oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOciverTmp.WriteOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TOciverTmp.ReadOsdCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('OsdCrtUser').AsString;
end;

procedure TOciverTmp.WriteOsdCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('OsdCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadOsdCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteOsdCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadOsdCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteOsdCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadOsdModUser:Str8;
begin
  Result := oTmpTable.FieldByName('OsdModUser').AsString;
end;

procedure TOciverTmp.WriteOsdModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('OsdModUser').AsString := pValue;
end;

function TOciverTmp.ReadOsdModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdModDate').AsDateTime;
end;

procedure TOciverTmp.WriteOsdModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadOsdModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdModTime').AsDateTime;
end;

procedure TOciverTmp.WriteOsdModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadOsdStat:Str1;
begin
  Result := oTmpTable.FieldByName('OsdStat').AsString;
end;

procedure TOciverTmp.WriteOsdStat(pValue:Str1);
begin
  oTmpTable.FieldByName('OsdStat').AsString := pValue;
end;

function TOciverTmp.ReadTsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOciverTmp.WriteTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TOciverTmp.ReadTsdItm:word;
begin
  Result := oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOciverTmp.WriteTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger := pValue;
end;

function TOciverTmp.ReadTsdCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('TsdCrtUser').AsString;
end;

procedure TOciverTmp.WriteTsdCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TsdCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadTsdCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteTsdCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTsdCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteTsdCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTsdModUser:Str8;
begin
  Result := oTmpTable.FieldByName('TsdModUser').AsString;
end;

procedure TOciverTmp.WriteTsdModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TsdModUser').AsString := pValue;
end;

function TOciverTmp.ReadTsdModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdModDate').AsDateTime;
end;

procedure TOciverTmp.WriteTsdModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTsdModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdModTime').AsDateTime;
end;

procedure TOciverTmp.WriteTsdModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTsdStat:Str1;
begin
  Result := oTmpTable.FieldByName('TsdStat').AsString;
end;

procedure TOciverTmp.WriteTsdStat(pValue:Str1);
begin
  oTmpTable.FieldByName('TsdStat').AsString := pValue;
end;

function TOciverTmp.ReadTimNum:Str12;
begin
  Result := oTmpTable.FieldByName('TimNum').AsString;
end;

procedure TOciverTmp.WriteTimNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TimNum').AsString := pValue;
end;

function TOciverTmp.ReadTimItm:word;
begin
  Result := oTmpTable.FieldByName('TimItm').AsInteger;
end;

procedure TOciverTmp.WriteTimItm(pValue:word);
begin
  oTmpTable.FieldByName('TimItm').AsInteger := pValue;
end;

function TOciverTmp.ReadTimCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('TimCrtUser').AsString;
end;

procedure TOciverTmp.WriteTimCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TimCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadTimCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TimCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteTimCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TimCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTimCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TimCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteTimCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TimCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTimModUser:Str8;
begin
  Result := oTmpTable.FieldByName('TimModUser').AsString;
end;

procedure TOciverTmp.WriteTimModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TimModUser').AsString := pValue;
end;

function TOciverTmp.ReadTimModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TimModDate').AsDateTime;
end;

procedure TOciverTmp.WriteTimModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TimModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTimModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TimModTime').AsDateTime;
end;

procedure TOciverTmp.WriteTimModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TimModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTimStat:Str1;
begin
  Result := oTmpTable.FieldByName('TimStat').AsString;
end;

procedure TOciverTmp.WriteTimStat(pValue:Str1);
begin
  oTmpTable.FieldByName('TimStat').AsString := pValue;
end;

function TOciverTmp.ReadStoCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('StoCrtUser').AsString;
end;

procedure TOciverTmp.WriteStoCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('StoCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadStoCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('StoCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteStoCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('StoCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadStoCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('StoCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteStoCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('StoCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadStoModUser:Str8;
begin
  Result := oTmpTable.FieldByName('StoModUser').AsString;
end;

procedure TOciverTmp.WriteStoModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('StoModUser').AsString := pValue;
end;

function TOciverTmp.ReadStoModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('StoModDate').AsDateTime;
end;

procedure TOciverTmp.WriteStoModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('StoModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadStoModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('StoModTime').AsDateTime;
end;

procedure TOciverTmp.WriteStoModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('StoModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadStoStat:Str1;
begin
  Result := oTmpTable.FieldByName('StoStat').AsString;
end;

procedure TOciverTmp.WriteStoStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StoStat').AsString := pValue;
end;

function TOciverTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TOciverTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOciverTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TOciverTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TOciverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOciverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOciverTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TOciverTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TOciverTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TOciverTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadResQnt:double;
begin
  Result := oTmpTable.FieldByName('ResQnt').AsFloat;
end;

procedure TOciverTmp.WriteResQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadNrsQnt:double;
begin
  Result := oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TOciverTmp.WriteNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOciverTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadOrdType:Str1;
begin
  Result := oTmpTable.FieldByName('OrdType').AsString;
end;

procedure TOciverTmp.WriteOrdType(pValue:Str1);
begin
  oTmpTable.FieldByName('OrdType').AsString := pValue;
end;

function TOciverTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TOciverTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TOciverTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOciverTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadAcqMode:Str1;
begin
  Result := oTmpTable.FieldByName('AcqMode').AsString;
end;

procedure TOciverTmp.WriteAcqMode(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqMode').AsString := pValue;
end;

function TOciverTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TOciverTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TOciverTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TOciverTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TOciverTmp.ReadTcdItm:word;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOciverTmp.WriteTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TOciverTmp.ReadTcdCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('TcdCrtUser').AsString;
end;

procedure TOciverTmp.WriteTcdCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TcdCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadTcdCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteTcdCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTcdCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteTcdCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTcdModUser:Str8;
begin
  Result := oTmpTable.FieldByName('TcdModUser').AsString;
end;

procedure TOciverTmp.WriteTcdModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TcdModUser').AsString := pValue;
end;

function TOciverTmp.ReadTcdModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdModDate').AsDateTime;
end;

procedure TOciverTmp.WriteTcdModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTcdModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdModTime').AsDateTime;
end;

procedure TOciverTmp.WriteTcdModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTcdStat:Str1;
begin
  Result := oTmpTable.FieldByName('TcdStat').AsString;
end;

procedure TOciverTmp.WriteTcdStat(pValue:Str1);
begin
  oTmpTable.FieldByName('TcdStat').AsString := pValue;
end;

function TOciverTmp.ReadTcdQnt:double;
begin
  Result := oTmpTable.FieldByName('TcdQnt').AsFloat;
end;

procedure TOciverTmp.WriteTcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('TcdQnt').AsFloat := pValue;
end;

function TOciverTmp.ReadTodNum:Str12;
begin
  Result := oTmpTable.FieldByName('TodNum').AsString;
end;

procedure TOciverTmp.WriteTodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TodNum').AsString := pValue;
end;

function TOciverTmp.ReadTodItm:word;
begin
  Result := oTmpTable.FieldByName('TodItm').AsInteger;
end;

procedure TOciverTmp.WriteTodItm(pValue:word);
begin
  oTmpTable.FieldByName('TodItm').AsInteger := pValue;
end;

function TOciverTmp.ReadTodCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('TodCrtUser').AsString;
end;

procedure TOciverTmp.WriteTodCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TodCrtUser').AsString := pValue;
end;

function TOciverTmp.ReadTodCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TodCrtDate').AsDateTime;
end;

procedure TOciverTmp.WriteTodCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TodCrtDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTodCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TodCrtTime').AsDateTime;
end;

procedure TOciverTmp.WriteTodCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TodCrtTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTodModUser:Str8;
begin
  Result := oTmpTable.FieldByName('TodModUser').AsString;
end;

procedure TOciverTmp.WriteTodModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('TodModUser').AsString := pValue;
end;

function TOciverTmp.ReadTodModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TodModDate').AsDateTime;
end;

procedure TOciverTmp.WriteTodModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TodModDate').AsDateTime := pValue;
end;

function TOciverTmp.ReadTodModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('TodModTime').AsDateTime;
end;

procedure TOciverTmp.WriteTodModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TodModTime').AsDateTime := pValue;
end;

function TOciverTmp.ReadTodStat:Str1;
begin
  Result := oTmpTable.FieldByName('TodStat').AsString;
end;

procedure TOciverTmp.WriteTodStat(pValue:Str1);
begin
  oTmpTable.FieldByName('TodStat').AsString := pValue;
end;

function TOciverTmp.ReadTodQnt:double;
begin
  Result := oTmpTable.FieldByName('TodQnt').AsFloat;
end;

procedure TOciverTmp.WriteTodQnt(pValue:double);
begin
  oTmpTable.FieldByName('TodQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOciverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOciverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOciverTmp.LocateOdOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result := oTmpTable.FindKey([pOcdNum,pOcdItm]);
end;

function TOciverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TOciverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOciverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOciverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOciverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOciverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOciverTmp.First;
begin
  oTmpTable.First;
end;

procedure TOciverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOciverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOciverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOciverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOciverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOciverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOciverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOciverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOciverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOciverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOciverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
