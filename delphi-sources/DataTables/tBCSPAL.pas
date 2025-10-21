unit tBCSPAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName = 'PaName';
  ixRegIno = 'RegIno';
  ixSended = 'Sended';

type
  TBcspalTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadSmlName:Str10;         procedure WriteSmlName (pValue:Str10);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadItmQmt:word;           procedure WriteItmQmt (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadReliab:double;         procedure WriteReliab (pValue:double);
    function  ReadRatDay:longint;        procedure WriteRatDay (pValue:longint);
    function  ReadReliabN:double;        procedure WriteReliabN (pValue:double);
    function  ReadItmCnt:longint;        procedure WriteItmCnt (pValue:longint);
    function  ReadDlvCnt:longint;        procedure WriteDlvCnt (pValue:longint);
    function  ReadBDlCnt:longint;        procedure WriteBDlCnt (pValue:longint);
    function  ReadNDlCnt:longint;        procedure WriteNDlCnt (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateRegIno (pRegIno:Str15):boolean;
    function LocateSended (pSended:byte):boolean;

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
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property SmlName:Str10 read ReadSmlName write WriteSmlName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property ItmQmt:word read ReadItmQmt write WriteItmQmt;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property Reliab:double read ReadReliab write WriteReliab;
    property RatDay:longint read ReadRatDay write WriteRatDay;
    property ReliabN:double read ReadReliabN write WriteReliabN;
    property ItmCnt:longint read ReadItmCnt write WriteItmCnt;
    property DlvCnt:longint read ReadDlvCnt write WriteDlvCnt;
    property BDlCnt:longint read ReadBDlCnt write WriteBDlCnt;
    property NDlCnt:longint read ReadNDlCnt write WriteNDlCnt;
  end;

implementation

constructor TBcspalTmp.Create;
begin
  oTmpTable := TmpInit ('BCSPAL',Self);
end;

destructor TBcspalTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBcspalTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TBcspalTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TBcspalTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TBcspalTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TBcspalTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TBcspalTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TBcspalTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TBcspalTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TBcspalTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TBcspalTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TBcspalTmp.ReadSmlName:Str10;
begin
  Result := oTmpTable.FieldByName('SmlName').AsString;
end;

procedure TBcspalTmp.WriteSmlName(pValue:Str10);
begin
  oTmpTable.FieldByName('SmlName').AsString := pValue;
end;

function TBcspalTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TBcspalTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TBcspalTmp.ReadItmQmt:word;
begin
  Result := oTmpTable.FieldByName('ItmQmt').AsInteger;
end;

procedure TBcspalTmp.WriteItmQmt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQmt').AsInteger := pValue;
end;

function TBcspalTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TBcspalTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TBcspalTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TBcspalTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBcspalTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBcspalTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBcspalTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBcspalTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TBcspalTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TBcspalTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TBcspalTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TBcspalTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TBcspalTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBcspalTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBcspalTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBcspalTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TBcspalTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TBcspalTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TBcspalTmp.ReadReliab:double;
begin
  Result := oTmpTable.FieldByName('Reliab').AsFloat;
end;

procedure TBcspalTmp.WriteReliab(pValue:double);
begin
  oTmpTable.FieldByName('Reliab').AsFloat := pValue;
end;

function TBcspalTmp.ReadRatDay:longint;
begin
  Result := oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TBcspalTmp.WriteRatDay(pValue:longint);
begin
  oTmpTable.FieldByName('RatDay').AsInteger := pValue;
end;

function TBcspalTmp.ReadReliabN:double;
begin
  Result := oTmpTable.FieldByName('ReliabN').AsFloat;
end;

procedure TBcspalTmp.WriteReliabN(pValue:double);
begin
  oTmpTable.FieldByName('ReliabN').AsFloat := pValue;
end;

function TBcspalTmp.ReadItmCnt:longint;
begin
  Result := oTmpTable.FieldByName('ItmCnt').AsInteger;
end;

procedure TBcspalTmp.WriteItmCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ItmCnt').AsInteger := pValue;
end;

function TBcspalTmp.ReadDlvCnt:longint;
begin
  Result := oTmpTable.FieldByName('DlvCnt').AsInteger;
end;

procedure TBcspalTmp.WriteDlvCnt(pValue:longint);
begin
  oTmpTable.FieldByName('DlvCnt').AsInteger := pValue;
end;

function TBcspalTmp.ReadBDlCnt:longint;
begin
  Result := oTmpTable.FieldByName('BDlCnt').AsInteger;
end;

procedure TBcspalTmp.WriteBDlCnt(pValue:longint);
begin
  oTmpTable.FieldByName('BDlCnt').AsInteger := pValue;
end;

function TBcspalTmp.ReadNDlCnt:longint;
begin
  Result := oTmpTable.FieldByName('NDlCnt').AsInteger;
end;

procedure TBcspalTmp.WriteNDlCnt(pValue:longint);
begin
  oTmpTable.FieldByName('NDlCnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBcspalTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TBcspalTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TBcspalTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TBcspalTmp.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TBcspalTmp.LocateRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oTmpTable.FindKey([pRegIno]);
end;

function TBcspalTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

procedure TBcspalTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TBcspalTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBcspalTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBcspalTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBcspalTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBcspalTmp.First;
begin
  oTmpTable.First;
end;

procedure TBcspalTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBcspalTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBcspalTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBcspalTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBcspalTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBcspalTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBcspalTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBcspalTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBcspalTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBcspalTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TBcspalTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
