unit NexTmpTable;

interface

uses
  IcTypes, IcConv, IcFiles, BtrTable, NexPath, NexMsg, IcTools,CntWin,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db;

type
  TFiltStrArray=Array [1..100] of Str50;

  TNexTmpTable = class(TBtrieveTable)
    BT_MAINTABLE: TBtrieveTable;
  private
    oOwner: TComponent;
    oTableName: Str12;
    function GetTmpTableName: Str12;
  public
    constructor Create(pOwner: TComponent); override;
    procedure   LoadItems    (pKeyNum:integer; const pKeyNames,pKeyValues: array of const);
    procedure   LoadItemsM   (pKeyNum:integer; const pEqNames,pEqValues,pKeyNames,pKeyValues: array of const);
    procedure   LoadItemsFilt(pKeyNum:byte;pFilt: TFiltStrArray;pNum:byte);
    procedure   Open; overload;
    procedure   Close; overload;
    procedure   Insert; overload;
    procedure   Edit; overload;
    procedure   Post; overload;
    procedure   Delete; overload;
    procedure   SetKeyNum(pKeyNum:smallint); overload;
  published
    { Published declarations }
  end;

  PROCEDURE   CalcFilterCond(var pFilt;pNum:byte;var pFilter:TFiltCondArray;var pFiltFlds:string);
  procedure   CleargFilt;

  procedure Register;

var
  gFilt: TFiltStrArray;

implementation

uses DM_SYSTEM;

  PROCEDURE  CleargFilt;
    BEGIN
      FillChar (gFilt,SizeOf (gFilt),#0);
    END;     { *** CleargFilt *** }

  PROCEDURE  CalcFilterCond(var pFilt;pNum:byte;var pFilter:TFiltCondArray;var pFiltFlds:string);
    var
      mFilt        : Array [1..100] of Str50 absolute pFilt;
      mRel         : Str2;
      mStr1,mStr2  : Str50;
      mBeg,mEnd,I,J: byte;
    BEGIN
      FillChar (pFilter,SizeOf(TFiltCondArray),#0);
      I:=0;J:=0;
      While(I < pNum)do begin
        Inc (I);
        If mFilt[i] <> '' then begin
          mStr2 := mFilt [i];
          repeat
            Inc (J);
            If  (Pos ('^',mStr2)<>0)and(Pos ('@',mStr2)<>0) then begin
              If Pos ('^',mStr2)<Pos ('@',mStr2) then pFilter[J].Next:=1
                                                 else pFilter[J].Next:=2;
            end else begin
              If (Pos ('^',mStr2)=0)and(Pos ('@',mStr2)=0)
              then pFilter[J].Next:=0
              else begin
                If Pos ('^',mStr2)>0 then pFilter[J].Next:=1
                                         else pFilter[J].Next:=2;
              end;
            end;
            If pFilter[J].Next > 0 then begin
              If pFilter[J].Next=1 then begin
                mStr1:= Copy (mStr2,1,Pos ('^',mStr2)-1);
                mStr2:= Copy (mStr2,Pos ('^',mStr2)+1,Length (mStr2));
              end else begin
                mStr1:= Copy (mStr2,1,Pos ('@',mStr2)-1);
                mStr2:= Copy (mStr2,Pos ('@',mStr2)+1,Length (mStr2));
              end;
            end else begin
              mStr1:=mStr2;
              mStr2:='';
              pFilter[J].Next:=1;
            end;

            mBeg:=Pos ('[',mStr1);mEnd:=Pos (']',mStr1);
            pFilter[J].Cond:=I;
            pFilter[J].Fld1:=Valint (Copy (mStr1,mBeg+1,mEnd-mBeg-1));
            Delete (mStr1,mBeg,mEnd-mBeg+1);
            If Pos ('[',mStr1) > 0 then begin
              pFilter[J].Fldc:=TRUE;
              mBeg:=Pos ('[',mStr1);mEnd:=Pos (']',mStr1);
              pFilter[J].Fld2:=Valint (Copy (mStr1,mBeg+1,mEnd-mBeg-1));
            end else begin
              pFilter[J].Fldc:=FALSE;
              mBeg:=Pos ('{',mStr1);mEnd:=Pos ('}',mStr1);
              pFilter[J].Val:=Copy (mStr1,mBeg+1,mEnd-mBeg-1);
            end;
            mRel:=Copy (mStr1,1,mBeg-1);
            pFilter[J].Rel:=0; // mRel = '='
            If mRel = '>'  then pFilter[J].Rel:=1;
            If mRel = '<'  then pFilter[J].Rel:=2;
            If mRel = '>=' then pFilter[J].Rel:=3;
            If mRel = '<=' then pFilter[J].Rel:=4;
            If mRel = '<>' then pFilter[J].Rel:=5;
          until (mStr2='')and(Pos ('^',mStr2)=0)and(Pos ('@',mStr2)=0);
        end; // mFilt[I] <> ''
      end; // while I < pNum
      pFiltFldS:='';                // ICtools NexTmpTable strint
      for I:=1 to J do begin
        If not pFilter[I].FldC and (LineElementPos (pFiltFldS,StrInt(pFilter[I].Fld1,0),';')=-1)
        then begin
          pFiltFlds:=pFiltFlds+';'+StrInt(pFilter[I].Fld1,0);
          If pFiltFlds[1]=';' then Delete (pFiltFlds,1,1);
        end;
      end;
    END;     { *** CalcFilterStr *** }

constructor TNexTmpTable.Create;
begin
  inherited Create (pOwner);
  AutoCreate := TRUE;
  oOwner := pOwner;
end;

function TNexTmpTable.GetTmpTableName: Str12;
var mTableName: Str12;  mCnt:byte;
    mNotExists: boolean;
begin
  mCnt := 0;
  Repeat
    Inc (mCnt);
    mTableName := oTableName+'.$'+StrIntZero(mCnt,2);
    mNotExists := not FileExistsI (DatabaseName+mTableName);
  until mNotExists or (mCnt=99);
  If mNotExists then begin
    Result := mTableName;
  end
  else begin
    ShowMsg (10,'');
    Result := oTableName+'.$$$';
  end;
end;

procedure TNexTmpTable.LoadItems;
 function  EqualFields (const pKeyNames,pKeyValues: array of const): boolean;
 var mNoEqual:boolean; I:byte;
     mKeyName:string; mKeyValue:string;
 begin
   mNoEqual := FALSE;      {Btrtable}
   For I:=0 to High(pKeyNames) do begin
     mKeyName := string(pKeyNames[I].VVariant);
//     mKeyValue := string(pKeyValues[I].VVariant);
//   EK 12-10-2000   
     with pKeyValues[i] do begin
       case VType of
         vtInteger:    mKeyValue:= IntToStr(VInteger);
//         vtBoolean:    mKeyValue:= BoolChars[VBoolean];
         vtChar:       mKeyValue:= VChar;
         vtExtended:   mKeyValue:= FloatToStr(VExtended^);
         vtString:     mKeyValue:= VString^;
         vtPChar:      mKeyValue:= VPChar;
         vtObject:     mKeyValue:= VObject.ClassName;
         vtClass:      mKeyValue:= VClass.ClassName;
         vtAnsiString: mKeyValue:= string(VAnsiString);
         vtCurrency:   mKeyValue:= CurrToStr(VCurrency^);
         vtVariant:    mKeyValue:= string(VVariant^);
         vtInt64:      mKeyValue:= IntToStr(VInt64^);
       end;
     end;
     If BT_MAINTABLE.FieldByName(mKeyName).AsString<>mKeyValue then mNoEqual := TRUE;
   end;
   Result := not mNoEqual;
 end;

var mItmNumFieldExist: boolean;
    mNullItmNumExist: boolean;  I:longint;
    mActPos: ^longint;  mList: TList;
begin
  mItmNumFieldExist := BT_MAINTABLE.FindField('ItmNum')<>Nil;
  mNullItmNumExist := FALSE;
  mList := TList.Create;
  BT_MAINTABLE.SetKeyNum (pKeyNum);
  BT_MAINTABLE.FindNearest (pKeyValues);
  While not (BT_MAINTABLE.Eof) and EqualFields(pKeyNames,pKeyValues) do begin
    inherited Insert;
    Move (BT_MAINTABLE.ActiveBuffer[0],ActiveBuffer[0],BT_MAINTABLE.RecordSize);
    FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
    inherited Post;
    If mItmNumFieldExist then begin
      New (mActPos);
      mActPos^ := ActPos;
      mList.Add (mActPos);
      If BT_MAINTABLE.FieldByName ('ItmNum').AsInteger=0 then mNullItmNumExist := True;
    end;
    BT_MAINTABLE.Next;
  end;
  If (RecordCount>0) and mNullItmNumExist then begin // Precislujeme polozky
    For I:=0 to mList.Count-1 do begin
      mActPos := mList.Items[I];
      GotoPos (mActPos^);
      Edit;
      FieldByName ('ItmNum').AsInteger := I+1;
      Post;
    end;
  end;
  If (RecordCount>0) and mItmNumFieldExist then begin
    For I:=0 to mList.Count-1 do begin
      mActPos := mList.Items[I];
      Dispose (mActPos);
    end;
  end;
  mList.Free;
end;

procedure TNexTmpTable.LoadItemsM;
 function  EqualFields (const pKeyNames,pKeyValues: array of const): boolean;
 var mNoEqual:boolean; I:byte;
     mKeyName:string; mKeyValue:string;
 begin
   mNoEqual := FALSE;      {Btrtable}
   For I:=0 to High(pKeyNames) do begin
     mKeyName := string(pKeyNames[I].VVariant);
//     mKeyValue := string(pKeyValues[I].VVariant);
//   EK 12-10-2000
     with pKeyValues[i] do begin
       case VType of
         vtInteger:    mKeyValue:= IntToStr(VInteger);
//         vtBoolean:    mKeyValue:= BoolChars[VBoolean];
         vtChar:       mKeyValue:= VChar;
         vtExtended:   mKeyValue:= FloatToStr(VExtended^);
         vtString:     mKeyValue:= VString^;
         vtPChar:      mKeyValue:= VPChar;
         vtObject:     mKeyValue:= VObject.ClassName;
         vtClass:      mKeyValue:= VClass.ClassName;
         vtAnsiString: mKeyValue:= string(VAnsiString);
         vtCurrency:   mKeyValue:= CurrToStr(VCurrency^);
         vtVariant:    mKeyValue:= string(VVariant^);
         vtInt64:      mKeyValue:= IntToStr(VInt64^);
       end;
     end;

     If BT_MAINTABLE.FieldByName(mKeyName).AsString<>mKeyValue then mNoEqual := TRUE;
   end;
   Result := not mNoEqual;
 end;

var mItmNumFieldExist: boolean;
    mNullItmNumExist: boolean;  I:longint;
    mActPos: ^longint;  mList: TList;
begin
  mItmNumFieldExist := BT_MAINTABLE.FindField('ItmNum')<>Nil;
  mNullItmNumExist := FALSE;
  mList := TList.Create;
  BT_MAINTABLE.SetKeyNum (pKeyNum);
  BT_MAINTABLE.FindNearest (pKeyValues);
  While not (BT_MAINTABLE.Eof) and EqualFields(pKeyNames,pKeyValues) do begin
    If EqualFields(pEqNames,pEqValues) then begin
      inherited Insert;
      Move (BT_MAINTABLE.ActiveBuffer[0],ActiveBuffer[0],BT_MAINTABLE.RecordSize);
      FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
      inherited Post;
      If mItmNumFieldExist then begin
        New (mActPos);
        mActPos^ := ActPos;
        mList.Add (mActPos);
        If BT_MAINTABLE.FieldByName ('ItmNum').AsInteger=0 then mNullItmNumExist := True;
      end;
    end;
    BT_MAINTABLE.Next;
  end;
  If (RecordCount>0) and mNullItmNumExist then begin // Precislujeme polozky
    For I:=0 to mList.Count-1 do begin
      mActPos := mList.Items[I];
      GotoPos (mActPos^);
      Edit;
      FieldByName ('ItmNum').AsInteger := I+1;
      Post;
    end;
  end;
  If (RecordCount>0) and mItmNumFieldExist then begin
    For I:=0 to mList.Count-1 do begin
      mActPos := mList.Items[I];
      Dispose (mActPos);
    end;
  end;
  mList.Free;
end;

procedure TNexTmpTable.LoadItemsFilt;
var mSetInd : boolean;
begin
  F_CntWinF:=TF_CntWinF.Create(Self);
  CalcFilterCond(pFilt,pNum,BT_MAINTABLE.oFilterCond,BT_MAINTABLE.oFiltCondFldS);
  mSetInd:=BT_MAINTABLE.SetFiltInd(pKeyNum);
  BT_MAINTABLE.First;
  F_CntWinF.Execute(BT_MAINTABLE.RecordCount,'Filter');
  If mSetInd then BT_MAINTABLE.FirstFiltInd;
  While not BT_MAINTABLE.EOF and (not mSetInd or(mSetInd and BT_MAINTABLE.IsInFiltInd)) do begin
    F_CntWinF.RefCnt;
    If BT_MAINTABLE.CheckFiltRec then begin
      inherited Insert;
      Move (BT_MAINTABLE.ActiveBuffer[0],ActiveBuffer[0],BT_MAINTABLE.RecordSize);
      FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
      inherited Post;
    end;
    BT_MAINTABLE.Next;
  end;
  FreeAndNIL(F_CntWinF);
end;

procedure TNexTmpTable.Open;
var mPos: byte;
begin
  mPos := Pos('.',TableName);
  If mPos>0
    then oTableName := copy(TableName,1,mPos-1)
    else oTableName := TableName;
  DataBaseName := gPath.SubPrivPath;
  DEFPath := gPath.DefPath;
  TableName := GetTmpTableName;
  CreateTable;
  inherited Open;

  BT_MAINTABLE := TBtrieveTable.Create (Self);
  If oOwner.Name='dmSYS'  then BT_MAINTABLE.DataBaseName := gPath.SysPath;
  If oOwner.Name='dmDLS'  then BT_MAINTABLE.DataBaseName := gPath.DlsPath;
  If oOwner.Name='dmPDP'  then BT_MAINTABLE.DataBaseName := gPath.PdpPath;
  If oOwner.Name='dmTPDP' then BT_MAINTABLE.DataBaseName := gPath.PdpPath;
  If oOwner.Name='dmLDG'  then BT_MAINTABLE.DataBaseName := gPath.LdgPath;
  If oOwner.Name='dmSTK'  then BT_MAINTABLE.DataBaseName := gPath.StkPath;
  BT_MAINTABLE.DEFPath := gPath.DefPath;
  BT_MAINTABLE.TableName := oTableName;
  BT_MAINTABLE.AutoCreate := TRUE;
  BT_MAINTABLE.Open;
end;

procedure TNexTmpTable.Close;
begin
  inherited Close;
  DeleteFile (DataBaseName+TableName);

  BT_MAINTABLE.Close;
  BT_MAINTABLE.Free;
end;

procedure TNexTmpTable.Insert;
begin
  inherited Insert;
  BT_MAINTABLE.Insert;
end;

procedure TNexTmpTable.Edit;
begin
  inherited Edit;
  BT_MAINTABLE.GotoPos (FieldByName('ActPos').AsInteger);
  BT_MAINTABLE.Edit;
end;

procedure TNexTmpTable.Post;
begin
  Move (ActiveBuffer[0], BT_MAINTABLE.ActiveBuffer[0],RecordSize);
  BT_MAINTABLE.Post;
  FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
  inherited Post;
end;

procedure TNexTmpTable.Delete;
begin
  BT_MAINTABLE.GotoPos (FieldByName('ActPos').AsInteger);
  BT_MAINTABLE.Delete;
  inherited Delete;
end;

procedure TNexTmpTable.SetKeyNum(pKeyNum:smallint);
begin
  inherited SetKeyNum (pKeyNum);
  BT_MAINTABLE.SetKeyNum (pKeyNum);
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TNexTmpTable]);
end;

end.
