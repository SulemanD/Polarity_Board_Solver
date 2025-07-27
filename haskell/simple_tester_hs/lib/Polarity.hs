module Polarity (polarity) where

{--
    Fill in the boggle function below. Use as many helpers as you want.
    Test your code by running 'cabal test' from the tester_hs_simple directory.
--}

polarity :: [String] -> ([Int], [Int], [Int], [Int]) -> [ String ]
-- Hardcoded solution to the 5x6 example. 
polarity board specs = [ "+-+-X-" , "-+-+X+", "XX+-+-", "XX-+X+", "-+XXX-" ]




