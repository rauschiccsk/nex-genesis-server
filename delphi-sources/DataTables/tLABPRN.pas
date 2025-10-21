unit tLABPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';

type
  TLabprnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadInfDvz:Str3;           procedure WriteInfDvz (pValue:Str3);
    function  ReadAccDvz:Str3;           procedure WriteAccDvz (pValue:Str3);
    function  ReadFixCrs:Str10;          procedure WriteFixCrs (pValue:Str10);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadAcXPrice:double;       procedure WriteAcXPrice (pValue:double);
    function  ReadAcBpcInt:Str6;         procedure WriteAcBpcInt (pValue:Str6);
    function  ReadAcBpcFrc:Str2;         procedure WriteAcBpcFrc (pValue:Str2);
    function  ReadAcYPrice:Str15;        procedure WriteAcYPrice (pValue:Str15);
    function  ReadAcMPrice:Str15;        procedure WriteAcMPrice (pValue:Str15);
    function  ReadAcMuName:Str10;        procedure WriteAcMuName (pValue:Str10);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgXPrice:double;       procedure WriteFgXPrice (pValue:double);
    function  ReadFgYPrice:Str15;        procedure WriteFgYPrice (pValue:Str15);
    function  ReadFgMPrice:Str15;        procedure WriteFgMPrice (pValue:Str15);
    function  ReadMinPrice:double;       procedure WriteMinPrice (pValue:double);
    function  ReadFgMuName:Str10;        procedure WriteFgMuName (pValue:Str10);
    function  ReadNotice1:Str60;         procedure WriteNotice1 (pValue:Str60);
    function  ReadNotice2:Str60;         procedure WriteNotice2 (pValue:Str60);
    function  ReadNotice3:Str60;         procedure WriteNotice3 (pValue:Str60);
    function  ReadNotice4:Str60;         procedure WriteNotice4 (pValue:Str60);
    function  ReadNotice5:Str60;         procedure WriteNotice5 (pValue:Str60);
    function  ReadNotice6:Str60;         procedure WriteNotice6 (pValue:Str60);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:longint):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property InfDvz:Str3 read ReadInfDvz write WriteInfDvz;
    property AccDvz:Str3 read ReadAccDvz write WriteAccDvz;
    property FixCrs:Str10 read ReadFixCrs write WriteFixCrs;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property AcXPrice:double read ReadAcXPrice write WriteAcXPrice;
    property AcBpcInt:Str6 read ReadAcBpcInt write WriteAcBpcInt;
    property AcBpcFrc:Str2 read ReadAcBpcFrc write WriteAcBpcFrc;
    property AcYPrice:Str15 read ReadAcYPrice write WriteAcYPrice;
    property AcMPrice:Str15 read ReadAcMPrice write WriteAcMPrice;
    property AcMuName:Str10 read ReadAcMuName write WriteAcMuName;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgXPrice:double read ReadFgXPrice write WriteFgXPrice;
    property FgYPrice:Str15 read ReadFgYPrice write WriteFgYPrice;
    property FgMPrice:Str15 read ReadFgMPrice write WriteFgMPrice;
    property MinPrice:double read ReadMinPrice write WriteMinPrice;
    property FgMuName:Str10 read ReadFgMuName write WriteFgMuName;
    property Notice1:Str60 read ReadNotice1 write WriteNotice1;
    property Notice2:Str60 read ReadNotice2 write WriteNotice2;
    property Notice3:Str60 read ReadNotice3 write WriteNotice3;
    property Notice4:Str60 read ReadNotice4 write WriteNotice4;
    property Notice5:Str60 read ReadNotice5 write WriteNotice5;
    property Notice6:Str60 read ReadNotice6 write WriteNotice6;
  end;

implementation

constructor TLabprnTmp.Create;
begin
  oTmpTable := TmpInit ('LABPRN',Self);
end;

destructor TLabprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TLabprnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TLabprnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TLabprnTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TLabprnTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TLabprnTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TLabprnTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TLabprnTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TLabprnTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TLabprnTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TLabprnTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TLabprnTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TLabprnTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TLabprnTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TLabprnTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TLabprnTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TLabprnTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TLabprnTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TLabprnTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TLabprnTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TLabprnTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TLabprnTmp.ReadInfDvz:Str3;
begin
  Result := oTmpTable.FieldByName('InfDvz').AsString;
end;

procedure TLabprnTmp.WriteInfDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('InfDvz').AsString := pValue;
end;

function TLabprnTmp.ReadAccDvz:Str3;
begin
  Result := oTmpTable.FieldByName('AccDvz').AsString;
end;

procedure TLabprnTmp.WriteAccDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('AccDvz').AsString := pValue;
end;

function TLabprnTmp.ReadFixCrs:Str10;
begin
  Result := oTmpTable.FieldByName('FixCrs').AsString;
end;

procedure TLabprnTmp.WriteFixCrs(pValue:Str10);
begin
  oTmpTable.FieldByName('FixCrs').AsString := pValue;
end;

function TLabprnTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TLabprnTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TLabprnTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TLabprnTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TLabprnTmp.ReadAcAPrice:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TLabprnTmp.WriteAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadAcBPrice:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TLabprnTmp.WriteAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadAcXPrice:double;
begin
  Result := oTmpTable.FieldByName('AcXPrice').AsFloat;
end;

procedure TLabprnTmp.WriteAcXPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcXPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadAcBpcInt:Str6;
begin
  Result := oTmpTable.FieldByName('AcBpcInt').AsString;
end;

procedure TLabprnTmp.WriteAcBpcInt(pValue:Str6);
begin
  oTmpTable.FieldByName('AcBpcInt').AsString := pValue;
end;

function TLabprnTmp.ReadAcBpcFrc:Str2;
begin
  Result := oTmpTable.FieldByName('AcBpcFrc').AsString;
end;

procedure TLabprnTmp.WriteAcBpcFrc(pValue:Str2);
begin
  oTmpTable.FieldByName('AcBpcFrc').AsString := pValue;
end;

function TLabprnTmp.ReadAcYPrice:Str15;
begin
  Result := oTmpTable.FieldByName('AcYPrice').AsString;
end;

procedure TLabprnTmp.WriteAcYPrice(pValue:Str15);
begin
  oTmpTable.FieldByName('AcYPrice').AsString := pValue;
end;

function TLabprnTmp.ReadAcMPrice:Str15;
begin
  Result := oTmpTable.FieldByName('AcMPrice').AsString;
end;

procedure TLabprnTmp.WriteAcMPrice(pValue:Str15);
begin
  oTmpTable.FieldByName('AcMPrice').AsString := pValue;
end;

function TLabprnTmp.ReadAcMuName:Str10;
begin
  Result := oTmpTable.FieldByName('AcMuName').AsString;
end;

procedure TLabprnTmp.WriteAcMuName(pValue:Str10);
begin
  oTmpTable.FieldByName('AcMuName').AsString := pValue;
end;

function TLabprnTmp.ReadFgAPrice:double;
begin
  Result := oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TLabprnTmp.WriteFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadFgBPrice:double;
begin
  Result := oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TLabprnTmp.WriteFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadFgXPrice:double;
begin
  Result := oTmpTable.FieldByName('FgXPrice').AsFloat;
end;

procedure TLabprnTmp.WriteFgXPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgXPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadFgYPrice:Str15;
begin
  Result := oTmpTable.FieldByName('FgYPrice').AsString;
end;

procedure TLabprnTmp.WriteFgYPrice(pValue:Str15);
begin
  oTmpTable.FieldByName('FgYPrice').AsString := pValue;
end;

function TLabprnTmp.ReadFgMPrice:Str15;
begin
  Result := oTmpTable.FieldByName('FgMPrice').AsString;
end;

procedure TLabprnTmp.WriteFgMPrice(pValue:Str15);
begin
  oTmpTable.FieldByName('FgMPrice').AsString := pValue;
end;

function TLabprnTmp.ReadMinPrice:double;
begin
  Result := oTmpTable.FieldByName('MinPrice').AsFloat;
end;

procedure TLabprnTmp.WriteMinPrice(pValue:double);
begin
  oTmpTable.FieldByName('MinPrice').AsFloat := pValue;
end;

function TLabprnTmp.ReadFgMuName:Str10;
begin
  Result := oTmpTable.FieldByName('FgMuName').AsString;
end;

procedure TLabprnTmp.WriteFgMuName(pValue:Str10);
begin
  oTmpTable.FieldByName('FgMuName').AsString := pValue;
end;

function TLabprnTmp.ReadNotice1:Str60;
begin
  Result := oTmpTable.FieldByName('Notice1').AsString;
end;

procedure TLabprnTmp.WriteNotice1(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice1').AsString := pValue;
end;

function TLabprnTmp.ReadNotice2:Str60;
begin
  Result := oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TLabprnTmp.WriteNotice2(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice2').AsString := pValue;
end;

function TLabprnTmp.ReadNotice3:Str60;
begin
  Result := oTmpTable.FieldByName('Notice3').AsString;
end;

procedure TLabprnTmp.WriteNotice3(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice3').AsString := pValue;
end;

function TLabprnTmp.ReadNotice4:Str60;
begin
  Result := oTmpTable.FieldByName('Notice4').AsString;
end;

procedure TLabprnTmp.WriteNotice4(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice4').AsString := pValue;
end;

function TLabprnTmp.ReadNotice5:Str60;
begin
  Result := oTmpTable.FieldByName('Notice5').AsString;
end;

procedure TLabprnTmp.WriteNotice5(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice5').AsString := pValue;
end;

function TLabprnTmp.ReadNotice6:Str60;
begin
  Result := oTmpTable.FieldByName('Notice6').AsString;
end;

procedure TLabprnTmp.WriteNotice6(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice6').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLabprnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TLabprnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TLabprnTmp.LocateItmNum (pItmNum:longint):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

procedure TLabprnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TLabprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TLabprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TLabprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TLabprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TLabprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TLabprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TLabprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TLabprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TLabprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TLabprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TLabprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TLabprnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TLabprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TLabprnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TLabprnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TLabprnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
