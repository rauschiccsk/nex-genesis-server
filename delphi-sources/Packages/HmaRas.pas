unit HmaRas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  HmaRasLib, ExtCtrls;

type
  EHmaRasError = class(Exception);
  TRasDialMode = (dmSync, dmAsync);

  TRasStatusOrFailEvent = procedure(Sender: TObject; Error: LongInt; State:TRasConnState; Status: String) of object;

  THmaRas = class(TComponent)
  private
    FSelectedEntry: string; // Huidig geselecteerde entry
    FUsername: String;
    FPassword: String;
    FDialParams: TRasDialParams;
    FInstanceHandle: HWND;
    FHandleRas: THRasConn;
    FRasMessage: UINT;
    FTimer: TTimer;
    FMode: TRasDialMode;
    FConnected: Boolean;

    FEntries: TStrings;
    FDevices: TStrings;

    FOnStatus: TRasStatusOrFailEvent;
    FOnConnect: TNotifyEvent;
    FOnDisconnect: TNotifyEvent;
    FOnFail: TRasStatusOrFailEvent;

    procedure SetPassword(const Value: String);
    procedure SetSelectedEntry(const Value: String);
    procedure SetUserName(const Value: String);

    procedure WndProc(var Msg: TMessage); // ontvangt status messages vanuit RasDial
    procedure TimerProc(Sender: TObject);

    function  GetEntries: TStrings;
    procedure UpdateEntries;
    procedure EnumEntries(var parEntries: TStrings);
    procedure UpdateDevices;
    procedure EnumDevices(var parEntries: TStrings);

    function  IsEntryAlreadyActive: THRasConn;
    function GetDevices: TStrings;
  protected
    procedure Connect; virtual;
    procedure DisConnect; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //Dialog box voor selecteren van entry, is ook design-time te gebruiken
    procedure SelectEntry;
    //Dialog box voor selecteren van device, is ook design-time te gebruiken
    function  SelectDevice(const FormCaption: String): String;

    procedure CreateEntry;
    procedure CreateEntryEx(const EntryName: String; Entry: TRasEntry);
    procedure DeleteEntry;
    procedure EditEntry;
    procedure RenameEntry(const NewName: String);

    procedure GetParams;

    procedure Dial;
    procedure HangUp;

    property Devices: TStrings read GetDevices;
    property Entries: TStrings read GetEntries;
    property Password: String read FPassword write SetPassword;
    property Username: String read FUserName write SetUserName;
    property Connected: Boolean read FConnected;
  published
    property Mode: TRasDialMode read FMode write FMode;
    property SelectedEntry: String read FSelectedEntry write SetSelectedEntry;

    property OnStatus: TRasStatusOrFailEvent read FOnStatus write FOnStatus;
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
    property OnFail: TRasStatusOrFailEvent read FOnFail write FOnFail;
  end;

PROCEDURE Register;

implementation

Uses HmaRasSelectEntryForm;

PROCEDURE Register;
BEGIN
  Registercomponents('Ras',[THmaRas]);
END;


function StatusString(state: TRasConnState; error: Longint): String;
var
  c: Array[0..255] of Char;
  s: String;
begin
  if error <> 0 then
  begin
    RasGetErrorString(error, c, 256);
    Result := c;
    if Result = '' then
      Result := 'Onbekende fout of niet geathoriseerd !';
    end
  else begin
    s := '';
    case State of
      RASCS_OpenPort: s := 'Open Port...';
      RASCS_PortOpened: s := 'Port Opened';
      RASCS_ConnectDevice: s := 'Connect Device...';
      RASCS_DeviceConnected: s := 'Device Connected';
      RASCS_AllDevicesConnected: s := 'All Device Connected';
      RASCS_Authenticate: s := 'Authenticate...';
      RASCS_AuthNotify: s := 'AuthNotify...';
      RASCS_AuthRetry: s := 'AuthRetry';
      RASCS_AuthCallback: s := 'AuthCallback';
      RASCS_AuthChangePassword: s := 'AuthChangePassword';
      RASCS_AuthProject: s := 'AuthProject';
      RASCS_AuthLinkSpeed: s := 'AuthLinkSpeed';
      RASCS_AuthAck: s := 'AuthAck';
      RASCS_ReAuthenticate: s := 'ReAuthenticate';
      RASCS_PrepareForCallback: s := 'PrepareForCallback...';
      RASCS_WaitForModemReset: s := 'WaitForModemReset...';
      RASCS_WaitForCallback: s := 'WaitForCallback...';
      RASCS_Projected: s := 'Projected';
      RASCS_StartAuthentication: s := 'StartAuthentication...';
      RASCS_CallbackComplete: s := 'CallbackComplete';
      RASCS_LogonNetwork: s := 'LogonNetwork';
      RASCS_Interactive: s := 'Interactive';
      RASCS_RetryAuthentication: s := 'RetryAuthentication...';
      RASCS_CallbackSetByCaller: s := 'CallbackSetByCaller...';
      RASCS_PasswordExpired: s := 'PasswordExpired !';
      RASCS_Connected: s := 'Connected';
      RASCS_Disconnected: s := 'Disconnected';
      end;
    Result := s;
  end;
end;

constructor THmaRas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  //Alloceren van windows handle voor ontvangen van windows messages
  FInstanceHandle := AllocateHWnd(WndProc);

  //Default geen entry geselecteerd
  FSelectedEntry  := '';

  //Stringlist voor entries
  FEntries        := TStringList.Create;
  FDevices        := TStringList.Create;

  //Timer aanmaken
  FTimer := TTimer.Create(NIL);
  FTimer.Enabled  := False;
  FTimer.Interval := 2000;
  FTimer.OnTimer  := TimerProc;

  FMode := dmAsync;

  //Ophalen constante voor RasMessage
  FRasMessage     := RegisterWindowMessage(RASDIALEVENT);
  if FRasMessage = 0 then
    FRasMessage := WM_RASDIALEVENT;

  FConnected := False;
end;

destructor THmaRas.Destroy;
begin
  //Ophangen als FHandleRas geen 0 is en er niet gebruik is gemaakt van een
  //al openstaande connectie
  HangUp;
  //Windows handle vrijgeven
  DeallocateHWnd(FInstanceHandle);
  //Vrijgeven Entries stringlist
  FEntries.Free;
  //Vrijgeven Devices stringlist
  FDevices.Free;
  //Timer vrijgeven
  FTimer.Free;

  inherited Destroy;
end;

procedure THmaRas.WndProc(var Msg: TMessage);
begin
  with Msg do
  begin
    if Msg = FRasMessage then
    begin
      // Status event ?
      if Assigned( FOnStatus ) then
        FOnstatus( Self, lParam, wParam, StatusString( wParam, lParam ) );
      if wParam = RASCS_Connected then
        Connect
      else if wParam = RASCS_Disconnected then
      begin
        if lParam <> 0 then // foutcode <> 0
        begin
          if Assigned( FOnFail ) then
            FOnFail( Self, lParam, wParam, StatusString( wParam, lParam ) );
        end;
        HangUp;
      end
      else if lParam <> 0 then // foutcode <> 0
      begin
        if Assigned( FOnFail ) then
          FOnFail( Self, lParam, wParam, StatusString( wParam, lParam ) );
        HangUp;
      end;
    end
    else
      Result := DefWindowProc(FInstanceHandle, Msg, wParam, lParam);
  end; //with Msg do
end;

procedure THmaRas.CreateEntry;
begin
  if RasCreatePhonebookEntry(Application.Handle, NIL ) <> 0 then
    raise EHmaRasError.Create('Aanmaken entry is mislukt !' )
  else
    UpdateEntries; // Vernieuw entries
end;

procedure THmaRas.CreateEntryEx(const EntryName: String; Entry: TRasEntry);
begin
  if RasSetEntryProperties( NIL, PChar(EntryName), @entry,
                            SizeOf(TRasEntry), NIL, 0) <> 0 then
    raise EHmaRasError.Create('Aanmaken entry is mislukt !' )
  else
    UpdateEntries; // Vernieuw entries
end;

procedure THmaRas.DeleteEntry;
begin
  if FSelectedEntry <> '' then
  begin
    if RasDeleteEntry(NIL, PChar(FSelectedEntry)) = 0 then
    begin
      UpdateEntries;
      SelectedEntry := '';
    end
    else
      EHmaRasError.Create( 'Verwijderen ' + FSelectedEntry + ' is mislukt !' );
  end;
end;

procedure THmaRas.RenameEntry(const NewName: String);
begin
  if FSelectedEntry <> '' then
  begin
    if RasRenameEntry(NIL, PChar(FSelectedEntry), PChar(NewName)) = 0 then
    begin
      UpdateEntries;
      SelectedEntry := '';
    end
    else
      EHmaRasError.Create( 'Hernoemen ' + FSelectedEntry + ' is mislukt !' );
  end;
end;


procedure THmaRas.EditEntry;
begin
  if FSelectedEntry <> '' then
  begin
    if RasEditPhonebookEntry(Application.Handle, NIL, PChar(FSelectedEntry) ) <> 0 then
      raise EHmaRasError.Create('Wijzigen ' + FSelectedEntry + '  is mislukt !' )
    else begin
      UpdateEntries;
      SelectedEntry := '';
    end;
  end;
end;

procedure THmaRas.EnumEntries(var parEntries: TStrings);
var
  BufSize: Longint;
  NumEntries: Longint;
  lpEntries, p: LPRasEntryName;
  x, Res: Integer;
begin
  if not Assigned(parEntries) then
    raise EHmaRasError.Create(
      'Entries stringlist parameter is NIL !');

  lpEntries := AllocMem( SizeOf(TRasEntryName) );
  try
    lpEntries^.dwSize := SizeOf(TRasEntryName);
    BufSize := SizeOf(TRasEntryName);

    // Ophalen grootte voor buffer
    Res := RasEnumEntries(NIL, NIL, lpEntries, BufSize, NumEntries);

    // Te kleine buffer ?
    if Res = ERROR_BUFFER_TOO_SMALL then
    begin
      ReallocMem(lpEntries, BufSize);
      FillChar(lpEntries^, BufSize, 0);
      lpEntries^.dwSize := SizeOf(TRasEntryName);
      Res := RasEnumEntries(NIL, NIL, lpEntries, BufSize, NumEntries);
    end;

    // Is RasENumEntries gelukt ?
    if Res = 0 then
    begin
      // Zijn er Entries ?
      if NumEntries > 0 then
      begin
        p := lpEntries;
        for x := 0 to NumEntries - 1 do
        begin
          parEntries.Add(p^.szEntryName);
          Inc(p); // Volgende item (pointer wordt opgehoogd met de grootte van het record)
        end;
      end;
    end;
    //else
    //  raise EHmaRasError.Create('EnumEntries is niet goed uitgevoerd !');
  finally
    FreeMem(lpEntries); // geheugen vrijgeven
  end;
end;


procedure THmaRas.EnumDevices(var parEntries: TStrings);
var
  Buffer: Pointer;
  Devices: LPRasDevInfo;
  DevSize, nDevs: Integer;
begin
  DevSize := 0;
  nDevs   := 0;
  if RasEnumDevices(nil, DevSize, nDevs) = ERROR_BUFFER_TOO_SMALL then
  begin
    Buffer := AllocMem(DevSize);
    try
      Devices := buffer;
      Devices^.dwSize := SizeOf(TRasDevInfo);
      if RasEnumDevices(Buffer, DevSize, nDevs) = 0 then
      begin
        while nDevs > 0 do
        begin
          parEntries.Add(Format('%s=%s', [devices^.szDeviceName, devices^.szDeviceType]));
          //cboDevice.Items.Add(Format('%s=%s', [devices^.szDeviceName, devices^.szDeviceType]));
          Inc(Devices);
          Dec(nDevs);
        end;
      end;
      //else
      //  raise EHmaRasError.Create( 'EnumDevices is niet goed uitgevoerd !' );
    finally
      FreeMem(buffer);
    end;
  end;
  //else
  //  raise EHmaRasError.Create( 'EnumDevices is niet goed uitgevoerd !' );
end;

procedure THmaRas.SetPassword(const Value: String);
begin
  if Value <> FPassword
    then FPassword := Value;
end;

procedure THmaRas.SetSelectedEntry(const Value: String);
begin
  if Value <> FSelectedEntry then
  begin
    FSelectedEntry := Value;
    //Ophalen en instellen Username en password
    GetParams;
  end;
end;

procedure THmaRas.SelectEntry;
var
  OldCurs: TCursor;
begin
  OldCurs       := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  with TFrmHmaRasSelectEntry.Create(Application) do
  begin
    try
      // Ken de Entries toe aan de items in de combobox
      CbxEntries.Items.Assign( Entries );
      // is er al een entry geselecteerd ? FSelectedEntry is niet leeg
      if FSelectedEntry <> '' then
        CbxEntries.ItemIndex := CbxEntries.Items.IndexOf( FSelectedEntry )
      else
        CbxEntries.ItemIndex := 0; // eerste item selecteren
      Screen.Cursor := OldCurs;
      Caption := 'Selecteer entry';
      // Haal geselecteerde item uit ComboBox
      if ShowModal = mrOK then
        SelectedEntry := CbxEntries.Items[CbxEntries.ItemIndex];
    finally
      Free;
      Screen.Cursor := OldCurs;
    end;
  end;
end;

function THmaRas.SelectDevice(const FormCaption: String): String;
var
  OldCurs: TCursor;
begin
  OldCurs       := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  with TFrmHmaRasSelectEntry.Create(Application) do
  begin
    try
      // Ken de Entries toe aan de items in de combobox
      CbxEntries.Items.Assign( Devices );
      Screen.Cursor := OldCurs;
      Caption := FormCaption;
      //Index op eerste item instellen
      CbxEntries.ItemIndex := 0;
      // Haal geselecteerde item uit ComboBox
      if ShowModal = mrOK then
        Result := CbxEntries.Items[CbxEntries.ItemIndex]
      else
        Result := '';
    finally
      Free;
      Screen.Cursor := OldCurs;
    end;
  end;
end;

procedure THmaRas.SetUserName(const Value: String);
begin
  if Value <> FUserName
    then FUserName := Value;
end;

procedure THmaRas.GetParams;
var
  fp: LongBool;
  r: Longint;
  c: Array[0..100] of Char;
begin
  if FSelectedEntry <> '' then
  begin
    // Vul record met nullen
    FillChar(FDialParams, SizeOf(TRasDialParams), 0);
    with FDialParams do
    begin
      dwSize := Sizeof(TRasDialParams);
      StrPCopy(szEntryName, FSelectedEntry);
    end;
    r := RasGetEntryDialParams(NIL, FDialParams, fp);
    if r = 0 then
    begin
      with FDialParams do
      begin
        FUserName := szUserName;
        if fp then
          FPassword := szPassword
        else
          FPassword := '';
      end;
    end
    else begin
      RasGetErrorString(r, c, 100);
      raise EHmaRasError.Create( c );
    end;
  end
  else begin
    FUserName := '';
    FPassword := '';
  end;
  //raise EHmaRasError.Create( 'Kan geen parameters ophalen als er geen aktieve selectie is !' );
end;

procedure THmaRas.Dial;
var
  r: integer;
  c: Array[0..100] of Char;
  OldCurs: TCursor;
  OpenHandle: THRasConn;
begin
  // Staat de entry nog niet open ?
  if (FSelectedEntry <> '') and (FHandleRas = 0) then
  begin
    // Staat de entry mogelijk al open ?
    OpenHandle := IsEntryAlreadyActive;
    //Entry is nog niet geopend
    if OpenHandle = 0 then
    begin
      OldCurs := Screen.Cursor;
      Screen.Cursor := crHourglass;
      try
        FillChar(FDialParams, SizeOf(TRasDialParams), 0);
        with FDialParams do
        begin
          dwSize := Sizeof(TRasDialParams);
          StrPCopy(szEntryName, FSelectedEntry);
          StrPCopy(szUserName, FUserName);
          StrPCopy(szPassword, FPassword);
          // You can override phone number here...
          // StrPCopy(szPhoneNumber, 'xxxxxx');
        end;
        FHandleRas := 0;

        // Synchroon bellen
        if FMode = dmSync then
        begin
          r := RasDial(NIL, NIL, FDialParams, 0, NIL, FHandleRas);
          if r = 0 then
          begin
            if Assigned( FOnStatus ) then
              FOnStatus( Self, r, RASCS_Connected, 'Connected' );
            Connect;
          end
          else begin
            if Assigned( FOnFail ) then
              FOnFail( Self, r, 0, StatusString( 0, r ) );
            if Assigned( FOnStatus ) then
              FOnStatus( Self, r, 0, 'Bellen van geselecteerde entry is mislukt !' );
            // Ophangen indien handle niet 0 is
            if FHandleRas <> 0 then
              HangUp;
          end;
        end
        // Asynchroon bellen
        else begin
          r := RasDial(NIL, NIL, FDialParams,  -1, Pointer(FInstanceHandle), FHandleRas);
          if r <> 0 then
          begin
            if Assigned( FOnFail ) then
              FOnFail( Self, r, 0, StatusString( 0, r ) );
            RasGetErrorString(r, c, 100);
            if Assigned( FOnStatus ) then
              FOnStatus( Self, r, 0, c );
            if FHandleRas <> 0 then
              HangUp;
          end;
        end;
      finally
        Screen.Cursor := OldCurs;
      end; // try/finally
    end // if OpenHandle = 0 then
    // Connectie is al open.
    else
      raise EHmaRasError.Create('Opened !');
  end; // if (not EmptyString( FSelectedEntry) ) and (FHandleRas = 0) then
end;

procedure THmaRas.UpdateEntries;
begin
  FEntries.Clear;
  EnumEntries(FEntries);
end;

function THmaRas.GetEntries: TStrings;
begin
  UpdateEntries;
  Result := FEntries;
end;

procedure THmaRas.UpdateDevices;
begin
  FDevices.Clear;
  EnumDevices(FDevices);
end;

function THmaRas.GetDevices: TStrings;
begin
  UpdateDevices;
  Result := FDevices;
end;

procedure THmaRas.HangUp;
begin
  if (FHandleRas <> 0) then
  begin
    RasHangUp(FHandleRas);
    DisConnect;
  end;
end;

procedure THmaRas.Connect;
begin
  FConnected := True;
  FTimer.Enabled := True;
  if Assigned( FOnConnect ) then
    FOnConnect( Self );
end;

procedure THmaRas.DisConnect;
begin
  FConnected := False;
  FTimer.Enabled := False;
  if Assigned(FOnStatus) then
    FOnstatus( Self, 0, RASCS_Disconnected, 'Disconnected' );
  if Assigned( FOnDisConnect ) then
    FOnDisConnect( Self );
  FHandleRas := 0;
end;

function THmaRas.IsEntryAlreadyActive: THRasConn;
var
  liBuf, liNum: LongInt;
  x: Integer;
  aEntries: array [1..100] of TRasConn;
begin
  Result := 0;
  aEntries[1].dwSize := SizeOf(TRasConn);
  liBuf := 100 * SizeOf(TRasConn);
  if RasEnumConnections(@aEntries[1], liBuf, liNum) = 0 then
  begin
    for x := 1 to liNum do
    begin
      // Is dit de geselecteerde entry ?
      if StrPas(aEntries[x].szEntryName) = FSelectedEntry then
      begin
        Result := aEntries[x].hrasconn;
        Break;
      end;
    end;
  end
end;

procedure THmaRas.TimerProc(Sender: TObject);
var
  RasConnStatus: TRasConnStatus;
  Status: DWORD;
begin
  if FHandleRas <> 0 then
  begin
    FillChar(RasConnStatus, SizeOf(RasConnStatus), 0);
    RasConnStatus.dwSize := SizeOf(RasConnStatus);
    Status := RasGetConnectStatus( FHandleRas, RasConnStatus );
    // Controleer of de connectie is verbroken buiten de applicatie om !
    if Status = ERROR_INVALID_HANDLE then
      Disconnect;
  end;
end;

end.
