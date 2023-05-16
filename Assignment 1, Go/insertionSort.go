package main

import (
	"fmt"
    "math/rand"
    "time"
    "./rational"
)


func insertionSortString(lst[] string) []string{
    var n = len(lst)
    ret := make([]string, n)
	copy(ret, lst)
    for i := 1; i < n; i++ {
        j := i
        for j > 0 {
            if ret[j] < ret[j-1] {
                ret[j-1], ret[j] = ret[j], ret[j-1]
            }
            j = j - 1
        }
    }
    return ret
}

func insertionSortInt (lst[] int) []int {
    var n = len(lst)
    ret := make([]int, n)
	copy(ret, lst)
    for i := 1; i < n; i++ {
        j := i
        for j > 0 {
            if ret[j] < ret[j-1] {
                ret[j-1], ret[j] = ret[j], ret[j-1]
            }
            j = j - 1
        }
    }
    return ret
}

func isLessThan(obj rational.Rationalizer, obj2 rational.Rationalizer) bool {
    if obj.LessThan(obj2) {
        return true
    } else {
        return false
    }
}
func insertionSortRational(lst[] rational.Rationalize) []rational.Rationalize{
    var n = len(lst)
    ret := make([]rational.Rationalize, n)
	copy(ret, lst)
    for i := 1; i < n; i ++ {
        j := i
        for j > 0 {
            if isLessThan(ret[j], ret[j-1]) == true {
                ret[j-1], ret[j] = ret[j], ret[j-1]
            }
            j = j - 1
        }
    }
    return ret
}

// https://flaviocopes.com/go-random/
// Returns an int >= min, < max  
func randomInt(min, max int) int {
    return min + rand.Intn(max-min)
}

/** https://www.calhoun.io/creating-random-strings-in-go/ **/
const charset = "abcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

var seededRand *rand.Rand = rand.New(rand.NewSource(time.Now().UnixNano()))

func StringWithCharset(length int, charset string) string {
    b := make([]byte, length)
    for i := range b {
        b[i] = charset[seededRand.Intn(len(charset))]
    }
    return string(b)
}
func randString(length int) string {
    return StringWithCharset(length, charset)
}
/*************************************************************/

func main() {
    rand.Seed(time.Now().UnixNano())
    len := 1000
    var lstInt = make([]int, len)
    for i := 0; i < len; i++ {
        lstInt[i] = int(randomInt(1, len))
    }
    // start the time measure here
    intStart := time.Now()
    retInt := insertionSortInt(lstInt)
    // get the time taken since start
    intDuration := time.Since(intStart)
    fmt.Println(intDuration.Microseconds())
    fmt.Println(retInt)
    /*  n = 1000
        time 1: 1833
        time 2: 1995
        time 3: 1105
        average: 1644.33
    */

    
    var lstString = make([]string, len)
    for i := 0; i < len; i++ {
        lstString[i] = randString(randomInt(1, 10))
    }
    stringStart := time.Now()
    retString := insertionSortString(lstString)
    stringDuration := time.Since(stringStart)
    fmt.Println(stringDuration.Microseconds())
    fmt.Println(retString)
    /*  n = 1000
        time 1: 22157
        time 2: 19568
        time 3: 10672
        average: 17465.67
    */

    var lstRational = make([]rational.Rationalize, len)
    for i := 0; i < len; i++ {
        lstRational[i], _ = rational.MakeRational(randomInt(1, len), randomInt(1, len))
        lstRational[i].ToLowestTerms()
    }
    rationalStart := time.Now()
    retRational := insertionSortRational(lstRational)
    rationalDuration := time.Since(rationalStart)
    fmt.Println(rationalDuration.Microseconds())
    fmt.Println(retRational)
    /*  n = 1000
        time 1: 65608
        time 2: 110259
        time 3: 79788
        average: 85218.33
    */
}
