unit dFINJRN; // Penazny dennik JU

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixAsAa = 'AsAa';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixAccText = 'AccText';
  ixAcValue = 'AcValue';
  ixCndNum = 'CndNum';
  ixCneNum = 'CneNum';

type
  TFINJRN = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    btFINJRN: TNexBtrTable;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadDocNum:Str12;
    procedure WriteDocNum (pValue:Str12);
    function ReadItmNum:word;
    procedure WriteItmNum (pValue:word);
    function ReadWriNum:word;
    procedure WriteWriNum (pValue:word);
    function ReadDocDate:TDateTime;
    procedure WriteDocDate (pValue:TDateTime);
    function ReadAccSnt:Str3;
    procedure WriteAccSnt (pValue:Str3);
    function ReadAccAnl:Str6;
    procedure WriteAccAnl (pValue:Str6);
    function ReadAccText:Str50;
    procedure WriteAccText (pValue:Str50);
    function ReadAcValue:double;
    procedure WriteAcValue (pValue:double);
    function ReadFgValue:double;
    procedure WriteFgValue (pValue:double);
    function ReadCndNum:Str12;
    procedure WriteCndNum (pValue:Str12);
    function ReadCneNum:Str12;
    procedure WriteCneNum (pValue:Str12);
    function ReadPaCode:longint;
    procedure WritePaCode (pValue:longint);
    function ReadFjrRow:byte;
    procedure WriteFjrRow (pValue:byte);
    function ReadOpType:Str1;
    procedure WriteOpType (pValue:Str1);
    function ReadStatus:byte;
    procedure WriteStatus (pValue:byte);
  public
    function Eof: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateAsAa (pAccSnt:Str3;pAccAnl:Str6):boolean;
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
    property DataSet:TNexBtrTable read btFINJRN;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDateTime read ReadDocDate write WriteDocDate;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property AccText:Str50 read ReadAccText write WriteAccText;
    property AcValue:double read ReadAcValue write WriteAcValue;
    property FgValue:double read ReadFgValue write WriteFgValue;
    property CndNum:Str12 read ReadCndNum write WriteCndNum;
    property CneNum:Str12 read ReadCneNum write WriteCneNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property FjrRow:byte read ReadFjrRow write WriteFjrRow;
    property OpType:Str1 read ReadOpType write WriteOpType;
    property Status:byte read ReadStatus write WriteStatus;
  end;

implementation

constructor TFINJRN.Create;
begin
  btFINJRN := TNexBtrTable.Create(Self);
  btFINJRN.DataBaseName := gPath.LdgPath;
  btFINJRN.FixedName := 'FINJRN';
  btFINJRN.TableName := 'FINJRN';
  btFINJRN.DefPath := gPath.DefPath;
  btFINJRN.DefName := 'FINJRN.BDF';
end;

destructor  TFINJRN.Destroy;
begin
  If btFINJRN.Active then btFINJRN.Close;
  FreeAndNil (btFINJRN);
end;

// *************************************** PRIVATE ********************************************

function TFINJRN.ReadCount:integer;
begin
  Result := btFINJRN.RecordCount;
end;

function TFINJRN.ReadDocNum:Str12;
begin
  Result := btFINJRN.FieldByName('DocNum').AsString;
end;

procedure TFINJRN.WriteDocNum (pValue:Str12);
begin
  btFINJRN.FieldByName('DocNum').AsString := pValue;
end;

function TFINJRN.ReadItmNum:word;
begin
  Result := btFINJRN.FieldByName('ItmNum').AsInteger;
end;

procedure TFINJRN.WriteItmNum (pValue:word);
begin
  btFINJRN.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFINJRN.ReadWriNum:word;
begin
  Result := btFINJRN.FieldByName('WriNum').AsInteger;
end;

procedure TFINJRN.WriteWriNum (pValue:word);
begin
  btFINJRN.FieldByName('WriNum').AsInteger := pValue;
end;

function TFINJRN.ReadDocDate:TDateTime;
begin
  Result := btFINJRN.FieldByName('DocDate').AsDateTime;
end;

procedure TFINJRN.WriteDocDate (pValue:TDateTime);
begin
  btFINJRN.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFINJRN.ReadAccSnt:Str3;
begin
  Result := btFINJRN.FieldByName('AccSnt').AsString;
end;

procedure TFINJRN.WriteAccSnt (pValue:Str3);
begin
  btFINJRN.FieldByName('AccSnt').AsString := pValue;
end;

function TFINJRN.ReadAccAnl:Str6;
begin
  Result := btFINJRN.FieldByName('AccAnl').AsString;
end;

procedure TFINJRN.WriteAccAnl (pValue:Str6);
begin
  btFINJRN.FieldByName('AccAnl').AsString := pValue;
end;

function TFINJRN.ReadAccText:Str50;
begin
  Result := btFINJRN.FieldByName('AccText').AsString;
end;

procedure TFINJRN.WriteAccText (pValue:Str50);
begin
  btFINJRN.FieldByName('AccText').AsString := pValue;
end;

function TFINJRN.ReadAcValue:double;
begin
  Result := btFINJRN.FieldByName('AcValue').AsFloat;
end;

procedure TFINJRN.WriteAcValue (pValue:double);
begin
  btFINJRN.FieldByName('AcValue').AsFloat := pValue;
end;

function TFINJRN.ReadFgValue:double;
begin
  Result := btFINJRN.FieldByName('FgValue').AsFloat;
end;

procedure TFINJRN.WriteFgValue (pValue:double);
begin
  btFINJRN.FieldByName('FgValue').AsFloat := pValue;
end;

function TFINJRN.ReadCndNum:Str12;
begin
  Result := btFINJRN.FieldByName('CndNum').AsString;
end;

procedure TFINJRN.WriteCndNum (pValue:Str12);
begin
  btFINJRN.FieldByName('CndNum').AsString := pValue;
end;

function TFINJRN.ReadCneNum:Str12;
begin
  Result := btFINJRN.FieldByName('CneNum').AsString;
end;

procedure TFINJRN.WriteCneNum (pValue:Str12);
begin
  btFINJRN.FieldByName('CneNum').AsString := pValue;
end;

function TFINJRN.ReadPaCode:longint;
begin
  Result := btFINJRN.FieldByName('PaCode').AsInteger;
end;

procedure TFINJRN.WritePaCode (pValue:longint);
begin
  btFINJRN.FieldByName('PaCode').AsInteger := pValue;
end;

function TFINJRN.ReadFjrRow:byte;
begin
  Result := btFINJRN.FieldByName('FjrRow').AsInteger;
end;

procedure TFINJRN.WriteFjrRow (pValue:byte);
begin
  btFINJRN.FieldByName('FjrRow').AsInteger := pValue;
end;

function TFINJRN.ReadOpType:Str1;
begin
  Result := btFINJRN.FieldByName('OpTyoe').AsString;
end;

procedure TFINJRN.WriteOpType (pValue:Str1);
begin
  btFINJRN.FieldByName('OpType').AsString := pValue;
end;

function TFINJRN.ReadStatus:byte;
begin
  Result := btFINJRN.FieldByName('Status').AsInteger;
end;

procedure TFINJRN.WriteStatus (pValue:byte);
begin
  btFINJRN.FieldByName('Status').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFINJRN.Eof: boolean;
begin
  Result := btFINJRN.Eof;
end;

function TFINJRN.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndexName (ixDoIt);
  Result := btFINJRN.FindKey([pDocNum,pItmNum]);
end;

function TFINJRN.LocateAsAa (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndexName (ixAsAa);
  Result := btFINJRN.FindKey([pAccSnt,pAccAnl]);
end;

function TFINJRN.GetIndexName:ShortString;
begin
  Result := btFINJRN.IndexName;
end;

procedure TFINJRN.SetIndexName (pIndexName:ShortString);
begin
  If btFINJRN.IndexName<>pIndexName then btFINJRN.IndexName := pIndexName;
end;

procedure TFINJRN.Open;
begin
  btFINJRN.Open;
end;

procedure TFINJRN.Close;
begin
  btFINJRN.Close;
end;

procedure TFINJRN.Prior;
begin
  btFINJRN.Prior;
end;

procedure TFINJRN.Next;
begin
  btFINJRN.Next;
end;

procedure TFINJRN.First;
begin
  btFINJRN.First;
end;

procedure TFINJRN.Last;
begin
  btFINJRN.Last;
end;

procedure TFINJRN.Insert;
begin
  btFINJRN.Insert;
end;

procedure TFINJRN.Edit;
begin
  btFINJRN.Edit;
end;

procedure TFINJRN.Post;
begin
  btFINJRN.Post;
end;

procedure TFINJRN.Delete;
begin
  btFINJRN.Delete;
end;

procedure TFINJRN.SwapIndex;
begin
  btFINJRN.SwapIndex;
end;

procedure TFINJRN.RestoreIndex;
begin
  btFINJRN.RestoreIndex;
end;

procedure TFINJRN.DisableControls;
begin
  btFINJRN.DisableControls;
end;

procedure TFINJRN.EnableControls;
begin
  btFINJRN.EnableControls;
end;

end.
