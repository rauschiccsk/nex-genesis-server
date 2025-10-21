unit RebFnc;
{$F+}

// *****************************************************************************
//                        OBNOVA DATABAZOVYCH SUBOROV
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, NexGlob, NexPath, NexIni, NexMsg,
  NexError, Bok, ComCtrls, SysUtils, Classes, Forms, BtrTable, Db;

type
  TRebFnc = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oInd:TProgressBar;
      procedure CopyFld (pOldTab,pNewTab:TBtrieveTable);
    public
      procedure Run(pTabName:Str8;pTabPath,pDefPath:ShortString); // Vykoná obnovu zadaneho databazaoveho suboru

      property Ind:TProgressBar write oInd;
  end;

implementation

constructor TRebFnc.Create(AOwner: TComponent);
begin
  //
end;

destructor TRebFnc.Destroy;
begin
  //
end;

// ********************************* PRIVATE ***********************************

procedure TRebFnc.CopyFld (pOldTab,pNewTab:TBtrieveTable);
var I:word;  mFieldName:string; mFieldType:TFieldType;
begin
  For I:= 0 to pOldTab.FieldCount-1 do begin
    mFieldName := pOldTab.Fields[I].FieldName;
    If pOldTab.FindField(mFieldName)<>nil then begin
      If pNewTab.FindField(mFieldName)<>nil then begin
        pNewTab.FieldByName(mFieldName).AsString := pOldTab.FieldByName(mFieldName).AsString;
      end;
    end;
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TRebFnc.Run(pTabName:Str8;pTabPath,pDefPath:ShortString); // Vykoná obnovu zadaneho databazaoveho suboru
var mOldTab,mNewTab:TBtrieveTable;  mOldQnt,mNewQnt:longint;
begin
  // Pôvodná databáza
  mOldTab := TBtrieveTable.Create (Application);
  mOldTab.DefPath := pDefPath;
  mOldTab.DefName := NumStrip(pTabName)+'.BDF';
  mOldTab.DataBaseName := pTabPath;
  mOldTab.FixedName := pTabName;
  mOldTab.TableName := pTabName;
  mOldTab.Open;
  // Nová databáza
  mNewTab := TBtrieveTable.Create (Application);
  mNewTab.DefPath := pDefPath;
  mNewTab.DefName := NumStrip(pTabName)+'.BDF';
  mNewTab.DataBaseName := pTabPath;
  mNewTab.TableNameExt := 'NEW';
  mOldTab.FixedName := pTabName;
  mNewTab.TableName := pTabName;
  mNewTab.CreateTable;
  mNewTab.Open;
  mOldTab.First;
  If mOldTab.RecordCount>0 then begin
    If oInd<>nil then begin
      oInd.Max := mOldTab.RecordCount;
      oInd.Position := 0;
    end;
    Repeat
      If oInd<>nil then oInd.StepBy(1);
      mNewTab.Insert;
      CopyFld(mOldTab,mNewTab);
      mNewTab.Post;
      Application.ProcessMessages;
      mOldTab.Next;
    until (mOldTab.Eof);
  end;
  mOldQnt := mOldTab.RecordCount;
  mNewQnt := mNewTab.RecordCount;
  mNewTab.Close;
  FreeAndNil (mNewTab);
  mOldTab.Close;
  FreeAndNil (mOldTab);
  If mOldQnt=mNewQnt then begin
    RenameFile(pTabPath+pTabName+'.BTR',pTabPath+pTabName+'.OLD');
    If not FileExists(pTabPath+pTabName+'.BTR')
      then RenameFile(pTabPath+pTabName+'.NEW',pTabPath+pTabName+'.BTR')
      else ; // Nebolo mozne premenovat
  end
  else begin // Novy a stary subor nemaju rovnaky pocet viet

  end;
end;


end.


