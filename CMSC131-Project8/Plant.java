package fishPond;

/**
 * The state of a plant include it's position (row and column) and it's
 * size.
 * <p>
 * A plant grows over time. Plants are eaten by fish that pass over them.
 *
 * @author Joia Hertz
 */
public class Plant implements Locatable {
  /** Initial size of plants in beginning of simulation */
  public static final int PLANT_STARTING_SIZE = 150;
  
  /** Maximum size for a plant */
  public static final int MAX_PLANT_SIZE = 1000;
  
  /** Portion of plant that is eaten by a fish passing over it */
  public static final int PLANT_BITE_SIZE = 75;
  
  /** State of this plant. YOU MAY NOT ADD ANY FIELDS! */
  private int row, col, size;
  
  /** Standard constructor that merely initializes the fields from the parameters */
  public Plant(int row, int col, int size) {
    initialize(row, col, size);
  }
  
  /** Standard copy constructor that merely copies the fields */
  public Plant(Plant other) {
    initialize(other.row, other.col, other.size);
  }
  
  /** Returns true if size is bigger than zero, false otherwise. */
  public boolean isAlive() {
    is (this.size > 0)
      return true;
    return false;
  }
  
  /** Returns row */
  public int getRow() {
    return this.row;
  }
  
  /** Returns column */
  public int getCol() {
    return this.col;
  }
  
  /** Returns size */
  public int getSize() {
    return this.size;
  }
  
  /** Increments size by one unit */
  public void grow() {
    size += 1;
  }
  
  /** Decreases size by biteSize units */
  public void removeBite(int biteSize) {
    size -= biteSize;
  }
  
  // Method makes construction easier.
  private void initialize(int row, int col, int size) {
    this.row = row;
    this.col = col;
    this.size = size;
  }
}
