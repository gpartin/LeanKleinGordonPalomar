module

public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
public import Mathlib.Tactic

public section

/-!
# C19 isotropic quadratic symbol and quartic long-wave error

This standalone statement surface is extracted from the audited
`LeanKleinGordonDerivation` release. It describes the positive half of the
nineteen-point cubic stencil (three face directions of weight two and six
edge directions of weight one), proves that its quadratic moment is exactly
isotropic, and bounds the finite-spacing cosine symbol by an explicit quartic
remainder.

It does not assert convergence of arbitrary nonlinear lattice trajectories,
a native massless carrier, a physical particle, or that the lattice is a model
of nature.
-/

namespace LeanKleinGordonPalomar

noncomputable section

abbrev Site := ℤ × ℤ × ℤ
abbrev WaveVector := ℝ × ℝ × ℝ

structure Bond where
  offset : Site
  weight : ℕ
  deriving DecidableEq

def positiveBonds : List Bond :=
  [⟨(1, 0, 0), 2⟩, ⟨(0, 1, 0), 2⟩, ⟨(0, 0, 1), 2⟩,
   ⟨(1, 1, 0), 1⟩, ⟨(1, -1, 0), 1⟩, ⟨(1, 0, 1), 1⟩,
   ⟨(1, 0, -1), 1⟩, ⟨(0, 1, 1), 1⟩, ⟨(0, 1, -1), 1⟩]

def dotSite (k : WaveVector) (s : Site) : ℝ :=
  k.1 * s.1 + k.2.1 * s.2.1 + k.2.2 * s.2.2

def scaleWave (h : ℝ) (k : WaveVector) : WaveVector :=
  (h * k.1, h * k.2.1, h * k.2.2)

def waveNormSq (k : WaveVector) : ℝ :=
  k.1 ^ 2 + k.2.1 ^ 2 + k.2.2 ^ 2

def speedSq : ℝ :=
  2 * (positiveBonds.map fun b =>
    (b.weight : ℝ) * (b.offset.1 : ℝ) ^ 2).sum

def spaceSymbol (k : WaveVector) : ℝ :=
  4 * (positiveBonds.map fun b =>
    (b.weight : ℝ) * (1 - Real.cos (dotSite k b.offset))).sum

def spatialErrorWeight (k : WaveVector) : ℝ :=
  (positiveBonds.map fun b =>
    (b.weight : ℝ) * (dotSite k b.offset) ^ 4).sum / 6

theorem c19IsotropicMoment (k : WaveVector) :
    2 * (positiveBonds.map fun b =>
      (b.weight : ℝ) * (dotSite k b.offset) ^ 2).sum =
      speedSq * waveNormSq k := by
  sorry

theorem c19SpeedSquared : speedSq = 12 := by
  sorry

theorem c19SpatialQuarticError (h : ℝ) (k : WaveVector) :
    |spaceSymbol (scaleWave h k) - h ^ 2 * (speedSq * waveNormSq k)| ≤
      h ^ 4 * spatialErrorWeight k := by
  sorry

end
end LeanKleinGordonPalomar

