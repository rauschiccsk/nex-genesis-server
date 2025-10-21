unit tPASUBC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaWp = '';
  ixWpaCode = 'WpaCode';
  ixWpaName_ = 'WpaName_';
  ixWpaCtn_ = 'WpaCtn_';

type
  TPasubcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str60;         procedure WriteWpaName (pValue:Str60);
    function  ReadWpaName_:Str60;        procedure WriteWpaName_ (pValue:Str60);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaCtn_:Str30;         procedure WriteWpaCtn_ (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadWpaTel:Str20;          procedure WriteWpaTel (pValue:Str20);
    function  ReadWpaFax:Str20;          procedure WriteWpaFax (pValue:Str20);
    function  ReadWpaEml:Str30;          procedure WriteWpaEml (pValue:Str30);
    function  ReadTrsCode:Str3;          procedure WriteTrsCode (pValue:Str3);
    function  ReadTrsName:Str20;         procedure WriteTrsName (pValue:Str20);
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
    function LocatePaWp (pPaCode:longint;pWpaCode:word):boolean;
    function LocateWpaCode (pWpaCode:word):boolean;
    function LocateWpaName_ (pWpaName_:Str60):boolean;
    function LocateWpaCtn_ (pWpaCtn_:Str30):boolean;

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
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str60 read ReadWpaName write WriteWpaName;
    property WpaName_:Str60 read ReadWpaName_ write WriteWpaName_;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaCtn_:Str30 read ReadWpaCtn_ write WriteWpaCtn_;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property WpaTel:Str20 read ReadWpaTel write WriteWpaTel;
    property WpaFax:Str20 read ReadWpaFax write WriteWpaFax;
    property WpaEml:Str30 read ReadWpaEml write WriteWpaEml;
    property TrsCode:Str3 read ReadTrsCode write WriteTrsCode;
    property TrsName:Str20 read ReadTrsName write WriteTrsName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPasubcTmp.Create;
begin
  oTmpTable := TmpInit ('PASUBC',Self);
end;

destructor TPasubcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPasubcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPasubcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPasubcTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TPasubcTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPasubcTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TPasubcTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TPasubcTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TPasubcTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TPasubcTmp.ReadWpaName_:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName_').AsString;
end;

procedure TPasubcTmp.WriteWpaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName_').AsString := pValue;
end;

function TPasubcTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TPasubcTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TPasubcTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TPasubcTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TPasubcTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TPasubcTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TPasubcTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TPasubcTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TPasubcTmp.ReadWpaCtn_:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn_').AsString;
end;

procedure TPasubcTmp.WriteWpaCtn_(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn_').AsString := pValue;
end;

function TPasubcTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TPasubcTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TPasubcTmp.ReadWpaTel:Str20;
begin
  Result := oTmpTable.FieldByName('WpaTel').AsString;
end;

procedure TPasubcTmp.WriteWpaTel(pValue:Str20);
begin
  oTmpTable.FieldByName('WpaTel').AsString := pValue;
end;

function TPasubcTmp.ReadWpaFax:Str20;
begin
  Result := oTmpTable.FieldByName('WpaFax').AsString;
end;

procedure TPasubcTmp.WriteWpaFax(pValue:Str20);
begin
  oTmpTable.FieldByName('WpaFax').AsString := pValue;
end;

function TPasubcTmp.ReadWpaEml:Str30;
begin
  Result := oTmpTable.FieldByName('WpaEml').AsString;
end;

procedure TPasubcTmp.WriteWpaEml(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaEml').AsString := pValue;
end;

function TPasubcTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TPasubcTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TPasubcTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TPasubcTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TPasubcTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPasubcTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPasubcTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPasubcTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPasubcTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPasubcTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPasubcTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TPasubcTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPasubcTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPasubcTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPasubcTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPasubcTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPasubcTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPasubcTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPasubcTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPasubcTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPasubcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPasubcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPasubcTmp.LocatePaWp (pPaCode:longint;pWpaCode:word):boolean;
begin
  SetIndex (ixPaWp);
  Result := oTmpTable.FindKey([pPaCode,pWpaCode]);
end;

function TPasubcTmp.LocateWpaCode (pWpaCode:word):boolean;
begin
  SetIndex (ixWpaCode);
  Result := oTmpTable.FindKey([pWpaCode]);
end;

function TPasubcTmp.LocateWpaName_ (pWpaName_:Str60):boolean;
begin
  SetIndex (ixWpaName_);
  Result := oTmpTable.FindKey([pWpaName_]);
end;

function TPasubcTmp.LocateWpaCtn_ (pWpaCtn_:Str30):boolean;
begin
  SetIndex (ixWpaCtn_);
  Result := oTmpTable.FindKey([pWpaCtn_]);
end;

procedure TPasubcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPasubcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPasubcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPasubcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPasubcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPasubcTmp.First;
begin
  oTmpTable.First;
end;

procedure TPasubcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPasubcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPasubcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPasubcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPasubcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPasubcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPasubcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPasubcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPasubcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPasubcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPasubcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1908001}
