const val BOARD_SIDE = 9
const val BLOCK_SIDE = 3

data class Cell(val number: Int, val fixed: Boolean = false)
data class Position(val row: Int, val col: Int)


class Board(val board: List<List<Cell>>) {

    fun print() {
        val blockSize = 3
        for (i in 0 until BOARD_SIDE) {
            if (i % blockSize == 0) {
                println("+-------+-------+-------+")
            }
            for (j in 0 until BOARD_SIDE) {
                if (j % blockSize == 0) {
                    print("| ")
                }
                val elem = board[i][j]
                print("${elem.number} ")
            }
            println("|")
        }
        println("+-------+-------+-------+")
    }

    fun fillWithRandValues(): Board {
        val matrix = board.toMutableList()
        val newMatrix = matrix.map { it.toMutableList() }
        val blockSize = BLOCK_SIDE
        for (blockIndex in 0 until BOARD_SIDE) {
            val rowIndex = (blockIndex / blockSize) * blockSize
            val colIndex = (blockIndex % blockSize) * blockSize
            val currBlockValues = getBlock(blockIndex).filter { it.number != 0 }.map { it.number }.toMutableList()
            for (row in rowIndex until rowIndex + blockSize) {
                for (col in colIndex until colIndex + blockSize) {
                    if (newMatrix[row][col].number == 0) {
                        val value = (1..9).filter { !currBlockValues.contains(it) }.random()
                        currBlockValues.add(value)
                        newMatrix[row][col] = Cell(value)
                    }
                }
            }
        }
        return Board(newMatrix)
    }

    fun get(pos: Position): Cell =
        board[pos.row][pos.col]

    fun insert(pos: Position, digit: Int): Board {
        val newMatrix = board.toMutableList()
        val newRow = board[pos.row].toMutableList()
        newRow[pos.col] = Cell(digit)
        newMatrix[pos.row] = newRow
        return Board(newMatrix)
    }

    fun insertCell(pos : Position, cell : Cell): Board{
        val newMatrix = board.toMutableList()
        val newRow = board[pos.row].toMutableList()
        newRow[pos.col] = cell
        newMatrix[pos.row] = newRow
        return Board(newMatrix)
    }

    fun getRow(row: Int): List<Cell> =
        board[row]

    fun getColumn(col: Int): List<Cell> =
        board.map { it[col] }

    fun getBlock(blockIndex: Int): List<Cell> {
        val rowIndex = (blockIndex / BLOCK_SIDE) * BLOCK_SIDE
        val colIndex = (blockIndex % BLOCK_SIDE) * BLOCK_SIDE
        val block = mutableListOf<Cell>()
        for (row in rowIndex until rowIndex + BLOCK_SIDE) {
            for (col in colIndex until colIndex + BLOCK_SIDE) {
                block.add(board[row][col])
            }
        }
        return block
    }

    fun getBlockPositions(blockIndex: Int): Map<Int, Position> {
        val rowIndex = (blockIndex / BLOCK_SIDE) * BLOCK_SIDE
        val colIndex = (blockIndex % BLOCK_SIDE) * BLOCK_SIDE
        val positions = mutableMapOf<Int, Position>()
        for (row in rowIndex until rowIndex + BLOCK_SIDE) {
            for (col in colIndex until colIndex + BLOCK_SIDE) {
                val elem = board[row][col]
                if(!elem.fixed) {
                    positions[elem.number] = Position(row, col)
                }
            }
        }
        return positions
    }

    fun getErrorsRow(row: Int): Int =
        getRow(row).groupingBy { it.number }.eachCount().values.count { it > 1 }

    fun getErrorsColumn(col: Int): Int =
        getColumn(col).groupingBy { it.number }.eachCount().values.count { it > 1 }

    fun getTotalCost(): Int {
        var rows = 0
        var cols = 0
        for (index in 0 until BOARD_SIDE) {
            rows += getErrorsRow(index)
            cols += getErrorsColumn(index)
        }
        return rows + cols
    }
    //improve this code, implement solo indexing
    fun generateNextBoard(): Board {
        val randBlockIndex = (0..8).random()
        val block = getBlock(randBlockIndex).filter { !it.fixed }
        val posBlock = getBlockPositions(randBlockIndex)
        val idx1 = block.indices.random()
        val idx2 = block.indices.filter { it != idx1 }.random()
        val elem1 = block[idx1].number
        val elem2 = block[idx2].number
        val pos1 = posBlock[elem1]!!
        val pos2 = posBlock[elem2]!!
        return insert(pos1, elem2).insert(pos2, elem1)
    }
}

fun getBoardFromTemplate(template: String): Board =
    Board(template.toList().map { char ->
        return@map when (char) {
            '.' -> Cell(0, false)
            char -> Cell(char.toString().toInt(), true)
            else -> {
                throw Exception("Wrong template format")
            }
        }
    }.chunked(BOARD_SIDE))
