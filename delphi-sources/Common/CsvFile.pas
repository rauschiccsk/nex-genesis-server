unit CsvFile;
/// ******************************************************************************************************************************
/// ******************************************************************************************************************************
///
///                                                 Copyright(c) 2024 ICC, s.r.o.
///                                                      All rights reserved
///
/// ----------------------------------------------------- UNIT DESCRIPTION -------------------------------------------------------
/// ==============================================================================================================================
/// ----------------------------------------------------- RELATED DOCUMENTS ------------------------------------------------------
/// ------------------------------------------------------ VERSION HISTPRY -------------------------------------------------------
/// 1.0 - Initial version (created by: Zoltan Rausch) on 01.06.2024
/// ==============================================================================================================================

interface

uses
  {Delphi} Classes, SysUtils,
  {NEX}    IcConv;

type
  TCsvFile = class
  private
    function GetLineCount:Longint;
    function GetLineData:String;
  public
    oLineIndex:Longint;
    oCsvFile:TStringList;
    constructor Create;
    destructor Destroy;
    procedure LoadFromFile(pFileName:String);
    procedure First;
    procedure Prev;
    procedure Next;
    procedure Last;
    function Eof:Boolean;

    property LineCount:Longint read GetLineCount;
    property LineData:String read GetLineData;
  end;

implementation

// -------------------------------------------------- PUBLIC METHODS ---------------------------------------------------

constructor TCsvFile.Create;
begin
  inherited Create;
  oCsvFile := TStringList.Create;
end;

destructor TCsvFile.Destroy;
begin
  FreeAndNil(oCsvFile);
  inherited Destroy;
end;

procedure TCsvFile.LoadFromFile(pFileName:String);
begin
  if FileExists(pFileName) then oCsvFile.LoadFromFile(pFileName);
end;

procedure TCsvFile.First;
begin
  oLineIndex := 0;
end;

procedure TCsvFile.Prev;
begin
  if oLineIndex > 0 then Dec(oLineIndex);
end;

procedure TCsvFile.Next;
begin
  if oLineIndex < LineCount then Inc(oLineIndex);
end;

procedure TCsvFile.Last;
begin
  oLineIndex := LineCount-1;
end;

function TCsvFile.Eof:Boolean;
begin
  Result := oLineIndex = LineCount;
end;

// -------------------------------------------------- PRIVATE METHODS --------------------------------------------------

function TCsvFile.GetLineCount:Longint;
begin
  Result := oCsvFile.Count;
end;

function TCsvFile.GetLineData:String;
begin
  Result := oCsvFile.Strings[oLineIndex];
end;

end.

