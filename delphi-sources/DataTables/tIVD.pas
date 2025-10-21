unit tIVD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName = 'GsName';
  ixDifQnt = 'DifQnt';
  ixDifVal = 'DifVal';
  ixDifStat = 'DifStat';

type
  TIvdTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadIvQnt:double;          procedure WriteIvQnt (pValue:double);
    function  ReadStQnt:double;          procedure WriteStQnt (pValue:double);
    function  ReadNsQnt:double;          procedure WriteNsQnt (pValue:double);
    function  ReadCpQnt:double;          procedure WriteCpQnt (pValue:double);
    function  ReadEvQnt:double;          procedure WriteEvQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadIvVal:double;          procedure WriteIvVal (pValue:double);
    function  ReadStVal:double;          procedure WriteStVal (pValue:double);
    function  ReadNsVal:double;          procedure WriteNsVal (pValue:double);
    function  ReadCpVal:double;          procedure WriteCpVal (pValue:double);
    function  ReadEvVal:double;          procedure WriteEvVal (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadDifStat:Str1;          procedure WriteDifStat (pValue:Str1);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadGaName:Str100;         procedure WriteGaName (pValue:Str100);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateDifQnt (pDifQnt:double):boolean;
    function LocateDifVal (pDifVal:double):boolean;
    function LocateDifStat (pDifStat:Str1):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property IvQnt:double read ReadIvQnt write WriteIvQnt;
    property StQnt:double read ReadStQnt write WriteStQnt;
    property NsQnt:double read ReadNsQnt write WriteNsQnt;
    property CpQnt:double read ReadCpQnt write WriteCpQnt;
    property EvQnt:double read ReadEvQnt write WriteEvQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property IvVal:double read ReadIvVal write WriteIvVal;
    property StVal:double read ReadStVal write WriteStVal;
    property NsVal:double read ReadNsVal write WriteNsVal;
    property CpVal:double read ReadCpVal write WriteCpVal;
    property EvVal:double read ReadEvVal write WriteEvVal;
    property DifVal:double read ReadDifVal write WriteDifVal;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property DifStat:Str1 read ReadDifStat write WriteDifStat;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property GaName:Str100 read ReadGaName write WriteGaName;
  end;

implementation

constructor TIvdTmp.Create;
begin
  oTmpTable := TmpInit ('IVD',Self);
end;

destructor TIvdTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIvdTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIvdTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIvdTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TIvdTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIvdTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TIvdTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TIvdTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TIvdTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TIvdTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TIvdTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TIvdTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TIvdTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TIvdTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TIvdTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TIvdTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TIvdTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TIvdTmp.ReadIvQnt:double;
begin
  Result := oTmpTable.FieldByName('IvQnt').AsFloat;
end;

procedure TIvdTmp.WriteIvQnt(pValue:double);
begin
  oTmpTable.FieldByName('IvQnt').AsFloat := pValue;
end;

function TIvdTmp.ReadStQnt:double;
begin
  Result := oTmpTable.FieldByName('StQnt').AsFloat;
end;

procedure TIvdTmp.WriteStQnt(pValue:double);
begin
  oTmpTable.FieldByName('StQnt').AsFloat := pValue;
end;

function TIvdTmp.ReadNsQnt:double;
begin
  Result := oTmpTable.FieldByName('NsQnt').AsFloat;
end;

procedure TIvdTmp.WriteNsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsQnt').AsFloat := pValue;
end;

function TIvdTmp.ReadCpQnt:double;
begin
  Result := oTmpTable.FieldByName('CpQnt').AsFloat;
end;

procedure TIvdTmp.WriteCpQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpQnt').AsFloat := pValue;
end;

function TIvdTmp.ReadEvQnt:double;
begin
  Result := oTmpTable.FieldByName('EvQnt').AsFloat;
end;

procedure TIvdTmp.WriteEvQnt(pValue:double);
begin
  oTmpTable.FieldByName('EvQnt').AsFloat := pValue;
end;

function TIvdTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TIvdTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TIvdTmp.ReadIvVal:double;
begin
  Result := oTmpTable.FieldByName('IvVal').AsFloat;
end;

procedure TIvdTmp.WriteIvVal(pValue:double);
begin
  oTmpTable.FieldByName('IvVal').AsFloat := pValue;
end;

function TIvdTmp.ReadStVal:double;
begin
  Result := oTmpTable.FieldByName('StVal').AsFloat;
end;

procedure TIvdTmp.WriteStVal(pValue:double);
begin
  oTmpTable.FieldByName('StVal').AsFloat := pValue;
end;

function TIvdTmp.ReadNsVal:double;
begin
  Result := oTmpTable.FieldByName('NsVal').AsFloat;
end;

procedure TIvdTmp.WriteNsVal(pValue:double);
begin
  oTmpTable.FieldByName('NsVal').AsFloat := pValue;
end;

function TIvdTmp.ReadCpVal:double;
begin
  Result := oTmpTable.FieldByName('CpVal').AsFloat;
end;

procedure TIvdTmp.WriteCpVal(pValue:double);
begin
  oTmpTable.FieldByName('CpVal').AsFloat := pValue;
end;

function TIvdTmp.ReadEvVal:double;
begin
  Result := oTmpTable.FieldByName('EvVal').AsFloat;
end;

procedure TIvdTmp.WriteEvVal(pValue:double);
begin
  oTmpTable.FieldByName('EvVal').AsFloat := pValue;
end;

function TIvdTmp.ReadDifVal:double;
begin
  Result := oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TIvdTmp.WriteDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat := pValue;
end;

function TIvdTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TIvdTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TIvdTmp.ReadDifStat:Str1;
begin
  Result := oTmpTable.FieldByName('DifStat').AsString;
end;

procedure TIvdTmp.WriteDifStat(pValue:Str1);
begin
  oTmpTable.FieldByName('DifStat').AsString := pValue;
end;

function TIvdTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIvdTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIvdTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIvdTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIvdTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIvdTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIvdTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIvdTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TIvdTmp.ReadGaName:Str100;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TIvdTmp.WriteGaName(pValue:Str100);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvdTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIvdTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIvdTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TIvdTmp.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TIvdTmp.LocateDifQnt (pDifQnt:double):boolean;
begin
  SetIndex (ixDifQnt);
  Result := oTmpTable.FindKey([pDifQnt]);
end;

function TIvdTmp.LocateDifVal (pDifVal:double):boolean;
begin
  SetIndex (ixDifVal);
  Result := oTmpTable.FindKey([pDifVal]);
end;

function TIvdTmp.LocateDifStat (pDifStat:Str1):boolean;
begin
  SetIndex (ixDifStat);
  Result := oTmpTable.FindKey([pDifStat]);
end;

procedure TIvdTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIvdTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIvdTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIvdTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIvdTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIvdTmp.First;
begin
  oTmpTable.First;
end;

procedure TIvdTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIvdTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIvdTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIvdTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIvdTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIvdTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIvdTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIvdTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIvdTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIvdTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIvdTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
