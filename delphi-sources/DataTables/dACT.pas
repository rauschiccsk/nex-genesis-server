unit dACT; // Zoznam vykazov obratovej pedvahy

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnAn = 'SnAn';
  ixAnlName = 'AnlName';
  ixDifVal = 'DifVal';

type
  TACT = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    btACT: TNexBtrTable;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadAccSnt:Str3;
    procedure WriteAccSnt (pValue:Str3);
    function ReadAccAnl:Str6;
    procedure WriteAccAnl (pValue:Str6);
    function ReadAnlName:Str50;
    procedure WriteAnlName (pValue:Str50);
    function ReadCBegVal:double;
    procedure WriteCBegVal (pValue:double);
    function ReadDBegVal:double;
    procedure WriteDBegVal (pValue:double);
    function ReadCPrvVal:double;
    procedure WriteCPrvVal (pValue:double);
    function ReadDPrvVal:double;
    procedure WriteDPrvVal (pValue:double);
    function ReadCTrnVal:double;
    procedure WriteCTrnVal (pValue:double);
    function ReadDTrnVal:double;
    procedure WriteDTrnVal (pValue:double);
    function ReadCSumVal:double;
    function ReadDSumVal:double;
    function ReadCEndVal:double;
    function ReadDEndVal:double;
    function ReadDifVal:double;
  public
    function Eof: boolean;
    function LocateSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
    procedure Open(pSerNum:word);
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
    property DataSet:TNexBtrTable read btACT write btACT;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property AnlName:Str50 read ReadAnlName write WriteAnlName;
    property CBegVal:double read ReadCBegVal write WriteCBegVal;
    property DBegVal:double read ReadDBegVal write WriteDBegVal;
    property CPrvVal:double read ReadCPrvVal write WriteCPrvVal;
    property DPrvVal:double read ReadDPrvVal write WriteDPrvVal;
    property CTrnVal:double read ReadCTrnVal write WriteCTrnVal;
    property DTrnVal:double read ReadDTrnVal write WriteDTrnVal;
    property CSumVal:double read ReadCSumVal;
    property DSumVal:double read ReadDSumVal;
    property CEndVal:double read ReadCEndVal;
    property DEndVal:double read ReadDEndVal;
    property DifVal:double read ReadDifVal;
  end;

implementation

constructor TACT.Create;
begin
  btACT := TNexBtrTable.Create(Self);
  btACT.DataBaseName := gPath.LdgPath;
  btACT.FixedName := 'ACT';
  btACT.TableName := 'ACT';
  btACT.DefPath := gPath.DefPath;
  btACT.DefName := 'ACT.BDF';
end;

destructor  TACT.Destroy;
begin
  If btACT.Active then btACT.Close;
  FreeAndNil (btACT);
end;

// *************************************** PRIVATE ********************************************

function TACT.ReadCount:integer;
begin
  Result := btACT.RecordCount;
end;

function TACT.ReadAccSnt:Str3;
begin
  Result := btACT.FieldByName('AccSnt').AsString;
end;

procedure TACT.WriteAccSnt (pValue:Str3);
begin
  btACT.FieldByName('AccSnt').AsString := pValue;
end;

function TACT.ReadAccAnl:Str6;
begin
  Result := btACT.FieldByName('AccAnl').AsString;
end;

procedure TACT.WriteAccAnl (pValue:Str6);
begin
  btACT.FieldByName('AccAnl').AsString := pValue;
end;

function TACT.ReadAnlName:Str50;
begin
  Result := btACT.FieldByName('AnlName').AsString;
end;

procedure TACT.WriteAnlName (pValue:Str50);
begin
  btACT.FieldByName('AnlName').AsString := pValue;
end;

function TACT.ReadCBegVal:double;
begin
  Result := btACT.FieldByName('CBegVal').AsFloat;
end;

procedure TACT.WriteCBegVal (pValue:double);
begin
  btACT.FieldByName('CBegVal').AsFloat := pValue;
end;

function TACT.ReadDBegVal:double;
begin
  Result := btACT.FieldByName('DBegVal').AsFloat;
end;

procedure TACT.WriteDBegVal (pValue:double);
begin
  btACT.FieldByName('DBegVal').AsFloat := pValue;
end;

function TACT.ReadCPrvVal:double;
begin
  Result := btACT.FieldByName('CPrvVal').AsFloat;
end;

procedure TACT.WriteCPrvVal (pValue:double);
begin
  btACT.FieldByName('CPrvVal').AsFloat := pValue;
end;

function TACT.ReadDPrvVal:double;
begin
  Result := btACT.FieldByName('DPrvVal').AsFloat;
end;

procedure TACT.WriteDPrvVal (pValue:double);
begin
  btACT.FieldByName('DPrvVal').AsFloat := pValue;
end;

function TACT.ReadCTrnVal:double;
begin
  Result := btACT.FieldByName('CTrnVal').AsFloat;
end;

procedure TACT.WriteCTrnVal (pValue:double);
begin
  btACT.FieldByName('CTrnVal').AsFloat := pValue;
end;

function TACT.ReadDTrnVal:double;
begin
  Result := btACT.FieldByName('DTrnVal').AsFloat;
end;

procedure TACT.WriteDTrnVal (pValue:double);
begin
  btACT.FieldByName('DTrnVal').AsFloat := pValue;
end;

function TACT.ReadCSumVal:double;
begin
  Result := btACT.FieldByName('CSumVal').AsFloat;
end;

function TACT.ReadDSumVal:double;
begin
  Result := btACT.FieldByName('DSumVal').AsFloat;
end;

function TACT.ReadCEndVal:double;
begin
  Result := btACT.FieldByName('CEndVal').AsFloat;
end;

function TACT.ReadDEndVal:double;
begin
  Result := btACT.FieldByName('DEndVal').AsFloat;
end;

function TACT.ReadDifVal:double;
begin
  Result := btACT.FieldByName('DifVal').AsFloat;
end;

// **************************************** PUBLIC ********************************************

function TACT.Eof: boolean;
begin
  Result := btACT.Eof;
end;

function TACT.LocateSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndexName (ixSnAn);
  Result := btACT.FindKey([pAccSnt,pAccAnl]);
end;

function TACT.GetIndexName:ShortString;
begin
  Result := btACT.IndexName;
end;

procedure TACT.SetIndexName (pIndexName:ShortString);
begin
  If btACT.IndexName<>pIndexName then btACT.IndexName := pIndexName;
end;

procedure TACT.Open(pSerNum:word);
begin
  btACT.Open(pSerNum);
end;

procedure TACT.Close;
begin
  btACT.Close;
end;

procedure TACT.Prior;
begin
  btACT.Prior;
end;

procedure TACT.Next;
begin
  btACT.Next;
end;

procedure TACT.First;
begin
  btACT.First;
end;

procedure TACT.Last;
begin
  btACT.Last;
end;

procedure TACT.Insert;
begin
  btACT.Insert;
end;

procedure TACT.Edit;
begin
  btACT.Edit;
end;

procedure TACT.Post;
begin
  btACT.FieldByName('CSumVal').AsFloat := CPrvVal+CTrnVal;
  btACT.FieldByName('DSumVal').AsFloat := DPrvVal+DTrnVal;
  btACT.FieldByName('CEndVal').AsFloat := CBegVal+CPrvVal+CTrnVal;
  btACT.FieldByName('DEndVal').AsFloat := DBegVal+DPrvVal+DTrnVal;
  btACT.FieldByName('DifVal').AsFloat := CEndVal-DEndVal;
  btACT.Post;
end;

procedure TACT.Delete;
begin
  btACT.Delete;
end;

procedure TACT.SwapIndex;
begin
  btACT.SwapIndex;
end;

procedure TACT.RestoreIndex;
begin
  btACT.RestoreIndex;
end;

procedure TACT.DisableControls;
begin
  btACT.DisableControls;
end;

procedure TACT.EnableControls;
begin
  btACT.EnableControls;
end;

end.
