unit tCSFREP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnIn = '';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';

type
  TCsfrepTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
    function  ReadIsdNum:Str12;          procedure WriteIsdNum (pValue:Str12);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadValue:double;          procedure WriteValue (pValue:double);
    function  ReadDocQnt:word;           procedure WriteDocQnt (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateCnIn (pCsdNum:Str12;pIsdNum:Str12):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

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
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
    property IsdNum:Str12 read ReadIsdNum write WriteIsdNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property Value:double read ReadValue write WriteValue;
    property DocQnt:word read ReadDocQnt write WriteDocQnt;
  end;

implementation

constructor TCsfrepTmp.Create;
begin
  oTmpTable := TmpInit ('CSFREP',Self);
end;

destructor TCsfrepTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCsfrepTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCsfrepTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCsfrepTmp.ReadCsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('CsdNum').AsString;
end;

procedure TCsfrepTmp.WriteCsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CsdNum').AsString := pValue;
end;

function TCsfrepTmp.ReadIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TCsfrepTmp.WriteIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IsdNum').AsString := pValue;
end;

function TCsfrepTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCsfrepTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCsfrepTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TCsfrepTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TCsfrepTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TCsfrepTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TCsfrepTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TCsfrepTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TCsfrepTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TCsfrepTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TCsfrepTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TCsfrepTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TCsfrepTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TCsfrepTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TCsfrepTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TCsfrepTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TCsfrepTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TCsfrepTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TCsfrepTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TCsfrepTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TCsfrepTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TCsfrepTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TCsfrepTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TCsfrepTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TCsfrepTmp.ReadValue:double;
begin
  Result := oTmpTable.FieldByName('Value').AsFloat;
end;

procedure TCsfrepTmp.WriteValue(pValue:double);
begin
  oTmpTable.FieldByName('Value').AsFloat := pValue;
end;

function TCsfrepTmp.ReadDocQnt:word;
begin
  Result := oTmpTable.FieldByName('DocQnt').AsInteger;
end;

procedure TCsfrepTmp.WriteDocQnt(pValue:word);
begin
  oTmpTable.FieldByName('DocQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsfrepTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCsfrepTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCsfrepTmp.LocateCnIn (pCsdNum:Str12;pIsdNum:Str12):boolean;
begin
  SetIndex (ixCnIn);
  Result := oTmpTable.FindKey([pCsdNum,pIsdNum]);
end;

function TCsfrepTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TCsfrepTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TCsfrepTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCsfrepTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCsfrepTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCsfrepTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCsfrepTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCsfrepTmp.First;
begin
  oTmpTable.First;
end;

procedure TCsfrepTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCsfrepTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCsfrepTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCsfrepTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCsfrepTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCsfrepTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCsfrepTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCsfrepTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCsfrepTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCsfrepTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCsfrepTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
