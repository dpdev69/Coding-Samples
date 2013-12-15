package fishPond;

import java.util.*;
import cmsc131Utilities.Random131;

/**
 * Model for the Fish pond Simulation. The model consists of a List of Fish,
 * a List of Plants, and a two dimensional array of boolean values representing
 * the poond (each element in the array is either ROCK, or WATER.)
 * <p>
 * Each time the simulation is re-started a new Model object is created
 * 
 * @author Fawzi Emad, Joia Hertz
 */
public class Model {
  
  /* State of this model. STUDENTS MAY NOT ADD ANY FIELDS! */
  private ArrayList<Fish> fish;
  private ArrayList<Plant> plants;
  private boolean[][] landscape;
  
  /** Value stored in landscape array to represent water */
  public static final boolean WATER = false;
  
  /** Value stored in landscape array to represent rock */
  public static final boolean ROCK = true;
  
  /* Minimum pond dimensions */
  private static final int MIN_POND_ROWS = 5;
  private static final int MIN_POND_COLS = 5;
  
  /**
   * <p>
   * If numRows is smaller than MIN_POND_ROWS, or if numCols is smaller than
   * MIN_POND_COLS, then this method will throw an IllegalPondSizeException.
   * <p>
   * The fields "rows" and "cols" are initialized with the values of
   * parameters numRows and numCols.
   * <p>
   * The field "landscape" is initialized as a 2-dimensional array of booleans.
   * The size is determined by rows and cols. Every entry in the landscape array
   * is filled with WATER. The border aroud the perimeter ofo the landscape array
   * (top, bottom, left, right) is then overwritten with ROCK.
   * <p>
   * Random rocks are placed in the pond until the number of rocks (in addition to
   * those in the border) reaches numRocks.
   * <p>
   * The "plants" ArrayList is instantiated. Randomly placed Plant objects are put
   * into the List. Their positions are chosen so that they are never above rocks
   * in the same position as another plant. Plants are generated in this way until
   * the list reaches size numPlants
   * <p>
   * The "fish" ArrayList is instantiated. Now randomly placed Fish objects are put
   * into the List. Their directions are also randomly selected. The positions are
   * chosen so that they are never above rocks, plants, or other fish. Fish are
   * generated in this way until the list reaches size numFish.
   * 
   * @param numRows number of rows for pond
   * @param numCols number of columns for pond
   * @param numRocks number of rocks to be drawn in addition to rocks around border
   * of pond
   * @param numFish number of fish to start with
   * @param numPlants number of plants to start with
   */
  public Model(int numRows, int numCols, int numRocks, int numFish, int numPlants) {
    if (numRows < MIN_POND_ROWS || numCols < MIN_POND_COLS) {
      throw new IllegalPondSizeException(numRows, numCols);
    }
    
    landscape = new boolean[numRows][numCols];
    plants = new ArrayList<Plant>();
    fish = new ArrayList<Fish>();
    
    /* Fill landscape with water and a border of rocks around the perimeter */
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        landscape[i][j] = WATER;
      }
      landscape[i][0] = ROCK;
      landscape[i][numCols - 1] = ROCK;
    }
    
    for (int j = 0; j < numCols - 1; j++) {
      landscape[0][j] = ROCK;
      landscape[numRows - 1][j] = ROCK;
    }
    
    /* Place random rocks */
    int rocksPlaced = 0;
    while (rocksPlaced < numRocks) {
      int row = Random131.getRandomInteger(numRows);
      int col = Random131.getRandomInteger(numCols);
      try {
        addPlant(new Plant(row, col, Plant.PLANT_STARTING_SIZE));
      }
      catch (IllegalPlantPositionException e) {
        i--;
      }
    }
    
    /* Place random fish */
    for (int i = 0; i < numFish; i++) {
      int row = Random131.getRandomInteger(numRows);
      int col = Random131.getRandomInteger(numCols);
      int r = Random131.getRandomInteger(4);
      int dir;
      if (r == 0)
        dir = Fish.UP;
      else if (r == 1)
        dir = Fish.DOWN;
      else if (r == 2)
        dir = Fish.LEFT;
      else
        dir = Fish.RIGHT;
        
      Fish f = new Fish(row, col, Fish.FISH_STARTING_SIZE, dir);
      try {
        addFish(f);
      }
      catch (IllegalFishPositionException e) {
        i--;
      }
    }
  }
  
  /**
   * <p>
   * When a plant gets bigger than Plant.MAX_PLANT_SIZE, it will explode into
   * 2 to 9 smaller plants, whose sizes add up to the size of the original plant.
   * The smaller plants will be placed in the 9 regions of the landscape array
   * that surrounds the original plant. If there are rocks, fish, or other plants
   * already occupying these adjacent regions, then fewer than 9 plants are created.
   * If there are no available regions nearby, the plant will not explode. */
  public void plantExplosions() {
    Iterator<Plant> i = plants.iterator();
    while (i.hasNext()) {
      Plant curr = i.next();
      if (curr.getSize() > Plant.MAX_PLANT_SIZE) {
        int count = 0;          // number of available slots for little plants
        boolean[] freeSpace = new boolean[9];   // true if just water in that region
        
        /* locations of 8 little plants that are determind by these offsets to
         * the coordinates of the plant that is exploding. */
        int[] dx = {0, 1, 1, 1, 0, -1, -1, -1};
        int[] dy = {1, 1, 0 ,-1, -1, -1, 0, 1};
        
        int r = curr.getRow();
        int c = curr.getCol();
        
        /* Look to see if space is available in all eight directions */
        for(int j = 0; j < 8; j++) {
          freeSpace[j] = isSpaceAvailable(r + dy[j], c + dx[j]);
          if (freeSpace[j])
            count++;
        }
        
        /* We'll split only if 1 or more spaces are available */
        if (count > 0) {
          i.remove();         // kill off original plant
          int newSize = curr.getSize() / (count + 1);   // truncates!
          
          /* Add little plants to the list -- iterator is now broken! */
          for (int j = 0; j < 8; j++)
            if (freeSpace[j])
              plants.add(new Plant(r + dy[j], c + dx[j], newSize));
              
          plants.add(new Plant(r, c, newSize));   // replace original
          
          /* Since we've modified the List, the original iterator 
           * is no longer userful. Start iterating from the beginning. */
          i = plants.iterator();
        }
      }
    }
  }
  
  /**
   * <p>
   * When a fish gets bigger than Fish.MAX_FISH_SIZE, it will explode into
   * 4 to 8 smaler fish, whose sizes add up to the size of the original fish.
   * The smaller fish will be placed in the eight regions of the landscape array
   * surrounding the original fish. The little fish will begin moving in
   * directions that point away from the original location. (Note that no little
   * fish is placed into the original location of the landscape array where the 
   * exploding fish was -- just in the surrounding squares.) If there are rocks,
   * fish, or plants already occupying these adjacent squares, then fewer than
   * eight little fish are created. If there are not at least four available
   * surrounding squares, then the fish will not explode. */
  public void fishExplosions() {
    Iterator<Fish> i = fish.iterator()
    while (i.hasNext()) {
      Fish curr = i.next()
      if (curr.getSize() > Fish.MAX_FISH_SIZE) {
        int count = 0;      // number of available squares for little fish
        boolean[] freeSpace = new boolean[8];   // true if just water in that region
        
        /* locations of the 8 little fish are determind by these offsets
         * to the coordinates of the original fish that is exploding */
        int[] dx = {0, 1, 1, 1, 0, -1, -1, -1};
        int[] dy = {-1, -1, 0, 1, 1, 1, 0, -1};
        
        /* directions for the 8 little fish */
        int[] newDir = {Fish.UP, Fish.UP, Fish.RIGHT, Fish.RIGHT, Fish.DOWN,
          Fish.DOWN, Fish.LEFT, Fish.LEFT};
        
        int r = curr.getRow();
        int c = curr.getCol();
        
        /* Look to see if space is available in all directions */
        for (int j = 0; j < 8; j++) {
          freeSpace[j] = isSpaceAvailable(r + dy[j], c + dx[j]);
          if (freeSpace[j])
            count++;
        }
        
        /* We'll split only if 4 or more spaces are available */
        if (count > 3) {
          i.remove();     // remove original fish from List
          int newSize = curr.getSize() / count;
            
          /* Add little fish to the list -- iterator is now broken! */
          for (int j = 0; j < 8; j++) 
            if (freeSpace[j])
              fish.add(new Fish(r + dy[j], c + dx[j], newSize, newDir[j]));
          
          /* Since we have modified the List, the original Iterator
           * is no longer valid. We'll start iterating again from the 
           * beginning. */
          i = fish.iterator();
        }
      }
    }
  }
  
  /* Checks the specified location to see if it has a rock, fish, or plant in it.
   * If so, returns false; if it is just water, returns true. */
  public boolean isSpaceAvailable(int r, int c) {
    if (landscape[r][c] == ROCK) {
      return false;
    }
    
    for (int i = 0; i < fish.size(); i++) {
      if (fish.get(i).getRow() == r && fish.get(i).getCol() == c) {
        return false;
      }
    }
    
    for (int j = 0; j < plants.size(); j++) {
      if (plants.get(j).getRow() == r && plants.get(j).getCol() == c) {
        return false;
      }
    }
    
    return true;
  }
  
  /** Copy constructor. */
  public Model(Model other) {
    this.landscape = other.landscape;
    this.fish = new ArrayList<Fish>();
    this.plants = new ArrayList<Plant>();
    Iterator<Fish> i = other.fish.iterator();
    while (i.hasNext()) {
      Fish curr = i.next();
      this.fish.add(new Fish(curr));
    }
    
    Iterator<Plant> j = other.plants.iterator();
    while (j.hasNext()) {
      Plant curr = j.next()l
      this.plants.add(new Plant(curr));
    }
  }
  
  /** Fish f eats a portion of plant p. The amount eaten is either
   * Plant.PLANT_BITE_SIZE or the current size of the plant, whichever is smaller.
   * The fish's size is increased by this amount and the plant's size is decreased
   * by this amount. */
  public static void fishEatPlant(Fish f, Plane p) {
    int food = (Plant.PLANT_BITE_SIZE > p.getSize() ? p.getSize():
      Plant.PLANT_BITE_SIZE);
    f.eat(food);
    p.removeBite(food);
  }
  
  /** returns number of rows in landscape array */
  public int getRows() {
    return landscape.length;
  }
  
  /** returns number of columns in landscape array */
  public int getCols() {
    return landscape[0].length;
  }
  
  /** Iterates through fish list. For each fish that isAlive, shrinks the fish by
   * invoking it's "shrink" method. */
  public void shrinkFish() {
    Iterator<Fish> i = fish.iterator();
    while (i.hasNext()) {
      Fish curr = i.next();
      if (curr.isAlive())
        curr.shrink();
    }
  }
  
  /** Iteratoes through plants list, growing each plant by invoking it's "grow"
   * method. */
  public void growPlants() {
    Interator<Plant> i = plants.iterator();
    while (i.hasNext()) {
      Plant curr = i.next();
      if (curr.isAlive())
        curr.grow();
    }
  }
  
  /** Iteratoes through the list of fish. Any fish that is no longer alive is removed
   * from the list. */
  public void removeDeadFish() {
    Iterator<Fish> i = fish.iterator();
    while (i.hasNext()) {
      Fish curr = i.next();
      if (curr.isAlive() == false) {
        i.remove();
        i = fish.iterator();
      }
    }
  }
  
  /** Iteratoes through the list of plants. Any plant that is no longer alive is removed
   * from the list. */
  public void removeDeadPlants() {
    Iterator<Plant> i = plants.iterator();
    while (i.hasNext()) {
      Plant curr = i.next();
      if (curr.isAlive() == false) {
        i.remove();
        i = plants.iterator();
      }
    }
  }
  
  /** Checks if the fish f is surroudned on FOUR SIDE (above, below, left, right)
   * by rocks. If so, return true. If there is at least one side without a rock,
   * then return false. */
  private boolean fishIsSurroundedByRocks(Fish f) {
    int[] dx = {0, 1, 0, -1};
    int[] dy = {1, 0, -1, 0};
    int row = f.getRow();
    int col = f.getCol();
    for (int i = 0; i < 4; i++) {
      int x = row + dx[i];
      int y = col + dy[i];
      if (landscape[x][y] == WATER)
        return false;
    }
    
    return true;
  }
  
  /** 
   * Iterate through list of Fish. FOR EACH FISH THAT IS ALIVE, do the following:
   * <p>
   * 1. If this fishIsSurroundedByRocks, DO NOTHING, and move on the the next fish.
   *    (This fish will not turn.)
   * <p>
   * 2. If this fish's direction is not equal to one of the code UP, DOWN, LEFT, or
   *    RIGHT, then throw an IllegalFishDirectionException, passing this fish's
   *    direction to the constructor of the IllegalFishDirectionException.
   * <p>
   * 3. Check whether or not this fish is about to hit a rock if it moves in it's
   *    current direction. If it is about to hit a rock, call the fish's
   *    setRandomDirection method. Repeat this step until the fish is no longer
   *    about to hit a rock
   */
  public void turnFish() {
    Iterator<Fish> i = fish.iterator();
    while (i.hasNext()) {
      Fish curr = i.next();
      if (curr.isAlive()) {
        if (fishIsSurroundedByRocks(curr) == false) {
          while (canMove(curr) == false) {
            curr.setRandomDirection();
          }
        }
      }
    }
  }
  
  // Throws an error if fish have illegal directions
  // Returns true if fish faces water and false if fish faces rock.
  private boolean canMove(Fish f) {
    int dir = f.getDirection();
    int dx = 0, dy = 0;
    switch(dir) {
      case Fish.UP:
        dy = -1;
        break;
      case Fish.DOWN:
        dy = 1;
        break;
      case Fish.LEFT:
        dx = -1;
        break;
      case Fish.RIGHT:
        dx = 1;
        break;
      default:
        throw new IllegalFishDirectionException(dir);
    }
    
    int x = f.getCol() + dx;
    int y = f.getRow() + dy;
    if (landscape[y][x] == ROCK)
      return false;
    return true;
  }
  
  /**
   * Note: This method assumes that each live fish is not surrounded by
   * rocks is already facing a direction where there is no rock! (Typically the 
   * call to this method should immediately follow a call to "turnFish", which
   * ensures that these conditions are satisfied.)
   * <p>
   * This method iterates through the list of fish. FOR EACH FISH THAT IS ALIVE,
   * do the following:
   * <p>
   * 1. Check to see if this fishIsSurroundedByRocks. If so, DO NOTHING and move
   *    along to the next fish in the list. (This fish does not move, does not 
   *    eat, does not fight.)
   * <p>
   * 2. Move this fish by calling it's "move" method.
   * <p>
   * 3. Check if there is a plant that isAlive and is located in the same position
   *    as this fish. If so, have the fish eat part of the plant by calling
   *    fishEatPlant.
   * <p>
   * 4. Check if there is another fish (distinct from this fish) that is in the same
   *    location as this fish. If so, have the two fish fight each other by calling
   *    the fight method.
   */
  public void moveFish() {
    Iterator<Fish> i = fish.iterator();
    while (i.hasNext()) {
      Fish curr = i.next()
      if (curr.isAlive()) {
        if (fishIsSurroundedByRocks(curr) == false) {
          curr.move();
          Iterator<Plant> j = plants.iterator();
          while (j.hasNext()) {
            Plant food = j.next();
            if (food.isAlive()) {
              if (samePlace(curr, food)) {
                fishEatPlant(curr, food);
              }
            }
          }
          
          Iterator<Fish> k = fish.iterator();
          while (k.hasNext()) {
            Fish enemy = k.next();
            if ((enemy.isAlive()) && (curr != enemy)) {
              if (samePlace(curr, enemy)) {
                curr.fight(enemy);
              }
            }
          }
        }
      }
    }
  }
  
  /** Attempts to add the plant p to plant list, if possible
   * <p>
   * First checks if the landscape in a plant's location is equal to ROCK. If it
   * is, then does nt add the plant to the list. Instead throws an
   * IllegalPlantPositionException, passing
   * IllegalPlantPositionException.PLANT_OVER_ROCK to the constructor.
   * <p>
   * Now checks for another plant (distinct from the parameter) that is in the 
   * same location as the parameter. If one is found, then does not add the plant
   * to the list. Instead throws an IllegalPlantPositionException,
   * passing IllegalPlantPositionException.TWO_PLANTS_IN_ONE_PLACE to the
   * constructor.
   * <p>
   * Otherwise, adds the plant to the list "plants".
   */
  public void addPlant(Plant p) {
    int row = p.getRow();
    int col = p.getCol();
    if (landscape[row][col] == ROCK)
      throw new IllegalPlantPositionException
      (IllegalPlantPositionException.PLANT_OVER_ROCK);
    if (samePlace(row, col, getPStuff())) {
      throw new IllegalPlantPositionException
      (IllegalPlantPositionException.TWO_PLANTS_IN_ONE_PLACE);
    }
    plants.add(p);
  }
  
  // Checks to see if two things in the array list are in the same spot.
  private boolean samePlace(int row, int col, ArrayList<Locatable> aList) {
    Iterator<Locatable> i = alist.iterator();
    while (i.hasNext()) {
      Locatable thing = i.next();
      if ((thing.getRow() == row) && (thing.getCol() == col) && (thing.isAlive())) {
        return true;
      }
    }
    return false;
  }
  
  /** Adds the fish f to the fish list, if possible
   * <p>
   * First checks if the landscape in the fish's location is equal to ROCK.
   * If it is, then the fish is not added to the list. Instead, throws an
   * IllegalFishPositionException, passing
   * IllegalFishPositionException.FISH_OVER_ROCK to the constructor.
   * <p>
   * Next checks or another fish (distinct from the parameter) that is in the 
   * same location as the parameter. If one is found, then the fish is not
   * added to the list. Instead throws an IllegalFishPositionException,
   * passing IllegalFishPositionException.TWO_FISH_IN_ONE_PLACE to the constructor
   * <p>
   * Otherwise, adds the parameter to the fish list.
   */
  public void addFish(Fish f) {
    int row = f.getRow();
    int col = f.getCol();
    if (landscape[row][col] == ROCK)
      throw new IllegalFishPositionException
      (IllegalFishPositionException.FISH_OVER_ROCK);
    if (samePlace(row, col, getFStuff())) {
      throw new IllegalFishPositionException
      (IllegalFishPositionException.TWO_FISH_IN_ONE_PLACE);
    }
    fish.add(f);
  }
  
  /** Returns a COPY of the fish list. */
  public ArrayList<Fish> getFish() {
    ArrayList<Fish> copy = new ArrayList<Fish>(fish);
    return copy;
  }
  
  // Changes fish to Locatables in the Array List
  private ArrayList<Locatable> getFStuff() {
    Locatable thing;
    ArrayList<Locatable> stuff = new ArrayList<Locatable>();
    Iterator<Fish> i = fish.iterator();
    while (i.hasNext()) {
      thing = i.next();
      stuff.add(thing);
    }
    return stuff;
  }
  
  /** Returns a COPY of the plants list. */
  public ArrayList<Plant> getPlants() {
      ArrayList<Plant> copy = new ArrayList<Plant>(plants);
      return copy;
  }
  
  // Changes the plants to Locatables in the Array List
  private ArrayList<Locatable> getPStuff() {
    Locatable thing;
    ArrayList<Locatable stuff = new ArrayList<Locatable();
    Iterator<Plants> i = plants.iterator();
    while (i.hasNext()) {
      thing = i.next();
      stuff.add(thing);
    }
    return stuff;
  }
  
  /** Returns the specified entry of the landscape array (either WATER or ROCK). */
  public boolean getShape(int row, int col) {
    return landscape[row][col];
  }
  
  // Retrusn true if objects are in the same location.
  private boolean samePlace(Locatable thing1, Locatable thing2) {
    if ((thing1.getRow() == thing2.getRow()) &&
      (thing1.getCol() == thing2.getCol()))
      return true;
    return false
  }
}
