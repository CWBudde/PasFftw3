unit TestFftw3_64;

interface

uses
{$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  Fftw3_Common, Classes, SysUtils, Fftw3_64;

const
  CFFTSize = 8192;

type
  TestTFftw64Dft = class(TTestCase)
  strict private
    FFftw64Dft: TFftw64Dft;
    FInput, FOutput: PFftw64Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw64DftReal2Complex = class(TTestCase)
  strict private
    FFftw64DftReal2Complex: TFftw64DftReal2Complex;
    FInput: PFftw64Real;
    FOutput: PFftw64Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw64DftComplex2Real = class(TTestCase)
  strict private
    FFftw64DftComplex2Real: TFftw64DftComplex2Real;
    FInput: PFftw64Complex;
    FOutput: PFftw64Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw64Real2Real = class(TTestCase)
  strict private
    FFftw64Real2Real: TFftw64Real2Real;
    FInput, FOutput: PFftw64Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw64Guru = class(TTestCase)
  strict private
    FFftw64Guru: TFftw64Guru;
    FInput, FOutput: PFftw64Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw64Guru64 = class(TTestCase)
  strict private
    FFftw64Guru64: TFftw64Guru64;
    FInput, FOutput: PFftw64Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw64Wisdom = class(TTestCase)
  private
    FDataStream: TMemoryStream;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestForgetWisdom;
    procedure TestImportExportToFilename;
    procedure TestImportExportToString;
    procedure TestImportExport;
    procedure TestImportSystem;
  end;

implementation

{ TestTFftw64Dft }

procedure TestTFftw64Dft.SetUp;
begin
  // allocate memory
  FInput := Fftw64AllocComplex(CFFTSize);
  FOutput := Fftw64AllocComplex(CFFTSize);

  // create plan
  FFftw64Dft := TFftw64Dft.Create(CFFTSize, FInput, FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw64Dft.TearDown;
begin
  // free memory
  Fftw64Free(FOutput);
  FOutput := nil;
  Fftw64Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw64Dft.Free;
  FFftw64Dft := nil;
end;

procedure TestTFftw64Dft.TestExecute;
begin
  // perform FFT
  FFftw64Dft.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw64Dft.Execute(FInput, FOutput);
end;

procedure TestTFftw64Dft.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw64Real;
begin
  Ri := PFftw64Real(FInput);
  Ii := PFftw64Real(FInput);
  Ro := PFftw64Real(FOutput);
  Io := PFftw64Real(FOutput);

  // perform FFT
  FFftw64Dft.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw64Dft.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw64Dft.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw64Dft.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw64Dft.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw64Dft.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw64DftReal2Complex }

procedure TestTFftw64DftReal2Complex.SetUp;
begin
  // allocate memory
  FInput := Fftw64AllocReal(CFFTSize);
  FOutput := Fftw64AllocComplex(CFFTSize);

  // create plan
  FFftw64DftReal2Complex := TFftw64DftReal2Complex.Create(CFFTSize, FInput,
    FOutput, [ffEstimate]);
end;

procedure TestTFftw64DftReal2Complex.TearDown;
begin
  // free memory
  Fftw64Free(FOutput);
  FOutput := nil;
  Fftw64Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw64DftReal2Complex.Free;
  FFftw64DftReal2Complex := nil;
end;

procedure TestTFftw64DftReal2Complex.TestExecute;
begin
  // perform FFT
  FFftw64DftReal2Complex.Execute(FInput, FOutput);

  // repeat FFT
  FFftw64DftReal2Complex.Execute(FInput, FOutput);
end;

procedure TestTFftw64DftReal2Complex.TestExecuteSplit;
var
  &In, Ro, Io: PFftw64Real;
begin
  &In := PFftw64Real(FInput);
  Ro := PFftw64Real(FOutput);
  Io := PFftw64Real(FOutput);

  // perform FFT
  FFftw64DftReal2Complex.Execute(&In, Ro, Io);

  // perform FFT (again)
  FFftw64DftReal2Complex.Execute(&In, Ro, Io);
end;

procedure TestTFftw64DftReal2Complex.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw64DftReal2Complex.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw64DftReal2Complex.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw64DftReal2Complex.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw64DftComplex2Real }

procedure TestTFftw64DftComplex2Real.SetUp;
begin
  // allocate memory
  FInput := Fftw64AllocComplex(CFFTSize);
  FOutput := Fftw64AllocReal(CFFTSize);

  // create plan
  FFftw64DftComplex2Real := TFftw64DftComplex2Real.Create(CFFTSize, FInput,
    FOutput, [ffEstimate]);
end;

procedure TestTFftw64DftComplex2Real.TearDown;
begin
  // free memory
  Fftw64Free(FOutput);
  FOutput := nil;
  Fftw64Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw64DftComplex2Real.Free;
  FFftw64DftComplex2Real := nil;
end;

procedure TestTFftw64DftComplex2Real.TestExecute;
begin
  // perform FFT
  FFftw64DftComplex2Real.Execute(FInput, FOutput);

  // repeat FFT
  FFftw64DftComplex2Real.Execute(FInput, FOutput);
end;

procedure TestTFftw64DftComplex2Real.TestExecuteSplit;
var
  Ri, Ii, &Out: PFftw64Real;
begin
  Ri := PFftw64Real(FInput);
  Ii := PFftw64Real(FInput);
  &Out := PFftw64Real(FOutput);

  // perform FFT
  FFftw64DftComplex2Real.Execute(Ri, Ii, &Out);

  // perform FFT (again)
  FFftw64DftComplex2Real.Execute(Ri, Ii, &Out);
end;

procedure TestTFftw64DftComplex2Real.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw64DftComplex2Real.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw64DftComplex2Real.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw64DftComplex2Real.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw64Real2Real }

procedure TestTFftw64Real2Real.SetUp;
begin
  // allocate memory
  FInput := Fftw64AllocReal(CFFTSize);
  FOutput := Fftw64AllocReal(CFFTSize);

  // create plan
  FFftw64Real2Real := TFftw64Real2Real.Create(CFFTSize, FInput, FOutput,
    fkDiscreteHartleyTransform, [ffEstimate]);
end;

procedure TestTFftw64Real2Real.TearDown;
begin
  // free memory
  Fftw64Free(FOutput);
  FOutput := nil;
  Fftw64Free(FInput);
  FInput := nil;

  FFftw64Real2Real.Free;
  FFftw64Real2Real := nil;
end;

procedure TestTFftw64Real2Real.TestExecute;
begin
  // perform FFT
  FFftw64Real2Real.Execute(FInput, FOutput);

  // repeat FFT
  FFftw64Real2Real.Execute(FInput, FOutput);
end;

procedure TestTFftw64Real2Real.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw64Real2Real.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw64Real2Real.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw64Real2Real.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw64Guru }

procedure TestTFftw64Guru.SetUp;
var
  Dim: TFftwIoDim;
begin
  // allocate memory
  FInput := Fftw64AllocComplex(CFFTSize);
  FOutput := Fftw64AllocComplex(CFFTSize);

  // create plan
  FFftw64Guru := TFftw64Guru.Create(CFFTSize, @Dim, 1, @Dim, FInput,
    FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw64Guru.TearDown;
begin
  // free memory
  Fftw64Free(FOutput);
  FOutput := nil;
  Fftw64Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw64Guru.Free;
  FFftw64Guru := nil;
end;

procedure TestTFftw64Guru.TestExecute;
begin
  // perform FFT
  FFftw64Guru.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw64Guru.Execute(FInput, FOutput);
end;

procedure TestTFftw64Guru.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw64Real;
begin
  Ri := PFftw64Real(FInput);
  Ii := PFftw64Real(FInput);
  Ro := PFftw64Real(FOutput);
  Io := PFftw64Real(FOutput);

  // perform FFT
  FFftw64Guru.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw64Guru.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw64Guru.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw64Guru.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw64Guru.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw64Guru.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw64Guru64 }

procedure TestTFftw64Guru64.SetUp;
var
  Dim: TFftwIoDim;
begin
  // allocate memory
  FInput := Fftw64AllocComplex(CFFTSize);
  FOutput := Fftw64AllocComplex(CFFTSize);

  // create plan
  FFftw64Guru64 := TFftw64Guru64.Create(CFFTSize, @Dim, 1, @Dim, FInput,
    FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw64Guru64.TearDown;
begin
  // free memory
  Fftw64Free(FOutput);
  FOutput := nil;
  Fftw64Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw64Guru64.Free;
  FFftw64Guru64 := nil;
end;

procedure TestTFftw64Guru64.TestExecute;
begin
  // perform FFT
  FFftw64Guru64.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw64Guru64.Execute(FInput, FOutput);
end;

procedure TestTFftw64Guru64.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw64Real;
begin
  Ri := PFftw64Real(FInput);
  Ii := PFftw64Real(FInput);
  Ro := PFftw64Real(FOutput);
  Io := PFftw64Real(FOutput);

  // perform FFT
  FFftw64Guru64.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw64Guru64.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw64Guru64.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw64Guru64.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw64Guru64.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw64Guru64.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw64Wisdom }

procedure TestTFftw64Wisdom.SetUp;
begin
end;

procedure TestTFftw64Wisdom.TearDown;
begin
end;

procedure TestTFftw64Wisdom.TestForgetWisdom;
begin
  TFftw64Wisdom.ForgetWisdom;
end;

procedure TestTFftw64Wisdom.TestImportExportToFilename;
var
  ReturnValue: Boolean;
begin
  ReturnValue := TFftw64Wisdom.ExportToFilename('Wisdom.wsd');
  CheckTrue(ReturnValue);

  ReturnValue := TFftw64Wisdom.ImportFromFilename('Wisdom.wsd');
  CheckTrue(ReturnValue);
end;

procedure TestTFftw64Wisdom.TestImportExportToString;
var
  Wisdom: AnsiString;
  ReturnValue: Boolean;
begin
  Wisdom := TFftw64Wisdom.ExportToString;
  CheckTrue(Wisdom <> '');

  ReturnValue := TFftw64Wisdom.ImportFromString(Wisdom);
  CheckTrue(ReturnValue);
end;

procedure FftwWriteCharFunc(c: AnsiChar; Ptr: Pointer); cdecl;
begin
  Assert(TObject(Ptr) is TestTFftw64Wisdom);
  TestTFftw64Wisdom(Ptr).FDataStream.Write(C, 1);
end;

function FftwReadCharFunc(Ptr: Pointer): PAnsiChar; cdecl;
begin
  Assert(TObject(Ptr) is TestTFftw64Wisdom);
  Result := TestTFftw64Wisdom(Ptr).FDataStream.Memory;
end;

procedure TestTFftw64Wisdom.TestImportExport;
var
  ReturnValue: Integer;
begin
  FDataStream := TMemoryStream.Create;
  try
    TFftw64Wisdom.Export(FftwWriteCharFunc, Self);
    CheckTrue(FDataStream.Size > 0);

    FDataStream.Position := 0;
    ReturnValue := TFftw64Wisdom.Import(FftwReadCharFunc, Self);
    CheckEquals(0, ReturnValue);
  finally
    FDataStream.Free;
  end;
end;

procedure TestTFftw64Wisdom.TestImportSystem;
var
  ReturnValue: Integer;
begin
  ReturnValue := TFftw64Wisdom.ImportSystem;
  CheckEquals(0, ReturnValue);
end;

initialization
  RegisterTest('Fftw64', TestTFftw64Dft.Suite);
  RegisterTest('Fftw64', TestTFftw64DftReal2Complex.Suite);
  RegisterTest('Fftw64', TestTFftw64DftComplex2Real.Suite);
  RegisterTest('Fftw64', TestTFftw64Real2Real.Suite);
(*
  RegisterTest('Fftw64', TestTFftw64Guru.Suite);
  RegisterTest('Fftw64', TestTFftw64Guru64.Suite);
*)
  RegisterTest('Fftw64', TestTFftw64Wisdom.Suite);
end.
