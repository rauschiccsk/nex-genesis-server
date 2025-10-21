unit tCASBTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixCasNum = 'CasNum';
  ixUsrName_ = 'UsrName_';

type
  TCasbtmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadUseName:Str30;         procedure WriteUseName (pValue:Str30);
    function  ReadUsrName_:Str30;        procedure WriteUsrName_ (pValue:Str30);
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadDifTime:TDatetime;     procedure WriteDifTime (pValue:TDatetime);
    function  ReadDocQnt:word;           procedure WriteDocQnt (pValue:word);
    function  ReadSumVal:double;         procedure WriteSumVal (pValue:double);
    function  ReadGscQnt:double;         procedure WriteGscQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateCasNum (pCasNum:word):boolean;
    function LocateUsrName_ (pUsrName_:Str30):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property UseName:Str30 read ReadUseName write WriteUseName;
    property UsrName_:Str30 read ReadUsrName_ write WriteUsrName_;
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property DifTime:TDatetime read ReadDifTime write WriteDifTime;
    property DocQnt:word read ReadDocQnt write WriteDocQnt;
    property SumVal:double read ReadSumVal write WriteSumVal;
    property GscQnt:double read ReadGscQnt write WriteGscQnt;
  end;

implementation

constructor TCasbtmTmp.Create;
begin
  oTmpTable := TmpInit ('CASBTM',Self);
end;

destructor TCasbtmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCasbtmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCasbtmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCasbtmTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TCasbtmTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TCasbtmTmp.ReadCasNum:word;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TCasbtmTmp.WriteCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TCasbtmTmp.ReadLogName:Str8;
begin
  Result := oTmpTable.FieldByName('LogName').AsString;
end;

procedure TCasbtmTmp.WriteLogName(pValue:Str8);
begin
  oTmpTable.FieldByName('LogName').AsString := pValue;
end;

function TCasbtmTmp.ReadUseName:Str30;
begin
  Result := oTmpTable.FieldByName('UseName').AsString;
end;

procedure TCasbtmTmp.WriteUseName(pValue:Str30);
begin
  oTmpTable.FieldByName('UseName').AsString := pValue;
end;

function TCasbtmTmp.ReadUsrName_:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName_').AsString;
end;

procedure TCasbtmTmp.WriteUsrName_(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName_').AsString := pValue;
end;

function TCasbtmTmp.ReadSalDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SalDate').AsDateTime;
end;

procedure TCasbtmTmp.WriteSalDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TCasbtmTmp.ReadBegTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegTime').AsDateTime;
end;

procedure TCasbtmTmp.WriteBegTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TCasbtmTmp.ReadEndTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndTime').AsDateTime;
end;

procedure TCasbtmTmp.WriteEndTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TCasbtmTmp.ReadDifTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('DifTime').AsDateTime;
end;

procedure TCasbtmTmp.WriteDifTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DifTime').AsDateTime := pValue;
end;

function TCasbtmTmp.ReadDocQnt:word;
begin
  Result := oTmpTable.FieldByName('DocQnt').AsInteger;
end;

procedure TCasbtmTmp.WriteDocQnt(pValue:word);
begin
  oTmpTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TCasbtmTmp.ReadSumVal:double;
begin
  Result := oTmpTable.FieldByName('SumVal').AsFloat;
end;

procedure TCasbtmTmp.WriteSumVal(pValue:double);
begin
  oTmpTable.FieldByName('SumVal').AsFloat := pValue;
end;

function TCasbtmTmp.ReadGscQnt:double;
begin
  Result := oTmpTable.FieldByName('GscQnt').AsFloat;
end;

procedure TCasbtmTmp.WriteGscQnt(pValue:double);
begin
  oTmpTable.FieldByName('GscQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCasbtmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCasbtmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCasbtmTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TCasbtmTmp.LocateCasNum (pCasNum:word):boolean;
begin
  SetIndex (ixCasNum);
  Result := oTmpTable.FindKey([pCasNum]);
end;

function TCasbtmTmp.LocateUsrName_ (pUsrName_:Str30):boolean;
begin
  SetIndex (ixUsrName_);
  Result := oTmpTable.FindKey([pUsrName_]);
end;

procedure TCasbtmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCasbtmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCasbtmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCasbtmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCasbtmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCasbtmTmp.First;
begin
  oTmpTable.First;
end;

procedure TCasbtmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCasbtmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCasbtmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCasbtmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCasbtmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCasbtmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCasbtmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCasbtmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCasbtmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCasbtmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCasbtmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
