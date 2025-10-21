unit tMCICLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';

type
  TMciclcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcqAvalue:double;      procedure WriteAcqAvalue (pValue:double);
    function  ReadBasPrfPrc:double;      procedure WriteBasPrfPrc (pValue:double);
    function  ReadBasAvalue:double;      procedure WriteBasAvalue (pValue:double);
    function  ReadBciPrfPrc:double;      procedure WriteBciPrfPrc (pValue:double);
    function  ReadBciDscPrc:double;      procedure WriteBciDscPrc (pValue:double);
    function  ReadBciAvalue:double;      procedure WriteBciAvalue (pValue:double);
    function  ReadPrjPrfPrc:double;      procedure WritePrjPrfPrc (pValue:double);
    function  ReadPrjDscPrc:double;      procedure WritePrjDscPrc (pValue:double);
    function  ReadPrjAvalue:double;      procedure WritePrjAvalue (pValue:double);
    function  ReadResPrfPrc:double;      procedure WriteResPrfPrc (pValue:double);
    function  ReadResDscPrc:double;      procedure WriteResDscPrc (pValue:double);
    function  ReadResAvalue:double;      procedure WriteResAvalue (pValue:double);
    function  ReadResBvalue:double;      procedure WriteResBvalue (pValue:double);
    function  ReadClcStatus:Str1;        procedure WriteClcStatus (pValue:Str1);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcqAvalue:double read ReadAcqAvalue write WriteAcqAvalue;
    property BasPrfPrc:double read ReadBasPrfPrc write WriteBasPrfPrc;
    property BasAvalue:double read ReadBasAvalue write WriteBasAvalue;
    property BciPrfPrc:double read ReadBciPrfPrc write WriteBciPrfPrc;
    property BciDscPrc:double read ReadBciDscPrc write WriteBciDscPrc;
    property BciAvalue:double read ReadBciAvalue write WriteBciAvalue;
    property PrjPrfPrc:double read ReadPrjPrfPrc write WritePrjPrfPrc;
    property PrjDscPrc:double read ReadPrjDscPrc write WritePrjDscPrc;
    property PrjAvalue:double read ReadPrjAvalue write WritePrjAvalue;
    property ResPrfPrc:double read ReadResPrfPrc write WriteResPrfPrc;
    property ResDscPrc:double read ReadResDscPrc write WriteResDscPrc;
    property ResAvalue:double read ReadResAvalue write WriteResAvalue;
    property ResBvalue:double read ReadResBvalue write WriteResBvalue;
    property ClcStatus:Str1 read ReadClcStatus write WriteClcStatus;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TMciclcTmp.Create;
begin
  oTmpTable := TmpInit ('MCICLC',Self);
end;

destructor TMciclcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMciclcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TMciclcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TMciclcTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TMciclcTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TMciclcTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TMciclcTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TMciclcTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TMciclcTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TMciclcTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TMciclcTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TMciclcTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TMciclcTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TMciclcTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TMciclcTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TMciclcTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TMciclcTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TMciclcTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TMciclcTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TMciclcTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TMciclcTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TMciclcTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TMciclcTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadAcqAvalue:double;
begin
  Result := oTmpTable.FieldByName('AcqAvalue').AsFloat;
end;

procedure TMciclcTmp.WriteAcqAvalue(pValue:double);
begin
  oTmpTable.FieldByName('AcqAvalue').AsFloat := pValue;
end;

function TMciclcTmp.ReadBasPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('BasPrfPrc').AsFloat;
end;

procedure TMciclcTmp.WriteBasPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('BasPrfPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadBasAvalue:double;
begin
  Result := oTmpTable.FieldByName('BasAvalue').AsFloat;
end;

procedure TMciclcTmp.WriteBasAvalue(pValue:double);
begin
  oTmpTable.FieldByName('BasAvalue').AsFloat := pValue;
end;

function TMciclcTmp.ReadBciPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('BciPrfPrc').AsFloat;
end;

procedure TMciclcTmp.WriteBciPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('BciPrfPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadBciDscPrc:double;
begin
  Result := oTmpTable.FieldByName('BciDscPrc').AsFloat;
end;

procedure TMciclcTmp.WriteBciDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('BciDscPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadBciAvalue:double;
begin
  Result := oTmpTable.FieldByName('BciAvalue').AsFloat;
end;

procedure TMciclcTmp.WriteBciAvalue(pValue:double);
begin
  oTmpTable.FieldByName('BciAvalue').AsFloat := pValue;
end;

function TMciclcTmp.ReadPrjPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrjPrfPrc').AsFloat;
end;

procedure TMciclcTmp.WritePrjPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrjPrfPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadPrjDscPrc:double;
begin
  Result := oTmpTable.FieldByName('PrjDscPrc').AsFloat;
end;

procedure TMciclcTmp.WritePrjDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrjDscPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadPrjAvalue:double;
begin
  Result := oTmpTable.FieldByName('PrjAvalue').AsFloat;
end;

procedure TMciclcTmp.WritePrjAvalue(pValue:double);
begin
  oTmpTable.FieldByName('PrjAvalue').AsFloat := pValue;
end;

function TMciclcTmp.ReadResPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('ResPrfPrc').AsFloat;
end;

procedure TMciclcTmp.WriteResPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('ResPrfPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadResDscPrc:double;
begin
  Result := oTmpTable.FieldByName('ResDscPrc').AsFloat;
end;

procedure TMciclcTmp.WriteResDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('ResDscPrc').AsFloat := pValue;
end;

function TMciclcTmp.ReadResAvalue:double;
begin
  Result := oTmpTable.FieldByName('ResAvalue').AsFloat;
end;

procedure TMciclcTmp.WriteResAvalue(pValue:double);
begin
  oTmpTable.FieldByName('ResAvalue').AsFloat := pValue;
end;

function TMciclcTmp.ReadResBvalue:double;
begin
  Result := oTmpTable.FieldByName('ResBvalue').AsFloat;
end;

procedure TMciclcTmp.WriteResBvalue(pValue:double);
begin
  oTmpTable.FieldByName('ResBvalue').AsFloat := pValue;
end;

function TMciclcTmp.ReadClcStatus:Str1;
begin
  Result := oTmpTable.FieldByName('ClcStatus').AsString;
end;

procedure TMciclcTmp.WriteClcStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('ClcStatus').AsString := pValue;
end;

function TMciclcTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TMciclcTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMciclcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TMciclcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TMciclcTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TMciclcTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

procedure TMciclcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TMciclcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMciclcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMciclcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMciclcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMciclcTmp.First;
begin
  oTmpTable.First;
end;

procedure TMciclcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMciclcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMciclcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMciclcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMciclcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMciclcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMciclcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMciclcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMciclcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMciclcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TMciclcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1804002}
