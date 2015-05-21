program UnitTest;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Fftw3_Common in '..\Source\Fftw3_Common.pas',
  Fftw3_32 in '..\Source\Fftw3_32.pas',
  Fftw3_64 in '..\Source\Fftw3_64.pas',
  Fftw3_80 in '..\Source\Fftw3_80.pas',
  TestFftw3_32 in 'TestFftw3_32.pas',
  TestFftw3_64 in 'TestFftw3_64.pas',
  TestFftw3_80 in 'TestFftw3_80.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.


