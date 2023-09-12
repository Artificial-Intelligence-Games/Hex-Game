import kotlin.random.Random

/**
 * Implements crossover using single-point crossover.
 */
fun crossover(parents: Pair<List<Int>, List<Int>>): List<Int> {
    val crossoverPoint = (0 until parents.first.count()).random()
    return parents.first.take(crossoverPoint) + parents.second.drop(crossoverPoint)
}

/**
 * Faz o crossover entre 2 parentes, pora gerar um filho. O filho resultante terá os primeiros n blocos do parent1,
 * até um crosspoint gerado randomly, e os restantes blocos do parent2.
 */
fun sudokuCrossover(parents: Pair<List<List<Cell>>, List<List<Cell>>>): List<List<Cell>> {
    val crossoverPoint = (0..7).random()
    val child: MutableList<MutableList<Cell>> = mutableListOf()

    for (i in 0 until 9) {
        val row: MutableList<Cell> = mutableListOf()
        for (j in 0 until 9) {
            val cell = Cell(0) // Initialize every cell with the digit 0
            row.add(cell)
        }
        child.add(row)
    }
    println("Parent 1: ")
    Board(parents.first).print()

    println("Parent 2: ")
    Board(parents.second).print()
    var childBoard = Board(child)


    var blockPositions : List<Pair<Int,Position>>
    var block : List<Cell>

    val parent1 = Board(parents.first)
    val parent2 = Board(parents.second)

   for(i in  0 .. crossoverPoint){
       block = parent1.getBlock(i)
       blockPositions = parent1.getBlockPositions(i).toList()
       println(blockPositions.size)
       blockPositions.forEach {
           childBoard = childBoard.insertCell(it.second,block[i])
       }
   }


    for(i in crossoverPoint+1 .. 8 ){
        block = parent2.getBlock(i)
        blockPositions = parent2.getBlockPositions(i).toList()
        blockPositions.forEach {
            childBoard = childBoard.insertCell(it.second,block[i])
        }
    }

    childBoard.print()

    return childBoard.board
}



