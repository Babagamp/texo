object FormPay: TFormPay
  Left = 298
  Top = 134
  Width = 798
  Height = 717
  Caption = #1055#1088#1080#1077#1084' '#1087#1083#1072#1090#1077#1078#1072' '#1079#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object PInput: TPanel
    Left = 108
    Top = 79
    Width = 573
    Height = 483
    TabOrder = 0
    object Label1: TLabel
      Left = 226
      Top = 197
      Width = 112
      Height = 30
      Caption = #1055#1088#1080#1085#1103#1090#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 59
      Top = 47
      Width = 128
      Height = 30
      Caption = #1050' '#1086#1087#1083#1072#1090#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 394
      Top = 47
      Width = 128
      Height = 30
      Caption = #1054#1089#1090#1072#1083#1086#1089#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object LPay: TLabel
      Left = 62
      Top = 98
      Width = 120
      Height = 56
      BiDiMode = bdRightToLeft
      Caption = '0000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -50
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      Layout = tlCenter
    end
    object LReceive: TLabel
      Left = 169
      Top = 256
      Width = 208
      Height = 98
      Caption = '0000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 98
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LLeftover: TLabel
      Left = 396
      Top = 98
      Width = 120
      Height = 56
      Caption = '0000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -50
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 443
      Top = 433
      Width = 92
      Height = 31
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
