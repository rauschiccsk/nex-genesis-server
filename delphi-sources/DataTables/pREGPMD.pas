unit pREGPMD;
// *****************************************************************************
// *****************************************************************************

interface

uses
  IcTypes, icTools, NexPath, NexGlob, TxtCut, dREGPMD,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, NexPxTable;

const
  ixRegInd = '';
  ixSmPm = 'SmPm';
  ixPmdMark = 'PmdMark';
  ixPmdName = 'PmdName';

type
//  TPmdArray = array[1..8000] of byte;
  TRegPmdTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrData: TRegPmd;
    oTmpTable: TNexPxTable;
//    oPmdArray: TPmdArray;
    oRegNum: Str12;
    oItmNum: word;
    function ReadCount:integer;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadRegInd:word;        procedure WriteRegInd (pValue:word);
    function ReadSysMark:Str2;       procedure WriteSysMark (pValue:Str2);
    function ReadPmdMark:Str3;       procedure WritePmdMark (pValue:Str3);
    function ReadPmdName:Str40;      procedure WritePmdName (pValue:Str40);
  public
    procedure LoadToTmp (pRegNum:Str12;pItmNum:word);
    procedure SaveToBtr;
    // Elementarne databazove operacie
    function Eof: boolean;
    function LocateSmPm (pSysMark:Str2;pPmdMark:Str3):boolean;
    function LocateRegInd (pRegInd:word):boolean;
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
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property BtrData:TRegPmd read oBtrData write oBtrData;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property SysMark:Str2 read ReadSysMark write WriteSysMark;
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property PmdName:Str40 read ReadPmdName write WritePmdName;
    property RegInd:word read ReadRegInd write WriteRegInd;
  end;

implementation

constructor TRegPmdTmp.Create;
begin
  oTmpTable := TmpInit ('REGPMD',Self);
  oBtrData := TRegPmd.Create;
  oBtrData.Open;
end;

destructor  TRegPmdTmp.Destroy;
begin
  oBtrData.Close; FreeAndNil (oBtrData);
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRegPmdTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRegPmdTmp.ReadRegInd:word;
begin
  Result := oTmpTable.FieldByName('RegInd').AsInteger;
end;

procedure TRegPmdTmp.WriteRegInd (pValue:word);
begin
  oTmpTable.FieldByName('RegInd').AsInteger := pValue;
end;

function TRegPmdTmp.ReadSysMark:Str2;
begin
  Result := oTmpTable.FieldByName('SysMark').AsString;
end;

procedure TRegPmdTmp.WriteSysMark (pValue:Str2);
begin
  oTmpTable.FieldByName('SysMark').AsString := pValue;
end;

function TRegPmdTmp.ReadPmdMark:Str3;
begin
  Result := oTmpTable.FieldByName('PmdMark').AsString;
end;

procedure TRegPmdTmp.WritePmdMark (pValue:Str3);
begin
  oTmpTable.FieldByName('PmdMark').AsString := pValue;
end;

function TRegPmdTmp.ReadPmdName:Str40;
begin
  Result := oTmpTable.FieldByName('PmdName').AsString;
end;

procedure TRegPmdTmp.WritePmdName (pValue:Str40);
begin
  oTmpTable.FieldByName('PmdName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

procedure TRegPmdTmp.LoadToTmp (pRegNum:Str12;pItmNum:word);
begin
  oRegNum := pRegNum;  oItmNum := pItmNum;
  If oBtrData.LocateReIt(oRegNum,oItmNum) then begin
    Repeat
      oTmpTable.Insert;
      BTR_To_PX (oBtrData.BtrTable,oTmpTable);
      oTmpTable.Post;
      Application.ProcessMessages;
      oBtrData.Next;
    until oBtrData.Eof or (oBtrData.RegNum<>pRegNum) or (oBtrData.ItmNum<>pItmNum);
  end;
end;

procedure TRegPmdTmp.SaveToBtr;
begin
  oBtrData.DeleteReIt(oRegNum,oItmNum);
  If Count>0 then begin
    First;
    Repeat
      oBtrData.Insert;
      oBtrData.RegNum := oRegNum;
      oBtrData.ItmNum := oItmNum;
      PX_To_BTR (oTmpTable,oBtrData.BtrTable);
      oBtrData.Post;
      Application.ProcessMessages;
      Next;
    until Eof;
  end;
end;

function TRegPmdTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRegPmdTmp.LocateSmPm (pSysMark:Str2;pPmdMark:Str3):boolean;
begin
  SetIndexName (ixSmPm);
  Result := oTmpTable.FindKey([pSysMark,pPmdMark]);
end;

function TRegPmdTmp.LocateRegInd (pRegInd:word):boolean;
begin
  SetIndexName (ixRegInd);
  Result := oTmpTable.FindKey([pRegInd]);
end;

function TRegPmdTmp.GetIndexName:ShortString;
begin
  Result := oTmpTable.IndexName;
end;

procedure TRegPmdTmp.SetIndexName (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRegPmdTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRegPmdTmp.Close;
begin
  oTmpTable.Close;
end;

procedure TRegPmdTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRegPmdTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRegPmdTmp.First;
begin
  oTmpTable.First;
end;

procedure TRegPmdTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRegPmdTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRegPmdTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRegPmdTmp.Post;
begin
  oTmpTable.Post;
end;

procedure TRegPmdTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRegPmdTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRegPmdTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRegPmdTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRegPmdTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRegPmdTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

procedure TRegPmdTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

end.
