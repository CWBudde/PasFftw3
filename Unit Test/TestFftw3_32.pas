unit TestFftw3_32;

interface

uses
{$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  Fftw3_Common, Classes, SysUtils, Fftw3_32;

const
  CFFTSize = 8192;

type
  TestTFftw32Dft = class(TTestCase)
  strict private
    FFftw32Dft: TFftw32Dft;
    FInput, FOutput: PFftw32Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw32DftReal2Complex = class(TTestCase)
  strict private
    FFftw32DftReal2Complex: TFftw32DftReal2Complex;
    FInput: PFftw32Real;
    FOutput: PFftw32Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw32DftComplex2Real = class(TTestCase)
  strict private
    FFftw32DftComplex2Real: TFftw32DftComplex2Real;
    FInput: PFftw32Complex;
    FOutput: PFftw32Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw32Real2Real = class(TTestCase)
  strict private
    FFftw32Real2Real: TFftw32Real2Real;
    FInput, FOutput: PFftw32Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw32Guru = class(TTestCase)
  strict private
    FFftw32Guru: TFftw32Guru;
    FInput, FOutput: PFftw32Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw32Guru64 = class(TTestCase)
  strict private
    FFftw32Guru64: TFftw32Guru64;
    FInput, FOutput: PFftw32Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw32Wisdom = class(TTestCase)
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

{ TestTFftw32Dft }

procedure TestTFftw32Dft.SetUp;
begin
  // allocate memory
  FInput := Fftw32AllocComplex(CFFTSize);
  FOutput := Fftw32AllocComplex(CFFTSize);

  // create plan
  FFftw32Dft := TFftw32Dft.Create(CFFTSize, FInput, FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw32Dft.TearDown;
begin
  // free memory
  Fftw32Free(FOutput);
  FOutput := nil;
  Fftw32Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw32Dft.Free;
  FFftw32Dft := nil;
end;

procedure TestTFftw32Dft.TestExecute;
begin
  // perform FFT
  FFftw32Dft.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw32Dft.Execute(FInput, FOutput);
end;

procedure TestTFftw32Dft.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw32Real;
begin
  Ri := PFftw32Real(FInput);
  Ii := PFftw32Real(FInput);
  Ro := PFftw32Real(FOutput);
  Io := PFftw32Real(FOutput);

  // perform FFT
  FFftw32Dft.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw32Dft.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw32Dft.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw32Dft.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw32Dft.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw32Dft.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw32DftReal2Complex }

procedure TestTFftw32DftReal2Complex.SetUp;
begin
  // allocate memory
  FInput := Fftw32AllocReal(CFFTSize);
  FOutput := Fftw32AllocComplex(CFFTSize);

  // create plan
  FFftw32DftReal2Complex := TFftw32DftReal2Complex.Create(CFFTSize, FInput,
    FOutput, [ffEstimate]);
end;

procedure TestTFftw32DftReal2Complex.TearDown;
begin
  // free memory
  Fftw32Free(FOutput);
  FOutput := nil;
  Fftw32Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw32DftReal2Complex.Free;
  FFftw32DftReal2Complex := nil;
end;

procedure TestTFftw32DftReal2Complex.TestExecute;
begin
  // perform FFT
  FFftw32DftReal2Complex.Execute(FInput, FOutput);

  // repeat FFT
  FFftw32DftReal2Complex.Execute(FInput, FOutput);
end;

procedure TestTFftw32DftReal2Complex.TestExecuteSplit;
var
  &In, Ro, Io: PFftw32Real;
begin
  &In := PFftw32Real(FInput);
  Ro := PFftw32Real(FOutput);
  Io := PFftw32Real(FOutput);

  // perform FFT
  FFftw32DftReal2Complex.Execute(&In, Ro, Io);

  // perform FFT (again)
  FFftw32DftReal2Complex.Execute(&In, Ro, Io);
end;

procedure TestTFftw32DftReal2Complex.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw32DftReal2Complex.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw32DftReal2Complex.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw32DftReal2Complex.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw32DftComplex2Real }

procedure TestTFftw32DftComplex2Real.SetUp;
begin
  // allocate memory
  FInput := Fftw32AllocComplex(CFFTSize);
  FOutput := Fftw32AllocReal(CFFTSize);

  // create plan
  FFftw32DftComplex2Real := TFftw32DftComplex2Real.Create(CFFTSize, FInput,
    FOutput, [ffEstimate]);
end;

procedure TestTFftw32DftComplex2Real.TearDown;
begin
  // free memory
  Fftw32Free(FOutput);
  FOutput := nil;
  Fftw32Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw32DftComplex2Real.Free;
  FFftw32DftComplex2Real := nil;
end;

procedure TestTFftw32DftComplex2Real.TestExecute;
begin
  // perform FFT
  FFftw32DftComplex2Real.Execute(FInput, FOutput);

  // repeat FFT
  FFftw32DftComplex2Real.Execute(FInput, FOutput);
end;

procedure TestTFftw32DftComplex2Real.TestExecuteSplit;
var
  Ri, Ii, &Out: PFftw32Real;
begin
  Ri := PFftw32Real(FInput);
  Ii := PFftw32Real(FInput);
  &Out := PFftw32Real(FOutput);

  // perform FFT
  FFftw32DftComplex2Real.Execute(Ri, Ii, &Out);

  // perform FFT (again)
  FFftw32DftComplex2Real.Execute(Ri, Ii, &Out);
end;

procedure TestTFftw32DftComplex2Real.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw32DftComplex2Real.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw32DftComplex2Real.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw32DftComplex2Real.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw32Real2Real }

procedure TestTFftw32Real2Real.SetUp;
begin
  // allocate memory
  FInput := Fftw32AllocReal(CFFTSize);
  FOutput := Fftw32AllocReal(CFFTSize);

  // create plan
  FFftw32Real2Real := TFftw32Real2Real.Create(CFFTSize, FInput, FOutput,
    fkDiscreteHartleyTransform, [ffEstimate]);
end;

procedure TestTFftw32Real2Real.TearDown;
begin
  // free memory
  Fftw32Free(FOutput);
  FOutput := nil;
  Fftw32Free(FInput);
  FInput := nil;

  FFftw32Real2Real.Free;
  FFftw32Real2Real := nil;
end;

procedure TestTFftw32Real2Real.TestExecute;
begin
  // perform FFT
  FFftw32Real2Real.Execute(FInput, FOutput);

  // repeat FFT
  FFftw32Real2Real.Execute(FInput, FOutput);
end;

procedure TestTFftw32Real2Real.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw32Real2Real.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw32Real2Real.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw32Real2Real.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw32Guru }

procedure TestTFftw32Guru.SetUp;
var
  Dim: TFftwIoDim;
begin
  // allocate memory
  FInput := Fftw32AllocComplex(CFFTSize);
  FOutput := Fftw32AllocComplex(CFFTSize);

  // create plan
  FFftw32Guru := TFftw32Guru.Create(CFFTSize, @Dim, 1, @Dim, FInput,
    FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw32Guru.TearDown;
begin
  // free memory
  Fftw32Free(FOutput);
  FOutput := nil;
  Fftw32Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw32Guru.Free;
  FFftw32Guru := nil;
end;

procedure TestTFftw32Guru.TestExecute;
begin
  // perform FFT
  FFftw32Guru.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw32Guru.Execute(FInput, FOutput);
end;

procedure TestTFftw32Guru.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw32Real;
begin
  Ri := PFftw32Real(FInput);
  Ii := PFftw32Real(FInput);
  Ro := PFftw32Real(FOutput);
  Io := PFftw32Real(FOutput);

  // perform FFT
  FFftw32Guru.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw32Guru.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw32Guru.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw32Guru.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw32Guru.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw32Guru.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw32Guru64 }

procedure TestTFftw32Guru64.SetUp;
var
  Dim: TFftwIoDim;
begin
  // allocate memory
  FInput := Fftw32AllocComplex(CFFTSize);
  FOutput := Fftw32AllocComplex(CFFTSize);

  // create plan
  FFftw32Guru64 := TFftw32Guru64.Create(CFFTSize, @Dim, 1, @Dim, FInput,
    FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw32Guru64.TearDown;
begin
  // free memory
  Fftw32Free(FOutput);
  FOutput := nil;
  Fftw32Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw32Guru64.Free;
  FFftw32Guru64 := nil;
end;

procedure TestTFftw32Guru64.TestExecute;
begin
  // perform FFT
  FFftw32Guru64.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw32Guru64.Execute(FInput, FOutput);
end;

procedure TestTFftw32Guru64.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw32Real;
begin
  Ri := PFftw32Real(FInput);
  Ii := PFftw32Real(FInput);
  Ro := PFftw32Real(FOutput);
  Io := PFftw32Real(FOutput);

  // perform FFT
  FFftw32Guru64.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw32Guru64.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw32Guru64.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw32Guru64.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw32Guru64.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw32Guru64.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw32Wisdom }

procedure TestTFftw32Wisdom.SetUp;
begin
end;

procedure TestTFftw32Wisdom.TearDown;
begin
end;

procedure TestTFftw32Wisdom.TestForgetWisdom;
begin
  TFftw32Wisdom.ForgetWisdom;
end;

procedure TestTFftw32Wisdom.TestImportExportToFilename;
var
  ReturnValue: Boolean;
begin
  ReturnValue := TFftw32Wisdom.ExportToFilename('Wisdom.wsd');
  CheckTrue(ReturnValue);

  ReturnValue := TFftw32Wisdom.ImportFromFilename('Wisdom.wsd');
  CheckTrue(ReturnValue);
end;

procedure TestTFftw32Wisdom.TestImportExportToString;
var
  Wisdom: AnsiString;
  ReturnValue: Boolean;
begin
  Wisdom := TFftw32Wisdom.ExportToString;
  CheckTrue(Wisdom <> '');

  ReturnValue := TFftw32Wisdom.ImportFromString(Wisdom);
  CheckTrue(ReturnValue);
end;

procedure FftwWriteCharFunc(c: AnsiChar; Ptr: Pointer); cdecl;
begin
  Assert(TObject(Ptr) is TestTFftw32Wisdom);
  TestTFftw32Wisdom(Ptr).FDataStream.Write(C, 1);
end;

function FftwReadCharFunc(Ptr: Pointer): PAnsiChar; cdecl;
begin
  Assert(TObject(Ptr) is TestTFftw32Wisdom);
  Result := TestTFftw32Wisdom(Ptr).FDataStream.Memory;
end;

procedure TestTFftw32Wisdom.TestImportExport;
var
  ReturnValue: Integer;
begin
  FDataStream := TMemoryStream.Create;
  try
    TFftw32Wisdom.Export(FftwWriteCharFunc, Self);
    CheckTrue(FDataStream.Size > 0);

    FDataStream.Position := 0;
    ReturnValue := TFftw32Wisdom.Import(FftwReadCharFunc, Self);
    CheckEquals(0, ReturnValue);
  finally
    FDataStream.Free;
  end;
end;

procedure TestTFftw32Wisdom.TestImportSystem;
var
  ReturnValue: Integer;
begin
  ReturnValue := TFftw32Wisdom.ImportSystem;
  CheckEquals(0, ReturnValue);
end;

initialization
  RegisterTest('Fftw32', TestTFftw32Dft.Suite);
  RegisterTest('Fftw32', TestTFftw32DftReal2Complex.Suite);
  RegisterTest('Fftw32', TestTFftw32DftComplex2Real.Suite);
  RegisterTest('Fftw32', TestTFftw32Real2Real.Suite);
(*
  RegisterTest(TestTFftw32Guru.Suite);
  RegisterTest(TestTFftw32Guru64.Suite);
*)
  RegisterTest('Fftw32', TestTFftw32Wisdom.Suite);
end.
