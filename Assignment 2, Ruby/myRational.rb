class MyRational 
    attr_reader :numerator, :denominator
    # @numerator
    # @denominator
    include Comparable

    # def numerator
    #     @numerator
    # end

    # def denominator
    #     @denominator
    # end

    def initialize(x, y)
        if y == 0
            raise 'MyRational: denominator cannot be 0'
        else
            @numerator = x
            @denominator = y
        end
    end

    def num()
        return @numerator
    end

    def denom()
        return @denominator
    end

    def pair()
        arr = Array.new(2)
        arr[0] = self.numerator
        arr[1] = self.denominator
        return arr
        # return "(#{@numerator}, #{@denominator})"
    end

    def to_s()
        return "#{@numerator}/#{@denominator}"
    end

    def to_f()
        return numerator.to_f / denominator
    end
    
    def gcd(a, b)
        if a == 0
            return b
        else   
            return gcd(b % a, a)
        end
    end
    def to_lowest_terms()
        commonFactor = gcd(self.numerator, self.denominator)
        numerator = self.numerator / commonFactor
        denominator = self.denominator / commonFactor  
        cpy = MyRational.new(numerator, denominator)
        return cpy      
    end
    
    def ==(other)
        copySelf = self.to_lowest_terms()
        copyOther = other.to_lowest_terms()

        if (copySelf.numerator == copyOther.numerator) && (copySelf.denominator == copyOther.denominator)
            return true 
        else
            return false
        end
    end
    
    def <(other)
        selfValue = (self.numerator.to_f) / self.denominator
        otherValue = (other.numerator.to_f) / other.denominator
        
        return selfValue < otherValue
    end

    def <=>(other)
        if (self.to_f() < other.to_f())
            return -1
        elsif (self == other)
            return 0
        else
            return 1
        end
    end

    def int?()
        if self.numerator.modulo(self.denominator) == 0
            return true
        else
            return false
        end
    end
    
    def +(other)
        newDenominator = gcd(self.denominator, other.denominator)
        newDenominator = (self.denominator * other.denominator) / newDenominator
        newNumerator = (self.numerator) * (newDenominator / self.denominator) + (other.numerator) * (newDenominator / other.denominator)
        
        result = MyRational.new(newNumerator, newDenominator)
        result = result.to_lowest_terms()
        return result
    end

    def *(other)
        newNumerator = self.numerator * other.numerator
        newDenominator = self.denominator * other.denominator

        result = MyRational.new(newNumerator, newDenominator)
        result = result.to_lowest_terms()
        return result
    end

    def /(other)
        
        if other.numerator == 0
            raise 'divide: cannot divide by 0'
        end
            newNumerator = self.numerator * other.denominator
            newDenominator = self.denominator * other.numerator
            result = MyRational.new(newNumerator, newDenominator)
            result = result.to_lowest_terms()
            return result
    end

    def invert()
        if numerator == 0
            raise 'Invert: Numerator cannot be 0 - undefined inverse'
        end
        newNumerator = self.denominator
        newDenominator = self.numerator

        result = MyRational.new(newNumerator, newDenominator)
        result = result.to_lowest_terms()
        return result
    end

end

class Integer
    def to_mr()
        rational = MyRational.new(self, 1)
        return rational
    end
end

def harmonicSum(n)
    result = MyRational.new(0, 1)

    i = 1
    while i <= n do 
        tmp = MyRational.new(1, i)
        result = result + (tmp)
        i += 1
    end
    result = result.to_lowest_terms()
    return result
end

def testRational(a, b)
    printf("%s numerator = %d\n", a.to_s, a.num )
    printf("%s denominator = %d\n", a.to_s, a.denom)
    printf("%s to_f = %f\n", a.to_s, a.to_f)
    printf("%s numerator = %d\n", b.to_s, b.num)
    printf("%s is equal %s: %s\n", a.to_s, b.to_s, a == b)
    printf("%s is less than %s: %s\n", a.to_s, b.to_s, a < b)
    printf("Pair of %s is: %s\n", a.to_s, a.pair.inspect)

    puts "_______________________________________________"
    printf("%s lowest term: %s\n", a.to_s, a.to_lowest_terms.to_s)
    printf("%s is int: %s\n", a.to_s, a.int?)
    printf("%s is <=> %s: %s\n", a.to_s, b.to_s, a <=> b)

    printf("%s + %s = %s\n", a.to_s, b.to_s, (a+b).to_s)
    printf("%s x %s = %s\n", a.to_s, b.to_s, (a*b).to_s)
    printf("%s / %s = %s\n", a.to_s, b.to_s, (a/b).to_s)
    printf("%s inverse: %s\n", b.to_s, b.invert.to_s)
    
    n = 3
    hSum = harmonicSum(n)
    printf("Harmonic sum n = %d = %s\n", n, hSum.to_s)

    int = -5
    printf("New int = %d, rational of %d = %s\n", int, int, int.to_mr.to_s)
end

def insertionSort(lst)
    cpy = lst[0 .. lst.length]
    i = 1
    while i < lst.length do
        j = i
        while j > 0 do
            if cpy[j] < cpy[j-1] 
                cpy[j-1], cpy[j] = cpy[j], cpy[j-1]
            end
            j = j - 1
        end
        i += 1
    end
    return cpy
end


a = MyRational.new(-6, 2)
b = MyRational.new(-3, 4)

testRational(a, b)

puts "_______________________________________________"
# test insertion sort

# https://www.rubyguides.com/2015/03/ruby-random/
def generate_to_s()
    randomNum = rand(1..20)
    charset = Array('A'..'Z') + Array('a'..'z')
    str = Array.new(randomNum) { charset.sample }.join
    return str
end

n = 10000
# create random int array
randomInt = Array.new(n) {rand(1..n)}  

# https://www.codegrepper.com/code-examples/ruby/ruby+calculate+execution+time
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sortedInt = insertionSort(randomInt)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# microseconds
elapsed = (ending - starting) * 1000000
printf("Insertion sort time for int: %.2f\n", elapsed)

# create random to_s array
randomto_s = Array.new(n)
incr = 0 
while incr < n do
    randomto_s[incr] = generate_to_s()
    incr += 1
end

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sortedto_s = insertionSort(randomto_s)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# microseconds
elapsed = (ending - starting) * 1000000
printf("Insertion sort time for to_s: %.2f\n", elapsed)

# create random myRational array
randomRational = Array.new(n)
incr = 0
while incr < n do   
    randomNumerator = rand(0..n)
    randomDenominator = rand(1..n)
    r = MyRational.new(randomNumerator, randomDenominator)
    randomRational[incr] = r
    incr += 1
end

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sortedRational = insertionSort(randomRational)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# microseconds
elapsed = (ending - starting) * 1000000
printf("Insertion sort time for rational: %.2f\n", elapsed)
