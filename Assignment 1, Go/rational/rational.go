package rational

import (
    "fmt"
    "errors"
)

type Floater64 interface {
    // Converts a value to an equivalent float64.
    toFloat64() float64
}

type Rationalizer interface {

    // 5. Rationalizers implement the standard Stringer interface.
    fmt.Stringer

    // 6. Rationalizers implement the Floater64 interface.
    Floater64

    // 2. Returns the numerator.
    Numerator() int

    // 3. Returns the denominator.
    Denominator() int

    // 4. Returns the numerator, denominator.
    Split() (int, int)

    // 7. Returns true iff this value equals other.
    Equal(other Rationalizer) bool

    // 8. Returns true iff this value is less than other.
    LessThan(other Rationalizer) bool

    // 9. Returns true iff the value equal an integer.
    IsInt() bool

    // 10. Returns the sum of this value with other.
    Add(other Rationalizer) Rationalizer

    // 11. Returns the product of this value with other.
    Multiply(other Rationalizer) Rationalizer

    // 12. Returns the quotient of this value with other. The error is nil 
    // if its is successful, and a non-nil if it cannot be divided.
    Divide(other Rationalizer) (Rationalizer, error)

    // 13. Returns the reciprocal. The error is nil if it is successful, 
    // and non-nil if it cannot be inverted.
    Invert() (Rationalizer, error)

    // 14. Returns an equal value in lowest terms.
    ToLowestTerms() Rationalizer
    
} // Rationalizer interface

// 1
type Rationalize struct {
	numerator, denominator int
}
func MakeRational (x int, y int) (Rationalize, error) {
	if y != 0 {
		return Rationalize{x, y}, nil
	} else {
		return Rationalize{x, 1}, errors.New("Defaulted denominator to be 1 - can't be 0")
	}
}
// 2
func (r Rationalize) Numerator() int {
    return r.numerator
}
// 3
func (r Rationalize) Denominator() int {
    return r.denominator
}
// 4
func (r Rationalize) Split() (int, int) {
    return r.numerator, r.denominator
}
// 5
func (r Rationalize) String() string {
    return fmt.Sprintf("%d/%d", r.numerator, r.denominator)
}
// 6
func (r Rationalize) toFloat64() float64 {
    var floatNum float64 = (float64(r.numerator)) / (float64(r.denominator))
    return floatNum
}
func Float64(obj Rationalizer) float64 {
    numerator := obj.Numerator()
    denominator := obj.Denominator()
    temp, _ := MakeRational(numerator, denominator)
    return temp.toFloat64()
}
/* 
https://www.geeksforgeeks.org/program-to-add-two-fractions/

-- gcd, lowestForm, and Add
*/
func gcd(a int, b int) int {
    if a == 0 {
        return b
    } else {
        return gcd(b % a, a)
    }
}
func lowestForm(r Rationalize) Rationalize {
    commonFactor := gcd(r.numerator, r.denominator)
    r.numerator = r.numerator / commonFactor
    r.denominator = r.denominator / commonFactor
    return r
}
// 7
func (r Rationalize) Equal(other Rationalizer) bool {
    f1 := lowestForm(r)
    temp := Rationalize{other.Numerator(), other.Denominator()}
    f2 := lowestForm(temp)
    if f1 == f2 {
        return true
    } else {
        return false
    }
}
// 8
func (r Rationalize) LessThan(other Rationalizer) bool {
    var a float64 = float64(r.numerator) / float64(r.denominator)
    var b float64 = float64(other.Numerator()) / float64(other.Denominator())
    if a < b {
        return true
    } else {
        return false
    }
}
// 9
func (r Rationalize) IsInt() bool {
    remainder := r.numerator % r.denominator
    if remainder == 0 {
        return true
    } else {
        return false
    }
}
// 10
func (r Rationalize) Add(other Rationalizer) Rationalizer {
    commonFactor := gcd(r.denominator, other.Denominator())
    newDenominator := (r.denominator * other.Denominator()) / commonFactor
    newNumerator := (r.numerator) * (newDenominator / r.denominator) + (other.Numerator()) * (newDenominator / other.Denominator())
    temp := Rationalize{newNumerator, newDenominator}
    addedFraction := lowestForm(temp)
    return addedFraction
}
// 11
func (r Rationalize) Multiply(other Rationalizer) Rationalizer {
    newNumerator := r.numerator * other.Numerator()
    newDenominator := r.denominator * other.Denominator()
    temp := Rationalize{newNumerator, newDenominator}
    multipliedFraction := lowestForm(temp)
    return multipliedFraction
}
// 12
func (r Rationalize) Divide(other Rationalizer) (Rationalizer, error) {
    if other.Denominator() == 0 || other.Numerator() == 0 {
        error := errors.New("Divide Error")
        return nil, error
    } else {
        newNumerator := r.numerator * other.Denominator()
        newDenominator := r.denominator * other.Numerator()
        temp := Rationalize{newNumerator, newDenominator}
        dividedFraction := lowestForm(temp)
        return dividedFraction, nil
    }
}
// 13
func (r Rationalize) Invert() (Rationalizer, error) {
    if r.numerator == 0 {
        error := errors.New("Invert Error")
        return nil, error
    } else {
        invertFraction := Rationalize{r.denominator, r.numerator}
        temp := r.numerator
        r.numerator = r.denominator
        r.denominator = temp
        return invertFraction, nil
    }
}
// 14
func (r Rationalize) ToLowestTerms() Rationalizer {
    return lowestForm(r)
}
// 15
func harmonicSumHelper(obj Rationalizer, obj2 Rationalizer) Rationalizer {
    return obj.Add(obj2)
}
func HarmonicSum(n int) Rationalizer {
    res := Rationalize{0, 0}
    r := Rationalize{0, 1}
    r2 := Rationalize{1, 1}
    for i := 1; i <= n ; i ++ {
        result := harmonicSumHelper(r, r2)
        res.numerator = result.Numerator()
        res.denominator = result.Denominator()
        r.numerator = result.Numerator()
        r.denominator = result.Denominator()
        r2.denominator = i + 1
    }
    return res
}
