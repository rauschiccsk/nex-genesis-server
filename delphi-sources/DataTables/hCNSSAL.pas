unit hCNSSAL;

interface

uses
  IcTypes, NexPath, NexGlob, tCNSSAL,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCNSSALHnd = class (TCNSSALTmp)
  private
    oPrcA   : array [1..10] of double;
    oDscA   : array [1..10] of double;
    oPrcN   : array [1..10] of String[20];
    oDscN   : array [1..10] of String[20];
    oPrcCnt : byte;
    oDscCnt : byte;
  public
    procedure Open; override;
    procedure InsertItem(pGsCode:longint;pDscPrc,pBPrice,pQnt:double);
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TCNSSALHnd.InsertItem(pGsCode:longint;pDscPrc,pBPrice,pQnt:double);
var I:byte;
begin
  Edit;BPrice:=pBPrice;Post;
  If pDscPrc>0then begin
    for I:=oDscCnt downto 1 do begin
      If pDscPrc>=oDscA[I] then begin
        Edit;
        TmpTable.FieldByName(oDscN[I]).AsFloat:=TmpTable.FieldByName(oDscN[I]).AsFloat+pQnt;
        Post;
        Break;
      end;
    end;
  end else begin
    for I:=1 to oPrcCnt do begin
      If pBPrice<=oPrcA[I] then begin
        Edit;
        TmpTable.FieldByName(oPrcN[I]).AsFloat:=TmpTable.FieldByName(oPrcN[I]).AsFloat+pQnt;
        Post;
        Break;
      end;
    end;
  end
end;

procedure TCNSSALHnd.Open;
var I:byte;
begin
  inherited;
  oPrcCnt:=0;oDscCnt:=0;FillChar(oPrcA,SIZEof(oPrcA),0);FillChar(oDscA,SIZEof(oDscA),0);
  For I:=0 to TmpTable.FieldCount-1 do begin
    If Pos('BPrice_',TmpTable.FieldDefs[I].Name)=1 then begin
      Inc(oPrcCnt);oPrcN[oPrcCnt]:=TmpTable.FieldDefs[I].Name;
      oPrcA[oPrcCnt]:=StrToFloat(Copy(TmpTable.FieldDefs[I].Name,8,10))/100;
    end;
    If Pos('DscPrc_',TmpTable.FieldDefs[I].Name)=1 then begin
      Inc(oDscCnt);oDscN[oDscCnt]:=TmpTable.FieldDefs[I].Name;
      oDscA[oDscCnt]:=StrToFloat(Copy(TmpTable.FieldDefs[I].Name,8,10));
    end;
  end;
end;

end.
