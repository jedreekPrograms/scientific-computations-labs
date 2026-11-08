# Jędrzej Stefanowski
# Obliczenia naukowe - Lista 2, zadanie 2

using LinearAlgebra
using Random
using Plots

# Ustala ziarno generatora, aby wyniki losowych eksperymentów
# były powtarzalne podczas kolejnych uruchomień.
Random.seed!(1234)

# Funkcje udostępnione przez prowadzącego

# Tworzy macierz Hilberta o rozmiarze n.
# n - liczba wierszy i kolumn macierzy.
function hilb(n::Int)
    if n < 1
        error("size n should be >= 1")
    end

    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

# Tworzy losową macierz o zadanym uwarunkowaniu c.
# n - rozmiar macierzy, n > 1.
# c - zadany wskaźnik uwarunkowania, c >= 1.
function matcond(n::Int, c::Float64)
    if n < 2
        error("size n should be > 1")
    end

    if c < 1.0
        error("condition number c should be >= 1.0")
    end

    (U, S, V) = svd(rand(n, n))

    return U * diagm(0 => [LinRange(1.0, c, n);]) * V'
end


# Rozwiązuje układ Ax = b dwiema metodami i oblicza błędy względne.
# A - badana macierz kwadratowa.
# n - liczba wierszy macierzy.
# x - dokładne rozwiązanie złożone z jedynek.
# b - wektor prawej strony wyznaczony jako A * x.
# x_gauss, x_inverse - rozwiązania obliczone przez Julię.
# error_gauss, error_inverse - błędy względne obu metod.
# Funkcja zwraca oba błędy, aby można było narysować wykresy.
function test_matrix(A)
    n = size(A, 1)
    x = ones(Float64, n)
    b = A * x

    println("cond(A): ", cond(A))
    println("rank(A): ", rank(A))

    # NaN oznacza brak wyniku, jeżeli metoda zakończy się błędem.
    error_gauss = NaN
    error_inverse = NaN

    # Pierwsza metoda: bezpośrednie rozwiązywanie układu A \ b.
    try
        x_gauss = A \ b
        error_gauss = norm(x_gauss - x) / norm(x)
        println("Błąd względny A \\ b: ", error_gauss)
    catch e
        println("A \\ b - nie udało się rozwiązać układu: ", typeof(e))
    end

    # Druga metoda: obliczenie macierzy odwrotnej i mnożenie przez b.
    try
        x_inverse = inv(A) * b
        error_inverse = norm(x_inverse - x) / norm(x)
        println("Błąd względny inv(A) * b: ", error_inverse)
    catch e
        println("inv(A) * b - nie udało się rozwiązać układu: ", typeof(e))
    end

    println()
    return error_gauss, error_inverse
end

# -------------------- CZĘŚĆ A: MACIERZE HILBERTA --------------------

println("========== MACIERZE HILBERTA ==========")

# Tablice przechowujące rozmiary macierzy i błędy obu metod.
hilbert_sizes = Int[]
hilbert_gauss = Float64[]
hilbert_inverse = Float64[]

# Badamy macierze Hilberta o rosnącym rozmiarze.
for n in 2:15
    println("----- n = ", n, " -----")
    A = hilb(n)

    error_gauss, error_inverse = test_matrix(A)

    # Zapisujemy wyniki, aby później narysować wykres.
    push!(hilbert_sizes, n)
    push!(hilbert_gauss, error_gauss)
    push!(hilbert_inverse, error_inverse)
end


# Wykres błędów względnych dla macierzy Hilberta.
p1 = plot(hilbert_sizes, hilbert_gauss,
    label="Eliminacja Gaussa",
    xlabel="Rozmiar macierzy n",
    ylabel="Błąd względny",
    title="Macierze Hilberta - porównanie metod",
    yscale=:log10,
    legend=:outerright,
    size=(1100, 600),
    dpi=150,
    marker=:circle)

plot!(p1, hilbert_sizes, hilbert_inverse,
    label="Macierz odwrotna",
    marker=:square)


# Zapisujemy wykres jako plik PNG w folderze z programem.
savefig(p1, joinpath(@__DIR__, "hilbert_bledy.png"))
display(p1)

# -------------------- CZĘŚĆ B: MACIERZE LOSOWE --------------------

println("========== MACIERZE LOSOWE ==========")

# Zadane wskaźniki uwarunkowania dla każdego rozmiaru macierzy.
conditions = [1.0, 10.0, 1e3, 1e7, 1e12, 1e16]


# Przygotowujemy wykres dla macierzy losowych.
p2 = plot(
    xlabel="Zadany wskaźnik uwarunkowania c",
    ylabel="Błąd względny",
    title="Macierze losowe - porównanie metod",
    xscale=:log10,
    yscale=:log10,
    legend=:outerright,
    size=(1200, 650),
    dpi=150)


# Badamy trzy rozmiary macierzy.
for n in (5, 10, 20)

    # Oddzielne tablice błędów dla aktualnego rozmiaru n.
    random_gauss = Float64[]
    random_inverse = Float64[]

    # Dla każdego n badamy sześć wskaźników uwarunkowania.
    for c in conditions
        println("----- n = ", n, ", zadane c = ", c, " -----")
        A = matcond(n, c)

        error_gauss, error_inverse = test_matrix(A)

        push!(random_gauss, error_gauss)
        push!(random_inverse, error_inverse)
    end

    # Dodajemy dwie linie dla danego rozmiaru macierzy.
    # Linia ciągła: A \ b. Linia przerywana: inv(A) * b.
    plot!(p2, conditions, random_gauss,
        label="n = $n, A \\ b",
        linestyle=:solid,
        marker=:circle)

    plot!(p2, conditions, random_inverse,
        label="n = $n, inv(A) * b",
        linestyle=:dash,
        marker=:square)
end

# Zapisujemy drugi wykres do pliku PNG.
savefig(p2, joinpath(@__DIR__, "losowe_bledy.png"))
display(p2)

println("Wykresy zapisano w folderze z plikiem zadania:")
println("- hilbert_bledy.png")
println("- losowe_bledy.png")
