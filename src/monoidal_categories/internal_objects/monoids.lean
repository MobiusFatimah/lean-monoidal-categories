-- Copyright (c) 2017 Scott Morrison. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Authors: Stephen Morgan, Scott Morrison
import .semigroups

open categories
open categories.monoidal_category

namespace categories.internal_objects

structure MonoidObject { C : Category } ( m : MonoidalStructure C ) extends SemigroupObject m := 
  ( unit : C.Hom m.tensor_unit object )
  ( left_identity  : C.compose (m.tensorMorphisms unit (C.identity object)) multiplication = C.compose (m.left_unitor object) (C.identity object) )
  ( right_identity : C.compose (m.tensorMorphisms (C.identity object) unit) multiplication = C.compose (m.right_unitor object) (C.identity object) )

attribute [simp,ematch] MonoidObject.left_identity
attribute [simp,ematch] MonoidObject.right_identity

-- instance MonoidObject_coercion_to_SemigroupObject { C : MonoidalCategory } : has_coe (MonoidObject C) (SemigroupObject C) :=
--   { coe := MonoidObject.to_SemigroupObject }

end categories.internal_objects