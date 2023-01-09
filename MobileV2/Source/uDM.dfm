object DM: TDM
  Height = 373
  Width = 443
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 80
    Top = 27
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 80
    Top = 85
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'LockingMode=Normal')
    BeforeConnect = FDConnBeforeConnect
    Left = 80
    Top = 144
  end
end
