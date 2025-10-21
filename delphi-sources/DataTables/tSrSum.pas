unit tSRSUM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';

type
  TSrsumTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadPrcVol:double;         procedure WritePrcVol (pValue:double);
    function  ReadBegQnt1:double;        procedure WriteBegQnt1 (pValue:double);
    function  ReadIncQnt1:double;        procedure WriteIncQnt1 (pValue:double);
    function  ReadOutQnt1:double;        procedure WriteOutQnt1 (pValue:double);
    function  ReadInvQnt1:double;        procedure WriteInvQnt1 (pValue:double);
    function  ReadEndQnt1:double;        procedure WriteEndQnt1 (pValue:double);
    function  ReadBegQnt2:double;        procedure WriteBegQnt2 (pValue:double);
    function  ReadIncQnt2:double;        procedure WriteIncQnt2 (pValue:double);
    function  ReadOutQnt2:double;        procedure WriteOutQnt2 (pValue:double);
    function  ReadInvQnt2:double;        procedure WriteInvQnt2 (pValue:double);
    function  ReadEndQnt2:double;        procedure WriteEndQnt2 (pValue:double);
    function  ReadBegQnt3:double;        procedure WriteBegQnt3 (pValue:double);
    function  ReadIncQnt3:double;        procedure WriteIncQnt3 (pValue:double);
    function  ReadOutQnt3:double;        procedure WriteOutQnt3 (pValue:double);
    function  ReadInvQnt3:double;        procedure WriteInvQnt3 (pValue:double);
    function  ReadEndQnt3:double;        procedure WriteEndQnt3 (pValue:double);
    function  ReadBegQnt4:double;        procedure WriteBegQnt4 (pValue:double);
    function  ReadIncQnt4:double;        procedure WriteIncQnt4 (pValue:double);
    function  ReadOutQnt4:double;        procedure WriteOutQnt4 (pValue:double);
    function  ReadInvQnt4:double;        procedure WriteInvQnt4 (pValue:double);
    function  ReadEndQnt4:double;        procedure WriteEndQnt4 (pValue:double);
    function  ReadBegQnt5:double;        procedure WriteBegQnt5 (pValue:double);
    function  ReadIncQnt5:double;        procedure WriteIncQnt5 (pValue:double);
    function  ReadOutQnt5:double;        procedure WriteOutQnt5 (pValue:double);
    function  ReadInvQnt5:double;        procedure WriteInvQnt5 (pValue:double);
    function  ReadEndQnt5:double;        procedure WriteEndQnt5 (pValue:double);
    function  ReadBegQnt6:double;        procedure WriteBegQnt6 (pValue:double);
    function  ReadIncQnt6:double;        procedure WriteIncQnt6 (pValue:double);
    function  ReadOutQnt6:double;        procedure WriteOutQnt6 (pValue:double);
    function  ReadInvQnt6:double;        procedure WriteInvQnt6 (pValue:double);
    function  ReadEndQnt6:double;        procedure WriteEndQnt6 (pValue:double);
    function  ReadBegQnt7:double;        procedure WriteBegQnt7 (pValue:double);
    function  ReadIncQnt7:double;        procedure WriteIncQnt7 (pValue:double);
    function  ReadOutQnt7:double;        procedure WriteOutQnt7 (pValue:double);
    function  ReadInvQnt7:double;        procedure WriteInvQnt7 (pValue:double);
    function  ReadEndQnt7:double;        procedure WriteEndQnt7 (pValue:double);
    function  ReadBegQnt8:double;        procedure WriteBegQnt8 (pValue:double);
    function  ReadIncQnt8:double;        procedure WriteIncQnt8 (pValue:double);
    function  ReadOutQnt8:double;        procedure WriteOutQnt8 (pValue:double);
    function  ReadInvQnt8:double;        procedure WriteInvQnt8 (pValue:double);
    function  ReadEndQnt8:double;        procedure WriteEndQnt8 (pValue:double);
    function  ReadBegQnt9:double;        procedure WriteBegQnt9 (pValue:double);
    function  ReadIncQnt9:double;        procedure WriteIncQnt9 (pValue:double);
    function  ReadOutQnt9:double;        procedure WriteOutQnt9 (pValue:double);
    function  ReadInvQnt9:double;        procedure WriteInvQnt9 (pValue:double);
    function  ReadEndQnt9:double;        procedure WriteEndQnt9 (pValue:double);
    function  ReadBegQnt10:double;       procedure WriteBegQnt10 (pValue:double);
    function  ReadIncQnt10:double;       procedure WriteIncQnt10 (pValue:double);
    function  ReadOutQnt10:double;       procedure WriteOutQnt10 (pValue:double);
    function  ReadInvQnt10:double;       procedure WriteInvQnt10 (pValue:double);
    function  ReadEndQnt10:double;       procedure WriteEndQnt10 (pValue:double);
    function  ReadBegQnt11:double;       procedure WriteBegQnt11 (pValue:double);
    function  ReadIncQnt11:double;       procedure WriteIncQnt11 (pValue:double);
    function  ReadOutQnt11:double;       procedure WriteOutQnt11 (pValue:double);
    function  ReadInvQnt11:double;       procedure WriteInvQnt11 (pValue:double);
    function  ReadEndQnt11:double;       procedure WriteEndQnt11 (pValue:double);
    function  ReadBegQnt12:double;       procedure WriteBegQnt12 (pValue:double);
    function  ReadIncQnt12:double;       procedure WriteIncQnt12 (pValue:double);
    function  ReadOutQnt12:double;       procedure WriteOutQnt12 (pValue:double);
    function  ReadInvQnt12:double;       procedure WriteInvQnt12 (pValue:double);
    function  ReadEndQnt12:double;       procedure WriteEndQnt12 (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

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
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property Volume:double read ReadVolume write WriteVolume;
    property PrcVol:double read ReadPrcVol write WritePrcVol;
    property BegQnt1:double read ReadBegQnt1 write WriteBegQnt1;
    property IncQnt1:double read ReadIncQnt1 write WriteIncQnt1;
    property OutQnt1:double read ReadOutQnt1 write WriteOutQnt1;
    property InvQnt1:double read ReadInvQnt1 write WriteInvQnt1;
    property EndQnt1:double read ReadEndQnt1 write WriteEndQnt1;
    property BegQnt2:double read ReadBegQnt2 write WriteBegQnt2;
    property IncQnt2:double read ReadIncQnt2 write WriteIncQnt2;
    property OutQnt2:double read ReadOutQnt2 write WriteOutQnt2;
    property InvQnt2:double read ReadInvQnt2 write WriteInvQnt2;
    property EndQnt2:double read ReadEndQnt2 write WriteEndQnt2;
    property BegQnt3:double read ReadBegQnt3 write WriteBegQnt3;
    property IncQnt3:double read ReadIncQnt3 write WriteIncQnt3;
    property OutQnt3:double read ReadOutQnt3 write WriteOutQnt3;
    property InvQnt3:double read ReadInvQnt3 write WriteInvQnt3;
    property EndQnt3:double read ReadEndQnt3 write WriteEndQnt3;
    property BegQnt4:double read ReadBegQnt4 write WriteBegQnt4;
    property IncQnt4:double read ReadIncQnt4 write WriteIncQnt4;
    property OutQnt4:double read ReadOutQnt4 write WriteOutQnt4;
    property InvQnt4:double read ReadInvQnt4 write WriteInvQnt4;
    property EndQnt4:double read ReadEndQnt4 write WriteEndQnt4;
    property BegQnt5:double read ReadBegQnt5 write WriteBegQnt5;
    property IncQnt5:double read ReadIncQnt5 write WriteIncQnt5;
    property OutQnt5:double read ReadOutQnt5 write WriteOutQnt5;
    property InvQnt5:double read ReadInvQnt5 write WriteInvQnt5;
    property EndQnt5:double read ReadEndQnt5 write WriteEndQnt5;
    property BegQnt6:double read ReadBegQnt6 write WriteBegQnt6;
    property IncQnt6:double read ReadIncQnt6 write WriteIncQnt6;
    property OutQnt6:double read ReadOutQnt6 write WriteOutQnt6;
    property InvQnt6:double read ReadInvQnt6 write WriteInvQnt6;
    property EndQnt6:double read ReadEndQnt6 write WriteEndQnt6;
    property BegQnt7:double read ReadBegQnt7 write WriteBegQnt7;
    property IncQnt7:double read ReadIncQnt7 write WriteIncQnt7;
    property OutQnt7:double read ReadOutQnt7 write WriteOutQnt7;
    property InvQnt7:double read ReadInvQnt7 write WriteInvQnt7;
    property EndQnt7:double read ReadEndQnt7 write WriteEndQnt7;
    property BegQnt8:double read ReadBegQnt8 write WriteBegQnt8;
    property IncQnt8:double read ReadIncQnt8 write WriteIncQnt8;
    property OutQnt8:double read ReadOutQnt8 write WriteOutQnt8;
    property InvQnt8:double read ReadInvQnt8 write WriteInvQnt8;
    property EndQnt8:double read ReadEndQnt8 write WriteEndQnt8;
    property BegQnt9:double read ReadBegQnt9 write WriteBegQnt9;
    property IncQnt9:double read ReadIncQnt9 write WriteIncQnt9;
    property OutQnt9:double read ReadOutQnt9 write WriteOutQnt9;
    property InvQnt9:double read ReadInvQnt9 write WriteInvQnt9;
    property EndQnt9:double read ReadEndQnt9 write WriteEndQnt9;
    property BegQnt10:double read ReadBegQnt10 write WriteBegQnt10;
    property IncQnt10:double read ReadIncQnt10 write WriteIncQnt10;
    property OutQnt10:double read ReadOutQnt10 write WriteOutQnt10;
    property InvQnt10:double read ReadInvQnt10 write WriteInvQnt10;
    property EndQnt10:double read ReadEndQnt10 write WriteEndQnt10;
    property BegQnt11:double read ReadBegQnt11 write WriteBegQnt11;
    property IncQnt11:double read ReadIncQnt11 write WriteIncQnt11;
    property OutQnt11:double read ReadOutQnt11 write WriteOutQnt11;
    property InvQnt11:double read ReadInvQnt11 write WriteInvQnt11;
    property EndQnt11:double read ReadEndQnt11 write WriteEndQnt11;
    property BegQnt12:double read ReadBegQnt12 write WriteBegQnt12;
    property IncQnt12:double read ReadIncQnt12 write WriteIncQnt12;
    property OutQnt12:double read ReadOutQnt12 write WriteOutQnt12;
    property InvQnt12:double read ReadInvQnt12 write WriteInvQnt12;
    property EndQnt12:double read ReadEndQnt12 write WriteEndQnt12;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPosM:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSrsumTmp.Create;
begin
  oTmpTable := TmpInit ('SRSUM',Self);
end;

destructor TSrsumTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrsumTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrsumTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrsumTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrsumTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrsumTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrsumTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrsumTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSrsumTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSrsumTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSrsumTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSrsumTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSrsumTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrsumTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TSrsumTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrsumTmp.ReadPrcVol:double;
begin
  Result := oTmpTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrsumTmp.WritePrcVol(pValue:double);
begin
  oTmpTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt1:double;
begin
  Result := oTmpTable.FieldByName('BegQnt1').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt1(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt1').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt1:double;
begin
  Result := oTmpTable.FieldByName('IncQnt1').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt1(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt1').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt1:double;
begin
  Result := oTmpTable.FieldByName('OutQnt1').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt1(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt1').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt1:double;
begin
  Result := oTmpTable.FieldByName('InvQnt1').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt1(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt1').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt1:double;
begin
  Result := oTmpTable.FieldByName('EndQnt1').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt1(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt1').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt2:double;
begin
  Result := oTmpTable.FieldByName('BegQnt2').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt2(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt2').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt2:double;
begin
  Result := oTmpTable.FieldByName('IncQnt2').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt2(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt2').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt2:double;
begin
  Result := oTmpTable.FieldByName('OutQnt2').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt2(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt2').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt2:double;
begin
  Result := oTmpTable.FieldByName('InvQnt2').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt2(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt2').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt2:double;
begin
  Result := oTmpTable.FieldByName('EndQnt2').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt2(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt2').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt3:double;
begin
  Result := oTmpTable.FieldByName('BegQnt3').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt3(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt3').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt3:double;
begin
  Result := oTmpTable.FieldByName('IncQnt3').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt3(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt3').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt3:double;
begin
  Result := oTmpTable.FieldByName('OutQnt3').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt3(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt3').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt3:double;
begin
  Result := oTmpTable.FieldByName('InvQnt3').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt3(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt3').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt3:double;
begin
  Result := oTmpTable.FieldByName('EndQnt3').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt3(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt3').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt4:double;
begin
  Result := oTmpTable.FieldByName('BegQnt4').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt4(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt4').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt4:double;
begin
  Result := oTmpTable.FieldByName('IncQnt4').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt4(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt4').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt4:double;
begin
  Result := oTmpTable.FieldByName('OutQnt4').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt4(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt4').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt4:double;
begin
  Result := oTmpTable.FieldByName('InvQnt4').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt4(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt4').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt4:double;
begin
  Result := oTmpTable.FieldByName('EndQnt4').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt4(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt4').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt5:double;
begin
  Result := oTmpTable.FieldByName('BegQnt5').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt5(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt5').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt5:double;
begin
  Result := oTmpTable.FieldByName('IncQnt5').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt5(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt5').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt5:double;
begin
  Result := oTmpTable.FieldByName('OutQnt5').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt5(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt5').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt5:double;
begin
  Result := oTmpTable.FieldByName('InvQnt5').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt5(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt5').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt5:double;
begin
  Result := oTmpTable.FieldByName('EndQnt5').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt5(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt5').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt6:double;
begin
  Result := oTmpTable.FieldByName('BegQnt6').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt6(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt6').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt6:double;
begin
  Result := oTmpTable.FieldByName('IncQnt6').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt6(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt6').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt6:double;
begin
  Result := oTmpTable.FieldByName('OutQnt6').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt6(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt6').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt6:double;
begin
  Result := oTmpTable.FieldByName('InvQnt6').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt6(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt6').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt6:double;
begin
  Result := oTmpTable.FieldByName('EndQnt6').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt6(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt6').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt7:double;
begin
  Result := oTmpTable.FieldByName('BegQnt7').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt7(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt7').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt7:double;
begin
  Result := oTmpTable.FieldByName('IncQnt7').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt7(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt7').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt7:double;
begin
  Result := oTmpTable.FieldByName('OutQnt7').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt7(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt7').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt7:double;
begin
  Result := oTmpTable.FieldByName('InvQnt7').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt7(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt7').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt7:double;
begin
  Result := oTmpTable.FieldByName('EndQnt7').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt7(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt7').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt8:double;
begin
  Result := oTmpTable.FieldByName('BegQnt8').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt8(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt8').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt8:double;
begin
  Result := oTmpTable.FieldByName('IncQnt8').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt8(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt8').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt8:double;
begin
  Result := oTmpTable.FieldByName('OutQnt8').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt8(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt8').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt8:double;
begin
  Result := oTmpTable.FieldByName('InvQnt8').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt8(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt8').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt8:double;
begin
  Result := oTmpTable.FieldByName('EndQnt8').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt8(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt8').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt9:double;
begin
  Result := oTmpTable.FieldByName('BegQnt9').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt9(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt9').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt9:double;
begin
  Result := oTmpTable.FieldByName('IncQnt9').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt9(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt9').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt9:double;
begin
  Result := oTmpTable.FieldByName('OutQnt9').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt9(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt9').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt9:double;
begin
  Result := oTmpTable.FieldByName('InvQnt9').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt9(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt9').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt9:double;
begin
  Result := oTmpTable.FieldByName('EndQnt9').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt9(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt9').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt10:double;
begin
  Result := oTmpTable.FieldByName('BegQnt10').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt10(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt10').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt10:double;
begin
  Result := oTmpTable.FieldByName('IncQnt10').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt10(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt10').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt10:double;
begin
  Result := oTmpTable.FieldByName('OutQnt10').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt10(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt10').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt10:double;
begin
  Result := oTmpTable.FieldByName('InvQnt10').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt10(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt10').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt10:double;
begin
  Result := oTmpTable.FieldByName('EndQnt10').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt10(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt10').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt11:double;
begin
  Result := oTmpTable.FieldByName('BegQnt11').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt11(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt11').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt11:double;
begin
  Result := oTmpTable.FieldByName('IncQnt11').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt11(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt11').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt11:double;
begin
  Result := oTmpTable.FieldByName('OutQnt11').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt11(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt11').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt11:double;
begin
  Result := oTmpTable.FieldByName('InvQnt11').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt11(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt11').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt11:double;
begin
  Result := oTmpTable.FieldByName('EndQnt11').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt11(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt11').AsFloat := pValue;
end;

function TSrsumTmp.ReadBegQnt12:double;
begin
  Result := oTmpTable.FieldByName('BegQnt12').AsFloat;
end;

procedure TSrsumTmp.WriteBegQnt12(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt12').AsFloat := pValue;
end;

function TSrsumTmp.ReadIncQnt12:double;
begin
  Result := oTmpTable.FieldByName('IncQnt12').AsFloat;
end;

procedure TSrsumTmp.WriteIncQnt12(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt12').AsFloat := pValue;
end;

function TSrsumTmp.ReadOutQnt12:double;
begin
  Result := oTmpTable.FieldByName('OutQnt12').AsFloat;
end;

procedure TSrsumTmp.WriteOutQnt12(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt12').AsFloat := pValue;
end;

function TSrsumTmp.ReadInvQnt12:double;
begin
  Result := oTmpTable.FieldByName('InvQnt12').AsFloat;
end;

procedure TSrsumTmp.WriteInvQnt12(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt12').AsFloat := pValue;
end;

function TSrsumTmp.ReadEndQnt12:double;
begin
  Result := oTmpTable.FieldByName('EndQnt12').AsFloat;
end;

procedure TSrsumTmp.WriteEndQnt12(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt12').AsFloat := pValue;
end;

function TSrsumTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSrsumTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrsumTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrsumTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrsumTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrsumTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrsumTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSrsumTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSrsumTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSrsumTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrsumTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrsumTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrsumTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrsumTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSrsumTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSrsumTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrsumTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrsumTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrsumTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSrsumTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSrsumTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TSrsumTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TSrsumTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrsumTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrsumTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrsumTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrsumTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrsumTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrsumTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrsumTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrsumTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrsumTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrsumTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrsumTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrsumTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrsumTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrsumTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrsumTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrsumTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
