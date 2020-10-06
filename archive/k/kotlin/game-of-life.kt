import java.awt.BasicStroke
import java.awt.Color
import java.awt.Dimension
import javax.swing.JFrame
import javax.swing.JLabel
import javax.swing.SwingConstants.LEADING
import javax.swing.border.StrokeBorder
import kotlin.random.Random

class GUI(title: String, val _width: Int, val frameRate: Int, val totalFrames: Int, val spawnRate: Float) : JFrame() {

    private lateinit var board: BooleanArray
    private lateinit var labels: List<JLabel>


    init {
        createUI(title)
    }

    private fun createUI(title: String) {
        val cellSize = 16
        board = newboard(_width)
        labels = board.map {
            JLabel("", null, LEADING).apply {
                size = Dimension(cellSize, cellSize)
                background = Color.white
                isOpaque = true
                border = StrokeBorder(BasicStroke(2f, 1, 1))
            }
        }
        setTitle(title)
        defaultCloseOperation = JFrame.EXIT_ON_CLOSE
        setSize(_width * cellSize, _width * cellSize)
        isVisible = true
        setLocationRelativeTo(null)
        layout = java.awt.GridLayout(_width, _width)
        for (l in labels) {
            add(l)
        }
    }

    public fun run() {
        for (i in 0 until totalFrames) {
            try {
                Thread.sleep((1000 / frameRate).toLong())
            } catch (ex: InterruptedException) {
                Thread.currentThread().interrupt()
            }
            board = simulate(board, _width)
            setLabels(board, labels, _width)
        }
    }

    private fun setLabels(grid: BooleanArray, labels: List<javax.swing.JLabel>, size: Int) {
        for (x in 0 until size) {
            for (y in 0 until size) {
                labels[x + y * size].background = if (board[x + y * size]) Color.black else Color.white
                labels[x + y * size].repaint()
            }
        }
    }

    private fun newboard(size: Int): BooleanArray {
        val board = BooleanArray(size * size)
        for (x in 0 until size) {
            for (y in 0 until size) {
                board[x + y * size] = Random.nextFloat() > spawnRate
            }
        }
        return board
    }

    private fun simulate(board: BooleanArray, w: Int): BooleanArray {
        for (x in 0 until w) {
            for (y in 0 until w) {
                val i = x + y * w
                var liveNeighbours = 0
                if (i - w >= 0 && board[i - w]) {
                    liveNeighbours++
                }
                if (i % w != 0 && board[i - 1]) {
                    liveNeighbours++
                }
                if ((i + 1) % w != 0 && board[i + 1]) {
                    liveNeighbours++
                }
                if (i + w < board.size && board[i + w]) {
                    liveNeighbours++
                }
                if (((i - w - 1) >= 0) && (i % w != 0) && board[i - w - 1]) {
                    liveNeighbours++
                }
                if (((i - w + 1) >= 0) && ((i + 1) % w != 0) && board[i - w + 1]) {
                    liveNeighbours++
                }
                if (((i + w - 1) < board.size) && (i % w != 0) && board[i + w - 1]) {
                    liveNeighbours++
                }
                if (((i + w + 1) < board.size) and ((i + 1) % w != 0) && board[i + w + 1]) {
                    liveNeighbours++
                }
                if (board[i] && liveNeighbours < 2 || liveNeighbours > 3) {
                    board[i] = false
                } else if (!board[i] && liveNeighbours == 3) {
                    board[i] = true
                }
            }

        }
        return board
    }
}

private fun createAndShowGUI(width: Int, frameRate: Int, totalFrames: Int, spawnRate: Float): GUI {
    val f = GUI("Game Of Life", width, frameRate, totalFrames, spawnRate)
    f.isVisible = true
    return f
}


fun main(args: Array<String>) {
    val w = if (args.size > 1) {
        args[0].toInt()
    } else 16
    val fr = if (args.size > 2) {
        args[1].toInt()
    } else 30
    val tf = if (args.size > 3) {
        args[2].toInt()
    } else 100
    val sw = if (args.size > 4) {
        args[3].toFloat()
    } else 0.5f

    val gui = createAndShowGUI(w, fr, tf, sw)
    gui.run()
}