unit tEXISIT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixOnOi = 'OnOi';
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';

type
  TExisitTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcCPrice:double;       procedure WriteAcCPrice (pValue:double);
    function  ReadAcDPrice:double;       procedure WriteAcDPrice (pValue:double);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadTvalue:double;         procedure WriteTvalue (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcCPrice:double read ReadAcCPrice write WriteAcCPrice;
    property AcDPrice:double read ReadAcDPrice write WriteAcDPrice;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property Tvalue:double read ReadTvalue write WriteTvalue;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TExisitTmp.Create;
begin
  oTmpTable := TmpInit ('EXISIT',Self);
end;

destructor TExisitTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TExisitTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TExisitTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TExisitTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TExisitTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TExisitTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TExisitTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TExisitTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TExisitTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TExisitTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TExisitTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TExisitTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TExisitTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TExisitTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TExisitTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TExisitTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TExisitTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TExisitTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TExisitTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TExisitTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TExisitTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TExisitTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TExisitTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TExisitTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TExisitTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TExisitTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TExisitTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TExisitTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TExisitTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TExisitTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TExisitTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TExisitTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TExisitTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TExisitTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TExisitTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TExisitTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TExisitTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TExisitTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TExisitTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TExisitTmp.ReadExpQnt:double;
begin
  Result := oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TExisitTmp.WriteExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TExisitTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TExisitTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TExisitTmp.ReadAcCPrice:double;
begin
  Result := oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TExisitTmp.WriteAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadAcDPrice:double;
begin
  Result := oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TExisitTmp.WriteAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadAcAPrice:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TExisitTmp.WriteAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadAcBPrice:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TExisitTmp.WriteAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TExisitTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TExisitTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TExisitTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TExisitTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TExisitTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TExisitTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TExisitTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TExisitTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TExisitTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TExisitTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TExisitTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TExisitTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TExisitTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadFgDPrice:double;
begin
  Result := oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TExisitTmp.WriteFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadFgAPrice:double;
begin
  Result := oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TExisitTmp.WriteFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadFgBPrice:double;
begin
  Result := oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TExisitTmp.WriteFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TExisitTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TExisitTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TExisitTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TExisitTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TExisitTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TExisitTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TExisitTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TExisitTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TExisitTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TExisitTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TExisitTmp.ReadTvalue:double;
begin
  Result := oTmpTable.FieldByName('Tvalue').AsFloat;
end;

procedure TExisitTmp.WriteTvalue(pValue:double);
begin
  oTmpTable.FieldByName('Tvalue').AsFloat := pValue;
end;

function TExisitTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TExisitTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TExisitTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TExisitTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TExisitTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TExisitTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TExisitTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TExisitTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TExisitTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TExisitTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TExisitTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TExisitTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TExisitTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TExisitTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TExisitTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TExisitTmp.LocateOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oTmpTable.FindKey([pOcdNum,pOcdItm]);
end;

function TExisitTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TExisitTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TExisitTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TExisitTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TExisitTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

procedure TExisitTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TExisitTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TExisitTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TExisitTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TExisitTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TExisitTmp.First;
begin
  oTmpTable.First;
end;

procedure TExisitTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TExisitTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TExisitTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TExisitTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TExisitTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TExisitTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TExisitTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TExisitTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TExisitTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TExisitTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TExisitTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1926001}
