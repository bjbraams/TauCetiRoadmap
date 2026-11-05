import Mathlib
import TauCeti.Analysis.SpecialFunctions.Erf
import TauCeti.Analysis.SpecialFunctions.IncompleteGamma
import TauCeti.Analysis.SpecialFunctions.IncompleteBeta
import TauCeti.Analysis.SpecialFunctions.LogIntegral

/-!
# Exponential, logarithmic, error and incomplete Gamma functions: suggested target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a milestone nor the roadmap.

The definitions below are roadmap-local copies of the definitions `README.md` pins, with their
intended bodies, so that the conventions are checked by the compiler. A name `Complex.f`,
`Real.f` or `f` here stands for the target `TauCeti.Complex.f`, `TauCeti.Real.f` or
`TauCeti.f`. The pinned conventions visible here are: Mathlib's regularized hypergeometric
function `Complex.regularizedHGFun` for Tricomi's `γ*`; the ray integral for `Γ(a, z)`; the
logarithmic coordinate `w` (with `z = exp w`) for continuation beyond the principal sheet;
segment integrals over `[0, 1]` for the entire functions; principal complex powers; and
asymptotic statements written out with `IsBigO` along the filters of the AsymptoticExpansions
roadmap. Theorems are stated with `sorry` (allowed in this human-owned roadmap library).
-/

noncomputable section

namespace TauCetiRoadmap.SpecialFunctionsEiLiErfIncompleteGamma

open Complex Filter Topology Asymptotics Set MeasureTheory Finset
open scoped Real Nat

/-- The logarithmic-coordinate filter "`z = exp w → ∞` in `|ph z| ≤ θ`", for any `θ > 0`. -/
local notation "logSectorAtTop " θ =>
  Filter.comap Complex.re atTop ⊓ 𝓟 (Set.ofPred fun w : ℂ => |Complex.im w| ≤ θ)

/-! ## Definitions: incomplete Gamma functions (Milestone 1) -/

namespace Complex

/-- Tricomi's entire incomplete Gamma function `γ*(a, z) = e^{−z} 𝐌(1, a + 1, z)`
(DLMF 8.5.2), entire in both variables. -/
def tricomiIncompleteGamma (a z : ℂ) : ℂ :=
  cexp (-z) * Complex.regularizedHGFun ({1} : Multiset ℂ) ({a + 1} : Multiset ℂ) z

/-- The regularized lower incomplete Gamma function `P(a, z) = z^a γ*(a, z)` (DLMF 8.2.6), with
the principal power. It is entire in `a` for fixed `z ≠ 0`. -/
def regularizedGamma (a z : ℂ) : ℂ :=
  z ^ a * tricomiIncompleteGamma a z

/-- The regularized upper incomplete Gamma function `Q(a, z) = 1 − P(a, z)` (DLMF 8.2.5). -/
def regularizedGammaQ (a z : ℂ) : ℂ :=
  1 - regularizedGamma a z

/-- The lower incomplete Gamma function `γ(a, z) = Γ(a) P(a, z)` (DLMF 8.2.4). At the poles
`a ∈ −ℕ` it takes Mathlib's junk value of `Γ`. -/
def lowerIncompleteGamma (a z : ℂ) : ℂ :=
  Complex.Gamma a * regularizedGamma a z

/-- The upper incomplete Gamma function `Γ(a, z) = e^{−z} ∫₀^∞ (z + t)^{a−1} e^{−t} dt`: the
integral 8.2.2 along the horizontal ray from `z`. On `slitPlane` it is the principal value;
on the cut it is a junk value, and statements are made only on `slitPlane` or through
`upperIncompleteGammaLog`. -/
def upperIncompleteGamma (a z : ℂ) : ℂ :=
  cexp (-z) * ∫ t in Ioi (0 : ℝ), (z + t) ^ (a - 1) * cexp (-(t : ℂ))

/-- `Γ(a, e^w)` on the logarithmic plane, continued from the positive axis along the vertical
segment from `Re w` to `w`, on which `d/du Γ(a, e^u) = −e^{au − e^u}`. It is entire in `a`
and in `w`. -/
def upperIncompleteGammaLog (a w : ℂ) : ℂ :=
  upperIncompleteGamma a (Real.exp w.re) -
    ∫ s in (0 : ℝ)..1, I * w.im *
      cexp (a * ((w.re : ℂ) + I * ((s * w.im : ℝ) : ℂ)) -
        cexp ((w.re : ℂ) + I * ((s * w.im : ℝ) : ℂ)))

/-! ## Definitions: error functions (Milestone 11) -/

/-- The error function `erf z = (2/√π) ∫₀^z e^{−t²} dt` (DLMF 7.2.1), along the segment. -/
def erf (z : ℂ) : ℂ :=
  2 / (Real.sqrt π : ℂ) * ∫ s in (0 : ℝ)..1, z * cexp (-((s : ℂ) * z) ^ 2)

/-- The complementary error function `erfc z = 1 − erf z` (DLMF 7.2.2). -/
def erfc (z : ℂ) : ℂ :=
  1 - erf z

end Complex

/-- The Faddeeva function `w(z) = e^{−z²} erfc(−iz)` (DLMF 7.2.3). -/
def faddeeva (z : ℂ) : ℂ :=
  cexp (-z ^ 2) * Complex.erfc (-I * z)

/-- Dawson's integral `F(z) = e^{−z²} ∫₀^z e^{t²} dt` (DLMF 7.2.5), with the body of the
parabolic cylinder roadmap's `TauCeti.dawson`. -/
def dawson (z : ℂ) : ℂ :=
  cexp (-z ^ 2) * ∫ s in (0 : ℝ)..1, z * cexp (((s : ℂ) * z) ^ 2)

/-- The Fresnel integral `C(z) = ∫₀^z cos(πt²/2) dt` (DLMF 7.2.7). -/
def fresnelC (z : ℂ) : ℂ :=
  ∫ s in (0 : ℝ)..1, z * Complex.cos (π * ((s : ℂ) * z) ^ 2 / 2)

/-- The Fresnel integral `S(z) = ∫₀^z sin(πt²/2) dt` (DLMF 7.2.8). -/
def fresnelS (z : ℂ) : ℂ :=
  ∫ s in (0 : ℝ)..1, z * Complex.sin (π * ((s : ℂ) * z) ^ 2 / 2)

/-- The Fresnel tail `ℱ(z) = ∫_z^∞ e^{πit²/2} dt`, through DLMF 7.5.2. -/
def fresnelTail (z : ℂ) : ℂ :=
  (1 + I) / 2 - (fresnelC z + I * fresnelS z)

/-- The Fresnel auxiliary function `f(z)` (DLMF 7.2.10). -/
def fresnelAuxF (z : ℂ) : ℂ :=
  (1 / 2 - fresnelS z) * Complex.cos (π * z ^ 2 / 2) -
    (1 / 2 - fresnelC z) * Complex.sin (π * z ^ 2 / 2)

/-- The Fresnel auxiliary function `g(z)` (DLMF 7.2.11). -/
def fresnelAuxG (z : ℂ) : ℂ :=
  (1 / 2 - fresnelC z) * Complex.cos (π * z ^ 2 / 2) +
    (1 / 2 - fresnelS z) * Complex.sin (π * z ^ 2 / 2)

/-- The Goodwin–Staton integral `G(z) = ∫₀^∞ e^{−t²}/(t + z) dt` (DLMF 7.2.12), meaningful on
`slitPlane`. -/
def goodwinStaton (z : ℂ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), cexp (-(t : ℂ) ^ 2) / (t + z)

/-- The repeated integrals `iⁿ erfc(z) = (2/√π) ∫₀^∞ tⁿ/n! e^{−(z+t)²} dt` (DLMF 7.18.2), for
`n : ℕ`; `i⁻¹ erfc(z) = (2/√π) e^{−z²}` is written out where it occurs. -/
def iteratedErfc (n : ℕ) (z : ℂ) : ℂ :=
  2 / (Real.sqrt π : ℂ) * ∫ t in Ioi (0 : ℝ), (t : ℂ) ^ n / (n ! : ℂ) * cexp (-(z + t) ^ 2)

/-! ## Definitions: exponential, sine and cosine integrals (Milestones 7–10) -/

/-- The generalized exponential integral `E_p(z) = z^{p−1} Γ(1 − p, z)` (DLMF 8.19.1). -/
def expIntegralE (p z : ℂ) : ℂ :=
  z ^ (p - 1) * Complex.upperIncompleteGamma (1 - p) z

/-- `E_p(e^w)` on the logarithmic plane. -/
def expIntegralELog (p w : ℂ) : ℂ :=
  cexp ((p - 1) * w) * Complex.upperIncompleteGammaLog (1 - p) w

/-- The entire function `Ein(z) = ∫₀^z (1 − e^{−t})/t dt` (DLMF 6.2.3). -/
def expIntegralEin (z : ℂ) : ℂ :=
  ∫ s in (0 : ℝ)..1, (1 - cexp (-(z * s))) / s

/-- The sine integral `Si(z) = ∫₀^z sin t / t dt` (DLMF 6.2.9). -/
def sinIntegral (z : ℂ) : ℂ :=
  ∫ s in (0 : ℝ)..1, Complex.sin (z * s) / s

/-- `si(z) = Si(z) − π/2` (DLMF 6.2.10). -/
def sinIntegralTail (z : ℂ) : ℂ :=
  sinIntegral z - π / 2

/-- The entire function `Cin(z) = ∫₀^z (1 − cos t)/t dt` (DLMF 6.2.12). -/
def cosIntegralCin (z : ℂ) : ℂ :=
  ∫ s in (0 : ℝ)..1, (1 - Complex.cos (z * s)) / s

/-- The principal cosine integral `Ci(z) = −Cin(z) + ln z + γ` (DLMF 6.2.13). -/
def cosIntegral (z : ℂ) : ℂ :=
  -cosIntegralCin z + Complex.log z + Real.eulerMascheroniConstant

/-- The hyperbolic sine integral `Shi(z)` (DLMF 6.2.15). -/
def sinhIntegral (z : ℂ) : ℂ :=
  ∫ s in (0 : ℝ)..1, Complex.sinh (z * s) / s

/-- The principal hyperbolic cosine integral `Chi(z)` (DLMF 6.2.16). -/
def coshIntegral (z : ℂ) : ℂ :=
  Real.eulerMascheroniConstant + Complex.log z +
    ∫ s in (0 : ℝ)..1, (Complex.cosh (z * s) - 1) / s

/-- The auxiliary function `f(z) = Ci(z) sin z − si(z) cos z` (DLMF 6.2.17). -/
def sinIntegralAuxF (z : ℂ) : ℂ :=
  cosIntegral z * Complex.sin z - sinIntegralTail z * Complex.cos z

/-- The auxiliary function `g(z) = −Ci(z) cos z − si(z) sin z` (DLMF 6.2.18). -/
def sinIntegralAuxG (z : ℂ) : ℂ :=
  -cosIntegral z * Complex.cos z - sinIntegralTail z * Complex.sin z

/-- The generalized sine integral `Si(a, z)` by its power series (DLMF 8.21.14). -/
def generalizedSinIntegral (a z : ℂ) : ℂ :=
  z ^ a * ∑' k : ℕ, (-1 : ℂ) ^ k * z ^ (2 * k + 1) / ((2 * k + a + 1) * ((2 * k + 1)! : ℂ))

/-- The generalized cosine integral `Ci(a, z)` by its power series (DLMF 8.21.15). -/
def generalizedCosIntegral (a z : ℂ) : ℂ :=
  z ^ a * ∑' k : ℕ, (-1 : ℂ) ^ k * z ^ (2 * k) / ((2 * k + a) * ((2 * k)! : ℂ))

/-- The generalized tail sine integral `si(a, z)` (DLMF 8.21.1), principal value. -/
def generalizedSinIntegralTail (a z : ℂ) : ℂ :=
  (cexp (π * I * a / 2) * Complex.upperIncompleteGammaLog a (Complex.log z - π * I / 2) -
    cexp (-(π * I * a / 2)) * Complex.upperIncompleteGammaLog a (Complex.log z + π * I / 2)) /
      (2 * I)

/-- The generalized tail cosine integral `ci(a, z)` (DLMF 8.21.1), principal value. -/
def generalizedCosIntegralTail (a z : ℂ) : ℂ :=
  (cexp (π * I * a / 2) * Complex.upperIncompleteGammaLog a (Complex.log z - π * I / 2) +
    cexp (-(π * I * a / 2)) * Complex.upperIncompleteGammaLog a (Complex.log z + π * I / 2)) / 2

namespace Real

/-- The exponential integral `Ei(x)` for real `x ≠ 0`, through DLMF 6.2.7; at `x = 0` the value
is junk. -/
def expIntegralEi (x : ℝ) : ℝ :=
  Real.eulerMascheroniConstant + Real.log |x| - (expIntegralEin (-x : ℂ)).re

/-- DLMF's logarithmic integral `li(x) = Ei(ln x)` (DLMF 6.2.8), the principal value
`⨍₀^x dt / ln t`. It differs from Tau Ceti's offset `TauCeti.Real.logIntegral` by `li(2)`. -/
def principalLogIntegral (x : ℝ) : ℝ :=
  expIntegralEi (Real.log x)

/-- The Voigt function `𝖴(x, t)` for `t > 0` (DLMF 7.19.1). -/
def voigtU (x t : ℝ) : ℝ :=
  1 / Real.sqrt (4 * π * t) * ∫ y : ℝ, Real.exp (-(x - y) ^ 2 / (4 * t)) / (1 + y ^ 2)

/-- The Voigt function `𝖵(x, t)` for `t > 0` (DLMF 7.19.2). -/
def voigtV (x t : ℝ) : ℝ :=
  1 / Real.sqrt (4 * π * t) * ∫ y : ℝ, y * Real.exp (-(x - y) ^ 2 / (4 * t)) / (1 + y ^ 2)

/-- The line-broadening function `H(a, u)` for `a > 0` (DLMF 7.19.4). -/
def voigtH (a u : ℝ) : ℝ :=
  a / π * ∫ t : ℝ, Real.exp (-t ^ 2) / ((u - t) ^ 2 + a ^ 2)

end Real

/-- The incomplete Beta function `B_x(a, b) = ∫₀^x t^{a−1}(1−t)^{b−1} dt` (DLMF 8.17.1), for
`a, b > 0` and `0 ≤ x ≤ 1`. -/
def incompleteBeta (a b x : ℝ) : ℝ :=
  ∫ t in (0 : ℝ)..x, t ^ (a - 1) * (1 - t) ^ (b - 1)

/-! ## Milestone 1: incomplete Gamma, definitions and continuation -/

open Complex in
/-- **M1.1** `γ*` is entire in `z`. -/
theorem differentiable_tricomiIncompleteGamma_right (a : ℂ) :
    Differentiable ℂ (tricomiIncompleteGamma a) := sorry

open Complex in
/-- **M1.1** `γ*` is entire in `a`. -/
theorem differentiable_tricomiIncompleteGamma_left (z : ℂ) :
    Differentiable ℂ fun a => tricomiIncompleteGamma a z := sorry

open Complex in
/-- **M1.1** The first series of DLMF 8.7.1, valid for all `a`. -/
theorem hasSum_tricomiIncompleteGamma (a z : ℂ) :
    HasSum (fun k : ℕ => cexp (-z) * z ^ k * (Complex.Gamma (a + k + 1))⁻¹)
      (tricomiIncompleteGamma a z) := sorry

open Complex in
/-- **M1.1** `γ*(−n, z) = zⁿ` (DLMF 8.4.12). -/
theorem tricomiIncompleteGamma_neg_natCast (n : ℕ) (z : ℂ) :
    tricomiIncompleteGamma (-n) z = z ^ n := sorry

open Complex in
/-- **M1.1** The differential equation DLMF 8.2.14. -/
theorem tricomiIncompleteGamma_ode (a z : ℂ) :
    z * deriv (deriv (tricomiIncompleteGamma a)) z +
      (a + 1 + z) * deriv (tricomiIncompleteGamma a) z + a * tricomiIncompleteGamma a z = 0 :=
  sorry

open Complex in
/-- **M1.2** The integral DLMF 8.2.1 along the segment from `0` to `z`. -/
theorem lowerIncompleteGamma_eq_integral {a : ℂ} (ha : 0 < a.re) (z : ℂ) :
    lowerIncompleteGamma a z =
      z ^ a * ∫ s in (0 : ℝ)..1, (s : ℂ) ^ (a - 1) * cexp (-(z * s)) := sorry

open Complex in
/-- **M1.2** The simple poles of `γ(·, z)` at `a = −n`, with residue `(−1)ⁿ/n!`. -/
theorem tendsto_mul_lowerIncompleteGamma (n : ℕ) {z : ℂ} (hz : z ≠ 0) :
    Tendsto (fun a => (a + n) * lowerIncompleteGamma a z) (𝓝[≠] (-n : ℂ))
      (𝓝 ((-1) ^ n / (n ! : ℂ))) := sorry

open Complex in
/-- **M1.3** `Γ(a, z)` is entire in `a` on the slit plane. -/
theorem differentiable_upperIncompleteGamma_left {z : ℂ} (hz : z ∈ slitPlane) :
    Differentiable ℂ fun a => upperIncompleteGamma a z := sorry

open Complex in
/-- **M1.3** DLMF 8.2.3. -/
theorem upperIncompleteGamma_add_lowerIncompleteGamma {a z : ℂ} (ha : ∀ n : ℕ, a ≠ -n)
    (hz : z ∈ slitPlane) :
    upperIncompleteGamma a z + lowerIncompleteGamma a z = Complex.Gamma a := sorry

open Complex in
/-- **M1.3** DLMF 8.2.2 on the positive axis. -/
theorem upperIncompleteGamma_ofReal {x : ℝ} (hx : 0 < x) (a : ℂ) :
    upperIncompleteGamma a x = ∫ t in Ioi x, (t : ℂ) ^ (a - 1) * cexp (-(t : ℂ)) := sorry

open Complex in
/-- **M1.4** The complex lower incomplete Gamma function restricts to Tau Ceti's. -/
theorem lowerIncompleteGamma_ofReal {s x : ℝ} (hs : 0 < s) (hx : 0 ≤ x) :
    lowerIncompleteGamma s x = (TauCeti.lowerIncompleteGamma s x : ℂ) := sorry

open Complex in
/-- **M1.4** The complex `P` restricts to Tau Ceti's `regularizedGamma`. -/
theorem regularizedGamma_ofReal {s x : ℝ} (hs : 0 < s) (hx : 0 ≤ x) :
    regularizedGamma s x = (TauCeti.regularizedGamma s x : ℂ) := sorry

open Complex in
/-- **M1.5** The logarithmic continuation is entire in `w`. -/
theorem differentiable_upperIncompleteGammaLog (a : ℂ) :
    Differentiable ℂ (upperIncompleteGammaLog a) := sorry

open Complex in
/-- **M1.5** On the principal sheet it is the principal value. -/
theorem upperIncompleteGammaLog_log {z : ℂ} (hz : z ∈ slitPlane) (a : ℂ) :
    upperIncompleteGammaLog a (Complex.log z) = upperIncompleteGamma a z := sorry

open Complex in
/-- **M1.5** DLMF 8.2.9 away from the poles of `Γ`. -/
theorem upperIncompleteGammaLog_add_two_pi_mul_I {a : ℂ} (ha : ∀ n : ℕ, a ≠ -n) (w : ℂ)
    (m : ℤ) :
    upperIncompleteGammaLog a (w + 2 * π * I * m) =
      cexp (2 * π * I * m * a) * upperIncompleteGammaLog a w +
        (1 - cexp (2 * π * I * m * a)) * Complex.Gamma a := sorry

open Complex in
/-- **M1.5** DLMF 8.2.9 at `a = −n`, the limiting form. -/
theorem upperIncompleteGammaLog_neg_natCast_add_two_pi_mul_I (n : ℕ) (w : ℂ) (m : ℤ) :
    upperIncompleteGammaLog (-n) (w + 2 * π * I * m) =
      upperIncompleteGammaLog (-n) w - 2 * π * I * m * (-1) ^ n / (n ! : ℂ) := sorry

open Complex in
/-- **M1.5** DLMF 8.2.11 (upper sign). -/
theorem upperIncompleteGammaLog_log_add_pi_mul_I {a : ℂ} (ha : ∀ n : ℕ, a ≠ -n) {z : ℂ}
    (hz : z ≠ 0) :
    upperIncompleteGammaLog a (Complex.log z + π * I) =
      Complex.Gamma a * (1 - z ^ a * cexp (π * I * a) * tricomiIncompleteGamma a (-z)) := sorry

/-! ## Milestones 2–3: special values, series, recurrences and derivatives -/

open Complex in
/-- **M2.1** DLMF 8.4.8, for every `z`. -/
theorem upperIncompleteGamma_natCast_add_one (n : ℕ) (z : ℂ) :
    upperIncompleteGamma (n + 1) z =
      n ! * cexp (-z) * ∑ k ∈ range (n + 1), z ^ k / (k ! : ℂ) := sorry

open Complex in
/-- **M2.4** DLMF 8.8.2. -/
theorem upperIncompleteGamma_add_one {z : ℂ} (hz : z ∈ slitPlane) (a : ℂ) :
    upperIncompleteGamma (a + 1) z = a * upperIncompleteGamma a z + z ^ a * cexp (-z) := sorry

open Complex in
/-- **M2.5** DLMF 8.8.13. -/
theorem hasDerivAt_upperIncompleteGamma {z : ℂ} (hz : z ∈ slitPlane) (a : ℂ) :
    HasDerivAt (upperIncompleteGamma a) (-(z ^ (a - 1) * cexp (-z))) z := sorry

/-! ## Milestone 4: continued fractions and inequalities -/

open Complex in
/-- **M4.1** The continued fraction DLMF 8.9.2, as a Mathlib `GenContFract` with head `0`,
partial numerators `z⁻¹, (1 − a)z⁻¹, z⁻¹, (2 − a)z⁻¹, 2z⁻¹, …` and partial denominators `1`. -/
theorem tendsto_convs_upperIncompleteGamma (a : ℂ) {z : ℂ} (hz : z ∈ slitPlane) :
    Tendsto
      (⟨0, Stream'.Seq.ofStream fun n : ℕ =>
        ⟨(if n = 0 then 1 else if Odd n then (((n + 1) / 2 : ℕ) : ℂ) - a
          else ((n / 2 : ℕ) : ℂ)) * z⁻¹, 1⟩⟩ : GenContFract ℂ).convs
      atTop (𝓝 (z ^ (-a) * cexp z * upperIncompleteGamma a z)) := sorry

open Complex in
/-- **M4.2** DLMF 8.10.1. -/
theorem upperIncompleteGamma_bound {a x : ℝ} (ha : 0 < a) (ha1 : a ≤ 1) (hx : 0 < x) :
    x ^ (1 - a) * Real.exp x * (upperIncompleteGamma a x).re ≤ 1 := sorry

/-! ## Milestone 5: asymptotics of the incomplete Gamma functions -/

open Complex in
/-- **M5.1** DLMF 8.11.2–8.11.3 in `|ph z| ≤ 3π/2 − δ`, in logarithmic coordinates `z = e^w`:
`z^{1−a} e^z Γ(a, z) − ∑_{k<n} u_k z^{−k} = O(z^{−n})` with `u_k = (a − 1)(a − 2)⋯(a − k)`. -/
theorem upperIncompleteGammaLog_isBigO (a : ℂ) (n : ℕ) {δ : ℝ} (hδ : 0 < δ) :
    (fun w => cexp ((1 - a) * w + cexp w) * upperIncompleteGammaLog a w -
        ∑ k ∈ range n, (descPochhammer ℂ k).eval (a - 1) * cexp (-(k * w)))
      =O[logSectorAtTop (3 * π / 2 - δ)] fun w => cexp (-(n * w)) := sorry

/-! ## Milestone 7: the generalized exponential integral -/

/-- **M7.1** DLMF 8.19.3. -/
theorem expIntegralE_eq_integral (p : ℂ) {z : ℂ} (hz : 0 < z.re) :
    expIntegralE p z = ∫ t in Ioi (1 : ℝ), cexp (-(z * t)) / (t : ℂ) ^ p := sorry

/-- **M7.2** DLMF 8.19.12. -/
theorem expIntegralE_add_one (p : ℂ) {z : ℂ} (hz : z ∈ slitPlane) :
    p * expIntegralE (p + 1) z + z * expIntegralE p z = cexp (-z) := sorry

/-- **M7.3** DLMF 8.19.18. -/
theorem expIntegralELog_add_two_pi_mul_I {p : ℂ} (hp : ∀ n : ℕ, p ≠ n + 1) (w : ℂ) (m : ℤ) :
    expIntegralELog p (w + 2 * π * I * m) =
      2 * π * I * cexp (m * p * π * I) / Complex.Gamma p *
          (Complex.sin (m * p * π) / Complex.sin (p * π)) * cexp ((p - 1) * w) +
        expIntegralELog p w := sorry

open Complex in
/-- **M7.3** DLMF 8.8.14. -/
theorem deriv_tricomiIncompleteGamma_left_zero {z : ℂ} (hz : z ∈ slitPlane) :
    deriv (fun a => tricomiIncompleteGamma a z) 0 = -expIntegralE 1 z - Complex.log z := sorry

/-! ## Milestone 8: exponential and logarithmic integrals -/

/-- **M8.1** DLMF 6.2.4. -/
theorem expIntegralE_one {z : ℂ} (hz : z ∈ slitPlane) :
    expIntegralE 1 z = expIntegralEin z - Complex.log z - Real.eulerMascheroniConstant := sorry

/-- **M8.2** DLMF 6.2.5 as a principal value. -/
theorem tendsto_expIntegralEi {x : ℝ} (hx : 0 < x) :
    Tendsto (fun ε => (∫ t in Iic (-ε), Real.exp t / t) + ∫ t in ε..x, Real.exp t / t)
      (𝓝[>] 0) (𝓝 (Real.expIntegralEi x)) := sorry

/-- **M8.2** The two logarithmic integrals. -/
theorem logIntegral_eq_principalLogIntegral_sub {x : ℝ} (hx : 1 < x) :
    TauCeti.Real.logIntegral x = Real.principalLogIntegral x - Real.principalLogIntegral 2 :=
  sorry

/-- **M8.4** DLMF 6.12.2: `x e^{−x} Ei(x) − ∑_{k<n} k!/x^k = O(x^{−n})`. -/
theorem expIntegralEi_isBigO (n : ℕ) :
    (fun x => x * Real.exp (-x) * Real.expIntegralEi x - ∑ k ∈ range n, (k ! : ℝ) / x ^ k)
      =O[atTop] fun x => (x ^ n)⁻¹ := sorry

/-- **M8.5** DLMF 6.13.1: the unique positive zero of `Ei`, to ten digits. -/
theorem existsUnique_expIntegralEi_eq_zero :
    ∃! x : ℝ, 0 < x ∧ Real.expIntegralEi x = 0 ∧ 0.3725074107 < x ∧ x < 0.3725074108 := sorry

/-! ## Milestone 9: sine and cosine integrals -/

/-- **M9.1** DLMF 6.2.14. -/
theorem tendsto_sinIntegral_atTop :
    Tendsto (fun x : ℝ => sinIntegral x) atTop (𝓝 (π / 2)) := sorry

/-- **M9.2** DLMF 6.5.5. -/
theorem sinIntegral_eq_expIntegralE {z : ℂ} (hz : 0 < z.re) :
    sinIntegral z = I / 2 * (expIntegralE 1 (-I * z) - expIntegralE 1 (I * z)) + π / 2 := sorry

/-! ## Milestone 10: generalized sine and cosine integrals -/

/-- **M10.1** DLMF 8.21.6 on the positive axis. -/
theorem generalizedSinIntegral_ofReal {a : ℂ} (ha : -1 < a.re) {x : ℝ} (hx : 0 < x) :
    generalizedSinIntegral a x = ∫ t in (0 : ℝ)..x, (t : ℂ) ^ (a - 1) * Complex.sin t := sorry

/-- **M10.1** DLMF 8.21.8 away from the poles of `Γ`; at `a = −2n` the right side is replaced
by its limiting value, stated separately. -/
theorem generalizedSinIntegral_add_tail {a : ℂ} (ha : ∀ n : ℕ, a ≠ -n) {z : ℂ}
    (hz : z ∈ slitPlane) :
    generalizedSinIntegral a z + generalizedSinIntegralTail a z =
      Complex.Gamma a * Complex.sin (π * a / 2) := sorry

/-! ## Milestone 11: error functions, definitions and elementary properties -/

open Complex in
/-- **M11.1** The complex error function restricts to Tau Ceti's real one. -/
theorem erf_ofReal (x : ℝ) : erf x = (TauCeti.Real.erf x : ℂ) := sorry

open Complex in
/-- **M11.1** `erf` is entire. -/
theorem differentiable_erf : Differentiable ℂ erf := sorry

open Complex in
/-- **M11.2** DLMF 7.6.1. -/
theorem hasSum_erf (z : ℂ) :
    HasSum (fun n : ℕ => 2 / (Real.sqrt π : ℂ) * (-1) ^ n * z ^ (2 * n + 1) /
      ((n ! : ℂ) * (2 * n + 1))) (erf z) := sorry

open Complex in
/-- **M11.3** DLMF 7.11.1, in the half-plane where `(z²)^{1/2} = z`. -/
theorem erf_eq_lowerIncompleteGamma {z : ℂ} (hz : 0 < z.re) :
    erf z = lowerIncompleteGamma (1 / 2) (z ^ 2) / (Real.sqrt π : ℂ) := sorry

open Complex in
/-- **M11.3** The entire form of DLMF 7.11.1: `erf z = z γ*(½, z²)`. -/
theorem erf_eq_mul_tricomiIncompleteGamma (z : ℂ) :
    erf z = z * tricomiIncompleteGamma (1 / 2) (z ^ 2) := sorry

/-- **M11.4** DLMF 7.10.2. -/
theorem hasDerivAt_faddeeva (z : ℂ) :
    HasDerivAt faddeeva (-2 * z * faddeeva z + 2 * I / (Real.sqrt π : ℂ)) z := sorry

/-- **M11.4** DLMF 7.5.1. -/
theorem dawson_eq_faddeeva (z : ℂ) :
    dawson z = I * (Real.sqrt π : ℂ) / 2 * (cexp (-z ^ 2) - faddeeva z) := sorry

/-- **M11.5** DLMF 7.5.8 (upper signs). -/
theorem fresnelC_add_I_mul_fresnelS (z : ℂ) :
    fresnelC z + I * fresnelS z =
      (1 + I) / 2 * Complex.erf ((Real.sqrt π : ℂ) * (1 - I) / 2 * z) := sorry

/-- **M11.5** The Fresnel integrals are real on the real line. -/
theorem fresnelC_ofReal_im (x : ℝ) : (fresnelC x).im = 0 := sorry

/-- **M11.5** DLMF 7.2.9. -/
theorem tendsto_fresnelC_atTop : Tendsto (fun x : ℝ => (fresnelC x).re) atTop (𝓝 (1 / 2)) :=
  sorry

/-! ## Milestone 12: integral representations, inequalities and integrals of error functions -/

/-- **M12.1** DLMF 7.7.2. -/
theorem faddeeva_eq_integral {z : ℂ} (hz : 0 < z.im) :
    faddeeva z = 1 / (π * I) * ∫ t : ℝ, cexp (-(t : ℂ) ^ 2) / (t - z) := sorry

/-- **M12.2** DLMF 7.8.2, with Mills' ratio written out as `(√π/2) e^{x²} erfc x`. -/
theorem millsRatio_bounds {x : ℝ} (hx : 0 ≤ x) :
    1 / (x + Real.sqrt (x ^ 2 + 2)) < Real.sqrt π / 2 * Real.exp (x ^ 2) * TauCeti.Real.erfc x ∧
      Real.sqrt π / 2 * Real.exp (x ^ 2) * TauCeti.Real.erfc x ≤
        1 / (x + Real.sqrt (x ^ 2 + 4 / π)) := sorry

/-! ## Milestone 13: asymptotics and zeros of error functions -/

open Complex in
/-- **M13.1** DLMF 7.12.1 in `|ph z| ≤ 3π/4 − δ`, in logarithmic coordinates `z = e^w`. -/
theorem erfc_isBigO (n : ℕ) {δ : ℝ} (hδ : 0 < δ) :
    (fun w => (Real.sqrt π : ℂ) * cexp (w + cexp (2 * w)) * erfc (cexp w) -
        ∑ m ∈ range n, (-1) ^ m * (ascPochhammer ℂ m).eval (1 / 2) * cexp (-(2 * m * w)))
      =O[logSectorAtTop (3 * π / 4 - δ)] fun w => cexp (-(2 * n * w)) := sorry

open Complex in
/-- **M13.2** `erf` has infinitely many zeros in the open first quadrant (DLMF §7.13(i)). -/
theorem infinite_erf_zeros_firstQuadrant :
    (Set.ofPred fun z : ℂ => erf z = 0 ∧ 0 < z.re ∧ 0 < z.im).Infinite := sorry

/-! ## Milestone 14: inverse error functions, repeated integrals, Voigt functions -/

/-- **M14.1** DLMF 7.17.2–7.17.2_5: `erfInv x = ∑ a_m t^{2m+1}` with `t = √π x/2` for
`|x| < 1`, where `a` is the recursion of DLMF 7.17.2_5. -/
theorem hasSum_erfInv (a : ℕ → ℝ) (ha0 : a 0 = 1)
    (ha : ∀ m, a (m + 1) = 1 / (2 * m + 3) *
      ∑ n ∈ range (m + 1), (2 * n + 1) / (m - n + 1) * a n * a (m - n))
    {x : ℝ} (hx : |x| < 1) :
    HasSum (fun m => a m * (Real.sqrt π / 2 * x) ^ (2 * m + 1)) (Real.erfInv x) := sorry

/-- **M14.2** DLMF 7.18.7 for `n ≥ 2`. -/
theorem iteratedErfc_add_two (n : ℕ) (z : ℂ) :
    iteratedErfc (n + 2) z =
      -(z / (n + 2)) * iteratedErfc (n + 1) z + 1 / (2 * (n + 2)) * iteratedErfc n z := sorry

/-- **M14.3** DLMF 7.19.3. -/
theorem voigt_eq_erfc (x : ℝ) {t : ℝ} (ht : 0 < t) :
    (Real.voigtU x t : ℂ) + I * Real.voigtV x t =
      (Real.sqrt (π / (4 * t)) : ℂ) * cexp (((1 - I * x) / (2 * Real.sqrt t)) ^ 2) *
        Complex.erfc ((1 - I * x) / (2 * Real.sqrt t)) := sorry

/-! ## Milestone 15: incomplete Beta functions -/

/-- **M15.1** DLMF 8.17.2 with Tau Ceti's `regularizedIncompleteBeta`. -/
theorem regularizedIncompleteBeta_eq_incompleteBeta {a b x : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hx0 : 0 ≤ x) (hx1 : x ≤ 1) :
    TauCeti.regularizedIncompleteBeta a b x = incompleteBeta a b x / ProbabilityTheory.beta a b :=
  sorry

/-- **M15.2** DLMF 8.17.7 with Mathlib's `ordinaryHypergeometric`. -/
theorem incompleteBeta_eq_hypergeometric {a b x : ℝ} (ha : 0 < a) (hb : 0 < b) (hx0 : 0 ≤ x)
    (hx1 : x < 1) :
    incompleteBeta a b x = x ^ a / a * ordinaryHypergeometric a (1 - b) (a + 1) x := sorry

/-- **M15.3** DLMF 8.17.5. -/
theorem regularizedIncompleteBeta_natCast {m n : ℕ} (hm : 0 < m) (hmn : m ≤ n) {x : ℝ}
    (hx0 : 0 ≤ x) (hx1 : x < 1) :
    TauCeti.regularizedIncompleteBeta m (n - m + 1) x =
      ∑ j ∈ Icc m n, (n.choose j : ℝ) * x ^ j * (1 - x) ^ (n - j) := sorry

end TauCetiRoadmap.SpecialFunctionsEiLiErfIncompleteGamma
