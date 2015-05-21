unit Fftw3_Common;

interface

const
  CFftwNoTimelimit = -1.0;

type
  TReal32 = Single;
  TComplex32 = record
    Re, Im: Single;
  end;

type
  TFftwSign = (
    fsForward = -1,
    fsBackward = +1
  );

  TFftwReal2RealKind = (
    fkReal2HalfComplex = 0,
    fkHalfComplex2Real = 1,
    fkDiscreteHartleyTransform = 2,
    fkRealEvenDFT00 = 3,
    fkRealEvenDFT01 = 4,
    fkRealEvenDFT10 = 5,
    fkRealEvenDFT11 = 6,
    fkRealOddDFT00 = 7,
    fkRealOddDFT01 = 8,
    fkRealOddDFT10 = 9,
    fkRealOddDFT11 = 10
  );
  PFftwReal2RealKind = ^TFftwReal2RealKind;

  TFftwIoDim = record
    DimensionSize: Integer;      // dimension size
    InputStride: Integer;        // input stride
    OutputStride: Integer;       // output stride
  end;
  PFftwIoDim = ^TFftwIoDim;

  TFftwIoDim64 = record
    DimensionSize: NativeInt;    // dimension size
    InputStride: NativeInt;      // input stride
    OutputStride: NativeInt;     // output stride
  end;
  PFftwIoDim64 = ^TFftwIoDim64;

  TFftwWriteCharFunc = procedure (c: AnsiChar; d: Pointer);
  TFftwReadCharFunc = function (d: Pointer): PInteger;

type
  TFftwFlag = (
    ffDestroyInput = 0,
    ffUnaligned = 1,
    ffConserveMemory = 2,
    ffExhaustive = 3,             // NoExhaustive InputStride default
    ffPreserveInput = 4,          // cancels FftwDestroyInput
    ffPatient = 5,                // Impatient InputStride default
    ffEstimate = 6,

    ffEstimatePatient = 7,
    ffBelievePCost = 8,
    ffNoDFT_R2HC = 9,
    ffNoNonthreaded = 10,
    ffNoBuffering = 11,
    ffNoIndirectOp = 12,
    ffAllowLargeGeneric = 13,     // NoLargeGeneric InputStride default
    ffNoRankSplits = 14,
    ffNoVRankSplits = 15,
    ffNoVRecurse = 16,
    ffNoSIMD = 17,
    ffNoSlow = 18,
    ffNoFixedRadixLargeN = 19,
    ffAllowPruning = 20,

    ffWisdomOnly = 21
  );
  TFftwFlags = set of TFftwFlag;

implementation

end.
