# Jędrzej Stefanowski
# Obliczenia naukowe - Lista 2, zadanie 4

using Polynomials

# Oblicza wielomian Wilkinsona w postaci iloczynowej.
# x - argument, dla którego obliczamy wartość wielomianu.
# wynik - aktualna wartość iloczynu.
function p(x)
    wynik = one(x)

    for k in 1:20
        wynik = wynik * (x - k)
    end

    return wynik
end

# Współczynniki wielomianu P w postaci naturalnej.
# Są zapisane od x^20 do wyrazu wolnego.
# big"..." zachowuje dokładną wartość dużych liczb całkowitych.
wspolczynniki = [
    big"1",
    big"-210",
    big"20615",
    big"-1256850",
    big"53327946",
    big"-1672280820",
    big"40171771630",
    big"-756111184500",
    big"11310276995381",
    big"-135585182899530",
    big"1307535010540395",
    big"-10142299865511450",
    big"63030812099294896",
    big"-311333643161390640",
    big"1206647803780373360",
    big"-3599979517947607200",
    big"8037811822645051776",
    big"-12870931245150988800",
    big"13803759753640704000",
    big"-8752948036761600000",
    big"2432902008176640000"
]

# Przygotowuje współczynniki w kolejności wymaganej przez Polynomial.
# Obliczenia pierwiastków wykonujemy w arytmetyce Float64.
wspolczynniki_float = Float64.(reverse(wspolczynniki))
P = Polynomial(wspolczynniki_float)

# Oblicza pierwiastki i sprawdza otrzymane wyniki.
# wielomian - badany wielomian w postaci naturalnej.
# nazwa - opis aktualnego eksperymentu.
# symbol - nazwa wielomianu wypisywana przy wyniku.
# zera - pierwiastki uporządkowane według części rzeczywistej.
# z - aktualnie sprawdzany pierwiastek.
function sprawdz_pierwiastki(wielomian, nazwa, symbol)
    println("========== ", nazwa, " ==========")

    zera = sort(roots(wielomian), by=real)

    for k in 1:20
        z = zera[k]

        println("k = ", k)
        println("Obliczony pierwiastek z = ", z)
        println("|", symbol, "(z)| = ", abs(wielomian(z)))
        println("|p(z)| = ", abs(p(z)))
        println("|z - k| = ", abs(z - k))
        println()
    end
end

# Część (a): pierwiastki oryginalnego wielomianu.
sprawdz_pierwiastki(P, "CZĘŚĆ A - ORYGINALNY WIELOMIAN", "P")

# Część (b): zmiana współczynnika przy x^19.
# Indeks 20 odpowiada współczynnikowi przy x^19.
zmienione = copy(wspolczynniki_float)
zmienione[20] = -210.0 - 2.0^(-23)

P_zmieniony = Polynomial(zmienione)

println("Oryginalny współczynnik: ", wspolczynniki_float[20])
println("Zmieniony współczynnik: ", zmienione[20])
println("Względna zmiana: ", 2.0^(-23) / 210.0)
println()

sprawdz_pierwiastki(P_zmieniony, "CZĘŚĆ B - ZMIENIONY WIELOMIAN", "P_zmieniony")
