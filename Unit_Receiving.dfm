object FormPay: TFormPay
  Left = 298
  Top = 134
  Width = 647
  Height = 550
  Caption = #1055#1088#1080#1077#1084' '#1087#1083#1072#1090#1077#1078#1072' '#1079#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PInput: TPanel
    Left = 88
    Top = 64
    Width = 465
    Height = 393
    TabOrder = 0
    object Label1: TLabel
      Left = 184
      Top = 160
      Width = 98
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 48
      Top = 32
      Width = 112
      Height = 25
      Caption = #1050' '#1086#1087#1083#1072#1090#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 320
      Top = 32
      Width = 112
      Height = 25
      Caption = #1054#1089#1090#1072#1083#1086#1089#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object LPay: TLabel
      Left = 57
      Top = 80
      Width = 96
      Height = 46
      BiDiMode = bdRightToLeft
      Caption = '0000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      Layout = tlCenter
    end
    object LReceive: TLabel
      Left = 144
      Top = 208
      Width = 172
      Height = 80
      Caption = '0000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = 80
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LLeftover: TLabel
      Left = 328
      Top = 80
      Width = 96
      Height = 46
      Caption = '0000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 360
      Top = 352
      Width = 75
      Height = 25
      Caption = #1042#1077#1088#1085#1091#1090#1089#1103
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
