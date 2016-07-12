program Payment;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {MainForm},
  Unit_Receiving in 'Unit_Receiving.pas' {FormPay},
  Unit_InputName in 'Unit_InputName.pas' {FormInputName};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormPay, FormPay);
  Application.CreateForm(TFormInputName, FormInputName);
  Application.Run;
end.
