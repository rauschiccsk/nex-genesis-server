unit tEASACC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAsAnVg = '';

type
  TEasaccTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadVatGrp:byte;           procedure WriteVatGrp (pValue:byte);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadPmiVal:double;         procedure WritePmiVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
    function  ReadAccVal:double;         procedure WriteAccVal (pValue:double);
    function  ReadVatSnt:Str3;           procedure WriteVatSnt (pValue:Str3);
    function  ReadVatAnl:Str6;           procedure WriteVatAnl (pValue:Str6);
    function  ReadAccVat:double;         procedure WriteAccVat (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateAsAnVg (pAccSnt:Str3;pAccAnl:Str6;pVatGrp:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property VatGrp:byte read ReadVatGrp write WriteVatGrp;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property PmiVal:double read ReadPmiVal write WritePmiVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property PayVal:double read ReadPayVal write WritePayVal;
    property DifVal:double read ReadDifVal write WriteDifVal;
    property AccVal:double read ReadAccVal write WriteAccVal;
    property VatSnt:Str3 read ReadVatSnt write WriteVatSnt;
    property VatAnl:Str6 read ReadVatAnl write WriteVatAnl;
    property AccVat:double read ReadAccVat write WriteAccVat;
  end;

implementation

constructor TEasaccTmp.Create;
begin
  oTmpTable := TmpInit ('EASACC',Self);
end;

destructor TEasaccTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEasaccTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TEasaccTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TEasaccTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TEasaccTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TEasaccTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TEasaccTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TEasaccTmp.ReadVatGrp:byte;
begin
  Result := oTmpTable.FieldByName('VatGrp').AsInteger;
end;

procedure TEasaccTmp.WriteVatGrp(pValue:byte);
begin
  oTmpTable.FieldByName('VatGrp').AsInteger := pValue;
end;

function TEasaccTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TEasaccTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TEasaccTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TEasaccTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TEasaccTmp.ReadPmiVal:double;
begin
  Result := oTmpTable.FieldByName('PmiVal').AsFloat;
end;

procedure TEasaccTmp.WritePmiVal(pValue:double);
begin
  oTmpTable.FieldByName('PmiVal').AsFloat := pValue;
end;

function TEasaccTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TEasaccTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TEasaccTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TEasaccTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TEasaccTmp.ReadDifVal:double;
begin
  Result := oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TEasaccTmp.WriteDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat := pValue;
end;

function TEasaccTmp.ReadAccVal:double;
begin
  Result := oTmpTable.FieldByName('AccVal').AsFloat;
end;

procedure TEasaccTmp.WriteAccVal(pValue:double);
begin
  oTmpTable.FieldByName('AccVal').AsFloat := pValue;
end;

function TEasaccTmp.ReadVatSnt:Str3;
begin
  Result := oTmpTable.FieldByName('VatSnt').AsString;
end;

procedure TEasaccTmp.WriteVatSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('VatSnt').AsString := pValue;
end;

function TEasaccTmp.ReadVatAnl:Str6;
begin
  Result := oTmpTable.FieldByName('VatAnl').AsString;
end;

procedure TEasaccTmp.WriteVatAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('VatAnl').AsString := pValue;
end;

function TEasaccTmp.ReadAccVat:double;
begin
  Result := oTmpTable.FieldByName('AccVat').AsFloat;
end;

procedure TEasaccTmp.WriteAccVat(pValue:double);
begin
  oTmpTable.FieldByName('AccVat').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEasaccTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TEasaccTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TEasaccTmp.LocateAsAnVg (pAccSnt:Str3;pAccAnl:Str6;pVatGrp:byte):boolean;
begin
  SetIndex (ixAsAnVg);
  Result := oTmpTable.FindKey([pAccSnt,pAccAnl,pVatGrp]);
end;

procedure TEasaccTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TEasaccTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEasaccTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEasaccTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEasaccTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEasaccTmp.First;
begin
  oTmpTable.First;
end;

procedure TEasaccTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEasaccTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEasaccTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEasaccTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEasaccTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEasaccTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEasaccTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEasaccTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEasaccTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEasaccTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TEasaccTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
