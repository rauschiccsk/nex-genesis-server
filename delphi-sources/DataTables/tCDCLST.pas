unit tCDCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';
  ixWrCaIn = 'WrCaIn';
  ixBdBt = 'BdBt';
  ixDocVal = 'DocVal';
  ixLgnName = 'LgnName';
  ixUsrName = 'UsrName';

type
  TCdclstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadBlkDate:TDatetime;     procedure WriteBlkDate (pValue:TDatetime);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadIntBlkNum:longint;     procedure WriteIntBlkNum (pValue:longint);
    function  ReadBlkTime:Str8;          procedure WriteBlkTime (pValue:Str8);
    function  ReadBlkType:Str1;          procedure WriteBlkType (pValue:Str1);
    function  ReadBlkTypeN:Str20;        procedure WriteBlkTypeN (pValue:Str20);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadItmCnt:longint;        procedure WriteItmCnt (pValue:longint);
    function  ReadLgnName:Str8;          procedure WriteLgnName (pValue:Str8);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
    function  ReadCusCard:Str30;         procedure WriteCusCard (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function Locate (pWriNum:longint;pCasNum:word;pBlkDate:TDatetime;pBlkNum:longint):boolean;
    function LocateWrCaIn (pWriNum:longint;pCasNum:word;pIntBlkNum:longint):boolean;
    function LocateBdBt (pBlkDate:TDatetime;pBlkTime:Str8):boolean;
    function LocateDocVal (pDocVal:double):boolean;
    function LocateLgnName (pLgnName:Str8):boolean;
    function LocateUsrName (pUsrName:Str30):boolean;

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
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property BlkDate:TDatetime read ReadBlkDate write WriteBlkDate;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property IntBlkNum:longint read ReadIntBlkNum write WriteIntBlkNum;
    property BlkTime:Str8 read ReadBlkTime write WriteBlkTime;
    property BlkType:Str1 read ReadBlkType write WriteBlkType;
    property BlkTypeN:Str20 read ReadBlkTypeN write WriteBlkTypeN;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property ItmCnt:longint read ReadItmCnt write WriteItmCnt;
    property LgnName:Str8 read ReadLgnName write WriteLgnName;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property CusCard:Str30 read ReadCusCard write WriteCusCard;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
  end;

implementation

constructor TCdclstTmp.Create;
begin
  oTmpTable := TmpInit ('CDCLST',Self);
end;

destructor TCdclstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCdclstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCdclstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCdclstTmp.ReadWriNum:longint;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TCdclstTmp.WriteWriNum(pValue:longint);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCdclstTmp.ReadCasNum:word;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TCdclstTmp.WriteCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TCdclstTmp.ReadBlkDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BlkDate').AsDateTime;
end;

procedure TCdclstTmp.WriteBlkDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BlkDate').AsDateTime := pValue;
end;

function TCdclstTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TCdclstTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TCdclstTmp.ReadIntBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('IntBlkNum').AsInteger;
end;

procedure TCdclstTmp.WriteIntBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('IntBlkNum').AsInteger := pValue;
end;

function TCdclstTmp.ReadBlkTime:Str8;
begin
  Result := oTmpTable.FieldByName('BlkTime').AsString;
end;

procedure TCdclstTmp.WriteBlkTime(pValue:Str8);
begin
  oTmpTable.FieldByName('BlkTime').AsString := pValue;
end;

function TCdclstTmp.ReadBlkType:Str1;
begin
  Result := oTmpTable.FieldByName('BlkType').AsString;
end;

procedure TCdclstTmp.WriteBlkType(pValue:Str1);
begin
  oTmpTable.FieldByName('BlkType').AsString := pValue;
end;

function TCdclstTmp.ReadBlkTypeN:Str20;
begin
  Result := oTmpTable.FieldByName('BlkTypeN').AsString;
end;

procedure TCdclstTmp.WriteBlkTypeN(pValue:Str20);
begin
  oTmpTable.FieldByName('BlkTypeN').AsString := pValue;
end;

function TCdclstTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TCdclstTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TCdclstTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TCdclstTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TCdclstTmp.ReadItmCnt:longint;
begin
  Result := oTmpTable.FieldByName('ItmCnt').AsInteger;
end;

procedure TCdclstTmp.WriteItmCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ItmCnt').AsInteger := pValue;
end;

function TCdclstTmp.ReadLgnName:Str8;
begin
  Result := oTmpTable.FieldByName('LgnName').AsString;
end;

procedure TCdclstTmp.WriteLgnName(pValue:Str8);
begin
  oTmpTable.FieldByName('LgnName').AsString := pValue;
end;

function TCdclstTmp.ReadUsrName:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName').AsString;
end;

procedure TCdclstTmp.WriteUsrName(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName').AsString := pValue;
end;

function TCdclstTmp.ReadCusCard:Str30;
begin
  Result := oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TCdclstTmp.WriteCusCard(pValue:Str30);
begin
  oTmpTable.FieldByName('CusCard').AsString := pValue;
end;

function TCdclstTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCdclstTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCdclstTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TCdclstTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCdclstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCdclstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCdclstTmp.Locate (pWriNum:longint;pCasNum:word;pBlkDate:TDatetime;pBlkNum:longint):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([pWriNum,pCasNum,pBlkDate,pBlkNum]);
end;

function TCdclstTmp.LocateWrCaIn (pWriNum:longint;pCasNum:word;pIntBlkNum:longint):boolean;
begin
  SetIndex (ixWrCaIn);
  Result := oTmpTable.FindKey([pWriNum,pCasNum,pIntBlkNum]);
end;

function TCdclstTmp.LocateBdBt (pBlkDate:TDatetime;pBlkTime:Str8):boolean;
begin
  SetIndex (ixBdBt);
  Result := oTmpTable.FindKey([pBlkDate,pBlkTime]);
end;

function TCdclstTmp.LocateDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oTmpTable.FindKey([pDocVal]);
end;

function TCdclstTmp.LocateLgnName (pLgnName:Str8):boolean;
begin
  SetIndex (ixLgnName);
  Result := oTmpTable.FindKey([pLgnName]);
end;

function TCdclstTmp.LocateUsrName (pUsrName:Str30):boolean;
begin
  SetIndex (ixUsrName);
  Result := oTmpTable.FindKey([pUsrName]);
end;

procedure TCdclstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCdclstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCdclstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCdclstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCdclstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCdclstTmp.First;
begin
  oTmpTable.First;
end;

procedure TCdclstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCdclstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCdclstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCdclstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCdclstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCdclstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCdclstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCdclstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCdclstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCdclstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCdclstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
