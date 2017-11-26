-- Copyright (c) 2017 Scott Morrison. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Authors: Scott Morrison
import .enriched_category
import ..braided_monoidal_category

namespace categories.enriched.products

open categories
open categories.enriched
open categories.monoidal_category
open categories.braided_monoidal_category

-- definition ProductCategory { V : Category } { m : MonoidalStructure V } { σ : Symmetry m } ( C D : EnrichedCategory m ) : EnrichedCategory m := {
--     Obj            := C.Obj × D.Obj,
--     Hom            := λ X Y, m.tensorObjects (C.Hom X.1 Y.1) (D.Hom X.2 Y.2),
--     compose        := λ X Y Z, sorry, -- PROJECT Writing this requires so many associators! we better provide some help.
--     identity       := sorry,
--     left_identity  := sorry,
--     right_identity := sorry,
--     associativity  := sorry
-- }

end categories.enriched.products