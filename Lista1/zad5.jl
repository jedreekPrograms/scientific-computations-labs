# Jędrzej Stefanowski

# Oblicza wartosc funkcji f(x) = sqrt(1 + x^2) - 1.
# x - argument funkcji typu Float64.
function f(x)
    return sqrt(x^2 + 1.0) - 1.0
end

# Oblicza wartosc algebraicznie przekształconej funkcji g.
# x - argument funkcji typu Float64.
# Postać g unika odejmowania dwóch bliskich liczb.
function g(x)
    return x^2 / (sqrt(x^2 + 1.0) + 1.0)
end

# n - numer eksperymentu, x = 8^(-n).
# result_f, result_g - wyniki obu postaci funkcji.
for n in 1:15
    x = 8.0^(-n)

    result_f = f(x)
    result_g = g(x)

    println("n = ", n)
    println("x = ", x)
    println("f(x) = ", result_f)
    println("g(x) = ", result_g)
    println()
end



# step - odstęp miedzy 1 a następna liczba Float64.
# x2 - kwadrat badanego argumentu.
# sum - wynik dodawania 1 + x2 w arytmetyce Float64.
step = nextfloat(1.0) - 1.0

println("Odstep miedzy 1 a nastepna liczba: 2^", exponent(step))
println()

for n in 8:10
    x = 8.0^(-n)
    x2 = x^2
    sum = 1.0 + x2

    println("n = ", n)
    println("x = 2^", exponent(x))
    println("x^2 = 2^", exponent(x2))
    println("x^2 / odstep = ", x2 / step)

    println("1 + x^2 = ", sum)
    println("Czy 1 + x^2 == 1? ", sum == 1.0)

    println("f(x) = ", f(x))
    println("g(x) = ", g(x))
    println()
end
