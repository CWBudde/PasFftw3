program FilerKernelExplorer;

uses
  Vcl.Forms,
  Fftw3_Common in '..\..\Source\Fftw3_Common.pas',
  Fftw3_64 in '..\..\Source\Fftw3_64.pas',
  MainUnit in 'MainUnit.pas' {FormFilterKernelExplorer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormFilterKernelExplorer, FormFilterKernelExplorer);
  Application.Run;
end.

