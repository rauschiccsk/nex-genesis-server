unit bVTRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearClsNum = 'YearClsNum';
  ixClsNum = 'ClsNum';
  ixSySn = 'SySn';

type
  TVtrlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadClsNum:word;           procedure WriteClsNum (pValue:word);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadVtcNum:byte;           procedure WriteVtcNum (pValue:byte);
    function  ReadDocCls:byte;           procedure WriteDocCls (pValue:byte);
    function  ReadNotice:Str15;          procedure WriteNotice (pValue:Str15);
    function  ReadInVatVal:double;       procedure WriteInVatVal (pValue:double);
    function  ReadOuVatVal:double;       procedure WriteOuVatVal (pValue:double);
    function  ReadDfVatVal:double;       procedure WriteDfVatVal (pValue:double);
    function  ReadRndVal:double;         procedure WriteRndVal (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadDocQnt:word;           procedure WriteDocQnt (pValue:word);
    function  ReadPrnQnt:word;           procedure WritePrnQnt (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSttTyp:Str1;           procedure WriteSttTyp (pValue:Str1);
    function  ReadAddDate:TDatetime;     procedure WriteAddDate (pValue:TDatetime);
    function  ReadOblEnt:byte;           procedure WriteOblEnt (pValue:byte);
    function  ReadVIN:Str20;             procedure WriteVIN (pValue:Str20);
    function  ReadTIN:Str20;             procedure WriteTIN (pValue:Str20);
    function  ReadVatPrs:Str1;           procedure WriteVatPrs (pValue:Str1);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadPaAddr1:Str60;         procedure WritePaAddr1 (pValue:Str60);
    function  ReadPaAddr2:Str10;         procedure WritePaAddr2 (pValue:Str10);
    function  ReadRegStn:Str30;          procedure WriteRegStn (pValue:Str30);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str6;           procedure WriteRegZip (pValue:Str6);
    function  ReadRegEml:Str60;          procedure WriteRegEml (pValue:Str60);
    function  ReadRegTel:Str30;          procedure WriteRegTel (pValue:Str30);
    function  ReadRegFax:Str30;          procedure WriteRegFax (pValue:Str30);
    function  ReadAutNam:Str60;          procedure WriteAutNam (pValue:Str60);
    function  ReadAutTel:Str30;          procedure WriteAutTel (pValue:Str30);
    function  ReadVtrDate:TDatetime;     procedure WriteVtrDate (pValue:TDatetime);
    function  ReadSrcYear:Str2;          procedure WriteSrcYear (pValue:Str2);
    function  ReadSrcNum:longint;        procedure WriteSrcNum (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearClsNum (pYear:Str2;pClsNum:word):boolean;
    function LocateClsNum (pClsNum:word):boolean;
    function LocateSySn (pSrcYear:Str2;pSrcNum:longint):boolean;
    function NearestYearClsNum (pYear:Str2;pClsNum:word):boolean;
    function NearestClsNum (pClsNum:word):boolean;
    function NearestSySn (pSrcYear:Str2;pSrcNum:longint):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property ClsNum:word read ReadClsNum write WriteClsNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property VtcNum:byte read ReadVtcNum write WriteVtcNum;
    property DocCls:byte read ReadDocCls write WriteDocCls;
    property Notice:Str15 read ReadNotice write WriteNotice;
    property InVatVal:double read ReadInVatVal write WriteInVatVal;
    property OuVatVal:double read ReadOuVatVal write WriteOuVatVal;
    property DfVatVal:double read ReadDfVatVal write WriteDfVatVal;
    property RndVal:double read ReadRndVal write WriteRndVal;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property PayVal:double read ReadPayVal write WritePayVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property DocQnt:word read ReadDocQnt write WriteDocQnt;
    property PrnQnt:word read ReadPrnQnt write WritePrnQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property Year:Str2 read ReadYear write WriteYear;
    property SttTyp:Str1 read ReadSttTyp write WriteSttTyp;
    property AddDate:TDatetime read ReadAddDate write WriteAddDate;
    property OblEnt:byte read ReadOblEnt write WriteOblEnt;
    property VIN:Str20 read ReadVIN write WriteVIN;
    property TIN:Str20 read ReadTIN write WriteTIN;
    property VatPrs:Str1 read ReadVatPrs write WriteVatPrs;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property PaAddr1:Str60 read ReadPaAddr1 write WritePaAddr1;
    property PaAddr2:Str10 read ReadPaAddr2 write WritePaAddr2;
    property RegStn:Str30 read ReadRegStn write WriteRegStn;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str6 read ReadRegZip write WriteRegZip;
    property RegEml:Str60 read ReadRegEml write WriteRegEml;
    property RegTel:Str30 read ReadRegTel write WriteRegTel;
    property RegFax:Str30 read ReadRegFax write WriteRegFax;
    property AutNam:Str60 read ReadAutNam write WriteAutNam;
    property AutTel:Str30 read ReadAutTel write WriteAutTel;
    property VtrDate:TDatetime read ReadVtrDate write WriteVtrDate;
    property SrcYear:Str2 read ReadSrcYear write WriteSrcYear;
    property SrcNum:longint read ReadSrcNum write WriteSrcNum;
  end;

implementation

constructor TVtrlstBtr.Create;
begin
  oBtrTable := BtrInit ('VTRLST',gPath.LdgPath,Self);
end;

constructor TVtrlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VTRLST',pPath,Self);
end;

destructor TVtrlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVtrlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVtrlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVtrlstBtr.ReadClsNum:word;
begin
  Result := oBtrTable.FieldByName('ClsNum').AsInteger;
end;

procedure TVtrlstBtr.WriteClsNum(pValue:word);
begin
  oBtrTable.FieldByName('ClsNum').AsInteger := pValue;
end;

function TVtrlstBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TVtrlstBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TVtrlstBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadVtcNum:byte;
begin
  Result := oBtrTable.FieldByName('VtcNum').AsInteger;
end;

procedure TVtrlstBtr.WriteVtcNum(pValue:byte);
begin
  oBtrTable.FieldByName('VtcNum').AsInteger := pValue;
end;

function TVtrlstBtr.ReadDocCls:byte;
begin
  Result := oBtrTable.FieldByName('DocCls').AsInteger;
end;

procedure TVtrlstBtr.WriteDocCls(pValue:byte);
begin
  oBtrTable.FieldByName('DocCls').AsInteger := pValue;
end;

function TVtrlstBtr.ReadNotice:Str15;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TVtrlstBtr.WriteNotice(pValue:Str15);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TVtrlstBtr.ReadInVatVal:double;
begin
  Result := oBtrTable.FieldByName('InVatVal').AsFloat;
end;

procedure TVtrlstBtr.WriteInVatVal(pValue:double);
begin
  oBtrTable.FieldByName('InVatVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadOuVatVal:double;
begin
  Result := oBtrTable.FieldByName('OuVatVal').AsFloat;
end;

procedure TVtrlstBtr.WriteOuVatVal(pValue:double);
begin
  oBtrTable.FieldByName('OuVatVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadDfVatVal:double;
begin
  Result := oBtrTable.FieldByName('DfVatVal').AsFloat;
end;

procedure TVtrlstBtr.WriteDfVatVal(pValue:double);
begin
  oBtrTable.FieldByName('DfVatVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadRndVal:double;
begin
  Result := oBtrTable.FieldByName('RndVal').AsFloat;
end;

procedure TVtrlstBtr.WriteRndVal(pValue:double);
begin
  oBtrTable.FieldByName('RndVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TVtrlstBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TVtrlstBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TVtrlstBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TVtrlstBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TVtrlstBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadDocQnt:word;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsInteger;
end;

procedure TVtrlstBtr.WriteDocQnt(pValue:word);
begin
  oBtrTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TVtrlstBtr.ReadPrnQnt:word;
begin
  Result := oBtrTable.FieldByName('PrnQnt').AsInteger;
end;

procedure TVtrlstBtr.WritePrnQnt(pValue:word);
begin
  oBtrTable.FieldByName('PrnQnt').AsInteger := pValue;
end;

function TVtrlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TVtrlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVtrlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVtrlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVtrlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TVtrlstBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TVtrlstBtr.ReadSttTyp:Str1;
begin
  Result := oBtrTable.FieldByName('SttTyp').AsString;
end;

procedure TVtrlstBtr.WriteSttTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('SttTyp').AsString := pValue;
end;

function TVtrlstBtr.ReadAddDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AddDate').AsDateTime;
end;

procedure TVtrlstBtr.WriteAddDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AddDate').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadOblEnt:byte;
begin
  Result := oBtrTable.FieldByName('OblEnt').AsInteger;
end;

procedure TVtrlstBtr.WriteOblEnt(pValue:byte);
begin
  oBtrTable.FieldByName('OblEnt').AsInteger := pValue;
end;

function TVtrlstBtr.ReadVIN:Str20;
begin
  Result := oBtrTable.FieldByName('VIN').AsString;
end;

procedure TVtrlstBtr.WriteVIN(pValue:Str20);
begin
  oBtrTable.FieldByName('VIN').AsString := pValue;
end;

function TVtrlstBtr.ReadTIN:Str20;
begin
  Result := oBtrTable.FieldByName('TIN').AsString;
end;

procedure TVtrlstBtr.WriteTIN(pValue:Str20);
begin
  oBtrTable.FieldByName('TIN').AsString := pValue;
end;

function TVtrlstBtr.ReadVatPrs:Str1;
begin
  Result := oBtrTable.FieldByName('VatPrs').AsString;
end;

procedure TVtrlstBtr.WriteVatPrs(pValue:Str1);
begin
  oBtrTable.FieldByName('VatPrs').AsString := pValue;
end;

function TVtrlstBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TVtrlstBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TVtrlstBtr.ReadPaAddr1:Str60;
begin
  Result := oBtrTable.FieldByName('PaAddr1').AsString;
end;

procedure TVtrlstBtr.WritePaAddr1(pValue:Str60);
begin
  oBtrTable.FieldByName('PaAddr1').AsString := pValue;
end;

function TVtrlstBtr.ReadPaAddr2:Str10;
begin
  Result := oBtrTable.FieldByName('PaAddr2').AsString;
end;

procedure TVtrlstBtr.WritePaAddr2(pValue:Str10);
begin
  oBtrTable.FieldByName('PaAddr2').AsString := pValue;
end;

function TVtrlstBtr.ReadRegStn:Str30;
begin
  Result := oBtrTable.FieldByName('RegStn').AsString;
end;

procedure TVtrlstBtr.WriteRegStn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegStn').AsString := pValue;
end;

function TVtrlstBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TVtrlstBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TVtrlstBtr.ReadRegZip:Str6;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TVtrlstBtr.WriteRegZip(pValue:Str6);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TVtrlstBtr.ReadRegEml:Str60;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TVtrlstBtr.WriteRegEml(pValue:Str60);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TVtrlstBtr.ReadRegTel:Str30;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TVtrlstBtr.WriteRegTel(pValue:Str30);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TVtrlstBtr.ReadRegFax:Str30;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TVtrlstBtr.WriteRegFax(pValue:Str30);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TVtrlstBtr.ReadAutNam:Str60;
begin
  Result := oBtrTable.FieldByName('AutNam').AsString;
end;

procedure TVtrlstBtr.WriteAutNam(pValue:Str60);
begin
  oBtrTable.FieldByName('AutNam').AsString := pValue;
end;

function TVtrlstBtr.ReadAutTel:Str30;
begin
  Result := oBtrTable.FieldByName('AutTel').AsString;
end;

procedure TVtrlstBtr.WriteAutTel(pValue:Str30);
begin
  oBtrTable.FieldByName('AutTel').AsString := pValue;
end;

function TVtrlstBtr.ReadVtrDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('VtrDate').AsDateTime;
end;

procedure TVtrlstBtr.WriteVtrDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VtrDate').AsDateTime := pValue;
end;

function TVtrlstBtr.ReadSrcYear:Str2;
begin
  Result := oBtrTable.FieldByName('SrcYear').AsString;
end;

procedure TVtrlstBtr.WriteSrcYear(pValue:Str2);
begin
  oBtrTable.FieldByName('SrcYear').AsString := pValue;
end;

function TVtrlstBtr.ReadSrcNum:longint;
begin
  Result := oBtrTable.FieldByName('SrcNum').AsInteger;
end;

procedure TVtrlstBtr.WriteSrcNum(pValue:longint);
begin
  oBtrTable.FieldByName('SrcNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtrlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtrlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVtrlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtrlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVtrlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVtrlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVtrlstBtr.LocateYearClsNum (pYear:Str2;pClsNum:word):boolean;
begin
  SetIndex (ixYearClsNum);
  Result := oBtrTable.FindKey([pYear,pClsNum]);
end;

function TVtrlstBtr.LocateClsNum (pClsNum:word):boolean;
begin
  SetIndex (ixClsNum);
  Result := oBtrTable.FindKey([pClsNum]);
end;

function TVtrlstBtr.LocateSySn (pSrcYear:Str2;pSrcNum:longint):boolean;
begin
  SetIndex (ixSySn);
  Result := oBtrTable.FindKey([pSrcYear,pSrcNum]);
end;

function TVtrlstBtr.NearestYearClsNum (pYear:Str2;pClsNum:word):boolean;
begin
  SetIndex (ixYearClsNum);
  Result := oBtrTable.FindNearest([pYear,pClsNum]);
end;

function TVtrlstBtr.NearestClsNum (pClsNum:word):boolean;
begin
  SetIndex (ixClsNum);
  Result := oBtrTable.FindNearest([pClsNum]);
end;

function TVtrlstBtr.NearestSySn (pSrcYear:Str2;pSrcNum:longint):boolean;
begin
  SetIndex (ixSySn);
  Result := oBtrTable.FindNearest([pSrcYear,pSrcNum]);
end;

procedure TVtrlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVtrlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TVtrlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVtrlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVtrlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVtrlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TVtrlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVtrlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVtrlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVtrlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVtrlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVtrlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVtrlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVtrlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVtrlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVtrlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVtrlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
