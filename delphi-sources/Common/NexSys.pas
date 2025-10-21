unit NexSys;

interface

uses
  IcVariab, IcTypes, NexIni, NexError, NexMsg;

  function IsStkCls (pDate:TDateTime):boolean; // Uzavierka skladovych dokladov - ak datum zapada do uzatvoreneho obdobia hodnota funkcie je TRUE
  function IsSabCls (pDate:TDateTime):boolean; // Uzavierka dokladov MO predaja - ak datum zapada do uzatvoreneho obdobia hodnota funkcie je TRUE
  function IsAccCls (pDate:TDateTime):boolean; // Uzavierka uctovnych dokladov - ak datum zapada do uzatvoreneho obdobia hodnota funkcie je TRUE

  function GetSysInfo:string; // Rok - Firma - Uzivatel
  function GetLastBook (pBookType:Str3; pBookNum:Str5): Str5; // Vrati cislo naposledy pouzitej knihy
  procedure SaveLastBook (pBookType:Str3; pBookNum:Str5); // Ulozi cislo naposledy pouzitej knihy

implementation

uses
  DM_SYSTEM;

function IsStkCls (pDate:TDateTime):boolean; // Uzavierka skladovych dokladov - ak datum zapada do uzatvoreneho obdobia hodnota funkcie je TRUE
begin
  Result := pDate<=gIni.GetStkClsDate;  
  If Result then ShowMsg (ecSysThisDateInClsPeriod,'');
end;

function IsSabCls (pDate:TDateTime):boolean; // Uzavierka dokladov MO predaja - ak datum zapada do uzatvoreneho obdobia hodnota funkcie je TRUE
begin
  Result := pDate<=gIni.GetSabClsDate;
  If Result then ShowMsg (ecSysThisDateInClsPeriod,'');
end;

function IsAccCls (pDate:TDateTime):boolean; // Uzavierka uctovnych dokladov - ak datum zapada do uzatvoreneho obdobia hodnota funkcie je TRUE
begin
  Result := pDate<=gIni.GetAccClsDate;
  If Result then ShowMsg (ecSysThisDateInClsPeriod,'');
end;

function GetSysInfo:string; // Rok - Firma - Uzivatel
begin
  Result := ' - '+gvSys.ActYear+' - '+gvSys.FirmaName+' - '+gvSys.UserName;
end;

function GetLastBook (pBookType:Str3; pBookNum:Str5): Str5; // Vrati cislo naposledy pouzitej knihy
begin
  If cNexStart and (pBookNum='') then pBookNum:=gvSys.ActYear2+'001';
  dmSYS.btLASTBOOK.Open;
  If dmSYS.btLASTBOOK.FindKey ([gvSys.LoginName,pBookType]) then begin
    If dmSYS.btLASTBOOK.FieldByName ('BookNum').AsString<>''
      then Result := dmSYS.btLASTBOOK.FieldByName ('BookNum').AsString
      else Result := pBookNum;
  end
  else Result := pBookNum;
  dmSYS.btLASTBOOK.Close;
end;

procedure SaveLastBook (pBookType:Str3; pBookNum:Str5); // Ulozi cislo naposledy pouzitej knihy
begin
  dmSYS.btLASTBOOK.Open;
  try
    If dmSYS.btLASTBOOK.FindKey ([gvSys.LoginName,pBookType]) then begin
      dmSYS.btLASTBOOK.Edit;
      dmSYS.btLASTBOOK.FieldByName ('BookNum').AsString := pBookNum;
      dmSYS.btLASTBOOK.Post;
    end
    else begin
      dmSYS.btLASTBOOK.Insert;
      dmSYS.btLASTBOOK.FieldByName ('Loginname').AsString := gvSys.LoginName;
      dmSYS.btLASTBOOK.FieldByName ('BookType').AsString := pBookType;
      dmSYS.btLASTBOOK.FieldByName ('BookNum').AsString := pBookNum;
      dmSYS.btLASTBOOK.Post;
    end;
  except end;  
  dmSYS.btLASTBOOK.Close;
end;

end.
