-- rational.hs
import System.Random 
import Control.Monad
import System.IO.Unsafe                                        


--
-- Implement your answers in this file.
--
-- There are few rules to follow:
--
--  - Don't change the MyRational type.
--  - Don't change any of the given function signatures.
--  - Use only functions from the standard prelude. Don't import any Haskell
--    modules.
--
-- You can implement your own helper functions if you like.
--

data MyRational = Frac Integer Integer

-- Given integers n and d, create a new rational with n as the numerator and d
-- as the denominator. Trying to create a rational with denominator 0 is an
-- error. Call the error function to crash the function, e.g. error
-- "makeRational: denominator can't be 0"
--
makeRational :: Integer -> Integer -> MyRational
-- ...
makeRational (num) (denom) = do
    if denom == 0
        then error "makeRational: denominator can't be 0"
    else Frac num denom

--
-- Returns the numerator of a rational.
--
getNum :: MyRational -> Integer
-- -- ...
getNum (Frac num _) = num
-- --
-- -- Returns the denominator of a rational.
-- --
getDenom :: MyRational -> Integer
-- -- ...
getDenom (Frac _ denom) = denom

-- --
-- -- Returns a pair of the numerator and denominator of a MyRational.
-- --
pair :: MyRational -> (Integer, Integer)
-- -- ...
pair (Frac num denom) = (num, denom)
-- --
-- -- Implement an instance of the show function that returns the usual string
-- -- representation of the rational. For instance, 5/3 would be the string
-- -- "5/3".
-- --
instance Show MyRational where
   show (Frac num denom) = (show num) ++ "/" ++ (show denom)


-- Divide helper to conver both operands to floats
divHelper x y  = (x `foo` y)  where foo x y = (fromIntegral x) / (fromIntegral y)


-- -- Convert the fraction to a floating point value Returns the value as the
-- -- number as a floating point number. For example, 5/2 is 2.5, 1/3 is 0.3333,
-- -- etc. Hint: use fromIntegral.
-- --
toFloat :: MyRational -> Float
-- -- ...
toFloat (Frac num denom) =  divHelper num denom

-- --
-- -- Implement an instance of == that test if two MyRationals are equal. Be
-- -- careful if either is not in lowest terms!
-- --
instance Eq MyRational where
  (/=) f    = not . (==) f
  (==) f f' = (x == x') && (y == y')
      where (Frac x y) = toLowestTerms f
            (Frac x' y') = toLowestTerms f'
            
-- --
-- -- Implement an instance of compare x y that tests if the MyRationals x and y
-- -- are the same (return EQ), or x is less than y (return LT), or x is greater
-- -- than y (return GT). Be careful with negative values, and when x or y is not
-- -- in lowest terms!
-- --
-- instance Ord MyRational where
-- -- ...
instance Ord MyRational where
  compare (Frac a b) (Frac c d) = compare (divHelper a b) (divHelper c d)
  (<)  f    = (==) LT . compare f
  (>)  f    = (==) GT . compare f
  (>=) f    = not . (<) f
  (<=) f    = not . (>) f
  max  f f' = if f < f' then f' else f
  min  f f' = if f < f' then f else f'
-- --
-- -- Return True if the given MyRational represents an integer, and False
-- -- otherwise. For example, 4/1, 21/3, and 0/99 are all integers.
-- --
isInt :: MyRational -> Bool
-- -- ...
isInt (Frac num denom) = do
    if num `mod` denom == 0
        then True
    else False

-- --
-- -- Adds two given MyRationals and returns a new MyRational that is there sum.
-- --
add :: MyRational -> MyRational -> MyRational
-- -- ...
add (Frac num1 denom1) (Frac num2 denom2) = do
    let factor = gcd denom1 denom2
    let newDenom = (denom1 * denom2) `div` factor
    let newNum = ((num1) * (newDenom `div` denom1)) + ((num2) * (newDenom `div` denom2))
    toLowestTerms (Frac newNum newDenom)
-- --
-- -- Multiplies two given MyRationals and returns a new MyRational that is there
-- -- product.
-- --
mult :: MyRational -> MyRational -> MyRational
-- -- ...
mult (Frac num1 denom1) (Frac num2 denom2) = do
    let newNum = num1 * num2
    let newDenom = denom1 * denom2 
    toLowestTerms (Frac newNum newDenom)
-- --
-- -- Divides two given MyRationals and returns a new MyRational that is there
-- -- quotient. Call the error function if division by zero would occur.
-- --
divide :: MyRational -> MyRational -> MyRational
-- -- ...
divide (Frac num1 denom1) (Frac num2 denom2) = do
    let newNum = num1 * denom2  
    let newDenom = denom1 * num2 
    if num2 == 0
        then error "divide: can't divide by 0"
    else
        toLowestTerms (Frac newNum newDenom)
-- --
-- -- Inverts a given MyRational and returns a new one with the numerator and
-- -- denominator switched. For example, 2/3 inverts to 3/2. Call the error
-- -- function for 0 numerators, e.g. 0/3 inverts to 3/0, which is not a
-- -- rational.
-- --
invert :: MyRational -> MyRational
-- -- ...
invert (Frac num denom) = do
    let newNum = denom
    let newDenom = num
    if num == 0
        then error "invert: numerator can't be 0"
    else
        (Frac newNum newDenom)
-- --
-- -- Reduces a given MyRational and returns a new MyRational that is in lowest
-- -- terms. For example, 36/20 reduces to 9/5. Use the gcd function to help do
-- -- this. Be careful in the case where the numerator or denominator is
-- -- negative.
-- --
toLowestTerms :: MyRational -> MyRational
-- -- ...
toLowestTerms (Frac num denom) = Frac (num `quot` factor) (denom `quot` factor)
    where factor = gcd num denom
-- --
-- -- Given an integer, return a rational equal to 1/1 + 1/2 + ... + 1/n.
-- --
-- -- For example:
-- --
-- -- > harmonicSum 25
-- -- 34052522467/8923714800
-- --
harmonicSum :: Integer -> MyRational
-- -- ...
harmonicSum n = do
    if n == 1
        then makeRational 1 1
    else
        add (makeRational 1 n) (harmonicSum (n - 1))
-- --
-- -- Using insertion sort, list any list of values [a] for a type that
-- -- implements Ord.
-- --
-- -- For example:
-- --
-- -- > insertionSort [5,6,2,3,1,4]
-- -- [1,2,3,4,5,6]
-- --
-- -- > insertion_sort ["one","two","three","four"]
-- -- ["four","one","three","two"]
-- --
-- -- > insertionSort [makeRational 2 2,makeRational 0 1,
-- --                  makeRational 4 5,makeRational (-1) 7]
-- -- [-1/7,0/1,4/5,2/2]
-- --
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x < y     = x:y:ys
                | otherwise = y:(insert x ys)

insertionSort :: Ord a => [a] -> [a]
-- -- ...
insertionSort [] = []
insertionSort (x:xs) = insert x (insertionSort xs)

-- --
-- -- When you're ready to test insertionSort, put a main function here that
-- -- calls it. See helloWorld.hs in the same folder for an example of how to do
-- -- this.
-- --
append a [] = [a]
append a (x:xs) = x : append a xs

randomInts :: Int -> IO([Int])
randomInts 0 = return []
randomInts n = do r  <- randomRIO (1,10000)
                  rs <- randomInts (n-1)
                  return (r:rs) 


testInt = do
    lst <- randomInts 10000
    let sortedList = insertionSort lst
    putStrLn "End of Number insertionSort"

testString = do
    lst <- randomStrings 10000
    let sortedList = insertionSort lst
    putStrLn "End of String insertionSort"

testMyRational = do
    lst <- randomRationals 10000
    let sortedList = insertionSort lst
    putStrLn "End of MyRational insertionSort"

randomize :: String -> IO String
randomize "random" = replicateM 10 (randomRIO ('a', 'z'))
randomize other = pure other

c :: Integer
c = unsafePerformIO (getStdRandom (randomR (0, 9)))

randomStrings :: Int -> IO([String])
randomStrings 0 = return []
randomStrings n = 
    do 
        r  <- randomize "random"
        rs <- randomStrings (n-1)
        return (r:rs) 

randomRationals :: Int -> IO([MyRational])
randomRationals 0 = return []
randomRationals n = 
    do 
        num <- randomRIO (1, 1000)
        denom <- randomRIO (1,1000)
        let r = makeRational num denom
        rs <- randomRationals (n-1)
        return (r:rs)


-- time is in seconds so multiplied by 1000000 for microseconds
-- ran only one test at a time to check times
main = do 
    putStrLn "Calling insertionSort For Numbers"
    testInt
  
    putStrLn "Calling insertionSort For Strings"
    testString

    putStrLn "Calling insertionSort for MyRational"
    testMyRational
-- --