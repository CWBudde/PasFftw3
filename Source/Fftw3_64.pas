unit Fftw3_64;

{$I Fftw3.inc}

interface

uses
  SysUtils,
  Fftw3_Common;

const
  CLibFftw64 = 'libfftw3-3.dll';

type
  PFftw64Real = ^Double;
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
  TFftw64PlanGuruSplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64Dft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64SplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64ExecuteDft = procedure (const Plan: TFftw64Plan; &In, &Out: PFftw64Complex); cdecl;
  TFftw64ExecuteSplitDft = procedure (const Plan: TFftw64Plan; Ri, Ii, Ro, Io: PFftw64Real); cdecl;

  TFftw64PlanManyDftReal2Complex = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex = function (Rank: Integer; const N: PInteger; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex1D = function (N: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex2D = function (N0, N1: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftReal2Complex3D = function (N0, N1, N2: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanManyDftComplex2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real = function (Rank: Integer; const N: PInteger; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real1D = function (N: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real2D = function (N0, N1: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanDftComplex2Real3D = function (N0, N1, N2: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanGuruDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruSplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruSplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64PlanGuru64DftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64DftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64SplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64SplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl;

  TFftw64ExecuteDftReal2Complex = procedure (const Plan: TFftw64Plan; &In: PFftw64Real; &Out: PFftw64Complex); cdecl;
  TFftw64ExecuteDftComplex2Real = procedure (const Plan: TFftw64Plan; &In: PFftw64Complex; &Out: PFftw64Real); cdecl;
  TFftw64ExecuteSplitDftReal2Complex = procedure (const Plan: TFftw64Plan; &In, Ro, Io: PFftw64Real); cdecl;
  TFftw64ExecuteSplitDftComplex2Real = procedure (const Plan: TFftw64Plan; Ri, Ii, &Out: PFftw64Real); cdecl;

  TFftw64PlanManyReal2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real = function (Rank: Integer; const N: PInteger; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real1D = function (N: Integer; &In, &Out: PFftw64Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real2D = function (N0, N1: Integer; &In, &Out: PFftw64Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanReal2Real3D = function (N0, N1, N2: Integer; &In, &Out: PFftw64Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuruReal2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64PlanGuru64Real2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl;
  TFftw64ExecuteReal2Real = procedure (const Plan: TFftw64Plan; &In, &Out: PFftw64Real); cdecl;

  TFftw64DestroyPlan = procedure (Plan: TFftw64Plan); cdecl;
  TFftw64ForgetWisdom = procedure; cdecl;
  TFftw64Cleanup = procedure; cdecl;
  TFftw64SetTimelimit = procedure (TimeLimit: Double); cdecl;
  TFftw64PlanWithNthreads = procedure (ThreadCount: Integer); cdecl;
  TFftw64InitThreads = function : Integer; cdecl;
  TFftw64CleanupThreads = procedure; cdecl;

  TFftw64ExportWisdomToFilename = function (const FileName: PAnsiChar): Boolean; cdecl;
  TFftw64ExportWisdomToFile = procedure (var OutputFile: file); cdecl;
  TFftw64ExportWisdomToString = function : PAnsiChar; cdecl;
  TFftw64ExportWisdom = procedure (WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl;

  TFftw64ImportSystemWisdom = function : Integer; cdecl;
  TFftw64ImportWisdomFromFilename = function (const FileName: PAnsiChar): Boolean; cdecl;
  TFftw64ImportWisdomFromFile = function (var InputFile: file): Boolean; cdecl;
  TFftw64ImportWisdomFromString = function (const InputString: PAnsiChar): Boolean; cdecl;
  TFftw64ImportWisdom = function (ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl;

  TFftw64FPrintPlan = procedure (const Plan: TFftw64Plan; var OutputFile: file); cdecl;
  TFftw64PrintPlan = procedure (const Plan: TFftw64Plan); cdecl;
  TFftw64SPrintPlan = function (const Plan: TFftw64Plan): PAnsiChar; cdecl;

  TFftw64Malloc = function (N: NativeUInt): Pointer; cdecl;
  TFftw64AllocReal = function (N: NativeUInt): PFftw64Real; cdecl;
  TFftw64AllocComplex = function (N: NativeUInt): PFftw64Complex; cdecl;
  TFftw64Free = procedure (Ptr: Pointer); cdecl;

  TFftw64Flops = procedure (const Plan: TFftw64Plan; out Add, Mul, FMAs: Double); cdecl;
  TFftw64EstimateCost = function (const Plan: TFftw64Plan): Double; cdecl;
  TFftw64Cost = function (const Plan: TFftw64Plan): Double; cdecl;
  TFftw64AlignmentOf = function (Ptr: PFftw64Real): Integer; cdecl;

var
  Fftw64Version: AnsiString;
  Fftw64CC: AnsiString;
  Fftw64CodeletOptim: AnsiString;

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
  function Fftw64PlanGuruSplitDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_split_dft';
  function Fftw64PlanGuru64Dft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_dft';
  function Fftw64PlanGuru64SplitDft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_split_dft';
  procedure Fftw64ExecuteDft(const Plan: TFftw64Plan; &In: PFftw64Complex; &Out: PFftw64Complex); cdecl; external CLibFftw64 name 'fftw_Execute_dft';
  procedure Fftw64ExecuteSplitDft(const Plan: TFftw64Plan; Ri, Ii, Ro, Io: PFftw64Real); cdecl; external CLibFftw64 name 'fftw_execute_split_dft';

  function Fftw64PlanManyDftReal2Complex(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_dft_r2c';
  function Fftw64PlanDftReal2Complex(Rank: Integer; const N: PInteger; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c';
  function Fftw64PlanDftReal2Complex1D(N: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c_1d';
  function Fftw64PlanDftReal2Complex2D(N0, N1: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c_2d';
  function Fftw64PlanDftReal2Complex3D(N0, N1, N2: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_r2c_3d';

  function Fftw64PlanManyDftComplex2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_dft_c2r';
  function Fftw64PlanDftComplex2Real(Rank: Integer; const N: PInteger; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r';
  function Fftw64PlanDftComplex2Real1D(N: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r_1d';
  function Fftw64PlanDftComplex2Real2D(N0, N1: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r_2d';
  function Fftw64PlanDftComplex2Real3D(N0, N1, N2: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_dft_c2r_3d';

  function Fftw64PlanGuruDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_dft_r2c';
  function Fftw64PlanGuruDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_dft_c2r';
  function Fftw64PlanGuruSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_split_dft_r2c';
  function Fftw64PlanGuruSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_split_dft_c2r';

  function Fftw64PlanGuru64DftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_dft_r2c';
  function Fftw64PlanGuru64DftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_dft_c2r';
  function Fftw64PlanGuru64SplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_split_dft_r2c';
  function Fftw64PlanGuru64SplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw64Real; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_split_dft_c2r';

  procedure Fftw64ExecuteDftReal2Complex(const Plan: TFftw64Plan; &In: PFftw64Real; &Out: PFftw64Complex); cdecl; external CLibFftw64 name 'fftw_execute_dft_r2c';
  procedure Fftw64ExecuteDftComplex2Real(const Plan: TFftw64Plan; &In: PFftw64Complex; &Out: PFftw64Real); cdecl; external CLibFftw64 name 'fftw_execute_dft_c2r';
  procedure Fftw64ExecuteSplitDftReal2Complex(const Plan: TFftw64Plan; &In, Ro, Io: PFftw64Real); cdecl; external CLibFftw64 name 'fftw_execute_split_dft_r2c';
  procedure Fftw64ExecuteSplitDftComplex2Real(const Plan: TFftw64Plan; Ri, Ii, &Out: PFftw64Real); cdecl; external CLibFftw64 name 'fftw_execute_split_dft_c2r';

  function Fftw64PlanManyReal2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const kind_: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_many_r2r';
  function Fftw64PlanReal2Real(Rank: Integer; const N: PInteger; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r';
  function Fftw64PlanReal2Real1D(N: Integer; &In, &Out: PFftw64Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r_1d';
  function Fftw64PlanReal2Real2D(N0, N1: Integer; &In, &Out: PFftw64Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r_2d';
  function Fftw64PlanReal2Real3D(N0, N1, N2: Integer; &In, &Out: PFftw64Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_r2r_3d';
  function Fftw64PlanGuruReal2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru_r2r';
  function Fftw64PlanGuru64Real2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw64Plan; cdecl; external CLibFftw64 name 'fftw_plan_guru64_r2r';
  procedure Fftw64ExecuteReal2Real(const Plan: TFftw64Plan; &In, &Out: PFftw64Real); cdecl; external CLibFftw64 name 'fftw_execute_r2r';

  procedure Fftw64DestroyPlan(Plan: TFftw64Plan); cdecl; external CLibFftw64 name 'fftw_destroy_plan';
  procedure Fftw64ForgetWisdom; cdecl; external CLibFftw64 name 'fftw_forget_wisdom';
  procedure Fftw64Cleanup; cdecl; external CLibFftw64 name 'fftw_cleanup';
  procedure Fftw64SetTimelimit(TimeLimit: Double); cdecl; external CLibFftw64 name 'fftw_set_timelimit';
  procedure Fftw64PlanWithNthreads(ThreadCount: Integer); cdecl; external CLibFftw64 name 'fftw_plan_with_nthreads';
  function Fftw64InitThreads: Integer; cdecl; external CLibFftw64 name 'fftw_init_threads';
  procedure Fftw64CleanupThreads; cdecl; external CLibFftw64 name 'fftw_cleanup_threads';

  function Fftw64ExportWisdomToFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw64 name 'fftw_export_wisdom_to_filename';
  procedure Fftw64ExportWisdomToFile(var OutputFile: file); cdecl; external CLibFftw64 name 'fftw_export_wisdom_to_file';
  function Fftw64ExportWisdomToString: PAnsiChar; cdecl; external CLibFftw64 name 'fftw_export_wisdom_to_string';
  procedure Fftw64ExportWisdom(WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl; external CLibFftw64 name 'fftw_export_wisdom';

  function Fftw64ImportSystemWisdom: Integer; cdecl; external CLibFftw64 name 'fftw_import_system_wisdom';
  function Fftw64ImportWisdomFromFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom_from_filename';
  function Fftw64ImportWisdomFromFile(var InputFile: file): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom_from_file';
  function Fftw64ImportWisdomFromString(const InputString: PAnsiChar): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom_from_string';
  function Fftw64ImportWisdom(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl; external CLibFftw64 name 'fftw_import_wisdom';

  procedure Fftw64FPrintPlan(const Plan: TFftw64Plan; var OutputFile: file); cdecl; external CLibFftw64 name 'fftw_fprint_plan';
  procedure Fftw64PrintPlan(const Plan: TFftw64Plan); cdecl; external CLibFftw64 name 'fftw_print_plan';
  function Fftw64SPrintPlan(const Plan: TFftw64Plan): PAnsiChar; cdecl; external CLibFftw64 name 'fftw_sprint_plan';

  function Fftw64Malloc(N: NativeUInt): Pointer; cdecl; external CLibFftw64 name 'fftw_malloc';
  function Fftw64AllocReal(N: NativeUInt): PFftw64Real; cdecl; external CLibFftw64 name 'fftw_alloc_real';
  function Fftw64AllocComplex(N: NativeUInt): PFftw64Complex; cdecl; external CLibFftw64 name 'fftw_alloc_complex';
  procedure Fftw64Free(Ptr: Pointer); cdecl; external CLibFftw64 name 'fftw_free';

  procedure Fftw64Flops(const Plan: TFftw64Plan; out Add, Mul, FMAs: Double); cdecl; external CLibFftw64 name 'fftw_flops';
  function Fftw64EstimateCost(const Plan: TFftw64Plan): Double; cdecl; external CLibFftw64 name 'fftw_estimate_cost';
  function Fftw64Cost(const Plan: TFftw64Plan): Double; cdecl; external CLibFftw64 name 'fftw_cost';
  function Fftw64AlignmentOf(Ptr: PFftw64Real): Integer; cdecl; external CLibFftw64 name 'fftw_alignment_of';
{$ENDIF}

type
  TCustomFftw64 = class
  private
    FPlan: TFftw64Plan;
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

  TFftw64Dft = class(TCustomFftw64)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags);

    procedure Execute(&In, &Out: PFftw64Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw64Real); overload;
  end;

  TFftw64DftReal2Complex = class(TCustomFftw64)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In: PFftw64Real; &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags);

    procedure Execute(&In: PFftw64Real; &Out: PFftw64Complex); overload;
    procedure Execute(&In, Ro, Io: PFftw64Real); overload;
  end;

  TFftw64DftComplex2Real = class(TCustomFftw64)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags);

    procedure Execute(&In: PFftw64Complex; &Out: PFftw64Real); overload;
    procedure Execute(Ri, Ii, &Out: PFftw64Real); overload;
  end;

  TFftw64Real2Real = class(TCustomFftw64)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In, &Out: PFftw64Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In, &Out: PFftw64Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In, &Out: PFftw64Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);

    procedure Execute(&In, &Out: PFftw64Real); overload;
  end;

  TFftw64Guru = class(TCustomFftw64)
  public
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags); overload;
    constructor CreateSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw64Real; Flags: TFftwFlags); overload;

    procedure Execute(&In, &Out: PFftw64Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw64Real); overload;
  end;

  TFftw64Guru64 = class(TCustomFftw64)
  public
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Real; &Out: PFftw64Complex; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags); overload;
    constructor CreateSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw64Real; Flags: TFftwFlags); overload;

    procedure Execute(&In, &Out: PFftw64Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw64Real); overload;
  end;

  TFftw64Wisdom = class sealed
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

{ TCustomFftw64 }

constructor TCustomFftw64.Create;
begin
  raise Exception.Create('Default constructor not supported!');
end;

destructor TCustomFftw64.Destroy;
begin
  Fftw64DestroyPlan(FPlan);
end;

procedure TCustomFftw64.Execute;
begin
  Fftw64Execute(FPlan);
end;

function TCustomFftw64.GetAsText: string;
begin
  Result := string(Fftw64SPrintPlan(FPlan));
end;

function TCustomFftw64.GetEstimateCost: Double;
begin
  Result := Fftw64EstimateCost(FPlan);
end;

procedure TCustomFftw64.GetFlops(out Add, Mul, FMAs: Double);
begin
  Fftw64Flops(FPlan, Add, Mul, FMAs);
end;

function TCustomFftw64.GetCost: Double;
begin
  Result := Fftw64Cost(FPlan);
end;


{ TFftw64Dft }

constructor TFftw64Dft.Create(Rank: Integer; const N: PInteger; &In,
  &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDft(Rank, N, &In, &Out, Sign, Flags);
end;

constructor TFftw64Dft.Create(N: Integer; &In, &Out: PFftw64Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDft1D(N, &In, &Out, Sign, Flags);
end;

constructor TFftw64Dft.Create(N0, N1: Integer; &In, &Out: PFftw64Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDft2D(N0, N1, &In, &Out, Sign, Flags);
end;

constructor TFftw64Dft.Create(N0, N1, N2: Integer; &In, &Out: PFftw64Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDft3D(N0, N1, N2, &In, &Out, Sign, Flags);
end;

constructor TFftw64Dft.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanManyDft(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Sign, Flags);
end;

procedure TFftw64Dft.Execute(&In, &Out: PFftw64Complex);
begin
  Fftw64ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw64Dft.Execute(Ri, Ii, Ro, Io: PFftw64Real);
begin
  Fftw64ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw64DftReal2Complex }

constructor TFftw64DftReal2Complex.Create(Rank: Integer; const N: PInteger;
  &In: PFftw64Real; &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftReal2Complex(Rank, N, &In, &Out, Flags);
end;

constructor TFftw64DftReal2Complex.Create(N: Integer; &In: PFftw64Real;
  &Out: PFftw64Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftReal2Complex1D(N, &In, &Out, Flags);
end;

constructor TFftw64DftReal2Complex.Create(N0, N1: Integer; &In: PFftw64Real;
  &Out: PFftw64Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftReal2Complex2D(N0, N1, &In, &Out, Flags);
end;

constructor TFftw64DftReal2Complex.Create(N0, N1, N2: Integer; &In: PFftw64Real;
  &Out: PFftw64Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftReal2Complex3D(N0, N1, N2, &In, &Out, Flags);
end;

constructor TFftw64DftReal2Complex.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw64Complex; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanManyDftReal2Complex(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Flags);
end;

procedure TFftw64DftReal2Complex.Execute(&In: PFftw64Real; &Out: PFftw64Complex);
begin
  Fftw64ExecuteDftReal2Complex(FPlan, &In, &Out);
end;

procedure TFftw64DftReal2Complex.Execute(&In, Ro, Io: PFftw64Real);
begin
  Fftw64ExecuteSplitDftReal2Complex(FPlan, &In, Ro, Io);
end;


{ TFftw64DftComplex2Real }

constructor TFftw64DftComplex2Real.Create(Rank: Integer; const N: PInteger;
  &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftComplex2Real(Rank, N, &In, &Out, Flags);
end;

constructor TFftw64DftComplex2Real.Create(N: Integer; &In: PFftw64Complex; &Out: PFftw64Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftComplex2Real1D(N, &In, &Out, Flags);
end;

constructor TFftw64DftComplex2Real.Create(N0, N1: Integer; &In: PFftw64Complex; &Out: PFftw64Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftComplex2Real2D(N0, N1, &In, &Out, Flags);
end;

constructor TFftw64DftComplex2Real.Create(N0, N1, N2: Integer; &In: PFftw64Complex; &Out: PFftw64Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanDftComplex2Real3D(N0, N1, N2, &In, &Out, Flags);
end;

constructor TFftw64DftComplex2Real.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw64Complex; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanManyDftComplex2Real(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Flags);
end;

procedure TFftw64DftComplex2Real.Execute(&In: PFftw64Complex; &Out: PFftw64Real);
begin
  Fftw64ExecuteDftComplex2Real(FPlan, &In, &Out);
end;

procedure TFftw64DftComplex2Real.Execute(Ri, Ii, &Out: PFftw64Real);
begin
  Fftw64ExecuteSplitDftComplex2Real(FPlan, Ri, Ii, &Out);
end;


{ TFftw64Real2Real }

constructor TFftw64Real2Real.Create(Rank: Integer; const N: PInteger;
  &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanReal2Real(Rank, N, &In, &Out, Kind, Flags);
end;

constructor TFftw64Real2Real.Create(N: Integer; &In, &Out: PFftw64Real;
  Kind: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanReal2Real1D(N, &In, &Out, Kind, Flags);
end;

constructor TFftw64Real2Real.Create(N0, N1: Integer; &In, &Out: PFftw64Real;
  Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanReal2Real2D(N0, N1, &In, &Out, Kind0, Kind1, Flags);
end;

constructor TFftw64Real2Real.Create(N0, N1, N2: Integer; &In, &Out: PFftw64Real;
  Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanReal2Real3D(N0, N1, N2, &In, &Out, Kind0, Kind1, Kind2,
    Flags);
end;

constructor TFftw64Real2Real.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw64Real; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw64Real; const onembed: PInteger;
  OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanManyReal2Real(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Kind, Flags);
end;

procedure TFftw64Real2Real.Execute(&In, &Out: PFftw64Real);
begin
  Fftw64ExecuteReal2Real(FPlan, &In, &Out);
end;


{ TFftw64Guru }

constructor TFftw64Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruDft(Rank, Dimensions, HowManyRank, HowManyDimensions,
    &In, &Out, Sign, Flags);
end;

constructor TFftw64Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruSplitDft(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, Ro, Io, Flags);
end;

constructor TFftw64Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw64Real;
  &Out: PFftw64Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw64Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw64Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw64Real;
  const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruReal2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Kind, Flags);
end;

constructor TFftw64Guru.CreateSplitDftReal2Complex(Rank: Integer;
  const Dimensions: PFftwIoDim; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw64Real; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruSplitDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, Ro, Io, Flags);
end;

constructor TFftw64Guru.CreateSplitDftComplex2Real(Rank: Integer;
  const Dimensions: PFftwIoDim; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw64Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuruSplitDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, &Out, Flags);
end;

procedure TFftw64Guru.Execute(&In, &Out: PFftw64Complex);
begin
  Fftw64ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw64Guru.Execute(Ri, Ii, Ro, Io: PFftw64Real);
begin
  Fftw64ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw64Guru64 }

constructor TFftw64Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In, &Out: PFftw64Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64Dft(Rank, Dimensions, HowManyRank, HowManyDimensions,
    &In, &Out, Sign, Flags);
end;

constructor TFftw64Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  Ri, Ii, Ro, Io: PFftw64Real; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64SplitDft(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, Ro, Io, Flags);
end;

constructor TFftw64Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw64Real;
  &Out: PFftw64Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64DftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw64Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In: PFftw64Complex; &Out: PFftw64Real; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64DftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw64Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In, &Out: PFftw64Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64Real2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Kind, Flags);
end;

constructor TFftw64Guru64.CreateSplitDftReal2Complex(Rank: Integer;
  const Dimensions: PFftwIoDim64; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw64Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64SplitDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, Ro, Io, Flags);
end;

constructor TFftw64Guru64.CreateSplitDftComplex2Real(Rank: Integer;
  const Dimensions: PFftwIoDim64; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw64Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw64PlanGuru64SplitDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, &Out, Flags);
end;

procedure TFftw64Guru64.Execute(&In, &Out: PFftw64Complex);
begin
  Fftw64ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw64Guru64.Execute(Ri, Ii, Ro, Io: PFftw64Real);
begin
  Fftw64ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw64Wisdom }

class procedure TFftw64Wisdom.ForgetWisdom;
begin
  Fftw64ForgetWisdom;
end;

class function TFftw64Wisdom.ExportToFilename(const FileName: TFileName): Boolean;
begin
  Result := Fftw64ExportWisdomToFilename(PAnsiChar(AnsiString(FileName)));
end;

class procedure TFftw64Wisdom.ExportToFile(var OutputFile: file);
begin
  Fftw64ExportWisdomToFile(OutputFile);
end;

class function TFftw64Wisdom.ExportToString: AnsiString;
begin
  Result := Fftw64ExportWisdomToString;
end;

class procedure TFftw64Wisdom.&Export(WriteChar: TFftwWriteCharFunc; Data: Pointer);
begin
  Fftw64ExportWisdom(WriteChar, Data);
end;

class function TFftw64Wisdom.ImportSystem: Integer;
begin
  Result := Fftw64ImportSystemWisdom;
end;

class function TFftw64Wisdom.ImportFromFilename(const FileName: TFileName): Boolean;
begin
  Result := Fftw64ImportWisdomFromFilename(PAnsiChar(AnsiString(FileName)));
end;

class function TFftw64Wisdom.ImportFromFile(var InputFile: file): Boolean;
begin
  Result := Fftw64ImportWisdomFromFile(InputFile);
end;

class function TFftw64Wisdom.ImportFromString(const InputString: AnsiString): Boolean;
begin
  Result := Fftw64ImportWisdomFromString(PAnsiChar(AnsiString(InputString)));
end;

class function TFftw64Wisdom.&Import(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer;
begin
  Result := Fftw64ImportWisdom(ReadChar, Data);
end;


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
      Fftw64Version := PAnsiChar(GetProcAddress(LibFftw3Handle, PAnsiChar('fftw_version')));
      Fftw64CC := PAnsiChar(GetProcAddress(LibFftw3Handle, PAnsiChar('fftw_cc')));
      Fftw64CodeletOptim := PAnsiChar(GetProcAddress(LibFftw3Handle, PAnsiChar('fftw_codelet_optim')));

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
