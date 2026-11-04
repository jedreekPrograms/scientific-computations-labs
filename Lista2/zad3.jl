# Jędrzej Stefanowski
# Obliczenia naukowe - Lista 2, zadanie 3

using Plots

# Oblicza wartość funkcji zgodnie z podanym wzorem.
# x - argument funkcji.
function f(x)
    return exp(x) * log(1.0 + exp(-x))
end

# Oblicza tę samą funkcję w sposób dokładniejszy numerycznie.
# x - argument funkcji.
# log1p oblicza log(1 + z) dokładniej dla małych wartości z.
function g(x)
    return exp(x) * log1p(exp(-x))
end

# Porównujemy wyniki dla wybranych argumentów.
# x - aktualny argument funkcji.
# result_f - wynik bezpośredniego obliczenia.
# result_g - wynik dokładniejszej postaci.
for x in (0.0, 1.0, 5.0, 10.0, 20.0, 30.0, 35.0, 36.0, 37.0, 40.0, 50.0)

    result_f = f(x)
    result_g = g(x)

    println("x = ", x)
    println("f(x) = ", result_f)
    println("g(x) = ", result_g)
    println("1 + exp(-x) = ", 1.0 + exp(-x))
    println()
end

# Przygotowujemy argumenty i wartości obu funkcji.
# xs - argumenty od 0 do 50.
# ys_f, ys_g - wartości funkcji dla kolejnych argumentów.
xs = 0.0:0.1:50.0

ys_f = [f(x) for x in xs]
ys_g = [g(x) for x in xs]

# Rysujemy wykres funkcji obliczonej bezpośrednio.
p = plot(xs, ys_f,
    label="Bezpośrednie obliczenie",
    xlabel="x",
    ylabel="Wartość funkcji",
    title="Zadanie 3 - porównanie wyników",
    linewidth=2,
    legend=:bottomleft,
    size=(1100, 600),
    dpi=150)

# Dodajemy wykres dokładniejszej numerycznie postaci.
plot!(p, xs, ys_g,
    label="Obliczenie z log1p",
    linewidth=2,
    linestyle=:dash)

# Dodajemy poziomą linię oznaczającą granicę funkcji.
hline!(p, [1.0],
    label="Granica = 1",
    linestyle=:dot,
    linewidth=2)

# Zapisujemy wykres do pliku PNG.
savefig(p, joinpath(@__DIR__, "zad3_wykres.png"))

display(p)

println("Wykres zapisano do pliku zad3_wykres.png")
