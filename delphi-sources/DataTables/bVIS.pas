unit bVIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixVisNum = 'VisNum';
  ixVisName = 'VisName';

type
  TVisBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadVisName:Str50;         procedure WriteVisName (pValue:Str50);
    function  ReadVisAdress:Str50;       procedure WriteVisAdress (pValue:Str50);
    function  ReadVisCtyName:Str20;      procedure WriteVisCtyName (pValue:Str20);
    function  ReadVisCtyCode:Str4;       procedure WriteVisCtyCode (pValue:Str4);
    function  ReadVisCtyZIP:Str6;        procedure WriteVisCtyZIP (pValue:Str6);
    function  ReadVisStaName:Str20;      procedure WriteVisStaName (pValue:Str20);
    function  ReadVisStaCode:Str4;       procedure WriteVisStaCode (pValue:Str4);
    function  ReadVisTelNum:Str30;       procedure WriteVisTelNum (pValue:Str30);
    function  ReadVisfaxNum:Str30;       procedure WriteVisfaxNum (pValue:Str30);
    function  ReadVisMobNum:Str30;       procedure WriteVisMobNum (pValue:Str30);
    function  ReadVisEMail:Str30;        procedure WriteVisEMail (pValue:Str30);
    function  ReadVisType:Str1;          procedure WriteVisType (pValue:Str1);
    function  ReadVisDocType:Str1;       procedure WriteVisDocType (pValue:Str1);
    function  ReadVisDocNum:Str30;       procedure WriteVisDocNum (pValue:Str30);
    function  ReadBirthDate:TDatetime;   procedure WriteBirthDate (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadBirthPlace:Str30;      procedure WriteBirthPlace (pValue:Str30);
    function  ReadCitizenship:Str30;     procedure WriteCitizenship (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadTitulBef:Str10;        procedure WriteTitulBef (pValue:Str10);
    function  ReadFirstName:Str15;       procedure WriteFirstName (pValue:Str15);
    function  ReadLastName:Str15;        procedure WriteLastName (pValue:Str15);
    function  ReadTitulAft:Str10;        procedure WriteTitulAft (pValue:Str10);
    function  ReadFunction:Str30;        procedure WriteFunction (pValue:Str30);
    function  ReadSexMark:Str1;          procedure WriteSexMark (pValue:Str1);
    function  ReadAccost:Str30;          procedure WriteAccost (pValue:Str30);
    function  ReadWorkTel:Str20;         procedure WriteWorkTel (pValue:Str20);
    function  ReadWorkSec:Str5;          procedure WriteWorkSec (pValue:Str5);
    function  ReadWorkEml:Str30;         procedure WriteWorkEml (pValue:Str30);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadMidName:Str15;         procedure WriteMidName (pValue:Str15);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateVisNum (pVisNum:longint):boolean;
    function LocateVisName (pVisName:Str50):boolean;
    function NearestVisNum (pVisNum:longint):boolean;
    function NearestVisName (pVisName:Str50):boolean;

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
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property VisName:Str50 read ReadVisName write WriteVisName;
    property VisAdress:Str50 read ReadVisAdress write WriteVisAdress;
    property VisCtyName:Str20 read ReadVisCtyName write WriteVisCtyName;
    property VisCtyCode:Str4 read ReadVisCtyCode write WriteVisCtyCode;
    property VisCtyZIP:Str6 read ReadVisCtyZIP write WriteVisCtyZIP;
    property VisStaName:Str20 read ReadVisStaName write WriteVisStaName;
    property VisStaCode:Str4 read ReadVisStaCode write WriteVisStaCode;
    property VisTelNum:Str30 read ReadVisTelNum write WriteVisTelNum;
    property VisfaxNum:Str30 read ReadVisfaxNum write WriteVisfaxNum;
    property VisMobNum:Str30 read ReadVisMobNum write WriteVisMobNum;
    property VisEMail:Str30 read ReadVisEMail write WriteVisEMail;
    property VisType:Str1 read ReadVisType write WriteVisType;
    property VisDocType:Str1 read ReadVisDocType write WriteVisDocType;
    property VisDocNum:Str30 read ReadVisDocNum write WriteVisDocNum;
    property BirthDate:TDatetime read ReadBirthDate write WriteBirthDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property BirthPlace:Str30 read ReadBirthPlace write WriteBirthPlace;
    property Citizenship:Str30 read ReadCitizenship write WriteCitizenship;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property TitulBef:Str10 read ReadTitulBef write WriteTitulBef;
    property FirstName:Str15 read ReadFirstName write WriteFirstName;
    property LastName:Str15 read ReadLastName write WriteLastName;
    property TitulAft:Str10 read ReadTitulAft write WriteTitulAft;
    property Function:Str30 read ReadFunction write WriteFunction;
    property SexMark:Str1 read ReadSexMark write WriteSexMark;
    property Accost:Str30 read ReadAccost write WriteAccost;
    property WorkTel:Str20 read ReadWorkTel write WriteWorkTel;
    property WorkSec:Str5 read ReadWorkSec write WriteWorkSec;
    property WorkEml:Str30 read ReadWorkEml write WriteWorkEml;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property MidName:Str15 read ReadMidName write WriteMidName;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TVisBtr.Create;
begin
  oBtrTable := BtrInit ('VIS',gPath.HtlPath,Self);
end;

constructor TVisBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VIS',pPath,Self);
end;

destructor TVisBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVisBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVisBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVisBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TVisBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TVisBtr.ReadVisName:Str50;
begin
  Result := oBtrTable.FieldByName('VisName').AsString;
end;

procedure TVisBtr.WriteVisName(pValue:Str50);
begin
  oBtrTable.FieldByName('VisName').AsString := pValue;
end;

function TVisBtr.ReadVisAdress:Str50;
begin
  Result := oBtrTable.FieldByName('VisAdress').AsString;
end;

procedure TVisBtr.WriteVisAdress(pValue:Str50);
begin
  oBtrTable.FieldByName('VisAdress').AsString := pValue;
end;

function TVisBtr.ReadVisCtyName:Str20;
begin
  Result := oBtrTable.FieldByName('VisCtyName').AsString;
end;

procedure TVisBtr.WriteVisCtyName(pValue:Str20);
begin
  oBtrTable.FieldByName('VisCtyName').AsString := pValue;
end;

function TVisBtr.ReadVisCtyCode:Str4;
begin
  Result := oBtrTable.FieldByName('VisCtyCode').AsString;
end;

procedure TVisBtr.WriteVisCtyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('VisCtyCode').AsString := pValue;
end;

function TVisBtr.ReadVisCtyZIP:Str6;
begin
  Result := oBtrTable.FieldByName('VisCtyZIP').AsString;
end;

procedure TVisBtr.WriteVisCtyZIP(pValue:Str6);
begin
  oBtrTable.FieldByName('VisCtyZIP').AsString := pValue;
end;

function TVisBtr.ReadVisStaName:Str20;
begin
  Result := oBtrTable.FieldByName('VisStaName').AsString;
end;

procedure TVisBtr.WriteVisStaName(pValue:Str20);
begin
  oBtrTable.FieldByName('VisStaName').AsString := pValue;
end;

function TVisBtr.ReadVisStaCode:Str4;
begin
  Result := oBtrTable.FieldByName('VisStaCode').AsString;
end;

procedure TVisBtr.WriteVisStaCode(pValue:Str4);
begin
  oBtrTable.FieldByName('VisStaCode').AsString := pValue;
end;

function TVisBtr.ReadVisTelNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisTelNum').AsString;
end;

procedure TVisBtr.WriteVisTelNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisTelNum').AsString := pValue;
end;

function TVisBtr.ReadVisfaxNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisfaxNum').AsString;
end;

procedure TVisBtr.WriteVisfaxNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisfaxNum').AsString := pValue;
end;

function TVisBtr.ReadVisMobNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisMobNum').AsString;
end;

procedure TVisBtr.WriteVisMobNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisMobNum').AsString := pValue;
end;

function TVisBtr.ReadVisEMail:Str30;
begin
  Result := oBtrTable.FieldByName('VisEMail').AsString;
end;

procedure TVisBtr.WriteVisEMail(pValue:Str30);
begin
  oBtrTable.FieldByName('VisEMail').AsString := pValue;
end;

function TVisBtr.ReadVisType:Str1;
begin
  Result := oBtrTable.FieldByName('VisType').AsString;
end;

procedure TVisBtr.WriteVisType(pValue:Str1);
begin
  oBtrTable.FieldByName('VisType').AsString := pValue;
end;

function TVisBtr.ReadVisDocType:Str1;
begin
  Result := oBtrTable.FieldByName('VisDocType').AsString;
end;

procedure TVisBtr.WriteVisDocType(pValue:Str1);
begin
  oBtrTable.FieldByName('VisDocType').AsString := pValue;
end;

function TVisBtr.ReadVisDocNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisDocNum').AsString;
end;

procedure TVisBtr.WriteVisDocNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisDocNum').AsString := pValue;
end;

function TVisBtr.ReadBirthDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BirthDate').AsDateTime;
end;

procedure TVisBtr.WriteBirthDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BirthDate').AsDateTime := pValue;
end;

function TVisBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TVisBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVisBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVisBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVisBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVisBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TVisBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TVisBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TVisBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TVisBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TVisBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TVisBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TVisBtr.ReadBirthPlace:Str30;
begin
  Result := oBtrTable.FieldByName('BirthPlace').AsString;
end;

procedure TVisBtr.WriteBirthPlace(pValue:Str30);
begin
  oBtrTable.FieldByName('BirthPlace').AsString := pValue;
end;

function TVisBtr.ReadCitizenship:Str30;
begin
  Result := oBtrTable.FieldByName('Citizenship').AsString;
end;

procedure TVisBtr.WriteCitizenship(pValue:Str30);
begin
  oBtrTable.FieldByName('Citizenship').AsString := pValue;
end;

function TVisBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TVisBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TVisBtr.ReadTitulBef:Str10;
begin
  Result := oBtrTable.FieldByName('TitulBef').AsString;
end;

procedure TVisBtr.WriteTitulBef(pValue:Str10);
begin
  oBtrTable.FieldByName('TitulBef').AsString := pValue;
end;

function TVisBtr.ReadFirstName:Str15;
begin
  Result := oBtrTable.FieldByName('FirstName').AsString;
end;

procedure TVisBtr.WriteFirstName(pValue:Str15);
begin
  oBtrTable.FieldByName('FirstName').AsString := pValue;
end;

function TVisBtr.ReadLastName:Str15;
begin
  Result := oBtrTable.FieldByName('LastName').AsString;
end;

procedure TVisBtr.WriteLastName(pValue:Str15);
begin
  oBtrTable.FieldByName('LastName').AsString := pValue;
end;

function TVisBtr.ReadTitulAft:Str10;
begin
  Result := oBtrTable.FieldByName('TitulAft').AsString;
end;

procedure TVisBtr.WriteTitulAft(pValue:Str10);
begin
  oBtrTable.FieldByName('TitulAft').AsString := pValue;
end;

function TVisBtr.ReadFunction:Str30;
begin
  Result := oBtrTable.FieldByName('Function').AsString;
end;

procedure TVisBtr.WriteFunction(pValue:Str30);
begin
  oBtrTable.FieldByName('Function').AsString := pValue;
end;

function TVisBtr.ReadSexMark:Str1;
begin
  Result := oBtrTable.FieldByName('SexMark').AsString;
end;

procedure TVisBtr.WriteSexMark(pValue:Str1);
begin
  oBtrTable.FieldByName('SexMark').AsString := pValue;
end;

function TVisBtr.ReadAccost:Str30;
begin
  Result := oBtrTable.FieldByName('Accost').AsString;
end;

procedure TVisBtr.WriteAccost(pValue:Str30);
begin
  oBtrTable.FieldByName('Accost').AsString := pValue;
end;

function TVisBtr.ReadWorkTel:Str20;
begin
  Result := oBtrTable.FieldByName('WorkTel').AsString;
end;

procedure TVisBtr.WriteWorkTel(pValue:Str20);
begin
  oBtrTable.FieldByName('WorkTel').AsString := pValue;
end;

function TVisBtr.ReadWorkSec:Str5;
begin
  Result := oBtrTable.FieldByName('WorkSec').AsString;
end;

procedure TVisBtr.WriteWorkSec(pValue:Str5);
begin
  oBtrTable.FieldByName('WorkSec').AsString := pValue;
end;

function TVisBtr.ReadWorkEml:Str30;
begin
  Result := oBtrTable.FieldByName('WorkEml').AsString;
end;

procedure TVisBtr.WriteWorkEml(pValue:Str30);
begin
  oBtrTable.FieldByName('WorkEml').AsString := pValue;
end;

function TVisBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TVisBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TVisBtr.ReadMidName:Str15;
begin
  Result := oBtrTable.FieldByName('MidName').AsString;
end;

procedure TVisBtr.WriteMidName(pValue:Str15);
begin
  oBtrTable.FieldByName('MidName').AsString := pValue;
end;

function TVisBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TVisBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVisBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVisBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVisBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVisBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVisBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVisBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVisBtr.LocateVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindKey([pVisNum]);
end;

function TVisBtr.LocateVisName (pVisName:Str50):boolean;
begin
  SetIndex (ixVisName);
  Result := oBtrTable.FindKey([pVisName]);
end;

function TVisBtr.NearestVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindNearest([pVisNum]);
end;

function TVisBtr.NearestVisName (pVisName:Str50):boolean;
begin
  SetIndex (ixVisName);
  Result := oBtrTable.FindNearest([pVisName]);
end;

procedure TVisBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVisBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TVisBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVisBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVisBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVisBtr.First;
begin
  oBtrTable.First;
end;

procedure TVisBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVisBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVisBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVisBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVisBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVisBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVisBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVisBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVisBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVisBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVisBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
