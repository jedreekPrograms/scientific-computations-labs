# Jędrzej Stefanowski

# Znajduje najmniejsze x z przedziału (1, 2),
# dla którego x * (1/x) jest różne od 1.
# Funkcja nie przyjmuje argumentów.
# x - aktualnie sprawdzana liczba Float64.
# k - numer kolejnej liczby maszynowej po 1.
# reciprocal - obliczona odwrotność liczby x.
# result - wynik mnożenia x przez reciprocal.
# Zwraca x, k, reciprocal, result lub nothing.
function find_smallest_x()
    x = nextfloat(1.0)
    k = 1

    while x < 2.0
        reciprocal = 1.0 / x
        result = x * reciprocal

        if result != 1.0
            return x, k, reciprocal, result
        end

        x = nextfloat(x)
        k += 1
    end

    return nothing
end

# answer - wynik wyszukiwania.
# previous - liczba maszynowa bezpośrednio przed znalezionym x.
answer = find_smallest_x()

if answer === nothing
    println("Nie znaleziono takiej liczby.")
else
    x, k, reciprocal, result = answer

    println("Najmniejsze x: ", x)
    println("Numer k: ", k)
    println("1/x: ", reciprocal)
    println("x * (1/x): ", result)
    println("Czy wynik jest rozny od 1? ", result != 1.0)
    println("Blad bezwzgledny: ", abs(result - 1.0))

    previous = prevfloat(x)
    println()
    println("Poprzednia liczba: ", previous)
    println("Wynik dla poprzedniej: ",
        previous * (1.0 / previous))
end
