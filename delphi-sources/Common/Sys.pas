unit Sys;
{$F+}

// *****************************************************************************
//                      SYSTÉMOVÉ ÚDAJE A DATABÁZOCÉ SÚBORY
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConv, IcTools, IcVariab,
  hUSRLST,
  SysUtils, Forms;

type
  TSys=class
    constructor Create;
    destructor Destroy; override;
    private
      ohUSRLST:TUsrlstHnd;
    public
      function UsrNum(pUsrLgn:Str8):word;
      function UsrNam(pUsrNum:word):Str30; overload;
      function UsrNam(pUsrLgn:Str8):Str30; overload;
      function UsrLev(pUsrLgn:Str8):byte; overload;
      function UsrLev(pUsrNum:word):byte; overload;
    published
  end;

implementation

uses bUSRLST;

constructor TSys.Create;
begin
  ohUSRLST:=TUsrlstHnd.Create;
end;

destructor TSys.Destroy;
begin
  FreeAndNil(ohUSRLST);
end;

// ********************************* PRIVATE ***********************************


// ********************************** PUBLIC ***********************************

function TSys.UsrNum(pUsrLgn:Str8):word;
begin
  Result:=0;
  If not ohUSRLST.Active then ohUSRLST.Open;
  If ohUSRLST.LocateLoginName(pUsrLgn) then Result:=ohUSRLST.UsrNum;
end;

function TSys.UsrNam(pUsrNum:word):Str30;
begin
  Result:='';
  If not ohUSRLST.Active then ohUSRLST.Open;
//  If ohUSRLST.LocateUsrNum(pUsrNum) then Result:=ohUSRLST.LoginName;
end;

function TSys.UsrNam(pUsrLgn:Str8):Str30;
begin
  Result:='';
  If not ohUSRLST.Active then ohUSRLST.Open;
  If ohUSRLST.LocateLoginName(pUsrLgn) then Result:=ohUSRLST.LoginName;
end;

function TSys.UsrLev(pUsrLgn:Str8):byte;
begin
  Result:=0;
  If not ohUSRLST.Active then ohUSRLST.Open;
  If ohUSRLST.LocateLoginName(pUsrLgn) then Result:=ohUSRLST.UsrLev;
end;

function TSys.UsrLev(pUsrNum:word):byte;
begin
  Result:=0;
  If not ohUSRLST.Active then ohUSRLST.Open;
//  If ohUSRLST.LocateLoginName(pUsrLgn) then Result:=ohUSRLST.UsrLev;
end;

end.
