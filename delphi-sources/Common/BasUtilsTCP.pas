unit BasUtilsTCP;

interface

  const
    zNul    = Chr (0);
    zSOH    = Chr (1);
    zSTX    = Chr (2);
    zETX    = Chr (3);
    zEOT    = Chr (4);
    zENQ    = Chr (5);
    zACK    = Chr (6);
    zHT     = Chr (9);
    zLF     = Chr (10);
    zVT     = Chr (11);
    zCR     = Chr (13);
    zDLE    = Chr (16);
    zDC1    = Chr (17);
    zDC2    = Chr (18);
    zDC3    = Chr (19);
    zDC4    = Chr (20);
    zNAK    = Chr (21);
    zETB    = Chr (23);
    zESC    = Chr (27);
    zFS     = Chr (28);
    zGS     = Chr (29);
    zRS     = Chr (30);
    zUS     = Chr (31);

    cCodes64 : array[0..65] of ShortString = (
              'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/',
              'G3edbC46gSluYvxOo2aIrj/wksNHEUZ1RM9VqPpFXzitmBWAT0LKJ8hyQfDn5c7+',
              'kHixVI0XSoQPRsEBg8AY3m6dCu4te/fDwpJFTqNa72yGOWvz9UhL5McZjKnb1+rl',
              'JpknaEom1l0F2eby4GZUqd7hQD+fMX3TWsL9/R5YSNxCOAHIzjBviwr8PctuV6gK',
              'epcgCoz/2P+MGTv5sHf1tnNjmaJriRLVlb7x4U89IEFBhkDquSWdAO6YwyKXZ3Q0',
              'cjXIzsCHdx56WNGARBLnJphQevZlTarw839PO1qtK7fV+SbDY20og4mUk/EMyiFu',
              'LAtghcV25lxnHw4B7/bfuCUQIoke6jGO9XNdT0paD+mYZrESvRWFKzP3MqsiJ18y',
              'F/GxSZ5TtcNHEouBdlICU69ArpWmvYPX2aL7JMwsDf0gnjV+RyQeb8hOiqKzk431',
              'yoZdbKN1uQ/YO0fercmkGjn3ILBv5FpR24HCUX8ti+VE6AlPhag7Jzq9DWSswTxM',
              'Ka0Slw/A8TLu2iU94o+6VcpW7HnJ5qMxXeCsPtkOQIGENjv1ZzmrFRdy3fgYhBbD',
              'W9tLiUMws/DmbSkZldeNCaIqygYv6JPBTK4HnxuhO2EF035G1cAVj7X+8RrpQfoz',
              'vOuYaVDIiCN0s278WShonX9qLdg4mzHBk3yflbeRQTGxwP+EFjMpr1cZ5J6AUt/K',
              '+ZwWhfDjKbVOrBN7M6zutmX/kln5cGoLd3YiqHgsJE8Q4avP9C0SAUeR1xyFTpI2',
              '84+zcr3gpTlLeKiCRUPQNo7OGskFB6jZhxn/vu91aSAEIfwbMXWqYd50HJV2Dtym',
              'wZuyGNjBcSUQ4zaKIxMWYOidntlAFTLkmfJ/hqoHE1g5rDV780psX6vRbC+e293P',
              '01qXeZQF657CUhRcWt+HbS/io8wYsP2jMpaxNDulEyJIV9LdGgmT4kv3OnzBrAfK',
              'wYvI/BgG3OSpAZLR96VQKUyEk+DeT0iXcFHPobJ1CM5qljn2zxt7hNsdmrf8W4au',
              'edCwL/8pYWbQFmGOIaNgflX0nqESHi2MABx4RJykstPKjur6z3o+c9VUD17vh5ZT',
              'Fx9M4gnmw3qYEjdPRUztT1ebNrDiLIAVJcW6y7Okf/vhlCZapsB50HQ82S+GoKuX',
              '+OJrPBvGjdm3uMAfKTobYRVgstZFxcw50QSq9NkL/HEzU7i6C8IyX1DeW2pl4nha',
              'zAgshNvbfB8lDSdUr6TEJ+9/q3i7njRLCyGxt5kIeMZu2HOpm0PYQVcFowa1X4WK',
              'cjL8WCYRtzx1NHDaBT5ZlmG3yVhi2oFKkveJUP/69XqAs+OuMb04SI7QdrpfgnwE',
              'BhlYntmbXOaF1MGowpfWyxc8j6RJ+U/kAvdzKHIe5PVNrLu7sq3DQT2gSiCE09Z4',
              '71SOTmoEKFbJjQUAcdthHlCe54a6IYqyn9Z/Dg8NvxBM2pwifkRu+GXrVLz3sPW0',
              'ztQ/yd8evPg7VJXF+TADWKLqxuUok4cEOmsb32fan615NG90IlZBrYHhwRSjMipC',
              'ikpVvPSWRB30nTqfxcj/OIYbtZ8175mKuLG6zgEDeFw9rUCMlhHQdo4aN+AX2Jsy',
              'QDxS4Jne/ypLtBYFHAhVPZgoM0d69bTUz15livc+K3awNuEI2R8fjrCXkGmOW7sq',
              'WHV/ZmJ9cRj0dGO7vgPLYpbUBFCwzr2SaNDyiIel4EQqThfKXtM+8xo15knAu63s',
              'c8M+hQWLZfOvxkDlpnmRePjCg/iUsH70w2I6tTy41uN9F5BYG3raJSdXVAzoKqEb',
              'c9i67G5w1gxK8dBb4TWQZvVauJmEDtnYSICLhpOF+eryNMURsA2HzkfP/lXjo0q3',
              'e1uzbV6lO+mncfdrGA7QXDvYqtgh9iCLHExRNMSB/WIaTk5P042pK8ZUyjFJos3w',
              '7fZ3JaetBgK1HSFR8Cply9nN2xicUuoT6hX0rqs5GdmkjYIvwL+W4AbOMQEVDPz/',
              'aIglXAGi+BQ23xtmRLOoPwUFhDZ9f4ETJ7sc10rS6N/zV5nWK8dvqyYCebkjHMpu',
              '2KGmuCfkMy618PaUTbnLo+V39IsW7qQiDwNpzvdr0ZgOjhAe5E/FcSJ4xlYtBRXH',
              'XSp8Avoz3NdW0GrVhBDaIZic4M5JnYkew7K2L6xf+CjmPUR1EFgsOT/QH9qytlub',
              'Vaw1UjyOpFeJSID3qf9gG+z5/YCLdBN26WrTmlbkXu0oH8tMxRsiPnA7ZKhvQcE4',
              'auUsDJYVRWxNbXiHojE9QAqzkZ+h3c7eCdSp/1fmlrBtIv5K8FTGn6PL0wyOM2g4',
              'dpgSveHo0IQzN4B6iEWqf/VmwuZaODytkl7YrcJC+8xjATUXKL3hF5P92RnbMsG1',
              'o3sjNvB+f9XUYMGC7e8g4r0ZSnkhlKzxLwRH/JPQya5m2FWEcA6V1IutDOidbTqp',
              'SUiynZQh+lstpHTqgKY6/FLXEV0u3Cm1BAD9xRjPI4waOzMfbW78G5cd2JorvNek',
              'GJ5WPHbp924x7ljKR+YTUgo0IVnyZFvMXkcf3qDmOSs6iE/BNw1ztr8QAChudeaL',
              '7z9+o0CycFI3fw/LRsudrVkg2T6SlPMnaAKbiOW58GNmtvqZ4hYDeEJHjpX1xQUB',
              '7/FqwyOG4oke5S8jEz6fgaHX0b3ticMPUIhKVnvRJ9dQATm+sNuxDBlpYW1CL2rZ',
              'dn7qoXJcuU9W1vClSsLxF3/i5A28NIMG+Dky0OVBHfjmhabrtReTzYgEZQpwK6P4',
              'M1ZYmVTSuE9iRGNnAFXp/vogOeh72wzqk+BDLyHc65C3UaKIrlWfs4PJbjxd0t8Q',
              '+GnjOmaN7DpJhrgFT6P1LkdyCecA845iqbYuVZRUtsQSzXI9HEl320oWvK/BMwxf',
              '9G+LYWdFswSyC0aHnjJkxNXbEQD1e4625g7vAmoqzBciPMtUfV83rR/IuOTZlKph',
              'jwJbIAnBh4fNmWcuxYg/LoUeG7q+P2DtZ3y0sr9p6EiaCTFX18vzKROSkVM5HldQ',
              'WP/z1TXULaCVHOlZkMBvE+tiYGuy3dInjAgSqxe9Q4ch6mo82wbfKrN7p5FJRDs0',
              'R+rAFMeszf9c5pyiLBtbU74G8gJWnPCIkhv6qaKNZoHjlY3dT2XwxQEu0S/1VDmO',
              'bqlAt035injGaJpUPBvTIM2NuQKcmh+XZFwDor9OeE/dRHYLgzyxV1fWC87S46ks',
              'OMYByqxGHlf/ias1Vueh4vZ8UbCpmcTdD6g37RnQW+EAJL59Pt2jzSkKN0FIowXr',
              'Sy5gpYsnINXHEbxVe3zoK2C1GvcODq/7tLu+mwPM0ZrdB6Rlh84JkUaFAT9QfiWj',
              'f2VN7AUIxzZvYaCltcib+/MeP5KTm0qWBgLQH4GdRy6J1nEOXo9ru8kshjwFp3DS',
              'AFHJdrqcS0xa7z5Wop43X+mvU6VkwBjufe2sl91nZRIgTbMGEYCtND/KhLPyQO8i',
              'LXxYPy5pI4EwbW867DZT0sg+aCe39hUcikB1JlVvMo/zjHRFq2GKftSduNQrmnOA',
              'q7ReuFgJPBK64GDlhatVAr9cY2+QU5msEyONZk0/XLnCoMvfjdwW1x8TSpiIHz3b',
              'WKyLdiOkme/BpMZ+lrzhxGj3sE05S9FQquIcf8V2oUvPT741RDCXgJnwbHYNA6ta',
              'XypZPRBrco8nCJTEj/2IQ7KL3xAf4uOMSW5+VNviU6dgGaHslmhbwk1tYDe0Fz9q',
              'GsjZP0HpWQhf6ra8J+UT2Fte3LBvCgSkmXu5EwxKAonRM1lz9IdiDObNq4YV7yc/',
              'MEXovz+0IRhkPtn8WU/mQ4eNu2awFqBxDYA3JbcSig65Hpy1Vr7s9ClfGTdKZOLj',
              'hXMyUKW215BJSlDzZEu4bxIO3jH8oRfsQ6rqgTLne/9vwPdmtcACFp0iG7N+YkVa',
              'OQh24JIgvmUufqDYkXzBWnVK1PHxdLwS6p3jytlF0oibcN7GAC9T/8ZrsRMEae+5',
              'sn5DbLq+WF7BruTypzgYhNMXcQ6/ioJk1mZvaKeGVIE4df02jtP93wH8RUlxSAOC',
              'jsQ3X8TlhSuDyvoatC2gnA9M5IExPYmKeVU1wrGBH76LW4/0qRzkpfZJ+bONcdFi',
              '+/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');

      cCRC16Table: array[0..255] of word = (
              $0000,$C0C1,$C181,$0140,$C301,$03C0,$0280,$C241,$C601,$06C0,$0780,
              $C741,$0500,$C5C1,$C481,$0440,$CC01,$0CC0,$0D80,$CD41,$0F00,$CFC1,
              $CE81,$0E40,$0A00,$CAC1,$CB81,$0B40,$C901,$09C0,$0880,$C841,$D801,
              $18C0,$1980,$D941,$1B00,$DBC1,$DA81,$1A40,$1E00,$DEC1,$DF81,$1F40,
              $DD01,$1DC0,$1C80,$DC41,$1400,$D4C1,$D581,$1540,$D701,$17C0,$1680,
              $D641,$D201,$12C0,$1380,$D341,$1100,$D1C1,$D081,$1040,$F001,$30C0,
              $3180,$F141,$3300,$F3C1,$F281,$3240,$3600,$F6C1,$F781,$3740,$F501,
              $35C0,$3480,$F441,$3C00,$FCC1,$FD81,$3D40,$FF01,$3FC0,$3E80,$FE41,
              $FA01,$3AC0,$3B80,$FB41,$3900,$F9C1,$F881,$3840,$2800,$E8C1,$E981,
              $2940,$EB01,$2BC0,$2A80,$EA41,$EE01,$2EC0,$2F80,$EF41,$2D00,$EDC1,
              $EC81,$2C40,$E401,$24C0,$2580,$E541,$2700,$E7C1,$E681,$2640,$2200,
              $E2C1,$E381,$2340,$E101,$21C0,$2080,$E041,$A001,$60C0,$6180,$A141,
              $6300,$A3C1,$A281,$6240,$6600,$A6C1,$A781,$6740,$A501,$65C0,$6480,
              $A441,$6C00,$ACC1,$AD81,$6D40,$AF01,$6FC0,$6E80,$AE41,$AA01,$6AC0,
              $6B80,$AB41,$6900,$A9C1,$A881,$6840,$7800,$B8C1,$B981,$7940,$BB01,
              $7BC0,$7A80,$BA41,$BE01,$7EC0,$7F80,$BF41,$7D00,$BDC1,$BC81,$7C40,
              $B401,$74C0,$7580,$B541,$7700,$B7C1,$B681,$7640,$7200,$B2C1,$B381,
              $7340,$B101,$71C0,$7080,$B041,$5000,$90C1,$9181,$5140,$9301,$53C0,
              $5280,$9241,$9601,$56C0,$5780,$9741,$5500,$95C1,$9481,$5440,$9C01,
              $5CC0,$5D80,$9D41,$5F00,$9FC1,$9E81,$5E40,$5A00,$9AC1,$9B81,$5B40,
              $9901,$59C0,$5880,$9841,$8801,$48C0,$4980,$8941,$4B00,$8BC1,$8A81,
              $4A40,$4E00,$8EC1,$8F81,$4F40,$8D01,$4DC0,$4C80,$8C41,$4400,$84C1,
              $8581,$4540,$8701,$47C0,$4680,$8641,$8201,$42C0,$4380,$8341,$4100,
              $81C1,$8081,$4040);

type
  TComData = record
    Com  : string;
    Head : string;
    Data : string;
  end;

  TTimeStat = record
    BegTime   :TDateTime;  // »as zaËatia komunik·cie
    HeadIDTime:TDateTime;  // »as odoslania ID hlaviËky
    AskTime   :TDateTime;  // »as odoslania tela paketu
    ProcTime  :TDateTime;  // »as procovania procesu pre server
    AnsTime   :TDateTime;  //»as naËÌtania odpovede
  end;

  TTCPDataInfo = record // ätrukt˙ra DataInfo pre TCP/IP paket
    PacketType:byte;    // Typ paketu: 1-Login, 2-Modul Init, 3 Line Init, 4 - Logout
    PacketNum :longint; // »Ìslo paketu
    HeadLen   :longint; // DÂûka hlaviËky
    DataLen   :longint; // DÂûka d·t
    PrgHand   :double;  // Identifik·tor hlavnho programu
    ModHand   :double;  // Identifik·tor modulu
    DCh       :word;    // KontrolnÈ ËÌslo d·t
    ECh       :word;    // KontrolnÈ ËÌslo kodovan˝ch d·t
    Key       :byte;    // Kæ˙Ë kÛdovania
  end;

  function LineElementNum   (const pStr: string; const pSeparator :char): integer; //new 1999.4.27.
  function LineElement      (const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.

  function  ReplaceStr (pStr,pFind,pRepl:AnsiString):AnsiString;
            //NahradÌ reùaze pFind s reùazmi pRepl
  function  GetSysDateFormat:ShortString;
            //Vr·ti aktu·lny form·t kr·tkeho d·tumu Windowsu
  function  GetSysTimeFormat:ShortString;
            //Vr·ti aktu·lny form·t kr·tkeho Ëasu Windowsu

  function FillStr (pStr:AnsiString; pLen:longint; pCh:AnsiString):AnsiString;
           //Hodnota funkcie je reùazec pStr vyplnen˝ z prava so znakom pCh na pLen dÂûku
  function AlignLeftBy (pStr:AnsiString; pLen:byte; pCh:AnsiChar):AnsiString;
           //DoplnÌ reùazec z æava so zadanÌm znakom
  function AlignRightBy (pStr:AnsiString; pLen:byte; pCh:AnsiChar):AnsiString;
           //DoplnÌ reùacez z prava so zadanÌm znakom
  function AlignCenterBy (pStr:AnsiString; pLen:byte; pCh:AnsiChar):AnsiString;
           //DoplnÌ reùazec z zæava a z prava so zadanÌm znakom
  function AlignLeft (pStr:AnsiString; pLen:byte):AnsiString;
           //DoplnÌ reùazec z æava s medzerou
  function AlignRight (pStr:AnsiString; pLen:byte):AnsiString;
           //DoplnÌ reùacez z prava s medzerou
  function AlignCenter (pStr:AnsiString; pLen:byte):AnsiString;
           //DoplnÌ reùazec z æava a z prava s medzerou
  function RemLeftSpaces (pStr:AnsiString):AnsiString;
           //Odstr·ni medzery z æava
  function RemRightSpaces (pStr:AnsiString):AnsiString;
           //Odstr·ni medzery z prava

  function  ValInt (pStr:ShortString):integer;
  function  StrInt (pNum:longint; pWidth:byte):ShortString;
           //Prekonvertuje celÈ ËÌslo na string
  function StrIntZero (pNum:integer;pWidth:byte):ShortString;
           //Prekonvertuje celÈ ËÌslo na string a z predu doplnÌ s nulami

  function ValDoub (pStr:ShortString):double;

  function StrDoub (pNum:double; pWidth,pFrac:byte):ShortString;
           //Prekonvertuje re·lne ËÌslo na string
  function StrDoubZero (pNum:double; pWidth,pFrac:byte):ShortString;
           //Prekonvertuje re·lne ËÌslo na string a z predu doplnÌ s nulami
  function StrDoubMinFrac (pNum:double; pWidth,pFrac:byte):ShortString;
           //Prekonvertuje re·lne ËÌslo na string a z desatinn˝ch miest odstr·ni poslednÈ nuli
  function StripFractZero (pNum:ShortString): ShortString;
           //Odstrani zbytocne nuly za desatinnou ciarkou

  function Sq (pX,pY:double):double;
  function Roundx (pNumber:double;pFract:integer):double;
  function RoundOK(v:double):double;

  function FloatToArrayS (pNum:double):ShortString;
  function ArraySToFloat (pA:ShortString):double;
  function FloatToArraySRev (pNum:double):ShortString;
  function ArraySToFloatRev (pA:ShortString):double;
  function LongToArrayS (pNum:longint):ShortString;
  function ArraySToLong (pA:ShortString):longint;
  function WordToArrayS (pNum:word):ShortString;
  function ArraySToWord (pA:ShortString):word;

  function EncodeB64(pStr:AnsiString; pNum:byte):AnsiString;
  function DecodeB64(pStr: AnsiString; pNum:byte):AnsiString;
  function DataKeyToChar (pKey:byte):AnsiChar;
  function CharToDataKey (pKey:AnsiChar):byte;

  function CalcCRC16 (pStr:string):word;

  function  GetDataInfo (pStr:string; var pPacketType:byte; var pPacketNum:longint; var pPrgHand, pModHand:double; var pHeadLen, pDataLen:longint; var pDCheck, pECheck:word; var pKey:byte):boolean;
  procedure GetSendStr (pPacketType: byte; pPacketNum:longint; pPrgHand, pModHand:double; pData:TComData; var pHeadID, pBody:string); // Vygeneruje identifikaËn˙ Ëssù hlavyËky a telo paketu
  function  SetDataInfoStr(pPacketType:byte; pPacketNum:longint; pPrgHand, pModHand:double; pHeadLen, pDataLen:longint; pDCheck, pECheck:word; pKey:byte):string; // Konvertovanie TCPDataInfo na B64

implementation

function  LineElementNum(const pStr: string; const pSeparator :char): integer; //new 1999.4.27.
var I, mNum:integer;
begin
  mNum := 0;
  If pStr<>'' then begin
    Inc(mNum);
    For i := 1 to length(pStr) do //new 1999.4.27.
      If (pStr[i] = pSeparator) then inc(mNum);
  end;
  Result := mNum;
end;

function  LineElement(const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.
var mStr: string;  I, mNum:integer;
begin
  mStr := '';  mNum := 0; I := 1;
  While (I<=Length(pStr)) and (pStr[I]<>#0) and (mNum<=pNum) do begin
    If (pStr[i] = pSeparator) then begin
      Inc(mNum)
    end else begin
      If (mNum = pNum) then mStr := mStr + pStr[i];
    end;
    Inc(I);
  end;
  Result := mStr;
end;

function  ReplaceStr (pStr,pFind,pRepl:AnsiString):AnsiString;
begin
  Result := '';
  while Pos (pFind, pStr)>0 do begin
    Result := Result+Copy (pStr, 1, Pos (pFind, pStr)-1)+pRepl;
    Delete (pStr, 1, Pos (pFind, pStr)-1+Length (pFind));
  end;
  Result := Result+pStr;
end;

function  GetSysDateFormat:ShortString;
//var mFormatSettings:TFormatSettings;
begin
//  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, mFormatSettings);
//  Result := ReplaceStr (mFormatSettings.ShortDateFormat, '/', mFormatSettings.DateSeparator);
  Result:='dd.mm.yyyy';
end;

function  GetSysTimeFormat:ShortString;
//var mFormatSettings:TFormatSettings;
begin
//  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, mFormatSettings);
//  Result := mFormatSettings.ShortTimeFormat;
  Result:='hh:nn:ss';
end;

function FillStr (pStr:AnsiString; pLen:longint; pCh:AnsiString):AnsiString;
var mLen:longint;
begin
  mLen := pLen-Length(pStr);
  if mLen>0 then begin
    Result := '';
    repeat
      Result := Result+pCh;
    until Length (Result)>=mLen;
    if Length (Result)>=mLen then Result := Copy (Result, 1, mLen);
    Result := Result+pStr;
  end else Result := pStr;
end;

function AlignLeftBy (pStr:AnsiString; pLen:byte; pCh:AnsiChar):AnsiString;
begin
  If Length (pStr)>=pLen
    then Result := Copy (pStr, 1, pLen)
    else Result := FillStr (pStr, pLen, pCh);
end;

function AlignRightBy (pStr:AnsiString; pLen:byte; pCh:AnsiChar):AnsiString;
var mS:AnsiString;
begin
  If Length (pStr)>=pLen
    then Result := Copy (pStr, 1, pLen)
    else begin
      mS := FillStr ('', pLen-Length (pStr), pCh);
      Result := pStr+mS;
    end;
end;

function AlignCenterBy (pStr:AnsiString; pLen:byte; pCh:AnsiChar):AnsiString;
var mSL, mSR:AnsiString;
begin
  If Length (pStr)>=pLen
    then Result := Copy (pStr, 1, pLen)
    else begin
      mSL := FillStr ('', (pLen-Length (pStr)) div 2, pCh);
      mSR := FillStr ('', pLen-Length (mSL+pStr), pCh);
      Result := mSL+pStr+mSR;
    end;
end;

function AlignLeft (pStr:AnsiString; pLen:byte):AnsiString;
begin
  AlignLeft := AlignLeftBy (pStr, pLen, ' ');
end;

function AlignRight (pStr:AnsiString; pLen:byte):AnsiString;
begin
  AlignRight := AlignRightBy (pStr, pLen, ' ');
end;

function AlignCenter (pStr:AnsiString; pLen:byte):AnsiString;
begin
  AlignCenter := AlignCenterBy (pStr, pLen, ' ');
end;

function RemLeftSpaces (pStr:AnsiString):AnsiString;
begin
  while Pos (' ', pStr)=1 do Delete (pStr, 1, 1);
  Result := pStr;
end;

function RemRightSpaces (pStr:AnsiString):AnsiString;
begin
  while Copy (pStr, Length (pStr), 1)=' ' do Delete (pStr, Length (pStr), 1);
  Result := pStr;
end;

function  ValInt (pStr:ShortString):integer;
var mNum, mErr:integer;
begin
  Val (pStr, mNum, mErr);
  If mErr<>0 then mNum := 0;
  Result := mNum;
end;

function  StrInt (pNum:longint; pWidth:byte):ShortString;
var mStr:string;
begin
  Str (pNum:pWidth,mStr);
  Result := mStr;
end;

function  StrIntZero (pNum:longint; pWidth:byte):ShortString;
begin
  Result := AlignLeftBy (StrInt (pNum,0), pWidth, '0');
end;

function  ValDoub (pStr:ShortString):double;
var mNum:double;  mErr,mPos:integer;
begin
  pStr := ReplaceStr(pStr,' ','');  // 17.06.2010 - RZ
  mPos := Pos(',',pStr);
  If mPos>0 then begin
    Delete (pStr,mPos,1);
    Insert ('.',pStr,mPos);
  end;
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  Result := mNum;
end;

function StrDoub (pNum:double; pWidth,pFrac:byte):ShortString;
var mStr:ShortString;
begin
  Str (pNum:pWidth:pFrac, mStr);
  Result := mStr;
end;

function StrDoubZero (pNum:double; pWidth,pFrac:byte):ShortString;
begin
  Result := AlignLeftBy (StrDoub (pNum, 0, pFrac), pWidth, '0');
end;

function StrDoubMinFrac (pNum:double; pWidth,pFrac:byte):ShortString;
begin
  Result := StrDoub (pNum, pWidth, pFrac);
  if Pos ('.', Result)>0 then begin
    while Copy (Result, Length (Result), 1)='0' do
      Delete (Result, Length (Result), 1);
    if Copy (Result, Length (Result), 1)='0' then Delete (Result, Length (Result), 1);
  end;
end;

function StripFractZero (pNum:ShortString): ShortString;
var mFind:boolean;
begin
  Result := pNum;
  Repeat
    mFind := (Result[Length(Result)]='0');
    If mFind
      then Delete (Result,Length(Result),1)
      else begin
        If Result[Length(Result)]='.' then Delete (Result,Length(Result),1);
      end;
  until not mFind or (Result='0');
end;

function Sq (pX,pY:double):double;
begin
  Sq := Exp (pY*Ln (pX));
end;

function Roundx (pNumber:double;pFract:integer):double;
var  N: double;
begin
  N := Sq (10, pFract);
  If pFract < 0 then
  begin
   Result := RoundOK (pNumber*N)/N;
//    Result := Int (pNumber)+(RoundOK (Frac(pNumber)*N)/N);
    Result := ValDoub (StrDoub (Result,0,pFract));
  end else
  begin
    Result := RoundOK (pNumber*N)/N;
    Result := ValDoub (StrDoub (Result,0,pFract));
  end;
end;

function RoundOK(v:double):double;
var fracs,rundop:boolean;
    I:double;
begin
(*
  fracs  := frac(roundto(v,-10))>0;
  rundop := frac(abs(roundto(v,-10)))>=0.5;
  if roundto(v,-10)>0 then
  begin
    i:=ceil(v);
    if not rundop and fracs then dec(i);
  end
  else begin
    i:=floor(v);
    if not rundop and fracs then inc(i);
  end;
  Result:=i;
*)
  rundop:=frac(abs(v))>=0.5;
  I:=int(v);
  if v>0 then
  begin
    if rundop then I:=I+1;
  end
  else begin
    if rundop then I:=I-1;
  end;
  Result:=I;
end;


function FloatToArrayS (pNum:double):ShortString;
var mA: array [1..8] of byte;
begin
  Move (pNum, mA, 8);
  Result := AnsiChar(mA[1])+AnsiChar(mA[2])+AnsiChar(mA[3])+AnsiChar(mA[4])+AnsiChar(mA[5])+AnsiChar(mA[6])+AnsiChar(mA[7])+AnsiChar(mA[8]);
end;

function ArraySToFloat (pA:ShortString):double;
var mA: array [1..8] of byte;
begin
  Result := 0;
  if Length (pA)=8 then begin
    mA[1] := Ord (pA[1]); mA[2] := Ord (pA[2]); mA[3] := Ord (pA[3]); mA[4] := Ord (pA[4]);
    mA[5] := Ord (pA[5]); mA[6] := Ord (pA[6]); mA[7] := Ord (pA[7]); mA[8] := Ord (pA[8]);
    Move (mA, Result, 8);
  end;
end;

function FloatToArraySRev (pNum:double):ShortString;
var mA: array [1..8] of byte;
begin
  Move (pNum, mA, 8);
  Result := AnsiChar(mA[8])+AnsiChar(mA[7])+AnsiChar(mA[6])+AnsiChar(mA[5])+AnsiChar(mA[4])+AnsiChar(mA[3])+AnsiChar(mA[2])+AnsiChar(mA[1]);
end;

function ArraySToFloatRev (pA:ShortString):double;
var mA: array [1..8] of byte;
begin
  Result := 0;
  if Length (pA)=8 then begin
    mA[8] := Ord (pA[8]); mA[7] := Ord (pA[7]); mA[6] := Ord (pA[6]); mA[5] := Ord (pA[5]);
    mA[4] := Ord (pA[4]); mA[3] := Ord (pA[3]); mA[2] := Ord (pA[2]); mA[1] := Ord (pA[1]);
    Move (mA, Result, 8);
  end;
end;

function LongToArrayS (pNum:longint):ShortString;
var mA: array [1..4] of byte;
begin
  Move (pNum, mA, 4);
  Result := AnsiChar(mA[1])+AnsiChar(mA[2])+AnsiChar(mA[3])+AnsiChar(mA[4]);
end;

function ArraySToLong (pA:ShortString):longint;
var mA: array [1..4] of byte;
begin
  Result := 0;
  if Length (pA)=4 then begin
    mA[1] := Ord (pA[1]); mA[2] := Ord (pA[2]); mA[3] := Ord (pA[3]); mA[4] := Ord (pA[4]);
    Move (mA, Result, 4);
  end;
end;

function WordToArrayS (pNum:word):ShortString;
var mA: array [1..2] of byte;
begin
  Move (pNum, mA, 2);
  Result := AnsiChar(mA[1])+AnsiChar(mA[2]);
end;

function ArraySToWord (pA:ShortString):word;
var mA: array [1..2] of byte;
begin
  Result := 0;
  if Length (pA)=2 then begin
    mA[1] := Ord (pA[1]); mA[2] := Ord (pA[2]);
    Move (mA, Result, 2);
  end;
end;

function EncodeB64(pStr:AnsiString; pNum:byte):AnsiString;
var i, a, x, b: integer; mKeyStr:string;
begin
  Result := '';
  a := 0; b := 0;
  mKeyStr := cCodes64[pNum];
  for i := 1 to Length(pStr) do begin
    x := Ord(AnsiChar (pStr[i]));
    b := b * 256 + x;
    a := a + 8;
    while a >= 6 do begin
      a := a - 6;
      x := b div (1 shl a);
      b := b mod (1 shl a);
      Result := Result + mKeyStr[x+1];
    end;
  end;
  if a > 0 then begin
    x := b shl (6 - a);
    Result := Result + mKeyStr[x+1];
  end;
end;

function DecodeB64(pStr:AnsiString; pNum:byte):AnsiString;
var i, a, x, b: integer; mKeyStr:string;
begin
  Result := '';
  a := 0; b := 0;
  mKeyStr := cCodes64[pNum];
  for i := 1 to Length(pStr) do begin
    x := Pos(pStr[i], mKeyStr) - 1;
    if x >= 0 then begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result+AnsiChar(x);
      end;
    end else Exit;
  end;
end;

function DataKeyToChar (pKey:byte):AnsiChar;
var mS:string;
begin
  Result := #0;
  mS := cCodes64[0];
  if (pKey>0) and (pKey<=Length (mS)) then Result := AnsiChar (mS[pKey]);
end;

function CharToDataKey (pKey:AnsiChar):byte;
var mS:string;
begin
  Result := 0;
  mS := cCodes64[0];
  if Pos (pKey, mS)>0 then Result := Pos (pKey, mS);
end;

function CalcCRC16 (pStr:string):word;
var I:longint; mB:byte;
begin
  Result := 0;
  for I := 1 to Length (pStr) do begin
    mB := Ord (pStr[I]);
    Result := Hi(Result) xor cCRC16Table[mB xor Lo(Result)];
  end;
end;

function  GetDataInfo (pStr:string; var pPacketType:byte; var pPacketNum:longint; var pPrgHand, pModHand:double; var pHeadLen, pDataLen:longint; var pDCheck, pECheck:word; var pKey:byte):boolean;
var mS:string;
begin
  Result:=FALSE;
  pPacketType:=0; pPacketNum:=0; pPrgHand:=0; pModHand:=0; pHeadLen:=0; pDataLen:=0; pDCheck:=0; pECheck:=0; pKey:=0;
  if Length(pStr)=46 then begin
    mS:=DecodeB64(pStr, 0);
    pPacketType:=Ord(mS[1]);
    pPacketNum:=ArraySToLong(Copy(mS,2,4));
    pHeadLen:=ArraySToLong(Copy(mS,6,4));
    pDataLen:=ArraySToLong(Copy(mS,10,4));
    pPrgHand:=ArraySToFloat(Copy(mS,14,8));
    pModHand:=ArraySToFloat(Copy(mS,22,8));
    pDCheck:=ArraySToWord(Copy(mS,30,2));
    pECheck:=ArraySToWord(Copy(mS,32,2));
    pKey:=Ord(mS[34]);
  end;
end;

procedure GetSendStr (pPacketType: byte; pPacketNum:longint; pPrgHand, pModHand:double; pData:TComData; var pHeadID, pBody:string);
var mDataKey:byte; mHeadC, mDataC:string;
begin
  mDataKey := Random(63) + 1;
  mHeadC:=EncodeB64(pData.Head, 0);
  mDataC:=EncodeB64(pData.Data, mDataKey);
  pHeadID:=zSOH+pData.Com+SetDataInfoStr (pPacketType, pPacketNum, pPrgHand, pModHand, Length (mHeadC), Length (mDataC), CalcCRC16(pData.Data), CalcCRC16(mDataC), mDataKey)+zETB;
  pBody:=zSTX+mHeadC+zETX+mDatac+zEOT;
end;

function SetDataInfoStr(pPacketType:byte; pPacketNum:longint; pPrgHand, pModHand:double; pHeadLen, pDataLen:longint; pDCheck, pECheck:word; pKey:byte):string;
var mR:TTCPDataInfo;
begin
  mR.PacketType:=pPacketType;
  mR.PacketNum:=pPacketNum;
  mR.HeadLen:=pHeadLen;
  mR.DataLen:=pDataLen;
  mR.PrgHand:=pPrgHand;
  mR.ModHand:=pModHand;
  mR.DCh:=pDCheck;
  mR.ECh:=pECheck;
  mR.Key:=pKey;
  Result:=AnsiChar(mR.PacketType)+LongToArrayS(mR.PacketNum)+LongToArrayS(mR.HeadLen)
          +LongToArrayS(mR.DataLen)+FloatToArrayS(mR.PrgHand)+FloatToArrayS(mR.ModHand)
          +WordToArrayS(mR.DCh)+WordToArrayS(mR.ECh)+AnsiChar(mR.Key);
  Result := EncodeB64(Result, 0);
end;

end.
