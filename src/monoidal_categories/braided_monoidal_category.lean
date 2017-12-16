-- Copyright (c) 2017 Scott Morrison. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Authors: Stephen Morgan, Scott Morrison
import .monoidal_category
import categories.products.switch

namespace categories.braided_monoidal_category

open categories
open categories.functor
open categories.natural_transformation
open categories.products
open categories.monoidal_category

universe variables u v

/-
-- I don't really understand why the universe annotations are needed in Braiding and in squaredBraiding.
-- My guess is that it is related to
-- https://groups.google.com/d/msg/lean-user/3qzchWkut0g/0QR6_cS8AgAJ
-/

definition Commutor { C : Category.{u v} } (m : MonoidalStructure C) := 
  NaturalIsomorphism (m.tensor) (FunctorComposition (SwitchProductCategory C C) m.tensor)

@[reducible] definition Hexagon_1 { C : Category.{u v} } { m : MonoidalStructure C } ( β : Commutor m ) :=
  ∀ X Y Z : C.Obj,
    C.compose
      (m.tensorMorphisms (C.identity X) (β.morphism.components (Y, Z)))
    (C.compose
      (m.inverse_associator X Z Y)
      (m.tensorMorphisms (β.morphism.components (X, Z)) (C.identity Y))
    )
      = 
    C.compose
      (m.inverse_associator X Y Z) 
    (C.compose
      (β.morphism.components (m.tensorObjects X Y, Z))
      (m.inverse_associator Z X Y)
    )
@[reducible] definition Hexagon_2 { C : Category.{u v} } { m : MonoidalStructure C } ( β : Commutor m ) :=
  ∀ X Y Z : C.Obj,
    C.compose
      (m.tensorMorphisms (C.identity X) (β.inverse.components (Z, Y)))
    (C.compose
      (m.inverse_associator X Z Y)
      (m.tensorMorphisms (β.inverse.components (Z, X)) (C.identity Y))
    )
      = 
    C.compose
      (m.inverse_associator X Y Z) 
    (C.compose
      (β.inverse.components (Z, m.tensorObjects X Y))
      (m.inverse_associator Z X Y)
    )

structure Braiding { C : Category.{u v} } ( m : MonoidalStructure C ) :=
  ( braiding: Commutor m )
  ( hexagon_1 : Hexagon_1 braiding )
  ( hexagon_2 : Hexagon_2 braiding )
-- PROJECT a theorem showing the hexagons hold as natural transformations

structure Symmetry { C : Category.{u v} } ( m : MonoidalStructure C ) extends parent: Braiding m :=
  (symmetry: Π X Y : C.Obj, C.compose (braiding.morphism.components ⟨X, Y⟩) (braiding.morphism.components ⟨Y, X⟩) = C.identity (m.tensor.onObjects ⟨X, Y⟩) )

attribute [simp,ematch] Symmetry.symmetry

end categories.braided_monoidal_category