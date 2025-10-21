unit bSPRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixPasCode = 'PasCode';
  ixPrgMod = 'PrgMod';
  ixCrtDat = 'CrtDat';

type
  TSprlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDes:Str250;         procedure WriteDocDes (pValue:Str250);
    function  ReadReason:Str250;         procedure WriteReason (pValue:Str250);
    function  ReadSoluti:Str250;         procedure WriteSoluti (pValue:Str250);
    function  ReadPrgMod:Str3;           procedure WritePrgMod (pValue:Str3);
    function  ReadDocSta:Str1;           procedure WriteDocSta (pValue:Str1);
    function  ReadCrtNam:Str8;           procedure WriteCrtNam (pValue:Str8);
    function  ReadCrtUsr:Str30;          procedure WriteCrtUsr (pValue:Str30);
    function  ReadCrtDat:TDatetime;      procedure WriteCrtDat (pValue:TDatetime);
    function  ReadCrtTim:TDatetime;      procedure WriteCrtTim (pValue:TDatetime);
    function  ReadClsNam:Str8;           procedure WriteClsNam (pValue:Str8);
    function  ReadClsUsr:Str30;          procedure WriteClsUsr (pValue:Str30);
    function  ReadClsDat:TDatetime;      procedure WriteClsDat (pValue:TDatetime);
    function  ReadClsTim:TDatetime;      procedure WriteClsTim (pValue:TDatetime);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadDocPri:Str1;           procedure WriteDocPri (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePasCode (pPaCode:longint):boolean;
    function LocatePrgMod (pPrgMod:Str3):boolean;
    function LocateCrtDat (pCrtDat:TDatetime):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPasCode (pPaCode:longint):boolean;
    function NearestPrgMod (pPrgMod:Str3):boolean;
    function NearestCrtDat (pCrtDat:TDatetime):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDes:Str250 read ReadDocDes write WriteDocDes;
    property Reason:Str250 read ReadReason write WriteReason;
    property Soluti:Str250 read ReadSoluti write WriteSoluti;
    property PrgMod:Str3 read ReadPrgMod write WritePrgMod;
    property DocSta:Str1 read ReadDocSta write WriteDocSta;
    property CrtNam:Str8 read ReadCrtNam write WriteCrtNam;
    property CrtUsr:Str30 read ReadCrtUsr write WriteCrtUsr;
    property CrtDat:TDatetime read ReadCrtDat write WriteCrtDat;
    property CrtTim:TDatetime read ReadCrtTim write WriteCrtTim;
    property ClsNam:Str8 read ReadClsNam write WriteClsNam;
    property ClsUsr:Str30 read ReadClsUsr write WriteClsUsr;
    property ClsDat:TDatetime read ReadClsDat write WriteClsDat;
    property ClsTim:TDatetime read ReadClsTim write WriteClsTim;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property DocPri:Str1 read ReadDocPri write WriteDocPri;
  end;

implementation

constructor TSprlstBtr.Create;
begin
  oBtrTable := BtrInit ('SPRLST',gPath.SysPath,Self);
end;

constructor TSprlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SPRLST',pPath,Self);
end;

destructor TSprlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSprlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSprlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSprlstBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSprlstBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSprlstBtr.ReadDocDes:Str250;
begin
  Result := oBtrTable.FieldByName('DocDes').AsString;
end;

procedure TSprlstBtr.WriteDocDes(pValue:Str250);
begin
  oBtrTable.FieldByName('DocDes').AsString := pValue;
end;

function TSprlstBtr.ReadReason:Str250;
begin
  Result := oBtrTable.FieldByName('Reason').AsString;
end;

procedure TSprlstBtr.WriteReason(pValue:Str250);
begin
  oBtrTable.FieldByName('Reason').AsString := pValue;
end;

function TSprlstBtr.ReadSoluti:Str250;
begin
  Result := oBtrTable.FieldByName('Soluti').AsString;
end;

procedure TSprlstBtr.WriteSoluti(pValue:Str250);
begin
  oBtrTable.FieldByName('Soluti').AsString := pValue;
end;

function TSprlstBtr.ReadPrgMod:Str3;
begin
  Result := oBtrTable.FieldByName('PrgMod').AsString;
end;

procedure TSprlstBtr.WritePrgMod(pValue:Str3);
begin
  oBtrTable.FieldByName('PrgMod').AsString := pValue;
end;

function TSprlstBtr.ReadDocSta:Str1;
begin
  Result := oBtrTable.FieldByName('DocSta').AsString;
end;

procedure TSprlstBtr.WriteDocSta(pValue:Str1);
begin
  oBtrTable.FieldByName('DocSta').AsString := pValue;
end;

function TSprlstBtr.ReadCrtNam:Str8;
begin
  Result := oBtrTable.FieldByName('CrtNam').AsString;
end;

procedure TSprlstBtr.WriteCrtNam(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtNam').AsString := pValue;
end;

function TSprlstBtr.ReadCrtUsr:Str30;
begin
  Result := oBtrTable.FieldByName('CrtUsr').AsString;
end;

procedure TSprlstBtr.WriteCrtUsr(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtUsr').AsString := pValue;
end;

function TSprlstBtr.ReadCrtDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDat').AsDateTime;
end;

procedure TSprlstBtr.WriteCrtDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDat').AsDateTime := pValue;
end;

function TSprlstBtr.ReadCrtTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TSprlstBtr.WriteCrtTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTim').AsDateTime := pValue;
end;

function TSprlstBtr.ReadClsNam:Str8;
begin
  Result := oBtrTable.FieldByName('ClsNam').AsString;
end;

procedure TSprlstBtr.WriteClsNam(pValue:Str8);
begin
  oBtrTable.FieldByName('ClsNam').AsString := pValue;
end;

function TSprlstBtr.ReadClsUsr:Str30;
begin
  Result := oBtrTable.FieldByName('ClsUsr').AsString;
end;

procedure TSprlstBtr.WriteClsUsr(pValue:Str30);
begin
  oBtrTable.FieldByName('ClsUsr').AsString := pValue;
end;

function TSprlstBtr.ReadClsDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ClsDat').AsDateTime;
end;

procedure TSprlstBtr.WriteClsDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ClsDat').AsDateTime := pValue;
end;

function TSprlstBtr.ReadClsTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('ClsTim').AsDateTime;
end;

procedure TSprlstBtr.WriteClsTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ClsTim').AsDateTime := pValue;
end;

function TSprlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSprlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSprlstBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSprlstBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSprlstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSprlstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSprlstBtr.ReadDocPri:Str1;
begin
  Result := oBtrTable.FieldByName('DocPri').AsString;
end;

procedure TSprlstBtr.WriteDocPri(pValue:Str1);
begin
  oBtrTable.FieldByName('DocPri').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSprlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSprlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSprlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSprlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSprlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSprlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSprlstBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TSprlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSprlstBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSprlstBtr.LocatePasCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPasCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TSprlstBtr.LocatePrgMod (pPrgMod:Str3):boolean;
begin
  SetIndex (ixPrgMod);
  Result := oBtrTable.FindKey([pPrgMod]);
end;

function TSprlstBtr.LocateCrtDat (pCrtDat:TDatetime):boolean;
begin
  SetIndex (ixCrtDat);
  Result := oBtrTable.FindKey([pCrtDat]);
end;

function TSprlstBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TSprlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSprlstBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSprlstBtr.NearestPasCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPasCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TSprlstBtr.NearestPrgMod (pPrgMod:Str3):boolean;
begin
  SetIndex (ixPrgMod);
  Result := oBtrTable.FindNearest([pPrgMod]);
end;

function TSprlstBtr.NearestCrtDat (pCrtDat:TDatetime):boolean;
begin
  SetIndex (ixCrtDat);
  Result := oBtrTable.FindNearest([pCrtDat]);
end;

procedure TSprlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSprlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSprlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSprlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSprlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSprlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSprlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSprlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSprlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSprlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSprlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSprlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSprlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSprlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSprlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSprlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSprlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1928001}
