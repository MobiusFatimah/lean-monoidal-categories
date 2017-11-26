-- Copyright (c) 2017 Scott Morrison. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Authors: Stephen Morgan, Scott Morrison
import .monoidal_category

open categories
open categories.isomorphism
open categories.functor
open categories.natural_transformation
open categories.products
open categories.monoidal_category

namespace categories.strict_monoidal_category

structure TensorProduct_is_strict { C : Category } ( tensor : TensorProduct C ) ( tensor_unit : C.Obj ) :=
  ( associativeOnObjects  : ∀ X Y Z : C.Obj, tensor.onObjects (tensor.onObjects (X, Y), Z) = tensor.onObjects (X, tensor.onObjects (Y, Z)) )
  ( strictLeftTensorUnit  : ∀ X : C.Obj, tensor.onObjects (tensor_unit, X) = X )
  ( strictRightTensorUnit : ∀ X : C.Obj, tensor.onObjects (X, tensor_unit) = X )

-- TODO why is this not a valid ematch lemma?
-- attribute [ematch] TensorProduct_is_strict.associativeOnObjects
-- TODO why is this not a valid simp lemma?
-- attribute [simp,ematch] TensorProduct_is_strict.strictLeftTensorUnit
-- attribute [simp,ematch] TensorProduct_is_strict.strictRightTensorUnit

-- set_option pp.implicit true

-- definition construct_StrictMonoidalCategory { C : Category } { tensor : TensorProduct C } { tensor_unit : C.Obj } ( is_strict : TensorProduct_is_strict tensor tensor_unit ) : MonoidalStructure C :=
-- {
--   tensor := {
--     onObjects     := λ p, tensor.onObjects p,
--     onMorphisms   := λ _ _ f, tensor.onMorphisms f,
--     identities    := ♮,
--     functoriality := ♮
--   },
--   tensor_unit := tensor_unit,
--   associator_transformation := {
--     components := λ t, begin
--                            induction t with pq r,
--                            induction pq with p q,
--                            refine (cast _ (C.identity (tensor.onObjects (tensor.onObjects (p, q), r)))),  
--                            blast, -- TODO Why doesn't blast do the next rewrite?
--                            rewrite ← is_strict.associativeOnObjects,
--                            exact sorry
--                        end,
--     naturality := begin
--                     -- TODO Given how we constructed components, I have no idea how to prove naturality.
--                     intros,
--                     dsimp,
--                     exact sorry
--                   end
--   },
--   left_unitor := sorry,
--   right_unitor := sorry,
--   associator_is_isomorphism := sorry,
--   left_unitor_is_isomorphism := sorry,
--   right_unitor_is_isomorphism := sorry,
--   pentagon := sorry,
--   triangle := sorry
-- }  

@[reducible] definition tensorList { C : Category } ( m : MonoidalStructure C ) ( X : list C.Obj ) : C.Obj := list.foldl m.tensorObjects m.tensor_unit X

-- @[reducible] definition tensorListConcatenation { C : MonoidalCategory } ( X : list C.Obj × list C.Obj ) : Isomorphism C (C.tensorObjects (tensorList X.1) (tensorList X.2)) (tensorList (append X.1 X.2)) :=
-- {
--   morphism  := sorry,
--   inverse   := sorry,
--   witness_1 := sorry,
--   witness_2 := sorry
-- }

-- @[reducible] definition ListObjectsCategory ( C : MonoidalCategory ) : Category := {
--   Obj := list C.Obj,
--   Hom := λ X Y, C.Hom (tensorList X) (tensorList Y),
--   identity       := λ X, C.identity (tensorList X),
--   compose        := λ _ _ _ f g, C.compose f g,
--   left_identity  := ♮,
--   right_identity := ♮,
--   associativity  := sorry
-- }

-- definition StrictTensorProduct ( C : MonoidalCategory ) : TensorProduct (ListObjectsCategory C) := {
--   onObjects     := λ X, append X.1 X.2,
--   onMorphisms   := λ X Y f, sorry, -- C.compose (C.compose (tensorListConcatenation X).inverse f) (tensorListConcatenation Y).morphism,
--   identities    := sorry,
--   functoriality := sorry
-- }

-- PROJECT
-- * show that StrictTensorProduct is strict
-- * construct a functor from C
-- * show that it is part of an equivalence

end categories.strict_monoidal_category
