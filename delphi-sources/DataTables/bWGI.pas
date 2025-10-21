unit bWGI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWgCode = 'WgCode';
  ixQcCode = 'QcCode';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixChgSnd = 'ChgSnd';

type
  TWgiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oLstNum: integer;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWgCode:longint;        procedure WriteWgCode (pValue:longint);
    function  ReadQcCode:word;           procedure WriteQcCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadExpDay:word;           procedure WriteExpDay (pValue:word);
    function  ReadChgSnd:byte;           procedure WriteChgSnd (pValue:byte);
    function  ReadLblFrm:byte;           procedure WriteLblFrm (pValue:byte);
    function  ReadIngrd1:Str255;         procedure WriteIngrd1 (pValue:Str255);
    function  ReadIngrd2:Str255;         procedure WriteIngrd2 (pValue:Str255);
    function  ReadIngrd3:Str255;         procedure WriteIngrd3 (pValue:Str255);
    function  ReadIngrd4:Str255;         procedure WriteIngrd4 (pValue:Str255);
    function  ReadGsName1:Str24;         procedure WriteGsName1 (pValue:Str24);
    function  ReadGsName2:Str24;         procedure WriteGsName2 (pValue:Str24);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateWgCode (pWgCode:longint):boolean;
    function LocateQcCode (pQcCode:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateChgSnd (pChgSnd:byte):boolean;
    function NearestWgCode (pWgCode:longint):boolean;
    function NearestQcCode (pQcCode:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str30):boolean;
    function NearestChgSnd (pChgSnd:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pLstNum:integer);
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
    property WgCode:longint read ReadWgCode write WriteWgCode;
    property QcCode:word read ReadQcCode write WriteQcCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ExpDay:word read ReadExpDay write WriteExpDay;
    property ChgSnd:byte read ReadChgSnd write WriteChgSnd;
    property LblFrm:byte read ReadLblFrm write WriteLblFrm;
    property Ingrd1:Str255 read ReadIngrd1 write WriteIngrd1;
    property Ingrd2:Str255 read ReadIngrd2 write WriteIngrd2;
    property Ingrd3:Str255 read ReadIngrd3 write WriteIngrd3;
    property Ingrd4:Str255 read ReadIngrd4 write WriteIngrd4;
    property GsName1:Str24 read ReadGsName1 write WriteGsName1;
    property GsName2:Str24 read ReadGsName2 write WriteGsName2;
  end;

implementation

constructor TWgiBtr.Create;
begin
  oBtrTable := BtrInit ('WGI',gPath.DlsPath,Self);
end;

constructor TWgiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WGI',pPath,Self);
end;

destructor TWgiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWgiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWgiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWgiBtr.ReadWgCode:longint;
begin
  Result := oBtrTable.FieldByName('WgCode').AsInteger;
end;

procedure TWgiBtr.WriteWgCode(pValue:longint);
begin
  oBtrTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TWgiBtr.ReadQcCode:word;
begin
  Result := oBtrTable.FieldByName('QcCode').AsInteger;
end;

procedure TWgiBtr.WriteQcCode(pValue:word);
begin
  oBtrTable.FieldByName('QcCode').AsInteger := pValue;
end;

function TWgiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TWgiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TWgiBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TWgiBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TWgiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TWgiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TWgiBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TWgiBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TWgiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TWgiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TWgiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TWgiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TWgiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TWgiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TWgiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWgiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWgiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWgiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWgiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWgiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWgiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TWgiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TWgiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWgiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWgiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWgiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWgiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWgiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWgiBtr.ReadExpDay:word;
begin
  Result := oBtrTable.FieldByName('ExpDay').AsInteger;
end;

procedure TWgiBtr.WriteExpDay(pValue:word);
begin
  oBtrTable.FieldByName('ExpDay').AsInteger := pValue;
end;

function TWgiBtr.ReadChgSnd:byte;
begin
  Result := oBtrTable.FieldByName('ChgSnd').AsInteger;
end;

procedure TWgiBtr.WriteChgSnd(pValue:byte);
begin
  oBtrTable.FieldByName('ChgSnd').AsInteger := pValue;
end;

function TWgiBtr.ReadLblFrm:byte;
begin
  Result := oBtrTable.FieldByName('LblFrm').AsInteger;
end;

procedure TWgiBtr.WriteLblFrm(pValue:byte);
begin
  oBtrTable.FieldByName('LblFrm').AsInteger := pValue;
end;

function TWgiBtr.ReadIngrd1:Str255;
begin
  Result := oBtrTable.FieldByName('Ingrd1').AsString;
end;

procedure TWgiBtr.WriteIngrd1(pValue:Str255);
begin
  oBtrTable.FieldByName('Ingrd1').AsString := pValue;
end;

function TWgiBtr.ReadIngrd2:Str255;
begin
  Result := oBtrTable.FieldByName('Ingrd2').AsString;
end;

procedure TWgiBtr.WriteIngrd2(pValue:Str255);
begin
  oBtrTable.FieldByName('Ingrd2').AsString := pValue;
end;

function TWgiBtr.ReadIngrd3:Str255;
begin
  Result := oBtrTable.FieldByName('Ingrd3').AsString;
end;

procedure TWgiBtr.WriteIngrd3(pValue:Str255);
begin
  oBtrTable.FieldByName('Ingrd3').AsString := pValue;
end;

function TWgiBtr.ReadIngrd4:Str255;
begin
  Result := oBtrTable.FieldByName('Ingrd4').AsString;
end;

procedure TWgiBtr.WriteIngrd4(pValue:Str255);
begin
  oBtrTable.FieldByName('Ingrd4').AsString := pValue;
end;

function TWgiBtr.ReadGsName1:Str24;
begin
  Result := oBtrTable.FieldByName('GsName1').AsString;
end;

procedure TWgiBtr.WriteGsName1(pValue:Str24);
begin
  oBtrTable.FieldByName('GsName1').AsString := pValue;
end;

function TWgiBtr.ReadGsName2:Str24;
begin
  Result := oBtrTable.FieldByName('GsName2').AsString;
end;

procedure TWgiBtr.WriteGsName2(pValue:Str24);
begin
  oBtrTable.FieldByName('GsName2').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWgiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWgiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWgiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWgiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWgiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWgiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWgiBtr.LocateWgCode (pWgCode:longint):boolean;
begin
  SetIndex (ixWgCode);
  Result := oBtrTable.FindKey([pWgCode]);
end;

function TWgiBtr.LocateQcCode (pQcCode:word):boolean;
begin
  SetIndex (ixQcCode);
  Result := oBtrTable.FindKey([pQcCode]);
end;

function TWgiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TWgiBtr.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TWgiBtr.LocateChgSnd (pChgSnd:byte):boolean;
begin
  SetIndex (ixChgSnd);
  Result := oBtrTable.FindKey([pChgSnd]);
end;

function TWgiBtr.NearestWgCode (pWgCode:longint):boolean;
begin
  SetIndex (ixWgCode);
  Result := oBtrTable.FindNearest([pWgCode]);
end;

function TWgiBtr.NearestQcCode (pQcCode:word):boolean;
begin
  SetIndex (ixQcCode);
  Result := oBtrTable.FindNearest([pQcCode]);
end;

function TWgiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TWgiBtr.NearestGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TWgiBtr.NearestChgSnd (pChgSnd:byte):boolean;
begin
  SetIndex (ixChgSnd);
  Result := oBtrTable.FindNearest([pChgSnd]);
end;

procedure TWgiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWgiBtr.Open(pLstNum:integer);
begin
  oLstNum := pLstNum;
  oBtrTable.Open(pLstNum);
end;

procedure TWgiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWgiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWgiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWgiBtr.First;
begin
  oBtrTable.First;
end;

procedure TWgiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWgiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWgiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWgiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWgiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWgiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWgiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWgiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWgiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWgiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWgiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1903001}
