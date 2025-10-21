unit tNRMCLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';

type
  TNrmclcTmp = class (TComponent)
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
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadMinAct:double;         procedure WriteMinAct (pValue:double);
    function  ReadOptAct:double;         procedure WriteOptAct (pValue:double);
    function  ReadMaxAct:double;         procedure WriteMaxAct (pValue:double);
    function  ReadMinClc:double;         procedure WriteMinClc (pValue:double);
    function  ReadOptClc:double;         procedure WriteOptClc (pValue:double);
    function  ReadMaxClc:double;         procedure WriteMaxClc (pValue:double);
    function  ReadModSta:Str1;           procedure WriteModSta (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;

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
    property MsName:Str10 read ReadMsName write WriteMsName;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property MinAct:double read ReadMinAct write WriteMinAct;
    property OptAct:double read ReadOptAct write WriteOptAct;
    property MaxAct:double read ReadMaxAct write WriteMaxAct;
    property MinClc:double read ReadMinClc write WriteMinClc;
    property OptClc:double read ReadOptClc write WriteOptClc;
    property MaxClc:double read ReadMaxClc write WriteMaxClc;
    property ModSta:Str1 read ReadModSta write WriteModSta;
  end;

implementation

constructor TNrmclcTmp.Create;
begin
  oTmpTable := TmpInit ('NRMCLC',Self);
end;

destructor TNrmclcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TNrmclcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TNrmclcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TNrmclcTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TNrmclcTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TNrmclcTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TNrmclcTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TNrmclcTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TNrmclcTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TNrmclcTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TNrmclcTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TNrmclcTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TNrmclcTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TNrmclcTmp.ReadDayQnt:word;
begin
  Result := oTmpTable.FieldByName('DayQnt').AsInteger;
end;

procedure TNrmclcTmp.WriteDayQnt(pValue:word);
begin
  oTmpTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TNrmclcTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TNrmclcTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TNrmclcTmp.ReadMinAct:double;
begin
  Result := oTmpTable.FieldByName('MinAct').AsFloat;
end;

procedure TNrmclcTmp.WriteMinAct(pValue:double);
begin
  oTmpTable.FieldByName('MinAct').AsFloat := pValue;
end;

function TNrmclcTmp.ReadOptAct:double;
begin
  Result := oTmpTable.FieldByName('OptAct').AsFloat;
end;

procedure TNrmclcTmp.WriteOptAct(pValue:double);
begin
  oTmpTable.FieldByName('OptAct').AsFloat := pValue;
end;

function TNrmclcTmp.ReadMaxAct:double;
begin
  Result := oTmpTable.FieldByName('MaxAct').AsFloat;
end;

procedure TNrmclcTmp.WriteMaxAct(pValue:double);
begin
  oTmpTable.FieldByName('MaxAct').AsFloat := pValue;
end;

function TNrmclcTmp.ReadMinClc:double;
begin
  Result := oTmpTable.FieldByName('MinClc').AsFloat;
end;

procedure TNrmclcTmp.WriteMinClc(pValue:double);
begin
  oTmpTable.FieldByName('MinClc').AsFloat := pValue;
end;

function TNrmclcTmp.ReadOptClc:double;
begin
  Result := oTmpTable.FieldByName('OptClc').AsFloat;
end;

procedure TNrmclcTmp.WriteOptClc(pValue:double);
begin
  oTmpTable.FieldByName('OptClc').AsFloat := pValue;
end;

function TNrmclcTmp.ReadMaxClc:double;
begin
  Result := oTmpTable.FieldByName('MaxClc').AsFloat;
end;

procedure TNrmclcTmp.WriteMaxClc(pValue:double);
begin
  oTmpTable.FieldByName('MaxClc').AsFloat := pValue;
end;

function TNrmclcTmp.ReadModSta:Str1;
begin
  Result := oTmpTable.FieldByName('ModSta').AsString;
end;

procedure TNrmclcTmp.WriteModSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ModSta').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNrmclcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TNrmclcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TNrmclcTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TNrmclcTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TNrmclcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TNrmclcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TNrmclcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TNrmclcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TNrmclcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TNrmclcTmp.First;
begin
  oTmpTable.First;
end;

procedure TNrmclcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TNrmclcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TNrmclcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TNrmclcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TNrmclcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TNrmclcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TNrmclcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TNrmclcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TNrmclcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TNrmclcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TNrmclcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1805001}
