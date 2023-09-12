import org.junit.jupiter.api.Test
import kotlin.test.assertEquals

class BoardTests {
    private val template =
                "524437689" +
                "697159273" +
                "813682415" +
                "431675481" +
                "586189932" +
                "792234765" +
                "289715842" +
                "645293913" +
                "317864756"
    @Test
    fun `Test error counter on columns`() {
        val board = getBoardFromTemplate(template)

        assertEquals(1, board.getErrorsRow(0))
        assertEquals(2, board.getErrorsRow(1))
        assertEquals(2, board.getErrorsRow(2))
        assertEquals(2, board.getErrorsRow(3))
        assertEquals(2, board.getErrorsRow(4))
        assertEquals(2, board.getErrorsRow(5))
        assertEquals(2, board.getErrorsRow(6))
        assertEquals(2, board.getErrorsRow(7))
        assertEquals(2, board.getErrorsRow(8))
    }

    @Test
    fun `Test error counter on rows`() {
        val board = getBoardFromTemplate(template)

        assertEquals(2, board.getErrorsColumn(0))
        assertEquals(3, board.getErrorsColumn(1))
        assertEquals(1, board.getErrorsColumn(2))
        assertEquals(3, board.getErrorsColumn(3))
        assertEquals(2, board.getErrorsColumn(4))
        assertEquals(3, board.getErrorsColumn(5))
        assertEquals(3, board.getErrorsColumn(6))
        assertEquals(2, board.getErrorsColumn(7))
        assertEquals(3, board.getErrorsColumn(8))
    }

    @Test
    fun `Test getTotalCost`(){
        val board = getBoardFromTemplate(template)
        assertEquals(39, board.getTotalCost())
    }


}