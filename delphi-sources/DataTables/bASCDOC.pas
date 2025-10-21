unit bAscdoc;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixEndDate = 'EndDate';

type
  TAscdocBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadIsvBef:double;         procedure WriteIsvBef (pValue:double);
    function  ReadIsvAct:double;         procedure WriteIsvAct (pValue:double);
    function  ReadIsvAft:double;         procedure WriteIsvAft (pValue:double);
    function  ReadIsvSum:double;         procedure WriteIsvSum (pValue:double);
    function  ReadIcvBef:double;         procedure WriteIcvBef (pValue:double);
    function  ReadIcvAct:double;         procedure WriteIcvAct (pValue:double);
    function  ReadIcvAft:double;         procedure WriteIcvAft (pValue:double);
    function  ReadIcvSum:double;         procedure WriteIcvSum (pValue:double);
    function  ReadDifSum:double;         procedure WriteDifSum (pValue:double);
    function  ReadExdTxt1:Str30;         procedure WriteExdTxt1 (pValue:Str30);
    function  ReadExdTxt2:Str30;         procedure WriteExdTxt2 (pValue:Str30);
    function  ReadExdTxt3:Str30;         procedure WriteExdTxt3 (pValue:Str30);
    function  ReadExdTxt4:Str30;         procedure WriteExdTxt4 (pValue:Str30);
    function  ReadExdTxt5:Str30;         procedure WriteExdTxt5 (pValue:Str30);
    function  ReadExdTxt6:Str30;         procedure WriteExdTxt6 (pValue:Str30);
    function  ReadExdTxt7:Str30;         procedure WriteExdTxt7 (pValue:Str30);
    function  ReadExdTxt8:Str30;         procedure WriteExdTxt8 (pValue:Str30);
    function  ReadExdTxt9:Str30;         procedure WriteExdTxt9 (pValue:Str30);
    function  ReadExdBeg1:longint;       procedure WriteExdBeg1 (pValue:longint);
    function  ReadExdBeg2:longint;       procedure WriteExdBeg2 (pValue:longint);
    function  ReadExdBeg3:longint;       procedure WriteExdBeg3 (pValue:longint);
    function  ReadExdBeg4:longint;       procedure WriteExdBeg4 (pValue:longint);
    function  ReadExdBeg5:longint;       procedure WriteExdBeg5 (pValue:longint);
    function  ReadExdBeg6:longint;       procedure WriteExdBeg6 (pValue:longint);
    function  ReadExdBeg7:longint;       procedure WriteExdBeg7 (pValue:longint);
    function  ReadExdBeg8:longint;       procedure WriteExdBeg8 (pValue:longint);
    function  ReadExdBeg9:longint;       procedure WriteExdBeg9 (pValue:longint);
    function  ReadExdEnd1:longint;       procedure WriteExdEnd1 (pValue:longint);
    function  ReadExdEnd2:longint;       procedure WriteExdEnd2 (pValue:longint);
    function  ReadExdEnd3:longint;       procedure WriteExdEnd3 (pValue:longint);
    function  ReadExdEnd4:longint;       procedure WriteExdEnd4 (pValue:longint);
    function  ReadExdEnd5:longint;       procedure WriteExdEnd5 (pValue:longint);
    function  ReadExdEnd6:longint;       procedure WriteExdEnd6 (pValue:longint);
    function  ReadExdEnd7:longint;       procedure WriteExdEnd7 (pValue:longint);
    function  ReadExdEnd8:longint;       procedure WriteExdEnd8 (pValue:longint);
    function  ReadExdEnd9:longint;       procedure WriteExdEnd9 (pValue:longint);
    function  ReadIsvExd1:double;        procedure WriteIsvExd1 (pValue:double);
    function  ReadIsvExd2:double;        procedure WriteIsvExd2 (pValue:double);
    function  ReadIsvExd3:double;        procedure WriteIsvExd3 (pValue:double);
    function  ReadIsvExd4:double;        procedure WriteIsvExd4 (pValue:double);
    function  ReadIsvExd5:double;        procedure WriteIsvExd5 (pValue:double);
    function  ReadIsvExd6:double;        procedure WriteIsvExd6 (pValue:double);
    function  ReadIsvExd7:double;        procedure WriteIsvExd7 (pValue:double);
    function  ReadIsvExd8:double;        procedure WriteIsvExd8 (pValue:double);
    function  ReadIsvExd9:double;        procedure WriteIsvExd9 (pValue:double);
    function  ReadIcvExd1:double;        procedure WriteIcvExd1 (pValue:double);
    function  ReadIcvExd2:double;        procedure WriteIcvExd2 (pValue:double);
    function  ReadIcvExd3:double;        procedure WriteIcvExd3 (pValue:double);
    function  ReadIcvExd4:double;        procedure WriteIcvExd4 (pValue:double);
    function  ReadIcvExd5:double;        procedure WriteIcvExd5 (pValue:double);
    function  ReadIcvExd6:double;        procedure WriteIcvExd6 (pValue:double);
    function  ReadIcvExd7:double;        procedure WriteIcvExd7 (pValue:double);
    function  ReadIcvExd8:double;        procedure WriteIcvExd8 (pValue:double);
    function  ReadIcvExd9:double;        procedure WriteIcvExd9 (pValue:double);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateEndDate (pEndDate:TDatetime):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property IsvBef:double read ReadIsvBef write WriteIsvBef;
    property IsvAct:double read ReadIsvAct write WriteIsvAct;
    property IsvAft:double read ReadIsvAft write WriteIsvAft;
    property IsvSum:double read ReadIsvSum write WriteIsvSum;
    property IcvBef:double read ReadIcvBef write WriteIcvBef;
    property IcvAct:double read ReadIcvAct write WriteIcvAct;
    property IcvAft:double read ReadIcvAft write WriteIcvAft;
    property IcvSum:double read ReadIcvSum write WriteIcvSum;
    property DifSum:double read ReadDifSum write WriteDifSum;
    property ExdTxt1:Str30 read ReadExdTxt1 write WriteExdTxt1;
    property ExdTxt2:Str30 read ReadExdTxt2 write WriteExdTxt2;
    property ExdTxt3:Str30 read ReadExdTxt3 write WriteExdTxt3;
    property ExdTxt4:Str30 read ReadExdTxt4 write WriteExdTxt4;
    property ExdTxt5:Str30 read ReadExdTxt5 write WriteExdTxt5;
    property ExdTxt6:Str30 read ReadExdTxt6 write WriteExdTxt6;
    property ExdTxt7:Str30 read ReadExdTxt7 write WriteExdTxt7;
    property ExdTxt8:Str30 read ReadExdTxt8 write WriteExdTxt8;
    property ExdTxt9:Str30 read ReadExdTxt9 write WriteExdTxt9;
    property ExdBeg1:longint read ReadExdBeg1 write WriteExdBeg1;
    property ExdBeg2:longint read ReadExdBeg2 write WriteExdBeg2;
    property ExdBeg3:longint read ReadExdBeg3 write WriteExdBeg3;
    property ExdBeg4:longint read ReadExdBeg4 write WriteExdBeg4;
    property ExdBeg5:longint read ReadExdBeg5 write WriteExdBeg5;
    property ExdBeg6:longint read ReadExdBeg6 write WriteExdBeg6;
    property ExdBeg7:longint read ReadExdBeg7 write WriteExdBeg7;
    property ExdBeg8:longint read ReadExdBeg8 write WriteExdBeg8;
    property ExdBeg9:longint read ReadExdBeg9 write WriteExdBeg9;
    property ExdEnd1:longint read ReadExdEnd1 write WriteExdEnd1;
    property ExdEnd2:longint read ReadExdEnd2 write WriteExdEnd2;
    property ExdEnd3:longint read ReadExdEnd3 write WriteExdEnd3;
    property ExdEnd4:longint read ReadExdEnd4 write WriteExdEnd4;
    property ExdEnd5:longint read ReadExdEnd5 write WriteExdEnd5;
    property ExdEnd6:longint read ReadExdEnd6 write WriteExdEnd6;
    property ExdEnd7:longint read ReadExdEnd7 write WriteExdEnd7;
    property ExdEnd8:longint read ReadExdEnd8 write WriteExdEnd8;
    property ExdEnd9:longint read ReadExdEnd9 write WriteExdEnd9;
    property IsvExd1:double read ReadIsvExd1 write WriteIsvExd1;
    property IsvExd2:double read ReadIsvExd2 write WriteIsvExd2;
    property IsvExd3:double read ReadIsvExd3 write WriteIsvExd3;
    property IsvExd4:double read ReadIsvExd4 write WriteIsvExd4;
    property IsvExd5:double read ReadIsvExd5 write WriteIsvExd5;
    property IsvExd6:double read ReadIsvExd6 write WriteIsvExd6;
    property IsvExd7:double read ReadIsvExd7 write WriteIsvExd7;
    property IsvExd8:double read ReadIsvExd8 write WriteIsvExd8;
    property IsvExd9:double read ReadIsvExd9 write WriteIsvExd9;
    property IcvExd1:double read ReadIcvExd1 write WriteIcvExd1;
    property IcvExd2:double read ReadIcvExd2 write WriteIcvExd2;
    property IcvExd3:double read ReadIcvExd3 write WriteIcvExd3;
    property IcvExd4:double read ReadIcvExd4 write WriteIcvExd4;
    property IcvExd5:double read ReadIcvExd5 write WriteIcvExd5;
    property IcvExd6:double read ReadIcvExd6 write WriteIcvExd6;
    property IcvExd7:double read ReadIcvExd7 write WriteIcvExd7;
    property IcvExd8:double read ReadIcvExd8 write WriteIcvExd8;
    property IcvExd9:double read ReadIcvExd9 write WriteIcvExd9;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TAscdocBtr.Create;
begin
  oBtrTable := BtrInit ('ASCDOC',gPath.LdgPath,Self);
end;

constructor TAscdocBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ASCDOC',pPath,Self);
end;

destructor TAscdocBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAscdocBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAscdocBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAscdocBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAscdocBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAscdocBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAscdocBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAscdocBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAscdocBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAscdocBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAscdocBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAscdocBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TAscdocBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TAscdocBtr.ReadIsvBef:double;
begin
  Result := oBtrTable.FieldByName('IsvBef').AsFloat;
end;

procedure TAscdocBtr.WriteIsvBef(pValue:double);
begin
  oBtrTable.FieldByName('IsvBef').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvAct:double;
begin
  Result := oBtrTable.FieldByName('IsvAct').AsFloat;
end;

procedure TAscdocBtr.WriteIsvAct(pValue:double);
begin
  oBtrTable.FieldByName('IsvAct').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvAft:double;
begin
  Result := oBtrTable.FieldByName('IsvAft').AsFloat;
end;

procedure TAscdocBtr.WriteIsvAft(pValue:double);
begin
  oBtrTable.FieldByName('IsvAft').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvSum:double;
begin
  Result := oBtrTable.FieldByName('IsvSum').AsFloat;
end;

procedure TAscdocBtr.WriteIsvSum(pValue:double);
begin
  oBtrTable.FieldByName('IsvSum').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvBef:double;
begin
  Result := oBtrTable.FieldByName('IcvBef').AsFloat;
end;

procedure TAscdocBtr.WriteIcvBef(pValue:double);
begin
  oBtrTable.FieldByName('IcvBef').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvAct:double;
begin
  Result := oBtrTable.FieldByName('IcvAct').AsFloat;
end;

procedure TAscdocBtr.WriteIcvAct(pValue:double);
begin
  oBtrTable.FieldByName('IcvAct').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvAft:double;
begin
  Result := oBtrTable.FieldByName('IcvAft').AsFloat;
end;

procedure TAscdocBtr.WriteIcvAft(pValue:double);
begin
  oBtrTable.FieldByName('IcvAft').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvSum:double;
begin
  Result := oBtrTable.FieldByName('IcvSum').AsFloat;
end;

procedure TAscdocBtr.WriteIcvSum(pValue:double);
begin
  oBtrTable.FieldByName('IcvSum').AsFloat := pValue;
end;

function TAscdocBtr.ReadDifSum:double;
begin
  Result := oBtrTable.FieldByName('DifSum').AsFloat;
end;

procedure TAscdocBtr.WriteDifSum(pValue:double);
begin
  oBtrTable.FieldByName('DifSum').AsFloat := pValue;
end;

function TAscdocBtr.ReadExdTxt1:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt1').AsString;
end;

procedure TAscdocBtr.WriteExdTxt1(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt1').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt2:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt2').AsString;
end;

procedure TAscdocBtr.WriteExdTxt2(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt2').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt3:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt3').AsString;
end;

procedure TAscdocBtr.WriteExdTxt3(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt3').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt4:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt4').AsString;
end;

procedure TAscdocBtr.WriteExdTxt4(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt4').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt5:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt5').AsString;
end;

procedure TAscdocBtr.WriteExdTxt5(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt5').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt6:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt6').AsString;
end;

procedure TAscdocBtr.WriteExdTxt6(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt6').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt7:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt7').AsString;
end;

procedure TAscdocBtr.WriteExdTxt7(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt7').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt8:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt8').AsString;
end;

procedure TAscdocBtr.WriteExdTxt8(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt8').AsString := pValue;
end;

function TAscdocBtr.ReadExdTxt9:Str30;
begin
  Result := oBtrTable.FieldByName('ExdTxt9').AsString;
end;

procedure TAscdocBtr.WriteExdTxt9(pValue:Str30);
begin
  oBtrTable.FieldByName('ExdTxt9').AsString := pValue;
end;

function TAscdocBtr.ReadExdBeg1:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg1').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg1(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg1').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg2:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg2').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg2(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg2').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg3:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg3').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg3(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg3').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg4:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg4').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg4(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg4').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg5:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg5').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg5(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg5').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg6:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg6').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg6(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg6').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg7:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg7').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg7(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg7').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg8:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg8').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg8(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg8').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdBeg9:longint;
begin
  Result := oBtrTable.FieldByName('ExdBeg9').AsInteger;
end;

procedure TAscdocBtr.WriteExdBeg9(pValue:longint);
begin
  oBtrTable.FieldByName('ExdBeg9').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd1:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd1').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd1(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd1').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd2:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd2').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd2(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd2').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd3:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd3').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd3(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd3').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd4:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd4').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd4(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd4').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd5:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd5').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd5(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd5').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd6:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd6').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd6(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd6').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd7:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd7').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd7(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd7').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd8:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd8').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd8(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd8').AsInteger := pValue;
end;

function TAscdocBtr.ReadExdEnd9:longint;
begin
  Result := oBtrTable.FieldByName('ExdEnd9').AsInteger;
end;

procedure TAscdocBtr.WriteExdEnd9(pValue:longint);
begin
  oBtrTable.FieldByName('ExdEnd9').AsInteger := pValue;
end;

function TAscdocBtr.ReadIsvExd1:double;
begin
  Result := oBtrTable.FieldByName('IsvExd1').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd1(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd1').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd2:double;
begin
  Result := oBtrTable.FieldByName('IsvExd2').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd2(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd2').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd3:double;
begin
  Result := oBtrTable.FieldByName('IsvExd3').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd3(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd3').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd4:double;
begin
  Result := oBtrTable.FieldByName('IsvExd4').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd4(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd4').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd5:double;
begin
  Result := oBtrTable.FieldByName('IsvExd5').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd5(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd5').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd6:double;
begin
  Result := oBtrTable.FieldByName('IsvExd6').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd6(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd6').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd7:double;
begin
  Result := oBtrTable.FieldByName('IsvExd7').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd7(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd7').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd8:double;
begin
  Result := oBtrTable.FieldByName('IsvExd8').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd8(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd8').AsFloat := pValue;
end;

function TAscdocBtr.ReadIsvExd9:double;
begin
  Result := oBtrTable.FieldByName('IsvExd9').AsFloat;
end;

procedure TAscdocBtr.WriteIsvExd9(pValue:double);
begin
  oBtrTable.FieldByName('IsvExd9').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd1:double;
begin
  Result := oBtrTable.FieldByName('IcvExd1').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd1(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd1').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd2:double;
begin
  Result := oBtrTable.FieldByName('IcvExd2').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd2(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd2').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd3:double;
begin
  Result := oBtrTable.FieldByName('IcvExd3').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd3(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd3').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd4:double;
begin
  Result := oBtrTable.FieldByName('IcvExd4').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd4(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd4').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd5:double;
begin
  Result := oBtrTable.FieldByName('IcvExd5').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd5(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd5').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd6:double;
begin
  Result := oBtrTable.FieldByName('IcvExd6').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd6(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd6').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd7:double;
begin
  Result := oBtrTable.FieldByName('IcvExd7').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd7(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd7').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd8:double;
begin
  Result := oBtrTable.FieldByName('IcvExd8').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd8(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd8').AsFloat := pValue;
end;

function TAscdocBtr.ReadIcvExd9:double;
begin
  Result := oBtrTable.FieldByName('IcvExd9').AsFloat;
end;

procedure TAscdocBtr.WriteIcvExd9(pValue:double);
begin
  oBtrTable.FieldByName('IcvExd9').AsFloat := pValue;
end;

function TAscdocBtr.ReadItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAscdocBtr.WriteItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAscdocBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAscdocBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAscdocBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAscdocBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAscdocBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAscdocBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAscdocBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAscdocBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAscdocBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAscdocBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAscdocBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TAscdocBtr.LocateEndDate (pEndDate:TDatetime):boolean;
begin
  SetIndex (ixEndDate);
  Result := oBtrTable.FindKey([pEndDate]);
end;

procedure TAscdocBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAscdocBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAscdocBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAscdocBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAscdocBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAscdocBtr.First;
begin
  oBtrTable.First;
end;

procedure TAscdocBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAscdocBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAscdocBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAscdocBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAscdocBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAscdocBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAscdocBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAscdocBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAscdocBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAscdocBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAscdocBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
