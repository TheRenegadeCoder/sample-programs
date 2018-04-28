import java.util.ArrayList;
import javax.swing.*;
import java.awt.GridLayout;
import java.awt.Color;

public class GameOfLife {

  private static class Cell extends JPanel {
    private ArrayList<Cell> neighbors;
    private boolean wasAlive;
    private boolean isAlive;
    private JPanel panel;

    public Cell(boolean isAlive) {
      this.wasAlive = isAlive;
      this.isAlive = isAlive;
      this.updateBackground();
      neighbors = new ArrayList<Cell>();
    }
    
    public void updateBackground() {
      Color color = isAlive ? Color.BLACK : Color.WHITE;
      this.setBackground(color);
    }

    public void addNeighbor(Cell neighbor) {
      this.neighbors.add(neighbor);
    }

    public boolean wasAlive() {
      return this.wasAlive;
    }

    public boolean isAlive() {
      return this.isAlive;
    }

    public void clearState() {
      this.wasAlive = this.isAlive;
    }

    public int numOfLivingNeighbors() {
      int numOfLivingNeighbors = 0;
      for(Cell neighbor : this.neighbors) {
        if (neighbor.wasAlive()) {
          numOfLivingNeighbors++;
        }
      }
      return numOfLivingNeighbors;
    }

    public void transition() {
      int numOfLivingNeighbors = this.numOfLivingNeighbors();
      if (this.wasAlive() && numOfLivingNeighbors < 2) {
        this.isAlive = false;
      } else if (this.wasAlive() && (numOfLivingNeighbors == 2 || numOfLivingNeighbors == 3)) {
        this.isAlive = true;
      } else if (this.wasAlive() && numOfLivingNeighbors > 3) {
        this.isAlive = false;
      } else if (!this.wasAlive() && numOfLivingNeighbors == 3) {
        this.isAlive = true;
      }
    }
  }

  private static class Grid extends JPanel {
    int width;
    Cell[][] grid;

    public Grid(int width) {
      this.width = width;
      this.grid = new Cell[width][width];
      this.setLayout(new GridLayout(width, width));
    }
    
    private void populate() {
      for (int row = 0; row < this.grid.length; row++) {
        for (int col = 0; col < this.grid[row].length; col++) {
          boolean rand = Math.random() < .15;
          this.grid[row][col] = new Cell(rand);
          this.add(this.grid[row][col]);
        }
      }
    }

    private void link() {
      for (int row = 0; row < this.grid.length; row++) {
        for (int col = 0; col < this.grid[row].length; col++) {
          int previousRow = Math.floorMod((row - 1), this.width);
          int nextRow = Math.floorMod((row + 1), this.width);
          int previousCol = Math.floorMod((col - 1), this.width);
          int nextCol = Math.floorMod((col + 1), this.width);
          this.grid[row][col].addNeighbor(this.grid[row][previousCol]);
          this.grid[row][col].addNeighbor(this.grid[row][nextCol]);
          this.grid[row][col].addNeighbor(this.grid[nextRow][col]);
          this.grid[row][col].addNeighbor(this.grid[previousRow][col]);
          this.grid[row][col].addNeighbor(this.grid[previousRow][previousCol]); 
          this.grid[row][col].addNeighbor(this.grid[previousRow][nextCol]); 
          this.grid[row][col].addNeighbor(this.grid[nextRow][previousCol]);
          this.grid[row][col].addNeighbor(this.grid[nextRow][nextCol]);
        }
      }
    }

    public void generate() {
      this.populate();
      this.link();
    }

    public void step() {
      for (int row = 0; row < this.grid.length; row++) {
        for (int col = 0; col < this.grid[row].length; col++) {
          this.grid[row][col].transition();
          this.grid[row][col].updateBackground();
        }
      }
      for (int row = 0; row < this.grid.length; row++) {
        for (int col = 0; col < this.grid[row].length; col++) {
          this.grid[row][col].clearState();
        }
      }
    }

    public String toString() {
      StringBuilder builder = new StringBuilder();
      for (int row = 0; row < this.grid.length; row++) {
        for (int col = 0; col < this.grid[row].length; col++) {
          if (this.grid[row][col].isAlive()) {
            builder.append(this.grid[row][col].numOfLivingNeighbors());
          } else {
            builder.append("X");
          }
        }
        builder.append("\n");
      }
      return builder.toString();
    }
  }

  public static void main(String[] args) {
    JFrame frame = new JFrame("SudokuMCVE");
    Grid grid = new Grid(100);
    grid.generate();
    frame.getContentPane().add(grid);
    frame.pack();
    frame.setVisible(true);
    for (int i = 0; i < 200; i++) {
      System.out.println(grid.toString());
      try        
      {
        Thread.sleep(300);
      } 
      catch(InterruptedException ex) 
      {
        Thread.currentThread().interrupt();
      }
      grid.step();
    }
  }
}
