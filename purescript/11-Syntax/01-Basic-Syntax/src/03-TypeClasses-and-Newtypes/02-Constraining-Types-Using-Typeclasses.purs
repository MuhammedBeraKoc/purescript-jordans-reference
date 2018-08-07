module Syntax.Typeclass.Constraints where

import Prelude

-- Adding a Type Class constraint to a type signature
-- enables usage of the corresponding type class' function in that context:

-- Syntax: Adding constraints on Function's type signature
function :: TypeClass1 Type1 => TypeClass2 Type2 => {- and so on -} Param1 -> ReturnType
function arg = "return result"

-- example

class ToInt a where
  toInt :: a -> Int

data List a
  = Nil           -- end of list
  | Cons a (List a)   -- a head element and the rest of the list (tail)

                      -- 'a' must have an 'ToInt' instance for this to compile
stringList_to_intList :: forall a. ToInt a => List a -> List Int
stringList_to_intList Nil = Nil
stringList_to_intList (Cons head tail) = Cons (toInt head) (stringList_to_intList tail)

-- Coupling this with the `forall` syntax:
function0 :: forall a b. TypeClass1 a => TypeClass2 b => a -> b -> String
function0 a b = "return result"



-- Syntax: Adding constraints on type class instances

-- This type class turns any type into a String so we can
-- print it to the console when needed
class Show_ a where -- this is the same signature for Show found in Prelude
  show_ :: a -> String

-- Problem:
-- Say we have a data type called "Box" that just contains a value:
data Box a = Box a

-- If we want to implement the `Show` typeclass for it, we are limited to this:
-- Warning: does not compile since "Box" by itself is of kind (* -> *) and we need kind (*)
-- instance boxShow1 :: Show Box where
--   show box = "Box(<unknown value>)"

{-
We would like to also show the 'a' value stored in Box. How do we do that?
  By constraining our types in the Box to also have a Show instance: -}

-- Syntax
instance someTypeInstance :: (TypeClass1 a) => {- (TypeClassN a) => -} TypeClass1 (IntanceType a) where
  function1 _ = "body"

{- example: Read the following as:
"I can 'show' a Box only if the type stored in the Box can also be shown."
-}
instance boxShow :: (Show a) => Show (Box a) where
  show (Box a) = "Box(" <> show a <> ")"

-- usage
test1 :: Boolean
test1 =
  show (Box 4) == "Box(4)"

test2 :: Boolean
test2 =
  show (Box (Box 5)) == "Box(Box(5))"

-- necessary to make file compile
class TypeClass1 a where
  function1 :: a -> String

instance typeclass1 :: TypeClass1 String where
  function1 x = x

class TypeClass2 a where
  function2 :: a -> String

data Param1
type Type1 = String
type Type2 = String
type ReturnType = String
data IntanceType a = InstanceType a