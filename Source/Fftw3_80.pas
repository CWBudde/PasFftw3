unit Fftw3_80;

{$I Fftw3.inc}

interface

uses
  SysUtils,
  Fftw3_Common;

{$DEFINE DynLink}

const
  CLibFftw80 = 'libfftw3l-3.dll';

type
  PFftw80Real = ^Extended;
  TFftw80Complex = packed record
    case Boolean of
      False: (Value: array [0..1] of Extended);
      True: (Re: Double; Im: Extended);
  end;
  PFftw80Complex = ^TFftw80Complex;

  TFftw80Plan = type Pointer;

{$IFDEF DynLink}
  TFftw80Execute = procedure (const Plan: TFftw80Plan); cdecl;
  TFftw80PlanDft = function (Rank: Integer; const N: PInteger; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDft1D = function (N: Integer; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDft2D = function (N0, N1: Integer; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDft3D = function (N0, N1, N2: Integer; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;

  TFftw80PlanManyDft = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuruDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuruSplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuru64Dft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuru64SplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80ExecuteDft = procedure (const Plan: TFftw80Plan; &In: PFftw80Complex; &Out: PFftw80Complex); cdecl;
  TFftw80ExecuteSplitDft = procedure (const Plan: TFftw80Plan; Ri, Ii, Ro, Io: PFftw80Real); cdecl;

  TFftw80PlanManyDftReal2Complex = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftReal2Complex = function (Rank: Integer; const N: PInteger; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftReal2Complex1D = function (N: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftReal2Complex2D = function (N0, N1: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftReal2Complex3D = function (N0, N1, N2: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl;

  TFftw80PlanManyDftComplex2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftComplex2Real = function (Rank: Integer; const N: PInteger; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftComplex2Real1D = function (N: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftComplex2Real2D = function (N0, N1: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanDftComplex2Real3D = function (N0, N1, N2: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;

  TFftw80PlanGuruDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuruDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuruSplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuruSplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;

  TFftw80PlanGuru64DftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuru64DftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuru64SplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuru64SplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl;

  TFftw80ExecuteDftReal2Complex = procedure (const Plan: TFftw80Plan; &In: PFftw80Real; &Out: PFftw80Complex); cdecl;
  TFftw80ExecuteDftComplex2Real = procedure (const Plan: TFftw80Plan; &In: PFftw80Complex; &Out: PFftw80Real); cdecl;
  TFftw80ExecuteSplitDftReal2Complex = procedure (const Plan: TFftw80Plan; &In, Ro, Io: PFftw80Real); cdecl;
  TFftw80ExecuteSplitDftComplex2Real = procedure (const Plan: TFftw80Plan; Ri, Ii, &Out: PFftw80Real); cdecl;

  TFftw80PlanManyReal2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanReal2Real = function (Rank: Integer; const N: PInteger; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanReal2Real1D = function (N: Integer; &In, &Out: PFftw80Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanReal2Real2D = function (N0, N1: Integer; &In, &Out: PFftw80Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanReal2Real3D = function (N0, N1, N2: Integer; &In, &Out: PFftw80Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuruReal2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80PlanGuru64Real2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl;
  TFftw80ExecuteReal2Real = procedure (const Plan: TFftw80Plan; &In, &Out: PFftw80Real); cdecl;

  TFftw80DestroyPlan = procedure (Plan: TFftw80Plan); cdecl;
  TFftw80ForgetWisdom = procedure; cdecl;
  TFftw80Cleanup = procedure; cdecl;
  TFftw80SetTimelimit = procedure (TimeLimit: Double); cdecl;
  TFftw80PlanWithNthreads = procedure (ThreadCount: Integer); cdecl;
  TFftw80InitThreads = function : Integer; cdecl;
  TFftw80CleanupThreads = procedure; cdecl;

  TFftw80ExportWisdomToFilename = function (const FileName: PAnsiChar): Boolean; cdecl;
  TFftw80ExportWisdomToFile = procedure (var OutputFile: file); cdecl;
  TFftw80ExportWisdomToString = function : PAnsiChar; cdecl;
  TFftw80ExportWisdom = procedure (WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl;

  TFftw80ImportSystemWisdom = function : Integer; cdecl;
  TFftw80ImportWisdomFromFilename = function (const FileName: PAnsiChar): Boolean; cdecl;
  TFftw80ImportWisdomFromFile = function (var InputFile: file): Boolean; cdecl;
  TFftw80ImportWisdomFromString = function (const InputString: PAnsiChar): Boolean; cdecl;
  TFftw80ImportWisdom = function (ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl;

  TFftw80FPrintPlan = procedure (const Plan: TFftw80Plan; var OutputFile: file); cdecl;
  TFftw80PrintPlan = procedure (const Plan: TFftw80Plan); cdecl;
  TFftw80SPrintPlan = function (const Plan: TFftw80Plan): PAnsiChar; cdecl;

  TFftw80Malloc = function (N: NativeUInt): Pointer; cdecl;
  TFftw80AllocReal = function (N: NativeUInt): PFftw80Real; cdecl;
  TFftw80AllocComplex = function (N: NativeUInt): PFftw80Complex; cdecl;
  TFftw80Free = procedure (Ptr: Pointer); cdecl;

  TFftw80Flops = procedure (const Plan: TFftw80Plan; out Add, Mul, FMAs: Double); cdecl;
  TFftw80EstimateCost = function (const Plan: TFftw80Plan): Double; cdecl;
  TFftw80Cost = function (const Plan: TFftw80Plan): Double; cdecl;
  TFftw80AlignmentOf = function (Ptr: PFftw80Real): Integer; cdecl;

var
  Fftw80Version: AnsiString;
  Fftw80CC: AnsiString;
  Fftw80CodeletOptim: AnsiString;

  Fftw80Execute: TFftw80Execute;
  Fftw80PlanDft: TFftw80PlanDft;
  Fftw80PlanDft1D: TFftw80PlanDft1D;
  Fftw80PlanDft2D: TFftw80PlanDft2D;
  Fftw80PlanDft3D: TFftw80PlanDft3D;

  Fftw80PlanManyDft: TFftw80PlanManyDft;
  Fftw80PlanGuruDft: TFftw80PlanGuruDft;
  Fftw80PlanGuruSplitDft: TFftw80PlanGuruSplitDft;
  Fftw80PlanGuru64Dft: TFftw80PlanGuru64Dft;
  Fftw80PlanGuru64SplitDft: TFftw80PlanGuru64SplitDft;
  Fftw80ExecuteDft: TFftw80ExecuteDft;
  Fftw80ExecuteSplitDft: TFftw80ExecuteSplitDft;

  Fftw80PlanManyDftReal2Complex: TFftw80PlanManyDftReal2Complex;
  Fftw80PlanDftReal2Complex: TFftw80PlanDftReal2Complex;
  Fftw80PlanDftReal2Complex1D: TFftw80PlanDftReal2Complex1D;
  Fftw80PlanDftReal2Complex2D: TFftw80PlanDftReal2Complex2D;
  Fftw80PlanDftReal2Complex3d:tFftw80PlanDftReal2Complex3D;

  Fftw80PlanManyDftComplex2Real: TFftw80PlanManyDftComplex2Real;
  Fftw80PlanDftComplex2Real: TFftw80PlanDftComplex2Real;
  Fftw80PlanDftComplex2Real1D: TFftw80PlanDftComplex2Real1D;
  Fftw80PlanDftComplex2Real2D: TFftw80PlanDftComplex2Real2D;
  Fftw80PlanDftComplex2Real3D: TFftw80PlanDftComplex2Real3D;

  Fftw80PlanGuruDftReal2Complex: TFftw80PlanGuruDftReal2Complex;
  Fftw80PlanGuruDftComplex2Real: TFftw80PlanGuruDftComplex2Real;
  Fftw80PlanGuruSplitDftReal2Complex: TFftw80PlanGuruSplitDftReal2Complex;
  Fftw80PlanGuruSplitDftComplex2Real: TFftw80PlanGuruSplitDftComplex2Real;

  Fftw80PlanGuru64DftReal2Complex: TFftw80PlanGuru64DftReal2Complex;
  Fftw80PlanGuru64DftComplex2Real: TFftw80PlanGuru64DftComplex2Real;
  Fftw80PlanGuru64SplitDftReal2Complex: TFftw80PlanGuru64SplitDftReal2Complex;
  Fftw80PlanGuru64SplitDftComplex2Real: TFftw80PlanGuru64SplitDftComplex2Real;

  Fftw80ExecuteDftReal2Complex: TFftw80ExecuteDftReal2Complex;
  Fftw80ExecuteDftComplex2Real: TFftw80ExecuteDftComplex2Real;
  Fftw80ExecuteSplitDftReal2Complex: TFftw80ExecuteSplitDftReal2Complex;
  Fftw80ExecuteSplitDftComplex2Real: TFftw80ExecuteSplitDftComplex2Real;

  Fftw80PlanManyReal2Real: TFftw80PlanManyReal2Real;
  Fftw80PlanReal2Real: TFftw80PlanReal2Real;
  Fftw80PlanReal2Real1D: TFftw80PlanReal2Real1D;
  Fftw80PlanReal2Real2D: TFftw80PlanReal2Real2D;
  Fftw80PlanReal2Real3D: TFftw80PlanReal2Real3D;
  Fftw80PlanGuruReal2Real: TFftw80PlanGuruReal2Real;
  Fftw80PlanGuru64Real2Real: TFftw80PlanGuru64Real2Real;
  Fftw80ExecuteReal2Real: TFftw80ExecuteReal2Real;

  Fftw80DestroyPlan: TFftw80DestroyPlan;
  Fftw80ForgetWisdom: TFftw80ForgetWisdom;
  Fftw80Cleanup: TFftw80Cleanup;
  Fftw80SetTimelimit: TFftw80SetTimelimit;
  Fftw80PlanWithNthreads: TFftw80PlanWithNthreads;
  Fftw80InitThreads: TFftw80InitThreads;
  Fftw80CleanupThreads: TFftw80CleanupThreads;

  Fftw80ExportWisdomToFilename: TFftw80ExportWisdomToFilename;
  Fftw80ExportWisdomToFile: TFftw80ExportWisdomToFile;
  Fftw80ExportWisdomToString: TFftw80ExportWisdomToString;
  Fftw80ExportWisdom: TFftw80ExportWisdom;

  Fftw80ImportSystemWisdom: TFftw80ImportSystemWisdom;
  Fftw80ImportWisdomFromFilename: TFftw80ImportWisdomFromFilename;
  Fftw80ImportWisdomFromFile: TFftw80ImportWisdomFromFile;
  Fftw80ImportWisdomFromString: TFftw80ImportWisdomFromString;
  Fftw80ImportWisdom: TFftw80ImportWisdom;

  Fftw80FPrintPlan: TFftw80FprintPlan;
  Fftw80PrintPlan: TFftw80PrintPlan;
  Fftw80SPrintPlan: TFftw80SPrintPlan;

  Fftw80Malloc: TFftw80Malloc;
  Fftw80AllocReal: TFftw80AllocReal;
  Fftw80AllocComplex: TFftw80AllocComplex;
  Fftw80Free: TFftw80Free;

  Fftw80Flops: TFftw80Flops;
  Fftw80EstimateCost: TFftw80EstimateCost;
  Fftw80Cost: TFftw80Cost;
  Fftw80AlignmentOf: TFftw80AlignmentOf;
{$ELSE}
  procedure Fftw80Execute(const Plan: TFftw80Plan); cdecl; external CLibFftw64 name 'fftwl_execute';
  function Fftw80PlanDft(Rank: Integer; const N: PInteger; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft';
  function Fftw80PlanDft1D(N: Integer; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_1d';
  function Fftw80PlanDft2D(N0, N1: Integer; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_2d';
  function Fftw80PlanDft3D(N0, N1, N2: Integer; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_3d';

  function Fftw80PlanManyDft(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_many_dft';
  function Fftw80PlanGuruDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_dft';
  function Fftw80PlanGuruSplitDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_split_dft';
  function Fftw80PlanGuru64Dft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Complex; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_dft';
  function Fftw80PlanGuru64SplitDft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_split_dft';
  procedure Fftw80ExecuteDft(const Plan: TFftw80Plan; &In: PFftw80Complex; &Out: PFftw80Complex); cdecl; external CLibFftw80 name 'fftwl_execute_dft';
  procedure Fftw80ExecuteSplitDft(const Plan: TFftw80Plan; Ri, Ii, Ro, Io: PFftw80Real); cdecl; external CLibFftw80 name 'fftwl_execute_split_dft';

  function Fftw80PlanManyDft_Real2Complex(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_many_dft_r2c';
  function Fftw80PlanDftReal2Complex(Rank: Integer; const N: PInteger; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_r2c';
  function Fftw80PlanDftReal2Complex1D(N: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_r2c_1d';
  function Fftw80PlanDftReal2Complex2D(N0, N1: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_r2c_2d';
  function Fftw80PlanDftReal2Complex3D(N0, N1, N2: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_r2c_3d';

  function Fftw80PlanManyDftComplex2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_many_dft_c2r';
  function Fftw80PlanDftComplex2Real(Rank: Integer; const N: PInteger; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_c2r';
  function Fftw80PlanDftComplex2Real1D(N: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_c2r_1d';
  function Fftw80PlanDftComplex2Real2D(N0, N1: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_c2r_2d';
  function Fftw80PlanDftComplex2Real3D(N0, N1, N2: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_dft_c2r_3d';

  function Fftw80PlanGuruDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_dft_r2c';
  function Fftw80PlanGuruDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_dft_c2r';
  function Fftw80PlanGuruSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_split_dft_r2c';
  function Fftw80PlanGuruSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_split_dft_c2r';

  function Fftw80PlanGuru64DftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_dft_r2c';
  function Fftw80PlanGuru64DftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_dft_c2r';
  function Fftw80PlanGuru64SplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_split_dft_r2c';
  function Fftw80PlanGuru64SplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw80Real; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_split_dft_c2r';

  procedure Fftw80ExecuteDftReal2Complex(const Plan: TFftw80Plan; &In: PFftw80Real; &Out: PFftw80Complex); cdecl; external CLibFftw80 name 'fftwl_execute_dft_r2c';
  procedure Fftw80ExecuteDftComplex2Real(const Plan: TFftw80Plan; &In: PFftw80Complex; &Out: PFftw80Real); cdecl; external CLibFftw80 name 'fftwl_execute_dft_c2r';
  procedure Fftw80ExecuteSplitDftReal2Complex(const Plan: TFftw80Plan; &In, Ro, Io: PFftw80Real); cdecl; external CLibFftw80 name 'fftwl_execute_split_dft_r2c';
  procedure Fftw80ExecuteSplitDftComplex2Real(const Plan: TFftw80Plan; Ri, Ii, &Out: PFftw80Real); cdecl; external CLibFftw80 name 'fftwl_execute_split_dft_c2r';

  function Fftw80PlanManyReal2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_many_r2r';
  function Fftw80PlanReal2Real(Rank: Integer; const N: PInteger; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_r2r';
  function Fftw80PlanReal2Real1D(N: Integer; &In, &Out: PFftw80Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_r2r_1d';
  function Fftw80PlanReal2Real2D(N0, N1: Integer; &In, &Out: PFftw80Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_r2r_2d';
  function Fftw80PlanReal2Real3D(N0, N1, N2: Integer; &In, &Out: PFftw80Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_r2r_3d';
  function Fftw80PlanGuruReal2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru_r2r';
  function Fftw80PlanGuru64Real2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw80Plan; cdecl; external CLibFftw80 name 'fftwl_plan_guru64_r2r';
  procedure Fftw80ExecuteReal2Real(const Plan: TFftw80Plan; &In, &Out: PFftw80Real); cdecl; external CLibFftw80 name 'fftwl_execute_r2r';

  procedure Fftw80DestroyPlan(Plan: TFftw80Plan); cdecl; external CLibFftw80 name 'fftwl_destroy_plan';
  procedure Fftw80ForgetWisdom; cdecl; external CLibFftw80 name 'fftwl_forget_wisdom';
  procedure Fftw80Cleanup; cdecl; external CLibFftw80 name 'fftwl_cleanup';
  procedure Fftw80SetTimelimit(TimeLimit: Double); cdecl; external CLibFftw80 name 'fftwl_set_timelimit';
  procedure Fftw80PlanWith_nthreads(ThreadCount: Integer); cdecl; external CLibFftw80 name 'fftwl_plan_with_nthreads';
  function Fftw80InitThreads: Integer; cdecl; external CLibFftw80 name 'fftwl_init_threads';
  procedure Fftw80CleanupThreads; cdecl; external CLibFftw80 name 'fftwl_cleanup_threads';

  function Fftw80ExportWisdomToFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw80 name 'fftwl_export_wisdom_to_filename';
  procedure Fftw80ExportWisdomToFile(var OutputFile: file); cdecl; external CLibFftw80 name 'fftwl_export_wisdom_to_file';
  function Fftw80ExportWisdomToString: PAnsiChar; cdecl; external CLibFftw80 name 'fftwl_export_wisdom_to_string';
  procedure Fftw80ExportWisdom(WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl; external CLibFftw80 name 'fftwl_export_wisdom';

  function Fftw80ImportSystemWisdom: Integer; cdecl; external CLibFftw80 name 'fftwl_import_system_wisdom';
  function Fftw80ImportWisdomFromFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw80 name 'fftwl_import_wisdom_from_filename';
  function Fftw80ImportWisdomFromFile(var InputFile: file): Integer; cdecl; external CLibFftw80 name 'fftwl_import_wisdom_from_file';
  function Fftw80ImportWisdomFromString(const InputString: PAnsiChar): Integer; cdecl; external CLibFftw80 name 'fftwl_import_wisdom_from_string';
  function Fftw80ImportWisdom(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl; external CLibFftw80 name 'fftwl_import_wisdom';

  procedure Fftw80FPrintPlan(const Plan: TFftw80Plan; var OutputFile: file); cdecl; external CLibFftw80 name 'fftwl_fprint_plan';
  procedure Fftw80PrintPlan(const Plan: TFftw80Plan); cdecl; external CLibFftw80 name 'fftwl_print_plan';
  function Fftw80SPrintPlan(const Plan: TFftw80Plan): PAnsiChar; cdecl; external CLibFftw80 name 'fftwl_sprint_plan';

  function Fftw80Malloc(N: NativeUInt): Pointer; cdecl; external CLibFftw80 name 'fftwl_malloc';
  function Fftw80AllocReal(N: NativeUInt): PFftw80Real; cdecl; external CLibFftw80 name 'fftwl_alloc_real';
  function Fftw80AllocComplex(N: NativeUInt): PFftw80Complex; cdecl; external CLibFftw80 name 'fftwl_alloc_complex';
  procedure Fftw80Free(Ptr: Pointer); cdecl; external CLibFftw80 name 'fftwl_free';

  procedure Fftw80Flops(const Plan: TFftw80Plan; out Add, Mul, FMAs: Double); cdecl; external CLibFftw80 name 'fftwl_flops';
  function Fftw80EstimateCost(const Plan: TFftw80Plan): Double; cdecl; external CLibFftw80 name 'fftwl_estimate_cost';
  function Fftw80Cost(const Plan: TFftw80Plan): Double; cdecl; external CLibFftw80 name 'fftwl_cost';
  function Fftw80AlignmentOf(Ptr: PFftw80Real): Integer; cdecl; external CLibFftw80 name 'fftwl_alignment_of';
{$ENDIF}

type
  TCustomFftw80 = class
  private
    FPlan: TFftw80Plan;
    function GetAsText: string;
    function GetEstimateCost: Double;
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;

    procedure Execute; overload;

    procedure GetFlops(out Add, Mul, FMAs: Double);
    function GetCost: Double;

    property AsText: string read GetAsText;
    property EstimateCost: Double read GetEstimateCost;
  end;

  TFftw80Dft = class(TCustomFftw80)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags);

    procedure Execute(&In, &Out: PFftw80Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw80Real); overload;
  end;

  TFftw80DftReal2Complex = class(TCustomFftw80)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In: PFftw80Real; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags);

    procedure Execute(&In: PFftw80Real; &Out: PFftw80Complex); overload;
    procedure Execute(&In, Ro, Io: PFftw80Real); overload;
  end;

  TFftw80DftComplex2Real = class(TCustomFftw80)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags);

    procedure Execute(&In: PFftw80Complex; &Out: PFftw80Real); overload;
    procedure Execute(Ri, Ii, &Out: PFftw80Real); overload;
  end;

  TFftw80Real2Real = class(TCustomFftw80)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In, &Out: PFftw80Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In, &Out: PFftw80Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In, &Out: PFftw80Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);

    procedure Execute(&In, &Out: PFftw80Real); overload;
  end;

  TFftw80Guru = class(TCustomFftw80)
  public
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags); overload;
    constructor CreateSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw80Real; Flags: TFftwFlags); overload;

    procedure Execute(&In, &Out: PFftw80Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw80Real); overload;
  end;

  TFftw80Guru64 = class(TCustomFftw80)
  public
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Real; &Out: PFftw80Complex; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags); overload;
    constructor CreateSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw80Real; Flags: TFftwFlags); overload;

    procedure Execute(&In, &Out: PFftw80Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw80Real); overload;
  end;

  TFftw80Wisdom = class sealed
  public
    class procedure ForgetWisdom;
    class function ExportToFilename(const FileName: TFileName): Boolean;
    class procedure ExportToFile(var OutputFile: file);
    class function ExportToString: AnsiString;
    class procedure &Export(WriteChar: TFftwWriteCharFunc; Data: Pointer);

    class function ImportSystem: Integer;
    class function ImportFromFilename(const FileName: TFileName): Boolean;
    class function ImportFromFile(var InputFile: file): Boolean;
    class function ImportFromString(const InputString: AnsiString): Boolean;
    class function &Import(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer;
  end;

implementation

{$IFDEF DynLink}
uses
  Windows;
{$ENDIF}

{ TCustomFftw80 }

constructor TCustomFftw80.Create;
begin
  raise Exception.Create('Default constructor not supported!');
end;

destructor TCustomFftw80.Destroy;
begin
  Fftw80DestroyPlan(FPlan);
end;

procedure TCustomFftw80.Execute;
begin
  Fftw80Execute(FPlan);
end;

function TCustomFftw80.GetAsText: string;
begin
  Result := string(Fftw80SPrintPlan(FPlan));
end;

function TCustomFftw80.GetEstimateCost: Double;
begin
  Result := Fftw80EstimateCost(FPlan);
end;

procedure TCustomFftw80.GetFlops(out Add, Mul, FMAs: Double);
begin
  Fftw80Flops(FPlan, Add, Mul, FMAs);
end;

function TCustomFftw80.GetCost: Double;
begin
  Result := Fftw80Cost(FPlan);
end;


{ TFftw80Dft }

constructor TFftw80Dft.Create(Rank: Integer; const N: PInteger; &In,
  &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDft(Rank, N, &In, &Out, Sign, Flags);
end;

constructor TFftw80Dft.Create(N: Integer; &In, &Out: PFftw80Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDft1D(N, &In, &Out, Sign, Flags);
end;

constructor TFftw80Dft.Create(N0, N1: Integer; &In, &Out: PFftw80Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDft2D(N0, N1, &In, &Out, Sign, Flags);
end;

constructor TFftw80Dft.Create(N0, N1, N2: Integer; &In, &Out: PFftw80Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDft3D(N0, N1, N2, &In, &Out, Sign, Flags);
end;

constructor TFftw80Dft.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanManyDft(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Sign, Flags);
end;

procedure TFftw80Dft.Execute(&In, &Out: PFftw80Complex);
begin
  Fftw80ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw80Dft.Execute(Ri, Ii, Ro, Io: PFftw80Real);
begin
  Fftw80ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw80DftReal2Complex }

constructor TFftw80DftReal2Complex.Create(Rank: Integer; const N: PInteger;
  &In: PFftw80Real; &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftReal2Complex(Rank, N, &In, &Out, Flags);
end;

constructor TFftw80DftReal2Complex.Create(N: Integer; &In: PFftw80Real;
  &Out: PFftw80Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftReal2Complex1D(N, &In, &Out, Flags);
end;

constructor TFftw80DftReal2Complex.Create(N0, N1: Integer; &In: PFftw80Real;
  &Out: PFftw80Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftReal2Complex2D(N0, N1, &In, &Out, Flags);
end;

constructor TFftw80DftReal2Complex.Create(N0, N1, N2: Integer; &In: PFftw80Real;
  &Out: PFftw80Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftReal2Complex3D(N0, N1, N2, &In, &Out, Flags);
end;

constructor TFftw80DftReal2Complex.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw80Complex; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanManyDftReal2Complex(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Flags);
end;

procedure TFftw80DftReal2Complex.Execute(&In: PFftw80Real; &Out: PFftw80Complex);
begin
  Fftw80ExecuteDftReal2Complex(FPlan, &In, &Out);
end;

procedure TFftw80DftReal2Complex.Execute(&In, Ro, Io: PFftw80Real);
begin
  Fftw80ExecuteSplitDftReal2Complex(FPlan, &In, Ro, Io);
end;


{ TFftw80DftComplex2Real }

constructor TFftw80DftComplex2Real.Create(Rank: Integer; const N: PInteger;
  &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftComplex2Real(Rank, N, &In, &Out, Flags);
end;

constructor TFftw80DftComplex2Real.Create(N: Integer; &In: PFftw80Complex; &Out: PFftw80Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftComplex2Real1D(N, &In, &Out, Flags);
end;

constructor TFftw80DftComplex2Real.Create(N0, N1: Integer; &In: PFftw80Complex; &Out: PFftw80Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftComplex2Real2D(N0, N1, &In, &Out, Flags);
end;

constructor TFftw80DftComplex2Real.Create(N0, N1, N2: Integer; &In: PFftw80Complex; &Out: PFftw80Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanDftComplex2Real3D(N0, N1, N2, &In, &Out, Flags);
end;

constructor TFftw80DftComplex2Real.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw80Complex; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanManyDftComplex2Real(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Flags);
end;

procedure TFftw80DftComplex2Real.Execute(&In: PFftw80Complex; &Out: PFftw80Real);
begin
  Fftw80ExecuteDftComplex2Real(FPlan, &In, &Out);
end;

procedure TFftw80DftComplex2Real.Execute(Ri, Ii, &Out: PFftw80Real);
begin
  Fftw80ExecuteSplitDftComplex2Real(FPlan, Ri, Ii, &Out);
end;


{ TFftw80Real2Real }

constructor TFftw80Real2Real.Create(Rank: Integer; const N: PInteger;
  &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanReal2Real(Rank, N, &In, &Out, Kind, Flags);
end;

constructor TFftw80Real2Real.Create(N: Integer; &In, &Out: PFftw80Real;
  Kind: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanReal2Real1D(N, &In, &Out, Kind, Flags);
end;

constructor TFftw80Real2Real.Create(N0, N1: Integer; &In, &Out: PFftw80Real;
  Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanReal2Real2D(N0, N1, &In, &Out, Kind0, Kind1, Flags);
end;

constructor TFftw80Real2Real.Create(N0, N1, N2: Integer; &In, &Out: PFftw80Real;
  Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanReal2Real3D(N0, N1, N2, &In, &Out, Kind0, Kind1, Kind2,
    Flags);
end;

constructor TFftw80Real2Real.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw80Real; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw80Real; const onembed: PInteger;
  OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanManyReal2Real(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Kind, Flags);
end;

procedure TFftw80Real2Real.Execute(&In, &Out: PFftw80Real);
begin
  Fftw80ExecuteReal2Real(FPlan, &In, &Out);
end;


{ TFftw80Guru }

constructor TFftw80Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruDft(Rank, Dimensions, HowManyRank, HowManyDimensions,
    &In, &Out, Sign, Flags);
end;

constructor TFftw80Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruSplitDft(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, Ro, Io, Flags);
end;

constructor TFftw80Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw80Real;
  &Out: PFftw80Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw80Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw80Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw80Real;
  const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruReal2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Kind, Flags);
end;

constructor TFftw80Guru.CreateSplitDftReal2Complex(Rank: Integer;
  const Dimensions: PFftwIoDim; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw80Real; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruSplitDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, Ro, Io, Flags);
end;

constructor TFftw80Guru.CreateSplitDftComplex2Real(Rank: Integer;
  const Dimensions: PFftwIoDim; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw80Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuruSplitDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, &Out, Flags);
end;

procedure TFftw80Guru.Execute(&In, &Out: PFftw80Complex);
begin
  Fftw80ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw80Guru.Execute(Ri, Ii, Ro, Io: PFftw80Real);
begin
  Fftw80ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw80Guru64 }

constructor TFftw80Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In, &Out: PFftw80Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64Dft(Rank, Dimensions, HowManyRank, HowManyDimensions,
    &In, &Out, Sign, Flags);
end;

constructor TFftw80Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  Ri, Ii, Ro, Io: PFftw80Real; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64SplitDft(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, Ro, Io, Flags);
end;

constructor TFftw80Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw80Real;
  &Out: PFftw80Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64DftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw80Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In: PFftw80Complex; &Out: PFftw80Real; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64DftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw80Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In, &Out: PFftw80Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64Real2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Kind, Flags);
end;

constructor TFftw80Guru64.CreateSplitDftReal2Complex(Rank: Integer;
  const Dimensions: PFftwIoDim64; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw80Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64SplitDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, Ro, Io, Flags);
end;

constructor TFftw80Guru64.CreateSplitDftComplex2Real(Rank: Integer;
  const Dimensions: PFftwIoDim64; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw80Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw80PlanGuru64SplitDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, &Out, Flags);
end;

procedure TFftw80Guru64.Execute(&In, &Out: PFftw80Complex);
begin
  Fftw80ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw80Guru64.Execute(Ri, Ii, Ro, Io: PFftw80Real);
begin
  Fftw80ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw80Wisdom }

class procedure TFftw80Wisdom.ForgetWisdom;
begin
  Fftw80ForgetWisdom;
end;

class function TFftw80Wisdom.ExportToFilename(const FileName: TFileName): Boolean;
begin
  Result := Fftw80ExportWisdomToFilename(PAnsiChar(AnsiString(FileName)));
end;

class procedure TFftw80Wisdom.ExportToFile(var OutputFile: file);
begin
  Fftw80ExportWisdomToFile(OutputFile);
end;

class function TFftw80Wisdom.ExportToString: AnsiString;
begin
  Result := Fftw80ExportWisdomToString;
end;

class procedure TFftw80Wisdom.&Export(WriteChar: TFftwWriteCharFunc; Data: Pointer);
begin
  Fftw80ExportWisdom(WriteChar, Data);
end;

class function TFftw80Wisdom.ImportSystem: Integer;
begin
  Result := Fftw80ImportSystemWisdom;
end;

class function TFftw80Wisdom.ImportFromFilename(const FileName: TFileName): Boolean;
begin
  Result := Fftw80ImportWisdomFromFilename(PAnsiChar(AnsiString(FileName)));
end;

class function TFftw80Wisdom.ImportFromFile(var InputFile: file): Boolean;
begin
  Result := Fftw80ImportWisdomFromFile(InputFile);
end;

class function TFftw80Wisdom.ImportFromString(const InputString: AnsiString): Boolean;
begin
  Result := Fftw80ImportWisdomFromString(PAnsiChar(AnsiString(InputString)));
end;

class function TFftw80Wisdom.&Import(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer;
begin
  Result := Fftw80ImportWisdom(ReadChar, Data);
end;


{$IFDEF DynLink}
var
  LibFftwHandle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};

procedure InitializeLibrary;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(LibFftwHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  if not FileExists(CLibFftw80) then
    raise Exception.CreateFmt('File not found (%s)', [CLibFftw80]);

  LibFftwHandle := LoadLibrary(CLibFftw80);
  if LibFftwHandle <> 0 then
    try
      Fftw80Version := PAnsiChar(GetProcAddress(LibFftwHandle, PAnsiChar('fftwl_version')));
      Fftw80CC := PAnsiChar(GetProcAddress(LibFftwHandle, PAnsiChar('fftwl_cc')));
      Fftw80CodeletOptim := PAnsiChar(GetProcAddress(LibFftwHandle, PAnsiChar('fftwl_codelet_optim')));

      Fftw80Execute := BindFunction('fftwl_execute');
      Fftw80PlanDft := BindFunction('fftwl_plan_dft');
      Fftw80PlanDft1D := BindFunction('fftwl_plan_dft_1d');
      Fftw80PlanDft2D := BindFunction('fftwl_plan_dft_2d');
      Fftw80PlanDft3D := BindFunction('fftwl_plan_dft_3d');

      Fftw80PlanManyDft := BindFunction('fftwl_plan_many_dft');
      Fftw80PlanGuruDft := BindFunction('fftwl_plan_guru_dft');
      Fftw80PlanGuruSplitDft := BindFunction('fftwl_plan_guru_split_dft');
      Fftw80PlanGuru64Dft := BindFunction('fftwl_plan_guru64_dft');
      Fftw80PlanGuru64SplitDft := BindFunction('fftwl_plan_guru64_split_dft');
      Fftw80ExecuteDft := BindFunction('fftwl_execute_dft');
      Fftw80ExecuteSplitDft := BindFunction('fftwl_execute_split_dft');

      Fftw80PlanManyDftReal2Complex := BindFunction('fftwl_plan_many_dft_r2c');
      Fftw80PlanDftReal2Complex := BindFunction('fftwl_plan_dft_r2c');
      Fftw80PlanDftReal2Complex1D := BindFunction('fftwl_plan_dft_r2c_1d');
      Fftw80PlanDftReal2Complex2D := BindFunction('fftwl_plan_dft_r2c_2d');
      Fftw80PlanDftReal2Complex3D := BindFunction('fftwl_plan_dft_r2c_3d');

      Fftw80PlanManyDftComplex2Real := BindFunction('fftwl_plan_many_dft_c2r');
      Fftw80PlanDftComplex2Real := BindFunction('fftwl_plan_dft_c2r');
      Fftw80PlanDftComplex2Real1D := BindFunction('fftwl_plan_dft_c2r_1d');
      Fftw80PlanDftComplex2Real2D := BindFunction('fftwl_plan_dft_c2r_2d');
      Fftw80PlanDftComplex2Real3D := BindFunction('fftwl_plan_dft_c2r_3d');

      Fftw80PlanGuruDftReal2Complex := BindFunction('fftwl_plan_guru_dft_r2c');
      Fftw80PlanGuruDftComplex2Real := BindFunction('fftwl_plan_guru_dft_c2r');
      Fftw80PlanGuruSplitDftReal2Complex := BindFunction('fftwl_plan_guru_split_dft_r2c');
      Fftw80PlanGuruSplitDftComplex2Real := BindFunction('fftwl_plan_guru_split_dft_c2r');

      Fftw80PlanGuru64DftReal2Complex := BindFunction('fftwl_plan_guru64_dft_r2c');
      Fftw80PlanGuru64DftComplex2Real := BindFunction('fftwl_plan_guru64_dft_c2r');
      Fftw80PlanGuru64SplitDftReal2Complex := BindFunction('fftwl_plan_guru64_split_dft_r2c');
      Fftw80PlanGuru64SplitDftComplex2Real := BindFunction('fftwl_plan_guru64_split_dft_c2r');

      Fftw80ExecuteDftReal2Complex := BindFunction('fftwl_execute_dft_r2c');
      Fftw80ExecuteDftComplex2Real := BindFunction('fftwl_execute_dft_c2r');
      Fftw80ExecuteSplitDftReal2Complex := BindFunction('fftwl_execute_split_dft_r2c');
      Fftw80ExecuteSplitDftComplex2Real := BindFunction('fftwl_execute_split_dft_c2r');

      Fftw80PlanManyReal2Real := BindFunction('fftwl_plan_many_r2r');
      Fftw80PlanReal2Real := BindFunction('fftwl_plan_r2r');
      Fftw80PlanReal2Real1D := BindFunction('fftwl_plan_r2r_1d');
      Fftw80PlanReal2Real2D := BindFunction('fftwl_plan_r2r_2d');
      Fftw80PlanReal2Real3D := BindFunction('fftwl_plan_r2r_3d');
      Fftw80PlanGuruReal2Real := BindFunction('fftwl_plan_guru_r2r');
      Fftw80PlanGuru64Real2Real := BindFunction('fftwl_plan_guru64_r2r');
      Fftw80ExecuteReal2Real := BindFunction('fftwl_execute_r2r');

      Fftw80DestroyPlan := BindFunction('fftwl_destroy_plan');
      Fftw80ForgetWisdom := BindFunction('fftwl_forget_wisdom');
      Fftw80Cleanup := BindFunction('fftwl_cleanup');
      Fftw80SetTimelimit := BindFunction('fftwl_set_timelimit');
      Fftw80PlanWithNThreads := BindFunction('fftwl_plan_with_nthreads');
      Fftw80InitThreads := BindFunction('fftwl_init_threads');
      Fftw80CleanupThreads := BindFunction('fftwl_cleanup_threads');

      Fftw80ExportWisdomToFilename := BindFunction('fftwl_export_wisdom_to_filename');
      Fftw80ExportWisdomToFile := BindFunction('fftwl_export_wisdom_to_file');
      Fftw80ExportWisdomToString := BindFunction('fftwl_export_wisdom_to_string');
      Fftw80ExportWisdom := BindFunction('fftwl_export_wisdom');

      Fftw80ImportSystemWisdom := BindFunction('fftwl_import_system_wisdom');
      Fftw80ImportWisdomFromFilename := BindFunction('fftwl_import_wisdom_from_filename');
      Fftw80ImportWisdomFromFile := BindFunction('fftwl_import_wisdom_from_file');
      Fftw80ImportWisdomFromString := BindFunction('fftwl_import_wisdom_from_string');
      Fftw80ImportWisdom := BindFunction('fftwl_import_wisdom');

      Fftw80FPrintPlan := BindFunction('fftwl_fprint_plan');
      Fftw80PrintPlan := BindFunction('fftwl_print_plan');
      Fftw80SPrintPlan := BindFunction('fftwl_sprint_plan');

      Fftw80Malloc := BindFunction('fftwl_malloc');
      Fftw80AllocReal := BindFunction('fftwl_alloc_real');
      Fftw80AllocComplex := BindFunction('fftwl_alloc_complex');
      Fftw80Free := BindFunction('fftwl_free');

      Fftw80Flops := BindFunction('fftwl_flops');
      Fftw80EstimateCost := BindFunction('fftwl_estimate_cost');
      Fftw80Cost := BindFunction('fftwl_cost');
      Fftw80AlignmentOf := BindFunction('fftwl_alignment_of');
    except
      FreeLibrary(LibFftwHandle);
      LibFftwHandle := 0;
    end;
end;

procedure FinalizeLibrary;
begin
  if LibFftwHandle <> 0 then
    FreeLibrary(LibFftwHandle);
end;

initialization
  InitializeLibrary;

finalization
  FinalizeLibrary;
{$ENDIF}

end.
