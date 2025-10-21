unit tBCSGSL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaGs = '';
  ixPaSc = 'PaSc';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixSupCode = 'SupCode';
  ixMgCode = 'MgCode';

type
  TBcsgslTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSupCode:Str15;         procedure WriteSupCode (pValue:Str15);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadOrdSta:Str1;           procedure WriteOrdSta (pValue:Str1);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadRatDay:longint;        procedure WriteRatDay (pValue:longint);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadMinOsq:double;         procedure WriteMinOsq (pValue:double);
    function  ReadMaxQnt:double;         procedure WriteMaxQnt (pValue:double);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadLastIDate:TDatetime;   procedure WriteLastIDate (pValue:TDatetime);
    function  ReadLastODate:TDatetime;   procedure WriteLastODate (pValue:TDatetime);
    function  ReadLastIQnt:double;       procedure WriteLastIQnt (pValue:double);
    function  ReadLastOQnt:double;       procedure WriteLastOQnt (pValue:double);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadMxwQnt:double;         procedure WriteMxwQnt (pValue:double);
    function  ReadMxwNum:longint;        procedure WriteMxwNum (pValue:longint);
    function  ReadSumQnt:double;         procedure WriteSumQnt (pValue:double);
    function  ReadCnoQnt:double;         procedure WriteCnoQnt (pValue:double);
    function  ReadCnmQnt:double;         procedure WriteCnmQnt (pValue:double);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadOsdQnt:double;         procedure WriteOsdQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadMinMax:Str1;           procedure WriteMinMax (pValue:Str1);
    function  ReadASaQnt:double;         procedure WriteASaQnt (pValue:double);
    function  ReadAOuQnt:double;         procedure WriteAOuQnt (pValue:double);
    function  ReadPSaQnt:double;         procedure WritePSaQnt (pValue:double);
    function  ReadPOuQnt:double;         procedure WritePOuQnt (pValue:double);
    function  ReadSsoQnt:double;         procedure WriteSsoQnt (pValue:double);
    function  ReadImrQnt:double;         procedure WriteImrQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaSc (pPaCode:longint;pSupCode:Str15):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSupCode (pSupCode:Str15):boolean;
    function LocateMgCode (pMgCode:longint):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SupCode:Str15 read ReadSupCode write WriteSupCode;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property OrdSta:Str1 read ReadOrdSta write WriteOrdSta;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property RatDay:longint read ReadRatDay write WriteRatDay;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property MinOsq:double read ReadMinOsq write WriteMinOsq;
    property MaxQnt:double read ReadMaxQnt write WriteMaxQnt;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property LastIDate:TDatetime read ReadLastIDate write WriteLastIDate;
    property LastODate:TDatetime read ReadLastODate write WriteLastODate;
    property LastIQnt:double read ReadLastIQnt write WriteLastIQnt;
    property LastOQnt:double read ReadLastOQnt write WriteLastOQnt;
    property Action:Str1 read ReadAction write WriteAction;
    property MxwQnt:double read ReadMxwQnt write WriteMxwQnt;
    property MxwNum:longint read ReadMxwNum write WriteMxwNum;
    property SumQnt:double read ReadSumQnt write WriteSumQnt;
    property CnoQnt:double read ReadCnoQnt write WriteCnoQnt;
    property CnmQnt:double read ReadCnmQnt write WriteCnmQnt;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property OsdQnt:double read ReadOsdQnt write WriteOsdQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property MinMax:Str1 read ReadMinMax write WriteMinMax;
    property ASaQnt:double read ReadASaQnt write WriteASaQnt;
    property AOuQnt:double read ReadAOuQnt write WriteAOuQnt;
    property PSaQnt:double read ReadPSaQnt write WritePSaQnt;
    property POuQnt:double read ReadPOuQnt write WritePOuQnt;
    property SsoQnt:double read ReadSsoQnt write WriteSsoQnt;
    property ImrQnt:double read ReadImrQnt write WriteImrQnt;
  end;

implementation

constructor TBcsgslTmp.Create;
begin
  oTmpTable := TmpInit ('BCSGSL',Self);
end;

destructor TBcsgslTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBcsgslTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TBcsgslTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TBcsgslTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TBcsgslTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TBcsgslTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TBcsgslTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TBcsgslTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TBcsgslTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TBcsgslTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TBcsgslTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TBcsgslTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TBcsgslTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TBcsgslTmp.ReadSupCode:Str15;
begin
  Result := oTmpTable.FieldByName('SupCode').AsString;
end;

procedure TBcsgslTmp.WriteSupCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SupCode').AsString := pValue;
end;

function TBcsgslTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TBcsgslTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TBcsgslTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TBcsgslTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBcsgslTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBcsgslTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBcsgslTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBcsgslTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TBcsgslTmp.ReadOrdSta:Str1;
begin
  Result := oTmpTable.FieldByName('OrdSta').AsString;
end;

procedure TBcsgslTmp.WriteOrdSta(pValue:Str1);
begin
  oTmpTable.FieldByName('OrdSta').AsString := pValue;
end;

function TBcsgslTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TBcsgslTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TBcsgslTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBcsgslTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBcsgslTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBcsgslTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TBcsgslTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TBcsgslTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TBcsgslTmp.ReadRatDay:longint;
begin
  Result := oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TBcsgslTmp.WriteRatDay(pValue:longint);
begin
  oTmpTable.FieldByName('RatDay').AsInteger := pValue;
end;

function TBcsgslTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadMinOsq:double;
begin
  Result := oTmpTable.FieldByName('MinOsq').AsFloat;
end;

procedure TBcsgslTmp.WriteMinOsq(pValue:double);
begin
  oTmpTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TBcsgslTmp.ReadMaxQnt:double;
begin
  Result := oTmpTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteMaxQnt(pValue:double);
begin
  oTmpTable.FieldByName('MaxQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadMinQnt:double;
begin
  Result := oTmpTable.FieldByName('MinQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteMinQnt(pValue:double);
begin
  oTmpTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadLastIDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LastIDate').AsDateTime;
end;

procedure TBcsgslTmp.WriteLastIDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LastIDate').AsDateTime := pValue;
end;

function TBcsgslTmp.ReadLastODate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LastODate').AsDateTime;
end;

procedure TBcsgslTmp.WriteLastODate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LastODate').AsDateTime := pValue;
end;

function TBcsgslTmp.ReadLastIQnt:double;
begin
  Result := oTmpTable.FieldByName('LastIQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteLastIQnt(pValue:double);
begin
  oTmpTable.FieldByName('LastIQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadLastOQnt:double;
begin
  Result := oTmpTable.FieldByName('LastOQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteLastOQnt(pValue:double);
begin
  oTmpTable.FieldByName('LastOQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TBcsgslTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TBcsgslTmp.ReadMxwQnt:double;
begin
  Result := oTmpTable.FieldByName('MxwQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteMxwQnt(pValue:double);
begin
  oTmpTable.FieldByName('MxwQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadMxwNum:longint;
begin
  Result := oTmpTable.FieldByName('MxwNum').AsInteger;
end;

procedure TBcsgslTmp.WriteMxwNum(pValue:longint);
begin
  oTmpTable.FieldByName('MxwNum').AsInteger := pValue;
end;

function TBcsgslTmp.ReadSumQnt:double;
begin
  Result := oTmpTable.FieldByName('SumQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteSumQnt(pValue:double);
begin
  oTmpTable.FieldByName('SumQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadCnoQnt:double;
begin
  Result := oTmpTable.FieldByName('CnoQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteCnoQnt(pValue:double);
begin
  oTmpTable.FieldByName('CnoQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadCnmQnt:double;
begin
  Result := oTmpTable.FieldByName('CnmQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteCnmQnt(pValue:double);
begin
  oTmpTable.FieldByName('CnmQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TBcsgslTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TBcsgslTmp.ReadOcdQnt:double;
begin
  Result := oTmpTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteOcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadNrsQnt:double;
begin
  Result := oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadOsdQnt:double;
begin
  Result := oTmpTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteOsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadMinMax:Str1;
begin
  Result := oTmpTable.FieldByName('MinMax').AsString;
end;

procedure TBcsgslTmp.WriteMinMax(pValue:Str1);
begin
  oTmpTable.FieldByName('MinMax').AsString := pValue;
end;

function TBcsgslTmp.ReadASaQnt:double;
begin
  Result := oTmpTable.FieldByName('ASaQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteASaQnt(pValue:double);
begin
  oTmpTable.FieldByName('ASaQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadAOuQnt:double;
begin
  Result := oTmpTable.FieldByName('AOuQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteAOuQnt(pValue:double);
begin
  oTmpTable.FieldByName('AOuQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadPSaQnt:double;
begin
  Result := oTmpTable.FieldByName('PSaQnt').AsFloat;
end;

procedure TBcsgslTmp.WritePSaQnt(pValue:double);
begin
  oTmpTable.FieldByName('PSaQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadPOuQnt:double;
begin
  Result := oTmpTable.FieldByName('POuQnt').AsFloat;
end;

procedure TBcsgslTmp.WritePOuQnt(pValue:double);
begin
  oTmpTable.FieldByName('POuQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadSsoQnt:double;
begin
  Result := oTmpTable.FieldByName('SsoQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteSsoQnt(pValue:double);
begin
  oTmpTable.FieldByName('SsoQnt').AsFloat := pValue;
end;

function TBcsgslTmp.ReadImrQnt:double;
begin
  Result := oTmpTable.FieldByName('ImrQnt').AsFloat;
end;

procedure TBcsgslTmp.WriteImrQnt(pValue:double);
begin
  oTmpTable.FieldByName('ImrQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBcsgslTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TBcsgslTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TBcsgslTmp.LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oTmpTable.FindKey([pPaCode,pGsCode]);
end;

function TBcsgslTmp.LocatePaSc (pPaCode:longint;pSupCode:Str15):boolean;
begin
  SetIndex (ixPaSc);
  Result := oTmpTable.FindKey([pPaCode,pSupCode]);
end;

function TBcsgslTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TBcsgslTmp.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TBcsgslTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TBcsgslTmp.LocateSupCode (pSupCode:Str15):boolean;
begin
  SetIndex (ixSupCode);
  Result := oTmpTable.FindKey([pSupCode]);
end;

function TBcsgslTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

procedure TBcsgslTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TBcsgslTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBcsgslTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBcsgslTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBcsgslTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBcsgslTmp.First;
begin
  oTmpTable.First;
end;

procedure TBcsgslTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBcsgslTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBcsgslTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBcsgslTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBcsgslTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBcsgslTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBcsgslTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBcsgslTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBcsgslTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBcsgslTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TBcsgslTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
