unit TestFftw3_80;

interface

uses
{$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  Fftw3_Common, Classes, SysUtils, Fftw3_80;

const
  CFFTSize = 8192;

type
  TestTFftw80Dft = class(TTestCase)
  strict private
    FFftw80Dft: TFftw80Dft;
    FInput, FOutput: PFftw80Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw80DftReal2Complex = class(TTestCase)
  strict private
    FFftw80DftReal2Complex: TFftw80DftReal2Complex;
    FInput: PFftw80Real;
    FOutput: PFftw80Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw80DftComplex2Real = class(TTestCase)
  strict private
    FFftw80DftComplex2Real: TFftw80DftComplex2Real;
    FInput: PFftw80Complex;
    FOutput: PFftw80Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw80Real2Real = class(TTestCase)
  strict private
    FFftw80Real2Real: TFftw80Real2Real;
    FInput, FOutput: PFftw80Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw80Guru = class(TTestCase)
  strict private
    FFftw80Guru: TFftw80Guru;
    FInput, FOutput: PFftw80Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw80Guru64 = class(TTestCase)
  strict private
    FFftw80Guru64: TFftw80Guru64;
    FInput, FOutput: PFftw80Complex;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
    procedure TestExecuteSplit;
    procedure TestGetFlops;
    procedure TestGetCost;
  end;

  TestTFftw80Wisdom = class(TTestCase)
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

{ TestTFftw80Dft }

procedure TestTFftw80Dft.SetUp;
begin
  // allocate memory
  FInput := Fftw80AllocComplex(CFFTSize);
  FOutput := Fftw80AllocComplex(CFFTSize);

  // create plan
  FFftw80Dft := TFftw80Dft.Create(CFFTSize, FInput, FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw80Dft.TearDown;
begin
  // free memory
  Fftw80Free(FOutput);
  FOutput := nil;
  Fftw80Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw80Dft.Free;
  FFftw80Dft := nil;
end;

procedure TestTFftw80Dft.TestExecute;
begin
  // perform FFT
  FFftw80Dft.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw80Dft.Execute(FInput, FOutput);
end;

procedure TestTFftw80Dft.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw80Real;
begin
  Ri := PFftw80Real(FInput);
  Ii := PFftw80Real(FInput);
  Ro := PFftw80Real(FOutput);
  Io := PFftw80Real(FOutput);

  // perform FFT
  FFftw80Dft.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw80Dft.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw80Dft.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw80Dft.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw80Dft.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw80Dft.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw80DftReal2Complex }

procedure TestTFftw80DftReal2Complex.SetUp;
begin
  // allocate memory
  FInput := Fftw80AllocReal(CFFTSize);
  FOutput := Fftw80AllocComplex(CFFTSize);

  // create plan
  FFftw80DftReal2Complex := TFftw80DftReal2Complex.Create(CFFTSize, FInput,
    FOutput, [ffEstimate]);
end;

procedure TestTFftw80DftReal2Complex.TearDown;
begin
  // free memory
  Fftw80Free(FOutput);
  FOutput := nil;
  Fftw80Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw80DftReal2Complex.Free;
  FFftw80DftReal2Complex := nil;
end;

procedure TestTFftw80DftReal2Complex.TestExecute;
begin
  // perform FFT
  FFftw80DftReal2Complex.Execute(FInput, FOutput);

  // repeat FFT
  FFftw80DftReal2Complex.Execute(FInput, FOutput);
end;

procedure TestTFftw80DftReal2Complex.TestExecuteSplit;
var
  &In, Ro, Io: PFftw80Real;
begin
  &In := PFftw80Real(FInput);
  Ro := PFftw80Real(FOutput);
  Io := PFftw80Real(FOutput);

  // perform FFT
  FFftw80DftReal2Complex.Execute(&In, Ro, Io);

  // perform FFT (again)
  FFftw80DftReal2Complex.Execute(&In, Ro, Io);
end;

procedure TestTFftw80DftReal2Complex.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw80DftReal2Complex.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw80DftReal2Complex.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw80DftReal2Complex.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw80DftComplex2Real }

procedure TestTFftw80DftComplex2Real.SetUp;
begin
  // allocate memory
  FInput := Fftw80AllocComplex(CFFTSize);
  FOutput := Fftw80AllocReal(CFFTSize);

  // create plan
  FFftw80DftComplex2Real := TFftw80DftComplex2Real.Create(CFFTSize, FInput,
    FOutput, [ffEstimate]);
end;

procedure TestTFftw80DftComplex2Real.TearDown;
begin
  // free memory
  Fftw80Free(FOutput);
  FOutput := nil;
  Fftw80Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw80DftComplex2Real.Free;
  FFftw80DftComplex2Real := nil;
end;

procedure TestTFftw80DftComplex2Real.TestExecute;
begin
  // perform FFT
  FFftw80DftComplex2Real.Execute(FInput, FOutput);

  // repeat FFT
  FFftw80DftComplex2Real.Execute(FInput, FOutput);
end;

procedure TestTFftw80DftComplex2Real.TestExecuteSplit;
var
  Ri, Ii, &Out: PFftw80Real;
begin
  Ri := PFftw80Real(FInput);
  Ii := PFftw80Real(FInput);
  &Out := PFftw80Real(FOutput);

  // perform FFT
  FFftw80DftComplex2Real.Execute(Ri, Ii, &Out);

  // perform FFT (again)
  FFftw80DftComplex2Real.Execute(Ri, Ii, &Out);
end;

procedure TestTFftw80DftComplex2Real.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw80DftComplex2Real.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw80DftComplex2Real.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw80DftComplex2Real.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw80Real2Real }

procedure TestTFftw80Real2Real.SetUp;
begin
  // allocate memory
  FInput := Fftw80AllocReal(CFFTSize);
  FOutput := Fftw80AllocReal(CFFTSize);

  // create plan
  FFftw80Real2Real := TFftw80Real2Real.Create(CFFTSize, FInput, FOutput,
    fkDiscreteHartleyTransform, [ffEstimate]);
end;

procedure TestTFftw80Real2Real.TearDown;
begin
  // free memory
  Fftw80Free(FOutput);
  FOutput := nil;
  Fftw80Free(FInput);
  FInput := nil;

  FFftw80Real2Real.Free;
  FFftw80Real2Real := nil;
end;

procedure TestTFftw80Real2Real.TestExecute;
begin
  // perform FFT
  FFftw80Real2Real.Execute(FInput, FOutput);

  // repeat FFT
  FFftw80Real2Real.Execute(FInput, FOutput);
end;

procedure TestTFftw80Real2Real.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw80Real2Real.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw80Real2Real.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw80Real2Real.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw80Guru }

procedure TestTFftw80Guru.SetUp;
var
  Dim: TFftwIoDim;
begin
  // allocate memory
  FInput := Fftw80AllocComplex(CFFTSize);
  FOutput := Fftw80AllocComplex(CFFTSize);

  // create plan
  FFftw80Guru := TFftw80Guru.Create(CFFTSize, @Dim, 1, @Dim, FInput,
    FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw80Guru.TearDown;
begin
  // free memory
  Fftw80Free(FOutput);
  FOutput := nil;
  Fftw80Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw80Guru.Free;
  FFftw80Guru := nil;
end;

procedure TestTFftw80Guru.TestExecute;
begin
  // perform FFT
  FFftw80Guru.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw80Guru.Execute(FInput, FOutput);
end;

procedure TestTFftw80Guru.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw80Real;
begin
  Ri := PFftw80Real(FInput);
  Ii := PFftw80Real(FInput);
  Ro := PFftw80Real(FOutput);
  Io := PFftw80Real(FOutput);

  // perform FFT
  FFftw80Guru.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw80Guru.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw80Guru.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw80Guru.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw80Guru.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw80Guru.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw80Guru64 }

procedure TestTFftw80Guru64.SetUp;
var
  Dim: TFftwIoDim;
begin
  // allocate memory
  FInput := Fftw80AllocComplex(CFFTSize);
  FOutput := Fftw80AllocComplex(CFFTSize);

  // create plan
  FFftw80Guru64 := TFftw80Guru64.Create(CFFTSize, @Dim, 1, @Dim, FInput,
    FOutput, fsForward, [ffEstimate]);
end;

procedure TestTFftw80Guru64.TearDown;
begin
  // free memory
  Fftw80Free(FOutput);
  FOutput := nil;
  Fftw80Free(FInput);
  FInput := nil;

  // destroy FFT
  FFftw80Guru64.Free;
  FFftw80Guru64 := nil;
end;

procedure TestTFftw80Guru64.TestExecute;
begin
  // perform FFT
  FFftw80Guru64.Execute(FInput, FOutput);

  // perform FFT (again)
  FFftw80Guru64.Execute(FInput, FOutput);
end;

procedure TestTFftw80Guru64.TestExecuteSplit;
var
  Ii, Ri, Io, Ro: PFftw80Real;
begin
  Ri := PFftw80Real(FInput);
  Ii := PFftw80Real(FInput);
  Ro := PFftw80Real(FOutput);
  Io := PFftw80Real(FOutput);

  // perform FFT
  FFftw80Guru64.Execute(Ri, Ii, Ro, Io);

  // perform FFT (again)
  FFftw80Guru64.Execute(Ri, Ii, Ro, Io);
end;

procedure TestTFftw80Guru64.TestGetFlops;
var
  Add, Mul, FMA: Double;
begin
  FFftw80Guru64.GetFlops(Add, Mul, FMA);
  CheckTrue(Add > 0);
  CheckTrue(Mul > 0);
  CheckTrue(FMA > 0);
end;

procedure TestTFftw80Guru64.TestGetCost;
var
  Cost: Double;
begin
  Cost := FFftw80Guru64.GetCost;
  CheckTrue(Cost >= 0);
end;


{ TestTFftw80Wisdom }

procedure TestTFftw80Wisdom.SetUp;
begin
end;

procedure TestTFftw80Wisdom.TearDown;
begin
end;

procedure TestTFftw80Wisdom.TestForgetWisdom;
begin
  TFftw80Wisdom.ForgetWisdom;
end;

procedure TestTFftw80Wisdom.TestImportExportToFilename;
var
  ReturnValue: Boolean;
begin
  ReturnValue := TFftw80Wisdom.ExportToFilename('Wisdom.wsd');
  CheckTrue(ReturnValue);

  ReturnValue := TFftw80Wisdom.ImportFromFilename('Wisdom.wsd');
  CheckTrue(ReturnValue);
end;

procedure TestTFftw80Wisdom.TestImportExportToString;
var
  Wisdom: AnsiString;
  ReturnValue: Boolean;
begin
  Wisdom := TFftw80Wisdom.ExportToString;
  CheckTrue(Wisdom <> '');

  ReturnValue := TFftw80Wisdom.ImportFromString(Wisdom);
  CheckTrue(ReturnValue);
end;

procedure FftwWriteCharFunc(c: AnsiChar; Ptr: Pointer); cdecl;
begin
  Assert(TObject(Ptr) is TestTFftw80Wisdom);
  TestTFftw80Wisdom(Ptr).FDataStream.Write(C, 1);
end;

function FftwReadCharFunc(Ptr: Pointer): PAnsiChar; cdecl;
begin
  Assert(TObject(Ptr) is TestTFftw80Wisdom);
  Result := TestTFftw80Wisdom(Ptr).FDataStream.Memory;
end;

procedure TestTFftw80Wisdom.TestImportExport;
var
  ReturnValue: Integer;
begin
  FDataStream := TMemoryStream.Create;
  try
    TFftw80Wisdom.Export(FftwWriteCharFunc, Self);
    CheckTrue(FDataStream.Size > 0);

    FDataStream.Position := 0;
    ReturnValue := TFftw80Wisdom.Import(FftwReadCharFunc, Self);
    CheckEquals(0, ReturnValue);
  finally
    FDataStream.Free;
  end;
end;

procedure TestTFftw80Wisdom.TestImportSystem;
var
  ReturnValue: Integer;
begin
  ReturnValue := TFftw80Wisdom.ImportSystem;
  CheckEquals(0, ReturnValue);
end;

initialization
  RegisterTest('Fftw80', TestTFftw80Dft.Suite);
  RegisterTest('Fftw80', TestTFftw80DftReal2Complex.Suite);
  RegisterTest('Fftw80', TestTFftw80DftComplex2Real.Suite);
  RegisterTest('Fftw80', TestTFftw80Real2Real.Suite);
(*
  RegisterTest('Fftw80', TestTFftw80Guru.Suite);
  RegisterTest('Fftw80', TestTFftw80Guru64.Suite);
*)
  RegisterTest('Fftw80', TestTFftw80Wisdom.Suite);
end.
