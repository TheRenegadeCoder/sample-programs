import java.util.ArrayList;

public class GameOfLife {

  private class Cell {
    private ArrayList<Cell> neighbors;
    private boolean isAlive;

    public Cell(boolean isAlive) {
      this.isAlive = isAlive;
      neighbors = new ArrayList<Cell>();
    }

    public boolean isAlive() {
      return this.isAlive;
    }

    private int numOfLivingNeighbors() {
      int numOfLivingNeighbors = 0;
      for(Cell neighbor : this.neighbors) {
        if (neighbor.isAlive()) {
          numOfLivingNeighbors++;
        }
      }
      return numOfLivingNeighbors;
    }

    public void transition() {
      numOfLivingNeighbors = this.numOfLivingNeighbors();
      if (this.isAlive() && numOfLivingNeighbors < 2) {
        this.isAlive = false;
      } else if (this.isAlive() && (numOfLivingNeighbors == 2 || numOfLivingNeighbors == 3)) {
        this.isAlive = 1;
      } else if (this.isAlive() && numOfLivingNeighbors == 4) {
        this.isAlive = 0;
      } else if (!this.isAlive() && numOfLivingNeighbors == 3) {
        this.isAlive = 1;
      }
    }
  }

  public static void main(String[] args) {
    // TODO: Play game
  }
}
