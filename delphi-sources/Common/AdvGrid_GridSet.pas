unit AdvGrid_GridSet;

interface

uses
   BtrTable,
   IcConv, IcTools, TxtWrap, TxtCut,
   DB, IniFiles, Classes, SysUtils;

const
  cDefType  = '.DGD';
  cUserType = '.UGD';
  cHideFld  = ';CrtName;CrtDate;ModName;ModDate;ImpName;ImpDate;Note;';

type
  TGridSet = class
    oSetList : TStringList;
    oSetGrid : TStringList;
    oDefGrid : TStringList;
    oColorGrp: TStringList;
    oFile    : TIniFile;
  private
    oDGDName : string;

    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create;
    destructor  Destroy; override;
    procedure   SetDGDName (Value:string);

    procedure  ReadList (pOnlyUserSet,pServiceMode:boolean);
    function   GetListItCount:integer;
    function   GetListItName (pIt:integer):string;
    function   GetListItText (pIt:integer):string;
    procedure  AddToList (pNewItem:string);
    procedure  ModifyInList (pService:boolean;pIt,pVal:string);

    function   LoadSet (pSection:string):boolean;
    function   GetGridItCount:integer;
    function   GetGridItName (pIt:integer):string;
    function   GetGridItText (pIt:integer):string;
    procedure  GetGridFieldParam(I:integer;var pFld,pDispLabel,pAlign,pDispFormat:string;var pFldNum,pDispWidth:integer;var pReadOnly:boolean;var pFullName:string);
    function   VerifyListItName (pSection:string):boolean;

    procedure  SaveGridSet (pSection:string);

    procedure  DeleteGridSet (pSection:string);

    function   DefaultExists:boolean;
    procedure  CreateDefaultGridSet (pDataSet:TDataSet);
    procedure  ReadDefaultInDataSet (pDataSet:TDataSet;pOnlyRefresh:boolean);
    function   FindFieldInDefGrid (pFld:string;var pIndex:longint):boolean;
    function   FindGridFieldInDataSet (pDataSet:TDataSet;pFld:string):boolean;
    procedure  ReadDefault;
    procedure  SaveDefault;

    function   VerifyD01:boolean;
    function   D01Exists:boolean;

    function   GetNewSection (pService:boolean):string;

    function   LoadColorGrp (pGrpNum:string):boolean;
  published
    { Published declarations }
  end;


implementation

constructor TGridSet.Create;
begin
  oSetList := TStringList.Create;
  oSetGrid := TStringList.Create;
  oDefGrid := TStringList.Create;
  oColorGrp := TStringList.Create;
end;

destructor TGridSet.Destroy;
begin
  oColorGrp.Free;
  oDefGrid.Free;
  oSetGrid.Free;
  oSetList.Free;
end;

procedure   TGridSet.SetDGDName (Value:string);
begin
  oDGDName := Value;
end;

procedure TGridSet.ReadList (pOnlyUserSet,pServiceMode:boolean);
var mS:string; I: integer;
  mSList:TStringList;
begin
  oSetList.Clear;
  mSList := TStringList.Create;
  If oDGDName<>'' then begin
    mSList.Clear;
    oFile := TIniFile.Create (oDGDName+cUserType);
    oFile.ReadSectionValues ('NAMES',mSList);
    oFile.Free;
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        If pServiceMode then begin
          oSetList.Add (mSList[I]);
        end else begin
          oFile := TIniFile.Create (oDGDName+cUserType);
          mS := Copy (mSList[I],1,3);
          If not oFile.ReadBool(mS,'ServiceOnly',FALSE) then oSetList.Add (mSList[I]);
          oFile.Free;
        end;
      end;
    end;
    If not pOnlyUserSet or (oSetList.Count=0) then begin
      mSList.Clear;
      oFile := TIniFile.Create (oDGDName+cDefType);
      oFile.ReadSectionValues ('NAMES',mSList);
      oFile.Free;
      If mSList.Count>0 then begin
        For I:=0 to mSList.Count-1 do begin
          If pServiceMode then begin
            oSetList.Add (mSList[I]);
          end else begin
            oFile := TIniFile.Create (oDGDName+cDefType);
            mS := Copy (mSList[I],1,3);
            If not oFile.ReadBool(mS,'ServiceOnly',FALSE) then oSetList.Add (mSList[I]);
            oFile.Free;
          end;
        end;
      end;
    end;
  end;
  mSList.Free;
end;

function  TGridSet.GetListItCount:integer;
begin
  Result := oSetList.Count;
end;

function  TGridSet.GetListItText (pIt:integer):string;
begin
  Result := '';
  If (pIt>=0) and (pIt<oSetList.Count) then Result := Copy (oSetList[pIt],Pos ('=',oSetList[pIt])+1,Length (oSetList[pIt]));
end;

function  TGridSet.GetListItName (pIt:integer):string;
begin
  Result := '';
  If oSetList<> nil then begin
    If (pIt>=0) and (pIt<oSetList.Count) then Result := Copy (oSetList[pIt],1,Pos ('=',oSetList[pIt])-1);
  end;
end;

procedure TGridSet.AddToList (pNewItem:string);
var
  I:integer;
  mIdent:string;
  mValue:string;
begin
  If pNewItem[1]='D'
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  oSetList.Clear;
  oFile.ReadSectionValues ('NAMES',oSetList);
  oSetList.Add (pNewItem);
  oSetList.Sort;
  oFile.EraseSection ('NAMES');
  For I:=0 to oSetList.Count-1 do begin
    mIdent := Copy (oSetList.Strings[I],1,Pos ('=',oSetList.Strings[I])-1);
    mValue := Copy (oSetList.Strings[I],Pos ('=',oSetList.Strings[I])+1,Length (oSetList.Strings[I]));
    oFile.WriteString ('NAMES', mIdent, mValue);
  end;
  oFile.Free;
end;

procedure TGridSet.ModifyInList (pService:boolean;pIt,pVal:string);
var
  I:integer;
  mNum:integer;
  mS:string;
  mOK:boolean;
begin
  SetDGDName (oDGDName);
  oSetList.Clear;
  If Copy (pIt,1,1)='D'
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  oFile.WriteString ('NAMES',pIt,pVal);
  oFile.Free;
end;

function  TGridSet.LoadSet (pSection:string):boolean;
begin
  If pSection<>'' then begin
    oSetGrid.Clear;
    Result := FALSE;
    If pSection[1]='D'
      then oFile := TIniFile.Create (oDGDName+cDefType)
      else oFile := TIniFile.Create (oDGDName+cUserType);
    If oFile.SectionExists (pSection) then begin
      oFile.ReadSectionValues (pSection,oSetGrid);
      If oSetGrid.Count>0 then Result := TRUE;
    end;
    oFile.Free;
  end;
end;

function  TGridSet.GetGridItCount:integer;
begin
  Result := oSetGrid.Count;
end;

function  TGridSet.GetGridItName (pIt:integer):string;
begin
  Result := '';
  If (pIt>=0) and (pIt<oSetGrid.Count) then Result := Copy (oSetGrid[pIt],1,Pos ('=',oSetGrid[pIt])-1);
end;

function  TGridSet.GetGridItText (pIt:integer):string;
begin
  Result := '';
  If (pIt>=0) and (pIt<oSetGrid.Count) then Result := Copy (oSetGrid[pIt],Pos ('=',oSetGrid[pIt])+1,Length (oSetGrid[pIt]));
end;

procedure  TGridSet.GetGridFieldParam(I:integer;var pFld,pDispLabel,pAlign,pDispFormat:string;var pFldNum,pDispWidth:integer;var pReadOnly:boolean;var pFullName:string);
var
  mS:string;
  mNum:string;
begin
  mS := GetGridItText (I);
  mNum := GetGridItName (I);
  Delete (mNum,1,Length ('FIELD'));
  mNum := RemRightSpaces (RemLeftSpaces (mNum));
  pFldNum := ValInt (mNum);
  pFld := LineElement (mS,0,',');
  pDispLabel := LineElement (mS,1,',');
  pDispWidth := ValInt (LineElement (mS,2,','));
  pAlign := LineElement (mS,3,',');
  pDispFormat := LineElement (mS,4,',');
  pReadOnly := not (UpString (LineElement (mS,5,','))='FALSE');
  pFullName := LineElement (mS,6,',');
end;

function   TGridSet.VerifyListItName (pSection:string):boolean;
var
  I:integer;
  mSList:TStringList;
begin
  Result := FALSE;
  mSList := TStringList.Create;
  If pSection[1]='D'
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  mSList.Clear;
  If oFile.SectionExists (pSection) then begin
    oFile.ReadSectionValues (pSection,mSList);
    If mSList.Count>0 then begin
      I := 0;
      While (I<mSList.Count-1) and not Result do begin
        Result := (Pos ('FIELD',UpString (mSList.Strings[I]))=1);
        Inc (I);
      end;
    end;
  end;
  oFile.Free;
  mSList.Free;
end;

procedure  TGridSet.SaveGridSet (pSection:string);
var
  I:integer;
  mIdent:string;
  mVal:string;
begin
  If pSection='' then pSection := 'D01';
  If pSection[1]='D'
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  oFile.EraseSection(pSection);
  If oSetGrid.Count>0 then begin
    For I:=0 to oSetGrid.Count-1 do begin
      mIdent := Copy (oSetGrid.Strings[I],1,Pos ('=',oSetGrid.Strings[I])-1);
      mVal := Copy (oSetGrid.Strings[I],Pos ('=',oSetGrid.Strings[I])+1,Length (oSetGrid.Strings[I]));
      oFile.WriteString (pSection,mIdent,mVal);
    end;
  end;
  oFile.Free;
end;

procedure  TGridSet.DeleteGridSet (pSection:string);
begin
  If pSection[1]='D'
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  oFile.EraseSection(pSection);
  oFile.DeleteKey ('NAMES',pSection);
  oFile.Free;
end;

function   TGridSet.DefaultExists:boolean;
begin
  oFile := TIniFile.Create (oDGDName+cDefType);
  Result := oFile.SectionExists ('DEFAULT');
  oFile.Free;
end;

procedure  TGridSet.CreateDefaultGridSet (pDataSet:TDataSet);
var
  I:integer;
  mFld:string;
  mWidth:integer;
  mAlignment:string;
  mReadOnly:string;
  mDisplayFormat:string;
  mFullName:string;
  mFontSize:integer;
  mIni:TIniFile;
begin
  If pDataSet<>nil then begin
    pDataSet.FieldDefs.Clear;
    pDataSet.FieldDefs.Updated := FALSE;
    pDataSet.FieldDefs.Update;
    If pDataSet.FieldCount>0 then begin
      oSetGrid.Clear;
      mFontSize := 7;
      mIni := TIniFile.Create(ExtractFilePath(oDGDName)+'FLDS.TXT');
      For I:=0 to pDataSet.FieldCount-1 do begin
        mFld := pDataSet.FieldDefs.Items[I].Name;
        mWidth := pDataSet.Fields[I].DisplayWidth*mFontSize;
        mAlignment := 'L';
        mDisplayFormat := '';
        If pDataset is TBtrieveTable
          then mFullName := (pDataset as TBtrieveTable).oFieldFullName[i]
          else mFullName := pDataset.Fields[I].FullName;
        mFullName := ReplaceStr(mFullName,',','.');
        mReadOnly := 'FALSE';
        case pDataSet.Fields[I].DataType of
          ftString: mWidth := pDataSet.Fields[I].DataSize*mFontSize;
          ftFloat, ftCurrency: begin mWidth := 12*mFontSize; mAlignment := 'R'; mDisplayFormat := '### ### ##0.00'; end;
          ftDate: begin mWidth := 10*mFontSize; mAlignment := 'R'; end;
          ftTime: begin mWidth := 8*mFontSize; mAlignment := 'R'; end;
          ftDateTime: begin mWidth := 17*mFontSize; mAlignment := 'R'; end;
          ftInteger, ftWord: begin mWidth := 6*mFontSize; mAlignment := 'R'; end;
        end;
        If mIni.ValueExists('Fields',mFld) then begin
          oSetGrid.Add ('Field'+StrInt (I,0)+'='+mFld+','+mIni.ReadString('Fields',mFld,''));
        end else begin
          oSetGrid.Add ('Field'+StrInt (I,0)+'='+mFld
            +','+mFld+','+StrInt (mWidth,0)
            +','+mAlignment+','+mDisplayFormat+','+mReadOnly+','+mFullName);
        end;
      end;
      FreeAndNil (mIni);
    end;
     SaveGridSet ('DEFAULT');
  end;
end;

procedure  TGridSet.ReadDefaultInDataSet (pDataSet:TDataSet;pOnlyRefresh:boolean);
var
  I,mIndex:integer;
  mFld,mStr,mData:string;
  mWidth:integer;
  mAlignment:string;
  mReadOnly:string;
  mDispName,mDisplayFormat:string;
  mFullName:string;
  mFontSize:integer;
  mFlds:string;
  mIni:TIniFile;
  mFind,mChange:boolean;
begin
  If pDataSet<>nil then begin
    pDataSet.FieldDefs.Clear;
    pDataSet.FieldDefs.Updated := FALSE;
    pDataSet.FieldDefs.Update;
    If pDataSet.FieldCount>0 then begin
      ReadDefault;
      mFontSize := 7;
      mIni := TIniFile.Create(ExtractFilePath(oDGDName)+'FLDS.TXT');
      For I:=0 to pDataSet.FieldCount-1 do begin
        mFld := pDataSet.FieldDefs.Items[I].Name;
        If pDataset is TBtrieveTable
          then mFullName  := (pDataSet as TBtrieveTable).oFieldFullName[I]
          else mFullName  := pDataSet.FieldByName(mFld).FullName;
        mFullName := ReplaceStr(mFullName,',','.');
        mFind := FindFieldInDefGrid (mFld,mIndex);
        mChange := TRUE;
        If mFind then begin
          mStr := oDefGrid.Strings[mIndex];
          mChange := (LineElement (mStr,0,',')=LineElement (mStr,1,',')) or (LineElement (mStr,6,',')<>mFullName);
        end;
        If mChange then begin
          If mFind then begin
            mDispName := LineElement (mStr,1,',');
            If mFld=mDispName then begin
              If mIni.ValueExists('Fields',mFld) then begin
                mDispName := LineElement (mIni.ReadString('Fields',mFld,''),0,',');
              end;
            end;
            mWidth := ValInt (LineElement (mStr,2,','));
            mAlignment := LineElement (mStr,3,',');
            mDisplayFormat := LineElement (mStr,4,',');
            mReadOnly := LineElement (mStr,5,',');
            mData := mFld+','+mDispName+','+StrInt (mWidth,0)+','+mAlignment+','+mDisplayFormat+','+mReadOnly+','+mFullName;
          end else begin
            mWidth := pDataSet.FieldByName(mFld).DisplayWidth*mFontSize;
            mAlignment := 'L';
            mDisplayFormat := '';
            mReadOnly := 'FALSE';
            case pDataSet.FieldByName(mFld).DataType of
              ftString: mWidth := pDataSet.FieldByName(mFld).DataSize*mFontSize;
              ftFloat, ftCurrency: begin mWidth := 12*mFontSize; mAlignment := 'R'; mDisplayFormat := '### ### ##0.00'; end;
              ftDate: begin mWidth := 10*mFontSize; mAlignment := 'R'; end;
              ftTime: begin mWidth := 8*mFontSize; mAlignment := 'R'; end;
              ftDateTime: begin mWidth := 17*mFontSize; mAlignment := 'R'; end;
              ftInteger, ftWord: begin mWidth := 6*mFontSize; mAlignment := 'R'; end;
            end;
            If mIni.ValueExists('Fields',mFld) then begin
              mData := mFld+','+mIni.ReadString('Fields',mFld,'')+','+mFullName;
            end else begin
              mData := mFld+','+mFld+','+StrInt (mWidth,0)+','+mAlignment+','+mDisplayFormat+','+mReadOnly+','+mFullName;
            end;
          end;
          If mFind
            then oDefGrid.Strings[mIndex] := mData
            else oDefGrid.Add (mData);
        end;
      end;
      FreeAndNil (mIni);
      mFlds:='';
      For I:=0 to pDataSet.FieldCount-1 do begin
        mFlds:=mFlds+'|'+UpperCase(pDataSet.FieldDefs.Items[I].Name);
        If pDataSet.FieldDefs.Items[I].Name[1]='_'
          then mFlds:=mFlds+'|'+UpperCase(Copy(pDataSet.FieldDefs.Items[I].Name,2,Length(pDataSet.FieldDefs.Items[I].Name)-1))+'_';
        If pDataSet.FieldDefs.Items[I].Name[Length(pDataSet.FieldDefs.Items[I].Name)]='_'
          then mFlds:=mFlds+'|'+'_'+UpperCase(Copy(pDataSet.FieldDefs.Items[I].Name,1,Length(pDataSet.FieldDefs.Items[I].Name)-1));
      end;
      mFlds:=mFlds+'|';
      I:=0;
      Repeat
        mWidth:=Pos(',',oDefGrid.Strings[I]);
        mFld:=UpperCase(Copy(oDefGrid.Strings[I],1,mWidth-1));
        If POS('|'+mFld+'|',mFldS)=0 then begin
//        If not FindGridFieldInDataSet (pDataset,mFld) then begin
          oDefGrid.Delete(I);
        end else Inc(I);
      until I = oDefGrid.Count
    end;
  end;
end;

function   TGridSet.FindFieldInDefGrid (pFld:string;var pIndex:longint):boolean;
var I:longint;
begin
  Result := FALSE; pIndex := -1;
  If oDefGrid.Count>0 then begin
    I := 1;
    Repeat
      Result := Pos (UpString (pFld),UpString (oDefGrid.Strings[I-1]))=1;
      If Result then pIndex := I-1;
      Inc (I);
    until Result or (I>oDefGrid.Count);
  end;
end;

function   TGridSet.FindGridFieldInDataSet (pDataSet:TDataSet;pFld:string):boolean;
var I:longint;
begin
  Result := FALSE;
  If pDataSet.FieldCount>0 then begin
    I := 1;
    Repeat
      Result := pFld=pDataSet.FieldDefs.Items[I].Name;
      Inc (I);
    until Result or (I>=pDataSet.FieldCount);
  end;
end;

procedure  TGridSet.ReadDefault;
var
  I:integer;
  mOpen:boolean;
begin
  oDefGrid.Clear;
  oFile := TIniFile.Create (oDGDName+cDefType);
  oFile.ReadSectionValues ('DEFAULT',oDefGrid);
  oFile.Free;
  If oDefGrid.Count>0 then begin
    For I:=0 to oDefGrid.Count-1 do begin
      If Pos ('=',oDefGrid.Strings[I])>0 then oDefGrid.Strings[I] := Copy (oDefGrid.Strings[I],Pos ('=',oDefGrid.Strings[I])+1,Length (oDefGrid.Strings[I]));
    end;
  end;
end;

procedure  TGridSet.SaveDefault;
var
  I:integer;
  mIdent:string;
  mVal:string;
begin
  oFile := TIniFile.Create (oDGDName+cDefType);
  oFile.EraseSection('DEFAULT');
  If oDefGrid.Count>0 then begin
    For I:=0 to oDefGrid.Count-1 do begin
      mIdent := Copy (oDefGrid.Strings[I],1,Pos ('=',oDefGrid.Strings[I])-1);
      mVal := Copy (oDefGrid.Strings[I],Pos ('=',oDefGrid.Strings[I])+1,Length (oDefGrid.Strings[I]));
      oFile.WriteString ('DEFAULT',mIdent,mVal);
    end;
  end;
  oFile.Free;
end;

function   TGridSet.D01Exists:boolean;
begin
  oFile := TIniFile.Create (oDGDName+cDefType);
  Result := oFile.SectionExists ('D01');
  oFile.Free;
end;

function  TGridSet.VerifyD01:boolean;
var
  I,J:integer;
  mS,mFld,mParam:string;
begin
  Result := FALSE;
  If not D01Exists then begin
    ReadDefault;
    oSetGrid.Clear;
    oSetGrid.Add ('Head=');
    If oDefGrid.Count>0 then begin
      For I:=0 to oDefGrid.Count-1 do begin
        mS := Copy (oDefGrid.Strings[I],Pos ('=',oDefGrid.Strings[I])+1,Length (oDefGrid.Strings[I]));
        mFld := ';'+Copy (mS,1,Pos (',',mS)-1)+';';
        If (Pos (UpString (mFld),UpString (cHideFld))=0) and (Copy (mFld,2,1)<>'_') and (Copy (mFld,Length (mFld)-1,1)<>'_') then begin
          mParam := '';
          For J:=0 to 5 do begin
            If J>0 then mParam := mParam+',';
            mParam := mParam+LineElement(mS,J,',');
          end;
          oSetGrid.Add ('Field'+StrInt (I,0)+'='+mParam);
        end;
      end;
      SaveGridSet ('D01');
      AddToList ('D01=D01');
    end;
  end else Result := TRUE;
end;

function  TGridSet.GetNewSection (pService:boolean):string;
var
  I:integer;
  mNum:integer;
  mS:string;
  mOK:boolean;
begin
  SetDGDName (oDGDName);
  oSetList.Clear;
  If pService
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  oFile.ReadSectionValues ('NAMES',oSetList);
  oFile.Free;
  I := 0;
  mOK := FALSE;
  While (I<oSetList.Count) and not mOK do begin
    mS := Copy (oSetList.Strings[I],2,2);
    If ValInt (mS)>0 then mOK := (ValInt (mS)<>I+1);
    If not mOK then Inc (I);
  end;
  If mOK
    then mNum := I+1
    else mNum := oSetList.Count+1;
  If pService
    then Result := 'D'+StrIntZero (mNum,2)
    else Result := 'U'+StrIntZero (mNum,2);
  AddToList (Result+'='+Result);
end;

function   TGridSet.LoadColorGrp (pGrpNum:string):boolean;
var mSect:string;
begin
  Result := FALSE;
  oColorGrp.Clear;
  If Copy (pGrpNum,1,1)='D'
    then oFile := TIniFile.Create (oDGDName+cDefType)
    else oFile := TIniFile.Create (oDGDName+cUserType);
  mSect := 'ColorGrp_'+pGrpNum;
  If oFile.SectionExists (mSect) then begin
    oFile.ReadSectionValues (mSect,oColorGrp);
    Result := (oColorGrp.Count>0);
  end;
  oFile.Free;
end;

end.

