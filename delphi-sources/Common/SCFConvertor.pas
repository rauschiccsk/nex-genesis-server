unit SCFConvertor;

interface

uses
  {  NEX }  IcEditors,IcButtons,SCFConvertor_EditSlct, NexPath,
  {      }  IcTools, CmpTools, BtrTable, IcConv,
  {Delphi}  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
            IniFiles, dsgnintf, stdctrls, comctrls, extctrls, dbctrls, db, buttons;

type
  TSCFConvertor = class(TComponent)
  private
    { Private declarations }
    oLB_Components: TStringList;
    oFileName: string;
    oUseINIFile: boolean;
    oVerifyComp: boolean;
    oFaktorHorizontal: integer;
    oFaktorVertical: integer;
    //2000.3.16 Bobe szulinapjan
    oPanel: TPanel;
    oIniFile: TIniFile;

    procedure CreateComponents;
    procedure TLabelBreaker;
    procedure TComponentCaptionFinder;
    procedure AssignCaption(pComonent: string; pLineNum: integer);
    procedure AssignCaptionGrupBox(pLineNum: integer);
    procedure ComponentParentFinder;

    procedure SetPanel(Value: TPanel);
    function  GetPanel: TPanel;
    function  FldToEditType(pLineStr,pLineStr2:string):byte;

  protected
    { Protected declarations }
    procedure SetDataSF(pDB: TControl; pStr: string); //overload;//2000.02.08. A data field es data source beallitasa
//    procedure SetDataSF(pDBCheckBox: TDBCheckBox; pStr: string); overload;//2000.02.08. A data field es data source beallitasa
    function  GetDataSource(pComponent: TComponent; pStr: string): TDataSource; //2000.02.08. Itt keresi meg vagy krealja meg azt az adattablat amire szukseg van
    //2000.3.17.
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Inport;


  published
    { Published declarations }
    property FileName: string read oFileName write oFileName;
    property FaktorHorizontal: integer read oFaktorHorizontal write oFaktorHorizontal;
    property FaktorVertical: integer read oFaktorVertical write oFaktorVertical;
    //2000.3.16. Bobe szulinapjan
    property Panel: TPanel read GetPanel write SetPanel;
    //2000.3.27.
//    property FolderName: string read oFolderName write oFolderName;
//    property PageControl: TPageControl read GetPageControl write SetPageControl;
    property UseINIFile: boolean read oUseINIFile write oUseINIFile;
    property VerifyComp: boolean read oVerifyComp write oVerifyComp;
  end;

  TSCFConvertorEditor = class(TComponentEditor)
    private
    protected
    public
      function  GetVerbCount: Integer; override;
      function  GetVerb(Index: Integer): string; override;
      procedure ExecuteVerb(Index: Integer); override;
      procedure Edit; override;
    published
  end;

procedure Register;

var uNum: integer = 0;

implementation
// Ezt csak akkor kell bekapcsolni ha gyorsan akarjuk lekrealni a komponenseket;
(*function  GetFreeComponentName(pForm: TForm; pName: string): string; //2000.1.20.
  begin
    inc(uNum);
    Result := 'Component'+IntToStr(uNum);
  end;
*)

procedure TSCFConvertor.ComponentParentFinder;
var
  mForm  : TForm;
  mParent: TWinControl;
  mControl: TControl;
  mGroupBox: TGroupBox;
  i, j: integer;
begin
  mForm := TForm(Self.Owner);
  if assigned(Panel)
    then mParent := TWinControl(Panel)
    else mParent := TWinControl(Self.Owner);

  if mForm.ComponentCount > 0 then for i:=0 to mForm.ComponentCount-1 do begin
    if mForm.Components[i] is TControl then begin
      mControl := (mForm.Components[i] as TControl);
      if mControl.Parent = mParent then begin
        for j :=0 to mForm.ComponentCount-1 do begin
          if mForm.Components[j] is TGroupBox then begin
            mGroupBox := mForm.Components[j] as TGroupBox;
            if mGroupBox.Parent = mParent then begin
              if (mGroupBox.Left<mControl.Left) and (mGroupBox.Left+mGroupBox.Width>mControl.Left)
                 and
                 (mGroupBox.Top<mControl.Top) and (mGroupBox.Top+mGroupBox.Height>mControl.Top)
                 and (i <> j)
              then begin
                  mControl.Parent := mGroupBox;
                  mControl.Left  := mControl.Left -mGroupBox.Left;
                  mControl.Top   := mControl.Top  -mGroupBox.Top +oFaktorVertical div 2;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSCFConvertor.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = oPanel)
    then oPanel := nil;
end;

procedure TSCFConvertor.SetPanel(Value: TPanel);
  begin
    oPanel := Value;
  end;

function  TSCFConvertor.GetPanel: TPanel;
  begin
    if not assigned(oPanel) then oPanel := nil;
    Result := oPanel;
  end;


function  TSCFConvertor.GetDataSource(pComponent: TComponent; pStr: string): TDataSource; //2000.02.08. Itt keresi meg vagy krealja meg azt az adattablat amire szukseg van
  var
    i: integer;
  begin
    Result := nil;
    if pStr= '' then exit;
    if (pComponent.ComponentCount > 0) then  for i := 0 to pComponent.ComponentCount - 1 do begin
      if (pComponent.Components[I] is TDataSource) then begin
        if (pComponent.Components[I] as TDataSource).DataSet is TBTRieveTable then begin
          if uppercase(((pComponent.Components[I] as TDataSource).DataSet as TBTRieveTable).TableName) = uppercase(pStr)
            then Result := pComponent.Components[I] as TDataSource;
        end;
      end;
    end;
  end;

procedure TSCFConvertor.SetDataSF(pDB: TControl; pStr: string); //A data field es data source beallitasa
  var
    mDataField: string;
  begin
    if copy(pStr,1,1) = '*' then begin
      // pl. "*.GETMGNAME(OED007^.MGCODE)"
      //ebben az esetben ez egy linkelt adatbazis lessz
    end else begin
      // pl. "GSCAT.MGCODE"
      //Itt pedig egyszeruen ki kell szedni es beallitani az adatbazist es fieldet
      if (pDB is TDBEdit) then begin
        (pDB as TDBEdit).DataSource := GetDataSource(owner, LineElement(pStr,0,'.'));
        (pDB as TDBEdit).DataField  := LineElement(pStr,1,'.');
      end else if (pDB is TDBComboBox) then begin
        (pDB as TDBComboBox).DataSource := GetDataSource(owner, LineElement(pStr,0,'.'));
        (pDB as TDBComboBox).DataField  := LineElement(pStr,1,'.');
      end else if (pDB is TDBCheckBox) then begin
        (pDB as TDBCheckBox).DataSource := GetDataSource(owner, LineElement(pStr,0,'.'));
        mDataField := LineElement(pStr,1,'.');
        if LineElementNum(mDataField,'=') > 1 then begin
          (pDB as TDBCheckBox).DataField  := LineElement(mDataField,0,'=');
          (pDB as TDBCheckBox).ValueChecked := LineElement(mDataField,1,'=');
          (pDB as TDBCheckBox).ValueUnchecked := '';
        end else begin
          (pDB as TDBCheckBox).DataField  := mDataField;
          (pDB as TDBCheckBox).ValueChecked := '1;Ano;A;True;Yes;On';
          (pDB as TDBCheckBox).ValueUnchecked := '0;Nie;N;False;No;Off';
        end;
      end;
    end;
  end;


procedure TSCFConvertor.Inport;
  begin
    oLB_Components.LoadFromFile(oFileName);
    TLabelBreaker;
    TComponentCaptionFinder;
    CreateComponents;
    ComponentParentFinder;
   end;

constructor TSCFConvertor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  oUseINIFile := FALSE;
  oVerifyComp := FALSE;
  oLB_Components := TStringList.Create;
  oPanel := nil;
  oFaktorHorizontal := 9;
  oFaktorVertical   := 20;
end;

destructor TSCFConvertor.Destroy;
begin
  oLB_Components.Free;
  inherited Destroy;
end;


procedure TSCFConvertor.AssignCaption(pComonent: string; pLineNum: integer);
var
  j: integer;
  mLeft, mTop,
  mWidth,mHeight: integer;
  mLineStr, mStr: string;
  mComponentTypeStr: string;
  mCaption: string;
  mDBStr: string;
begin
  mLineStr := oLB_Components[pLineNum];
  mComponentTypeStr := UpperCase(LineElement(mLineStr,0,'|'));
  if mComponentTypeStr = pComonent then begin
    mLeft    := StrToInt(LineElement(mLineStr,1,'|'));
    mTop     := StrToInt(LineElement(mLineStr,2,'|'));
    mDBStr   := LineElement(mLineStr,6,'|');
    for j := 0 to oLB_Components.Count-1 do begin
      mStr := oLB_Components[j];
      if 1= pos('TLABEL|'+IntToStr(mLeft-1)+'|'+IntToStr(mTop)+'|',mStr) then begin
        mCaption := LineElement(mStr,5,'|');
        if (1 = pos('[ ] ', mCaption)) or (1 = pos('( ) ', mCaption)) then begin
          mWidth   := StrToInt(LineElement(mStr,3,'|'));
          mHeight  := StrToInt(LineElement(mStr,4,'|'));
          mCaption := copy(mCaption,5,255);
          oLB_Components[j] := 'DELETED';
          oLB_Components[pLineNum] := pComonent+'|'+IntToStr(mLeft-1)+'|'+IntToStr(mTop)+'|'+IntToStr(mWidth)+'|'+IntToStr(mHeight)+'|'+mCaption+'|'+mDBStr;
        end;
      end;
    end;
  end;
end;

procedure TSCFConvertor.AssignCaptionGrupBox(pLineNum: integer);
var
  J,mLeft,mTop: integer;
  mjLeft, mjTop,mWidth,mHeight: integer;
  mLineStr, mStr: string;
  mComponentTypeStr: string;
  mCaption: string;
  mjComponentName: string;
begin
  mLineStr := oLB_Components[pLineNum];
  mComponentTypeStr := UpperCase(LineElement(mLineStr,0,'|'));
  if mComponentTypeStr = 'TPANEL' then begin
    mLeft    := StrToInt(LineElement(mLineStr,1,'|'));
    mTop     := StrToInt(LineElement(mLineStr,2,'|'));
    mWidth   := StrToInt(LineElement(mLineStr,3,'|'));
    mHeight  := StrToInt(LineElement(mLineStr,4,'|'));
    for j := 0 to oLB_Components.Count-1 do begin
      mStr := oLB_Components[j];
      mjComponentName    := UpperCase(LineElement(mStr,0,'|'));
      if (mjComponentName = 'TLABEL') then begin
        mjLeft    := StrToInt(LineElement(mStr,1,'|'));
        mjTop     := StrToInt(LineElement(mStr,2,'|'));
        if (mTop= mjTop) and (mjLeft>mLeft) and (mjLeft<mLeft+mWidth) then begin
          mCaption := LineElement(mStr,5,'|');
          oLB_Components[j] := 'DELETED';
          oLB_Components[pLineNum] := 'TGROUPBOX|'+IntToStr(mLeft)+'|'+IntToStr(mTop)+'|'+IntToStr(mWidth)+'|'+IntToStr(mHeight)+'|'+mCaption;
        end;
      end;
    end;
  end;
end;


procedure TSCFConvertor.TComponentCaptionFinder;
var
 i: integer;
begin
  if oLB_Components.Count > 0 then for i := 0 to oLB_Components.Count-1 do begin
    AssignCaption('TCHECKBOX', i);
    AssignCaption('TRADIOBUTTON', i);
    AssignCaption('TDBRADIOBUTTON', i);
    AssignCaption('TDBCHECKBOX', i);
    AssignCaptionGrupBox(i);
  end;
end;


procedure TSCFConvertor.TLabelBreaker;
var
  mLineStr: string;
  mComponentTypeStr: string;
  mStr: string;
  i, j: integer;
  mLeft,mTop,mHeight: integer;
  mCaption : string;
  mActLeft: integer;
begin
  if oLB_Components.Count > 0 then for i := 0 to oLB_Components.Count-1 do begin
    mLineStr := oLB_Components[i];
    mComponentTypeStr := UpperCase(LineElement(mLineStr,0,'|'));
    if mComponentTypeStr = 'TLABEL' then begin
      oLB_Components[i] := 'DELETED';
      mLeft    := StrToInt(LineElement(mLineStr,1,'|'));
      mTop     := StrToInt(LineElement(mLineStr,2,'|'));
      mHeight  := StrToInt(LineElement(mLineStr,4,'|'));
      mStr := LineElement(mLineStr,5,'|');
      while (mStr <> '') and (mStr[1] = ' ') do begin
        inc(mLeft);
        delete(mStr, 1, 1);
      end;
      mCaption := '';
      mActLeft := 0;
      for j := 1 to length(mStr) do begin
        if mStr[j] <> ' ' then begin
          if mStr[j] = #255 then mStr[j] := ' ';
          mCaption := mCaption + mStr[j];
          if j >= length(mStr) then begin
            if mCaption <> '' then begin
              oLB_Components.Add('TLABEL|'
                                     +IntToStr(mLeft+mActLeft)
                                     +'|'+
                                     IntToStr(mTop)
                                     +'|'
                                     +IntToStr(j-mActLeft)
                                     +'|'
                                     +IntToStr(mHeight)
                                     +'|'
                                     +mCaption);
            end;
          end;
        end else begin
          if j >= length(mStr) then begin
            if mCaption <> '' then begin
              oLB_Components.Add('TLABEL|'
                                     +IntToStr(mLeft+mActLeft)
                                     +'|'+
                                     IntToStr(mTop)
                                     +'|'
                                     +IntToStr(j-mActLeft)
                                     +'|'
                                     +IntToStr(mHeight)
                                     +'|'
                                     +mCaption);
            end;
            mActLeft := j+1;
            mCaption := '';
          end else begin
            if mStr[j+1] <> ' ' then begin
              if mCaption <> '' then begin
                if mStr[j] = #255 then mStr[j] := ' ';
                mCaption := mCaption + mStr[j];
              end;
            end else begin
              if mCaption <> '' then begin
                oLB_Components.Add('TLABEL|'
                                     +IntToStr(mLeft+mActLeft)
                                     +'|'+
                                     IntToStr(mTop)
                                     +'|'
                                     +IntToStr(j-mActLeft)
                                     +'|'
                                     +IntToStr(mHeight)
                                     +'|'
                                     +mCaption);
              end;
              mActLeft := j+1;
              mCaption := '';
            end;
          end;
        end;
      end;
    end;
  end;
end;


procedure TSCFConvertor.CreateComponents;
var
  mLabel: TLabel;
  mEdit: TEdit;
  mCheckBox: TCheckBox;
  mRadioButton: TRadioButton;
  mButton: TBitBtn;
  mOKButton:TOKButton;
  mDateTimePicker: TDateTimePicker;
  mComboBox: TComboBox;
  mPanel:TPanel;
  mBevel:TBevel;
  mDBEdit: TDBEdit;
  mDBCheckBox: TDBCheckBox;
  mGroupBox: TGroupBox;
  mDBComboBox: TDBComboBox;
  mPEd: TPriceEdit;
  mVEd: TValueEdit;
  mQEd: TQuantEdit;
  mBEd: TBarCodeEdit;
  mTEd: TVatEdit;
  mCEd: TCodeEdit;
  mNEd: TNameEdit;
  mLEd: TLongEdit;
  mDEd: TPrcEdit;

  mComboBoxItems,mLineStr,mLineStr2,mFld,mComponentTypeStr: string;
  mDFT,i,j,mComboBoxItemNum : integer;

  mForm  : TForm;
  mParent: TWinControl;
begin
  If oUseINIFile then oIniFile := TIniFile.Create (gPath.SysPath+'SCFFLD.SYS');
  mForm := TForm(Self.Owner);
  if assigned(Panel)
    then mParent := TWinControl(Panel)
    else mParent := TWinControl(Self.Owner);

  if oLB_Components.Count > 0 then for i := 0 to oLB_Components.Count-1 do begin
    mLineStr := DosStringToWinString(oLB_Components[i]);
    If LineElementNum(mLineStr,'.')=2
      then mFld:=LineElement(mLineStr,1,'.')  // napr. MGCODE.MGCODE
      else mFld:=LineElement(mLineStr,2,'.'); // napr. *.MGCODE.MGNAME.MGCODE
    mFld:=RemNonCharNum(mFld);
    If i< oLB_Components.Count-1
      then mLineStr2 := DosStringToWinString(oLB_Components[i+1])
      else mLineStr2 := '';
    mComponentTypeStr := UpperCase(LineElement(mLineStr,0,'|'));
    if mComponentTypeStr = 'TLABEL' then begin
      mLabel         := TLabel.Create(mForm);
      mLabel.Parent  := mParent;
      mLabel.Name    := GetFreeComponentName(mForm,'Label_');
      mLabel.Caption := LineElement(mLineStr,5,'|');
      mLabel.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mLabel.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical+0;
      mLabel.BringToFront;
    end else if mComponentTypeStr = 'TEDIT' then begin
      mEdit         := TEdit.Create(mForm);
      mEdit.Parent  := mParent;
      mEdit.Name    := GetFreeComponentName(mForm,'Edit_');
      mEdit.AutoSize:= FALSE;
      mEdit.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mEdit.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mEdit.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
      mEdit.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
    end else if mComponentTypeStr = 'TDBEDIT' then begin
      mDFT:=FldToEditType (mLineStr,mLineStr2);
      case mDFT of
       1: begin
            mPEd         := TPriceEdit.Create(mForm);
            mPEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_PriceEdit')
                       else mFld:= 'E_'+mFld;
            mPEd.Name    := mFLD;
            mPEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mPEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       2: begin
            mVEd         := TValueEdit.Create(mForm);
            mVEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_valueEdit')
                       else mFld:= 'E_'+mFld;
            mVEd.Name    := mFLD;
            mVEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mVEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       3: begin
            mQEd         := TQuantEdit.Create(mForm);
            mQEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_QuantEdit')
                       else mFld:= 'E_'+mFld;
            mQEd.Name    := mFLD;
            mQEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mQEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       4: begin
            mBEd         := TBarCodeEdit.Create(mForm);
            mBEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_BarcodeEdit')
                       else mFld:= 'E_'+mFld;
            mBEd.Name    := mFLD;
            mBEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mBEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       5: begin
            mTEd         := TVatEdit.Create(mForm);
            mTEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_VatEdit')
                       else mFld:= 'E_'+mFld;
            mTEd.Name    := mFLD;
            mTEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mTEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       6: begin
            mNEd         := TNameEdit.Create(mForm);
            mNEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_NameEdit')
                       else mFld:= 'E_'+mFld;
            mNEd.Name    := mFLD;
            mNEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mNEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       7: begin
            mCEd         := TCodeEdit.Create(mForm);
            mCEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_CodeEdit')
                       else mFld:= 'E_'+mFld;
            mCEd.Name    := mFLD;
            mCEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mCEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
            // zrusit pridruzeny komponent
            oLB_Components[i+1] := 'DELETED';
          end;
       8: begin
            mLEd         := TLongEdit.Create(mForm);
            mLEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_LongEdit')
                       else mFld:= 'E_'+mFld;
            mLEd.Name    := mFLD;
            mLEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mLEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
      11: begin
            mDEd         := TPrcEdit.Create(mForm);
            mDEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_PrcEdit')
                       else mFld:= 'E_'+mFld;
            mDEd.Name    := mFLD;
            mDEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mDEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
          end;
       10: begin
            oLB_Components[i] := 'DELETED';
          end;
          else begin // toto je vlastne 9
            (*
            mDBEdit         := TDBEdit.Create(mForm);
            mDBEdit.Parent  := mParent;
            mDBEdit.Name    := GetFreeComponentName(mForm,'DBEdit');
            mDBEdit.AutoSize:= FALSE;
            mDBEdit.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mDBEdit.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
            mDBEdit.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
            mDBEdit.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
            SetDataSF(mDBEdit, LineElement(mLineStr,6,'|')); //A data field es data source beallitasa
      //    mDBEdit.DataField := LineElement(mLineStr,5,'|');
            *)
            mNEd         := TNameEdit.Create(mForm);
            mNEd.Parent  := mParent;
            If mFld='' then mFld:= GetFreeComponentName(mForm,'E_NameEdit')
                       else mFld:= 'E_'+mFld;
            mNEd.Name    := mFLD;
            mNEd.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
            mNEd.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
            mNEd.Width   :=  StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
            mNEd.MaxLength:= StrToInt(LineElement(mLineStr,3,'|'));
          end;
      end; // case
    end else if mComponentTypeStr = 'TCHECKBOX' then begin
      mCheckBox         := TCheckBox.Create(mForm);
      mCheckBox.Parent  := mParent;
      mCheckBox.Name    := GetFreeComponentName(mForm,'CheckBox_');
      mCheckBox.Caption := LineElement(mLineStr,5,'|');
      mCheckBox.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mCheckBox.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mCheckBox.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
    end else if (mComponentTypeStr = 'TDBCHECKBOX') or (mComponentTypeStr = 'TDBRADIOBUTTON') then begin
      mDBCheckBox         := TDBCheckBox.Create(mForm);
      mDBCheckBox.Parent  := mParent;
      mDBCheckBox.Name    := GetFreeComponentName(mForm,'DBCheckBox_');
      mDBCheckBox.Caption := LineElement(mLineStr,5,'|');
      mDBCheckBox.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mDBCheckBox.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mDBCheckBox.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
      SetDataSF(mDBCheckBox, LineElement(mLineStr,6,'|')); //A data field es data source beallitasa
    end else if mComponentTypeStr = 'TRADIOBUTTON' then begin
      mRadioButton         := TRadioButton.Create(mForm);
      mRadioButton.Parent  := mParent;
      mRadioButton.Name    := GetFreeComponentName(mForm,'RadioButton_');
      mRadioButton.Caption := LineElement(mLineStr,5,'|');
      mRadioButton.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mRadioButton.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mRadioButton.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
//      mRadioButton.Height  := 12;
    end else if mComponentTypeStr = 'TBUTTON' then begin
      If (POS('OK',LineElement(mLineStr,5,'|'))=0) then begin
        mButton         := TBitBtn.Create(mForm);
        mButton.Parent  := mParent;
        mButton.Name    := GetFreeComponentName(mForm,'Button_');
        mButton.Caption := LineElement(mLineStr,5,'|');
        mButton.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal -oFaktorHorizontal div 2;
        mButton.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
        mButton.Width   := 100; //deleted 2000.5.3. StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
        mButton.Height  := 22; //deleted 2000.5.3. StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
      end else begin
        mOKButton         := TOKButton.Create(mForm);
        mOKButton.Parent  := mParent;
        mOKButton.Name    := GetFreeComponentName(mForm,'OKButton_');
        mOKButton.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal -oFaktorHorizontal div 2;
        mOKButton.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      end
    end else if (mComponentTypeStr = 'TDATEPICKER') or (mComponentTypeStr = 'TDBDATEPICKER')then begin
      mDateTimePicker         := TDateTimePicker.Create(mForm);
      mDateTimePicker.Parent  := mParent;
      mDateTimePicker.Name    := GetFreeComponentName(mForm,'DateTimePicker_');
      mDateTimePicker.Kind    := dtkDate;
      mDateTimePicker.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mDateTimePicker.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mDateTimePicker.Width   := (StrToInt(LineElement(mLineStr,3,'|'))+1)*oFaktorHorizontal;
      mDateTimePicker.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
    end else if (mComponentTypeStr = 'TTIMEPICKER') or (mComponentTypeStr = 'TDBTIMEPICKER') then begin
      mDateTimePicker         := TDateTimePicker.Create(mForm);
      mDateTimePicker.Parent  := mParent;
      mDateTimePicker.Name    := GetFreeComponentName(mForm,'DateTimePicker_');
      mDateTimePicker.Kind    := dtkTime;
      mDateTimePicker.DateMode:= dmUpDown;
      mDateTimePicker.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mDateTimePicker.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mDateTimePicker.Width   := (StrToInt(LineElement(mLineStr,3,'|'))+1)*oFaktorHorizontal;
      mDateTimePicker.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
    end else if mComponentTypeStr = 'TDBCOMBOBOX' then begin
      mDBComboBox         := TDBComboBox.Create(mForm);
      mDBComboBox.Parent  := mParent;
      mDBComboBox.Name    := GetFreeComponentName(mForm,'DBComboBox_');
      mDBComboBox.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mDBComboBox.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mDBComboBox.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
      mComboBoxItems    := LineElement(mLineStr,5,'|');
      mComboBoxItemNum  := LineElementNum(mComboBoxItems,',');
      if mComboBoxItemNum >0 then for j := 0 to mComboBoxItemNum-1 do begin
        mDBComboBox.Items.Add(LineElement(mComboBoxItems,j,','));
      end;
      SetDataSF(mDBComboBox, LineElement(mLineStr,6,'|')); //A data field es data source beallitasa
    end else if mComponentTypeStr = 'TCOMBOBOX' then begin
      mComboBox         := TComboBox.Create(mForm);
      mComboBox.Parent  := mParent;
      mComboBox.Name    := GetFreeComponentName(mForm,'ComboBox_');
      mComboBox.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal;
      mComboBox.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical;
      mComboBox.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
      mComboBoxItems    := LineElement(mLineStr,5,'|');
      mComboBoxItemNum  := LineElementNum(mComboBoxItems,',');
      if mComboBoxItemNum >0 then for j := 0 to mComboBoxItemNum-1 do begin
        mComboBox.Items.Add(LineElement(mComboBoxItems,j,','));
      end;
//    end else if mComponentTypeStr = 'TPANEL' then begin
//      mPanel         := TPanel.Create(mForm);
//      mPanel.Parent  := mParennt;
//      mPanel.Name    := GetFreeComponentName(mForm, 'Panel');
//      mPanel.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal + oFaktorHorizontal div 2;
//      mPanel.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical + oFaktorVertical div 2;
//      mPanel.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
//      mPanel.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
//      mPanel.SendToBack;
    end else if mComponentTypeStr = 'TGROUPBOX' then begin
      mGroupBox         := TGroupBox.Create(mForm);
      mGroupBox.Parent  := mParent;
      mGroupBox.Name    := GetFreeComponentName(mForm, 'GroupBox_');

      mGroupBox.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal - oFaktorHorizontal div 2;
      mGroupBox.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical + oFaktorVertical div 2;
      mGroupBox.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
      mGroupBox.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
      mGroupBox.Caption := LineElement(mLineStr,5,'|');

   end else if (mComponentTypeStr = 'TLINE') or (mComponentTypeStr = 'TPANEL') then begin
      mBevel         := TBevel.Create(mForm);
      mBevel.Parent  := mParent;
      mBevel.Name    := GetFreeComponentName(mForm, 'Bevel_');
      mBevel.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal - oFaktorHorizontal div 2;
      mBevel.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical + oFaktorVertical div 2;
      mBevel.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal;
      if mBevel.Width <= oFaktorHorizontal then mBevel.Width := 2;
      mBevel.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical;
      if mBevel.Height <= oFaktorVertical then mBevel.Height := 2;
      mBevel.Shape   := bsFrame;
      mBevel.SendToBack;
    end else if (mComponentTypeStr = 'TFORM') then begin
//      mParent.Left    := StrToInt(LineElement(mLineStr,1,'|'))*oFaktorHorizontal + oFaktorHorizontal div 2;
//      mParent.Top     := StrToInt(LineElement(mLineStr,2,'|'))*oFaktorVertical + oFaktorVertical div 2;
      mParent.Width   := StrToInt(LineElement(mLineStr,3,'|'))*oFaktorHorizontal + 2*oFaktorHorizontal;
      mParent.Height  := StrToInt(LineElement(mLineStr,4,'|'))*oFaktorVertical + 2*oFaktorVertical;
      if (mParent is TForm) then begin
        mForm.Caption := LineElement(mLineStr,5,'|');
      end else begin
        mPanel         := TPanel.Create(mForm);
        mPanel.Parent  := mParent;
        mPanel.Name    := GetFreeComponentName(mForm, 'Panel_');
        mPanel.Height  := 25;
        mPanel.Align   := alTop;
        mPanel.BevelOuter := bvNone;
        mPanel.Caption := LineElement(mLineStr,5,'|');
      end;
    end;
  end;
  If UseINIFile then oIniFile.Free;
end;

function TSCFConvertor.FldToEdittype;
var
  mName,mFld1,mFld2 : String;
  mForm : TF_FldEditSlct;
  mType : integer;
  mSelected:boolean;
begin
  If LineElementNum(pLineStr,'.')=2
    then mFld1:=LineElement(pLineStr,1,'.')  // napr. MGCODE.MGCODE
    else mFld1:=LineElement(pLineStr,2,'.'); // napr. *.MGCODE.MGNAME.MGCODE
  If LineElementNum(pLineStr2,'.')=2
    then mFld2:=LineElement(pLineStr2,1,'.')  // napr. MGCODE.MGCODE
    else mFld2:=LineElement(pLineStr2,2,'.'); // napr. *.MGCODE.MGNAME.MGCODE
  mType:=0;
  mSelected:=FALSE;
  If oUseINIFile then begin
    mName := oIniFIle.ReadString('DOUBLE',mFld1+'-'+mFld2,'');
    If mName<>'' then begin
      If mName[1]<>'*' then mSelected:=TRUE;
      mType:=7;
    end else begin
      mName := oIniFIle.ReadString('SINGLE',mFld1,'');
      If mName<>'' then begin
        If mName[1]<>'*' then begin
          mSelected:=TRUE;
          mType:=StrToInt(mName);
        end else mType:=StrToInt(Copy(mName,2,255));
      end;
    end;
  end;
  If not mSelected then begin
    If mType=0 then begin
      If oUseINIFile then begin
        If (LineElementInString(oIniFile.ReadString('FLD','PRICE','PRICE'),      mFld1,',')>=0) then mType:=1 else
        If (LineElementInString(oIniFile.ReadString('FLD','VALUE','VAL,VALUE'),  mFld1,',')>=0) then mType:=2 else
        If (LineElementInString(oIniFile.ReadString('FLD','QUANT','QNT,QUANT'),  mFld1,',')>=0) then mType:=3 else
        If (LineElementInString(oIniFile.ReadString('FLD','BARCODE','BARCODE'),  mFld1,',')>=0) then mType:=4 else
        If (LineElementInString(oIniFile.ReadString('FLD','VATPR','VATPRC'),     mFld1,',')>=0) then mType:=5 else
        If (LineElementInString(oIniFile.ReadString('FLD','PRC','DSCPRC,PROFIT'),mFld1,',')>=0) then mType:=11 else
        If (POS('NUM',    mFld1)>0) and  (POS('NAME',mFld2)>0)
        or (POS('NUM',    mFld2)>0) and  (POS('NAME',mFld1)>0)
        or (POS('CODE',   mFld1)>0) and  (POS('NAME',mFld2)>0)
        or (POS('CODE',   mFld2)>0) and  (POS('NAME',mFld1)>0) then mType:=7 else
        If (LineElementInString(oIniFile.ReadString('FLD','NAME','NAME'),      mFld1,',')>=0) then mType:=6  else
        If (LineElementInString(oIniFile.ReadString('FLD','LONG','CODE'),      mFld1,',')>=0) then mType:=8  else
        If (LineElementInString(oIniFile.ReadString('FLD','DELETE','****'),        mFld1,',')>=0) then mType:=10
        else mType:=9;
      end else begin
        If (LineElementInString('PRICE',        mFld1,',')>=0) then mType:=1 else
        If (LineElementInString('VAL,VALUE',    mFld1,',')>=0) then mType:=2 else
        If (LineElementInString('QNT,QUANT',    mFld1,',')>=0) then mType:=3 else
        If (LineElementInString('BARCODE',      mFld1,',')>=0) then mType:=4 else
        If (LineElementInString('VATPRC',       mFld1,',')>=0) then mType:=5 else
        If (LineElementInString('DSCPRC,PROFIT',mFld1,',')>=0) then mType:=11 else
        If (POS('NUM',    mFld1)>0) and  (POS('NAME',mFld2)>0)
        or (POS('NUM',    mFld2)>0) and  (POS('NAME',mFld1)>0)
        or (POS('CODE',   mFld1)>0) and  (POS('NAME',mFld2)>0)
        or (POS('CODE',   mFld2)>0) and  (POS('NAME',mFld1)>0) then mType:=7 else
        If (LineElementInString('NAME',     mFld1,',')>=0) then mType:=6 else
        If (LineElementInString('CODE',     mFld1,',')>=0) then mType:=8 else
        If (LineElementInString('****',     mFld1,',')>=0) then mType:=10
        else mType:=9;
      end;
      (*
      If (POS('PRICE',  mFld1)>0) then mType:=1 else
      If (POS('VAL',    mFld1)>0) or (POS('VALUE',mFld1)>0) then mType:=2 else
      If (POS('QNT',    mFld1)>0) or (POS('QUANT',mFld1)>0) then mType:=3 else
      If (POS('BARCODE',mFld1)>0) then mType:=4 else
      If (POS('VATPRC' ,mFld1)>0) then mType:=5 else
      If (POS('NUM',    mFld1)>0) and  (POS('NAME',mFld2)>0)
      or (POS('NUM',    mFld2)>0) and  (POS('NAME',mFld1)>0)
      or (POS('CODE',   mFld1)>0) and  (POS('NAME',mFld2)>0)
      or (POS('CODE',   mFld2)>0) and  (POS('NAME',mFld1)>0) then mType:=7 else
      If (POS('NAME' ,  mFld1)>0) then mType:=6 else
      If (POS('CODE' ,  mFld1)>0) then mType:=8 else mType:=9;
      *)
    end;
    If oVerifyComp then begin
      mForm:=TF_FldEditSlct.Create(Self);
      mSelected:=FALSE;
      mType:=mForm.Execute(mFld1,mFld2,mType,mSelected);
      mForm.free;
      If oUseINIFile then begin
        mName:=IntToStr(mType);
        If not mSelected then mName:='*'+mName;
        If mType=7
          then oIniFile.WriteString('DOUBLE',mFld1+'-'+mFld2,mName)
          else oIniFile.WriteString('SINGLE',mFld1,mName);
      end;
    end;
  end;
  Result:=mType;
end;

{ TAgyLanguageComponentEditor }
function TSCFConvertorEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

function TSCFConvertorEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result := 'by AgySoft';
    1: Result := 'Inport SCF (Txt) file';
    2: Result := 'Empty';
  end;
end;

procedure TSCFConvertorEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0: MessageDlg('Version 1.0' + #13 + 'Created by Mgr. Nagy László', mtInformation, [mbOk], 0);
    1: (Component as TSCFConvertor).Inport;
    2: ;
  end;
end;

procedure TSCFConvertorEditor.Edit;
begin
  MessageDlg('Version 1.0' + #13 + 'Created by Mgr. Nagy László', mtInformation, [mbOk], 0);
end;

procedure Register;
begin
  RegisterComponents('Extern', [TSCFConvertor]);
  RegisterComponentEditor(TSCFConvertor, TSCFConvertorEditor)
end;

end.
