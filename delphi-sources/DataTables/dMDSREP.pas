unit dMDSREP;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixPrfPrc = 'PrfPrc';

type
  TMdsrep = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadPlsPce:double;         procedure WritePlsPce (pValue:double);
    function  ReadActApl:word;           procedure WriteActApl (pValue:word);
    function  ReadActPce:double;         procedure WriteActPce (pValue:double);
    function  ReadCtrPac:longint;        procedure WriteCtrPac (pValue:longint);
    function  ReadCtrPce:double;         procedure WriteCtrPce (pValue:double);
    function  ReadBccPac:longint;        procedure WriteBccPac (pValue:longint);
    function  ReadBccPce:double;         procedure WriteBccPce (pValue:double);
    function  ReadPdsPac:longint;        procedure WritePdsPac (pValue:longint);
    function  ReadPdsPce:double;         procedure WritePdsPce (pValue:double);
    function  ReadBuyPac:longint;        procedure WriteBuyPac (pValue:longint);
    function  ReadBuyPce:double;         procedure WriteBuyPce (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadSalPce:double;         procedure WriteSalPce (pValue:double);
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
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocatePrfPrc (pPrfPrc:double):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property PlsPce:double read ReadPlsPce write WritePlsPce;
    property ActApl:word read ReadActApl write WriteActApl;
    property ActPce:double read ReadActPce write WriteActPce;
    property CtrPac:longint read ReadCtrPac write WriteCtrPac;
    property CtrPce:double read ReadCtrPce write WriteCtrPce;
    property BccPac:longint read ReadBccPac write WriteBccPac;
    property BccPce:double read ReadBccPce write WriteBccPce;
    property PdsPac:longint read ReadPdsPac write WritePdsPac;
    property PdsPce:double read ReadPdsPce write WritePdsPce;
    property BuyPac:longint read ReadBuyPac write WriteBuyPac;
    property BuyPce:double read ReadBuyPce write WriteBuyPce;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property SalPce:double read ReadSalPce write WriteSalPce;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TMdsrep.Create;
begin
  oBtrTable := BtrInit ('MDSREP',gPath.StkPath,Self);
end;

destructor  TMdsrep.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMdsrep.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMdsrep.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TMdsrep.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TMdsrep.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TMdsrep.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TMdsrep.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TMdsrep.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TMdsrep.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TMdsrep.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TMdsrep.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TMdsrep.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TMdsrep.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TMdsrep.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TMdsrep.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TMdsrep.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TMdsrep.ReadPlsPce:double;
begin
  Result := oBtrTable.FieldByName('PlsPce').AsFloat;
end;

procedure TMdsrep.WritePlsPce(pValue:double);
begin
  oBtrTable.FieldByName('PlsPce').AsFloat := pValue;
end;

function TMdsrep.ReadActApl:word;
begin
  Result := oBtrTable.FieldByName('ActApl').AsInteger;
end;

procedure TMdsrep.WriteActApl(pValue:word);
begin
  oBtrTable.FieldByName('ActApl').AsInteger := pValue;
end;

function TMdsrep.ReadActPce:double;
begin
  Result := oBtrTable.FieldByName('ActPce').AsFloat;
end;

procedure TMdsrep.WriteActPce(pValue:double);
begin
  oBtrTable.FieldByName('ActPce').AsFloat := pValue;
end;

function TMdsrep.ReadCtrPac:longint;
begin
  Result := oBtrTable.FieldByName('CtrPac').AsInteger;
end;

procedure TMdsrep.WriteCtrPac(pValue:longint);
begin
  oBtrTable.FieldByName('CtrPac').AsInteger := pValue;
end;

function TMdsrep.ReadCtrPce:double;
begin
  Result := oBtrTable.FieldByName('CtrPce').AsFloat;
end;

procedure TMdsrep.WriteCtrPce(pValue:double);
begin
  oBtrTable.FieldByName('CtrPce').AsFloat := pValue;
end;

function TMdsrep.ReadBccPac:longint;
begin
  Result := oBtrTable.FieldByName('BccPac').AsInteger;
end;

procedure TMdsrep.WriteBccPac(pValue:longint);
begin
  oBtrTable.FieldByName('BccPac').AsInteger := pValue;
end;

function TMdsrep.ReadBccPce:double;
begin
  Result := oBtrTable.FieldByName('BccPce').AsFloat;
end;

procedure TMdsrep.WriteBccPce(pValue:double);
begin
  oBtrTable.FieldByName('BccPce').AsFloat := pValue;
end;

function TMdsrep.ReadPdsPac:longint;
begin
  Result := oBtrTable.FieldByName('PdsPac').AsInteger;
end;

procedure TMdsrep.WritePdsPac(pValue:longint);
begin
  oBtrTable.FieldByName('PdsPac').AsInteger := pValue;
end;

function TMdsrep.ReadPdsPce:double;
begin
  Result := oBtrTable.FieldByName('PdsPce').AsFloat;
end;

procedure TMdsrep.WritePdsPce(pValue:double);
begin
  oBtrTable.FieldByName('PdsPce').AsFloat := pValue;
end;

function TMdsrep.ReadBuyPac:longint;
begin
  Result := oBtrTable.FieldByName('BuyPac').AsInteger;
end;

procedure TMdsrep.WriteBuyPac(pValue:longint);
begin
  oBtrTable.FieldByName('BuyPac').AsInteger := pValue;
end;

function TMdsrep.ReadBuyPce:double;
begin
  Result := oBtrTable.FieldByName('BuyPce').AsFloat;
end;

procedure TMdsrep.WriteBuyPce(pValue:double);
begin
  oBtrTable.FieldByName('BuyPce').AsFloat := pValue;
end;

function TMdsrep.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TMdsrep.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TMdsrep.ReadSalPce:double;
begin
  Result := oBtrTable.FieldByName('SalPce').AsFloat;
end;

procedure TMdsrep.WriteSalPce(pValue:double);
begin
  oBtrTable.FieldByName('SalPce').AsFloat := pValue;
end;

function TMdsrep.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TMdsrep.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMdsrep.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMdsrep.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMdsrep.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMdsrep.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMdsrep.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMdsrep.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMdsrep.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMdsrep.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMdsrep.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMdsrep.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMdsrep.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMdsrep.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMdsrep.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMdsrep.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMdsrep.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TMdsrep.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([pGsName_]);
end;

function TMdsrep.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TMdsrep.LocatePrfPrc (pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result := oBtrTable.FindKey([pPrfPrc]);
end;

procedure TMdsrep.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMdsrep.Open;
begin
  oBtrTable.Open;
end;

procedure TMdsrep.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMdsrep.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMdsrep.Next;
begin
  oBtrTable.Next;
end;

procedure TMdsrep.First;
begin
  oBtrTable.First;
end;

procedure TMdsrep.Last;
begin
  oBtrTable.Last;
end;

procedure TMdsrep.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMdsrep.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMdsrep.Post;
var mSalPce:double;
begin
  mSalPce := PlsPce;
  If IsNotNul(ActPce) and (ActPce<mSalPce) then mSalPce := ActPce;
  If IsNotNul(CtrPce) and (CtrPce<mSalPce) then mSalPce := CtrPce;
  If IsNotNul(BccPce) and (BccPce<mSalPce) then mSalPce := BccPce;
  If IsNotNul(PdsPce) and (PdsPce<mSalPce) then mSalPce := PdsPce;
  If IsNotNul(BuyPce) then PrfPrc := ((SalPce/BuyPce)-1)*100;
  SalPce := mSalPce;
  oBtrTable.Post;
end;

procedure TMdsrep.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMdsrep.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMdsrep.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMdsrep.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMdsrep.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
