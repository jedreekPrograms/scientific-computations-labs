# Jędrzej Stefanowski
# Obliczenia naukowe - Lista 2, zadanie 5

using Plots

# Oblicza kolejny wyraz ciągu modelującego wzrost populacji.
# p - wartość populacji w bieżącej iteracji.
# r - współczynnik wzrostu populacji.
function next_population(p, r)
    return p + r * p * (one(p) - p)
end

# Wartości początkowe dla obu typów arytmetyki.
# p32 - obliczenia bez obcięcia w Float32.
# p32_cut - obliczenia z obcięciem po dziesiątej iteracji.
# p64 - obliczenia bez obcięcia w Float64.
p32 = Float32(0.01)
p32_cut = Float32(0.01)
p64 = Float64(0.01)

r32 = Float32(3)
r64 = Float64(3)

# Numery iteracji i tablice wyników do wykresów.
steps = collect(0:40)
results32 = Float32[p32]
results32_cut = Float32[p32_cut]
results64 = Float64[p64]

println("========== ZADANIE 5 - WYNIKI ==========")
println("n = 0 | Float32 = ", p32,
    " | Float32 po obcięciu = ", p32_cut,
    " | Float64 = ", p64)

# Wykonujemy 40 iteracji dla trzech przebiegów.
for n in 1:40
    global p32, p32_cut, p64

    p32 = next_population(p32, r32)
    p32_cut = next_population(p32_cut, r32)
    p64 = next_population(p64, r64)


    # Po dziesiątej iteracji obcinamy wynik do trzech miejsc po przecinku.
    # Używamy obcięcia, a nie zaokrąglenia.
    if n == 10
        println()
        println("Wartość przed obcięciem (n = 10): ", p32_cut)
        p32_cut = trunc(p32_cut * Float32(1000)) / Float32(1000)
        println("Wartość po obcięciu (n = 10): ", p32_cut)
        println()
    end

    # Zapisujemy wyniki wszystkich iteracji do tablic.
    push!(results32, p32)
    push!(results32_cut, p32_cut)
    push!(results64, p64)

    # Różnice pozwalają sprawdzić wpływ obcięcia i precyzji.
    difference_cut = abs(Float64(p32) - Float64(p32_cut))
    difference_precision = abs(Float64(p32) - p64)

    println("n = ", n)
    println("Float32 bez obcięcia: ", p32)
    println("Float32 z obcięciem: ", p32_cut)
    println("Float64: ", p64)
    println("Różnica po obcięciu: ", difference_cut)
    println("Różnica Float32 i Float64: ", difference_precision)
    println()
end

# Podsumowanie ostatniej iteracji.
println("========== ITERACJA 40 ==========")
println("Float32 bez obcięcia: ", p32)
println("Float32 z obcięciem: ", p32_cut)
println("Float64: ", p64)

# Wykres 1: wpływ obcięcia po dziesiątej iteracji.
plot1 = plot(steps, results32,
    label="Float32 bez obcięcia",
    xlabel="Numer iteracji n",
    ylabel="Wartość populacji p",
    title="Wpływ obcięcia wyniku po 10 iteracjach",
    marker=:circle,
    markersize=2,
    legend=:outerright,
    size=(1150, 600),
    dpi=150)

plot!(plot1, steps, results32_cut,
    label="Float32 z obcięciem",
    linestyle=:dash,
    marker=:square,
    markersize=2)

vline!(plot1, [10],
    label="Obcięcie przy n = 10",
    linestyle=:dot)

savefig(plot1, joinpath(@__DIR__, "zad5_obciecie.png"))
display(plot1)

# Wykres 2: porównanie precyzji Float32 i Float64 bez obcinania.
plot2 = plot(steps, results32,
    label="Float32",
    xlabel="Numer iteracji n",
    ylabel="Wartość populacji p",
    title="Porównanie arytmetyki Float32 i Float64",
    marker=:circle,
    markersize=2,
    legend=:outerright,
    size=(1150, 600),
    dpi=150)

plot!(plot2, steps, results64,
    label="Float64",
    linestyle=:dash,
    marker=:square,
    markersize=2)

savefig(plot2, joinpath(@__DIR__, "zad5_precyzja.png"))
display(plot2)

println("Wykresy zapisano w folderze z programem:")
println("- zad5_obciecie.png")
println("- zad5_precyzja.png")
