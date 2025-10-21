unit LinkBtrTable;

interface

uses
  IcTypes, IcConv, BtrTable, NexPath, NexMsg, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db;

type
  TLinkBtrTable = class(TNexBtrTable)
  private
    oUseMain: boolean;     // TRUE ak sa pouziva spolocny databazovy subor
    btMAIN: TNexBtrTable;  // Hlavny (spolocny) databazovy subor
  public
    procedure Open; overload;
    procedure Close; overload;
    procedure Post; overload;
    procedure Delete; overload;
  published
    property MainDataSet: TNexBtrTable read btMAIN write btMAIN;
  end;

procedure Register;

implementation

procedure TLinkBtrTable.Open;
begin
  inherited Open;
  oUseMain := (btMAIN<>nil) and (btMAIN.TableName<>TableName);
  If oUseMain then btMAIN.Open;
end;

procedure TLinkBtrTable.Close;
begin
  inherited Close;
  If oUseMain then btMAIN.Close;
end;

procedure TLinkBtrTable.Post;
begin
  // Ulozime udaje do spolocneho sunoru
  If oUseMain then begin
    If btMAIN.GotoPos (FieldByName('ActPos').AsInteger) then begin
      btMAIN.Edit;
      Move (ActiveBuffer[0], btMAIN.ActiveBuffer[0],RecordSize);
      btMAIN.Post;
    end
    else begin
      btMAIN.Insert;
      Move (ActiveBuffer[0], btMAIN.ActiveBuffer[0],RecordSize);
      btMAIN.Post;
    end;
    FieldByName ('ActPos').AsInteger := btMAIN.ActPos; // Zapametame ActPos rekordu zo spolocnej databaze
  end;
  // Ulozime udaje do knihy
  inherited Post;
end;

procedure TLinkBtrTable.Delete;
begin
  If oUseMain then  begin
    If btMAIN.GotoPos (FieldByName('ActPos').AsInteger) then btMAIN.Delete;
  end;
  inherited Delete;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TLinkBtrTable]);
end;

end.
