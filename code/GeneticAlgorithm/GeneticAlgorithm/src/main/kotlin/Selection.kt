import java.lang.Math.random

/**
 * Selecão Random.
 */
fun <T> randomSelection(scoredPopulation: Collection<Pair<Double, T>>): T {
    return scoredPopulation.elementAt((random() * scoredPopulation.size.toDouble()).toInt()).second
}


/**
 * Seleção por Roleta. Seleciona um individuo com uma probabilidade proporcional ao seu score.
 */
fun <T> fitnessProportionateSelection(scoredPopulation: Collection<Pair<Double, T>>): T {
    var value= scoredPopulation.sumOf { it.first } * random()

    for ((fitness, individual) in scoredPopulation) {
        value -= fitness
        if (value <= 0) return individual
    }

    return scoredPopulation.last().second
}

/**
 * Modo de seleção por Torneio. Seleciona 5 individuos randomly da população, e retorna aquele com maior score
 */
fun <T> sudokuSelectionTournament(scoredPopulation: Collection<Pair<Double, T>>): T {
    val tournamentSize = 5

    val tournament = scoredPopulation.shuffled().take(tournamentSize)
    val winner = tournament.maxByOrNull { it.first }!!.second

    return winner
}

