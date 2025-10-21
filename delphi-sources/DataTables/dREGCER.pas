unit dREGCER; // Zoznam vykazov obratovej pedvahy

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegNum = 'RegNum';
  ixUpaCode = 'UpaCode';
  ixUpaName = 'UpaName';
  ixUpaIno = 'UpaIno';
  ixDpaCode = 'DpaCode';

type
  TRegCer = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadRegNum:Str12;       procedure WriteRegNum (pValue:Str12);
    function ReadRegKey:Str20;       procedure WriteRegKey (pValue:Str20);
    function ReadSystem:Str1;        procedure WriteSystem (pValue:Str1);
    function ReadSpcMark:Str10;      procedure WriteSpcMark (pValue:Str10);
    function ReadCerDate:TDateTime;  procedure WriteCerDate (pValue:TDateTime);
    function ReadUpaCode:longint;    procedure WriteUpaCode (pValue:longint);
    function ReadUpaName:Str30;      procedure WriteUpaName (pValue:Str30);
    function ReadUpaRegn:Str60;      procedure WriteUpaRegn (pValue:Str60);
    function ReadUpaAddr:Str30;      procedure WriteUpaAddr (pValue:Str30);
    function ReadUpaZip:Str15;       procedure WriteUpaZip (pValue:Str15);
    function ReadUpaCty:Str3;        procedure WriteUpaCty (pValue:Str3);
    function ReadUpaCtn:Str30;       procedure WriteUpaCtn (pValue:Str30);
    function ReadUpaSta:Str2;        procedure WriteUpaSta (pValue:Str2);
    function ReadUpaStn:Str30;       procedure WriteUpaStn (pValue:Str30);
    function ReadUpaIno:Str10;       procedure WriteUpaIno (pValue:Str10);
    function ReadUpaTin:Str15;       procedure WriteUpaTin (pValue:Str15);
    function ReadUpaVin:Str15;       procedure WriteUpaVin (pValue:Str15);
    function ReadWpaCode:word;       procedure WriteWpaCode (pValue:word);
    function ReadWpaName:Str30;      procedure WriteWpaName (pValue:Str30);
    function ReadWpaAddr:Str30;      procedure WriteWpaAddr (pValue:Str30);
    function ReadWpaZip:Str15;       procedure WriteWpaZip (pValue:Str15);
    function ReadWpaCty:Str3;        procedure WriteWpaCty (pValue:Str3);
    function ReadWpaCtn:Str30;       procedure WriteWpaCtn (pValue:Str30);
    function ReadWpaSta:Str2;        procedure WriteWpaSta (pValue:Str2);
    function ReadWpaStn:Str30;       procedure WriteWpaStn (pValue:Str30);
    function ReadDpaCode:longint;    procedure WriteDpaCode (pValue:longint);
    function ReadDpaName:Str30;      procedure WriteDpaName (pValue:Str30);
    function ReadDpaRegn:Str60;      procedure WriteDpaRegn (pValue:Str60);
    function ReadDpaAddr:Str30;      procedure WriteDpaAddr (pValue:Str30);
    function ReadDpaZip:Str15;       procedure WriteDpaZip (pValue:Str15);
    function ReadDpaCty:Str3;        procedure WriteDpaCty (pValue:Str3);
    function ReadDpaCtn:Str30;       procedure WriteDpaCtn (pValue:Str30);
    function ReadDpaSta:Str2;        procedure WriteDpaSta (pValue:Str2);
    function ReadDpaStn:Str30;       procedure WriteDpaStn (pValue:Str30);
    function ReadDpaIno:Str10;       procedure WriteDpaIno (pValue:Str10);
    function ReadDpaTin:Str15;       procedure WriteDpaTin (pValue:Str15);
    function ReadDpaVin:Str15;       procedure WriteDpaVin (pValue:Str15);
    function ReadNotice:Str60;       procedure WriteNotice (pValue:Str60);
  public
    function Eof: boolean;
    function LocateRegNum (pRegNum:Str12):boolean;
    procedure FilterSystem (pSystem:Str1);
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
    property btREGCER:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property RegNum:Str12 read ReadRegNum write WriteRegNum;
    property RegKey:Str20 read ReadRegKey write WriteRegKey;
    property System:Str1 read ReadSystem write WriteSystem;
    property SpcMark:Str10 read ReadSpcMark write WriteSpcMark;
    property CerDate:TDateTime read ReadCerDate write WriteCerDate;
    property UpaCode:longint read ReadUpaCode write WriteUpaCode;
    property UpaName:Str30 read ReadUpaName write WriteUpaName;
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
    property DpaAddr:Str30 read ReadDpaAddr write WriteDpaAddr;
    property DpaZip:Str15 read ReadDpaZip write WriteDpaZip;
    property DpaCty:Str3 read ReadDpaCty write WriteDpaCty;
    property DpaCtn:Str30 read ReadDpaCtn write WriteDpaCtn;
    property DpaSta:Str2 read ReadDpaSta write WriteDpaSta;
    property DpaStn:Str30 read ReadDpaStn write WriteDpaStn;
    property DpaIno:Str10 read ReadDpaIno write WriteDpaIno;
    property DpaTin:Str15 read ReadDpaTin write WriteDpaTin;
    property DpaVin:Str15 read ReadDpaVin write WriteDpaVin;
    property Notice:Str60 read ReadNotice write WriteNotice;
  end;

implementation

constructor TRegCer.Create;
begin
  oBtrTable := TNexBtrTable.Create(Self);
  oBtrTable.DataBaseName := gPath.CdwPath;
  oBtrTable.FixedName := 'REGCER';
  oBtrTable.TableName := 'REGCER';
  oBtrTable.DefPath := gPath.DefPath;
  oBtrTable.DefName := 'REGCER.BDF';
end;

destructor  TRegCer.Destroy;
begin
  If oBtrTable.Active then oBtrTable.Close;
  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRegCer.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRegCer.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

function TRegCer.ReadRegKey:Str20;
begin
  Result := oBtrTable.FieldByName('RegKey').AsString;
end;

function TRegCer.ReadSystem:Str1;
begin
  Result := oBtrTable.FieldByName('System').AsString;
end;

function TRegCer.ReadSpcMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpcMark').AsString;
end;

function TRegCer.ReadCerDate:TDateTime;
begin
  Result := oBtrTable.FieldByName('CerDate').AsDateTime;
end;

function TRegCer.ReadUpaCode:longint;
begin
  Result := oBtrTable.FieldByName('UpaCode').AsInteger;
end;

function TRegCer.ReadUpaName:Str30;
begin
  Result := oBtrTable.FieldByName('UpaName').AsString;
end;

function TRegCer.ReadUpaRegn:Str60;
begin
  Result := oBtrTable.FieldByName('UpaRegn').AsString;
end;

function TRegCer.ReadUpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('UpaAddr').AsString;
end;

function TRegCer.ReadUpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('UpaZip').AsString;
end;

function TRegCer.ReadUpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('UpaCty').AsString;
end;

function TRegCer.ReadUpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('UpaCtn').AsString;
end;

function TRegCer.ReadUpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('UpaSta').AsString;
end;

function TRegCer.ReadUpaStn:Str30;
begin
  Result := oBtrTable.FieldByName('UpaStn').AsString;
end;

function TRegCer.ReadUpaIno:Str10;
begin
  Result := oBtrTable.FieldByName('UpaIno').AsString;
end;

function TRegCer.ReadUpaTin:Str15;
begin
  Result := oBtrTable.FieldByName('UpaTin').AsString;
end;

function TRegCer.ReadUpaVin:Str15;
begin
  Result := oBtrTable.FieldByName('UpaVin').AsString;
end;

function TRegCer.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

function TRegCer.ReadWpaName:Str30;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

function TRegCer.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

function TRegCer.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

function TRegCer.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

function TRegCer.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

function TRegCer.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

function TRegCer.ReadWpaStn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaStn').AsString;
end;

function TRegCer.ReadDpaCode:longint;
begin
  Result := oBtrTable.FieldByName('DpaCode').AsInteger;
end;

function TRegCer.ReadDpaName:Str30;
begin
  Result := oBtrTable.FieldByName('DpaName').AsString;
end;

function TRegCer.ReadDpaRegn:Str60;
begin
  Result := oBtrTable.FieldByName('DpaRegn').AsString;
end;

function TRegCer.ReadDpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('DpaAddr').AsString;
end;

function TRegCer.ReadDpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('DpaZip').AsString;
end;

function TRegCer.ReadDpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('DpaCty').AsString;
end;

function TRegCer.ReadDpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('DpaCtn').AsString;
end;

function TRegCer.ReadDpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('DpaSta').AsString;
end;

function TRegCer.ReadDpaStn:Str30;
begin
  Result := oBtrTable.FieldByName('DpaStn').AsString;
end;

function TRegCer.ReadDpaIno:Str10;
begin
  Result := oBtrTable.FieldByName('DpaIno').AsString;
end;

function TRegCer.ReadDpaTin:Str15;
begin
  Result := oBtrTable.FieldByName('DpaTin').AsString;
end;

function TRegCer.ReadDpaVin:Str15;
begin
  Result := oBtrTable.FieldByName('DpaVin').AsString;
end;

function TRegCer.ReadNotice:Str60;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TRegCer.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

procedure TRegCer.WriteRegKey (pValue:Str20);
begin
  oBtrTable.FieldByName('RegKey').AsString := pValue;
end;

procedure TRegCer.WriteSystem (pValue:Str1);
begin
  oBtrTable.FieldByName('System').AsString := pValue;
end;

procedure TRegCer.WriteSpcMark (pValue:Str10);
begin
  oBtrTable.FieldByName('SpcMark').AsString := pValue;
end;

procedure TRegCer.WriteCerDate (pValue:TDateTime);
begin
  oBtrTable.FieldByName('CerDate').AsDateTime := pValue;
end;

procedure TRegCer.WriteUpaCode (pValue:longint);
begin
  oBtrTable.FieldByName('UpaCode').AsInteger := pValue;
end;

procedure TRegCer.WriteUpaName (pValue:Str30);
begin
  oBtrTable.FieldByName('UpaName').AsString := pValue;
end;

procedure TRegCer.WriteUpaRegn (pValue:Str60);
begin
  oBtrTable.FieldByName('UpaRegn').AsString := pValue;
end;

procedure TRegCer.WriteUpaAddr (pValue:Str30);
begin
  oBtrTable.FieldByName('UpaAddr').AsString := pValue;
end;

procedure TRegCer.WriteUpaZip (pValue:Str15);
begin
  oBtrTable.FieldByName('UpaZip').AsString := pValue;
end;

procedure TRegCer.WriteUpaCty (pValue:Str3);
begin
  oBtrTable.FieldByName('UpaCty').AsString := pValue;
end;

procedure TRegCer.WriteUpaCtn (pValue:Str30);
begin
  oBtrTable.FieldByName('UpaCtn').AsString := pValue;
end;

procedure TRegCer.WriteUpaSta (pValue:Str2);
begin
  oBtrTable.FieldByName('UpaSta').AsString := pValue;
end;

procedure TRegCer.WriteUpaStn (pValue:Str30);
begin
  oBtrTable.FieldByName('UpaStn').AsString := pValue;
end;

procedure TRegCer.WriteUpaIno (pValue:Str10);
begin
  oBtrTable.FieldByName('UpaIno').AsString := pValue;
end;

procedure TRegCer.WriteUpaTin (pValue:Str15);
begin
  oBtrTable.FieldByName('UpaTin').AsString := pValue;
end;

procedure TRegCer.WriteUpaVin (pValue:Str15);
begin
  oBtrTable.FieldByName('UpaVin').AsString := pValue;
end;

procedure TRegCer.WriteWpaCode (pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

procedure TRegCer.WriteWpaName (pValue:Str30);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

procedure TRegCer.WriteWpaAddr (pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

procedure TRegCer.WriteWpaZip (pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

procedure TRegCer.WriteWpaCty (pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

procedure TRegCer.WriteWpaCtn (pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

procedure TRegCer.WriteWpaSta (pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

procedure TRegCer.WriteWpaStn (pValue:Str30);
begin
  oBtrTable.FieldByName('WpaStn').AsString := pValue;
end;

procedure TRegCer.WriteDpaCode (pValue:longint);
begin
  oBtrTable.FieldByName('DpaCode').AsInteger := pValue;
end;

procedure TRegCer.WriteDpaName (pValue:Str30);
begin
  oBtrTable.FieldByName('DpaName').AsString := pValue;
end;

procedure TRegCer.WriteDpaRegn (pValue:Str60);
begin
  oBtrTable.FieldByName('DpaRegn').AsString := pValue;
end;

procedure TRegCer.WriteDpaAddr (pValue:Str30);
begin
  oBtrTable.FieldByName('DpaAddr').AsString := pValue;
end;

procedure TRegCer.WriteDpaZip (pValue:Str15);
begin
  oBtrTable.FieldByName('DpaZip').AsString := pValue;
end;

procedure TRegCer.WriteDpaCty (pValue:Str3);
begin
  oBtrTable.FieldByName('DpaCty').AsString := pValue;
end;

procedure TRegCer.WriteDpaCtn (pValue:Str30);
begin
  oBtrTable.FieldByName('DpaCtn').AsString := pValue;
end;

procedure TRegCer.WriteDpaSta (pValue:Str2);
begin
  oBtrTable.FieldByName('DpaSta').AsString := pValue;
end;

procedure TRegCer.WriteDpaStn (pValue:Str30);
begin
  oBtrTable.FieldByName('DpaStn').AsString := pValue;
end;

procedure TRegCer.WriteDpaIno (pValue:Str10);
begin
  oBtrTable.FieldByName('DpaIno').AsString := pValue;
end;

procedure TRegCer.WriteDpaTin (pValue:Str15);
begin
  oBtrTable.FieldByName('DpaTin').AsString := pValue;
end;

procedure TRegCer.WriteDpaVin (pValue:Str15);
begin
  oBtrTable.FieldByName('DpaVin').AsString := pValue;
end;

procedure TRegCer.WriteNotice (pValue:Str60);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegCer.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegCer.LocateRegNum (pRegNum:Str12):boolean;
begin
  SetIndexName (ixRegNum);
  Result := oBtrTable.FindKey([pRegNum]);
end;

function TRegCer.GetIndexName:ShortString;
begin
  Result := oBtrTable.IndexName;
end;

procedure TRegCer.SetIndexName (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRegCer.Open;
begin
  oBtrTable.Open;
end;

procedure TRegCer.Close;
begin
  oBtrTable.Close;
end;

procedure TRegCer.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRegCer.Next;
begin
  oBtrTable.Next;
end;

procedure TRegCer.First;
begin
  oBtrTable.First;
end;

procedure TRegCer.Last;
begin
  oBtrTable.Last;
end;

procedure TRegCer.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRegCer.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRegCer.Post;
begin
  oBtrTable.Post;
end;

procedure TRegCer.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRegCer.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRegCer.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRegCer.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRegCer.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRegCer.DisableControls;
begin
  oBtrTable.DisableControls;
end;

procedure TRegCer.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRegCer.FilterSystem (pSystem:Str1);
begin
  oBtrTable.ClearFilter;
  If pSystem<>'' then begin
    oBtrTable.AddFilter('System',pSystem,FALSE);
    oBtrTable.Filtered := TRUE;
  end
  else oBtrTable.Filtered := FALSE;
end;

end.
