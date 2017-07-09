-- Copyright (c) 2017 Scott Morrison. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Authors: Stephen Morgan, Scott Morrison
import .braided_monoidal_category
import .tensor_with_object

open categories
open categories.functor
open categories.products
open categories.natural_transformation
open categories.monoidal_category

namespace categories.drinfeld_centre

structure {u v} HalfBraiding { C : Category.{u v} } ( m : MonoidalStructure C ) :=
    (object   : C.Obj)
    (commutor : NaturalIsomorphism (m.tensor_on_left object) (m.tensor_on_right object))

definition {u v} HalfBraiding_coercion_to_object { C : Category.{u v} } ( m : MonoidalStructure C ) : has_coe (HalfBraiding m) (C.Obj) :=
  { coe := HalfBraiding.object }

attribute [instance] HalfBraiding_coercion_to_object

structure {u v} HalfBraidingMorphism  { C : Category.{u v} } { m : MonoidalStructure C } ( X Y : HalfBraiding m ) :=
  (morphism : C.Hom X Y)
  -- FIXME I've had to write out the statement gorily, so that it can match.
  -- (witness : ∀ Z : C.Obj, C.compose (X.commutor Z) (m.tensorMorphisms (C.identity Z) morphism) = C.compose (m.tensorMorphisms morphism (C.identity Z)) (Y.commutor Z))
  (witness : ∀ Z : C.Obj, C.compose (X.commutor.morphism.components Z) (@Functor.onMorphisms _ _ m.tensor (Z, X) (Z, Y) (C.identity Z, morphism)) = C.compose (@Functor.onMorphisms _ _ m.tensor (X, Z) (Y, Z) (morphism, C.identity Z)) (Y.commutor.morphism.components Z))

attribute [simp,ematch] HalfBraidingMorphism.witness

@[applicable] lemma HalfBraidingMorphism_equal
  { C : Category }
  { m : MonoidalStructure C }
  { X Y : HalfBraiding m }
  { f g : HalfBraidingMorphism X Y }
  ( w : f.morphism = g.morphism ) : f = g :=
  begin
    induction f,
    induction g,
    blast
  end

definition {u v} DrinfeldCentre { C : Category.{u v} } ( m : MonoidalStructure C )  : Category := {
  Obj := HalfBraiding m,
  Hom := λ X Y, HalfBraidingMorphism X Y,
  identity := λ X, {
    morphism := C.identity X,
    witness  := ♯
  },
  compose := λ P Q R f g, {
    morphism := C.compose f.morphism g.morphism,
    witness  := 
      begin
        -- PROJECT improve automation. This is also affected by https://github.com/leanprover/lean/issues/1552
        intros, 
        dsimp,
        -- blast, -- perhaps should work, but very slow
        rewrite m.interchange_right_identity,
        rewrite m.interchange_left_identity,
        tidy,
        -- rewrite ← C.associativity,
        -- simp,
        -- rewrite f.witness,
        -- rewrite C.associativity,
        -- tidy,
        -- rewrite g.witness,
        -- tidy,
      end
  },
  left_identity  := ♯,
  right_identity := ♯,
  associativity  := ♯
}

end categories.drinfeld_centre