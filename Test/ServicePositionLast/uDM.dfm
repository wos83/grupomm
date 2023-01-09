object DM: TDM
  OnCreate = AndroidServiceCreate
  OnDestroy = AndroidServiceDestroy
  OnBind = AndroidServiceBind
  OnUnBind = AndroidServiceUnBind
  OnRebind = AndroidServiceRebind
  OnTaskRemoved = AndroidServiceTaskRemoved
  OnConfigurationChanged = AndroidServiceConfigurationChanged
  OnLowMemory = AndroidServiceLowMemory
  OnTrimMemory = AndroidServiceTrimMemory
  OnHandleMessage = AndroidServiceHandleMessage
  OnStartCommand = AndroidServiceStartCommand
  Height = 554
  Width = 641
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 112
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 112
    Top = 88
  end
  object RESTResponse1: TRESTResponse
    Left = 112
    Top = 144
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 304
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 304
    Top = 88
  end
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Left = 304
    Top = 144
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 304
    Top = 200
  end
end
