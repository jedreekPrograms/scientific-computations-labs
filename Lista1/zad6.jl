# Jędrzej Stefanowski

# Oblicza wartosc f(x) = sin(x) + cos(3*x).
# x - argument funkcji typu Float64.
function f(x)
    return sin(x) + cos(3 * x)
end

# Oblicza pochodna f'(x) ze wzoru analitycznego.
# x - punkt obliczania pochodnej.
function derivative(x)
    return cos(x) - 3 * sin(3 * x)
end

# x0 - punkt, w którym obliczamy pochodna.
# exact - wartosc pochodnej ze wzoru analitycznego.
# errors - tablica błędów bezwzględnych.
x0 = 1.0
exact = derivative(x0)

errors = Float64[]

println("Dokladna pochodna: ", exact)
println()

# n - numer kroku, od 0 do 54.
# h - krok różnicowy równy 2^(-n).
# xh - punkt x0 + h.
# approximation - przybliżenie pochodnej z ilorazu różnicowego.
# error - blad bezwzględny danego przybliżenia.
for n in 0:54
    h = 2.0^(-n)

    xh = x0 + h

    approximation = (f(xh) - f(x0)) / h

    error = abs(exact - approximation)

    push!(errors, error)

    println("n = ", n)
    println("h = ", h)
    println("1 + h = ", xh)
    println("Przyblizenie: ", approximation)
    println("Blad: ", error)
    println("Czy 1 + h == 1? ", xh == x0)
    println()
end

# best_index - indeks najmniejszego błędu w tablicy.
# best_n - odpowiadająca mu wartosc n.
best_index = argmin(errors)
best_n = best_index - 1

println("========== NAJLEPSZY WYNIK ==========")
println("n = ", best_n)
println("h = ", 2.0^(-best_n))
println("Najmniejszy blad: ", errors[best_index])
