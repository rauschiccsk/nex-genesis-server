unit HdsBtrTable;

interface

uses
  IcTypes, IcConv, IcVariab, BtrTable, NexPath, NexMsg, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db;

type
  THdsBtrTable = class(TNexBtrTable)
  private
    oModDataSet: TNexBtrTable;  // Subor modifikovanych udajov MOD
    oDelDataSet: TNexBtrTable;  // Subor Zrusenych udajov DEL
    oModSave: boolean; // Ak je TRUE ukladaju sa modifikacie
    oDelSave: boolean; // Ak je TRUE ukladaju sa zrusene zaznamy
    oModMyOpen: boolean;  // TRUE ak databazu MOD sme otvorili v tomto objekte
    oDelMyOpen: boolean;  // TRUE ak databazu MOD sme otvorili v tomto objekte
    oBefModBuffer: PChar;  // Na ulozenie zaznamu pred modifikaciou
    oBefModNum: word; // Poradove cilo modifikacie pred ulozenim aktualneho zaznamu
    oInsert: boolean; // TRUE ak je to novz zaznam
    procedure OpenModDataSet; // Otvory databazu modifikacii
    procedure OpenDelDataSet; // Otvory databazu zrusenych zaznamov
    function RecModify:boolean; // TRUE ak bola zistena modifikacia zaznamu
  public
    procedure Open; overload;
    procedure Close; overload;
    procedure Insert; overload;
    procedure Edit; overload;
    procedure Post; overload;
    procedure Delete; overload;
  published
    property ModDataSet: TNexBtrTable read oModDataSet write oModDataSet;
    property DelDataSet: TNexBtrTable read oDelDataSet write oDelDataSet;
    property ModSave: boolean read oModSave write oModSave;
    property DelSave: boolean read oDelSave write oDelSave;
  end;

procedure Register;

implementation

procedure THdsBtrTable.Open;
begin
  inherited Open;
  oBefModBuffer := AllocRecordBuffer;
  OpenModDataSet; // Otvory databazu modifikacii
  OpenDelDataSet; // Otvory databazu zrusenych zaznamov
end;

procedure THdsBtrTable.Close;
begin
  inherited Close;
  FreeRecordBuffer (oBefModBuffer);
  If oModMyOpen then begin
    oModDataSet.Close;
    FreeAndNil (oModDataSet);
  end;
  If oDelMyOpen then begin
    oDelDataSet.Close;
    FreeAndNil (oDelDataSet);
  end;
end;

procedure THdsBtrTable.Insert;
begin
  oInsert := TRUE; // Novy zaznam
  inherited Insert;
end;

procedure THdsBtrTable.Edit;
var mSrcBuffer:PChar;
begin
  oInsert := FALSE;
  oBefModNum := FieldByName ('ModNum').AsInteger;
  mSrcBuffer := GetRecordBuffer;
  Move (mSrcBuffer[0],oBefModBuffer^,GetRecordLen);
  inherited Edit;
end;

procedure THdsBtrTable.Post;
var mRecModify:boolean;
begin
  mRecModify := RecModify and not oInsert;
  If mRecModify then FieldByName ('ModNum').AsInteger := FieldByName ('ModNum').AsInteger+1;
  inherited Post;
  If oModSave then  begin
    If mRecModify then begin
      If oBefModNum=0 then begin // Ak je to prva modifikacia ulozime aj povodny zaznam
        oModDataSet.Insert;
        oModDataSet.SetRecordBuffer(oBefModBuffer);
        oModDataSet.FieldByName ('ModNum').AsInteger := oBefModNum;
        oModDataSet.Post;
        Inc (oBefModNum,1);
      end;
      oModDataSet.Insert;
      oModDataSet.SetRecordBuffer(GetRecordBuffer);
      oModDataSet.FieldByName ('ModNum').AsInteger := FieldByName ('ModNum').AsInteger;
      oModDataSet.Post;
    end;
  end;
end;

procedure THdsBtrTable.Delete;
begin
  If oDelSave then  begin
    oDelDataSet.Insert;
    oDelDataSet.SetRecordBuffer(GetRecordBuffer);
    oDelDataSet.FieldByName ('ModUser').AsString := gvSys.LoginName;
    oDelDataSet.FieldByName ('ModDate').AsDateTime := Date;
    oDelDataSet.FieldByName ('ModTime').AsString := TimeToStr(Time);
    oDelDataSet.Post;
  end;
  inherited Delete;
end;

//************************************* PRIVATE **********************************

procedure THdsBtrTable.OpenModDataSet; // Otvory databazu modifikacii
begin
  If oModSave then begin //Ak treba zapisovat modifikacie prekontrolujeme ci dtabaza je otvorena ked nie otvorime
    If oModDataSet=nil then begin
      oModMyOpen := TRUE;
      oModDataSet := TNexBtrTable.Create(Owner);
      oModDataSet.Name := Name+'MOD1';
      oModDataSet.DataBaseName := DataBaseName;
      oModDataSet.DefName := FixedName+'.MDF';
      oModDataSet.FixedName := FixedName;
      oModDataSet.AutoCreate := TRUE;
    end
    else oModMyOpen := oModDataSet.Active;
    If oModMyOpen then begin
      oModDataSet.TableName := TableName;
      oModDataSet.TableNameExt := 'MOD';
      oModDataSet.Open;
    end;
  end;
end;

procedure THdsBtrTable.OpenDelDataSet; // Otvory databazu modifikacii
begin
  If oDelSave then begin //Ak treba zapisovat zrusene zaznamy prekontrolujeme ci dtabaza je otvorena ked nie otvorime
    If oDelDataSet=nil then begin
      oDelMyOpen := TRUE;
      oDelDataSet := TNexBtrTable.Create(Owner);
      oDelDataSet.Name := Name+'DEL1';
      oDelDataSet.DataBaseName := DataBaseName;
      oDelDataSet.DefName := DefName;
      oDelDataSet.FixedName := FixedName;
    end
    else oDelMyOpen := oDelDataSet.Active;
    If oDelMyOpen then begin
      oDelDataSet.TableName := TableName;
      oDelDataSet.TableNameExt := 'DEL';
      oDelDataSet.Open;
    end;
  end;
end;

function THdsBtrTable.RecModify:boolean; // TRUE ak bola zistena modifikacia zaznamu
var mAftModBuffer:PChar;  I:word;  mBef,mAft:char;
begin
  Result := FALSE;
  mAftModBuffer := GetRecordBuffer;
  I := 0;
  Repeat
    Move (oBefModBuffer[I],mBef,1);
    Move (mAftModBuffer[I],mAft,1);
    If mAft<>mBef then Result := TRUE;
    Inc (I);
  until Result or (I=GetRecordLen);
end;


procedure Register;
begin
  RegisterComponents('IcDataAccess', [THdsBtrTable]);
end;

end.
