unit BtrStruct; // 01.07.2000
// Obsahuje Btrieve struktury

interface

const
  MY_THREAD_ID        = 50;
  cKeyToSQL: array[0..20] of string =
    ('CHARACTER',
     'INTEGER',
     'FLOAT',
     'DATE',
     'TIME',
     'DECIMAL',
     'MONEY',
     'LOGICAL',
     'NUMERIC',
     'BFLOAT',
     'LSTRING',
     'ZSTRING',
     'NOTE',
     'LVAR',
     'UNSIGNED',
     'AUTOINC',
     '',
     'NUMERICSTS',
     'NUMERICSA',
     'CURRENCY',
     'TIMESTAMP');
  { ami kimaradt:  BIT | CHAR | DEC | INT }
  

type
  PFile_DDF_Rec = ^TFile_DDF_Rec;
  TFile_DDF_Rec = packed record
    Xf_Id       : word;
    Xf_Name     : array [0..19] of char;
    Xf_Loc      : array [0..63] of char;
    Xf_Flags    : byte;
    Xf_Reserved : array [0..9] of char;
  end;

  PField_DDF_Rec = ^TField_DDF_Rec;
  TField_DDF_Rec = packed record
    Xe_Id       : word;
    Xe_File     : word;
    Xe_Name     : array [0..19] of char;
    Xe_DataType : byte;
    Xe_Offset   : word;
    Xe_Size     : word;
    Xe_Dec      : byte;
    Xe_Flags    : word;
  end;

  PIndex_DDF_Rec = ^TIndex_DDF_Rec;
  TIndex_DDF_Rec = packed record
    Xi_File     : word;
    Xi_Field    : word;
    Xi_Number   : word;
    Xi_Part     : word;
    Xi_Flags    : word;
  end;

  CLIENT_ID = packed record
    networkandnode : array[1..12] of char;
    applicationID  : array[1..3] of char;
    threadID       : smallint;
  end;

  FILE_SPECS = packed record
    RecordLength: smallint;
    PageSize    : smallint;
    SegmentCount: byte;
    UnUsed      : byte;
    RecordCount : LongWord;
    flags       : smallint;
    dupPointers : byte;
    notUsed     : byte;
    allocations : smallint;
  end;

  P_KEY_SPECS = ^KEY_SPECS;
  KEY_SPECS = packed record
    position    : smallint;
    length      : smallint;
    flags       : smallint;
    reserved    : array [0..3] of char;
    keyType     : char;
    nullChar    : char;
    notUsed     : array[0..1] of char;
    manualKeyNumber : byte;
    acsNumber   : byte;
  end;

  FILE_CREATE_BUF = packed record
    FileSpecs   : FILE_SPECS;
    KeySpecs    : array[0..255] of KEY_SPECS;
  end;

  STAT_REC   = FILE_CREATE_BUF;
  BTR_Status = SmallInt;
  BTR_Position_Block  = string[128];
  TBtrPosition = longint; //array[0..3] of byte;

implementation

end.
