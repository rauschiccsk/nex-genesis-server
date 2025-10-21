unit hCah;

interface

uses
  IcTypes, NexPath, NexGlob, bCah,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TCahHnd = class (TCahBtr)
  private
    procedure PutBegVal_ (pNum:byte; pValue:double);
    procedure PutPayName_(pNum:byte; pName:Str20);
    procedure PutTrnVal_ (pNum:byte; pValue:double);
    procedure PutIncVal_ (pNum:byte; pValue:double);
    procedure PutExpVal_ (pNum:byte; pValue:double);
    procedure PutChIVal_ (pNum:byte; pValue:double);
    procedure PutChEVal_ (pNum:byte; pValue:double);
    function  GetBegVal_ (pNum:byte):double;
    function  GetPayName_(pNum:byte):Str20;
    function  GetTrnVal_ (pNum:byte):double;
    function  GetIncVal_ (pNum:byte):double;
    function  GetExpVal_ (pNum:byte):double;
    function  GetChIVal_ (pNum:byte):double;
    function  GetChEVal_ (pNum:byte):double;
  public
    property BegVal_[pNum:byte]:double read GetBegVal_  write PutBegVal_;
    property ExpVal_[pNum:byte]:double read GetExpVal_  write PutExpVal_;
    property IncVal_[pNum:byte]:double read GetIncVal_  write PutIncVal_;
    property TrnVal_[pNum:byte]:double read GetTrnVal_  write PutTrnVal_;
    property ChIVal_[pNum:byte]:double read GetChIVal_  write PutChIVal_;
    property ChEVal_[pNum:byte]:double read GetChEVal_  write PutChEVal_;
    property PayName_[pNum:byte]:Str20  read Getpayname_ write PutPayName_;
  published
  end;

implementation

uses DB;

{ TCahHnd }

procedure TCahHnd.PutBegVal_(pNum: byte; pValue: double);
begin
  BtrTable.FieldByName('BegVal'+IntToStr(pNum)).AsFloat := pValue;
end;

procedure TCahHnd.PutExpVal_(pNum: byte; pValue: double);
begin
  BtrTable.FieldByName('ExpVal'+IntToStr(pNum)).AsFloat := pValue;
end;

procedure TCahHnd.PutChEVal_(pNum: byte; pValue: double);
begin
  BtrTable.FieldByName('ChEVal'+IntToStr(pNum)).AsFloat := pValue;
end;

procedure TCahHnd.PutChIVal_(pNum: byte; pValue: double);
begin
  BtrTable.FieldByName('ChIVal'+IntToStr(pNum)).AsFloat := pValue;
end;

procedure TCahHnd.PutIncVal_(pNum: byte; pValue: double);
begin
  BtrTable.FieldByName('IncVal'+IntToStr(pNum)).AsFloat := pValue;
end;

procedure TCahHnd.PutPayName_(pNum: byte; pName: Str20);
begin
  BtrTable.FieldByName('PayName'+IntToStr(pNum)).AsString := pName;
end;

procedure TCahHnd.PutTrnVal_(pNum: byte; pValue: double);
begin
  BtrTable.FieldByName('TrnVal'+IntToStr(pNum)).AsFloat := pValue;
end;

function TCahHnd.GetBegVal_(pNum: byte): double;
begin
  Result:=BtrTable.FieldByName('BegVal'+IntToStr(pNum)).AsFloat;
end;

function TCahHnd.GetExpVal_(pNum: byte): double;
begin
  Result:=BtrTable.FieldByName('ExpVal'+IntToStr(pNum)).AsFloat;
end;

function TCahHnd.GetChEVal_(pNum: byte): double;
begin
  Result:=BtrTable.FieldByName('ChEVal'+IntToStr(pNum)).AsFloat;
end;

function TCahHnd.GetChIVal_(pNum: byte): double;
begin
  Result:=BtrTable.FieldByName('ChIVal'+IntToStr(pNum)).AsFloat;
end;

function TCahHnd.GetIncVal_(pNum: byte): double;
begin
  Result:=BtrTable.FieldByName('IncVal'+IntToStr(pNum)).AsFloat;
end;

function TCahHnd.GetPayName_(pNum: byte): Str20;
begin
  Result:=BtrTable.FieldByName('PayName'+IntToStr(pNum)).AsString;
end;

function TCahHnd.GetTrnVal_(pNum: byte): double;
begin
  Result:=BtrTable.FieldByName('TrnVal'+IntToStr(pNum)).AsFloat;
end;

end.
