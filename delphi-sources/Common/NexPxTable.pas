unit NexPxTable;

(*
Tento unit obsahuje konponent NexPxTable. Tento komponent je z TTable a m·
nasledovnÈ funkcie:
- CreateTableInDef - vytvor˝ datab·zov˝ s˙bor podæa popisu DefName

novÈ vlastnosti:
- DefPath - adres·r, kde sa nach·dza definiËn˝ s˙bor. SystÈm automaticky
            naËÌta z gPath.DefPath
- DefName - n·zov definiËnÈho s˙boru
- AutoCreate - ak je TRUE, pred otvorenÌm datab·zovÈho s˙boru prekontroluje, Ëi
            existuje dan˝ datab·zov˝ s˙bor, ak nie, vytvor˝
- AutoDelete - ak je TRUE, po uzatvorenÌ datab·zovÈho s˙boru s prÌkazom Close
            automaticky ho zruöÌ
- FixName    - z·kladn· Ëasù n·zvu datab·zovÈho s˙boru pri automatickom generovanÌ
- AutoTableName - ak je TRUE, pred otvorenÌm datab·zovÈho s˙boru vygeneruje n·zov
            z FixName s poradov˝m ËÌslom na 3 miesta. Prekotroluje, Ëi existuje
            tak˝ datab·zov˝ s˙bor. Ak ·no, pok˙si ho zruöiù. Ak sa ned·, generuje
            Ôaæöie meno.

*)

interface

uses
  NexPath, IcTypes, IcConv, IcTools, IcFiles, NumText, Nexmsg, PxTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DbTables;

type
  TNexPxTable = class(TTable)
  private
    oInsEnab: boolean;
    oDefPath: string;
    oDefName: string;
    oFixName: string;
    oIndexName: string;
    oAutoCreate: boolean;
    oAutoDelete: boolean;
    oAutoTableName: boolean;
    eBeforePost: TDataSetNotifyEvent;
    oStatusRec: array [1..10] of TPxStatusRec;
    oSwapNum: byte;

    procedure MyBeforePost (DataSet: TDataSet) ;
    procedure MyAfterInsert (DataSet: TDataSet);

    function  GetActive:boolean;
    procedure SetActive (Value:boolean);
    function  GetFldType (pFldName,pFldTypeS:string;var pFldType:TFieldType;var pFldSize:longint):boolean;
    function  GetIndOption (pIndex,pIndTypeS:string;var pIndName,pIndFields:string;var pIndType:TIndexOptions):boolean;
  public
    oGPathRead : boolean;
    constructor Create(pOwner: TComponent); override;
    procedure Open; overload;
    procedure Close; overload;

    procedure CreateTableInDef;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure InternalCreateTable;
    procedure DelRecs;
  published
    property Active:boolean read GetActive write SetActive;
    property FixName: string read oFixName write oFixName;
    property DefPath: string read oDefPath write oDefPath;
    property DefName: string read oDefName write oDefName;
    property InsEnab: boolean write oInsEnab;
    property AutoCreate: boolean read oAutoCreate write oAutoCreate;
    property AutoDelete: boolean read oAutoDelete write oAutoDelete;
    property AutoTableName: boolean read oAutoTableName write oAutoTableName;
    property BeforePost: TDataSetNotifyEvent read eBeforePost write eBeforePost;
  end;

procedure Register;

implementation

uses
  DM_StkDat;

procedure TNexPxTable.SwapStatus;
begin
  Inc (oSwapNum);
  oStatusRec[oSwapNum].IndexName  :=IndexName;
  oStatusRec[oSwapNum].Position   :=GetBookMark;
  oStatusRec[oSwapNum].Filter     :=Filter;
  oStatusRec[oSwapNum].Filtered   :=Filtered;
end;

procedure TNexPxTable.RestoreStatus;
begin
  IndexName  :=oStatusRec[oSwapNum].IndexName;
  Filter     :=oStatusRec[oSwapNum].Filter;
  Filtered   :=oStatusRec[oSwapNum].Filtered;
  If BookmarkValid(oStatusRec[oSwapNum].Position) then begin
    GotoBookMark(oStatusRec[oSwapNum].Position);
    FreeBookMark(oStatusRec[oSwapNum].Position);
  end;
  Dec(oSwapNum);
end;

procedure TNexPxTable.MyBeforePost (DataSet: TDataSet) ;
var B,L,I:byte;  mIndex,mStr:string;  mFoundedField: TField;
begin
  for I:=0 to DataSet.FieldCount-1 do begin
    mStr:=DataSet.Fields[i].FieldName;
    mStr:=Uppercase(mStr); //2000.5.9.
    If mStr[length(mStr)] = '_' then begin
      mFoundedField:=DataSet.FindField(copy(mStr,1,Length(mStr)-1));
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=IcConv.StrToAlias(mFoundedField.AsString);
    end;
    If POS('NUMTOTEXT_',mStr)=1 then begin
      mStr:=Copy(mStr,Length('NUMTOTEXT_')+1,255);
      mFoundedField:=DataSet.FindField(mStr);
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=Numtext.ConvNumToText(ValDoub(mFoundedField.AsString));
    end;
    If POS('COPY_',mStr)=1 then begin
      mStr:=Copy(mStr,Length('COPY_')+1,255);
      B:=valint(Copy(mStr,1,POS('_',mStr)-1));
      mStr:=Copy(mStr,POS('_',mStr)+1,255);
      L:=valint(Copy(mStr,1,POS('_',mStr)-1));
      mStr:=Copy(mStr,POS('_',mStr)+1,255);
      mFoundedField:=DataSet.FindField(mStr);
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=Copy(mFoundedField.AsString,B,L);
    end;
    If POS('GSCODE_',mStr)=1 then begin
      mStr:=Copy(mStr,Length('GSCODE_')+1,255);
      mFoundedField:=DataSet.FindField('GsCode');
      If (mFoundedField <> nil)and(dmSTK.btGSCAT<>NIL)and dmSTK.btGSCAT.Active then begin
        mIndex:=dmStk.btGSCAT.IndexName;dmStk.btGSCAT.IndexName:='GsCode';
        If ((dmStk.btGSCAT.fieldByname('GsCode').AsInteger=mFoundedField.AsInteger)or dmSTK.btGSCAT.FindKey([mFoundedField.AsInteger]))
          then DataSet.Fields[i].AsString:=dmStk.btGSCAT.fieldByname(mStr).AsString;
        dmStk.btGSCAT.IndexName:=mIndex;
      end;
    end;
  end;
  If Assigned (eBeforePost) then eBeforePost (DataSet);
end;

procedure TNexPxTable.MyAfterInsert (DataSet: TDataSet);
begin
  If not oInsEnab then Cancel;
end;

function  TNexPxTable.GetActive:boolean;
begin
  Result:=inherited Active;
end;

procedure TNexPxTable.SetActive (Value:boolean);
begin
  If not inherited Active and Value then begin
    Open;
  end else begin
    If inherited Active and not Value then Close;
  end;
end;

function  TNexPxTable.GetFldType (pFldName,pFldTypeS:string;var pFldType:TFieldType;var pFldSize:longint):boolean;
begin
  Result:=FALSE;
  If pFldTypeS<>'' then begin
    pFldType:=ftUnknown;
    pFldSize:=0;
    pFldTypeS:=UpString (pFldTypeS);
    If (pFldTypeS='LONGINT') or (pFldTypeS='WORD') or (pFldTypeS='BYTE')
                                  then pFldType:=ftInteger;
    If (pFldTypeS='DOUBLE')       then pFldType:=ftFloat;
    If (pFldTypeS='DATETYPE')     then pFldType:=ftDate;
    If (pFldTypeS='TIMETYPE')     then pFldType:=ftTime;
    If (pFldTypeS='MEMO')         then pFldType:=ftMemo;
    If (pFldTypeS='BLOB')         then pFldType:=ftBlob;
    If (pFldTypeS='BOOLEAN')      then pFldType:=ftBoolean;
    If (pFldTypeS='GRAPHIC')      then pFldType:=ftGraphic;
    If (pFldTypeS='DATETIMETYPE') then pFldType:=ftDateTime;
    If (pFldTypeS='CHAR') then begin
      pFldType:=ftString;
      pFldSize:=0;
    end;
    If (Copy (pFldTypeS,1,3)='STR') then begin
      pFldType:=ftString;
      pFldSize:=ValInt (Copy (pFldTypeS,4,Length (pFldTypeS)));
    end;
    Result:=(pFldType<>ftUnknown);
    If not Result then ShowMsg (190002,DatabaseName+TableName+'  '+pFldName+pFldTypeS); //Nespr·vn˝ typ pola
  end;
end;

function  TNexPxTable.GetIndOption (pIndex,pIndTypeS:string;var pIndName,pIndFields:string;var pIndType:TIndexOptions):boolean;
begin
  Result:=FALSE;
  If (pIndex<>'') and (pIndTypeS<>'') then begin
    pIndName:=RemLeftSpaces (RemRightSpaces (Copy (pIndex,Pos ('=',pIndex)+1,Length (pIndex))));
    pIndFields:=RemLeftSpaces (RemRightSpaces (Copy (pIndex,1,Pos ('=',pIndex)-1)));
    pIndType:=[];
    pIndTypeS:=UpString (pIndTypeS);
    If Pos ('CDUPLIC',pIndTypeS)=0 then pIndType:=pIndType+[ixPrimary];
    If Pos ('CDESCEND',pIndTypeS)>0 then pIndType:=pIndType+[ixDescending];
    If Pos ('CINSENSIT',pIndTypeS)>0 then pIndType:=pIndType+[ixCaseInsensitive];
    Result:=TRUE;
//    If not Result then ShowMsg (190003,DatabaseName+TableName+'  '+pIndex+' - '+pIndTypeS); // Chybne definovany index
  end;
end;

constructor TNexPxTable.Create;
begin
  inherited Create (pOwner);
  inherited BeforePost:=MyBeforePost;
  inherited AfterInsert:=MyAfterInsert;

  oInsEnab:=TRUE;
  oAutoCreate:=TRUE;
  oAutoDelete:=TRUE;
  oAutoTableName:=TRUE;              
  oGPathRead:=TRUE;
  oSwapNum:=0;
end;

procedure TNexPxTable.InternalCreateTable;
var mCnt:longint;
begin
  If oAutoTableName and (oFixName<>'') then begin
    mCnt:=1;
    Repeat
      TableName:=oFixName+StrIntZero (mCnt,2);
      If FileExistsI(DatabaseName+TableName+'.DB') then begin
        If not FileInUse(DatabaseName+TableName+'.DB') then begin
          try
            DeleteTable;
          except end;
        end;
      end;
      Inc (mCnt);
    until not FileExistsI(DatabaseName+TableName+'.DB');
  end;
  CreateTableInDef;
  oSwapNum:=0;
end;

procedure TNexPxTable.Open;
begin
  If Active then Close;
  If oGPathRead then begin
    DatabaseName:= gPath.SubPrivPath;
    DEFPath:=gPath.DefPath;
    If oAutoTableName then TableName:=oFixName+'01';
  end;
  If not FileExistsI(DatabaseName+TableName+'.DB') then begin // Ak neexistuje a je zapnute automatcike vytovrenie potom vyrvorime databazu
    If oAutoCreate then InternalCreateTable;
  end
  else begin  // Ak existuje subor
    If oAutoDelete and oAutoCreate then InternalCreateTable;
  end;

  oSwapNum:=0;
  inherited Open;
end;

procedure TNexPxTable.Close;
begin
  inherited Close;
  If oAutoDelete then begin
    If Exists then try DeleteTable except end;
  end;
end;

procedure TNexPxTable.CreateTableInDef;
var
  mT:TextFile;
  mS:string;
  mInd:boolean;
  mFldName:string;
  mFldTypeS:string;
  mFldType:TFieldType;
  mFldSize:longint;
  mIndexS:string;
  mIndName:string;
  mIndFields:string;
  mIndType:TIndexOptions;
  mTable:TTable;
begin
  If oDefName<>'' then begin
    If FileExistsI(oDefPath+oDefName) then begin
      FieldDefs.Clear;
      IndexDefs.Clear;
      AssignFile(mT, oDefPath+oDefName);
      Reset(mT);
      ReadLn (mT,mS);
      mInd:=FALSE;
      Repeat
        ReadLn (mT,mS);
        If mS<>'' then begin
          If Pos ('IND ',UpString (mS))=1
            then mInd:=TRUE
            else begin
              If Pos (';',mS)>0 then System.Delete (mS,Pos (';',mS),Length (mS));
              If Pos (' ',mS)>0 then begin
                mFldName:=RemLeftSpaces (RemRightSpaces (Copy (mS,1,Pos (' ',mS)-1)));
                mFldTypeS:=RemLeftSpaces (RemRightSpaces (Copy (mS,Pos (' ',mS)+1,Length (mS))));
                If GetFldType (mFldName,mFldTypeS,mFldType,mFldSize) then FieldDefs.Add(mFldName,mFldType,mFldSize,FALSE);
              end;
            end;
        end;
      until System.EOF (mT) or mInd;
      If mInd then begin
        Repeat
          If mS<>'' then begin
            If Pos (';',mS)>0 then System.Delete (mS,Pos (';',mS),Length (mS));
            If Pos (',',mS)>0 then mS:=ReplaceStr (mS, ',', ';');
            If Pos ('IND ',UpString (mS))=1 then begin
              System.Delete (mS,1,4);
              If (Pos ('=',mS)>0) then begin
                mIndexS:=mS;
                mS:='';
                If not System.EOF (mT) then ReadLn (mT,mS);
                If GetIndOption (mIndexS,mS,mIndName,mIndFields,mIndType) then IndexDefs.Add (mIndName,mIndFields,mIndType);
              end;
            end;
          end;
          If not System.EOF (mT) then ReadLn (mT,mS);
        until System.EOF (mT);
      end;
      CloseFile (mT);
      If (FieldDefs.Count>0) and (IndexDefs.Count>0) then begin
        mTable:=TTable.Create(Self);
        mTable.DatabaseName:= DatabaseName;
        mTable.TableName:=TableName;
        mTable.TableType:=TableType;
        mTable.FieldDefs.Assign (FieldDefs);
        mTable.IndexDefs.Assign(IndexDefs);
        try 
          mTable.CreateTable;
        except end;
        If not mTable.Exists then begin
          try mTable.CreateTable; except end;
        end;
        FreeAndNil (mTable);
//        try
//          CreateTable;
//        except end;
      end;
    end else begin
      ShowMsg (190001, oDefPath+oDefName);  { Neexistujuci definicny subor }
    end;
  end;
end;

procedure TNexPxTable.DelRecs;
var I,J:integer;
begin
  If Active then begin
    J:=RecordCount;
    First;
    For I:=1 to J do Delete;
  end else Open;
end;

procedure TNexPxTable.SwapIndex;
begin
  oIndexName:=IndexName;
end;

procedure TNexPxTable.RestoreIndex;
begin
  If oIndexName<>IndexName then IndexName:=oIndexName;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TNexPxTable]);
end;

initialization
  Classes.RegisterClass(TNexPxTable);
finalization
  Classes.UnRegisterClass(TNexPxTable);

end.
