# Jędrzej Stefanowski
# Obliczenia naukowe - Lista 2, zadanie 1

# Oblicza iloczyn skalarny przez sumowanie w przód.
# x, y - wektory wejściowe.
# T - typ arytmetyki (Float32 lub Float64).
# s - aktualna suma częściowa.
function sum_forward(x, y, T)
    s = T(0)

    for i in 1:length(x)
        s = s + x[i] * y[i]
    end

    return s
end

# Oblicza iloczyn skalarny przez sumowanie w tyl.
# x, y - wektory wejściowe.
# T - typ arytmetyki (Float32 lub Float64).
# s - aktualna suma częściowa.
function sum_backward(x, y, T)
    s = T(0)

    for i in length(x):-1:1
        s = s + x[i] * y[i]
    end

    return s
end


# Oblicza iloczyn skalarny, sumując osobno składniki
# dodatnie i ujemne, posortowane według wartości bezwzględnej.
# x, y - wektory wejściowe.
# T - typ arytmetyki.
# ascending - true: od najmniejszych modułów (metoda d).
# ascending - false: od największych modułów (metoda c).
# products - iloczyny odpowiadających sobie elementów.
# positive, negative - dodatnie i ujemne iloczyny.
# positive_sum, negative_sum - ich sumy częściowe.
function sum_sorted(x, y, T, ascending)
    products = x .* y

    positive = filter(p -> p > T(0), products)
    negative = filter(p -> p < T(0), products)

    if ascending
        sort!(positive)
        sort!(negative; rev=true)
    else
        sort!(positive; rev=true)
        sort!(negative)
    end

    positive_sum = T(0)
    negative_sum = T(0)

    for p in positive
        positive_sum += p
    end

    for p in negative
        negative_sum += p
    end

    return positive_sum + negative_sum
end



# Wartość referencyjna dla starych danych.
correct_old = -1.00657107000000e-11

# Wartość referencyjna dla zmodyfikowanych danych.
correct_new = -0.004296343192495245

# Porównanie wyników dla obu typów arytmetyki.
for T in (Float32, Float64)

    x_old = T.([2.718281828, -3.141592654,
        1.414213562, 0.5772156649,
        0.3010299957])

    x_new = T.([2.718281828, -3.141592654,
        1.414213562, 0.577215664,
        0.301029995])

    y = T.([1486.2497, 878366.9879,
        -22.37492, 4773714.647,
        0.000185049])

    # Wyniki dla danych z Listy 1.
    old_results = [
        sum_forward(x_old, y, T),
        sum_backward(x_old, y, T),
        sum_sorted(x_old, y, T, false),
        sum_sorted(x_old, y, T, true)
    ]

    # Wyniki dla danych z Listy 2.
    new_results = [
        sum_forward(x_new, y, T),
        sum_backward(x_new, y, T),
        sum_sorted(x_new, y, T, false),
        sum_sorted(x_new, y, T, true)
    ]

    names = [
        "(a) W przod",
        "(b) W tyl",
        "(c) Od najwiekszego",
        "(d) Od najmniejszego"
    ]

    println("========== ", T, " ==========")
    println("Stara wartosc poprawna: ", correct_old)
    println("Nowa wartosc poprawna: ", correct_new)

    for i in 1:4
        old_result = old_results[i]
        new_result = new_results[i]

        # Zmiana wyniku po modyfikacji danych.
        difference = new_result - old_result

        # Błędy dla nowych danych.
        absolute_error = abs(Float64(new_result) - correct_new)
        relative_error = absolute_error / abs(correct_new)

        println()
        println(names[i])
        println("Stary wynik: ", old_result)
        println("Nowy wynik: ", new_result)
        println("Zmiana wyniku: ", difference)
        println("Blad bezwzgledny: ", absolute_error)
        println("Blad wzgledny: ", relative_error)
    end

    println()
end

