unit dREGITM; // Zoznam vykazov obratovej pedvahy

interface

uses
  IcTypes, IcTools, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegNum = 'RegNum';
  ixReIt = 'ReIt';
  ixReSt = 'ReSt';

type
  TRegItm = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadRegNum:Str12;       procedure WriteRegNum (pValue:Str12);
    function ReadItmNum:word;        procedure WriteItmNum (pValue:word);
    function ReadSysVer:byte;        procedure WriteSysVer (pValue:byte);
    function ReadWrsQnt:word;        procedure WriteWrsQnt (pValue:word);
    function ReadCasQnt:byte;        procedure WriteCasQnt (pValue:byte);
    function ReadUsfQnt:byte;        procedure WriteUsfQnt (pValue:byte);
    function ReadPrsQnt:word;        procedure WritePrsQnt (pValue:word);
    function ReadCrdQnt:word;        procedure WriteCrdQnt (pValue:word);
    function ReadRegDate:TDateTime;  procedure WriteRegDate (pValue:TDateTime);
    function ReadEndDate:TDateTime;  procedure WriteEndDate (pValue:TDateTime);
    function ReadExpDate:TDateTime;  procedure WriteExpDate (pValue:TDateTime);
    function ReadSpcMod:Str250;      procedure WriteSpcMod (pValue:Str250);
    function ReadIcdNum:Str12;       procedure WriteIcdNum (pValue:Str12);
    function ReadIcdDate:TDateTime;  procedure WriteIcdDate (pValue:TDateTime);
    function ReadStatus:Str1;
  public
    function Eof: boolean;
    function LocateRegNum (pRegNum:Str12):boolean;
    function LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
    function LocateReSt (pRegNum:Str12;pStatus:Str1):boolean;
    procedure FilterRegNum (pRegNum:Str12);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable write oBtrTable;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property RegNum:Str12 read ReadRegNum write WriteRegNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property SysVer:byte read ReadSysVer write WriteSysVer;
    property WrsQnt:word read ReadWrsQnt write WriteWrsQnt;
    property CasQnt:byte read ReadCasQnt write WriteCasQnt;
    property UsfQnt:byte read ReadUsfQnt write WriteUsfQnt;
    property PrsQnt:word read ReadPrsQnt write WritePrsQnt;
    property CrdQnt:word read ReadCrdQnt write WriteCrdQnt;
    property RegDate:TDateTime read ReadRegDate write WriteRegDate;
    property EndDate:TDateTime read ReadEndDate write WriteEndDate;
    property ExpDate:TDateTime read ReadExpDate write WriteExpDate;
    property SpcMod:Str250 read ReadSpcMod write WriteSpcMod;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdDate:TDateTime read ReadIcdDate write WriteIcdDate;
    property Status:Str1 read ReadStatus;
  end;

implementation

constructor TRegItm.Create;
begin
  oBtrTable := TNexBtrTable.Create(Self);
  oBtrTable.DataBaseName := gPath.CdwPath;
  oBtrTable.FixedName := 'REGITM';
  oBtrTable.TableName := 'REGITM';
  oBtrTable.DefPath := gPath.DefPath;
  oBtrTable.DefName := 'REGITM.BDF';
end;

destructor  TRegItm.Destroy;
begin
  If oBtrTable.Active then oBtrTable.Close;
  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRegItm.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRegItm.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

function TRegItm.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

function TRegItm.ReadSysVer:byte;
begin
  Result := oBtrTable.FieldByName('SysVer').AsInteger;
end;

function TRegItm.ReadWrsQnt:word;
begin
  Result := oBtrTable.FieldByName('WrsQnt').AsInteger;
end;

function TRegItm.ReadCasQnt:byte;
begin
  Result := oBtrTable.FieldByName('CasQnt').AsInteger;
end;

function TRegItm.ReadUsfQnt:byte;
begin
  Result := oBtrTable.FieldByName('UsfQnt').AsInteger;
end;

function TRegItm.ReadPrsQnt:word;
begin
  Result := oBtrTable.FieldByName('PrsQnt').AsInteger;
end;

function TRegItm.ReadCrdQnt:word;
begin
  Result := oBtrTable.FieldByName('CrdQnt').AsInteger;
end;

function TRegItm.ReadRegDate:TDateTime;
begin
  Result := oBtrTable.FieldByName('RegDate').AsDateTime;
end;

function TRegItm.ReadEndDate:TDateTime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

function TRegItm.ReadExpDate:TDateTime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

function TRegItm.ReadSpcMod:Str250;
begin
  Result := oBtrTable.FieldByName('SpcMod').AsString;
end;

function TRegItm.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

function TRegItm.ReadIcdDate:TDateTime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

function TRegItm.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TRegItm.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

procedure TRegItm.WriteItmNum (pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

procedure TRegItm.WriteSysVer (pValue:byte);
begin
  oBtrTable.FieldByName('SysVer').AsInteger := pValue;
end;

procedure TRegItm.WriteWrsQnt (pValue:word);
begin
  oBtrTable.FieldByName('WrsQnt').AsInteger := pValue;
end;

procedure TRegItm.WriteCasQnt (pValue:byte);
begin
  oBtrTable.FieldByName('CasQnt').AsInteger := pValue;
end;

procedure TRegItm.WriteUsfQnt (pValue:byte);
begin
  oBtrTable.FieldByName('UsfQnt').AsInteger := pValue;
end;

procedure TRegItm.WritePrsQnt (pValue:word);
begin
  oBtrTable.FieldByName('PrsQnt').AsInteger := pValue;
end;

procedure TRegItm.WriteCrdQnt (pValue:word);
begin
  oBtrTable.FieldByName('CrdQnt').AsInteger := pValue;
end;

procedure TRegItm.WriteRegDate (pValue:TDateTime);
begin
  oBtrTable.FieldByName('RegDate').AsDateTime := pValue;
end;

procedure TRegItm.WriteEndDate (pValue:TDateTime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

procedure TRegItm.WriteExpDate (pValue:TDateTime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

procedure TRegItm.WriteSpcMod (pValue:Str250);
begin
  oBtrTable.FieldByName('SpcMod').AsString := pValue;
end;

procedure TRegItm.WriteIcdNum (pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

procedure TRegItm.WriteIcdDate (pValue:TDateTime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegItm.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegItm.LocateRegNum (pRegNum:Str12):boolean;
begin
  SetIndexName (ixRegNum);
  Result := oBtrTable.FindKey([pRegNum]);
end;

function TRegItm.LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
begin
  SetIndexName (ixReIt);
  Result := oBtrTable.FindKey([pRegNum,pItmNum]);
end;

function TRegItm.LocateReSt (pRegNum:Str12;pStatus:Str1):boolean;
begin
  SetIndexName (ixReSt);
  Result := oBtrTable.FindKey([pRegNum,pStatus]);
end;

function TRegItm.GetIndexName:ShortString;
begin
  Result := oBtrTable.IndexName;
end;

procedure TRegItm.SetIndexName (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRegItm.FilterRegNum (pRegNum:Str12);    
begin
  oBtrTable.ClearFilter;
  If pRegNum<>'' then begin
    oBtrTable.AddFilter('RegNum',pRegNum,FALSE);
    oBtrTable.Filtered := TRUE;
  end
  else oBtrTable.Filtered := FALSE;
end;

procedure TRegItm.Open;
begin
  oBtrTable.Open;
end;

procedure TRegItm.Close;
begin
  oBtrTable.Close;
end;

procedure TRegItm.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRegItm.Next;
begin
  oBtrTable.Next;
end;

procedure TRegItm.First;
begin
  oBtrTable.First;
end;

procedure TRegItm.Last;
begin
  oBtrTable.Last;
end;

procedure TRegItm.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRegItm.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRegItm.Post;
begin
  If EndDate=0
    then oBtrTable.FieldByName('Status').AsString := 'A'
    else oBtrTable.FieldByName('Status').AsString := 'X';
  oBtrTable.Post;
end;

procedure TRegItm.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRegItm.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRegItm.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRegItm.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRegItm.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRegItm.DisableControls;
begin
  oBtrTable.DisableControls;
end;

procedure TRegItm.EnableControls;
begin
  oBtrTable.EnableControls;
end;

end.
