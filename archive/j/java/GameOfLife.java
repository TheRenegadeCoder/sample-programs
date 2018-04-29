import java.util.ArrayList;
import javax.swing.*;
import java.awt.GridLayout;
import java.awt.Color;

public class GameOfLife {
  
  private int width;
  private int rate;
  private int totalFrames;
  
  public GameOfLife(int width, int rate, int totalFrames) {
    this.width = width;
    this.rate = rate;
    this.totalFrames = totalFrames;
  }
  
  public void run() {
    JFrame frame = new JFrame("The Renegade Coder's Game of Life");
    Grid grid = new Grid(this.width);
    grid.generate();
    frame.getContentPane().add(grid);
    frame.pack();
    frame.setVisible(true);
    for (int i = 0; i < this.totalFrames; i++) {
      try        
      {
        Thread.sleep(this.rate);
      } 
      catch(InterruptedException ex) 
      {
        Thread.currentThread().interrupt();
      }
      grid.step();
    }
  } 
  
  public static void main(String[] args) {
    GameOfLife game;
    if (args.length > 3) {
      // TODO
      game = new GameOfLife(100, 300, 200);
    } else {
      game = new GameOfLife(100, 300, 200);
    }
    game.run();
  }
    
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
  }
}
