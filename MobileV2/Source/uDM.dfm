object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 120
    Top = 40
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 120
    Top = 128
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'LockingMode=Normal')
    BeforeConnect = FDConnBeforeConnect
    Left = 120
    Top = 216
  end
  object FDQry: TFDQuery
    Connection = FDConn
    Left = 120
    Top = 304
  end
  object restDataPL: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblPL
    FieldDefs = <>
    Response = restRespPL
    Left = 696
    Top = 432
  end
  object tblPL: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'title'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'detail'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'instance'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'data'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 696
    Top = 520
  end
  object restRespPL: TRESTResponse
    ContentType = 'application/json'
    Left = 696
    Top = 344
  end
  object restPL: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://vps35067.publiccloud.com.br/api/position/last'
    Params = <>
    SynchronizedEvents = False
    Left = 696
    Top = 168
  end
  object restReqPL: TRESTRequest
    Client = restPL
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'Authorization'
        Options = [poDoNotEncode]
        Value = 
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjgzMzQ0' +
          'ODcsImlzcyI6InZwczM1MDY3LnB1YmxpY2Nsb3VkLmNvbS5iciIsIm5iZiI6MTY2' +
          'ODMzNDQ4NywiZXhwIjoxNjY4MzQxNjg3LCJjb250cmFjdG9yIjp7ImlkIjoxLCJu' +
          'YW1lIjoiTS5TLiBkZSBNaXJhbmRhIFJhc3RyZWFkb3JlcyAtIEVQUCIsImVudGl0' +
          'eXR5cGVpZCI6MSwiZW50aXR5dHlwZW5hbWUiOiJQZXNzb2EganVyXHUwMGVkZGlj' +
          'YSIsImNvb3BlcmF0aXZlIjpmYWxzZSwianVyaWRpY2FscGVyc29uIjp0cnVlLCJi' +
          'bG9ja2VkIjpmYWxzZSwidXVpZCI6IjgyN2Q4MzM4LTZkMGMtYmY4NS0zZWEyLWZm' +
          'MWY2NmZkNzBkMyJ9LCJ1c2VyIjp7ImlkIjoxNDYsIm5hbWUiOiJXaWxsaWFtIFNh' +
          'bnRvcyIsInVzZXJuYW1lIjoid2lsbGlhbSIsImdyb3VwSUQiOjJ9fQ.0jS3AzkTz' +
          'WeUjMb3U1MsRtJgEgSltl25mpYWT1093bU'
      end>
    Response = restRespPL
    SynchronizedEvents = False
    Left = 696
    Top = 264
  end
end
