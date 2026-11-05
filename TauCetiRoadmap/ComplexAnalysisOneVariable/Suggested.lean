/-
Copyright (c) 2026 Bastiaan J Braams. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Bastiaan J Braams
-/
module

public import Mathlib
public import TauCeti.Analysis.Contour.Cycle.Basic

/-!
# Complex analysis of one variable: suggested target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The sixteen theorems below are the principal targets 1–16 of `README.md`, with the same numbers
and names. They cover integration and isolated singularities, Runge approximation and
Mittag–Leffler, infinite products and factorization, and the Koebe theorems for univalent
functions. The theorem proofs are intentionally left as `sorry`.

Cycles, cycle integrals and winding numbers are Tau Ceti's native ones from
`TauCeti.Analysis.Contour.Cycle.Basic`: a cycle is an element of the free abelian group on closed
piecewise-`C¹` curves, and `TauCeti.Contour.Cycle.integral f C` integrates `deriv γ t • f (γ t)`
over each generator. The definitions in this file are the new objects of the roadmap: the
Banach-valued residue, circle Laurent coefficients, Runge generators, elementary factors and
their products, the order bound for entire functions, and Blaschke factors and products.
-/

@[expose] public noncomputable section

open Set Filter MeasureTheory
open scoped Topology ComplexConjugate

namespace TauCetiRoadmap.ComplexAnalysisOneVariable

section BanachDefinitions
variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]

/-- The residue at `c`, as the limit of normalized circle integrals over shrinking positive
radii. For `f` holomorphic on a punctured disc about `c` the normalized integral is constant in
the radius, so the limit exists and equals that constant. -/
def residue (f : ℂ → F) (c : ℂ) : F :=
  limUnder (𝓝[>] (0 : ℝ)) (fun r ↦ (2 * Real.pi * Complex.I : ℂ)⁻¹ • ∮ z in C(c, r), f z)

/-- The Laurent coefficient of exponent `k`, computed on the circle of radius `r` about zero. -/
def circleLaurentCoeff (f : ℂ → F) (r : ℝ) (k : ℤ) : F :=
  (2 * Real.pi * Complex.I : ℂ)⁻¹ • ∮ w in C(0, r), w ^ (-k - 1) • f w

end BanachDefinitions

/-- Generators for rational functions with poles in `A`, including polynomials. -/
def rungeGenerators (A : Set ℂ) : Set (ℂ → ℂ) :=
  insert (fun z ↦ z) ((fun a ↦ fun z : ℂ ↦ (a - z)⁻¹) '' A)

/-- The Weierstrass elementary factor of genus `p`. -/
def elementaryFactor (p : ℕ) (z : ℂ) : ℂ :=
  (1 - z) * Complex.exp (∑ k ∈ Finset.range p, z ^ (k + 1) / (k + 1))

/-- The canonical product using genus `n` for the `n`th factor. -/
def weierstrassProduct (a : ℕ → ℂ) (z : ℂ) : ℂ := ∏' n, elementaryFactor n (z / a n)

/-- A canonical product with a fixed genus and an arbitrary index type. -/
def canonicalProduct {ι : Type*} (k : ℕ) (a : ι → ℂ) (z : ℂ) : ℂ :=
  ∏' i, elementaryFactor k (z / a i)

/-- Order at most `ρ`: for every exponent `s > ρ` there is an explicit bound
`‖f z‖ ≤ A * exp (B * ‖z‖ ^ s)` with `A B ≥ 0`. -/
def HasOrderLE (f : ℂ → ℂ) (ρ : ℝ) : Prop :=
  ∀ s : ℝ, ρ < s → ∃ A B : ℝ, 0 ≤ A ∧ 0 ≤ B ∧ ∀ z, ‖f z‖ ≤ A * Real.exp (B * ‖z‖ ^ s)

/-- The normalized Blaschke factor, for a nonzero point `a` of the unit disc. -/
def blaschkeFactor (a z : ℂ) : ℂ := (‖a‖ / a) * (a - z) / (1 - conj a * z)

/-- The product of the Blaschke factors of an indexed family. -/
def blaschkeProduct {ι : Type*} (a : ι → ℂ) (z : ℂ) : ℂ :=
  ∏' i, blaschkeFactor (a i) z

open TauCeti.Contour

/-- 1. Primitives on simply connected open sets, with prescribed value; Banach-valued. -/
theorem primitives {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F] [CompleteSpace F]
    {U : Set ℂ} {f : ℂ → F} (hf : DifferentiableOn ℂ f U) (hU : IsOpen U)
    (hUs : IsSimplyConnected U) (z₀ : ℂ) (v : F) :
    ∃ P : ℂ → F, P z₀ = v ∧ ∀ z ∈ U, HasDerivAt P (f z) z := by
  sorry

/-- 2. The residue theorem for a null-homologous cycle and finitely many isolated singularities
of any type; Banach-valued. -/
theorem residue_theorem {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F] [CompleteSpace F]
    {C : Cycle} {U : Set ℂ} (hU : IsOpen U) (S : Finset ℂ) (hCU : C.IsIn (U \ ↑S))
    (hnull : C.IsNullHomologous U) {f : ℂ → F} (hf : DifferentiableOn ℂ f (U \ ↑S)) :
    Cycle.integral f C =
      ∑ a ∈ S, (2 * Real.pi * Complex.I * Cycle.windingNumber a C) • residue f a := by
  sorry

/-- 3. The bilateral Laurent expansion on an annulus; Banach-valued. -/
theorem laurent_expansion {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F] [CompleteSpace F]
    {f : ℂ → F} {r R : ℝ} (hr : 0 < r) {z : ℂ} (hrz : r < ‖z‖) (hzR : ‖z‖ < R)
    (hf : AnalyticOnNhd ℂ f (Metric.closedBall 0 R \ Metric.ball 0 r)) :
    HasSum (fun k : ℤ ↦ z ^ k • circleLaurentCoeff f r k) (f z) := by
  sorry

/-- 4. Casorati–Weierstrass: every punctured neighborhood of an essential singularity has dense
image. -/
theorem casorati_weierstrass {f : ℂ → ℂ} {c : ℂ}
    (hf : ∀ᶠ z in 𝓝[≠] c, AnalyticAt ℂ f z) (hc : ¬MeromorphicAt f c)
    {s : Set ℂ} (hs : s ∈ 𝓝[≠] c) : Dense (f '' s) := by
  sorry

/-- 5. An isolated singularity is removable, a pole, or has dense image on each punctured
neighborhood. -/
theorem isolated_singularity {f : ℂ → ℂ} {c : ℂ} (hf : ∀ᶠ z in 𝓝[≠] c, AnalyticAt ℂ f z) :
    (∃ g : ℂ → ℂ, AnalyticAt ℂ g c ∧ f =ᶠ[𝓝[≠] c] g) ∨
      Tendsto (fun z ↦ ‖f z‖) (𝓝[≠] c) atTop ∨
      ∀ s ∈ 𝓝[≠] c, Dense (f '' s) := by
  sorry

/-- 6. Runge approximation with poles in a set meeting every bounded complementary component. -/
theorem runge {K : Set ℂ} (hK : IsCompact K) {A : Set ℂ} (hAK : A ∩ K = ∅)
    (hA : ∀ w ∉ K, Bornology.IsBounded (connectedComponentIn Kᶜ w) →
      ∃ a ∈ A, a ∈ connectedComponentIn Kᶜ w)
    {U : Set ℂ} (hU : IsOpen U) (hKU : K ⊆ U) {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f U) :
    ∀ ε > 0, ∃ g ∈ Algebra.adjoin ℂ (rungeGenerators A), ∀ z ∈ K, ‖f z - g z‖ ≤ ε := by
  sorry

/-- 7. Polynomial Runge approximation on a compact set with connected complement. -/
theorem runge_polynomial {K : Set ℂ} (hK : IsCompact K) (hKc : IsPreconnected Kᶜ)
    {U : Set ℂ} (hU : IsOpen U) (hKU : K ⊆ U) {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f U)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ p : Polynomial ℂ, ∀ z ∈ K, ‖f z - p.eval z‖ ≤ ε := by
  sorry

/-- 8. Mittag–Leffler on an arbitrary open set for a set of singularities with no accumulation
point in the open set (every point of `U` has positive distance from the other singularities). -/
theorem mittag_leffler {U : Set ℂ} (hU : IsOpen U) {S : Set ℂ} (hSU : S ⊆ U)
    (hS : ∀ z ∈ U, ∃ ε > 0, ∀ w ∈ S, w ≠ z → ε ≤ dist w z)
    {P : ℂ → ℂ → ℂ} (hP : ∀ a ∈ S, DifferentiableOn ℂ (P a) {a}ᶜ) :
    ∃ f : ℂ → ℂ, DifferentiableOn ℂ f (U \ S) ∧
      ∀ a ∈ S, ∃ g : ℂ → ℂ, AnalyticAt ℂ g a ∧ f =ᶠ[𝓝[≠] a] fun z ↦ P a z + g z := by
  sorry

/-- 9. The Weierstrass product is entire and has precisely the prescribed zeros, with
multiplicities. -/
theorem weierstrass_product {a : ℕ → ℂ} (ha : ∀ n, a n ≠ 0)
    (hlim : Tendsto (fun n ↦ ‖a n‖) atTop atTop) :
    Differentiable ℂ (weierstrassProduct a) ∧
      ∀ w : ℂ, analyticOrderAt (weierstrassProduct a) w = ({n : ℕ | a n = w}.ncard : ℕ∞) := by
  sorry

/-- 10. Weierstrass factorization for a nonzero zero sequence tending to infinity, counted with
multiplicity. -/
theorem weierstrass_factorization {a : ℕ → ℂ} {f : ℂ → ℂ} (hf : Differentiable ℂ f)
    (ha : ∀ n, a n ≠ 0) (hlim : Tendsto (fun n ↦ ‖a n‖) atTop atTop)
    (hord : ∀ w : ℂ, analyticOrderAt f w = ({n : ℕ | a n = w}.ncard : ℕ∞)) :
    ∃ g : ℂ → ℂ, Differentiable ℂ g ∧
      ∀ z : ℂ, f z = Complex.exp (g z) * weierstrassProduct a z := by
  sorry

/-- 11. Hadamard factorization for entire functions of order at most `ρ`, with polynomial degree
at most the genus. -/
theorem hadamard {f : ℂ → ℂ} (hf : Differentiable ℂ f) (hne : ∃ z, f z ≠ 0) {ρ : ℝ}
    (hρ : HasOrderLE f ρ) {k : ℕ} (hk : ρ < k + 1) :
    ∃ (ι : Type) (_ : Countable ι) (a : ι → ℂ) (m : ℕ) (P : Polynomial ℂ),
      (∀ i, a i ≠ 0) ∧
      Tendsto (fun i ↦ ‖a i‖) cofinite atTop ∧
      (∀ i, f (a i) = 0) ∧
      (Summable fun i ↦ ‖a i‖⁻¹ ^ (k + 1)) ∧
      P.natDegree ≤ k ∧
      ∀ z : ℂ, f z = Complex.exp (P.eval z) * z ^ m * canonicalProduct k a z := by
  sorry

/-- 12. The multiplicity-weighted Blaschke condition for nonzero zeros of a bounded nontrivial
holomorphic function on the unit disc. -/
theorem blaschke_condition {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f (Metric.ball 0 1)) {M : ℝ}
    (hM : ∀ z ∈ Metric.ball 0 1, ‖f z‖ ≤ M) (hne : ∃ z ∈ Metric.ball 0 1, f z ≠ 0) :
    Summable fun w : {w : ℂ // ‖w‖ < 1 ∧ f w = 0 ∧ w ≠ 0} ↦
      ((analyticOrderAt f (w : ℂ)).toNat : ℝ) * (1 - ‖(w : ℂ)‖) := by
  sorry

/-- 13. Riesz factorization into an origin power, a Blaschke product and a zero-free holomorphic
factor with the same bound. -/
theorem riesz_factorization {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f (Metric.ball 0 1)) {M : ℝ}
    (hM : ∀ z ∈ Metric.ball 0 1, ‖f z‖ ≤ M) (hne : ∃ z ∈ Metric.ball 0 1, f z ≠ 0) :
    ∃ (ι : Type) (_ : Countable ι) (a : ι → ℂ) (m : ℕ) (g : ℂ → ℂ),
      (∀ i, a i ≠ 0) ∧
      (∀ i, ‖a i‖ < 1) ∧
      (Summable fun i ↦ 1 - ‖a i‖) ∧
      (∀ i, f (a i) = 0) ∧
      DifferentiableOn ℂ g (Metric.ball 0 1) ∧
      (∀ z ∈ Metric.ball 0 1, g z ≠ 0) ∧
      (∀ z ∈ Metric.ball 0 1, ‖g z‖ ≤ M) ∧
      ∀ z ∈ Metric.ball 0 1, f z = z ^ m * blaschkeProduct a z * g z := by
  sorry

/-- 14. Koebe's quarter theorem for a normalized univalent function. -/
theorem koebe_quarter {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f (Metric.ball 0 1))
    (hinj : InjOn f (Metric.ball 0 1)) (h0 : f 0 = 0) (h1 : deriv f 0 = 1) :
    Metric.ball 0 (1 / 4) ⊆ f '' Metric.ball 0 1 := by
  sorry

/-- 15. The two-sided Koebe distortion bound for the derivative of a univalent function. -/
theorem koebe_distortion {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f (Metric.ball 0 1))
    (hinj : InjOn f (Metric.ball 0 1)) (h1 : deriv f 0 = 1) {z₀ : ℂ}
    (hz₀ : z₀ ∈ Metric.ball 0 1) :
    (1 - ‖z₀‖) / (1 + ‖z₀‖) ^ 3 ≤ ‖deriv f z₀‖ ∧
      ‖deriv f z₀‖ ≤ (1 + ‖z₀‖) / (1 - ‖z₀‖) ^ 3 := by
  sorry

/-- 16. The upper Koebe growth bound for a normalized univalent function. -/
theorem koebe_growth {f : ℂ → ℂ} (hf : DifferentiableOn ℂ f (Metric.ball 0 1))
    (hinj : InjOn f (Metric.ball 0 1)) (h0 : f 0 = 0) (h1 : deriv f 0 = 1) {z₀ : ℂ}
    (hz₀ : z₀ ∈ Metric.ball 0 1) :
    ‖f z₀‖ ≤ ‖z₀‖ / (1 - ‖z₀‖) ^ 2 := by
  sorry

end TauCetiRoadmap.ComplexAnalysisOneVariable
