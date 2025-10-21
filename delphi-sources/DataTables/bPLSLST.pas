unit bPLSLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPlsNum = 'PlsNum';
  ixMaster = 'Master';

type
  TPlslstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadPlsName:Str30;         procedure WritePlsName (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadRndType:byte;          procedure WriteRndType (pValue:byte);
    function  ReadDelPls:byte;           procedure WriteDelPls (pValue:byte);
    function  ReadAvgCalc:byte;          procedure WriteAvgCalc (pValue:byte);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
    function  ReadFrmNum:byte;           procedure WriteFrmNum (pValue:byte);
    function  ReadPrnLab:byte;           procedure WritePrnLab (pValue:byte);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadMaster:word;           procedure WriteMaster (pValue:word);
    function  ReadGrpTyp:Str1;           procedure WriteGrpTyp (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePlsNum (pPlsNum:word):boolean;
    function LocateMaster (pMaster:word):boolean;
    function NearestPlsNum (pPlsNum:word):boolean;
    function NearestMaster (pMaster:word):boolean;

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
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property PlsName:Str30 read ReadPlsName write WritePlsName;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property RndType:byte read ReadRndType write WriteRndType;
    property DelPls:byte read ReadDelPls write WriteDelPls;
    property AvgCalc:byte read ReadAvgCalc write WriteAvgCalc;
    property Shared:boolean read ReadShared write WriteShared;
    property FrmNum:byte read ReadFrmNum write WriteFrmNum;
    property PrnLab:byte read ReadPrnLab write WritePrnLab;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property Master:word read ReadMaster write WriteMaster;
    property GrpTyp:Str1 read ReadGrpTyp write WriteGrpTyp;
  end;

implementation

constructor TPlslstBtr.Create;
begin
  oBtrTable := BtrInit ('PLSLST',gPath.StkPath,Self);
end;

constructor TPlslstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PLSLST',pPath,Self);
end;

destructor TPlslstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPlslstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPlslstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPlslstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TPlslstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TPlslstBtr.ReadPlsName:Str30;
begin
  Result := oBtrTable.FieldByName('PlsName').AsString;
end;

procedure TPlslstBtr.WritePlsName(pValue:Str30);
begin
  oBtrTable.FieldByName('PlsName').AsString := pValue;
end;

function TPlslstBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPlslstBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPlslstBtr.ReadRndType:byte;
begin
  Result := oBtrTable.FieldByName('RndType').AsInteger;
end;

procedure TPlslstBtr.WriteRndType(pValue:byte);
begin
  oBtrTable.FieldByName('RndType').AsInteger := pValue;
end;

function TPlslstBtr.ReadDelPls:byte;
begin
  Result := oBtrTable.FieldByName('DelPls').AsInteger;
end;

procedure TPlslstBtr.WriteDelPls(pValue:byte);
begin
  oBtrTable.FieldByName('DelPls').AsInteger := pValue;
end;

function TPlslstBtr.ReadAvgCalc:byte;
begin
  Result := oBtrTable.FieldByName('AvgCalc').AsInteger;
end;

procedure TPlslstBtr.WriteAvgCalc(pValue:byte);
begin
  oBtrTable.FieldByName('AvgCalc').AsInteger := pValue;
end;

function TPlslstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TPlslstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TPlslstBtr.ReadFrmNum:byte;
begin
  Result := oBtrTable.FieldByName('FrmNum').AsInteger;
end;

procedure TPlslstBtr.WriteFrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('FrmNum').AsInteger := pValue;
end;

function TPlslstBtr.ReadPrnLab:byte;
begin
  Result := oBtrTable.FieldByName('PrnLab').AsInteger;
end;

procedure TPlslstBtr.WritePrnLab(pValue:byte);
begin
  oBtrTable.FieldByName('PrnLab').AsInteger := pValue;
end;

function TPlslstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPlslstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPlslstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPlslstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPlslstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPlslstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPlslstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TPlslstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TPlslstBtr.ReadMaster:word;
begin
  Result := oBtrTable.FieldByName('Master').AsInteger;
end;

procedure TPlslstBtr.WriteMaster(pValue:word);
begin
  oBtrTable.FieldByName('Master').AsInteger := pValue;
end;

function TPlslstBtr.ReadGrpTyp:Str1;
begin
  Result := oBtrTable.FieldByName('GrpTyp').AsString;
end;

procedure TPlslstBtr.WriteGrpTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('GrpTyp').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlslstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlslstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPlslstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlslstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPlslstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPlslstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPlslstBtr.LocatePlsNum (pPlsNum:word):boolean;
begin
  SetIndex (ixPlsNum);
  Result := oBtrTable.FindKey([pPlsNum]);
end;

function TPlslstBtr.LocateMaster (pMaster:word):boolean;
begin
  SetIndex (ixMaster);
  Result := oBtrTable.FindKey([pMaster]);
end;

function TPlslstBtr.NearestPlsNum (pPlsNum:word):boolean;
begin
  SetIndex (ixPlsNum);
  Result := oBtrTable.FindNearest([pPlsNum]);
end;

function TPlslstBtr.NearestMaster (pMaster:word):boolean;
begin
  SetIndex (ixMaster);
  Result := oBtrTable.FindNearest([pMaster]);
end;

procedure TPlslstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPlslstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPlslstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPlslstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPlslstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPlslstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPlslstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPlslstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPlslstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPlslstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPlslstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPlslstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPlslstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPlslstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPlslstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPlslstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPlslstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1925001}
