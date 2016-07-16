unit Unit_InputNum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons;

type
  TFormInputNum = class(TForm)
    PanelInputNum: TPanel;
    PanelInput: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInputNum: TFormInputNum;

implementation

{$R *.dfm}

procedure TFormInputNum.SpeedButton13Click(Sender: TObject);
begin
FormInputNum.ModalResult:=mrCancel;
end;

procedure TFormInputNum.SpeedButton14Click(Sender: TObject);
begin
FormInputNum.ModalResult:=mrOk;
end;

procedure TFormInputNum.SpeedButtonClick(Sender: TObject);
var Str: String;
begin
  if StrToInt(PanelInput.Caption + (Sender as TSpeedButton).Caption) < 15001 then
    begin
      PanelInput.Caption := IntToStr(StrToInt(PanelInput.Caption + (Sender as TSpeedButton).Caption));
    end
  else
    begin
      ShowMessage('—умма не должна превышать 15 тыс. руб');
    end
end;

procedure TFormInputNum.FormCreate(Sender: TObject);
begin
    // ќкно во весь экран
    FormInputNum.BorderStyle := bsNone;
    FormInputNum.WindowState := wsMaximized;

    // ѕанель с ¬водом цифр по центру
    PanelInputNum.Left := (FormInputNum.ClientWidth - PanelInputNum.Width) div 2;
    PanelInputNum.Top := (FormInputNum.ClientHeight - PanelInputNum.Height) div 2;

end;

procedure TFormInputNum.SpeedButton12Click(Sender: TObject);
begin
  PanelInput.Caption := '0';
end;

procedure TFormInputNum.SpeedButton11Click(Sender: TObject);
begin
  if length(PanelInput.Caption) > 1 then PanelInput.Caption := Copy(PanelInput.Caption,1,length(PanelInput.Caption)-1)
    else PanelInput.Caption := '0';
end;

end.
