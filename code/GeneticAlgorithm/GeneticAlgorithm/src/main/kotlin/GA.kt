import java.lang.Math.random

/**
 * Implementação do Algoritmo Genético, inspirado em mutações genéticas a nivel bioloógico.
 * O agoritmo admite 3 fases por cada ciclo (epoch):
 *    Seleção --------> Reprodução ---------> Mutação
 *
 * @param T é o tipo do invididuo.
 * @property population a collection of individuals to start optimization.
 * @property score a function which scores the fitness of an individual. Higher fitness is better. É o numero total de conflitos, menor numero = maior fitness
 * @property cross a function which implements the crossover of two individuals resulting in a child.
 * @property mutate a function which mutates a given individual.
 * @property select a function which implements a selection strategy of an individual from the population.
 */
class GA<T>(
    var population: Collection<T>,
    val score: (individual: T) -> Double,
    val cross: (parents: Pair<T, T>) -> T,
    val mutate: (individual: T) -> T,
    val select: (scoredPopulation: Collection<Pair<Double, T>>) -> T) {

    /**
     * @return O melhor individuo, após o número de epochs ter executado sob a população dada.
     *
     * @param epochs - numero de epochs (ciclos de mutação)
     * @param mutationProbability - valor entre 0 e 1 que define a probabilidade do Filho ser mutado
     */
    fun run(epochs: Int = 1000, mutationProbability: Double = 0.1): T {
        var scoredPopulation = population.map { Pair(score(it), it) }.sortedByDescending { it.first }

        for (i in 0..epochs)
            scoredPopulation = scoredPopulation
                .map { Pair(select(scoredPopulation), select(scoredPopulation)) }
                .map { cross(it) }
                .map { if (random() <= mutationProbability) mutate(it) else it }
                .map { Pair(score(it), it) }
                .sortedByDescending { it.first }

        return scoredPopulation.first().second
    }

}
/**
* Exemplo do Array Binário, obter o máximo numero de 1's possivel num individuo.
*/
fun binaryArrayExample() : List<Int>{
    val population = (1..100).map { (1..10).map { if (random() < 0.5) 0 else 1 } }
    val algorithm = GA(
        population,
        score = { it.count{it==1}.toDouble()},
        cross = ::crossover,
        mutate = ::mutation,
        select = ::fitnessProportionateSelection
    )
    return algorithm.run()
}



fun sudokuSolver(template : String) : List<List<Cell>> {
    val boardTemplate = getBoardFromTemplate(template)
    println("Initial Board: ")
    boardTemplate.print()
    println()
    println()
    val population = (1 .. 100).map {boardTemplate.fillWithRandValues().board}

    val algorithm = GA<List<List<Cell>>>(
        population,
        score = {81 - Board(it).getTotalCost().toDouble()},
        cross = ::sudokuCrossover,
        mutate = ::sudokuMutation,
        select = ::sudokuSelectionTournament
    )
    return algorithm.run()
}


fun main(){

    //val result = binaryArrayExample()
    val result = sudokuSolver(".5..83.17...1..4..3.4..56.8....3...9.9.8245....6....7...9....5...729..861.36.72.4") //result vai ser uma board com Score é 0

    print("Best individual: ")
    result.forEach { print(it) }
}