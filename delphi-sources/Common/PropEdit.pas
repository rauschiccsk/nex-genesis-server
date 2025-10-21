unit PropEdit;

interface
(*******************************************************************
                          
    Object Inspector/Component Editor.
*)

uses
  PropTools, Ictools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, ComCtrls, Consts;

type
  TFF_CompEdit = class(TForm)
    StringGrid1: TStringGrid;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    ComponentBox: TComboBox;
    EditStr: TEdit;
    ComboEnum: TComboBox;
    SetEdit: TListBox;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel1Resize(Sender: TObject);
    procedure ComponentBoxChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;  var CanSelect: Boolean);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure FixUpOnExit(Sender: TObject);
    procedure EditStrKeyPress(Sender: TObject; var Key: Char);
    procedure EditkeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComponentBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    PropList: TStringList;
    FComponent,FOwner: TComponent;
    CurComponent: TComponent;
    CompProp: TEProperty;

    procedure ShowCurrentComponent(pPos:boolean);
    procedure ClearStringGrid;
    procedure ClearPropList;
    procedure DoLastControl;
    procedure EGetStrs (Const s : String);
    procedure SetEditBounds (AControl : TWinControl);
    Procedure SetStatusBar (Sender: TObject;  ARow: Integer);
    procedure EditProperty (CurCol, CurRow: LongInt);
    procedure ClearEdit (Sender: TObject);
    procedure CompList (pDefForm:TComponent; pClassName:string; pWithParent:boolean);
    procedure Init (AComponent : TComponent);
  public
    { Public declarations }
    Procedure Execute (AComponent: TComponent; IsModal: Boolean);
 end;
 Procedure EditAComponent(AComponent : TComponent;
                          ACaption   : String;
                          IsModal    : Boolean);
var
  FF_CompEdit: TFF_CompEdit;

implementation

{$R *.DFM}
uses
  Db, DbTables, FileCtrl, ImageView, StrListEdit;


Procedure GetFileList(FPath : String;
                      Mask  : String;
                      FList : TStrings);
Var
    TMask     : String;
    P         : Integer;
    FResult   : Integer;
    SearchRec : TSearchrec;
begin
  FList.Clear;
  If FPath='' then
    Exit;
  If NOT DirectoryExists(FPath) then
    Exit;
  If FPath[Length(FPath)]<>'\' then
    Fpath:=FPath+'\';
  While Mask<>'' do
  begin
    P:=Pos(';',Mask);
    If P=0 then
      P:=Succ(Length(Mask));
    TMask:=Copy(Mask,1,Pred(P));
    Delete(Mask,1,P);
    FResult := SysUtils.FindFirst(FPath+TMask,0,SearchRec);
    while FResult = 0 do
    begin
      FList.Add(SearchRec.Name);
      FResult := SysUtils.FindNext(SearchRec);
    end;
    SysUtils.FindClose(SearchRec);
  end;
end;

Procedure EditAComponent(AComponent : TComponent;
                         ACaption   : String;
                         IsModal    : Boolean);
Var
    AForm : TFF_CompEdit;
begin
  AForm:=TFF_CompEdit.Create(Application);
  If ACaption<>'' then
    AForm.Caption:=ACaption;
  AForm.Execute(AComponent,True);
  AForm.Free;
end;

procedure TFF_CompEdit.FormClose(    Sender: TObject;
                                  var Action: TCloseAction);
begin
  ClearPropList; {Clear the property list and free the form}
  if FF_Image<>nil then begin
    FF_Image.Free;
    FF_Image:=nil;
  end;
  if SedForm<>nil then begin
    SedForm.Free;
    SedForm:=nil;
  end;
  Free;
  FF_CompEdit:=nil;
end;

procedure TFF_CompEdit.ClearStringGrid;
Var
    I       : Integer;
begin
  For I:=0 To StringGrid1.RowCount-1 do
  begin
    StringGrid1.Cells[0,I]:='';
    StringGrid1.Cells[1,I]:='';
  end;
end;
procedure TFF_CompEdit.ClearPropList;
Var
    I       : Integer;
begin                   {Clear the Property List}
  If PropList<>Nil then
    For I:=0 to PropList.Count-1 do
    begin
      CompProp:=PropList.Objects[I] As TEProperty;
      if Compprop<>nil then CompProp.Free;
    end;
  PropList.Free;
  PropList:=Nil;
  CompProp:=Nil;
  ClearStringGrid;
end;
procedure TFF_CompEdit.Panel1Resize(Sender: TObject);
begin
  ComponentBox.Width:=Panel1.Width-21;
  BitBtn1.Left:=Panel1.Width-22;
end;

Procedure TFF_CompEdit.ShowCurrentComponent(pPos:boolean);
Var
    S          : String;
    ACount     : Integer;
    I          : Integer;
    AComponent : TComponent;
    TInt       : Integer;
               Procedure DelCurrent;
               begin
                 CompProp:=PropList.Objects[I] As TEProperty;
                 CompProp.Free;
                 PropList.Delete(I);
                 Dec(Acount);
               end;
begin
  S :=Copy(ComponentBox.Text,1,Pred(Pos(':',ComponentBox.Text)));
  AComponent:=FComponent;
  If S<>'' then
    For I:=0 to FComponent.ComponentCount-1 do
      If FComponent.Components[I].Name=S then
      begin
        AComponent:=FComponent.Components[I];
        Break;
      end;
  If (AComponent<>Nil) {AND (AComponent<>CurComponent)} then
  begin
    CurComponent:=AComponent;
    ClearPropList;
    ACount:=E_EnumProperties(CurComponent,PropList,'');
    I:=0;
    While I<ACount do Inc(I); // tungli
    (*  begin       // tungli - removed original
    S:=UpperCase(PropList.Strings[I]);
    If (S='MASTERFIELDS') OR (S='MASTERSOURCE') OR
         (S='SESSIONNAME') OR (S='UPDATEOBJECT') OR
         (S='INDEXFILES') then
        DelCurrent
      else
        Inc(I);
    end; *)

    If ACount>0 then
    begin
      StringGrid1.RowCount:=ACount;
      For I:=0 to ACount-1 do
      begin
        StringGrid1.Cells[0,I]:=PropList.Strings[I];
        CompProp:=PropList.Objects[I] As TEProperty;
        If UpperCase(PropList.Strings[I])='MODALRESULT' then
        begin
          TInt:=StrToInt(CompProp.PValue);
          If (TInt<MrNone) OR (TInt>MrNo) then
            TInt:=mrNone;
          CompProp.PValue:=mrArray[TInt];
          CompProp.EType:=PROP_MODALTYPE;
        end;
        StringGrid1.Cells[1,I]:=CompProp.PValue;
      end;
      if pPos then begin
        StringGrid1.Col:=1;
        StringGrid1.Row:=0;
      end;
    end
    else
      StringGrid1.RowCount:=0;
  end;
end;
procedure TFF_CompEdit.ComponentBoxChange(Sender: TObject);
begin
  ShowCurrentComponent(false);
end;

Procedure TFF_CompEdit.Execute(AComponent : TComponent;
                                IsModal    : Boolean);
begin
  Init(AComponent);
  If IsModal then
  begin
    BorderIcons:=BorderIcons-[biMinimize];
    Height:=Height DIV 2;
    ShowModal;
  end
  else
    Show;
end;

procedure TFF_CompEdit.Init(AComponent : TComponent);
Var
     I  : Integer;
              Function AddComponent(AComponent : TComponent) : String;
              begin
                Result:=AComponent.Name+':'+AComponent.ClassName;
              end;
begin
  ComponentBox.Items.Clear;
  FComponent:=AComponent;
  if (FComponent is TApplication) or (FComponent is TForm) then
    FOwner:=FComponent else FOwner:=FComponent.Owner;
  If FComponent.ComponentCount>0 then
    ComponentBox.Items.Add(AddComponent(FComponent))
  else begin
    ComponentBox.Style:=csDropDown;
    ComponentBox.text:=FComponent.Name+':'+FComponent.ClassName;
    ComponentBox.Enabled:=False;
  end;
  For I:=0 to FComponent.ComponentCount-1 do
    ComponentBox.Items.Add(AddComponent(FComponent.Components[I]));
  CurComponent:=Nil;
  if ComponentBox.Items.Count>0 then ComponentBox.ItemIndex:=0;
  ShowCurrentComponent(true);
  if FOwner is TForm then begin
    Left:=TWinControl(FOwner).Left;
    Top:=TWinControl(FOwner).top;
  end else  Position:=poScreenCenter;
end;

procedure TFF_CompEdit.FormResize(Sender: TObject);
begin
  StringGrid1.DefaultColWidth:=(ClientWidth-25) DIV 2;
  With StringGrid1 do
  begin
    ColWidths[0]:=DefaultColWidth;
    ColWidths[1]:=DefaultColWidth;
  end;
  If (ActiveControl=EditStr) OR (ActiveControl=ComboEnum) OR
     (ActiveControl=SetEdit) then
    SetEditBounds(ActiveControl);
end;

procedure TFF_CompEdit.DoLastControl;
Var
    CurRow  : Integer;
    PropStr,OldValue : String;
    S       : String;
    TInt    : Integer;
    Tf      : Extended;
    TBool   : Boolean;
    CAddr   : LongInt;
    I,J     : Integer;
    mT      : TComponent; // tungli temp value
begin
 try
  OldValue:='';
  CurRow:=StringGrid1.Row;
  If CurRow<Proplist.Count then begin
    PropStr:=PropList.Strings[CurRow];
    CompProp:=PropList.Objects[CurRow] AS TEProperty;
    if CompProp<>nil then if CompProp.EType=PROP_NOTYPE then Exit;
    CAddr:=longint(nil); // tungli
    If CompProp<>nil then begin
      OldValue:=CompProp.PValue;
      CompProp.PValue:='nil'; // tungli
      If CompProp.EType=PROP_STRTYPE then begin
        If E_SetStrProp(CurComponent,PropStr,EditStr.Text) then CompProp.PValue:=EditStr.Text;
      end else
        If CompProp.EType=PROP_CHARTYPE then begin
          S:=RemAllChar(EditStr.Text,#32);
          If S='' then TInt:=0
          else begin
            If S[1]='#' then begin
              Delete(S,1,1);
              TInt:=StrToInt(S);
            end else TInt:=Ord(S[1]);
          end;
          If E_SetIntProp(CurComponent,PropStr,TInt) then CompProp.PValue:=EditStr.Text;
        end else
          If CompProp.EType=PROP_BOOLTYPE then begin
            If E_SetBoolProp(CurComponent,PropStr,UpperCase(Trim(ComboEnum.Text))='TRUE') then CompProp.PValue:=Trim(ComboEnum.Text);
          end else
            If CompProp.EType=PROP_INTTYPE then begin
              TInt:=StrToInt(EditStr.Text);
              With CompProp do
                if (TInt < MinVal) or (TInt > MaxVal) then;// raise ECompEditError.CreateResFmt(SOutOfRange, [MinVal,MaxVal]);
              If E_SetIntProp(CurComponent,PropStr,TInt) then CompProp.PValue:=EditStr.Text;
            end else
              If CompProp.EType=PROP_REALTYPE then begin
                Tf:=StrToFloat(EditStr.Text);
                If E_SetRealProp(CurComponent,PropStr,Tf) then CompProp.PValue:=EditStr.Text;
              end else
                If CompProp.EType IN [PROP_ENUMTYPE,PROP_MODALTYPE] then begin
                  If E_SetIntProp(CurComponent,PropStr,ComboEnum.ItemIndex) then CompProp.PValue:=ComboEnum.Text;
                end else
                  If CompProp.EType=PROP_SETTYPE then begin
                    CompProp.PValue:='[';
                    For TInt:=0 to SetEdit.Items.Count-1 do
                      If SetEdit.Selected[TInt] then begin
                        if Length(CompProp.PValue) <> 1 then CompProp.PValue:=CompProp.PValue+',';
                        CompProp.PValue:=CompProp.PValue+SetEdit.Items.Strings[TInt];
                      end;
                    CompProp.PValue:=CompProp.PValue+']';
                    If NOT E_SetSetStrProp(CurComponent,PropStr,CompProp.PValue) then CompProp.PValue:=StringGrid1.Cells[1,CurRow];
                  end else
                    If CompProp.EType=PROP_COLORTYPE then begin
                      If E_SetIntProp(CurComponent,PropStr,StringToColor(ComboEnum.Text)) then CompProp.PValue:=ComboEnum.Text;
                    end else
                      If CompProp.EType=PROP_CURSORTYPE then begin
                        If E_SetIntProp(CurComponent,PropStr,StringToCursor(ComboEnum.Text)) then CompProp.PValue:=ComboEnum.Text;
                      end else
                        If CompProp.EType IN [PROP_INDEXNAME,PROP_DBNAMETYPE,PROP_DBIDXNAMETYPE,
                                 PROP_DBTABNAMETYPE,PROP_DBLOOKUPFIELD] then begin
                          if (Trim(ComboEnum.Text)<>'') and (CompProp.EType=PROP_INDEXNAME) then E_SetStrProp(CurComponent,'IndexFieldNames','');
                          if (Trim(ComboEnum.Text)<>'') and (CompProp.EType=PROP_DBIDXNAMETYPE) then E_SetStrProp(CurComponent,'IndexName','');
                          if (Trim(ComboEnum.Text)<>OldValue) and ((CompProp.EType=PROP_DBNAMETYPE) or (CompProp.EType=PROP_DBTABNAMETYPE)) then begin
                            E_SetStrProp(CurComponent,'IndexFieldNames','');
                            E_SetStrProp(CurComponent,'IndexName','');
                            if (CompProp.EType=PROP_DBNAMETYPE) then E_SetStrProp(CurComponent,'TableName','');
                          end;
                          If E_SetStrProp(CurComponent,PropStr,ComboEnum.Text) then CompProp.PValue:=ComboEnum.Text;
                        end else
                          If CompProp.EType = PROP_CLASSTYPE then begin    //tungli begin
                            if CompProp.SubType=PROP_COMPONENT then begin
                              TBool:=false;
                              mT:=FindComp(FOwner,ComboEnum.Text);
                              if mT<>nil then begin
                                CAddr:=Longint(mT);
                                TBool:=E_SetIntProp(CurComponent,PropList.Strings[CurRow],CAddr);
                                 if Tbool then begin
                                   CompProp.PValue:=mT.Name;
                                   CompProp.ClassAddr:=CAddr;
                                 end;
                              end;
                              if not TBool then begin
                                TBool:=E_SetIntProp(CurComponent,PropList.Strings[CurRow],longint(nil));
                                if TBool then begin
                                  CompProp.PValue:='nil';
                                  CompProp.ClassAddr:=Longint(nil);
                                end;
                              end;
                            TBool:=false;
                          end;                             // tungli end
                          If CompProp.SubType=PROP_DATASETSUB then begin
                            CAddr:=Longint(nil);
                            TBool:=False;
                            mT:=FindComp(FOwner,ComboEnum.Text);
                            if mT<>nil then begin
                              if mT is TDataSet then begin
                                TBool:=True;
                                CAddr:=Longint(mT);
                              end;
                            end;
                            If NOT TBool then
                              With Session do
                                for I:= 0 to DatabaseCount - 1 do
                                  With Databases[I] do
                                    For J:=0 to DataSetCount-1 do
                                      If CompareText(ComboEnum.Text,DataSets[I].Name)=0 then begin
                                        CAddr:=Longint(DataSets[I]);
                                        Break;
                                      end;
                            If E_SetIntProp(CurComponent,PropList.Strings[CurRow],CAddr) then begin
                              CompProp.PValue:=ComboEnum.Text;
                              CompProp.ClassAddr:=CAddr;
                            end;
                          end else
                            If CompProp.SubType=PROP_DATASOURCESUB then begin
                              TBool:=True;
                              CAddr:=longint(nil);
                              mT:=FindComp(FOwner,ComboEnum.Text);
                              if (mT<>nil) and (mT is TdataSource) then begin
                                 TBool:=true;
                                 CAddr:=Longint(mT);
                               end;
                              TBool:=E_SetIntProp(CurComponent,PropList.Strings[CurRow],CAddr);
                              If TBool then begin
                                CompProp.PValue:=ComboEnum.Text;
                                CompProp.ClassAddr:=CAddr;
                              end;
                            end;
                          end;
                          StringGrid1.Cells[1,CurRow]:=CompProp.PValue;
                        end;
    end;
  finally
    ShowCurrentComponent(false);
  end;
end;  {** DoLastControl **}

Procedure TFF_CompEdit.SetStatusBar(Sender : TObject;
                                     ARow   : Integer);
begin
  If Assigned(PropList) then
    If Sender IS TStringGrid then
      If TEProperty(PropList.Objects[ARow]).EType=PROP_NOTYPE then
        StatusBar1.SimpleText:='This Property Cannot Be Edited'
      else
        StatusBar1.SimpleText:='Double Click/Enter To Edit Property'
    else
      StatusBar1.SimpleText:='Escape To Cancel'
  else
    StatusBar1.SimpleText:='';
end;

procedure TFF_CompEdit.StringGrid1SelectCell(Sender        : TObject;
                                              Col           ,
                                              Row           : Longint;
                                              var CanSelect : Boolean);
begin
  If Col=1 then
  begin
    CanSelect:=True;
    SetStatusBar(StringGrid1,Row);
  end
  else
    CanSelect:=False;
end;
Procedure TFF_CompEdit.EGetStrs(Const s : String);
begin
  ComboEnum.Items.Add(S);
end;
procedure TFF_CompEdit.SetEditBounds(AControl : TWinControl);
Var
    Rect : TRect;
begin
  If AControl<>Nil then With AControl do
  begin
    CompProp:=PropList.Objects[StringGrid1.Row] AS TEProperty;
    Rect := StringGrid1.CellRect(1,StringGrid1.Row);
    If CompProp.EType = PROP_SETTYPE then
    begin
      Left:=0;
      Top:=Rect.Top+StringGrid1.Top+StringGrid1.DefaultRowHeight;
      Height:=StringGrid1.DefaultRowHeight*5;
      Width:=StringGrid1.Width;
    end
    else
    begin
      Left:=Rect.Left+1;
      Top:=Rect.Top+StringGrid1.Top;
      Height:=StringGrid1.DefaultRowHeight;
      Width:=StringGrid1.DefaultColWidth;
    end;
    StatusBar1.SimpleText:='';
    Visible:=True;
    ActiveControl:=AControl;
    SetStatusBar(AControl,0);
  end
end;


procedure TFF_CompEdit.EditProperty(CurCol ,CurRow : LongInt);
Var
    DoIt       : Boolean;
    CurEdit    : TWinControl;
    I,J        : Integer;
    S          ,
    Ts         : String;
    FontDialog : TFontDialog;
    AList      : TStrings;
    TBool      : Boolean;
    CAddr      : Longint;
    mBool      : boolean;  //tungli begin
    mParent    : TClass;
    mComp      : TComponent; //tungli end
    mS:String;

                Function GetDataBaseName : Boolean;
                begin
                  Result:=False;
                  If StringGrid1.RowCount>0 then
                  begin
                    I:=0;
                    While (I<StringGrid1.RowCount) AND (UpperCase(StringGrid1.Cells[0,I])<>'DATABASENAME') do
                      Inc(I);
                    If I<StringGrid1.RowCount then
                    begin
                      S:=StringGrid1.Cells[1,I];
                      Result:=S<>'';
                    end;
                  end;
                end;

                Function GetDataBasePath : Boolean;
                begin
                  Result:=False;
                  AList:=TStringList.Create;
                  Session.GetAliasParams(S,AList);
                  S:='';
                  I:=0;
                  While I < AList.Count do
                    If Pos('PATH',UpperCase(Alist.Strings[I]))>0 then
                    begin
                      S:=AList.Strings[I];
                      Delete(S,1,Pos('=',S));
                      Result:=True;
                      Break;
                    end
                    else
                      Inc(I);
                    AList.Free;
                end;

                Function GetTableName : Boolean;
                begin
                  Result:=False;
                  S:='';
                  If StringGrid1.RowCount>0 then
                  begin
                    I:=0;
                    While (I<StringGrid1.RowCount) AND (UpperCase(StringGrid1.Cells[0,I])<>'TABLENAME') do
                      Inc(I);
                    If I<StringGrid1.RowCount then
                      S:=StringGrid1.Cells[1,I];
                    Result:=S<>'';
                  end;
                end;

                Function GetLookUpSource : Boolean;
                begin
                  Result:=False;
                  CAddr:=0;
                  If StringGrid1.RowCount>0 then
                  begin
                    I:=0;
                    While (I<StringGrid1.RowCount) AND (UpperCase(StringGrid1.Cells[0,I])<>'LOOKUPSOURCE') do
                      Inc(I);
                    If I<StringGrid1.RowCount then
                    begin
                      S:=StringGrid1.Cells[1,I];
                      If S<>'' then
                        CAddr:=LongInt(TDataSource(TeProperty(PropList.Objects[I]).ClassAddr).DataSet);
                    end;
                    Result:=CAddr>0;
                  end;
                end;
begin
  If (PropList=Nil) OR (CurCol<>1) then Exit;
  CompProp:=PropList.Objects[CurRow] AS TEProperty;
  If CompProp.EType IN [PROP_STRTYPE,PROP_INTTYPE,PROP_REALTYPE,PROP_CHARTYPE] then begin
    EditStr.MaxLength:=CompProp.MaxChars;
    EditStr.Text:=CompProp.PValue;
    CurEdit:=EditStr;
  end else
    If CompProp.EType IN [PROP_BOOLTYPE,PROP_ENUMTYPE,PROP_COLORTYPE,PROP_CURSORTYPE,PROP_MODALTYPE] then begin
      ComboEnum.Items.Clear;
      CurEdit:=ComboEnum;
      Case CompProp.EType of
        PROP_BOOLTYPE   ,
        PROP_ENUMTYPE   : If NOT E_GetEnumList(CompProp,ComboEnum.Items) then CurEdit:=Nil;
        PROP_COLORTYPE  : GetColorValues(EGetStrs);
        PROP_CURSORTYPE : GetCursorValues(EGetStrs);
        PROP_MODALTYPE  : For I:=MrNone to MrNo do
                          ComboEnum.Items.Add(MrArray[I]);
      else
        CurEdit:=Nil;
      end; {case}
    end else
      If CompProp.EType = PROP_SETTYPE then begin
        If E_GetEnumList(CompProp,SetEdit.Items) then begin
          S:=RemAllChar(RemAllChar(StringGrid1.Cells[1,CurRow],'['),']');
          While S<>'' do begin
            I:=Pos(',',S);
            If I=0 then I:=Succ(Length(S));
            Ts:=Copy(S,1,Pred(I));
            Delete(S,1,I);
            I:=SetEdit.Items.IndexOf(Ts);
            If I>-1 then SetEdit.Selected[I]:=True;
          end;
          CurEdit:=SetEdit;
        end;
      end else
        If CompProp.EType IN [PROP_INDEXNAME,PROP_DBIDXNAMETYPE,PROP_DBTABNAMETYPE,
                            PROP_DBNAMETYPE,PROP_DBLOOKUPFIELD] then begin
          ComboEnum.Style:=csDropDown;
          If CompProp.EType=PROP_DBNAMETYPE then Session.GetDataBaseNames(ComboEnum.Items)
          else
            If (CompProp.EType=PROP_DBIDXNAMETYPE) or (CompProp.EType=PROP_INDEXNAME) then begin
              If GetTableName AND GetDataBaseName then
                If E_GetBoolProp(CurComponent,'Active',TBool) then begin
                  If NOT TBool then
                    Try
                      If E_SetBoolProp(CurComponent,'Active',True) then begin
                        TTable(CurComponent).IndexDefs.Update;
                        For I := 0 to TTable(CurComponent).IndexDefs.Count - 1 do begin
                          if CompProp.EType=PROP_DBIDXNAMETYPE then begin
                            ComboEnum.Items.Add(TTable(CurComponent).IndexDefs.Items[I].Fields);
                          end;
                          if CompProp.EType=PROP_INDEXNAME then begin
                            ComboEnum.Items.Add(TTable(CurComponent).IndexDefs.Items[I].Name);// tungli
                          end;
                        end;
                      end;
                    Finally
                      If NOT TBool then E_SetBoolProp(CurComponent,'Active',False);
                    end;
                end;
            end else
              If CompProp.EType=PROP_DBTABNAMETYPE then begin
                if getDataBaseName then Session.GetTableNames(S,'*',true,false,ComboEnum.Items); // tungli
                // If GetDataBaseName AND GetDataBasePath then GetFileList(S,'*.DB;*.DBF',ComboEnum.Items);
              end else
                If CompProp.EType=PROP_DBLOOKUPFIELD then begin
                  If GetLookupSource then begin
                    TBool:=TTable(CAddr).Active;
                    If NOT TBool then TTable(CAddr).Active:=True;
                    For I := 0 to TTable(CAddr).FieldDefs.Count - 1 do
                      ComboEnum.Items.Add(TTAble(CAddr).FieldDefs.Items[I].Name);
                    If NOT TBool then TTable(CAddr).Active:=False;
                  end;
                end;
                CurEdit:=ComboEnum;
        end else
          If CompProp.EType=PROP_CLASSTYPE then begin
            if UpperCase(Trim(CompProp.PValue))<>'nil' then ComboEnum.Items.Add('nil');
            mBool:=false;
            if CompProp.SubType=PROP_COMPONENT then begin  // tungli begin
              CompList(FOwner,CompProp.MyClassName,true);
              CurEdit:=ComboEnum;
            end;                                           // tungli end
            If CompProp.SubType=PROP_DATASETSUB then begin
              ComboEnum.Style:=csDropDown;
              With Session do
                for I:= 0 to DatabaseCount - 1 do
                  With Databases[I] do
                    For J:=0 to DataSetCount-1 do
                      If ComboEnum.Items.IndexOf(Datasets[j].Name)<0 then ComboEnum.Items.Add(DataSets[j].Name);     //tungli
              CompList(FOwner,CompProp.MyClassName,true);
              CurEdit:=ComboEnum;
            end else
              If CompProp.SubType=PROP_DATASOURCESUB then begin
                ComboEnum.Style:=csDropDown;
                CompList(FOwner,CompProp.MyClassName,true);
                CurEdit:=ComboEnum;
              end;
          end;
          If CurEdit<>Nil then begin
            If CurEdit=ComboEnum then begin
              ComboEnum.Text:=CompProp.PValue;
              ComboEnum.ItemIndex:=ComboEnum.Items.IndexOf(CompProp.PValue);
            end;
            SetEditBounds(CurEdit);
          end else
            If CompProp.EType=PROP_CLASSTYPE then begin
              Try
                case CompProp.SubType of
                PROP_FONTSUB:
                  begin
                    FontDialog := TFontDialog.Create(Application);
                    try
                      FontDialog.Font := TFont(CompProp.ClassAddr);
                      FontDialog.Options := FontDialog.Options + [fdForceFontExist];
                      if FontDialog.Execute then
                        If E_SetIntProp(CurComponent,PropList.Strings[CurRow],LongInt(FontDialog.Font)) then
                          CompProp.PValue:=FontDialog.Font.Name;
                    finally
                      FontDialog.Free;
                    end;
                  end;
                PROP_ICONSUB:
                  begin
                    if FF_Image=nil then Application.CreateForm(TFF_Image,FF_Image);   // tungli
                    FF_Image.IconsOnly;
                    FF_Image.Image1.Picture.Icon.Assign(TIcon(CompProp.ClassAddr));
                    If FF_Image.ShowModal=mrOk then TIcon(CompProp.ClassAddr).Assign(FF_Image.Image1.Picture.Icon);
                  end;
                PROP_BMPSUB:
                  begin
                    if FF_Image=nil then Application.CreateForm(TFF_Image,FF_Image); // tungli
                    DoIt:=UpperCase(StringGrid1.Cells[0,CurRow])='GLYPH';
                    FF_Image.BmpsOnly(DoIt);
                    FF_Image.Image1.Picture.BitMap.Assign(TBitMap(CompProp.ClassAddr));
                    If FF_Image.ShowModal=mrOk then
                      TBitMap(CompProp.ClassAddr).Assign(FF_Image.Image1.Picture.BitMap);
                    If DoIt then begin
                      For I := 0 To StringGrid1.RowCount-1 do
                        If UpperCase(StringGrid1.Cells[0,I])='NUMGLYPHS' then begin
                          If E_SetIntProp(CurComponent,StringGrid1.Cells[0,I],StrToInt(FF_Image.UpDownEdit.Text)) then
                          begin
                            With PropList.Objects[I] AS TEProperty do begin
                              PValue:=FF_Image.UpdownEdit.Text;
                              StringGrid1.Cells[0,I]:=PValue;
                            end;
                          end;
                          Break;
                        end;
                    end;
                  end;
                  PROP_TSTRSUB:
                  begin
                    if SedForm=nil then Application.CreateForm(TSedForm,SedForm); // tungli
                    SedForm.StrList.Lines.Assign(TStrings(CompProp.ClassAddr));
                    If (SedForm.ShowModal=mrOk) then TStrings(CompProp.ClassAddr).Assign(SedForm.StrList.Lines);
                  end;
                  else {case}
                        If Assigned(TComponent(CompProp.ClassAddr)) then begin
                          E_GetStrProp(CurComponent,'Name',ts);
                          If ts<>'' then ts:=ts+'.';
                          ts:=ts+StringGrid1.Cells[0,CurRow];
                          EditAComponent(TComponent(CompProp.ClassAddr),ts,True);
                        end;
                  end; {case subtype}
                 StringGrid1.Cells[1,CurRow]:=CompProp.PValue;
              Finally
              end;
            end;
  if FF_Image<>nil then begin   // tungli begin
    FF_Image.Free;
    FF_Image:=nil;
  end;
  if SedForm<>nil then begin
    SedForm.Free;
    SedForm:=nil;
  end;                           // tungli end
end;   {** EditProperty **}


procedure TFF_CompEdit.CompList(pDefForm:TComponent; pClassName:string; pWithParent:boolean); // tungli
var i,j:integer;
    mF:TComponent;
    mS:String;
    mParent:TClass;
    mBool:Boolean;
begin
  pClassName:=UpperCase(pClassName);
  for i:=0 to Application.ComponentCount-1 do begin
    if Application.Components[i] is TForm then begin
      mF:=Application.Components[i];
      if mF=nil then Continue;
      for j:=0 to mF.ComponentCount-1 do begin
        if mF.Components[j]=nil then Continue;
        mS:=UpperCase(mF.Components[j].ClassName);  // must save to mS, else chaos
        if mS=pClassName then begin
          mS:=mF.Components[j].Name;
          if mF<>pDefForm then mS:=mF.Name+'.'+mS;
          If ComboEnum.Items.IndexOf(mS)<0 then ComboEnum.Items.Add(mS);
        end else begin
          if pWithParent then begin
            mBool:=false;
            mParent:=mF.Components[j].ClassParent;
            while mParent<>nil do begin
              mS:=UpperCase(mParent.ClassName); // must save to mS, else chaos
              if mS=pClassName then begin
                mS:=mF.Components[j].Name;
                if mF<>pDefForm then mS:=mF.Name+'.'+mS;
                If ComboEnum.Items.IndexOf(mS)<0 then ComboEnum.Items.Add(mS);
                mBool:=true;
              end;
              if mBool then mParent:=nil
              else mParent:=mParent.ClassParent;
            end;
          end; {if withParent}
        end;
      end; {for j}
    end;
  end;
end;  {** CompList **}

procedure TFF_CompEdit.StringGrid1DblClick(Sender: TObject);
Var
    CurCol     : LongInt;
    CurRow     : LongInt;
    MousePoint : TPoint;
begin             {THIS WAS ADDED DUE TO A BUG FOUND BY Wm David Parker}
  GetCursorPos(MousePoint);
  MousePoint:=StringGrid1.ScreenToClient(MousePoint);
  StringGrid1.MouseToCell(MousePoint.X,MousePoint.Y,CurCol,CurRow);
  EditProperty(CurCol,CurRow);
end;

procedure TFF_CompEdit.ClearEdit(Sender: TObject);
begin
  E_SetBoolProp(TComponent(Sender),'Visible',False);
  ActiveControl:=StringGrid1;
  If Sender=ComboEnum then
  begin
    ComboEnum.Items.Clear;
    ComboEnum.Style:=csDropDownList;
  end;
  SetStatusBar(StringGrid1,StringGrid1.Row);
end;
procedure TFF_CompEdit.FixUpOnExit(Sender: TObject);
Var
    S         : String;
    IsVisible : Boolean;
begin
  If NOT E_GetBoolProp(TComponent(Sender),'Visible',IsVisible) then
    IsVisible:=False;
  If IsVisible AND (PropList<>Nil) then
  begin
    CompProp:=PropList.Objects[StringGrid1.Row] AS TEProperty;
    If CompProp.EType=PROP_SETTYPE then
      S:=''
    else If NOT E_GetStrProp(TComponent(Sender),'Text',S) then
      S:=StringGrid1.Cells[1,StringGrid1.Row];
    Try
      //If (S<>StringGrid1.Cells[1,StringGrid1.Row]) then
        DoLastControl;
    Finally
      ClearEdit(Sender);
    end;
  end
  else
    ClearEdit(Sender);
end;

procedure TFF_CompEdit.EditStrKeyPress(Sender: TObject; var Key: Char);
begin
  If StringGrid1.Row>=PropList.Count then
    Exit;
  CompProp:=PropList.Objects[StringGrid1.Row] AS TEProperty;
  Case CompProp.EType Of
    PROP_CHARTYPE : If Key IN ['0'..'9'] then
                      If Pos('#',EditStr.Text)=0 then
                        Key:=#0;
    PROP_INTTYPE  : If (Key='-') AND (CompProp.MinVal>-1) then
                      Key:=#0
                    else If NOT (Key IN ['-','0'..'9']) then
                      Key:=#0;
    PROP_REALTYPE  : If (Key='.') AND (EditStr.Text='') then
                      Key:=#0
                    else If NOT (Key IN ['-','.','0'..'9']) then
                      Key:=#0;
  end;
end;



procedure TFF_CompEdit.EditkeyDown(Sender: TObject; var Key: Word;
                                    Shift: TShiftState);
Var
     ARow : Integer;
begin
  If Key=VK_ESCAPE then
  begin          {Suggested by Wm David Parker to allow for cancel of edit}
    E_SetBoolProp(TComponent(Sender),'Visible',False);
    Key:=0;
  end
  else If Key IN[VK_UP,VK_DOWN,13] then
  begin
    If (Sender = ComboEnum) AND (ComboEnum.DroppedDown) then
      Exit;
    if key=13 then begin StringGrid1.setFocus; exit; end;
    With StringGrid1 do
    begin
      ARow:=Row;
      If Key = VK_UP then
      begin
        If (Sender=SetEdit) then With SetEdit do
          If (ItemIndex>0) then
            Exit;
        If Row>0 then
          ARow:=Row-1;
      end
      else If Row<RowCount-1 then
      begin
        If (Sender=SetEdit) then With SetEdit do
          If (ItemIndex>-1) AND (ItemIndex<Items.Count-1) then
            Exit;
        ARow:=Row+1;
      end;
      If ARow<>Row then
      begin
        FixUpOnExit(Sender);
        Row:=ARow;
        Key:=0;
      end;
    end;
  end;
end;
procedure TFF_CompEdit.StringGrid1KeyPress(    Sender : TObject;
                                            Var Key    : Char);
begin
  If Key=#13 then
  begin
    If (PropList=Nil) OR (StringGrid1.Col<>1) then
      Exit;
    With StringGrid1 do
      EditProperty(Col,Row);
    Key:=#0;
  end;
end;
procedure TFF_CompEdit.BitBtn1Click(Sender: TObject);
begin
  ShowCurrentComponent(true);
end;

procedure TFF_CompEdit.FormActivate(Sender: TObject);
begin
  Caption:=FOwner.Name+' components';
end;

procedure TFF_CompEdit.ComponentBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    Key:=0;
    if Fcomponent is TForm then begin
      if MessageDlg('Do you want view TApplication?',mtConfirmation,[mbYes,mbNo],0)=mrNo then exit;
      ClearPropList; {Clear the property list and free the form}
      Init(Application);
      Show;
    end else begin
      if CurComponent is TForm then begin
        if MessageDlg('Do you want view this form?',mtConfirmation,[mbYes,mbNo],0)=mrNo then exit;
        ClearPropList; {Clear the property list and free the form}
        Init(CurComponent);
        Show;
      end;
    end;
end;

end.
