unit bSOBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = 'BookNum';
  ixContoNum = 'ContoNum';

type
  TSoblstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadBankCode:Str4;         procedure WriteBankCode (pValue:Str4);
    function  ReadBankName:Str30;        procedure WriteBankName (pValue:Str30);
    function  ReadIbanCode:Str34;        procedure WriteIbanCode (pValue:Str34);
    function  ReadSwftCode:Str20;        procedure WriteSwftCode (pValue:Str20);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyBegVal:double;       procedure WritePyBegVal (pValue:double);
    function  ReadPyCredVal:double;      procedure WritePyCredVal (pValue:double);
    function  ReadPyDebVal:double;       procedure WritePyDebVal (pValue:double);
    function  ReadPyEndVal:double;       procedure WritePyEndVal (pValue:double);
    function  ReadDocQnt:longint;        procedure WriteDocQnt (pValue:longint);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadAutoAcc:byte;          procedure WriteAutoAcc (pValue:byte);
    function  ReadAboType:byte;          procedure WriteAboType (pValue:byte);
    function  ReadAboPath:Str80;         procedure WriteAboPath (pValue:Str80);
    function  ReadPyMaxPdf:double;       procedure WritePyMaxPdf (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
    function  ReadAcBegVal:double;       procedure WriteAcBegVal (pValue:double);
    function  ReadAcCredVal:double;      procedure WriteAcCredVal (pValue:double);
    function  ReadAcDebVal:double;       procedure WriteAcDebVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBookNum (pBookNum:Str5):boolean;
    function LocateContoNum (pContoNum:Str30):boolean;
    function NearestBookNum (pBookNum:Str5):boolean;
    function NearestContoNum (pContoNum:Str30):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property BankCode:Str4 read ReadBankCode write WriteBankCode;
    property BankName:Str30 read ReadBankName write WriteBankName;
    property IbanCode:Str34 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str20 read ReadSwftCode write WriteSwftCode;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyBegVal:double read ReadPyBegVal write WritePyBegVal;
    property PyCredVal:double read ReadPyCredVal write WritePyCredVal;
    property PyDebVal:double read ReadPyDebVal write WritePyDebVal;
    property PyEndVal:double read ReadPyEndVal write WritePyEndVal;
    property DocQnt:longint read ReadDocQnt write WriteDocQnt;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property AutoAcc:byte read ReadAutoAcc write WriteAutoAcc;
    property AboType:byte read ReadAboType write WriteAboType;
    property AboPath:Str80 read ReadAboPath write WriteAboPath;
    property PyMaxPdf:double read ReadPyMaxPdf write WritePyMaxPdf;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property AcBegVal:double read ReadAcBegVal write WriteAcBegVal;
    property AcCredVal:double read ReadAcCredVal write WriteAcCredVal;
    property AcDebVal:double read ReadAcDebVal write WriteAcDebVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
  end;

implementation

constructor TSoblstBtr.Create;
begin
  oBtrTable := BtrInit ('SOBLST',gPath.LdgPath,Self);
end;

constructor TSoblstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SOBLST',pPath,Self);
end;

destructor TSoblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSoblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSoblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSoblstBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TSoblstBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TSoblstBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TSoblstBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TSoblstBtr.ReadContoNum:Str30;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TSoblstBtr.WriteContoNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TSoblstBtr.ReadBankCode:Str4;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TSoblstBtr.WriteBankCode(pValue:Str4);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TSoblstBtr.ReadBankName:Str30;
begin
  Result := oBtrTable.FieldByName('BankName').AsString;
end;

procedure TSoblstBtr.WriteBankName(pValue:Str30);
begin
  oBtrTable.FieldByName('BankName').AsString := pValue;
end;

function TSoblstBtr.ReadIbanCode:Str34;
begin
  Result := oBtrTable.FieldByName('IbanCode').AsString;
end;

procedure TSoblstBtr.WriteIbanCode(pValue:Str34);
begin
  oBtrTable.FieldByName('IbanCode').AsString := pValue;
end;

function TSoblstBtr.ReadSwftCode:Str20;
begin
  Result := oBtrTable.FieldByName('SwftCode').AsString;
end;

procedure TSoblstBtr.WriteSwftCode(pValue:Str20);
begin
  oBtrTable.FieldByName('SwftCode').AsString := pValue;
end;

function TSoblstBtr.ReadPyDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('PyDvzName').AsString;
end;

procedure TSoblstBtr.WritePyDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TSoblstBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TSoblstBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TSoblstBtr.ReadPyBegVal:double;
begin
  Result := oBtrTable.FieldByName('PyBegVal').AsFloat;
end;

procedure TSoblstBtr.WritePyBegVal(pValue:double);
begin
  oBtrTable.FieldByName('PyBegVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadPyCredVal:double;
begin
  Result := oBtrTable.FieldByName('PyCredVal').AsFloat;
end;

procedure TSoblstBtr.WritePyCredVal(pValue:double);
begin
  oBtrTable.FieldByName('PyCredVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadPyDebVal:double;
begin
  Result := oBtrTable.FieldByName('PyDebVal').AsFloat;
end;

procedure TSoblstBtr.WritePyDebVal(pValue:double);
begin
  oBtrTable.FieldByName('PyDebVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadPyEndVal:double;
begin
  Result := oBtrTable.FieldByName('PyEndVal').AsFloat;
end;

procedure TSoblstBtr.WritePyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('PyEndVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadDocQnt:longint;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsInteger;
end;

procedure TSoblstBtr.WriteDocQnt(pValue:longint);
begin
  oBtrTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TSoblstBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TSoblstBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TSoblstBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TSoblstBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TSoblstBtr.ReadAutoAcc:byte;
begin
  Result := oBtrTable.FieldByName('AutoAcc').AsInteger;
end;

procedure TSoblstBtr.WriteAutoAcc(pValue:byte);
begin
  oBtrTable.FieldByName('AutoAcc').AsInteger := pValue;
end;

function TSoblstBtr.ReadAboType:byte;
begin
  Result := oBtrTable.FieldByName('AboType').AsInteger;
end;

procedure TSoblstBtr.WriteAboType(pValue:byte);
begin
  oBtrTable.FieldByName('AboType').AsInteger := pValue;
end;

function TSoblstBtr.ReadAboPath:Str80;
begin
  Result := oBtrTable.FieldByName('AboPath').AsString;
end;

procedure TSoblstBtr.WriteAboPath(pValue:Str80);
begin
  oBtrTable.FieldByName('AboPath').AsString := pValue;
end;

function TSoblstBtr.ReadPyMaxPdf:double;
begin
  Result := oBtrTable.FieldByName('PyMaxPdf').AsFloat;
end;

procedure TSoblstBtr.WritePyMaxPdf(pValue:double);
begin
  oBtrTable.FieldByName('PyMaxPdf').AsFloat := pValue;
end;

function TSoblstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSoblstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSoblstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSoblstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSoblstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSoblstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSoblstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSoblstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSoblstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSoblstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSoblstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSoblstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSoblstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSoblstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSoblstBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TSoblstBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TSoblstBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TSoblstBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadAcBegVal:double;
begin
  Result := oBtrTable.FieldByName('AcBegVal').AsFloat;
end;

procedure TSoblstBtr.WriteAcBegVal(pValue:double);
begin
  oBtrTable.FieldByName('AcBegVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadAcCredVal:double;
begin
  Result := oBtrTable.FieldByName('AcCredVal').AsFloat;
end;

procedure TSoblstBtr.WriteAcCredVal(pValue:double);
begin
  oBtrTable.FieldByName('AcCredVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadAcDebVal:double;
begin
  Result := oBtrTable.FieldByName('AcDebVal').AsFloat;
end;

procedure TSoblstBtr.WriteAcDebVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDebVal').AsFloat := pValue;
end;

function TSoblstBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TSoblstBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSoblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSoblstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSoblstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSoblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSoblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSoblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSoblstBtr.LocateBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindKey([pBookNum]);
end;

function TSoblstBtr.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindKey([pContoNum]);
end;

function TSoblstBtr.NearestBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindNearest([pBookNum]);
end;

function TSoblstBtr.NearestContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindNearest([pContoNum]);
end;

procedure TSoblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSoblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSoblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSoblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSoblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSoblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSoblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSoblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSoblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSoblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSoblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSoblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSoblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSoblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSoblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSoblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSoblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
