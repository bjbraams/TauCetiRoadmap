# Complex analysis of one variable: singularities, approximation, factorization, and univalent functions

Develop a reusable library connecting local holomorphic theory to global integration,
prescribed singularities, entire-function products, bounded holomorphic functions on the disc,
and the quantitative theory of univalent functions. The principal results are Banach-valued
primitives and residue theory, bilateral Laurent expansions, Casorati–Weierstrass, Runge and
Mittag–Leffler, Weierstrass and Hadamard factorization, the Blaschke condition and bounded-function
Riesz factorization, and the Koebe quarter, distortion, and upper growth theorems.

This README is the mathematical specification. It has sixteen principal targets, numbered 1–16,
and twelve named milestones, lettered A–L. The milestones are targets on the same footing as the
principal results. [Suggested.lean](Suggested.lean) gives suggested Lean statements for the
principal targets under the same numbers and names; proving those signatures alone does not
complete the roadmap. The compact-support Cauchy–Pompeiu identity is a supplied tool for
approximation, rather than a separate target here.

## Scope, suppliers, and shared targets

Use Mathlib's complex differentiation, analytic functions and orders, meromorphic functions and
divisors, circle and curve integrals, compact-open convergence, infinite sums and products,
Jensen's formula, Borel–Carathéodory, maximum modulus, Schwarz's lemma, and removable-singularity
theorems. Extend their APIs under the hypotheses each result actually supplies.

Consume the following Tau Ceti developments, importing individual modules:

- [ContourIntegration](../../Completed/ContourIntegration/README.md): piecewise C¹ curves,
  cycles, winding numbers, null-homology, the homological Cauchy theorem, and scalar meromorphic
  residue theory. The relevant code includes `TauCeti.Analysis.Contour.Cycle.Basic`,
  `TauCeti.Analysis.Contour.Cycle.HomologyCauchy`, `TauCeti.Analysis.Contour.Cycle.Residue`,
  and `TauCeti.Analysis.Contour.Primitive`.
- [ConformalMapping](../../Completed/ConformalMapping/README.md): holomorphic logarithms and
  roots under their stated hypotheses, nonvanishing derivatives and holomorphic inverses of
  injective maps, disc automorphisms (`TauCeti.Analysis.Complex.Conformal.Moebius`), local
  degree, the area formula `TauCeti.Analysis.Complex.Conformal.Area`, and the plane-separation
  results of `TauCeti.Analysis.Complex.PlaneSeparation`. Riemann mapping, Montel, Hurwitz, and
  Schwarz–Pick are suppliers, not targets to reimplement in this proposal.
- `TauCeti.Analysis.Complex.Pompeiu` and `TauCeti.Analysis.Complex.CauchyKernel`: the
  compact-support C¹ Cauchy–Pompeiu formula for complex Banach-valued maps and local
  integrability of the Cauchy kernel. Prove the cutoff and approximation adapters in Layer 3
  with the supplied normalization.

Check each supplier against the dependency revision used for implementation. If that revision
predates an existing upstream supplier, integrating its proof in a compatible shared module is
part of the prerequisite work, before a consumer imports it. In particular, the
[compact-support Cauchy–Pompeiu supplier][pompeiu-supplier] must be available with its Banach-valued
C¹ hypotheses; the approximation layer must neither assume it nor substitute an admitted formula.
This requirement does not authorize changing the roadmap repository's dependency pins.

There is substantial common scope with the
[GlobalHolomorphicFunctions proposal, PR #992][gh-proposal]. Its
[specification][gh-specification] includes Runge and Runge exhaustions (GH0), prescribed
principal parts (GH2), arbitrary-genus products and full Weierstrass factorization (GH3).
The overlapping targets in Layers 3–5 below must have shared implementations and comparison
lemmas, with their allocation reconciled in the roadmap specifications. This proposal is not
an instruction to build a second copy of those theories. Its Mittag–Leffler target also permits
essential principal data, and its integration targets retain arbitrary complex Banach values.
The finite-rank Runge operators, general zero prescription on arbitrary open sets, global smooth
inhomogeneous Cauchy–Riemann solver, and Cousin I specified in that proposal remain its broader
contracts; they are not prerequisites for the narrower results here. Reuse the genus-one
zero-support, elementary-factor, and entire-logarithm suppliers identified in its supplier
contracts when developing the arbitrary-genus and finite-order results here.

Potential theory (Dirichlet problems, Perron's method, Green functions, and subharmonic maximum
principles) belongs to the [PDE roadmap](../PDE/README.md); no target in this proposal depends
on it. Jensen's formula, maximum modulus, and Borel–Carathéodory come from Mathlib. Other
boundaries are Mergelyan approximation, Picard theory, natural boundaries, full Hardy-space
inner–outer factorization, the lower Koebe growth bound, and the general Bieberbach coefficient
theorem. The second-coefficient estimate needed for Koebe is Milestone K.

## Standing conventions and generality

- **Domains and functions.** Use open sets `U : Set ℂ`, `DifferentiableOn ℂ`, `AnalyticOnNhd`,
  and `HasDerivAt`; add `IsPreconnected` or `IsSimplyConnected` only where required. Functions
  are ambient functions whose restrictions carry the hypotheses. Values assigned at an
  isolated singularity are irrelevant to punctured-neighborhood statements.
- **Target spaces.** Primitive existence, Laurent expansion, homological Cauchy theory, and the
  cycle residue theorem allow an arbitrary complex Banach space `F`. Completeness is attached
  to the results that use it. The scalar singularity, approximation, product, growth, and
  univalent-function results have target ℂ. Do not replace a Banach-valued statement with its
  scalar specialization.
- **Contours.** Use Tau Ceti's native cycle carrier `TauCeti.Contour.Cycle`, the free abelian
  group on closed piecewise-C¹ curves, with `Cycle.integral`, `Cycle.windingNumber`,
  `Cycle.trace`, `Cycle.IsIn`, and `Cycle.IsNullHomologous` from
  `TauCeti.Analysis.Contour.Cycle.Basic`. The integral over a generator `γ` is
  `∫ t in γ.a..γ.b, deriv γ t • f (γ t)`, so an `F`-valued `f` is integrated against the
  complex-linear one-form `v ↦ v • f(z)`. Do not introduce a second cycle structure.
- **Cycles.** Null-homology in `U` is `Cycle.IsNullHomologous C U`: the winding number of the
  whole cycle vanishes at every point outside `U`. It is a condition on the cycle, not on each
  generator. The zero cycle is allowed.
- **Residues and Laurent coefficients.** The residue is the coefficient of exponent −1.
  Normalize circle coefficients by `(2πi)⁻¹` and use integer exponents. Compare the
  Banach-valued isolated-singularity residue with Tau Ceti's scalar `TauCeti.Contour.residue`
  on their common domain, as specified in Milestone B. The totalized definition makes no
  convergence assertion without the punctured holomorphy hypotheses.
- **Approximation.** Uniform approximation of `h` on a compact set `K` by a set `S` of functions
  is stated inline as `∀ ε > 0, ∃ g ∈ S, ∀ z ∈ K, ‖h z - g z‖ ≤ ε`; do not wrap it in a new
  predicate. Rational approximants belong to `Algebra.adjoin ℂ (rungeGenerators A)`, the complex
  algebra generated by `z` and `(a-z)⁻¹` for allowed pole locations `a ∈ A`. This includes
  polynomials. Locally uniform approximation on an open set uses `TendstoLocallyUniformlyOn`.
- **Orders and indexing.** Use `analyticOrderAt`, distinguishing infinite order from zero.
  Enumerate zeros with multiplicity; do not assume distinct zeros. General product families
  include empty and finite index types, and convergence uses finite-subset products. The
  sequential Weierstrass target has its separately stated escape-to-infinity hypothesis.
- **Growth and genus.** A bound at exponent `s` means
  `∃ A B ≥ 0, ∀ z, ‖f z‖ ≤ A * exp (B * ‖z‖ ^ s)`, written inline. Order at most `ρ`,
  `HasOrderLE f ρ`, means this bound for every real `s > ρ`. These are different endpoint
  conditions. The Hadamard target uses an arbitrary real `ρ` and natural genus `k` with
  `ρ < k + 1`; do not add an endpoint growth bound or a nonnegative-order hypothesis to its
  signature.
- **Disc factors.** Work on `Metric.ball (0 : ℂ) 1`. Normalize the nonzero Blaschke factor by
  `b_a(z) = (|a|/a) * (a-z)/(1-conj(a)*z)`, so `b_a(0)=|a|`. Treat zeros at the origin
  separately through `z^m`, since this formula at `a=0` does not give that factor.
- **Names and imports.** Follow Mathlib namespaces and naming conventions, use specific
  supplier imports, and document declarations and modules. Prototype names in Suggested.lean
  identify mathematical targets; the integrated library uses and extends the existing APIs.

## Layer 0: local analytic and zero-order infrastructure

Each item below is a required statement. Where Mathlib or Tau Ceti already proves it in the
stated generality, cite that declaration; otherwise prove it here.

- **Finite order and discreteness.** Let `U` be open and preconnected, `f` analytic on `U`, and
  `f z₀ ≠ 0` for some `z₀ ∈ U`. Then `analyticOrderAt f z ≠ ⊤` for every `z ∈ U`,
  `{z | f z ≠ 0} ∈ codiscreteWithin U`, the set `{z ∈ K | f z = 0}` is finite for every compact
  `K ⊆ U`, and `{z ∈ U | f z = 0}` is countable. Mathlib's
  `codiscreteWithin_setOfPred_analyticOrderAt_eq_zero_or_top` and
  `preimage_zero_mem_codiscreteWithin` are the starting point.
- **Dividing out zeros.** If `f` is analytic at `a` with `analyticOrderAt f a = m < ⊤`, then
  `f z = (z-a)^m * g z` near `a` with `g` analytic at `a` and `g a ≠ 0`. If `f` and `g` are
  analytic on an open `U` and `analyticOrderAt f z = analyticOrderAt g z ≠ ⊤` for every `z ∈ U`,
  construct `h` analytic on `U` with `h z ≠ 0` and `f z = h z * g z` for every `z ∈ U`,
  including at the common zeros.
- **Multiplicity enumeration.** Under the hypotheses of the first item, define the index type
  `Σ a : {a : ℂ // a ∈ U ∧ a ≠ 0 ∧ f a = 0}, Fin (analyticOrderAt f a).toNat` with its
  projection `ζ` to ℂ. Prove that it is countable and that
  `({i | ζ i = w}.ncard : ℕ∞) = analyticOrderAt f w` for every `w ∈ U` with `w ≠ 0`. For
  `U = univ`, prove `Tendsto (fun i ↦ ‖ζ i‖) cofinite atTop`. This index is the zero family
  used by Hadamard and Riesz factorization.
- **Holomorphic parameter integrals.** Let `U` be open, `μ` a measure on a measurable space `X`,
  `E` a complex Banach space, and `φ : ℂ → X → E` such that `φ · x` is holomorphic on `U` for
  `μ`-almost every `x`, each `φ z` is a.e. strongly measurable for `z ∈ U`, and for each compact
  `K ⊆ U` there is an integrable `b_K` with `‖φ z x‖ ≤ b_K x` for `z ∈ K` and a.e. `x`. Then
  `z ↦ ∫ x, φ z x ∂μ` is holomorphic on `U`, with derivative the integral of the derivatives.
  Derive it from Mathlib's `hasDerivAt_integral_of_dominated_loc_of_deriv_le`, using Cauchy
  estimates for the derivative bound. It is used for Laurent coefficients, the Cauchy-kernel
  integrals of Layer 3, and Milestone A.
- **Locally uniform sums.** Consume Mathlib's `differentiableOn_tsum_of_summable_norm`, and
  prove termwise differentiation of the sum under the same summable compact majorant.
- **Taylor coefficients.** For `f : ℂ → E` holomorphic on a neighborhood of `closedBall c R`
  with `R > 0`, prove
  `iteratedDeriv n f c / n! = (2πi)⁻¹ • ∮ w in C(c, R), (w-c)^(-(n+1)) • f w` and the Cauchy
  bound `‖iteratedDeriv n f c‖ / n! ≤ C / R^n` when `‖f‖ ≤ C` on the circle, from Mathlib's
  `cauchyPowerSeries` and `norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le`.

The zero function is treated separately throughout; its totalized divisor must not be used to
infer a zero-free quotient or finite orders.

## Layer 1: primitives on simply connected open sets

**Principal target 1: `primitives`.** For a holomorphic `f : ℂ → F` on an open simply connected
set `U`, construct `P : ℂ → F` with `HasDerivAt P (f z) z` for every `z ∈ U`, and any prescribed
value `P z₀ = v`. The prototype permits arbitrary `z₀ : ℂ`: when `z₀ ∉ U`, this is a choice
of an ambient value, not an extra condition on the domain.

Use Mathlib's `Complex.IsExactOn`. Supply a local-to-global theorem gluing local primitives
whose differences are locally constant, or an equivalent path-independence theorem with the
same generality. Local primitives on discs come from Mathlib. The gluing theorem itself
should not require completeness once those local primitives are given.

Prove uniqueness up to an additive constant on preconnected open domains, and uniqueness from
one prescribed value at a point in the domain. Derive endpoint formulas for integrals along
piecewise C¹ curves in `U` and compatibility with restrictions. Consume existing scalar
logarithm and root constructions, adding bridges to the primitive API where needed; the
Banach-valued existence statement is the new contract.

## Layer 2: Laurent series, residues, and isolated singularities

Build Laurent coefficients about a centre `c` by integrating
`(w-c)^(-k-1) • f(w)` on a positively oriented circle and multiplying by `(2πi)⁻¹`.
The Suggested.lean coefficient `circleLaurentCoeff` is the specialization `c=0`.

Required basic theory includes integrability, linearity, centre translation, radius
independence on an analytic annulus, Cauchy coefficient bounds, uniqueness, and vanishing of
negative coefficients for a function holomorphic through the centre. Prove geometric bounds
for positive and negative tails, and convergence locally uniformly on compact subannuli.

**Principal target 3: `laurent_expansion`.** If `0 < r < ‖z‖ < R` and `f` is analytic on a
neighborhood of `closedBall 0 R \ ball 0 r`, prove

$$
f(z)=\sum_{k\in\mathbb Z} z^k\,c_k,
\qquad c_k=\frac{1}{2\pi i}\int_{|w|=r}w^{-k-1}f(w)\,dw,
$$

as a `HasSum` over ℤ, with complex scalar multiplication for `F`-valued coefficients.
The inner circle may be used for every coefficient because radius independence has been proved.
Also give the local open-annulus formulation by choosing contained coefficient circles.

**Milestone A: Banach-valued homological Cauchy theorem.** Let `F` be a complex Banach space,
`U` open, `C : Cycle` with `C.IsIn U` and `C.IsNullHomologous U`, and `f : ℂ → F` holomorphic
on `U`. Prove `Cycle.integral f C = 0`, and for `z ∈ U \ C.trace` the Cauchy formula
`Cycle.integral (fun w ↦ (w - z)⁻¹ • f w) C = (2πi · Cycle.windingNumber z C) • f z`. This
extends the scalar `TauCeti.Contour.Cycle.homologyCauchyTheorem`. Either deduce it from the
scalar theorem by applying continuous linear functionals, which commute with the integral, and
separating points of `F` by Hahn–Banach, or adapt the divided-difference argument with its
compact-parameter integral estimates.

**Milestone B: the residue at an isolated singularity.** Define `residue f c` for `f : ℂ → F` as
the limit, as `r → 0⁺`, of `(2πi)⁻¹ • ∮ z in C(c, r), f z`. Assume `R > 0` and `f`
holomorphic on `ball c R \ {c}`. Prove:

- `(2πi)⁻¹ • ∮ z in C(c, r), f z = residue f c` for every `0 < r < R`;
- the residue is unchanged by changing the value `f c`;
- it equals the Laurent coefficient of exponent −1 of `f` about `c`;
- it is additive and complex-linear in `f` among functions holomorphic on `ball c R \ {c}`;
- it is zero if `f` is holomorphic on `ball c R`;
- if `(z - c) • f z → v` as `z → c` in `𝓝[≠] c`, then `residue f c = v`;
- for `F = ℂ` and `MeromorphicAt f c`, `residue f c = TauCeti.Contour.residue f c`.

Agreement with the scalar meromorphic API is required only under meromorphy; the Banach-valued
residue is defined and computed for essential singularities as well.

**Principal target 2: `residue_theorem`.** Let `U` be open, `S : Finset ℂ`, and `C : Cycle` with
`C.IsIn (U \ S)` and `C.IsNullHomologous U`. For every Banach-valued `f` holomorphic on
`U \ S`, prove

$$
\int_C f(z)\,dz
=2\pi i\sum_{a\in S} n(C,a)\,\mathrm{Res}(f,a).
$$

Use scalar multiplication in the Banach target. Essential singularities are allowed and no
meromorphy hypothesis is added. Points of `S` outside `U` have winding number zero by
null-homology. Supply comparison lemmas with Mathlib: for the one-generator cycle given by
`circleMap c r` on `[0, 2π]` with `r > 0`, the cycle integral is `∮ z in C(c, r), f z`, and the
winding number is one at points of `ball c r` and zero outside `closedBall c r`; for a closed
curve that is C¹ on its parameter interval, the cycle integral agrees with Mathlib's
`curveIntegral` of `fun z ↦ ContinuousLinearMap.toSpanSingleton ℂ (f z)` along the
corresponding `Path`. Singularities on the trace and principal-value integrals belong to
ContourIntegration's distinct contracts.

**Principal targets 4 and 5: `casorati_weierstrass` and `isolated_singularity`.** For scalar
`f` analytic throughout some punctured neighborhood of `c`, prove that failure of
`MeromorphicAt f c` forces dense image on every member of `𝓝[≠] c`. Assemble the alternatives:
a removable analytic extension, `‖f z‖ → ∞` at the puncture, or dense image on every punctured
neighborhood. State removability as equality of germs; no value assigned to `f(c)` is assumed
to be the extension value. Use Mathlib's removable-singularity and meromorphic-order theory.

## Layer 3: compact Runge approximation and Runge exhaustions

Let `K` be compact and `S` a complex subalgebra of `ℂ → ℂ` whose members are continuous on `K`.
Prove that the functions `h` continuous on `K` and uniformly approximable on `K` by `S` form a
complex subalgebra of `ℂ → ℂ` containing `S`, and that this subalgebra is closed under uniform
limits on `K`: if each `h n` belongs to it and
`∀ ε > 0, ∀ᶠ n in atTop, ∀ z ∈ K, ‖h z - h n z‖ ≤ ε`, then `h` belongs to it.

Provide the analytic approximation mechanism, using the supplied compact-support
Cauchy–Pompeiu theorem. Given compact `K ⊆ U` and `f` holomorphic on open `U`, construct a
smooth cutoff equal to one near `K`, with compact support inside `U`. Represent `f` on `K`
as a Cauchy-kernel area integral whose continuous density is supported in a compact subset
of `U \ K`. Prove uniform approximation of that integral by finite sums of simple kernels,
using positive separation of the two compact sets. Account for the kernel sign, the factor
of two in the antiholomorphic derivative, and area normalization. This layer supplies the
adapters; it does not reprove the compact-support identity.

Prove pole pushing by geometric-series estimates: approximate a pole by a sufficiently close
allowed pole, propagate approximability through each connected component of the complement,
and approximate poles in the unbounded component by polynomials.

**Principal target 6: `runge`.** Let `K` be compact and `A ∩ K = ∅`. Assume each bounded
connected component of `Kᶜ` meets `A`. Every function holomorphic on an open neighborhood of
`K` is uniformly approximable there by the algebra generated by `z` and `(a-z)⁻¹`, `a ∈ A`.
No condition is imposed on the unbounded component because polynomial approximation handles
its poles.

**Principal target 7: `runge_polynomial`.** If `Kᶜ` is preconnected, polynomials approximate
every function holomorphic near `K`, with `‖f z - p(z)‖ ≤ ε` on `K` for each `ε > 0`.
This hypothesis is holomorphy near `K`, not just holomorphy on its interior and continuity on
`K`.

**Milestone C: Runge exhaustions.** For every open `U`, construct compact sets `K n` with
`K n ⊆ interior (K (n+1))`, `⋃ n, K n = U`, every compact subset of `U` contained in some
`K n`, and every bounded connected component of `(K n)ᶜ` meeting `Uᶜ`. Let `A ⊆ Uᶜ` meet every
bounded connected component of `Uᶜ`. For `f` holomorphic on `U`, construct
`r n ∈ Algebra.adjoin ℂ (rungeGenerators A)` with `TendstoLocallyUniformlyOn r f atTop U`. If
`Uᶜ` has no bounded connected component, the `r n` are polynomials. These exhaustions and
approximation lemmas are shared with GH0.

## Layer 4: prescribed isolated singularities

**Principal target 8: `mittag_leffler`.** Let `U` be any open set and `S ⊆ U` have no
accumulation point in `U`. For each `a ∈ S`, prescribe a function `P_a : ℂ → ℂ` holomorphic
on `{a}ᶜ`. Construct `f` holomorphic on `U \ S` such that, at every `a ∈ S`,

$$
f(z)=P_a(z)+g_a(z)
$$

on a punctured neighborhood of `a`, with `g_a` analytic at `a`. The input singularity can
be essential; the target is not restricted to finite polar principal parts.

Use the native condition `Sᶜ ∈ codiscreteWithin U` and prove its equivalence, under the
stated subset and openness hypotheses, with the prototype's metric condition
`∀ z ∈ U, ∃ ε > 0, ∀ w ∈ S, w ≠ z → ε ≤ dist w z`. In particular, a merely discrete
subset with an accumulation point elsewhere inside `U` does not satisfy the required condition.

Split the prescribed data into finite exhaustion shells, apply Milestone C to correct their
tails by functions holomorphic on `U`, and establish locally uniform summability away from
`S`. Prove the local analytic extension of the remainder at each marked point. Give the
finite-principal-part meromorphic specialization and its native principal-part comparison,
shared with GH2. Handle empty and finite `S` and disconnected `U`.

## Layer 5: infinite products and Weierstrass factorization

Start with holomorphic factors `1 + u_i`. A summable uniform majorant for `‖u_i‖` on each
compact subset of an open domain gives locally uniform product convergence and holomorphy.
Consume Mathlib's product convergence results. Prove nonvanishing of tails, the exact zero
set, and additivity of orders from the finitely many vanishing factors near a point.
Include finite products, the empty product one, and reindexing under the convergence hypotheses.

For natural genus `p`, use

$$
E_p(w)=(1-w)\exp\left(\sum_{j=1}^{p}\frac{w^j}{j}\right).
$$

Provide the value at zero, exact simple zero at one, holomorphy, and small-disc estimates
such as `|E_p(w)-1| ≤ 4|w|^(p+1)` for `|w| ≤ 1/2`, sufficient to prove compact summability.
Use the shared primary-factor API, including its genus-one specialization.

**Principal target 9: `weierstrass_product`.** For nonzero `a_n` with `|a_n| → ∞`, the
variable-genus product `W(z)=∏_{n∈ℕ} E_n(z/a_n)` is entire, and

$$
\mathop{\mathrm{ord}}_w W=\#\{n\in\mathbb N:a_n=w\}.
$$

Prove finiteness of each fibre, holomorphy, the exact zero set, and the order identity.

**Principal target 10: `weierstrass_factorization`.** If an entire `f` has these same
orders at every point, construct an entire `g` with `f=exp(g) W`. The matching-order
hypothesis already forces `f(0) ≠ 0`; do not add it to the prototype as an extra assumption.
Use the zero-matching quotient of Layer 0 and the entire-logarithm supplier. The product
and quotient arguments are shared with GH3.

**Milestone D: fixed-genus canonical products.** Let `ι` be any index type, `k : ℕ`, and
`a : ι → ℂ` with `a i ≠ 0` and `Summable (fun i ↦ ‖a i‖⁻¹ ^ (k+1))`. Prove that the
finite-subset products of `E_k(z/a_i)` converge locally uniformly on ℂ, that
`P_k(z)=∏_i E_k(z/a_i)` is entire, that `Tendsto (fun i ↦ ‖a i‖) cofinite atTop`, and that
`analyticOrderAt P_k w = ({i | a i = w}.ncard : ℕ∞)` for every `w`. This includes finite and
empty families and is the input to Hadamard factorization, not a consequence of it.

## Layer 6: finite order and Hadamard factorization

Use the quantified growth convention above and prove the following closure properties. A bound
at exponent `s ≥ 0` gives a bound at every exponent `s' ≥ s`. If `f` and `g` have bounds at
exponent `s`, so does `f * g`. A polynomial, and `z ↦ z^m`, have bounds at every exponent
`s > 0`. If `P.natDegree ≤ k`, then `z ↦ exp (P.eval z)` has a bound at exponent `k`.
`HasOrderLE f ρ` and `ρ ≤ ρ'` give `HasOrderLE f ρ'`, and `HasOrderLE` is closed under products.

**Milestone E: zero counting and convergence exponent.** Let `f` be entire with `f 0 ≠ 0` and
a bound at exponent `s ≥ 0`. Using Jensen's formula, prove that there is `C` such that, for
every `r ≥ 1`, the number of zeros of `f` in `closedBall 0 r`, counted with multiplicity, is at
most `C * r ^ s`. Deduce, by summing over dyadic shells, that `∑_i ‖ζ i‖⁻¹ ^ t < ∞` over the
Layer 0 multiplicity index for every `t > s`. In particular, if `HasOrderLE f ρ` and
`ρ < k + 1`, then `Summable (fun i ↦ ‖ζ i‖⁻¹ ^ (k+1))`. Remove a zero at the origin by
dividing by `z^m` before applying this.

Build the estimates connecting Milestone D's products to growth: lower bounds away from small
discs around the zeros, and arbitrarily large radii whose circles avoid those discs. For the
zero-free quotient `exp(G)`, deduce a real-part bound on such circles.

**Milestone F: polynomiality from real-part growth.** Let `G` be entire, `s ≥ 0`, and suppose
there are `C` and radii `r n → ∞` with `re (G z) ≤ C * (r n) ^ s` whenever `‖z‖ = r n`. Prove
that `G` is a polynomial function of `natDegree ≤ ⌊s⌋₊`, using Borel–Carathéodory and Cauchy
estimates to show that the Taylor coefficients of `G` above degree `⌊s⌋₊` vanish.

**Principal target 11: `hadamard`.** For an entire function `f` nonzero somewhere, of order
at most `ρ`, and natural `k` with `ρ < k+1`, construct a countable index type `ι`, a family
`a : ι → ℂ` of nonzero zeros of `f`, a natural `m`, and a complex polynomial `P` such that
`‖a i‖ → ∞` along the cofinite filter and

$$
f(z)=\exp(P(z))\,z^m\prod_i E_k(z/a_i),
\qquad \deg P\le k,\qquad
\sum_i |a_i|^{-(k+1)}<\infty.
$$

Use `P.natDegree ≤ k` in Lean. The zero function is excluded by the hypothesis that `f` is
nonzero somewhere.

**Milestone G: Hadamard factorization for a given zero family.** Under the hypotheses of
target 11, let `a : ι → ℂ` satisfy `a i ≠ 0` and
`({i | a i = w}.ncard : ℕ∞) = analyticOrderAt f w` for every `w ≠ 0`. Prove
`Summable (fun i ↦ ‖a i‖⁻¹ ^ (k+1))` and construct `P` with `P.natDegree ≤ k` and
`f z = exp (P.eval z) * z ^ m * P_k(z)` for `m = (analyticOrderAt f 0).toNat`. Target 11
follows by applying this to the Layer 0 multiplicity index. Conversely, prove that any data
satisfying the conclusion of target 11 has this fibre identity and has
`m = (analyticOrderAt f 0).toNat`, by Milestone D and nonvanishing of the exponential. Include
the zero-free, finite-zero, and constant cases.

## Layer 7: Blaschke products and bounded-function Riesz factorization

Develop the normalized factors for `0 < |a| < 1`: their values, holomorphy, simple zeros,
modulus on the disc and its boundary, and the compact-disc estimate

$$
|1-b_a(z)|\le\frac{1+|z|}{1-|z|}(1-|a|),\qquad |z|<1.
$$

**Milestone H: Blaschke products.** Let `a : ι → ℂ` satisfy `0 < ‖a i‖ < 1` and
`Summable (fun i ↦ 1 - ‖a i‖)`. Prove that the finite-subset products of `b_{a_i}` converge
locally uniformly on the unit disc, that `B(z)=∏_i b_{a_i}(z)` is holomorphic there with
`‖B z‖ ≤ 1`, that `B z ≠ 0` for `z` in the disc outside the range of `a`, and that
`analyticOrderAt B w = ({i | a i = w}.ncard : ℕ∞)` for every `w` in the disc. Include the
empty product and finite families; repetitions encode multiplicities.

**Principal target 12: `blaschke_condition`.** If `f` is holomorphic on the unit disc,
bounded by `M`, and nonzero somewhere, prove

$$
\sum_{\substack{|w|<1,\ f(w)=0\\w\ne0}}
\mathop{\mathrm{ord}}_w(f)\,(1-|w|)<\infty.
$$

Apply Jensen's formula to the nonzero remainder after removing the zero at the origin.
Prove the weighted statement before translating it to a zero enumeration.

**Principal target 13: `riesz_factorization`.** Under those same hypotheses, construct a
countable index type `ι`, a family `a : ι → ℂ` of nonzero zeros of `f` in the unit disc with
`∑_i (1-|a_i|) < ∞`, a natural `m`, and a holomorphic nowhere-zero function `g` on the disc
such that

$$
f(z)=z^m B(z)g(z),\qquad |g(z)|\le M\quad (|z|<1),
$$

where `B` is the Blaschke product of `a`. The bound on `g` must be the same given `M`, not an
unspecified larger constant. Prove it using finite Blaschke products, maximum modulus on
contained circles, and passage to the limit. Equality of zero orders alone gives a holomorphic
quotient but does not establish this bound. This is removal of the zero divisor of a bounded
function, not an assertion that the remaining factor is outer.

**Milestone I: multiplicities in Riesz factorization.** Prove that any data satisfying the
conclusion of target 13 has `({i | a i = w}.ncard : ℕ∞) = analyticOrderAt f w` for every
nonzero `w` in the disc and `m = (analyticOrderAt f 0).toNat`, by Milestone H and the
nonvanishing of `g`.

## Layer 8: the area theorem and quantitative univalence

Use the supplied inverse, nonvanishing-derivative, disc-automorphism, logarithm, and root
theorems. Supply the contour, area, and Taylor-coefficient computations required below,
including their normalization and the interchange of the relevant integrals and sums.

**Milestone J: Gronwall's area theorem.** Let `G : ℂ → ℂ` be injective on
`ball 0 1 \ {0}`, with `h z := G z - z⁻¹` holomorphic on `ball 0 1`, so that

$$
G(z)=z^{-1}+b_0+b_1z+b_2z^2+\cdots,\qquad b_n=\frac{h^{(n)}(0)}{n!}.
$$

Prove that `fun n ↦ n * ‖b n‖ ^ 2` is summable and that `∑_{n≥1} n|b_n|² ≤ 1`. Establish the
Parseval identity on contained circles and the signed-area/index identity used to obtain the
nonnegative complement-area estimate. Consume the area formula
`TauCeti.Analysis.Complex.Conformal.Area` and the plane-separation results of
`TauCeti.Analysis.Complex.PlaneSeparation`, proving their adapters for the analytic boundary
contours. Do not assume an unproved global Green theorem in this step; any extra area identity
used here is part of this layer and must have its own hypotheses and proof.

**Milestone K: the second-coefficient bound.** For `f` holomorphic and injective on the unit
disc, normalized by `f(0)=0` and `f'(0)=1`, prove `‖iteratedDeriv 2 f 0‖ ≤ 4`, equivalently
`|a₂| ≤ 2`. Use the odd square-root transform `g(z) = √(f(z²)) = z + (a₂/2)z³ + ⋯`, which is
injective on the disc, and apply Milestone J to `1/g`.

**Principal target 14: `koebe_quarter`.** Prove `ball 0 (1/4) ⊆ f '' ball 0 1` for such
`f`, by the omitted-value transform and Milestone K.

**Milestone L: the pre-Schwarzian estimate.** For `f` holomorphic and injective on the unit
disc and every `z` in the disc, prove

$$
\left|(1-|z|^2)\frac{f''(z)}{f'(z)}-2\overline z\right|\le4,
$$

by applying Milestone K to `f` composed with a disc automorphism sending `0` to `z`, and then
normalized.

Integrate the resulting logarithmic derivative bounds along rays, using a holomorphic
logarithm of the nonvanishing derivative and explicit real comparison functions.

**Principal target 15: `koebe_distortion`.** For `r=|z|<1`, prove

$$
\frac{1-r}{(1+r)^3}\le |f'(z)|\le\frac{1+r}{(1-r)^3}.
$$

Its prototype assumes `f'(0)=1` without requiring `f(0)=0`; translating the function
preserves the derivative estimate. Keep that generality.

**Principal target 16: `koebe_growth`.** With `f(0)=0` and `f'(0)=1`, prove the upper bound
`|f(z)| ≤ |z|/(1-|z|)²` by integrating the derivative estimate along a radius.

## Dependency order and acceptance

Layer 0 supplies the common local adapters. Layer 1 uses disc primitives and gluing;
Layer 2 uses local Cauchy theory and the supplied contour API. Layer 3 uses the supplied
Cauchy–Pompeiu theorem and compact approximation estimates; Layer 4 uses Milestone C. Layer 5
uses Layer 0's zero and quotient API and the entire logarithm. Layer 6 uses Layer 5 and
Jensen/Borel–Carathéodory. Layer 7 uses the product and zero-order API of Layers 0 and 5 and
Jensen, without requiring the Hadamard theorem. Layer 8 uses the local analytic and contour
suppliers and its own area/coefficient estimates; it does not require the Runge or finite-order
branches. This is a dependency order, not a requirement to copy the import graph of an existing
formalization.

Completion requires the stated basic APIs, supplier comparisons, hypotheses, all sixteen
principal targets, and Milestones A–L. Include concrete formal specializations that exercise
the conventions:

- Primitives with prescribed values and uniqueness on a disc; the zero cycle and the difference
  of two circles whose winding number vanishes outside an annulus.
- Laurent coefficients and residues of `z⁻¹ + 1 + z`, and an essential singularity such as
  `exp(1/z)`, where the value at zero is irrelevant.
- Polynomial approximation on a closed disc; rational approximation on a compact annulus
  with an allowed pole in its hole; empty and finite prescribed singularity sets.
- Repeated zeros in a Weierstrass product; empty and finite fixed-genus products; Hadamard
  factorization for a nonzero constant and for a polynomial.
- Empty and finite Blaschke products, an origin zero separated from the nonzero zero family,
  and preservation of the input bound in Riesz factorization.
- The normalized identity map and the Koebe function `z/(1-z)²` as checks of normalization
  and the sharp constants in the quarter, derivative, and upper growth estimates.

Provide kernel-checked proofs without admissions in the implementation. Mathematical
generality, agreement with supplier objects, and the supporting API are acceptance criteria
in addition to compilation. Suggested.lean deliberately contains admissions as a specification
aid and does not certify the implementation or completion by itself.

## Existing formalizations and provenance

[Bastiaan J. Braams's lean-CA][lean-ca] is an Apache-2.0 source development for the selected
mathematics. Its [Challenge.lean][challenge] states the selected results, and
[Solution.lean][solution] connects them to library proofs. Its [mathematical synopsis][synopsis],
[library guide][structure], and [credits][credits] give broader context. This proposal specifies
mathematics and API requirements independently of that repository's file layout and numbering.

A secondary source map for locating relevant proofs is:

- Layer 1: `ComplexAnalysis/HasPrimitives.lean` and the locally constant gluing support.
- Layer 2: `LaurentSeries/`, `Residue/`, `EssentialSingularity.lean`, `Cycle/Cauchy.lean`,
  and `Cycle/Residue.lean`.
- Layers 3–4: `Runge/` and `MittagLeffler.lean`.
- Layers 5–6: `AnalyticOrder.lean`, `InfiniteProduct.lean`, `WeierstrassFactor.lean`,
  `WeierstrassProduct.lean`, `CanonicalProduct/`, `FiniteOrder.lean`, and `Hadamard.lean`.
- Layer 7: `Blaschke.lean` and `RieszFactorization.lean`.
- Layer 8: `Parseval.lean`, `DiscCauchyTransform.lean`, `UnivalentDisk/`, `AreaTheorem.lean`,
  `Koebe.lean`, `KoebeDistortion.lean`, and `KoebeGrowth.lean`.

When integrating existing code, retain applicable author and licence notices, coordinate with
its authors, and replace duplicated suppliers with imports and small comparison lemmas.
Source theorem names and proofs are evidence and implementation material, not a requirement
to preserve a private vocabulary or accidental import dependencies.

Related work to acknowledge and compare includes Roman Kvasnytskyi's
[Mathlib residue proposal #29588][residue-pr], Junyan Xu's
[primitive and path-integral proposal #26950][primitive-pr], Vincent Beffara's
[Curvint][curvint], and Matteo Cipollina's
[Hadamard development][cipollina] and [Zulip discussion][hadamard-discussion]. Their scope
and conventions differ: compare target spaces, punctured germs, growth hypotheses, and genus
before adapting code. The lean-CA credits record more detailed source comparisons, including
the PNT+ and Jeremy Tan rectangular residue developments. The two Mathlib pull requests are
inactive and are prior art, not API decisions: reuse their work where useful, but the
interfaces are the ones specified here. If either lands in Mathlib, adopt Mathlib's API and
reduce the corresponding Tau Ceti declarations to comparison lemmas. Follow Mathlib's adopted
APIs wherever they exist.

## Mathematical references

- J. B. Conway, *Functions of One Complex Variable I*, second edition, Springer, 1978:
  Chapters IV–V for primitives, Laurent expansions and residues; VII §5 for products;
  VIII §§1 and 3 for Runge and Mittag–Leffler; XI §3 for finite-order factorization.
- J. B. Conway, *Functions of One Complex Variable II*, Springer, 1995:
  Chapter 14 §7 for area and Koebe estimates; Chapter 20 §2 for Blaschke and bounded-function
  Riesz factorization.
- S. Lang, *Complex Analysis*, fourth edition, Springer, 1999: Chapters III–VIII for the
  integral and singularity background, and XIII §3 for finite order and Hadamard factorization.
- E. M. Stein and R. Shakarchi, *Complex Analysis*, Princeton University Press, 2003:
  Chapters 2–3 for integration and residues, and Chapter 5 for entire functions and Hadamard.
- P. L. Duren, *Univalent Functions*, Springer, 1983: Chapter 2 for the area theorem,
  second-coefficient estimate, and Koebe distortion and growth estimates.
- W. Rudin, *Real and Complex Analysis*, third edition, McGraw-Hill, 1987: Chapter 13 for
  rational approximation and its contour foundations.
- L. Hörmander, *An Introduction to Complex Analysis in Several Variables*, third edition,
  North-Holland, 1990: the one-variable compact-support Cauchy–Pompeiu and cutoff tools.

[gh-proposal]: https://github.com/TauCetiProject/TauCetiRoadmap/pull/992
[gh-specification]: https://github.com/TauCetiProject/TauCetiRoadmap/blob/7018cfb37ce4cc5e479fded132892dbfc0c51521/TauCetiRoadmap/GlobalHolomorphicFunctions/README.md
[pompeiu-supplier]: https://github.com/TauCetiProject/TauCeti/pull/13584
[lean-ca]: https://github.com/bjbraams/lean-CA/tree/bf70bd0a69d64c856d4a2434e57546fce56b9199
[challenge]: https://github.com/bjbraams/lean-CA/blob/bf70bd0a69d64c856d4a2434e57546fce56b9199/Challenge.lean
[solution]: https://github.com/bjbraams/lean-CA/blob/bf70bd0a69d64c856d4a2434e57546fce56b9199/Solution.lean
[synopsis]: https://github.com/bjbraams/lean-CA/blob/bf70bd0a69d64c856d4a2434e57546fce56b9199/SYNOPSIS.md
[structure]: https://github.com/bjbraams/lean-CA/blob/bf70bd0a69d64c856d4a2434e57546fce56b9199/STRUCTURE.md
[credits]: https://github.com/bjbraams/lean-CA/blob/bf70bd0a69d64c856d4a2434e57546fce56b9199/CREDITS.md
[residue-pr]: https://github.com/leanprover-community/mathlib4/pull/29588
[primitive-pr]: https://github.com/leanprover-community/mathlib4/pull/26950
[curvint]: https://github.com/vbeffara/Curvint
[cipollina]: https://github.com/leibniz-rs/PrimeNumberTheoremAnd/tree/8dc50485d7166be58b05ee0d54216c06a4b3aef9
[hadamard-discussion]: https://leanprover-community.github.io/archive/stream/423402-PrimeNumberTheorem%2B/topic/Hadamard.20factorization.20-.20PR.20ideas.html
