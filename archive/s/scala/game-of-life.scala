import javax.swing._;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.Color;

import scala.util.Try

class Cell(var isAlive: Boolean) extends JPanel {
  var neighbors = Array[Cell]()
  var wasAlive: Boolean = isAlive
  this.updateBackground

  def updateBackground() {
    val color: Color = if (this.isAlive) Color.BLACK else Color.WHITE
    this.setBackground(color)
  }

  def addNeighbor(neighbor: Cell) {
    this.neighbors = this.neighbors :+ neighbor
  }

  def clearState() {
    this.wasAlive = this.isAlive
  }

  def countLivingNeighbors(): Int = this.neighbors.filter(n => n.wasAlive == true).length

  def transition() {
    val count = this.countLivingNeighbors
    if (this.wasAlive) {
      this.isAlive = count match {
        case c if c == 2 || c == 3 => true
        case _ => false
      }
    } else if (count == 3) {
      this.isAlive = true
    }
  }
}

class Grid (width: Int, var spawnRate: Double) extends JPanel {
  this.setMinimumSize(new Dimension(width, width));
  this.setMaximumSize(new Dimension(width, width));
  this.setPreferredSize(new Dimension(width, width));

  var grid = Array.ofDim[Cell](width, width)
  this.setLayout(new GridLayout(width, width))

  def populate() {
    for (row <- 0 to this.grid.length - 1) {
      for (col <- 0 to this.grid(row).length - 1) {
        val rand: Boolean = Math.random < spawnRate
        this.grid(row)(col) = new Cell(rand)
        this.add(this.grid(row)(col))
      }
    }
  }

  def link() {
    for (row <- 0 to this.grid.length - 1) {
      for (col <- 0 to this.grid(row).length - 1) {
        val prevRow: Int = Math.floorMod((row - 1), this.width)
        val nextRow: Int = Math.floorMod((row + 1), this.width)
        val prevCol: Int = Math.floorMod((col - 1), this.width)
        val nextCol: Int = Math.floorMod((col + 1), this.width)
        this.grid(row)(col).addNeighbor(this.grid(row)(prevCol));
        this.grid(row)(col).addNeighbor(this.grid(row)(nextCol));
        this.grid(row)(col).addNeighbor(this.grid(nextRow)(col));
        this.grid(row)(col).addNeighbor(this.grid(prevRow)(col));
        this.grid(row)(col).addNeighbor(this.grid(prevRow)(prevCol));
        this.grid(row)(col).addNeighbor(this.grid(prevRow)(nextCol));
        this.grid(row)(col).addNeighbor(this.grid(nextRow)(prevCol));
        this.grid(row)(col).addNeighbor(this.grid(nextRow)(nextCol));
      }
    }
  }

  def generate() {
    this.populate
    this.link
  }

  def step() {
    for (row <- 0 to this.grid.length - 1) {
      for (col <- 0 to this.grid(row).length - 1) {
        this.grid(row)(col).transition
        this.grid(row)(col).updateBackground
      }
    }
    for (row <- 0 to this.grid.length - 1) {
      for (col <- 0 to this.grid(row).length - 1) {
        this.grid(row)(col).clearState
      }
    }
  }
}

// default configs
class Game (
  var width: Int = 100,
  var frameRate: Double = 3.0,
  var totalFrames: Int = 200,
  var spawnRate: Double = 0.15
) {

  // additional config helpers receiving from IO
  def config(width: Int, frameRate: Double, totalFrames: Int, spawnRate: Double) = {
    this.width = width
    this.frameRate = frameRate
    this.totalFrames = totalFrames
    this.spawnRate = spawnRate
  }

  def run() {
    val frame = new JFrame("Game of Life - a Scala port")
    var grid = new Grid(this.width, this.spawnRate)
    grid.generate
    frame.getContentPane().add(grid)
    frame.pack
    frame.setVisible(true)

    for (i <- 0 to this.totalFrames) {
      try {
        val delay: Int = (1000 / this.frameRate).toInt
        Thread.sleep(delay)
      }
      catch {
        case e: InterruptedException => Thread.currentThread().interrupt
      }
      grid.step
    }
  }
}

object GameOfLife {
  def main(args: Array[String]) {
    // parse args
    val game = new Game
    // fail silently and use game default configs
    if (args.length > 3) {
      Try {
        val width: Int = args(0).toInt
        val frameRate: Double = args(1).toDouble
        val totalFrames: Int = args(2).toInt
        val spawnRate: Double = args(3).toDouble

        game.config(width, frameRate, totalFrames, spawnRate)
      }
    }

    game.run
  }
}