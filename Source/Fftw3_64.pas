unit Fftw3_64;

{$I Fftw3.inc}

interface

uses
  SysUtils,
  Fftw3_Common;

const
  CLibFftw64 = 'libfftw3-3.dll';

type
  TFftw64Complex = packed record
    case Boolean of
      False: (Value: array [0..1] of Double);
      True: (Re: Double; Im: Double);
  end;
  PFftw64Complex = ^TFftw64Complex;

  TFftw64Plan = type Pointer;

{$IFDEF DynLink}
  TFftw64Execute = procedure (const Plan: TFftw64Plan); cdecl;
  TFftw64PlanDft = function (Rank: Integer; const N: PInteger; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDft1D = function (N: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDft2D = function (N0, N1: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDft3D = function (N0, N1, N2: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanManyDft = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruSplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64Dft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64SplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64ExecuteDft = procedure (const Plan: TFftw64Plan; &In, &Out: PFftw64Complex); cdecl;
  TFftw64ExecuteSplitDft = procedure (const Plan: TFftw64Plan; Ri, Ii, Ro, Io: PDouble); cdecl;

  TFftw64PlanManyDftReal2Complex = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PDouble; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex = function (Rank: Integer; const N: PInteger; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex1D = function (N: Integer; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex2D = function (N0, N1: Integer; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex3D = function (N0, N1, N2: Integer; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanManyDftComplex2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PDouble; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real = function (Rank: Integer; const N: PInteger; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real1D = function (N: Integer; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real2D = function (N0, N1: Integer; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real3D = function (N0, N1, N2: Integer; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanGuruDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruSplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruSplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanGuru64DftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64DftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64SplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64SplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64ExecuteDftReal2Complex = procedure (const Plan: TFftw64Plan; &In: PDouble; &Out: PFftw64Complex); cdecl;
  TFftw64ExecuteDftComplex2Real = procedure (const Plan: TFftw64Plan; &In: PFftw64Complex; &Out: PDouble); cdecl;
  TFftw64ExecuteSplitDftReal2Complex = procedure (const Plan: TFftw64Plan; &In, Ro, Io: PDouble); cdecl;
  TFftw64ExecuteSplitDftComplex2Real = procedure (const Plan: TFftw64Plan; Ri, Ii, &Out: PDouble); cdecl;

  TFftw64PlanManyReal2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PDouble; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PDouble; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real = function (Rank: Integer; const N: PInteger; &In, &Out: PDouble; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real1D = function (N: Integer; &In, &Out: PDouble; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real2D = function (N0, N1: Integer; &In, &Out: PDouble; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real3D = function (N0, N1, N2: Integer; &In, &Out: PDouble; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruReal2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PDouble; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64Real2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PDouble; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64ExecuteReal2Real = procedure (const Plan: TFftw64Plan; &In, &Out: PDouble); cdecl;

  TFftw64DestroyPlan = procedure (Plan: TFftw64Plan); cdecl;
  TFftw64ForgetWisdom = procedure; cdecl;
  TFftw64Cleanup = procedure; cdecl;
  TFftw64SetTimelimit = procedure (TimeLimit: Double); cdecl;
  TFftw64PlanWithNthreads = procedure (ThreadCount: Integer); cdecl;
  TFftw64InitThreads = function : Integer; cdecl;
  TFftw64CleanupThreads = procedure; cdecl;

  TFftw64ExportWisdomToFilename = function (const FileName: PAnsiChar): Integer; cdecl;
  TFftw64ExportWisdomToFile = procedure (var OutputFile: file); cdecl;
  TFftw64ExportWisdomToString = function : PAnsiChar; cdecl;
  TFftw64ExportWisdom = procedure (WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl;

  TFftw64ImportSystemWisdom = function : Integer; cdecl;
  TFftw64ImportWisdomFromFilename = function (const FileName: PAnsiChar): Integer; cdecl;
  TFftw64ImportWisdomFromFile = function (var InputFile: file): Integer; cdecl;
  TFftw64ImportWisdomFromString = function (const InputString: PAnsiChar): Integer; cdecl;
  TFftw64ImportWisdom = function (ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl;

  TFftw64FPrintPlan = procedure (const Plan: TFftw64Plan; var OutputFile: file); cdecl;
  TFftw64PrintPlan = procedure (const Plan: TFftw64Plan); cdecl;
  TFftw64SPrintPlan = function (const Plan: TFftw64Plan): PAnsiChar; cdecl;

  TFftw64Malloc = function (N: NativeUInt): Pointer; cdecl;
  TFftw64AllocReal = function (N: NativeUInt): PDouble; cdecl;
  TFftw64AllocComplex = function (N: NativeUInt): PFftw64Complex; cdecl;
  TFftw64Free = procedure (Ptr: Pointer); cdecl;

  TFftw64Flops = procedure (const Plan: TFftw64Plan; Add, Mul, FMAs: PDouble); cdecl;
  TFftw64EstimateCost = function (const Plan: TFftw64Plan): Double; cdecl;
  TFftw64Cost = function (const Plan: TFftw64Plan): Double; cdecl;
  TFftw64AlignmentOf = function (Ptr: PDouble): Integer; cdecl;

var
  Fftw64Execute: TFftw64Execute;
  Fftw64PlanDft: TFftw64PlanDft;
  Fftw64PlanDft1d: TFftw64PlanDft1D;
  Fftw64PlanDft2d: TFftw64PlanDft2D;
  Fftw64PlanDft3d: TFftw64PlanDft3D;

  Fftw64PlanManyDft: TFftw64PlanManyDft;
  Fftw64PlanGuruDft: TFftw64PlanGuruDft;
  Fftw64PlanGuruSplitDft: TFftw64PlanGuruSplitDft;
  Fftw64PlanGuru64Dft: TFftw64PlanGuru64Dft;
  Fftw64PlanGuru64SplitDft: TFftw64PlanGuru64SplitDft;
  Fftw64ExecuteDft: TFftw64ExecuteDft;
  Fftw64ExecuteSplitDft: TFftw64ExecuteSplitDft;

  Fftw64PlanManyDftReal2Complex: TFftw64PlanManyDftReal2Complex;
  Fftw64PlanDftReal2Complex: TFftw64PlanDftReal2Complex;
  Fftw64PlanDftReal2Complex1D: TFftw64PlanDftReal2Complex1D;
  Fftw64PlanDftReal2Complex2D: TFftw64PlanDftReal2Complex2D;
  Fftw64PlanDftReal2Complex3D: TFftw64PlanDftReal2Complex3D;

  Fftw64PlanManyDftComplex2Real: TFftw64PlanManyDftComplex2Real;
  Fftw64PlanDftComplex2Real: TFftw64PlanDftComplex2Real;
  Fftw64PlanDftComplex2Real1D: TFftw64PlanDftComplex2Real1D;
  Fftw64PlanDftComplex2Real2D: TFftw64PlanDftComplex2Real2D;
  Fftw64PlanDftComplex2Real3D: TFftw64PlanDftComplex2Real3D;

  Fftw64PlanGuruDftReal2Complex: TFftw64PlanGuruDftReal2Complex;
  Fftw64PlanGuruDftComplex2Real: TFftw64PlanGuruDftComplex2Real;
  Fftw64PlanGuruSplitDftReal2Complex: TFftw64PlanGuruSplitDftReal2Complex;
  Fftw64PlanGuruSplitDftComplex2Real: TFftw64PlanGuruSplitDftComplex2Real;

  Fftw64PlanGuru64DftReal2Complex: TFftw64PlanGuru64DftReal2Complex;
  Fftw64PlanGuru64DftComplex2Real: TFftw64PlanGuru64DftComplex2Real;
  Fftw64PlanGuru64SplitDftReal2Complex: TFftw64PlanGuru64SplitDftReal2Complex;
  Fftw64PlanGuru64SplitDftComplex2Real: TFftw64PlanGuru64SplitDftComplex2Real;

  Fftw64ExecuteDftReal2Complex: TFftw64ExecuteDftReal2Complex;
  Fftw64ExecuteDftComplex2Real: TFftw64ExecuteDftComplex2Real;
  Fftw64ExecuteSplitDftReal2Complex: TFftw64ExecuteSplitDftReal2Complex;
  Fftw64ExecuteSplitDftComplex2Real: TFftw64ExecuteSplitDftComplex2Real;

  Fftw64PlanManyReal2Real: TFftw64PlanManyReal2Real;
  Fftw64PlanReal2Real: TFftw64PlanReal2Real;
  Fftw64PlanReal2Real1D: TFftw64PlanReal2Real1D;
  Fftw64PlanReal2Real2D: TFftw64PlanReal2Real2D;
  Fftw64PlanReal2Real3D: TFftw64PlanReal2Real3D;
  Fftw64PlanGuruReal2Real: TFftw64PlanGuruReal2Real;
  Fftw64PlanGuru64Real2Real: TFftw64PlanGuru64Real2Real;
  Fftw64ExecuteReal2Real: TFftw64ExecuteReal2Real;

  Fftw64DestroyPlan: TFftw64DestroyPlan;
  Fftw64ForgetWisdom: TFftw64ForgetWisdom;
  Fftw64Cleanup: TFftw64Cleanup;
  Fftw64SetTimelimit: TFftw64SetTimelimit;
  Fftw64PlanWithNthreads: TFftw64PlanWithNthreads;
  Fftw64InitThreads: TFftw64InitThreads;
  Fftw64CleanupThreads: TFftw64CleanupThreads;

  Fftw64ExportWisdomToFilename: TFftw64ExportWisdomToFilename;
  Fftw64ExportWisdomToFile: TFftw64ExportWisdomToFile;
  Fftw64ExportWisdomToString: TFftw64ExportWisdomToString;
  Fftw64ExportWisdom: TFftw64ExportWisdom;

  Fftw64ImportSystemWisdom: TFftw64ImportSystemWisdom;
  Fftw64ImportWisdomFromFilename: TFftw64ImportWisdomFromFilename;
  Fftw64ImportWisdomFromFile: TFftw64ImportWisdomFromFile;
  Fftw64ImportWisdomFromString: TFftw64ImportWisdomFromString;
  Fftw64ImportWisdom: TFftw64ImportWisdom;

  Fftw64FPrintPlan: TFftw64FprintPlan;
  Fftw64PrintPlan: TFftw64PrintPlan;
  Fftw64SPrintPlan: TFftw64SPrintPlan;

  Fftw64Malloc: TFftw64Malloc;
  Fftw64AllocReal: TFftw64AllocReal;
  Fftw64AllocComplex: TFftw64AllocComplex;
  Fftw64Free: TFftw64Free;

  Fftw64Flops: TFftw64Flops;
  Fftw64EstimateCost: TFftw64EstimateCost;
  Fftw64Cost: TFftw64Cost;
  Fftw64AlignmentOf: TFftw64AlignmentOf;

{$ELSE}
  procedure Fftw64Execute(const Plan: TFftw64Plan); cdecl; external CLibFftw64 name 'fftw_execute';
  function Fftw64PlanDft(Rank: Integer; const N: PInteger; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft';
  function Fftw64PlanDft1D(N: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_1d';
  function Fftw64PlanDft2D(N0, N1: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_2d';
  function Fftw64PlanDft3D(N0, N1, N2: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_3d';

  function Fftw64PlanManyDft(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_dft';
  function Fftw64PlanGuruDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_dft';
  function Fftw64PlanGuruSplitDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_split_dft';
  function Fftw64PlanGuru64Dft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_dft';
  function Fftw64PlanGuru64SplitDft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_split_dft';
  procedure Fftw64ExecuteDft(const Plan: TFftw64Plan; &In: PFftw64Complex; &Out: PFftw64Complex); cdecl; external CLibFftw64 name 'fftw_Execute_dft';
  procedure Fftw64ExecuteSplitDft(const Plan: TFftw64Plan; Ri, Ii, Ro, Io: PDouble); cdecl; external CLibFftw64 name 'fftw_execute_split_dft';

  function Fftw64PlanManyDftReal2Complex(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PDouble; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_dft_r2c';
  function Fftw64PlanDftReal2Complex(Rank: Integer; const N: PInteger; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c';
  function Fftw64PlanDftReal2Complex1D(N: Integer; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c_1d';
  function Fftw64PlanDftReal2Complex2D(N0, N1: Integer; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c_2d';
  function Fftw64PlanDftReal2Complex3D(N0, N1, N2: Integer; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c_3d';

  function Fftw64PlanManyDftComplex2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PDouble; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_dft_c2r';
  function Fftw64PlanDftComplex2Real(Rank: Integer; const N: PInteger; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r';
  function Fftw64PlanDftComplex2Real1D(N: Integer; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r_1d';
  function Fftw64PlanDftComplex2Real2D(N0, N1: Integer; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r_2d';
  function Fftw64PlanDftComplex2Real3D(N0, N1, N2: Integer; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r_3d';

  function Fftw64PlanGuruDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_dft_r2c';
  function Fftw64PlanGuruDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_dft_c2r';
  function Fftw64PlanGuruSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_split_dft_r2c(';
  function Fftw64PlanGuruSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_split_dft_c2r(';

  function Fftw64PlanGuru64DftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PDouble; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_dft_r2c';
  function Fftw64PlanGuru64DftC2r(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Complex; &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_dft_c2r';
  function Fftw64PlanGuru64SplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_split_dft_r2c(';
  function Fftw64PlanGuru64SplitDftComple2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PDouble; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_split_dft_c2r(';

  procedure Fftw64ExecuteDftReal2Complex(const Plan: TFftw64Plan; &In: PDouble; &Out: PFftw64Complex); cdecl; external CLibFftw64 name 'fftw_execute_dft_r2c';
  procedure Fftw64ExecuteDftComple2Real(const Plan: TFftw64Plan; &In: PFftw64Complex; &Out: PDouble); cdecl; external CLibFftw64 name 'fftw_execute_dft_c2r';
  procedure Fftw64ExecuteSplitDftReal2Complex(const Plan: TFftw64Plan; &In, Ro, Io: PDouble); cdecl; external CLibFftw64 name 'fftw_execute_split_dft_r2c';
  procedure Fftw64ExecuteSplitDftComple2Real(const Plan: TFftw64Plan; Ri, Ii, &Out: PDouble); cdecl; external CLibFftw64 name 'fftw_execute_split_dft_c2r';

  function Fftw64PlanManyReal2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PDouble; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PDouble; const onembed: PInteger; OutputStride, OutputDist: Integer; const kind_: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_r2r';
  function Fftw64PlanReal2Real(Rank: Integer; const N: PInteger; &In, &Out: PDouble; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r';
  function Fftw64PlanReal2Real1D(N: Integer; &In, &Out: PDouble; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r_1d';
  function Fftw64PlanReal2Real2D(N0, N1: Integer; &In, &Out: PDouble; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r_2d';
  function Fftw64PlanReal2Real3D(N0, N1, N2: Integer; &In, &Out: PDouble; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r_3d';
  function Fftw64PlanGuruReal2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PDouble; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_r2r';
  function Fftw64PlanGuru64Real2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PDouble; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_r2r';
  procedure Fftw64ExecuteReal2Real(const Plan: TFftw64Plan; &In, &Out: PDouble); cdecl; external CLibFftw64 name 'fftw_execute_r2r';

  procedure Fftw64DestroyPlan(Plan: TFftw64Plan); cdecl; external CLibFftw64 name 'fftw_destroy_plan';
  procedure Fftw64ForgetWisdom; cdecl; external CLibFftw64 name 'fftw_forget_wisdom;';
  procedure Fftw64Cleanup; cdecl; external CLibFftw64 name 'fftw_cleanup;';
  procedure Fftw64SetTimelimit(TimeLimit: Double); cdecl; external CLibFftw64 name 'fftw_set_timelimit';
  procedure Fftw64PlanWithNthreads(ThreadCount: Integer); cdecl; external CLibFftw64 name 'fftw_plan_with_nthreads';
  function Fftw64InitThreads: Integer; cdecl; external CLibFftw64 name 'fftw_init_threads:';
  procedure Fftw64CleanupThreads; cdecl; external CLibFftw64 name 'fftw_cleanup_threads;';

  function Fftw64ExportWisdomToFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw64 name 'fftw_export_wisdom_to_filename';
  procedure Fftw64ExportWisdomToFile(var OutputFile: file); cdecl; external CLibFftw64 name 'fftw_export_wisdom_to_file';
  function Fftw64ExportWisdomToString: PAnsiChar; cdecl; external CLibFftw64 name 'fftw_export_wisdom_to_string:';
  procedure Fftw64ExportWisdom(WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl; external CLibFftw64 name 'fftw_export_wisdom';

  function Fftw64ImportSystemWisdom: Integer; cdecl; external CLibFftw64 name 'fftw_import_system_wisdom:';
  function Fftw64ImportWisdomFromFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom_from_filename';
  function Fftw64ImportWisdomFromFile(var InputFile: file): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom_from_file';
  function Fftw64ImportWisdomFromString(const InputString: PAnsiChar): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom_from_string';
  function Fftw64ImportWisdom(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom';

  procedure Fftw64FPrintPlan(const Plan: TFftw64Plan; var OutputFile: file); cdecl; external CLibFftw64 name 'fftw_fprint_plan';
  procedure Fftw64PrintPlan(const Plan: TFftw64Plan); cdecl; external CLibFftw64 name 'fftw_print_plan';
  function Fftw64SPrintPlan(const Plan: TFftw64Plan): PAnsiChar; cdecl; external CLibFftw64 name 'fftw_sprint_plan';

  function Fftw64Malloc(N: NativeUInt): Pointer; cdecl; external CLibFftw64 name 'fftw_malloc';
  function Fftw64AllocReal(N: NativeUInt): PDouble; cdecl; external CLibFftw64 name 'fftw_alloc_real';
  function Fftw64AllocComplex(N: NativeUInt): PFftw64Complex; cdecl; external CLibFftw64 name 'fftw_alloc_complex';
  procedure Fftw64Free(Ptr: Pointer); cdecl; external CLibFftw64 name 'fftw_free';

  procedure Fftw64Flops(const Plan: TFftw64Plan; Add, Mul, FMAs: PDouble); cdecl; external CLibFftw64 name 'fftw_flops';
  function Fftw64EstimateCost(const Plan: TFftw64Plan): Double; cdecl; external CLibFftw64 name 'fftw_estimate_cost';
  function Fftw64Cost(const Plan: TFftw64Plan): Double; cdecl; external CLibFftw64 name 'fftw_cost';
  function Fftw64AlignmentOf(Ptr: PDouble): Integer; cdecl; external CLibFftw64 name 'fftw_alignment_of';
{$ENDIF}

implementation

{$IFDEF DynLink}
uses
  Windows;
{$ENDIF}


{$IFDEF DynLink}
var
  LibFftw3Handle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};

procedure InitializeLibrary;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(LibFftw3Handle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  if not FileExists(CLibFftw64) then
    raise Exception.CreateFmt('File not found (%s)', [CLibFftw64]);

  LibFftw3Handle := LoadLibrary(CLibFftw64);
  if LibFftw3Handle <> 0 then
    try
      Fftw64Execute := BindFunction('fftw_execute');
      Fftw64PlanDft := BindFunction('fftw_plan_dft');
      Fftw64PlanDft1D := BindFunction('fftw_plan_dft_1d');
      Fftw64PlanDft2D := BindFunction('fftw_plan_dft_2d');
      Fftw64PlanDft3D := BindFunction('fftw_plan_dft_3d');

      Fftw64PlanManyDft := BindFunction('fftw_plan_many_dft');
      Fftw64PlanGuruDft := BindFunction('fftw_plan_guru_dft');
      Fftw64PlanGuruSplitDft := BindFunction('fftw_plan_guru_split_dft');
      Fftw64PlanGuru64Dft := BindFunction('fftw_plan_guru64_dft');
      Fftw64PlanGuru64SplitDft := BindFunction('fftw_plan_guru64_split_dft');
      Fftw64ExecuteDft := BindFunction('fftw_execute_dft');
      Fftw64ExecuteSplitDft := BindFunction('fftw_execute_split_dft');

      Fftw64PlanManyDftReal2Complex := BindFunction('fftw_plan_many_dft_r2c');
      Fftw64PlanDftReal2Complex := BindFunction('fftw_plan_dft_r2c');
      Fftw64PlanDftReal2Complex1D := BindFunction('fftw_plan_dft_r2c_1d');
      Fftw64PlanDftReal2Complex2D := BindFunction('fftw_plan_dft_r2c_2d');
      Fftw64PlanDftReal2Complex3D := BindFunction('fftw_plan_dft_r2c_3d');

      Fftw64PlanManyDftComplex2Real := BindFunction('fftw_plan_many_dft_c2r');
      Fftw64PlanDftComplex2Real := BindFunction('fftw_plan_dft_c2r');
      Fftw64PlanDftComplex2Real1D := BindFunction('fftw_plan_dft_c2r_1d');
      Fftw64PlanDftComplex2Real2D := BindFunction('fftw_plan_dft_c2r_2d');
      Fftw64PlanDftComplex2Real3D := BindFunction('fftw_plan_dft_c2r_3d');

      Fftw64PlanGuruDftReal2Complex := BindFunction('fftw_plan_guru_dft_r2c');
      Fftw64PlanGuruDftComplex2Real := BindFunction('fftw_plan_guru_dft_c2r');
      Fftw64PlanGuruSplitDftReal2Complex := BindFunction('fftw_plan_guru_split_dft_r2c');
      Fftw64PlanGuruSplitDftComplex2Real := BindFunction('fftw_plan_guru_split_dft_c2r');

      Fftw64PlanGuru64DftReal2Complex := BindFunction('fftw_plan_guru64_dft_r2c');
      Fftw64PlanGuru64DftComplex2Real := BindFunction('fftw_plan_guru64_dft_c2r');
      Fftw64PlanGuru64SplitDftReal2Complex := BindFunction('fftw_plan_guru64_split_dft_r2c');
      Fftw64PlanGuru64SplitDftComplex2Real := BindFunction('fftw_plan_guru64_split_dft_c2r');

      Fftw64ExecuteDftReal2Complex := BindFunction('fftw_execute_dft_r2c');
      Fftw64ExecuteDftComplex2Real := BindFunction('fftw_execute_dft_c2r');
      Fftw64ExecuteSplitDftReal2Complex := BindFunction('fftw_execute_split_dft_r2c');
      Fftw64ExecuteSplitDftComplex2Real := BindFunction('fftw_execute_split_dft_c2r');

      Fftw64PlanManyReal2Real := BindFunction('fftw_plan_many_r2r');
      Fftw64PlanReal2Real := BindFunction('fftw_plan_r2r');
      Fftw64PlanReal2Real1D := BindFunction('fftw_plan_r2r_1d');
      Fftw64PlanReal2Real2D := BindFunction('fftw_plan_r2r_2d');
      Fftw64PlanReal2Real3D := BindFunction('fftw_plan_r2r_3d');
      Fftw64PlanGuruReal2Real := BindFunction('fftw_plan_guru_r2r');
      Fftw64PlanGuru64Real2Real := BindFunction('fftw_plan_guru64_r2r');
      Fftw64ExecuteReal2Real := BindFunction('fftw_execute_r2r');

      Fftw64DestroyPlan := BindFunction('fftw_destroy_plan');
      Fftw64ForgetWisdom := BindFunction('fftw_forget_wisdom');
      Fftw64Cleanup := BindFunction('fftw_cleanup');
      Fftw64SetTimelimit := BindFunction('fftw_set_timelimit');
      Fftw64PlanWithNthreads := BindFunction('fftw_plan_with_nthreads');
      Fftw64InitThreads := BindFunction('fftw_init_threads');
      Fftw64CleanupThreads := BindFunction('fftw_cleanup_threads');

      Fftw64ExportWisdomToFilename := BindFunction('fftw_export_wisdom_to_filename');
      Fftw64ExportWisdomToFile := BindFunction('fftw_export_wisdom_to_file');
      Fftw64ExportWisdomToString := BindFunction('fftw_export_wisdom_to_string');
      Fftw64ExportWisdom := BindFunction('fftw_export_wisdom');

      Fftw64ImportSystemWisdom := BindFunction('fftw_import_system_wisdom');
      Fftw64ImportWisdomFromFilename := BindFunction('fftw_import_wisdom_from_filename');
      Fftw64ImportWisdomFromFile := BindFunction('fftw_import_wisdom_from_file');
      Fftw64ImportWisdomFromString := BindFunction('fftw_import_wisdom_from_string');
      Fftw64ImportWisdom := BindFunction('fftw_import_wisdom');

      Fftw64FPrintPlan := BindFunction('fftw_fprint_plan');
      Fftw64PrintPlan := BindFunction('fftw_print_plan');
      Fftw64SPrintPlan := BindFunction('fftw_sprint_plan');

      Fftw64Malloc := BindFunction('fftw_malloc');
      Fftw64AllocReal := BindFunction('fftw_alloc_real');
      Fftw64AllocComplex := BindFunction('fftw_alloc_complex');
      Fftw64Free := BindFunction('fftw_free');

      Fftw64Flops := BindFunction('fftw_flops');
      Fftw64EstimateCost := BindFunction('fftw_estimate_cost');
      Fftw64Cost := BindFunction('fftw_cost');
      Fftw64AlignmentOf := BindFunction('fftw_alignment_of');
    except
      FreeLibrary(LibFftw3Handle);
      LibFftw3Handle := 0;
    end;
end;

procedure FinalizeLibrary;
begin
  if LibFftw3Handle <> 0 then
    FreeLibrary(LibFftw3Handle);
end;

initialization
  InitializeLibrary;

finalization
  FinalizeLibrary;
{$ENDIF}

end.
