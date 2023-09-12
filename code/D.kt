fun geneticAlgorithm(board: String): String {}

fun solve(board: String): String {

    geneticAlgorithm(board)
}

fun main() {
    var board = ".5..83.17...1..4..3.4..56.8....3...9.9.8245....6....7...9....5...729..861.36.72.4"
    println(board)

    board = solve(board)
    println(board)

}