program Payment;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {MainForm},
  Unit_Receiving in 'Unit_Receiving.pas' {FormPay};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormPay, FormPay);
  Application.Run;
end.
