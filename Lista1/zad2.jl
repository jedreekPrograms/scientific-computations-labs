# Jędrzej Stefanowski

# Badanie rozmieszczenia liczb Float64 w trzech przedziałach.
# a, b - początek i koniec badanego przedziału.
# step - odstęp miedzy kolejnymi liczbami maszynowymi.
# k - numer kolejnej liczby od początku przedziału.
# x - aktualnie analizowana liczba maszynowa.
for (a, b) in ((0.5, 1.0), (1.0, 2.0), (2.0, 4.0))

    step = nextfloat(a) - a

    println("========== PRZEDZIAL [", a, ", ", b, "] ==========")
    println("Odstep dziesietnie: ", step)
    println("Odstep binarnie: 2^", exponent(step))
    println()

    for k in 0:5
        x = a + k * step
        println("k = ", k, ", x = ", x)
    end

    println()
    println("Ostatnia liczba przed koncem: ", prevfloat(b))
    println("Odstep od ostatniej liczby do konca: ", b - prevfloat(b))
    println()
end

println("========== BITSTRING ==========")

step = 2.0^(-52)

# bits - binarna reprezentacja liczby x.
for k in 0:3
    x = 1.0 + k * step

    bits = bitstring(x)

    println("k = ", k, ", x = ", x)
    println("Znak:      ", bits[1])
    println("Wykladnik: ", bits[2:12])
    println("Mantysa:   ", bits[13:64])
    println()
end
