unit tSRPRN_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TSrprn_cTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadSrCode01:Str1;         procedure WriteSrCode01 (pValue:Str1);
    function  ReadSrCode02:Str1;         procedure WriteSrCode02 (pValue:Str1);
    function  ReadSrCode03:Str1;         procedure WriteSrCode03 (pValue:Str1);
    function  ReadSrCode04:Str1;         procedure WriteSrCode04 (pValue:Str1);
    function  ReadSrCode05:Str1;         procedure WriteSrCode05 (pValue:Str1);
    function  ReadSrCode06:Str1;         procedure WriteSrCode06 (pValue:Str1);
    function  ReadSrCode07:Str1;         procedure WriteSrCode07 (pValue:Str1);
    function  ReadSrCode08:Str1;         procedure WriteSrCode08 (pValue:Str1);
    function  ReadSrCode09:Str1;         procedure WriteSrCode09 (pValue:Str1);
    function  ReadSrCode10:Str1;         procedure WriteSrCode10 (pValue:Str1);
    function  ReadSrCode11:Str1;         procedure WriteSrCode11 (pValue:Str1);
    function  ReadSrCode12:Str1;         procedure WriteSrCode12 (pValue:Str1);
    function  ReadSrCode13:Str1;         procedure WriteSrCode13 (pValue:Str1);
    function  ReadSrCode14:Str1;         procedure WriteSrCode14 (pValue:Str1);
    function  ReadSrCode15:Str1;         procedure WriteSrCode15 (pValue:Str1);
    function  ReadTrdShop:Str1;          procedure WriteTrdShop (pValue:Str1);
    function  ReadTrdStor:Str1;          procedure WriteTrdStor (pValue:Str1);
    function  ReadLaQnt01:Str1;          procedure WriteLaQnt01 (pValue:Str1);
    function  ReadLaQnt02:Str1;          procedure WriteLaQnt02 (pValue:Str1);
    function  ReadLaQnt03:Str1;          procedure WriteLaQnt03 (pValue:Str1);
    function  ReadLaQnt04:Str1;          procedure WriteLaQnt04 (pValue:Str1);
    function  ReadLaQnt05:Str1;          procedure WriteLaQnt05 (pValue:Str1);
    function  ReadLaQnt06:Str1;          procedure WriteLaQnt06 (pValue:Str1);
    function  ReadLaQnt07:Str1;          procedure WriteLaQnt07 (pValue:Str1);
    function  ReadLaQnt08:Str1;          procedure WriteLaQnt08 (pValue:Str1);
    function  ReadLaQnt09:Str1;          procedure WriteLaQnt09 (pValue:Str1);
    function  ReadLaQnt10:Str1;          procedure WriteLaQnt10 (pValue:Str1);
    function  ReadLaQnt11:Str1;          procedure WriteLaQnt11 (pValue:Str1);
    function  ReadGsQnt01:Str1;          procedure WriteGsQnt01 (pValue:Str1);
    function  ReadGsQnt02:Str1;          procedure WriteGsQnt02 (pValue:Str1);
    function  ReadGsQnt03:Str1;          procedure WriteGsQnt03 (pValue:Str1);
    function  ReadGsQnt04:Str1;          procedure WriteGsQnt04 (pValue:Str1);
    function  ReadGsQnt05:Str1;          procedure WriteGsQnt05 (pValue:Str1);
    function  ReadGsQnt06:Str1;          procedure WriteGsQnt06 (pValue:Str1);
    function  ReadGsQnt07:Str1;          procedure WriteGsQnt07 (pValue:Str1);
    function  ReadGsQnt08:Str1;          procedure WriteGsQnt08 (pValue:Str1);
    function  ReadGsQnt09:Str1;          procedure WriteGsQnt09 (pValue:Str1);
    function  ReadGsQnt10:Str1;          procedure WriteGsQnt10 (pValue:Str1);
    function  ReadGsQnt11:Str1;          procedure WriteGsQnt11 (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property SrCode01:Str1 read ReadSrCode01 write WriteSrCode01;
    property SrCode02:Str1 read ReadSrCode02 write WriteSrCode02;
    property SrCode03:Str1 read ReadSrCode03 write WriteSrCode03;
    property SrCode04:Str1 read ReadSrCode04 write WriteSrCode04;
    property SrCode05:Str1 read ReadSrCode05 write WriteSrCode05;
    property SrCode06:Str1 read ReadSrCode06 write WriteSrCode06;
    property SrCode07:Str1 read ReadSrCode07 write WriteSrCode07;
    property SrCode08:Str1 read ReadSrCode08 write WriteSrCode08;
    property SrCode09:Str1 read ReadSrCode09 write WriteSrCode09;
    property SrCode10:Str1 read ReadSrCode10 write WriteSrCode10;
    property SrCode11:Str1 read ReadSrCode11 write WriteSrCode11;
    property SrCode12:Str1 read ReadSrCode12 write WriteSrCode12;
    property SrCode13:Str1 read ReadSrCode13 write WriteSrCode13;
    property SrCode14:Str1 read ReadSrCode14 write WriteSrCode14;
    property SrCode15:Str1 read ReadSrCode15 write WriteSrCode15;
    property TrdShop:Str1 read ReadTrdShop write WriteTrdShop;
    property TrdStor:Str1 read ReadTrdStor write WriteTrdStor;
    property LaQnt01:Str1 read ReadLaQnt01 write WriteLaQnt01;
    property LaQnt02:Str1 read ReadLaQnt02 write WriteLaQnt02;
    property LaQnt03:Str1 read ReadLaQnt03 write WriteLaQnt03;
    property LaQnt04:Str1 read ReadLaQnt04 write WriteLaQnt04;
    property LaQnt05:Str1 read ReadLaQnt05 write WriteLaQnt05;
    property LaQnt06:Str1 read ReadLaQnt06 write WriteLaQnt06;
    property LaQnt07:Str1 read ReadLaQnt07 write WriteLaQnt07;
    property LaQnt08:Str1 read ReadLaQnt08 write WriteLaQnt08;
    property LaQnt09:Str1 read ReadLaQnt09 write WriteLaQnt09;
    property LaQnt10:Str1 read ReadLaQnt10 write WriteLaQnt10;
    property LaQnt11:Str1 read ReadLaQnt11 write WriteLaQnt11;
    property GsQnt01:Str1 read ReadGsQnt01 write WriteGsQnt01;
    property GsQnt02:Str1 read ReadGsQnt02 write WriteGsQnt02;
    property GsQnt03:Str1 read ReadGsQnt03 write WriteGsQnt03;
    property GsQnt04:Str1 read ReadGsQnt04 write WriteGsQnt04;
    property GsQnt05:Str1 read ReadGsQnt05 write WriteGsQnt05;
    property GsQnt06:Str1 read ReadGsQnt06 write WriteGsQnt06;
    property GsQnt07:Str1 read ReadGsQnt07 write WriteGsQnt07;
    property GsQnt08:Str1 read ReadGsQnt08 write WriteGsQnt08;
    property GsQnt09:Str1 read ReadGsQnt09 write WriteGsQnt09;
    property GsQnt10:Str1 read ReadGsQnt10 write WriteGsQnt10;
    property GsQnt11:Str1 read ReadGsQnt11 write WriteGsQnt11;
  end;

implementation

constructor TSrprn_cTmp.Create;
begin
  oTmpTable := TmpInit ('SRPRN_C',Self);
end;

destructor TSrprn_cTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrprn_cTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrprn_cTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrprn_cTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TSrprn_cTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TSrprn_cTmp.ReadSrCode01:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode01').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode01(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode01').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode02:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode02').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode02(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode02').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode03:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode03').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode03(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode03').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode04:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode04').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode04(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode04').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode05:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode05').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode05(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode05').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode06:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode06').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode06(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode06').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode07:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode07').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode07(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode07').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode08:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode08').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode08(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode08').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode09:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode09').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode09(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode09').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode10:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode10').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode10(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode10').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode11:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode11').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode11(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode11').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode12:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode12').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode12(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode12').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode13:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode13').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode13(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode13').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode14:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode14').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode14(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode14').AsString := pValue;
end;

function TSrprn_cTmp.ReadSrCode15:Str1;
begin
  Result := oTmpTable.FieldByName('SrCode15').AsString;
end;

procedure TSrprn_cTmp.WriteSrCode15(pValue:Str1);
begin
  oTmpTable.FieldByName('SrCode15').AsString := pValue;
end;

function TSrprn_cTmp.ReadTrdShop:Str1;
begin
  Result := oTmpTable.FieldByName('TrdShop').AsString;
end;

procedure TSrprn_cTmp.WriteTrdShop(pValue:Str1);
begin
  oTmpTable.FieldByName('TrdShop').AsString := pValue;
end;

function TSrprn_cTmp.ReadTrdStor:Str1;
begin
  Result := oTmpTable.FieldByName('TrdStor').AsString;
end;

procedure TSrprn_cTmp.WriteTrdStor(pValue:Str1);
begin
  oTmpTable.FieldByName('TrdStor').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt01').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt01').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt02').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt02').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt03').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt03').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt04').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt04').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt05').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt05').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt06').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt06').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt07').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt07').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt08').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt08').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt09').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt09').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt10').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt10').AsString := pValue;
end;

function TSrprn_cTmp.ReadLaQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt11').AsString;
end;

procedure TSrprn_cTmp.WriteLaQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt11').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt01').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt01').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt02').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt02').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt03').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt03').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt04').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt04').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt05').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt05').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt06').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt06').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt07').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt07').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt08').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt08').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt09').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt09').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt10').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt10').AsString := pValue;
end;

function TSrprn_cTmp.ReadGsQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('GsQnt11').AsString;
end;

procedure TSrprn_cTmp.WriteGsQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('GsQnt11').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrprn_cTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrprn_cTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrprn_cTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TSrprn_cTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrprn_cTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrprn_cTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrprn_cTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrprn_cTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrprn_cTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrprn_cTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrprn_cTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrprn_cTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrprn_cTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrprn_cTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrprn_cTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrprn_cTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrprn_cTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrprn_cTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrprn_cTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrprn_cTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
