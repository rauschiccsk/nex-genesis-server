unit tCADITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRecNum = '';
  ixBdBtCnBn = 'BdBtCnBn';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixGsQnt = 'GsQnt';
  ixBPrice = 'BPrice';
  ixBValue = 'BValue';
  ixLgnName = 'LgnName';
  ixUsrName = 'UsrName';

type
  TCaditmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRecNum:longint;        procedure WriteRecNum (pValue:longint);
    function  ReadBlkDate:TDatetime;     procedure WriteBlkDate (pValue:TDatetime);
    function  ReadBlkTime:Str8;          procedure WriteBlkTime (pValue:Str8);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadLgnName:Str8;          procedure WriteLgnName (pValue:Str8);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRecNum (pRecNum:longint):boolean;
    function LocateBdBtCnBn (pBlkDate:TDatetime;pBlkTime:Str8;pCasNum:word;pBlkNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateGsQnt (pGsQnt:double):boolean;
    function LocateBPrice (pBPrice:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateLgnName (pLgnName:Str8):boolean;
    function LocateUsrName (pUsrName:Str30):boolean;

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
    property RecNum:longint read ReadRecNum write WriteRecNum;
    property BlkDate:TDatetime read ReadBlkDate write WriteBlkDate;
    property BlkTime:Str8 read ReadBlkTime write WriteBlkTime;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property LgnName:Str8 read ReadLgnName write WriteLgnName;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
  end;

implementation

constructor TCaditmTmp.Create;
begin
  oTmpTable := TmpInit ('CADITM',Self);
end;

destructor TCaditmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCaditmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCaditmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCaditmTmp.ReadRecNum:longint;
begin
  Result := oTmpTable.FieldByName('RecNum').AsInteger;
end;

procedure TCaditmTmp.WriteRecNum(pValue:longint);
begin
  oTmpTable.FieldByName('RecNum').AsInteger := pValue;
end;

function TCaditmTmp.ReadBlkDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BlkDate').AsDateTime;
end;

procedure TCaditmTmp.WriteBlkDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BlkDate').AsDateTime := pValue;
end;

function TCaditmTmp.ReadBlkTime:Str8;
begin
  Result := oTmpTable.FieldByName('BlkTime').AsString;
end;

procedure TCaditmTmp.WriteBlkTime(pValue:Str8);
begin
  oTmpTable.FieldByName('BlkTime').AsString := pValue;
end;

function TCaditmTmp.ReadCasNum:word;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TCaditmTmp.WriteCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TCaditmTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TCaditmTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TCaditmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TCaditmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCaditmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TCaditmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TCaditmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TCaditmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TCaditmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TCaditmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TCaditmTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCaditmTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCaditmTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCaditmTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCaditmTmp.ReadLgnName:Str8;
begin
  Result := oTmpTable.FieldByName('LgnName').AsString;
end;

procedure TCaditmTmp.WriteLgnName(pValue:Str8);
begin
  oTmpTable.FieldByName('LgnName').AsString := pValue;
end;

function TCaditmTmp.ReadUsrName:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName').AsString;
end;

procedure TCaditmTmp.WriteUsrName(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCaditmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCaditmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCaditmTmp.LocateRecNum (pRecNum:longint):boolean;
begin
  SetIndex (ixRecNum);
  Result := oTmpTable.FindKey([pRecNum]);
end;

function TCaditmTmp.LocateBdBtCnBn (pBlkDate:TDatetime;pBlkTime:Str8;pCasNum:word;pBlkNum:longint):boolean;
begin
  SetIndex (ixBdBtCnBn);
  Result := oTmpTable.FindKey([pBlkDate,pBlkTime,pCasNum,pBlkNum]);
end;

function TCaditmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TCaditmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TCaditmTmp.LocateGsQnt (pGsQnt:double):boolean;
begin
  SetIndex (ixGsQnt);
  Result := oTmpTable.FindKey([pGsQnt]);
end;

function TCaditmTmp.LocateBPrice (pBPrice:double):boolean;
begin
  SetIndex (ixBPrice);
  Result := oTmpTable.FindKey([pBPrice]);
end;

function TCaditmTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TCaditmTmp.LocateLgnName (pLgnName:Str8):boolean;
begin
  SetIndex (ixLgnName);
  Result := oTmpTable.FindKey([pLgnName]);
end;

function TCaditmTmp.LocateUsrName (pUsrName:Str30):boolean;
begin
  SetIndex (ixUsrName);
  Result := oTmpTable.FindKey([pUsrName]);
end;

procedure TCaditmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCaditmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCaditmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCaditmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCaditmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCaditmTmp.First;
begin
  oTmpTable.First;
end;

procedure TCaditmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCaditmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCaditmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCaditmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCaditmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCaditmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCaditmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCaditmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCaditmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCaditmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCaditmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
