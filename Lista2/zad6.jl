
# Jędrzej Stefanowski
# Obliczenia naukowe - Lista 2, zadanie 6

using Plots

# c - stała z polecenia.
# x - aktualna wartość ciągu, początkowo x0.
# wyniki - tablica przechowująca wartości od x0 do x40.
function oblicz(c, x)
    wyniki = [x]

    println("n = 0, x = ", x)

    for n in 1:40
        x = x^2 + c
        push!(wyniki, x)
        println("n = ", n, ", x = ", x)
    end

    return wyniki
end

# Obliczamy wszystkie przypadki osobno.
# w1, w2, ..., w7 - tablice wyników dla siedmiu
# przypadków podanych w poleceniu.
# Każda tablica przechowuje x0 oraz 40 kolejnych wartości.
println("========== PRZYPADEK 1 ==========")
w1 = oblicz(-2.0, 1.0)

println("========== PRZYPADEK 2 ==========")
w2 = oblicz(-2.0, 2.0)

println("========== PRZYPADEK 3 ==========")
w3 = oblicz(-2.0, 1.99999999999999)

println("========== PRZYPADEK 4 ==========")
w4 = oblicz(-1.0, 1.0)

println("========== PRZYPADEK 5 ==========")
w5 = oblicz(-1.0, -1.0)

println("========== PRZYPADEK 6 ==========")
w6 = oblicz(-1.0, 0.75)

println("========== PRZYPADEK 7 ==========")
w7 = oblicz(-1.0, 0.25)

# Wypisujemy końcowe wartości.
println("========== WYNIKI PO 40 ITERACJACH ==========")

println("Przypadek 1: ", w1[end])
println("Przypadek 2: ", w2[end])
println("Przypadek 3: ", w3[end])
println("Przypadek 4: ", w4[end])
println("Przypadek 5: ", w5[end])
println("Przypadek 6: ", w6[end])
println("Przypadek 7: ", w7[end])

# Wykres dla c = -2.
wykres1 = plot(0:40, w1,
    label="x0 = 1",
    xlabel="Numer iteracji n",
    ylabel="Wartość x",
    title="Zadanie 6 - c = -2",
    linewidth=2,
    size=(1100, 600))

plot!(wykres1, 0:40, w2, label="x0 = 2", linewidth=2)
plot!(wykres1, 0:40, w3, label="x0 = 1.99999999999999", linewidth=2)

savefig(wykres1, joinpath(@__DIR__, "zad6_c_minus2.png"))
display(wykres1)

# Wykres dla c = -1.
wykres2 = plot(0:40, w4,
    label="x0 = 1",
    xlabel="Numer iteracji n",
    ylabel="Wartość x",
    title="Zadanie 6 - c = -1",
    linewidth=2,
    size=(1100, 600))

plot!(wykres2, 0:40, w5, label="x0 = -1", linewidth=2)
plot!(wykres2, 0:40, w6, label="x0 = 0.75", linewidth=2)
plot!(wykres2, 0:40, w7, label="x0 = 0.25", linewidth=2)

savefig(wykres2, joinpath(@__DIR__, "zad6_c_minus1.png"))
display(wykres2)

# argumenty - wartości x wykorzystane do rysowania paraboli.
# wartosci_paraboli - wartości funkcji x^2 - 1.
# wykres3 - wykres paraboli, prostej y = x i kroków iteracji.
argumenty = -1.5:0.01:1.5
wartosci_paraboli = [x^2 - 1 for x in argumenty]

wykres3 = plot(argumenty, wartosci_paraboli,
    label="y = x^2 - 1",
    xlabel="x",
    ylabel="y",
    title="Iteracja graficzna: c = -1, x0 = 0.75",
    linewidth=2,
    size=(900, 700),
    aspect_ratio=:equal)

plot!(wykres3, argumenty, argumenty,
    label="y = x",
    linewidth=2)

# Rysujemy kolejne kroki iteracji.
x = 0.75

for n in 1:12
    global x
    y = x^2 - 1

    plot!(wykres3, [x, x], [x, y],
        label="", color=:gray)

    plot!(wykres3, [x, y], [y, y],
        label="", color=:gray)

    x = y
end

savefig(wykres3, joinpath(@__DIR__, "zad6_iteracja_graficzna.png"))
display(wykres3)

println("Wykresy zapisano w folderze z plikiem zadania.")
