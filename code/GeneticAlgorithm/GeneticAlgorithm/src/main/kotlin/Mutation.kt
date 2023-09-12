import java.lang.Math.random

/**
 * Faz mutação em Bit Flip, numa lista de inteiros.
 */
fun mutation(individual: List<Int>): List<Int> {
    val mutationProbability = 1.0 / individual.count()
    return individual.map { if (random() < mutationProbability) 1 - it else it }
}

/**
 * Seleciona randomly 1 bloco da board, e depois seleciona randomly 2 números não-fixos, que serão trocados um com o outro.
 */
fun sudokuMutation(individual: List<List<Cell>>) : List<List<Cell>> {
    val blockIndex = (0 .. 8 ).random()
    var board = Board(individual)
    val blockPositions = board.getBlockPositions(blockIndex).toList()
    /**Tenta encontrar um valor desse bloco que não seja fixo**/
    var randomNum1 = (0 .. 8).random()
    var num1 = blockPositions[randomNum1]
    var value1 = board.get(num1.second)
    while(value1.fixed){
        randomNum1 = (0 .. 8).random()
        num1 = blockPositions[randomNum1]
        value1 = board.get(num1.second)
    }
    /**Tenta encontrar um valor desse bloco que não seja fixo**/
    var randomNum2 = (0 .. 8).random()
    var num2 = blockPositions[randomNum2]
    var value2 = board.get(num2.second)
    while(value2.fixed || value2 == value1){
        randomNum2 = (0 .. 8).random()
        num2 = blockPositions[randomNum2]
        value2 = board.get(num2.second)
    }

    /**Efetua a troca**/
    return board.insert(num1.second,num2.first).insert(num2.second,num1.first).board
}