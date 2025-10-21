unit SallyComGlobal;

interface

uses Classes, IdGlobal;

const
  cSallyComMode: string = 'O'; //T-trening, L-Live (ostré údaje)
  cAppBreak    : boolean = FALSE;

type
  TIPSServParam = record
    Active           : boolean;
    Port             : longint;
    InitString       : string;
    TerminateWaitTime: longint;
    ComTimeout       : longint;
  end;

  TIPCServParam = record
    Active           : boolean;
    SendTimer        : longint;
    CassaList        : string;
  end;

  TIPCServCasParam = record
    CasNum           : longint;
    Host             : string;
    Port             : longint;
    ConnectTimeout   : longint;
    ReadTimeout      : longint;
    ComTimeout       : longint;
    IPVersion        : TIdIPVersion;
    InitString       : string;
    ReconnectAfterErr: longint; 
    SendFileList     : string;
    Status           : longint;
    NextTime         : TDateTime;
    LastErrorTime    : TDateTime;
  end;
//  192.168.1.10;4001;0;-1;10000;icc;sendfilelist;S;HEXDATE;HEXDATE

  TFTPServParam = record
    Active           : boolean;
    SendTimer        : longint;
    RecvTimer        : longint;
    CassaList        : string;
  end;

  TFTPServCasParam = record
    CasNum           : longint;
    Host             : string;
    Port             : longint;
    UserName         : string;
    Passw            : string;
    Path             : string;
    ReadTimeout      : longint;
    TransferTimeout  : longint;
    SendFileList     : string;
    RecvFileList     : string; //(TFILE,CFILE,EFILE,ACTTURN)
    Status           : longint;
    NextTime         : TDateTime;
    LastErrorTime    : TDateTime;
  end;
//ftp.icc.sk;21;icc.sk;pasw;/icc;60000;0;sendfilelist;readfilelist;S;HEXDATE;HEXDATE

  TSDServParam = record
    Active           : boolean;
    GetTimer         : longint;
    CassaList        : string;
  end;

  TTurnArray = array [0..9] of double;
  TActTurn = record
    CasNum  : longint;
    ActDate : TDateTime;
    ActTime : TDateTime;
    FiscDate: TDateTime;
    UserName: string;
    DBegVal : TTurnArray;
    BegVal  : TTurnArray;
    TrnVal  : TTurnArray;
    ExpVal  : TTurnArray;
    ChIVal  : TTurnArray;
    ChOVal  : TTurnArray;
    IncVal  : TTurnArray;
    EndVal  : TTurnArray;
    PaidAdv : TTurnArray;
    UsedAdv : TTurnArray;
    IncValFM: TTurnArray;
    NotToRet: double;
  end;

  TDepData = array [1..5] of record
    GsCode: longint;
    VatPrc: longint;
    DepVal: double;
  end;

implementation

end.
