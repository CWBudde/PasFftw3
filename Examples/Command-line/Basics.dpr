program Basics;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Fftw3_Common in '..\..\Source\Fftw3_Common.pas',
  Fftw3_32 in '..\..\Source\Fftw3_32.pas',
  Fftw3_64 in '..\..\Source\Fftw3_64.pas',
  Fftw3_80 in '..\..\Source\Fftw3_80.pas';

const
  CFftSize = 8192;
var
  Input: PSingle;
  Output: PFftw32Complex;
  Plan: TFftw32Plan;
begin
  try
    Input := Fftw32AllocReal(8192);
    try
      Output := Fftw32AllocComplex(8192);
      try
        // create a plan for a real to complex transformation (FFT)
        Plan := Fftw32PlanDftReal2Complex1D(CFftSize, Input, Output, [ffEstimate]);
        try
          // perform FFT
          Fftw32Execute(Plan);

          // perform FFT (again)
          Fftw32Execute(Plan);

        finally
          // destroy plan
          Fftw32DestroyPlan(Plan);
        end;
      finally
        Fftw32Free(Output);
      end;
    finally
      Fftw32Free(Input);
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

