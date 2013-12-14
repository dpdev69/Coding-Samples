package studentCode;
import java.awt.Color;
import CMSC131GridTools.DrawingGrid;

public class LetterMaker {
  private final static int STROKE_THICKNESS = 3;
  
  // This method draws the letter of the users choice.
  public static void drawLetter(DrawingGrid grid, String letter, Color color) {
    
    // Stores the size of the grid the user choice inside a variable called size.
    int size = grid.getGridSize();
    
    // Paints the 3 by 3 square in the bottom right corner for an invalid letter choice. (Error Letter)
    if (letter.equals("error")) {
      for (int i = size - 3, i <= size - 1; i++) {
        grid.setColor(i, size - 3, color);
        grid.setColor(i, size - 2, color);
        grid.setColor(i, size - 1, color);
      }
    }
    
    // Paints the letter C.
    if (letter.equals("C")) {
      for (int i = 0; i <= size - 1; i++) {
        grid.setColor(0, i, color);
        grid.setColor(1, i, color);
        grid.setColor(2, i, color);
        grid.setColor(size - 3, i, color);
        grid.setColor(size - 2, i, color);
        grid.setColor(size - 1, i, color);
        grid.setColor(i, 0, color);
        grid.setColor(i, 1, color);
        grid.setColor(i, 2, color);
      }
    }
    
    // Paints the letter U.
    if (letter.equals("U")) {
      for (int i = 0; i <= size - 1; i++) {
        grid.setColor(i, 0, color);
        grid.setColor(i, 1, color);
        grid.setColor(i, 2, color);
        grid.setColor(size - 3, i, color);
        grid.setColor(size - 2, i, color);
        grid.setColor(size - 1, i, color);
        grid.setColor(i, size - 3, color);
        grid.setColor(i, size - 2, color);
        grid.setColor(i, size - 1, color);
      }
    }
    
    // Paints the letter H.
    if (letter.equals("H")) {
      for (int i = 0; i <= size - 1; i++) {
        grid.setColor(i, 0, color);
        grid.setColor(i, 1, color);
        grid.setColor(i, 2, color);
        grid.setColor((size/2 - 1/2 - 1), i, color);
        grid.setColor((size/2 - 1/2), i, color);
        grid.setColor((size/2 - 1/2 + 1), i, color);
        grid.setColor(i, size - 3, color);
        grid.setColor(i, size - 2, color);
        grid.setColor(i, size - 1, color);
      }
    }
    
    // Paints the letter O.
    if (letter.equals("O")) {
      for (int i = 0; i <= size - 1; i++) {
        grid.setColor(0, i, color);
        grid.setColor(1, i, color);
        grid.setColor(2, i, color);
        grid.setColor(i, 0, color);
        grid.setColor(i, 1, color);
        grid.setColor(i, 2, color);
        grid.setColor(size - 3, i, color);
        grid.setColor(size - 2, i, color);
        grid.setColor(size - 1, i, color);
        grid.setColor(i, size - 3, color);
        grid.setColor(i, size - 2, color);
        grid.setColor(i, size - 1, color);
      }
    }
    
    // Paints the letter I.
    if (letter.equals("I")) {
      for (int i = 0; i <= size - 1; i++) {
        grid.setColor(0, i, color);
        grid.setColor(1, i, color);
        grid.setColor(2, i, color);
        grid.setColor(i, (size/2 - 1/2), color);
        grid.setColor(i, (size/2 - 1/2 + 1), color);
        grid.setColor(i, (size/2 - 1/2 - 1), color);
        grid.setColor(size - 3, i, color);
        grid.setColor(size - 2, i, color);
        grid.setColor(size - 1, i, color);
      }
    }
    
    // Paints the letter N.
    if (letter.equals("N")) {
      for (int row = 0; row < size; row++) {
        for (int col = 0; col < 3; col++) {
          grid.setColor(row, col, color);
        }
        
        for (int col = size - 3; col < size; col++) {
          grid.setColor(row, col, color);
        }
      }
      
      for (int row = 0, row < size - 1; row++) {
        for (int col = row; col <= row + 1; col++) {
          grid.setColor(row, col, color);
          grid.setColor(row + 1, col, color);
        }
      }
    }
    
    // Paints the letter Z.
    if (letter.equals("Z")) {
      for (int row = 0; row < size; row++) {
        for (int col = 0; col < 3; col++) {
          grid.setColor(col, row, color);
        }
        
        for (int col = size - 3; col < size; col++) {
          grid.setColor(col, row, color);
        }
      }
      
      for (int row = 0; row < size - 1; row++) {
        for (int col = row; col <= row + 1; col++) {
          grid.setColor(col, size - 1 - row, color);
          grid.setColor(col, size - 2 - row, color);
        }
      }
    }
  }
}
