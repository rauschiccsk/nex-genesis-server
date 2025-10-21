unit GrpTable;
// ****************************************************************************
//                   Ovladac na skupinu otvorenych suborov
//
// Tatu funkcia umozni otvorit vsetky alebo specifikovane databazove subory
// tej istej skupiny, napr. vsetky knihy OF alebo DF a pod.
// ****************************************************************************

interface

uses
  IcTypes, IcConv, IcValue, IcTools, IcVariab,
  pBokLst,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TGrpTableF = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    oCount:byte; // Pocet otovrenych databaz
    oFindNum:byte; // Poradove cislo databaze v ktorom bol najdeny hladany udaj
    oPmdBook:boolean;
  public      
    btBOOK:TNexBtrTable; // Zoznam knih
    otBokLst:TBoklstTmp;
    btTABLE:array[1..100] of TNexBtrTable; // Zoznam otvorenych databaz
    procedure OpenTables (pBook_Pmd,pTableName,pIndexName:ShortString;pPmdOpen:boolean);
    function FindKey(const pKeyValues: array of const):boolean;
  published
    property Count:byte read oCount;
    property FindNum:byte read oFindNum;
  end;

implementation

{$R *.dfm}

procedure TGrpTableF.FormCreate(Sender: TObject);
begin
  oCount := 0;
  oFindNum := 0;
  btBOOK := nil;
  otBokLst:=TBoklstTmp.Create;otBokLst.Open;
end;

procedure TGrpTableF.OpenTables (pBook_Pmd,pTableName,pIndexName:ShortString;pPmdOpen:boolean);
begin
  oPmdBook:=Length(pBook_Pmd)=3;
  If oPmdBook then begin
    otBokLst.LoadToTmp(pBook_Pmd);otBokLst.First;
    oCount := 0;
    while not otBokLst.Eof do begin
      Inc (oCount);
      btTABLE[oCount] := TNexBtrTable.Create(Self);
      btTABLE[oCount].Name := 'mt'+pTableName+StrInt(oCount,0);
      btTABLE[oCount].FixedName := pTableName;
      btTABLE[oCount].Open(otBokLst.BokNum);
      btTABLE[oCount].IndexName := pIndexName;
      otBokLst.Next;
    end;
  end else begin
    btBOOK := TNexBtrTable.Create(Self);
    btBOOK.Name := 'mt'+pBook_Pmd;
    btBOOK.FixedName := pBook_Pmd;
    btBOOK.Open;
    btBOOK.First;
    oCount := 0;
    If btBOOK.RecordCount>0 then begin
      Repeat
        Inc (oCount);
        btTABLE[oCount] := TNexBtrTable.Create(Self);
        btTABLE[oCount].Name := 'mt'+pTableName+StrInt(oCount,0);
        btTABLE[oCount].FixedName := pTableName;
        btTABLE[oCount].Open(btBOOK.FieldByName('BookNum').AsString);
        btTABLE[oCount].IndexName := pIndexName;
        Application.ProcessMessages;
        btBOOK.Next;
      until btBOOK.Eof;
    end;
  end;
end;

function TGrpTableF.FindKey(const pKeyValues: array of const):boolean;
var mCnt:byte;
begin
  Result := FALSE;
  mCnt := 0;
  If oCount>0 then begin
    If oPmdBook then begin
      otBokLst.First;
      Repeat
        Inc (mCnt);
        Application.ProcessMessages;
        Result := btTABLE[mCnt].FindKey(pKeyValues);
        If not Result then otBokLst.Next;
      until Result or (mCnt=oCount);
    end else begin
      btBOOK.First;
      Repeat
        Inc (mCnt);
        Application.ProcessMessages;
        Result := btTABLE[mCnt].FindKey(pKeyValues);
        If not Result then btBOOK.Next;
      until Result or (mCnt=oCount);
    end;
  end;
  If Result then oFindNum := mCnt;
end;

procedure TGrpTableF.FormDestroy(Sender: TObject);
var I:byte;
begin
  If oCount>0 then begin // Mame otvorene subory, ktorych treba uzatvorit
    For I:=1 to oCount do begin
      btTABLE[I].Close;
      FreeAndNil (btTABLE[I]);
    end;
  end;
  If btBOOK<>nil then begin
    btBOOK.Close;
    FreeAndNil (btBOOK);
  end;
  otBokLst.Close; FreeAndNil (otBokLst);
end;

// *************************** PRIVATE METHODS *******************************


// **************************** PUBLIC METHODS *******************************


end.
