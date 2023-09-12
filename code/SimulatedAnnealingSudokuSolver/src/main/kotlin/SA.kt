import kotlin.math.exp
import kotlin.random.Random

private const val MINIMUM_TEMPERATURE = 0.0001
private const val ITERATIONS_PER_TEMPERATURE = 1000
private const val COOLING_RATE = 0.99

fun SA(template: String): Board {
    val initialBoard = getBoardFromTemplate(template)
    initialBoard.print()

    var currentBoard = initialBoard.fillWithRandValues()
    var currentCost = currentBoard.getTotalCost()

    var temperature = calculateStartingTemperature(template)

    var stuckCounter = 0
    var previousCost = 0

    while (currentCost > 0 && temperature > 0.0) {
        previousCost = currentCost
        for (iter in 1..ITERATIONS_PER_TEMPERATURE) {
            println(currentCost)
            val newBoard = currentBoard.generateNextBoard()
            val newCost = newBoard.getTotalCost()
            val diff = newCost - currentCost

            if (newCost < currentCost) {
                currentBoard = newBoard
                currentCost = newCost
            } else if (exp(-diff / temperature) > Random.nextDouble()) {
                currentBoard = newBoard
                currentCost = newCost
            }
        }

        if (currentCost >= previousCost) {
            stuckCounter += 1
        } else {
            stuckCounter = 0
        }
        if (stuckCounter > 100){
            //re-heat
            temperature += 2
        }

        temperature *= COOLING_RATE
    }
    return currentBoard
}