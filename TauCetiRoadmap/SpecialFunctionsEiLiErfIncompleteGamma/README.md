# Exponential, logarithmic, error and incomplete Gamma functions

This roadmap builds the theory of Chapters 6, 7 and 8 of the NIST *Digital Library of
Mathematical Functions* (DLMF; see [References](#references)) as a library. It covers three
chapters:
- **Chapter 8:** the incomplete Gamma functions `γ(a, z)`, `Γ(a, z)`, `P`, `Q` and Tricomi's
  entire function `γ*(a, z)`; the generalized exponential integral `E_p(z)`; the generalized sine
  and cosine integrals; and the incomplete Beta function `B_x(a, b)`.
- **Chapter 6:** the exponential integrals `E₁`, `Ein` and `Ei`; the logarithmic integral `li`;
  the sine and cosine integrals `Si`, `si`, `Ci`, `Cin`, `Shi`, `Chi`; and their auxiliary
  functions `f`, `g`.
- **Chapter 7:** the complex error functions `erf`, `erfc` and `w`; Dawson's integral; the
  Fresnel integrals `C`, `S` and `ℱ` with their auxiliary functions; the Goodwin–Staton integral;
  the inverse error functions; the repeated integrals `iⁿ erfc`; and the Voigt functions.

The roadmap covers:
- definitions as entire or principal-branch functions, and analytic continuation in logarithmic
  coordinates;
- special values, symmetry, interrelations, and representations by Kummer's function and
  `₁F₂`;
- power series, recurrences and derivatives;
- integral representations, including the Mellin–Barnes integrals;
- inequalities and continued fractions;
- asymptotic expansions for large argument and for large parameter with a fixed ratio;
- zeros;
- integrals, Laplace transforms and sums;
- the Gibbs phenomenon.

Chapter 8 is the base: Chapter 6 is the case `E₁ = Γ(0, ·)`, and Chapter 7 is the case
`erf z = π^{−1/2} γ(½, z²)`. Milestones 1–6 use nothing from Chapters 6 and 7. The Chapter 8
formulas that involve `E₁`, `erf`, `erfc` or Dawson's integral are placed after those functions,
in Milestones 7, 11 and 13.

The asymptotic statements consume the [AsymptoticExpansions](../AsymptoticExpansions/README.md)
roadmap (DLMF Chapter 2): Watson's lemma, Laplace's method, transcendental equations and
three-term recurrences.

The suggested home is `TauCeti/Analysis/SpecialFunctions/`, beside Tau Ceti's existing
`Erf.lean`, `IncompleteGamma.lean`, `IncompleteBeta.lean` and `LogIntegral.lean`. Suggested
files, grouped by milestone:
- Milestones 1–6: `IncompleteGamma/Complex.lean`, `IncompleteGamma/Continuation.lean`,
  `IncompleteGamma/Series.lean`, `IncompleteGamma/Integrals.lean`,
  `IncompleteGamma/ContinuedFraction.lean`, `IncompleteGamma/Asymptotics.lean`,
  `IncompleteGamma/Zeros.lean`.
- Milestones 7–10: `ExpIntegral/Generalized.lean`, `ExpIntegral/Basic.lean`,
  `ExpIntegral/SineCosine.lean`, `ExpIntegral/GeneralizedSineCosine.lean`.
- Milestones 11–14: `Erf/Complex.lean`, `Erf/Fresnel.lean`, `Erf/Integrals.lean`,
  `Erf/Asymptotics.lean`, `Erf/Zeros.lean`, `Erf/Inverse.lean`, `Erf/Repeated.lean`,
  `Erf/Voigt.lean`.
- Milestone 15: `IncompleteBeta/Hypergeometric.lean`.
- The general Pincherle theorem of Milestone 4.1:
  `TauCeti/Algebra/ContinuedFractions/Pincherle.lean`.

## Scope and completion criterion

The roadmap is complete when Tau Ceti proves all of the following.

1. **Incomplete Gamma: definitions and continuation** (DLMF 8.2.1–8.2.14, with 8.4.2, 8.4.12,
   8.7.1 and the bridge to Tau Ceti's real functions).
2. **Special values, Kummer representations, series and recurrences** (DLMF 8.4.5, 8.4.7–8.4.11,
   8.5.1–8.5.2, 8.7.2–8.7.3, 8.8.1–8.8.13, 8.8.15–8.8.19, 8.15.1).
3. **Integral representations, integrals and sums** (DLMF 8.6.1–8.6.5, 8.6.7–8.6.12,
   8.14.1–8.14.6, 8.22.2–8.22.3).
4. **Continued fractions and inequalities** (DLMF 8.9.1–8.9.2, 8.10.1–8.10.13), with Pincherle's
   theorem for continued fractions.
5. **Asymptotics of the incomplete Gamma functions** (DLMF 8.11.1–8.11.9, 8.11.12–8.11.19).
6. **Zeros of `γ*`** (DLMF §8.13(i) with 8.13.1, and §8.13(iii) (a)–(c)).
7. **The generalized exponential integral** (DLMF 8.4.4, 8.4.13, 8.4.15, 8.8.14,
   8.19.1–8.19.15, 8.19.17–8.19.27, 8.20.1–8.20.6, 8.22.1, and 2.11.5–2.11.7).
8. **Exponential and logarithmic integrals** (DLMF 6.2.1–6.2.8, 6.4.1–6.4.3, 6.5.1–6.5.2,
   6.6.1–6.6.4, 6.7.1–6.7.8, 6.8.1–6.8.3, 6.9.1, 6.10.1–6.10.3, 6.11.1, 6.12.1–6.12.2, 6.13.1,
   6.14.1, 6.14.4, and 2.5.49).
9. **Sine and cosine integrals** (DLMF 6.2.9–6.2.21, 6.4.4–6.4.7, 6.5.3–6.5.7, 6.6.5–6.6.6,
   6.7.9–6.7.14, 6.12.3–6.12.8, 6.13.2, 6.14.2–6.14.3, 6.14.5–6.14.7, 6.15.1–6.15.4,
   6.16.1–6.16.4).
10. **Generalized sine and cosine integrals** (DLMF 8.21.1–8.21.27).
11. **Error functions, Dawson's and Fresnel integrals** (DLMF 7.2.1–7.2.12, 7.4.1–7.4.8,
    7.5.1–7.5.13, 7.6.1–7.6.7, 7.10.1–7.10.4, 7.11.1–7.11.4, 7.11.6–7.11.8, and 8.4.1, 8.4.3,
    8.4.6, 8.4.14).
12. **Integral representations, inequalities, continued fractions and integrals of the error
    functions** (DLMF 7.7.1–7.7.16, 7.8.1–7.8.8, 7.9.1–7.9.3, 7.14.1–7.14.8).
13. **Asymptotics and zeros of the error functions** (DLMF 7.12.1–7.12.7, §7.13 with
    7.13.1–7.13.7), and the incomplete Gamma functions near the transition point
    (DLMF 8.11.10–8.11.11).
14. **Inverse error functions, repeated integrals and Voigt functions** (DLMF 7.17.1–7.17.6,
    7.18.1–7.18.9, 7.18.13–7.18.14, 7.19.1–7.19.11).
15. **Incomplete Beta functions** (DLMF 8.17.1–8.17.24 with 8.17.9 for `0 ≤ x < ½`, and 8.18.1).

**What this roadmap owns:** the functions and formulas listed above, with the hypotheses and
conventions specified in the milestones. It also owns the following auxiliary results, which
the milestones need and which neither Mathlib nor Tau Ceti provides:

| Result | Milestone |
|---|---|
| Pincherle's theorem: a continued fraction whose three-term recurrence has a minimal solution converges to the ratio fixed by that solution | 4.1 |
| `∫₀^∞ e^{−zt} t^{s−1}/(1 + t) dt` and `∫₀^∞ e^{−zt}(1 + t)^{a−1} dt` as Laplace transforms in a sector | 3.1 |
| The circle form of Hankel's loop integral for `γ(a, z)` | 3.2 |

**What this roadmap does not own:**
- **The real functions Tau Ceti already has:** `TauCeti.lowerIncompleteGamma`,
  `TauCeti.regularizedGamma`, `TauCeti.regularizedIncompleteBeta`,
  `TauCeti.inverseRegularizedGamma`, `TauCeti.inverseRegularizedIncompleteBeta`,
  `TauCeti.Real.erf`, `TauCeti.Real.erfc`, `Real.erfInv` and the offset logarithmic integral
  `TauCeti.Real.logIntegral`, with their existing API. This roadmap restricts its complex
  functions to them and does not restate their real theory.
- **Probability statements:** the normal cdf (DLMF 7.20.1), the gamma, beta, Poisson and binomial
  cdfs, and their quantiles.
- **Formulas through other special functions**, listed in
  [Beyond this roadmap](#beyond-this-roadmap-a-roadmap-for-a-roadmap-do-not-implement):
  Kummer's second function `U`, Whittaker functions, modified and spherical Bessel functions,
  Laguerre polynomials, Chebyshev expansions, the continued Gauss function `₂F₁` and the Hurwitz
  zeta function at complex shift.
- **The uniform asymptotic expansions for large parameter** (DLMF §8.12 and §8.18(ii)), and
  exponentially improved expansions.
- **Numerical tables and methods of computation.**

## Ownership and dependencies

- **[AsymptoticExpansions](../AsymptoticExpansions/README.md)** (DLMF Chapter 2) supplies the
  following. Expansions here are stated through its pinned `Asymptotics.HasAsymptoticExpansion`.
  - Milestone 1: asymptotic scales, Poincaré and generalized expansions, uniform expansions.
  - Milestone 2: transcendental equations and reversion, for the zeros.
  - Milestone 3: integration by parts and Watson's lemma on the real line.
  - Milestone 4: Watson's lemma in sectors and the rotation of the path.
  - Milestone 5: Laplace's method.
  - Milestone 8: Mellin inversion and the shifting of the line, for the Mellin–Barnes integrals.
  - Milestone 12: three-term recurrences, for the minimal solutions in Pincherle's theorem.
- **[ZerosOfLFunctions §1.2](../ZerosOfLFunctions/README.md#12-stirling-on-the-sector)**
  supplies complex Stirling in `|ph a| ≤ π − δ` (for DLMF 8.11.5).
  **[§1.3](../ZerosOfLFunctions/README.md#13-vertical-strips)** supplies the decay of `Γ` on
  vertical lines (for the Mellin–Barnes integrals). Neither is restated here.
- **[StandardDistributions](../StandardDistributions/README.md) Layer 2** owns the real
  incomplete Gamma, incomplete Beta and error functions and the closed-form cdfs. **Layer 8.4**
  owns their inverses. These are implemented in Tau Ceti and consumed here.
- **[ArithmeticDirichletSeries](../../Completed/ArithmeticDirichletSeries/README.md) §6.2** and
  ZerosOfLFunctions own the offset logarithmic integral `TauCeti.Real.logIntegral`. Milestone 8.2
  relates it to DLMF's `li` by one identity.
- **[ContourIntegration](../../Completed/ContourIntegration/README.md)** owns residues
  (`TauCeti.Contour.residue`), consumed in the Mellin–Barnes integrals.
- **The parabolic cylinder roadmap** (`SpecialFunctionsParabolicCylinder`, an open pull request)
  pins Dawson's integral as `TauCeti.dawson`, with the same definition as here. Whichever roadmap
  is implemented first owns `TauCeti.dawson`, and the other consumes it. The relations of
  `iⁿ erfc` to the parabolic cylinder functions (DLMF 7.18.11–7.18.12) are recorded under
  [Beyond this roadmap](#beyond-this-roadmap-a-roadmap-for-a-roadmap-do-not-implement).
- **Mathlib** supplies:
  - `Complex.Gamma`, `Complex.digamma`, `Real.eulerMascheroniConstant` and
    `ProbabilityTheory.beta`;
  - the regularized hypergeometric function `Complex.regularizedHGFun` with
    `regularizedHGFunCoeff`, and the Gauss series `ordinaryHypergeometric`;
  - `Complex.besselJ`, `Polynomial.hermite`, `ascPochhammer` and `descPochhammer`;
  - `GenContFract` and its convergents `GenContFract.convs`;
  - `mellin`, `mellinInv` and `mellinInv_mellin_eq`;
  - `Complex.slitPlane`, `Complex.log` and `Complex.cpow`;
  - `riemannZeta`, `harmonic` and `Nat.choose`.

**The boundary in one sentence:** this roadmap owns the complex theory of the functions of DLMF
Chapters 6–8 and its real-variable consequences. It consumes the general asymptotic methods of
AsymptoticExpansions and the existing real incomplete Gamma, Beta and error functions. It
excludes formulas through functions of other chapters, uniform large-parameter expansions,
exponentially improved expansions and numerical tables.

## Mathlib and Tau Ceti inventory

- **Mathlib** has no error function, exponential integral, incomplete Gamma or Beta function,
  Fresnel, sine or cosine integral, Dawson or Faddeeva function. It has
  `Complex.regularizedHGFun a b` for multisets `a`, `b` of complex parameters. This is the
  regularized `pFq` (DLMF 16.2.5), entire when `a.card ≤ b.card`
  (`analyticOnNhd_regularizedHGFun_of_card_le`). It also has
  `ordinaryHypergeometric a b c x`, the Gauss series, with junk value `0` outside its disc of
  convergence.
- **Mathlib pull request [#34053](https://github.com/leanprover-community/mathlib4/pull/34053)**
  (real `erf`, `erfc`). It has had no substantive activity for more than six months and is prior
  art only. Tau Ceti's `Erf.lean` follows its names.
- **Tau Ceti** has:
  - `TauCeti.Real.erf x = 2/√π ∫₀ˣ e^{−t²} dt` and `erfc = 1 − erf`, with parity, derivatives,
    monotonicity, limits and bounds; `Real.erfInv` and `Real.erfOrderIso`.
  - `TauCeti.lowerIncompleteGamma s x` and `TauCeti.regularizedGamma s x` for real `s`, `x`. Both
    are clamped to `0` for `s ≤ 0` or `x ≤ 0`. Their API covers continuity, monotonicity, the
    derivative, the recurrence `γ(s + 1, x) = sγ(s, x) − xˢe^{−x}`, the limits, the Erlang values
    and `TauCeti.Real.erf_eq_regularizedGamma_half_sq`.
  - `TauCeti.regularizedIncompleteBeta a b x`, its inverse and the identities `I_x(a, b) =
    1 − I_{1−x}(b, a)` (`regularizedIncompleteBeta_symm`) and 8.17.20
    (`regularizedIncompleteBeta_add_one_left`), with `_add_one_right` and its difference form.
  - `TauCeti.Real.logIntegral x = ∫₂ˣ dt/log t` with `logIntegral_isEquivalent_div_log`.
  - `TauCeti.inverseRegularizedGamma` in `TauCeti/Probability/Distributions/Gamma/Quantile`.
- **Other roadmaps.** No other roadmap defines a complex error function, an exponential, sine or
  cosine integral, or a complex incomplete Gamma function.

## Prior formalization

B. Braams' [`lean-DLMF`](https://github.com/bjbraams/lean-DLMF) (Apache-2.0) formalizes DLMF on
top of Mathlib, Tau Ceti and [`lean-codes`](https://github.com/bjbraams/lean-codes). Its
directories `DLMF/IncompleteGamma/`, `DLMF/ExpIntegrals/` and `DLMF/ErrorFunctions/`, with the
basic definitions in `DLMF/Confluent/Basic/` and `DLMF/Statistical/Basic/`, provide source
material for every milestone. That development defines `Γ(a, z)` through Kummer's second
function `U`. This roadmap defines it by the ray integral, so that `U` is not needed. Its
`γ*` is the same as here, through `regularizedHGFun`. Its sine and cosine integrals are power
series, while here they are segment integrals and the series are theorems.

This roadmap specifies the mathematics intrinsically. `lean-DLMF` supplies prior proofs and
implementation references; reused code carries attribution under the repository's porting
guidance. The following secondary provenance map records source counterparts (checked at commit
`1e4cfe6`). The mathematical targets and dependencies are specified by the milestones.

| Milestone | Counterpart in `lean-DLMF` |
|---|---|
| 1. Definitions, continuation | `Statistical/Basic/IncompleteGamma`, `Confluent/Basic/IncompleteGamma`, `IncompleteGamma/Basic`, `IncompleteGamma/Regularized`, `IncompleteGamma/ContinuedProperties` |
| 2. Values, series, recurrences | `IncompleteGamma/SpecialValues`, `IncompleteGamma/SeriesRecurrences` |
| 3. Integral representations | `IncompleteGamma/Representations/{UpperBarnes, LowerBarnes}`, `IncompleteGamma/RealIntegrals`, `IncompleteGamma/ZerosIntegrals` |
| 4. Fractions, inequalities | `IncompleteGamma/BoundsFractions`, `IncompleteGamma/BoundTools`, `IncompleteGamma/FractionTools` |
| 5. Asymptotics | `IncompleteGamma/Asymptotics/{LargeArgument, PartialSums, Central}` |
| 6. Zeros | `IncompleteGamma/ZerosIntegrals` |
| 7. `E_p` | `Confluent/Basic/ExponentialIntegrals`, `IncompleteGamma/ExponentialIntegral`, `IncompleteGamma/ExpIntegralAsymptotics` |
| 8–9. `E₁`, `Ei`, `li`, `Si`, `Ci` | `ExpIntegrals/Basic/{Functions, Properties}`, `ExpIntegrals/{AnalyticProperties, Continuation, Representations, Expansions, Asymptotics, ZerosIntegrals}`, `ExpIntegrals/TransformTools/*` |
| 10. `Si(a, z)`, `Ci(a, z)` | `IncompleteGamma/SineCosine/{SphericalSeries, GammaRepresentations}` |
| 11. Error functions | `Confluent/Basic/ErrorFunctions`, `ErrorFunctions/Basic/{Functions, Properties}`, `ErrorFunctions/{Series, AnalyticProperties, Relations}` |
| 12. Integrals, inequalities | `ErrorFunctions/Integrals/*`, `ErrorFunctions/IntegralTools`, `ErrorFunctions/BoundsAsymptotics/ContinuedFractions` |
| 13. Asymptotics, zeros | `ErrorFunctions/BoundsAsymptotics/{GaussianRemainders, FresnelRemainders}`, `ErrorFunctions/{Zeros, ZeroTools, ZeroClassification}` |
| 14. Inverse, `iⁿ erfc`, Voigt | `ErrorFunctions/Basic/Inverse`, `ErrorFunctions/{InverseGeneralized, Repeated, Voigt}` |
| 15. Incomplete Beta | `IncompleteGamma/Basic/IncompleteBeta`, `IncompleteGamma/{Beta, BetaContinuedFraction, BetaAsymptotics}` |

## Conventions (pinned)

- **Namespaces.** The complex incomplete Gamma functions and the complex error functions live in
  `TauCeti.Complex`, beside their real counterparts in `TauCeti` and `TauCeti.Real`:
  - `TauCeti.Complex.lowerIncompleteGamma`, `upperIncompleteGamma`, `upperIncompleteGammaLog`;
  - `regularizedGamma` (`P`), `regularizedGammaQ` (`Q`) and `tricomiIncompleteGamma` (`γ*`);
  - `erf` and `erfc`.

  The other complex functions live in `TauCeti`: `faddeeva`, `dawson`, `fresnelC`, `fresnelS`,
  `fresnelTail` (`ℱ`), `fresnelAuxF`, `fresnelAuxG`, `goodwinStaton`, `iteratedErfc`,
  `expIntegralE`, `expIntegralELog`, `expIntegralEin`, `sinIntegral`, `sinIntegralTail` (`si`),
  `cosIntegral` (`Ci`), `cosIntegralCin`, `sinhIntegral`, `coshIntegral`, `sinIntegralAuxF`,
  `sinIntegralAuxG`, `generalizedSinIntegral` (`Si(a, z)`), `generalizedCosIntegral`,
  `generalizedSinIntegralTail` (`si(a, z)`), `generalizedCosIntegralTail`, and `incompleteBeta`.
  Functions defined only on `ℝ` live in `TauCeti.Real`: `expIntegralEi`, `principalLogIntegral`
  (DLMF's `li`), `voigtU`, `voigtV` and `voigtH`. Argument order follows DLMF: parameter first.
- **Incomplete Gamma.** With Mathlib's `𝐌(a, b, z) = Complex.regularizedHGFun {a} {b} z`:

```lean
def TauCeti.Complex.tricomiIncompleteGamma (a z : ℂ) : ℂ :=
  cexp (-z) * Complex.regularizedHGFun {1} {a + 1} z                    -- DLMF 8.5.2
def regularizedGamma (a z : ℂ) : ℂ := z ^ a * tricomiIncompleteGamma a z -- P, DLMF 8.2.6
def regularizedGammaQ (a z : ℂ) : ℂ := 1 - regularizedGamma a z        -- Q, DLMF 8.2.5
def lowerIncompleteGamma (a z : ℂ) : ℂ := Complex.Gamma a * regularizedGamma a z
def upperIncompleteGamma (a z : ℂ) : ℂ :=
  cexp (-z) * ∫ t in Ioi (0 : ℝ), (z + t) ^ (a - 1) * cexp (-(t : ℂ))
```

  `γ*` is entire in each variable. For `z ≠ 0`, `P(·, z)` and `Q(·, z)` are entire, and
  `P(a, ·)`, `Q(a, ·)` are holomorphic on `slitPlane`. `Γ(a, z)` is the integral 8.2.2 along
  the horizontal ray from `z`, which stays in `slitPlane`
  when `z` does. It is the principal value there and entire in `a`. On the cut `(−∞, 0]` its value
  is junk, and no statement is made there. `γ(a, z)` takes Mathlib's junk value of `Γ` at
  `a ∈ −ℕ`, where DLMF's `γ` has poles. Statements about it either exclude those points or are
  stated for `γ*` and `P`.
- **Logarithmic coordinates.** Values off the principal sheet, and sectors wider than
  `|ph z| < π`, are written in `w` with `z = exp w`:

```lean
def upperIncompleteGammaLog (a w : ℂ) : ℂ :=
  upperIncompleteGamma a (Real.exp w.re) -
    ∫ s in (0 : ℝ)..1, I * w.im *
      cexp (a * (w.re + I * (s * w.im)) - cexp (w.re + I * (s * w.im)))
```

  This is `Γ(a, e^w)` continued from the positive axis along the vertical segment from `Re w` to
  `w`. The lower functions need no separate definition: `γ(a, e^w) = Γ(a) e^{aw} γ*(a, e^w)`
  and `P(a, e^w) = e^{aw} γ*(a, e^w)` are written out. `E_p` on the logarithmic plane is
  `expIntegralELog p w = exp((p − 1)w) · upperIncompleteGammaLog (1 − p) w`. "`z → ∞` in
  `|ph z| ≤ θ`" for `θ ≥ π` is the filter
  `comap re atTop ⊓ 𝓟 {w | |w.im| ≤ θ}`, as pinned by AsymptoticExpansions; for `θ < π` the
  filter `Bornology.cobounded ℂ ⊓ 𝓟 {z | |arg z| ≤ θ}` is used directly.
- **Entire functions as segment integrals.** `erf`, `dawson`, `fresnelC`, `fresnelS`,
  `expIntegralEin`, `sinIntegral`, `cosIntegralCin` and `sinhIntegral` are defined by the
  integral from `0` to `z` along the segment, written `∫ s in 0..1, z * f(s z)` (or `f(sz)/s`
  for the kernels `(1 − e^{−t})/t` etc., whose singularity at `0` is removable). For example:

```lean
def TauCeti.Complex.erf (z : ℂ) : ℂ := 2 / √π * ∫ s in (0 : ℝ)..1, z * cexp (-(s * z) ^ 2)
def TauCeti.Complex.erfc (z : ℂ) : ℂ := 1 - erf z
def TauCeti.faddeeva (z : ℂ) : ℂ := cexp (-z ^ 2) * Complex.erfc (-I * z)
def TauCeti.dawson (z : ℂ) : ℂ := cexp (-z ^ 2) * ∫ s in (0 : ℝ)..1, z * cexp ((s * z) ^ 2)
def TauCeti.expIntegralEin (z : ℂ) : ℂ := ∫ s in (0 : ℝ)..1, (1 - cexp (-(z * s))) / s
def TauCeti.expIntegralE (p z : ℂ) : ℂ := z ^ (p - 1) * Complex.upperIncompleteGamma (1 - p) z
```

  The power series are theorems. `fresnelTail z = (1 + i)/2 − (C(z) + iS(z))` (DLMF 7.5.2);
  `cosIntegral`, `coshIntegral`, `sinIntegralTail` and the auxiliary functions are the explicit
  combinations 6.2.10, 6.2.13, 6.2.16–6.2.18, 7.2.10–7.2.11. The full list of bodies is in
  `Suggested.lean`.
- **Generalized sine and cosine integrals.** `Si(a, z)` and `Ci(a, z)` are the series
  8.21.14–8.21.15, with the principal power `z^a`; they take junk values at their parameter
  poles. `si(a, z)` and `ci(a, z)` are 8.21.1, solved for each function, through
  `upperIncompleteGammaLog a (log z ∓ πi/2)`; they are entire in `a`.
- **Real functions.**

```lean
def TauCeti.Real.expIntegralEi (x : ℝ) : ℝ :=
  Real.eulerMascheroniConstant + Real.log |x| - (expIntegralEin (-x)).re   -- DLMF 6.2.7
def TauCeti.Real.principalLogIntegral (x : ℝ) : ℝ := expIntegralEi (Real.log x)  -- DLMF 6.2.8
```

  `Ei(0)` and `li(1)` are junk values. The principal-value integrals 6.2.5 and 6.2.8 are
  theorems. The Voigt functions are the integrals 7.19.1, 7.19.2 and 7.19.4. `B_x(a, b)` is
  `incompleteBeta a b x = ∫ t in 0..x, t^(a−1) (1 − t)^(b−1)` with real powers, for
  `a, b > 0` and `0 ≤ x ≤ 1`.
- **Real values of complex functions.** A real-variable statement about a complex function is
  made at `(x : ℂ)`. Equalities are stated in `ℂ`. Inequalities, limits in `ℝ` and real zeros use
  `.re`, after the milestone item proving that the imaginary part vanishes on the real line.
  The restrictions to Tau Ceti's real functions are equalities in `ℂ`, such as
  `Complex.erf x = (TauCeti.Real.erf x : ℂ)`.
- **Parameter poles.** `Γ` and `1/Γ` are Mathlib's: `Complex.Gamma (−n) = 0` is a junk value,
  and `(Complex.Gamma a)⁻¹` is the entire reciprocal. A formula of DLMF that holds "by limiting
  values" at `a ∈ −ℕ` is stated twice: once with the hypothesis `∀ n : ℕ, a ≠ −n`, and once at
  `a = −n` with the limit evaluated explicitly.
- **Special numbers and polynomials.** `ψ` is `Complex.digamma`. Pochhammer symbols `(a)_k` are
  `(ascPochhammer ℂ k).eval a`, and `(a − 1)(a − 2)⋯(a − k)` is
  `(descPochhammer ℂ k).eval (a − 1)`. DLMF's Hermite polynomial `H_n` (physicists') is
  `H_n(z) = 2^{n/2} He_n(√2 z)` with `He_n = Polynomial.hermite n` (probabilists'), written out.
  `e_n(z) = ∑_{k≤n} z^k/k!` (8.4.11) is written out as a `Finset` sum.
- **Continued fractions** are Mathlib's `GenContFract ℂ` (or `ℝ`). The continued fraction
  `b₀ + a₁/(b₁ + a₂/(b₂ + ⋯))` is `⟨b₀, Stream'.Seq.ofStream fun n => ⟨a (n+1), b (n+1)⟩⟩`, and its
  convergence to `v` is `Tendsto g.convs atTop (𝓝 v)`. DLMF's prefactors stay outside.
- **Expansions** are stated with AsymptoticExpansions' `HasAsymptoticExpansion` and its written-out
  uniform and generalized forms. `Suggested.lean` writes them out as `IsBigO`, because that
  roadmap is not yet in Tau Ceti. Remainder bounds ("bounded by the first neglected term")
  are inequalities between the remainder and that term, with the hypotheses DLMF states.
- **Mills' ratio, `inverfc` and other DLMF notation for one-line expressions** are written out:
  `𝖬(x) = (√π/2) e^{x²} erfc x`, `inverfc x = erfInv (1 − x)`. No new names or predicates are
  introduced for them.

## Milestone 1: incomplete Gamma, definitions and continuation

1. **Tricomi's function.** `γ*` is entire in `a` for fixed `z` and in `z` for fixed `a`. Prove:
   - the series 8.7.1: `γ*(a, z) = ∑ e^{−z} z^k/Γ(a + k + 1)` for all `a`, `z`, and
     `γ*(a, z) = Γ(a)⁻¹ ∑ (−z)^k/(k!(a + k))` for `a ∉ −ℕ`;
   - the special values `γ*(a, 0) = 1/Γ(a + 1)` (8.4.2) and `γ*(−n, z) = zⁿ` (8.4.12);
   - the integral 8.2.7 `γ*(a, z) = Γ(a)⁻¹ ∫₀¹ t^{a−1} e^{−zt} dt` for `Re a > 0`;
   - the differential equation 8.2.14.

2. **`P` and `γ`.** Prove 8.2.1 in the form `γ(a, z) = z^a ∫₀¹ s^{a−1} e^{−zs} ds` for `Re a > 0`
   and every `z`. Prove 8.2.4 and 8.2.6 (by definition, with `γ = Γ(a)P` for `a ∉ −ℕ`). Prove the
   poles: for `z ≠ 0`, `(a + n) γ(a, z) → (−1)ⁿ/n!` as `a → −n`. For fixed `z ≠ 0`, `P(·, z)` is
   entire, and `γ(·, z)` is holomorphic off `−ℕ`.

3. **`Γ(a, z)` and `Q`.** For `z ∈ slitPlane`:
   - the ray integral converges absolutely;
   - `Γ(·, z)` is entire;
   - `Γ(a, ·)` is holomorphic on `slitPlane`;
   - 8.2.2 holds: the definition is its integral along the horizontal ray from `z`, and for
     `x > 0`, `Γ(a, x) = ∫_x^∞ t^{a−1} e^{−t} dt`;
   - 8.2.3: `γ(a, z) + Γ(a, z) = Γ(a)` for `a ∉ −ℕ`;
   - 8.2.4–8.2.5: `Q(a, z) = Γ(a, z)/Γ(a)` for `a ∉ −ℕ`, and `Q(−n, z) = 0` for `z ≠ 0`;
   - 8.2.12, for `Γ(a, ·)` on `slitPlane` and for `γ(a, ·)`, and 8.2.13, for
     `w = e^z z^{1−a} Γ(a, z)`.

4. **The real bridge.** For real `s > 0` and `x ≥ 0`,
   `Complex.lowerIncompleteGamma s x = (TauCeti.lowerIncompleteGamma s x : ℂ)` and
   `Complex.regularizedGamma s x = (TauCeti.regularizedGamma s x : ℂ)`. For real `a` and `x > 0`,
   `Γ(a, x)`, `P(a, x)` and `γ*(a, x)` are real, and `γ*(a, x)` is real for every real `x`.

5. **Continuation** (DLMF 8.2.8–8.2.11). Prove:
   - `upperIncompleteGammaLog` is entire in `a` and in `w`;
   - `upperIncompleteGammaLog a (log z) = Γ(a, z)` for `z ∈ slitPlane`;
   - `∂_w upperIncompleteGammaLog a w = −e^{aw − e^w}`;
   - 8.2.8 for `γ(a, e^w) = Γ(a) e^{aw} γ*(a, e^w)`;
   - 8.2.9 for `a ∉ −ℕ`, and its limiting form
     `Γ(−n, e^{w+2πim}) = Γ(−n, e^w) − 2πim (−1)ⁿ/n!`;
   - 8.2.10 for all `a`, with `1/Γ(1 − a)` written `(Complex.Gamma (1 − a))⁻¹`, Mathlib's entire
     reciprocal;
   - 8.2.11 for `a ∉ −ℕ` and `z ≠ 0`, both signs, with `w = log z ± πi`.

*Needs:* Mathlib `Complex.regularizedHGFun`, `analyticOnNhd_regularizedHGFun_of_card_le`,
`Complex.Gamma`, `Complex.differentiableAt_Gamma`, `Complex.tendsto_self_mul_Gamma_nhds_zero`
with the recurrence `Complex.Gamma_add_one` for the residues at `−n`, holomorphy of parametric
integrals (`hasDerivAt_integral_of_dominated_loc_of_deriv_le`) and the Cauchy theorem for
rectangles. Tau Ceti `IncompleteGamma.lean`.

## Milestone 2: special values, Kummer representations, series and recurrences

1. **Special values** (DLMF 8.4.5, 8.4.7–8.4.11). `Γ(1, z) = e^{−z}`, and for `n ∈ ℕ` the Erlang
   forms 8.4.7–8.4.10 with `e_n` written out. The upper function holds for every `z`, because
   the integrand of `Γ(n + 1, z)` is a polynomial times `e^{−t}`.
2. **Kummer representations** (DLMF 8.5.1–8.5.2). `γ*(a, z) = 𝐌(a, a + 1, −z)`, and 8.5.1 for
   `a ∉ −ℕ` in the form `γ(a, z) = a⁻¹ z^a Γ(a + 1) 𝐌(a, a + 1, −z)`. This is Kummer's
   transformation for the special parameters `(1, a + 1)`, proved here from the series.
3. **Series** (DLMF 8.7.2–8.7.3). 8.7.3 for `a ∉ −ℕ` and `z ∈ slitPlane`. 8.7.2 for `|y| < |x|`
   with `x > 0`, as a convergent series.
4. **Recurrences** (DLMF 8.8.1–8.8.12). 8.8.1 for `a ∉ −ℕ`; 8.8.2 on `slitPlane` for all `a`;
   the three-term recurrence 8.8.3 for both functions; 8.8.4–8.8.6; the iterated forms 8.8.7–8.8.12
   for `n ∈ ℕ`, with `Γ(a + n)/Γ(a + k + 1)` written through `(ascPochhammer ℂ _).eval` where
   `Γ` may vanish.
5. **Derivatives** (DLMF 8.8.13, 8.8.15–8.8.19). 8.8.13 on `slitPlane`, and the `n`th
   derivatives 8.8.15–8.8.19 with `iteratedDeriv`. The parameter derivative 8.8.14 is in
   Milestone 7.3.
6. **Sums** (DLMF 8.15.1). `γ(a, λx) = λ^a ∑ γ(a + k, x)(1 − λ)^k/k!` for `Re a > 0`, `x > 0` and
   `|1 − λ| < 1`, which is the region of convergence used.

*Needs:* Milestone 1; Mathlib `regularizedHGFunCoeff`, `ascPochhammer`, `iteratedDeriv`.

## Milestone 3: integral representations, integrals and sums

1. **Real-line integrals** (DLMF 8.6.1–8.6.5, 8.6.7). 8.6.1 for `a ∉ ℤ` and `z ≠ 0`. 8.6.2 for
   `Re a > 0`, with Mathlib's `Complex.besselJ`. 8.6.3 for `Re a > 0` and `Re z > 0`. 8.6.4 for
   `Re a < 1` and `z ∈ slitPlane`. 8.6.5 and 8.6.7 for `Re z > 0`. The auxiliary Laplace
   transforms `∫₀^∞ e^{−zt}(1 + t)^{a−1} dt` and `∫₀^∞ e^{−zt} t^{s−1}/(1 + t) dt` are holomorphic
   in `Re z > 0` and continue across `|ph z| < π` by rotating the ray
   (AsymptoticExpansions 4.3), giving 8.6.4 from 8.6.5.
2. **Contour integrals** (DLMF 8.6.8–8.6.9). 8.6.8 for `z ≠ 0`, `a ∉ ℤ`, with the loop taken as
   the unit circle from `−1`:
   `γ(a, z) = z^a/(2 sin πa) ∫_{−π}^{π} e^{iaθ + z e^{iθ}} dθ`. 8.6.9 for `Re z > 0`,
   `Re a > −1`, with the indented path taken as the ray `r e^{±iθ}`, `0 < θ < π/2 − |ph z|`, and
   with the left side `upperIncompleteGammaLog (−a) (log z ± πi)`.
3. **Mellin–Barnes integrals** (DLMF 8.6.10–8.6.12). Each is stated as an integral over the
   vertical line `Re s = c`, written as `(2π)⁻¹ ∫ y : ℝ, f(c + iy)`, for the parameters for which
   a straight line separates the poles as DLMF requires: 8.6.10 for `|ph z| < π/2`, `Re a > 0`
   and `0 < c < Re a`; 8.6.11 for `|ph z| < π/2` and `c > max(0, −Re a)`; 8.6.12 for
   `|ph z| < 3π/2` (in logarithmic coordinates), `Re a < 1` and `max(Re a − 1, −1) < c < 0`.
4. **Integrals** (DLMF 8.14.1–8.14.6). 8.14.1–8.14.4 with the stated hypotheses, and with the
   limiting values at `b = 0` stated separately. 8.14.5 for `Re s > 0`, where `1/(1 + s)` lies
   in the unit disc, and 8.14.6 for `Re s > −½`, where `s/(1 + s)` does, both with Mathlib's
   `ordinaryHypergeometric`.
5. **The incomplete Riemann zeta function** (DLMF 8.22.2–8.22.3). For `Re s > 1` and `x > 0`,
   `Γ(s)⁻¹ ∫₀ˣ t^{s−1}/(e^t − 1) dt = ∑ k^{−s} P(s, kx)`, and its limit as `x → ∞` is
   `riemannZeta s`.

*Needs:* Milestones 1–2; AsymptoticExpansions 4.3 (rotation of the path) and 8.1–8.2 (Mellin
inversion and shifting the line); ZerosOfLFunctions §1.3; ContourIntegration residues;
Mathlib `Complex.besselJ`, `ordinaryHypergeometric`, `circleIntegral`, `riemannZeta`.

## Milestone 4: continued fractions and inequalities

1. **Pincherle's theorem** (Gautschi 1967, Theorem 1.1). Let `a n`, `b n` (`n ≥ 1`) be complex
   with every `a n ≠ 0`, and consider the recurrence `y(n + 1) = b n · y(n) + a n · y(n − 1)`
   for `n ≥ 1`. A solution `f` is *minimal* when `f(n)/u(n) → 0` for every solution `u` not
   proportional to `f`. Then the continued fraction `a₁/(b₁ + a₂/(b₂ + ⋯))` (a `GenContFract`
   with head `0`) converges if and only if the recurrence has a minimal solution `f`, and its
   value is then `−f(1)/f(0)`. With AsymptoticExpansions 12.1 this gives convergence whenever the
   two characteristic solutions of the recurrence have different growth.
2. **The incomplete Gamma fractions** (DLMF 8.9.1–8.9.2). 8.9.1 for `a ∉ −ℕ`, `a ≠ −1` and every
   `z`. 8.9.2 for `z ∈ slitPlane`, from the minimal solution `Γ(a + n, z)` of 8.8.3 in the form
   needed, each as convergence of a `GenContFract ℂ`.
3. **Inequalities** (DLMF 8.10.1–8.10.13). For real parameters and `x > 0`, with `Γ(a, x)` and
   `γ(a, x)` the real parts of the complex functions:
   - 8.10.1–8.10.2 for `0 < a ≤ 1`, with the reversed inequalities for `a ≥ 1`;
   - 8.10.3–8.10.4: with `ϑ` defined by 8.10.3, `ϑ → 1` as `x → ∞` and `0 < ϑ ≤ 1` for `a ≤ 2`
     (`a ≠ 1`);
   - the Padé bounds 8.10.5–8.10.6 for `n = 1, 2`;
   - 8.10.7–8.10.8;
   - 8.10.9–8.10.10 for `0 < a < 1`;
   - 8.10.11–8.10.12 for `a > 0`, with equality only at `a = 1`;
   - 8.10.13 for `n ≥ 1`.

*Needs:* Milestones 1–3; AsymptoticExpansions 12.1; Mathlib `GenContFract`, `GenContFract.convs`
and the recurrences for its numerators and denominators (`GenContFract.convs_eq` family).

## Milestone 5: asymptotics of the incomplete Gamma functions

1. **Large `z`, fixed `a`** (DLMF 8.11.1–8.11.3). With `u_k = (a − 1)(a − 2)⋯(a − k)`, for every
   `n` and `δ > 0`, in logarithmic coordinates:
   `e^{(1−a)w + e^w} Γ(a, e^w) − ∑_{k<n} u_k e^{−kw} = O(e^{−nw})` as `Re w → ∞` with
   `|Im w| ≤ 3π/2 − δ`. For real `a`, `x > 0` and `n ≥ a − 1`, `R_n(a, x)` lies between `0` and
   the first neglected term `u_n/xⁿ`. The proof is Watson's lemma (AsymptoticExpansions 4.2–4.3)
   on 8.6.5, and 8.2.9 beyond `|ph z| ≤ π`.
2. **Large `a`, fixed `z`** (DLMF 8.11.4–8.11.5). 8.11.4 as a convergent series for `a ∉ −ℕ`,
   and as a generalized asymptotic expansion as `a → ∞` in `|ph a| ≤ π − δ`, with respect to the
   scale `|z|^k/|(a)_{k+1}|`. 8.11.5 in the same sector, both relations as asymptotic
   equivalences, using complex Stirling.
3. **Large `a`, fixed `z/a`** (DLMF 8.11.6–8.11.9). With `b_k(λ)` the polynomials of
   8.11.8–8.11.9 and `z = λa`:
   - 8.11.6 for `0 < λ < 1` and `|ph a| ≤ π/2 − δ`;
   - 8.11.7 for `λ > 1` and `|ph a| ≤ 3π/2 − δ`, in logarithmic coordinates for `a`;
   - each as an asymptotic expansion in the scale `|a|^{−k}`, uniformly for `λ` in compact
     subsets of the stated intervals.
4. **`Γ(z, z)` and the exponential partial sums** (DLMF 8.11.12–8.11.19):
   - 8.11.12 with the stated six coefficients, as `z → ∞` in `|ph z| ≤ 2π − δ`, with `a = z`
     and the second argument in logarithmic coordinates;
   - the limits 8.11.13;
   - the identities 8.11.14–8.11.15;
   - the expansions 8.11.16–8.11.17 to the stated number of terms;
   - 8.11.18 uniformly for `x ≤ 1 − δ`, with `d_k` from 8.11.19.

The transition region 8.11.10–8.11.11, which needs `erfc` and Dawson's integral, is
Milestone 13.5.

*Needs:* Milestones 1–3; AsymptoticExpansions 1, 3, 4 and 5; ZerosOfLFunctions §1.2.

## Milestone 6: zeros of `γ*`

1. **`x`-zeros** (DLMF §8.13(i)). For real `a ≥ 0`, `γ*(a, x) ≠ 0` for all real `x`. For
   `a < 0` and `n ≥ 1`:
   - if `1 − 2n < a < 2 − 2n`, there is exactly one negative zero and no positive zero;
   - if `−2n < a < 1 − 2n`, there is exactly one negative zero `x₋(a)` and exactly one positive
     zero `x₊(a)`.
   On `−1 < a < 0`, `x₋` is strictly decreasing and satisfies 8.13.1.
2. **`a`-zeros** (DLMF §8.13(iii) (a)–(c)). For fixed real `x` and `n ≥ 1`:
   - for `x < 0`, `γ*(·, x)` has exactly two zeros in `−2n < a < 2 − 2n`;
   - there is `x*_n > 0` such that for `0 < x ≤ x*_n` it has exactly two zeros (counted with
     multiplicity) in `−2n < a < 1 − 2n`, and for `x > x*_n` none;
   - for `x = 0` its zeros are exactly `a = −n`, `n ≥ 1`.

*Needs:* Milestones 1–2; the intermediate value theorem and Rolle's theorem; 8.2.14 and 8.8.4 for
the sign changes.

## Milestone 7: the generalized exponential integral

1. **Definition and integrals** (DLMF 8.19.1–8.19.4). `E_p(z) = z^{p−1} Γ(1 − p, z)` by
   definition. `E_p` is holomorphic on `slitPlane` for each `p`, and entire in `p` for each `z`
   there. Prove 8.19.2 along the horizontal ray, 8.19.3 for `Re z > 0`, and 8.19.4 for
   `Re z > 0` and `Re p > 0`. Prove 2.11.5 as the same statement as 8.19.4. Prove the terminant
   identity 8.22.1 as `Γ(p) z^{1−p} E_p(z) = Γ(p) Γ(1 − p, z)`.
2. **Special values and series** (DLMF 8.19.5–8.19.11, 8.4.4, 8.4.13, 8.4.15). `E₀`, `E_p(0)`
   for `Re p > 1` as a limit along `slitPlane`, and 8.19.7 for `n ≥ 2`. Prove 8.19.8–8.19.9 for
   `n ≥ 1` with `ψ = Complex.digamma` and `z ∈ slitPlane`. Prove 8.19.10–8.19.11 for
   `p ∉ ℤ_{>0}`. Prove `Γ(0, z) = E₁(z)` (8.4.4), 8.4.13 and 8.4.15.
3. **Recurrence, derivatives and continuation** (DLMF 8.19.12–8.19.15, 8.19.18). 8.19.12–8.19.14
   on `slitPlane`, and 8.19.15 for `Re z > 0` and `j ≥ 1`. For 8.19.18, in logarithmic
   coordinates and for `p ∉ ℤ_{>0}`:
   `E_p(e^{w + 2πim}) = 2πi e^{mpπi} Γ(p)⁻¹ (sin(mpπ)/sin(pπ)) e^{(p−1)w} + E_p(e^w)`.
   At `p = n ∈ ℤ_{>0}`, prove the limiting form
   `E_n(e^{w+2πim}) = E_n(e^w) + 2πim (−1)ⁿ e^{(n−1)w}/(n − 1)!`, which is 6.4.2 at `n = 1`.
   Prove the parameter derivative of `γ*` at `a = 0`, `∂_a γ*(a, z)|_{a=0} = −E₁(z) − ln z`
   (8.8.14), for `z ∈ slitPlane`, from the series 8.7.1 and 8.19.8 at `n = 1`.
4. **Continued fraction and inequalities** (DLMF 8.19.17, 8.19.19–8.19.22). 8.19.17 for
   `z ∈ slitPlane`, via Milestone 4.1 as in 4.2. 8.19.19–8.19.22 for `n ≥ 1` and `x > 0`
   (with `E₀` from 8.19.5 where `n − 1 = 0`).
5. **Integrals** (DLMF 8.19.23–8.19.27). 8.19.23 on `slitPlane` for `Re p > 1` along the ray.
   8.19.24 for `n ≥ 1` and `Re a > −1`. 8.19.25 for `Re a > −½` and `Re(p + b) > 1`, where
   `a/(1 + a)` lies in the unit disc. 8.19.26–8.19.27 with `F(1, 1; 1 + p; ½)` as Mathlib's
   `ordinaryHypergeometric`.
6. **Asymptotics** (DLMF 8.20.1–8.20.6, 2.11.6–2.11.7). 8.20.1 as an identity. 8.20.2 in
   `|ph z| ≤ 3π/2 − δ` and 8.20.3 in `π/2 + δ ≤ ±ph z ≤ 7π/2 − δ`, both in logarithmic
   coordinates. 2.11.6–2.11.7 as the same statements. 8.20.4–8.20.5 with `A_k` the polynomials
   of 8.20.4. 8.20.6 as `p → +∞`, uniformly for `λ ∈ [0, ∞)`.

*Needs:* Milestones 1–5 (1–2 for 7.1–7.3, 4.1 for 7.4, 5.1 for 7.6); AsymptoticExpansions 1, 3
and 4; Mathlib `Complex.digamma`, `ordinaryHypergeometric`.

## Milestone 8: exponential and logarithmic integrals

1. **`E₁` and `Ein`** (DLMF 6.2.1–6.2.4, 6.4.1–6.4.3, 6.11.1, 2.5.49). `Ein` is entire. On
   `slitPlane`: 6.2.1 along the horizontal ray, 6.2.2 (which is 2.5.49), and 6.2.4. In
   logarithmic coordinates, `E₁(e^w) = Ein(e^w) − w − γ` (6.4.1) is the value of
   `expIntegralELog 1 w`; deduce 6.4.2–6.4.3. 6.11.1 is 8.4.4.
2. **`Ei` and `li`** (DLMF 6.2.5–6.2.8, 6.5.1–6.5.2). For `x > 0`:
   - 6.2.5, both principal-value integrals, as limits as `ε → 0+` of integrals over the
     complement of `(−ε, ε)`;
   - 6.2.6 and 6.2.7;
   - 6.5.1, as the limits of `E₁(−x ± iy)` as `y → 0+`;
   - 6.5.2.

   `principalLogIntegral` satisfies 6.2.8 as a principal value at `t = 1` for `x > 1`, and
   `TauCeti.Real.logIntegral x = li(x) − li(2)` for `x > 1`.
3. **Series and integral representations** (DLMF 6.6.1–6.6.4, 6.7.1–6.7.8, 6.10.1–6.10.3). The
   power series 6.6.1–6.6.4, with 6.6.3 using `ψ(n + 1) = Complex.digamma (n + 1)`. The
   integrals 6.7.1–6.7.8 with their stated parameter ranges, with 6.7.3–6.7.4 as improper
   integrals. The inverse factorial series 6.10.1 for `Re z > 0`, with `c_k` defined by 6.10.3
   and the values 6.10.2 as checks.
4. **Inequalities, continued fraction, asymptotics** (DLMF 6.8.1–6.8.3, 6.9.1, 6.12.1–6.12.2).
   6.8.1–6.8.3 for `x > 0`. 6.9.1 for `z ∈ slitPlane`, the case `p = 1` of 8.19.17. 6.12.1
   in `|ph z| ≤ 3π/2 − δ`, with the remainder bounds:
   - at most the first neglected term in `|ph z| ≤ π/2`, and of the same sign on the positive
     axis;
   - at most `csc |ph z|` times it in `π/2 ≤ |ph z| < π`.

   6.12.2 as `x → +∞`, with the remainder bound `1 + χ(n + 1)` times the next term, where
   `χ(n) = π^{1/2} Γ(n/2 + 1)/Γ(n/2 + ½)` (DLMF 9.7.2) is written out. The expansion of
   `li(x)` follows.
5. **Zeros and integrals** (DLMF 6.13.1, 6.14.1, 6.14.4). `Ei` has exactly one positive zero `x₀`.
   `Ei(x) < 0` for `x < 0`, and `x₀ ∈ (0.3725074107, 0.3725074108)`. Prove 6.14.1 for
   `Re a > −1` (with the limit at `a = 0`) and 6.14.4.

*Needs:* Milestones 1 and 7; AsymptoticExpansions 3–4; Mathlib `Real.eulerMascheroniConstant`,
`Complex.digamma`, interval integrals.

## Milestone 9: sine and cosine integrals

1. **Definitions and continuation** (DLMF 6.2.9–6.2.16, 6.4.4–6.4.5). `Si`, `Cin` and `Shi` are
   entire. `Si` and `Shi` are odd and `Cin` is even. 6.2.10–6.2.11, with 6.2.11 on `slitPlane`
   along the horizontal ray as an improper integral. 6.2.13 and 6.2.16 hold by definition. Prove
   the limits 6.2.14. Prove 6.4.4–6.4.5 in logarithmic coordinates, with
   `Ci(e^w) = −Cin(e^w) + w + γ`.
2. **Auxiliary functions** (DLMF 6.2.17–6.2.21, 6.4.6–6.4.7, 6.7.12–6.7.14). Prove 6.2.19–6.2.21.
   Prove 6.4.6–6.4.7 in logarithmic coordinates. Prove 6.7.12 for `|ph z| ≤ π` as an improper
   integral. Prove the first integrals of 6.7.13–6.7.14 for `z ∈ slitPlane`, and the second for
   `Re z ≥ 0` (with `z ≠ 0` for `g`).
3. **Interrelations and series** (DLMF 6.5.3–6.5.7, 6.6.5–6.6.6, 6.7.9–6.7.11). 6.5.3–6.5.4 for
   `x > 0`; 6.5.5–6.5.7 for `Re z > 0`; the power series 6.6.5–6.6.6; 6.7.9–6.7.11 with the
   stated ranges.
4. **Asymptotics** (DLMF 6.12.3–6.12.8). The remainder identities 6.12.5–6.12.8 for `Re z > 0`.
   The expansions 6.12.3–6.12.4 in `|ph z| ≤ π − δ`. The remainder bounds in `|ph z| ≤ π/4`, and
   with the factor `csc(2|ph z|)` in `π/4 ≤ |ph z| < π/2`.
5. **Zeros** (DLMF §6.13, 6.13.2). `Ci` and `si` each have infinitely many positive zeros, simple
   and enumerated increasingly as `c_k`, `s_k` (`k ≥ 0`, as in DLMF). Prove 6.13.2 with
   `α = kπ`, respectively `(k + ½)π`, as an asymptotic expansion in `α⁻¹` to the stated four
   terms. Prove the alternating remainder property: the remainder after `n` terms has the sign of
   the `(n + 1)`th term and modulus at most its modulus, for `n ≤ 4`.
6. **Integrals and sums** (DLMF 6.14.2–6.14.3, 6.14.5–6.14.7, 6.15.1–6.15.4). As stated, with
   `Re a > 0` for the Laplace transforms and improper integrals where DLMF's are not absolutely
   convergent.
7. **The Gibbs phenomenon** (DLMF 6.16.1–6.16.4). The Fourier series 6.16.1 converges pointwise
   on `(−π, π)` to the stated values, and the identity 6.16.2 holds. `R_n(x) = O(n⁻¹)` uniformly on
   `[−π, π]` (6.16.4). The first positive maximum of `Si` is at `π`, and
   `S_n(π/(2n)) → Si(π)/2` as `n → ∞`.

*Needs:* Milestones 7–8; AsymptoticExpansions 2, 3 and 4. The Dirichlet integral 6.2.14 is
proved here from 6.5.5 and the decay of `E₁` on the imaginary axis.

## Milestone 10: generalized sine and cosine integrals

1. **Definitions and analyticity** (DLMF 8.21.1–8.21.3). For each `z ∈ slitPlane`:
   - `si(·, z)` and `ci(·, z)` are entire;
   - `Si(·, z)` is holomorphic off `{−1, −3, −5, …}` and `Ci(·, z)` off `{0, −2, −4, …}`, with
     simple poles there;
   - 8.21.2 holds away from those poles;
   - 8.21.1 holds by definition.

   On the positive axis, the principal values are those of 8.21.1–8.21.2 with the principal
   `Γ(a, ∓ix)` and `γ(a, ∓ix)`. Prove 8.21.3 for `0 < Re a < 1`.
2. **Integral representations and interrelations** (DLMF 8.21.4–8.21.9). 8.21.4–8.21.7 for real
   `x > 0`, with the stated ranges of `Re a`, as improper integrals in 8.21.4–8.21.5. 8.21.8 for
   `a ∉ −ℕ`, and its limiting form at `a = −2n`. 8.21.9 for `a ∉ −ℕ`, and its limiting form at
   `a = −(2n + 1)`.
3. **Special values and series** (DLMF 8.21.10–8.21.17). 8.21.10–8.21.11. 8.21.12–8.21.13 as
   limits along the positive axis with the stated exclusions. 8.21.14–8.21.15 hold by
   definition. 8.21.16–8.21.17 are outside the scope (spherical Bessel functions).
4. **Auxiliary functions and asymptotics** (DLMF 8.21.18–8.21.27). 8.21.18–8.21.21. 8.21.22–8.21.23
   for `z ∈ slitPlane` and `Re a < 1`, as improper integrals. 8.21.24–8.21.25 for `Re z > 0`.
   8.21.26–8.21.27 in `|ph z| ≤ π − δ`.

*Needs:* Milestones 1, 5 and 9; AsymptoticExpansions 4.

## Milestone 11: error functions, Dawson's and Fresnel integrals

1. **Definitions** (DLMF 7.2.1–7.2.3, 7.2.5–7.2.8, 7.2.10–7.2.12). `erf`, `erfc`, `w`, `F`, `C`,
   `S` and `ℱ` are entire. `erf (x : ℂ) = TauCeti.Real.erf x`. The defining integrals from `0`
   are characterized by their derivatives and their value `0` at `0`: `erf′ = 2π^{−1/2} e^{−z²}`,
   `F′ = 1 − 2zF`, `C′ = cos(πz²/2)` and `S′ = sin(πz²/2)`.
   7.2.2 holds for `erfc` as `∫_z^∞` along the horizontal ray for `|ph z| < π/4` and for real
   `z`. 7.2.6 holds for `ℱ` as an improper integral along the real axis. `G` (7.2.12) is
   holomorphic on `slitPlane`.
2. **Values at infinity and symmetry** (DLMF 7.2.4, 7.2.9, 7.4.1–7.4.8). 7.2.4 in
   `|ph z| ≤ π/4 − δ`.
   7.2.9 for the real parts. 7.4.1–7.4.8 as identities of entire functions. `C`, `S`, `F` and
   `erf` are real on the real axis.
3. **Interrelations** (DLMF 7.5.1–7.5.13). All as identities of entire functions, with 7.5.8–7.5.10
   for both sign choices. 7.5.11–7.5.12 for real `x` with the stated signs. 7.5.13 for `x > 0`,
   with `Ei` of Milestone 8.
4. **Series, derivatives and hypergeometric forms** (DLMF 7.6.1–7.6.7, 7.10.1–7.10.4, 7.11.1–7.11.4,
   7.11.6–7.11.8). The power series 7.6.1–7.6.7. 7.10.1 with `H_n` written through
   `Polynomial.hermite`. 7.10.2–7.10.4. 7.11.1–7.11.3 for `Re z > 0`, where `(z²)^{1/2} = z`,
   and the entire form `erf z = z γ*(½, z²)`. 7.11.4 and 7.11.6 with `𝐌` (`M(a, b, ·) =
   Γ(b) 𝐌(a, b, ·)`). 7.11.7–7.11.8 with `Complex.regularizedHGFun` for `₁F₂`.
5. **Incomplete Gamma special values** (DLMF 8.4.1, 8.4.3, 8.4.6, 8.4.14). 8.4.1 and 8.4.6 for
   `Re z > 0`. 8.4.3 for `z ≠ 0`. 8.4.14 for `n ∈ ℕ` and `Re z > 0`.

*Needs:* Milestones 1, 2 and 7 (for 7.11.3); Mathlib `Polynomial.hermite`,
`Complex.regularizedHGFun`; Tau Ceti `Erf.lean`.

## Milestone 12: integrals, inequalities and continued fractions of the error functions

1. **Integral representations** (DLMF 7.7.1–7.7.16). 7.7.1 for `|ph z| ≤ π/4` (`z ≠ 0`), 7.7.2 for
   `Im z > 0`, and 7.7.3–7.7.9 with the stated ranges. 7.7.10–7.7.12 with the stated ranges, with
   7.7.12 as an improper integral. The Mellin–Barnes integrals 7.7.13–7.7.14 with
   `ζ = π² z⁴/16` and `|ph z| < π/8` (so that `|ph ζ| < π/2`), as in Milestone 3.3. 7.7.15–7.7.16
   for `Re a > 0`.
2. **Inequalities** (DLMF 7.8.1–7.8.8). With Mills' ratio written out, 7.8.2–7.8.5 on the stated
   ranges, and 7.8.6–7.8.8. 7.8.7 includes the strict decrease of `F(x)/√(1 − e^{−2x²})` on
   `x > 0`.
3. **Continued fractions** (DLMF 7.9.1–7.9.3). 7.9.1–7.9.2 for `Re z > 0` and 7.9.3 for
   `Im z > 0`, via Milestone 4.1.
4. **Integrals** (DLMF 7.14.1–7.14.8 with 7.14.4_5). With the stated ranges, the limit at `a = 0`
   in 7.14.1, and principal square roots.

*Needs:* Milestones 3.3, 4.1, 8 and 11; AsymptoticExpansions 8.1–8.2.

## Milestone 13: asymptotics and zeros of the error functions

1. **`erfc`** (DLMF 7.12.1). Both expansions in `|ph z| ≤ 3π/4 − δ`, in logarithmic coordinates.
   The remainder bounds hold in `|ph z| ≤ π/4` (with the sign on the positive axis) and with the
   factor `csc(2|ph z|)` in `π/4 ≤ |ph z| < π/2`.
2. **Fresnel auxiliary functions** (DLMF 7.12.2–7.12.7). The remainder identities 7.12.4–7.12.7
   for `|ph z| < π/4`. The expansions in `|ph z| ≤ π/2 − δ`. The remainder bounds in
   `|ph z| ≤ π/8` and with the factor `|csc(4 ph z)|` in `π/8 ≤ |ph z| < π/4`.
3. **Zeros of `erf` and `erfc`** (DLMF §7.13(i)–(ii), 7.13.1–7.13.4):
   - `erf` has a simple zero at `0` and infinitely many zeros in the open first quadrant, all
     simple;
   - its zero set is invariant under `z ↦ −z` and `z ↦ z̄`;
   - `erfc` has infinitely many zeros in `π/2 < ph z < 3π/4`, its other zeros are their
     conjugates, and the zeros of `w` are `iz_n` and `i z̄_n`;
   - enumerating by increasing modulus, the expansions 7.13.1 and 7.13.3 hold to the stated
     terms, with `λ`, `μ` from 7.13.2 and 7.13.4.
4. **Zeros of the Fresnel integrals** (DLMF §7.13(iii)–(iv), 7.13.5–7.13.7):
   - `C` has a simple zero and `S` a triple zero at `0`;
   - each has infinitely many zeros in the open first quadrant, and its zero set has the
     eightfold symmetry stated;
   - the expansions 7.13.5 hold with 7.13.6, respectively 7.13.7;
   - if `z_n` is a zero of `erfc`, then `(1 + i) z_n/√π` is a zero of `ℱ`.
5. **The incomplete Gamma functions near the transition point** (DLMF 8.11.10–8.11.11). With
   `x = a + (2a)^{1/2} y`, both formulas hold as `a → +∞`, uniformly for `y` in compact subsets
   of `ℝ`, with `erfc` and Dawson's integral of Milestone 11. The proof is Laplace's method
   (AsymptoticExpansions 5) on the integral 8.2.1 after the substitution `t = a + (2a)^{1/2} s`.

*Needs:* Milestones 1, 5, 11 and 12; AsymptoticExpansions 2 (for the zeros), 4, and 5 (for 13.5);
the argument principle (or Rouché's theorem) for counting zeros near the asymptotic positions,
with Mathlib's `circleIntegral`.

## Milestone 14: inverse error functions, repeated integrals and Voigt functions

1. **Inverse error functions** (DLMF 7.17.1–7.17.6). `inverf` is `Real.erfInv` and `inverfc x` is
   `Real.erfInv (1 − x)`. Prove 7.17.2 for `|x| < 1`, with the coefficients defined by the
   recursion 7.17.2_5 and the four printed coefficients as checks. Prove 7.17.3–7.17.6 as
   `x → 0+`, with `u`, `v` from 7.17.5–7.17.6, as an asymptotic expansion to the stated terms in
   the scale `u^{k−1/2}`.
2. **Repeated integrals** (DLMF 7.18.1–7.18.9, 7.18.13–7.18.14). `iⁿ erfc` is entire for each `n`.
   Prove:
   - 7.18.1–7.18.2, with the iterated-integral form along the horizontal ray;
   - 7.18.3–7.18.4;
   - 7.18.5 for `n ≥ 1`;
   - 7.18.6–7.18.7, with 7.18.7 at `n = 1` using `i⁻¹ erfc` written out;
   - 7.18.8 with `H_n` through `Polynomial.hermite`;
   - 7.18.9 with `𝐌`;
   - 7.18.13 for `Re z > 0`, via Milestone 4.1;
   - 7.18.14 in `|ph z| ≤ 3π/4 − δ`.
3. **Voigt functions** (DLMF 7.19.1–7.19.11). For `t > 0`: 7.19.3 with `z = (1 − ix)/(2√t)`;
   7.19.4 for `a > 0`; 7.19.5 as `t → 0+`; 7.19.6–7.19.9; and 7.19.10–7.19.11 for `a > 0` and
   real `u`.

*Needs:* Milestones 4, 11 and 13; AsymptoticExpansions 2; Tau Ceti `Real.erfInv`,
`hasDerivAt_erfInv`.

## Milestone 15: incomplete Beta functions

1. **Definition and normalization** (DLMF 8.17.1–8.17.6, 8.17.24). For `a, b > 0` and
   `0 ≤ x ≤ 1`:
   - `TauCeti.regularizedIncompleteBeta a b x = B_x(a, b)/B(a, b)` (8.17.2), with
     `ProbabilityTheory.beta`;
   - 8.17.3 is the definition of `ProbabilityTheory.beta`;
   - 8.17.4 is Tau Ceti's `regularizedIncompleteBeta_symm`, and is not restated;
   - 8.17.5 and 8.17.24 for positive integers `m`, `n` and `0 ≤ x < 1`, 8.17.24 as a convergent
     series;
   - 8.17.6 for `0 ≤ x ≤ ½`.
2. **Hypergeometric and integral representations** (DLMF 8.17.7–8.17.10). 8.17.7–8.17.8 for
   `0 ≤ x < 1`, and 8.17.9 for `0 ≤ x < ½` (where `|x/(x − 1)| < 1`), all with Mathlib's
   `ordinaryHypergeometric`. 8.17.10 for `0 < x < 1` and `x < c < 1`, as a vertical-line integral.
3. **Recurrences** (DLMF 8.17.11–8.17.21). All, for `a, b > 0` and `0 ≤ x ≤ 1`, with the parameters
   in each formula positive. 8.17.20 is Tau Ceti's `regularizedIncompleteBeta_add_one_left`, and
   is not restated.
4. **Continued fraction** (DLMF 8.17.22–8.17.23). Convergence for `0 ≤ x < 1`, via Milestone 4.1.
   DLMF's bracketing of the convergents is not owned; see
   [Beyond this roadmap](#beyond-this-roadmap-a-roadmap-for-a-roadmap-do-not-implement).
5. **Large `a`, fixed `b` and `x`** (DLMF 8.18.1). For each `n`, with the `O`-term uniform in `a`.
   For `b ∈ ℤ_{>0}` and `n ≥ b` the formula is exact.

*Needs:* Milestones 3.3 and 4.1; Tau Ceti `IncompleteBeta.lean` and `Beta.lean`; Mathlib
`ordinaryHypergeometric`, `ProbabilityTheory.beta`.

## Beyond this roadmap (a roadmap for a roadmap; do not implement)

The following material is the natural continuation. It is recorded only to fix the boundary.
Contributors should not attempt it under this roadmap.
- **Formulas through Kummer's second function `U` and Whittaker functions**: DLMF 6.11.2–6.11.3,
  7.11.5, 7.18.10, 8.5.3–8.5.5, 8.19.16. They belong to a confluent hypergeometric roadmap
  (DLMF Chapter 13).
- **Formulas through modified and spherical Bessel functions, Laguerre and Chebyshev
  polynomials**: DLMF 6.7.15–6.7.16, 6.10.4–6.10.8, 7.6.8–7.6.11, 8.6.6, 8.7.4–8.7.6,
  8.21.16–8.21.17. They belong to Bessel-function and orthogonal-polynomial roadmaps.
- **Relations to the parabolic cylinder functions**: DLMF 7.18.11–7.18.12. They belong to
  whichever of this roadmap and the parabolic cylinder roadmap is implemented second, since they
  need both `iⁿ erfc` and `U(a, z)`, `Hh_n`.
- **The continued Gauss function**: DLMF 8.14.5–8.14.6, 8.17.9 and 8.19.25 outside the unit disc
  of the hypergeometric argument. They belong to a hypergeometric roadmap (DLMF Chapter 15).
- **The Hurwitz zeta function at complex shift**: DLMF 8.15.2.
- **Uniform asymptotic expansions for large parameter**, which rest on the coalescence of a saddle
  point with a pole (beyond AsymptoticExpansions): DLMF §8.12 (8.12.1–8.12.22), §8.18(ii)
  (8.18.2–8.18.18), and the uniform approximations of Dunster and Paris cited there. Also
  excluded are the error bounds and exponentially improved extensions of 8.11.7 (Nemes), the
  extension of 8.11.7 to `−a`, `λ < 0`, and the inverse-function expansions of 8.12.21–8.12.22
  and 8.18.18.
- **Exponentially improved expansions and the Stokes phenomenon** for `E_p`, `erfc` and the
  auxiliary functions (DLMF §2.11(iii)–(v) applied to them; §§6.12, 7.12 references).
- **The bracketing of the incomplete Beta convergents** stated after DLMF 8.17.23. As printed
  (unconditionally for `a, b > 0`, `0 ≤ x ≤ 1`), it fails at large indices: for `a = 2.5`,
  `b = 3.3`, `x = 0.3` the convergents built from `d_1, …, d_n` exceed `I_x(a, b)` for every
  `n ≥ 5`, although half of them should lie below it. The range of indices for which it holds
  must be established before it can be specified.
- **The double zeros of `γ*(a, x)`** (DLMF Table 8.13.1) and their complex trajectories, and the
  `λ`-zeros of §8.13(ii).
- **Numerical tables of zeros** (DLMF Tables 7.13.1–7.13.4, the 30-digit values of `c₁`, `c₂` and
  `x₀`).
- **Number theory**: von Koch's theorem 6.16.5, `li(x) − π(x) = O(√x ln x)` under the Riemann
  hypothesis, for an analytic number theory roadmap.
- **Methods of computation, tables, approximations and software** (DLMF §§6.18–6.21, 7.22–7.25,
  8.25–8.28), including the recurrences 6.18.1–6.18.2 of Acton's algorithm; the applications
  sections §§6.17, 7.20(ii), 7.21, 8.23, 8.24; and the generalized error functions of §7.16, which
  are incomplete Gamma functions by a change of variable and have no numbered formulas.

## References

- NIST *Digital Library of Mathematical Functions*, Chapter 6 (N. M. Temme), Chapter 7
  (N. M. Temme) and Chapter 8 (R. B. Paris), <https://dlmf.nist.gov/6>,
  <https://dlmf.nist.gov/7>, <https://dlmf.nist.gov/8>; and
  [§2.5(ii)](https://dlmf.nist.gov/2.5#ii), [§2.11(ii)](https://dlmf.nist.gov/2.11#ii).
- F. W. J. Olver, *Asymptotics and Special Functions*, Academic Press, 1974, Chapters 2–3 and 9.
- N. M. Temme, *Special Functions: An Introduction to the Classical Functions of Mathematical
  Physics*, Wiley, 1996, Chapters 3 and 11.
- W. B. Jones and W. J. Thron, *Continued Fractions: Analytic Theory and Applications*,
  Addison-Wesley, 1980, Chapter 4 (Pincherle's theorem).
- W. Gautschi, Computational aspects of three-term recurrence relations, *SIAM Rev.* 9 (1967),
  24–82.
- F. G. Tricomi, Asymptotische Eigenschaften der unvollständigen Gammafunktion, *Math. Z.* 53
  (1950), 136–148.
- K. S. Kölbig, On the zeros of the incomplete gamma function, *Math. Comp.* 26 (1972), 751–756.
- A. J. MacLeod, Asymptotic expansions for the zeros of certain special functions, *J. Comput.
  Appl. Math.* 145 (2002), 261–267.
