package main
import(
	"fmt"
	"./rational"
)

func process(obj rational.Rationalizer, obj2 rational.Rationalizer) {
    fmt.Printf("Numerator of %d: %d\n", obj, obj.Numerator())
    fmt.Printf("Denominator of %d: %d\n", obj, obj.Denominator())
    fmt.Printf("Split of %d: ", obj)
    fmt.Println(obj.Split())
    // created another function (Float64) that calls toFloat64() because toFloat64() can't be exported
    fmt.Printf("Floating point value of %d: %f\n", obj, rational.Float64(obj))
    fmt.Printf("isEqual for %d, %d: %t\n", obj, obj2, obj.Equal(obj2))
    fmt.Printf("isLessThan for %d, %d: %t\n", obj, obj2, obj.LessThan(obj2))
    fmt.Printf("isInt for %d: %t\n", obj, obj.IsInt())
    fmt.Printf("isInt for %d: %t\n", obj2, obj2.IsInt())
    fmt.Printf("Add %d + %d: ", obj, obj2)
    fmt.Println(obj.Add(obj2))
    fmt.Printf("Multiply %d * %d: ", obj, obj2)
    fmt.Println(obj.Multiply(obj2))
    fmt.Printf("Divide %d / %d: ", obj, obj2)
    fmt.Println(obj.Divide(obj2))
    fmt.Printf("Invert of %d: ", obj)
    fmt.Println(obj.Invert())
    fmt.Printf("Lowest form for %d: ", obj2)
    fmt.Println(obj2.ToLowestTerms())    
    fmt.Printf("Harmonic sum of n = 5: ")
    fmt.Println(rational.HarmonicSum(5))
    fmt.Printf("String of %d: %s\n", obj, obj.String())
}
func main() {
    f, _ := rational.MakeRational(-1, 1)
    f2, _ := rational.MakeRational(0, 5)
    process(f,  f2)   
}