unit dACTLST; // Zoznam vykazov obratovej pedvahy

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixBegDate = 'BegDate';
  ixEndDate = 'EndDate';
  ixDescribe = 'Describe';
  ixMthNum = 'MthNum';

type
  TACTLST = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    btACTLST: TNexBtrTable;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);
    function ReadSerNum:longint;
    procedure WriteSerNum(pValue:longint);
    function ReadFrsDate:TDateTime;
    procedure WriteFrsDate(pValue:TDateTime);
    function ReadBegDate:TDateTime;
    procedure WriteBegDate (pValue:TDateTime);
    function ReadEndDate:TDateTime;
    procedure WriteEndDate (pValue:TDateTime);
    function ReadDescribe:Str60;
    procedure WriteDescribe (pValue:Str60);
    function ReadCntNum:word;
    procedure WriteCntNum (pValue:word);
    function ReadWriNums:Str60;
    procedure WriteWriNums (pValue:Str60);
    function ReadMthNum:word;
    procedure WriteMthNum (pValue:word);
    function ReadMthName:Str10;
    procedure WriteMthName (pValue:Str10);
  public
    function Eof: boolean;
    function LocateSerNum (pSerNum:longint):boolean;
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
    procedure DisableControls;
    procedure EnableControls;
  published
    property DataSet:TNexBtrTable read btACTLST;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;
    
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property FrsDate:TDateTime read ReadFrsDate write WriteFrsDate;
    property BegDate:TDateTime read ReadBegDate write WriteBegDate;
    property EndDate:TDateTime read ReadEndDate write WriteEndDate;
    property Describe:Str60 read ReadDescribe write WriteDescribe;
    property CntNum:word read ReadCntNum write WriteCntNum;
    property WriNums:Str60 read ReadWriNums write WriteWriNums;
    property MthNum:word read ReadMthNum write WriteMthNum;
    property MthName:Str10 read ReadMthName write WriteMthName;
  end;

implementation

constructor TACTLST.Create;
begin
  btACTLST := TNexBtrTable.Create(Self);
  btACTLST.DataBaseName := gPath.LdgPath;
  btACTLST.FixedName := 'ACTLST';
  btACTLST.TableName := 'ACTLST';
  btACTLST.DefPath := gPath.DefPath;
  btACTLST.DefName := 'ACTLST.BDF';
end;

destructor  TACTLST.Destroy;
begin
  If btACTLST.Active then btACTLST.Close;
  FreeAndNil (btACTLST);
end;

// *************************************** PRIVATE ********************************************

function TACTLST.ReadCount:integer;
begin
  Result := btACTLST.RecordCount;
end;

function TACTLST.ReadSerNum:longint;
begin
  Result := btACTLST.FieldByName('SerNum').AsInteger;
end;

procedure TACTLST.WriteSerNum(pValue:longint);
begin
  btACTLST.FieldByName('SerNum').AsInteger := pValue;
end;

function TACTLST.ReadFrsDate:TDateTime;
begin
  Result := btACTLST.FieldByName('FrsDate').AsDateTime;
end;

procedure TACTLST.WriteFrsDate (pValue:TDateTime);
begin
  btACTLST.FieldByName('FrsDate').AsDateTime := pValue;
end;

function TACTLST.ReadBegDate:TDateTime;
begin
  Result := btACTLST.FieldByName('BegDate').AsDateTime;
end;

procedure TACTLST.WriteBegDate (pValue:TDateTime);
begin
  btACTLST.FieldByName('BegDate').AsDateTime := pValue;
end;

function TACTLST.ReadEndDate:TDateTime;
begin
  Result := btACTLST.FieldByName('EndDate').AsDateTime;
end;

procedure TACTLST.WriteEndDate (pValue:TDateTime);
begin
  btACTLST.FieldByName('EndDate').AsDateTime := pValue;
end;

function TACTLST.ReadDescribe:Str60;
begin
  Result := btACTLST.FieldByName('Describe').AsString;
end;

procedure TACTLST.WriteDescribe (pValue:Str60);
begin
  btACTLST.FieldByName('Describe').AsString := pValue;
end;

function TACTLST.ReadCntNum:word;
begin
  Result := btACTLST.FieldByName('CntNum').AsInteger;
end;

procedure TACTLST.WriteCntNum (pValue:word);
begin
  btACTLST.FieldByName('CntNum').AsInteger := pValue;
end;

function TACTLST.ReadWriNums:Str60;
begin
  Result := btACTLST.FieldByName('WriNums').AsString;
end;

procedure TACTLST.WriteWriNums (pValue:Str60);
begin
  btACTLST.FieldByName('WriNums').AsString := pValue;
end;

function TACTLST.ReadMthNum:word;
begin
  Result := btACTLST.FieldByName('MthNum').AsInteger;
end;

procedure TACTLST.WriteMthNum (pValue:word);
begin
  btACTLST.FieldByName('MthNum').AsInteger := pValue;
end;

function TACTLST.ReadMthName:Str10;
begin
  Result := btACTLST.FieldByName('MthName').AsString;
end;

procedure TACTLST.WriteMthName (pValue:Str10);
begin
  btACTLST.FieldByName('MthName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TACTLST.Eof: boolean;
begin
  Result := btACTLST.Eof;
end;

function TACTLST.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndexName (ixSerNum);
  Result := btACTLST.FindKey([pSerNum]);
end;

function TACTLST.GetIndexName:ShortString;
begin
  Result := btACTLST.IndexName;
end;

procedure TACTLST.SetIndexName (pIndexName:ShortString);
begin
  If btACTLST.IndexName<>pIndexName then btACTLST.IndexName := pIndexName;
end;

procedure TACTLST.Open;
begin
  btACTLST.Open;
end;

procedure TACTLST.Close;
begin
  btACTLST.Close;
end;

procedure TACTLST.Prior;
begin
  btACTLST.Prior;
end;

procedure TACTLST.Next;
begin
  btACTLST.Next;
end;

procedure TACTLST.First;
begin
  btACTLST.First;
end;

procedure TACTLST.Last;
begin
  btACTLST.Last;
end;

procedure TACTLST.Insert;
begin
  btACTLST.Insert;
end;

procedure TACTLST.Edit;
begin
  btACTLST.Edit;
end;

procedure TACTLST.Post;
begin
  btACTLST.Post;
end;

procedure TACTLST.Delete;
begin
  btACTLST.Delete;
end;

procedure TACTLST.SwapIndex;
begin
  btACTLST.SwapIndex;
end;

procedure TACTLST.RestoreIndex;
begin
  btACTLST.RestoreIndex;
end;

procedure TACTLST.DisableControls;
begin
  btACTLST.DisableControls;
end;

procedure TACTLST.EnableControls;
begin
  btACTLST.EnableControls;
end;

end.
