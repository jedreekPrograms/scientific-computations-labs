# Jędrzej Stefanowski

# Wyznacza iteracyjnie epsilon maszynowy.
# T - badany typ zmiennoprzecinkowy.
# epsilon - aktualnie sprawdzany odstęp od jedynki.
function calculate_macheps(T)
    epsilon = T(1)

    while T(1) + epsilon / T(2) > T(1)
        epsilon = epsilon / T(2)
    end

    return epsilon
end

# Precyzja znacząca: 11 / 24 / 53 bity
# calculated - wartosc wyznaczona przez własny algorytm.
# built_in - wartosc zwrócona przez funkcje wbudowaną Julii.
for T in (Float16, Float32, Float64)
    calculated = calculate_macheps(T)
    built_in = eps(T)

    println("Typ: ", T)
    println("Obliczony macheps: ", calculated)
    println("Zapis binarny: 2^", exponent(calculated))
    println("Wbudowany eps:     ", built_in)
    println("Czy są równe? ", calculated == built_in)
    println()
end

# Wyznacza najmniejszą dodatnia liczbę maszynową (eta).
# T - badany typ zmiennoprzecinkowy.
# eta - aktualnie sprawdzana dodatnia liczba.
function calculate_eta(T)
    eta = T(1)

    while eta / T(2) > T(0)
        eta = eta / T(2)
    end

    return eta
end

# calculated - wartosc wyznaczona przez własny algorytm.
# built_in - wartosc zwrócona przez funkcje wbudowaną Julii.
for T in (Float16, Float32, Float64)
    calculated = calculate_eta(T)
    built_in = nextfloat(T(0))

    println("Typ: ", T)
    println("Obliczona eta: ", calculated)
    println("Zapis binarny: 2^", exponent(calculated))
    println("Wbudowana eta: ", built_in)
    println("Czy są równe? ", calculated == built_in)
    println()
end

# Porównuje najmniejsza liczbę podnormalna i normalna.
# T - badany typ zmiennoprzecinkowy.
# eta - najmniejsza dodatnia liczba podnormalna.
# min_normal - najmniejsza dodatnia liczba znormalizowana.
function compare_minimums(T)
    eta = nextfloat(T(0))
    min_normal = floatmin(T)

    println("Typ: ", T)
    println("Eta: ", eta)
    println("Eta jako potega: 2^", exponent(eta))

    println("MINnor: ", min_normal)
    println("MINnor jako potega: 2^", exponent(min_normal))

    println("MINnor / eta: ", min_normal / eta)
    println("Stosunek jako potega: 2^",
        exponent(min_normal) - exponent(eta))
    println()
end

for T in (Float32, Float64)
    compare_minimums(T)
end

# Wyznacza iteracyjnie największą skończona liczbę maszynowa.
# T - badany typ zmiennoprzecinkowy.
# max_value - największą dotychczas znaleziona wartość.
# step - krok używany do powiększania max_value.
# candidate - testowana nowa wartość.
function calculate_max(T)
    max_value = T(1)

    while !isinf(max_value * T(2))
        max_value = max_value * T(2)
    end

    step = max_value / T(2)

    while step > T(0)
        candidate = max_value + step

        if !isinf(candidate) && candidate > max_value
            max_value = candidate
        end

        step = step / T(2)
    end

    return max_value
end

# calculated - wartosc wyznaczona przez własny algorytm.
# built_in - wartosc zwrócona przez funkcje wbudowaną Julii.
# t - liczba bitów precyzji znaczącej.
# c - wykładnik największej skończonej liczby maszynowej.
for T in (Float16, Float32, Float64)
    calculated = calculate_max(T)
    built_in = floatmax(T)

    t = precision(T)
    c = exponent(calculated)

    println("Typ: ", T)
    println("Obliczony MAX: ", calculated)
    println("Wzor binarny: (2 - 2^-", t - 1, ") * 2^", c)
    println("Wbudowany MAX: ", built_in)
    println("Czy są równe? ", calculated == built_in)
    println()
end
