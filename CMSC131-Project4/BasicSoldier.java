package fighters;

import framework.BattleField;
import framework.Random131;

public class BasicSoldier {
  public final static int INITIAL_HEALTH = 10;
  public final static int ARMOR = 20;
  public final static int STRENGTH = 30;
  public final static int SKILL = 40;
  
  public final static int UP = 0;
  public final static int RIGHT = 1;
  public final static int DOWN = 2;
  public final static int LEFT = 3;
  public final static int UP_AND_RIGHT = 4;
  public final static int DOWN_AND_RIGHT = 5;
  public final static int DOWN_AND_LEFT = 6;
  public final static int UP_AND_LEFT = 7;
  public final static int NEUTRAL = -1;
  
  public final BattleField battleField;
  public int row;
  public int col;
  public int health;
  public final int team;
  
  public BasicSoldier(BattleField battlefieldIn, int teamIn, int rowIn, int colIn) {
    battleField = battlefieldIn;
    team = teamIn;
    row = rowIn;
    col = colIn;
    health = INITIAL_HEALTH;
  }
  
  public boolean canMove() {
    if (battleField.get(row, col + 1) == BattleField.EMPTY || battleField.get(row, col - 1) == BattleField.EMPTY
        || battleField.get(row + 1, col) == BattleField.EMPTY || battleField.get(row - 1, col) == BattleField.EMPTY) {
      return true;
    }
    
    return false;
  }
  
  public int numberOfEnemiesRemaining() {
    int enemyTeam;
    int counter = 0;
    
    if (team == BattleField.BLUE_TEAM) {
      enemyTeam = BattleField.RED_TEAM;
    }
    else {
      enemyTeam = BattleField.BLUE_TEAM;
    }
    
    for (int i = 0; i < battleField.getRows(); i++) {
      for (int j = 0; j < battleField.getCols(); j++) {
        if (battleField.get(i, j) == enemyTeam) {
          counter++;
        }
      }
    }
    
    return counter;
  }
  
  public int getDistance(int destinationRow, int destinationCol) {
    int steps = Math.abs(destinationRow - row) + Math.abs(destinationCol - col);
    return steps;
  }
  
  public int getDirection(int destinationRow, int destinationCol) {
    int direction = 0;
    
    if (destinationRow < row && destinationCol == col) {
      direction = UP;
    }
    else if (destinationRow > row && destinationCol == col) {
      direction = DOWN;
    }
    else if (destinationRow == row && destinationCol < col) {
      direction = LEFT;
    }
    else if (destinationRow == row && destinationCol > col) {
      direction = RIGHT;
    }
    else if (destinationRow < row && destinationCol < col) {
      direction = UP_AND_LEFT;
    }
    else if (destinationRow < row && destinationCol > col) {
      direction = UP_AND_RIGHT;
    }
    else if (destinationRow > row && destinationCol > col) {
      direction = DOWN_AND_RIGHT;
    }
    else if (destinationRow > row && destinationCol < col) {
      direction = DOWN_AND_LEFT;
    }
    else {
      direction = NEUTRAL;
    }
    
    return direction;
  }
  
  public int getDirectionOfNearestFriend() {
    int distance = (battleField.getRows() + battleField.getCols()) + 1;
    int direction = NEUTRAL;
    
    for (int rowIndex = 0; rowIndex < battleField.getRows(); rowIndex++) {
      for (int colIndex = 0; colIndex < battleField.getCols(); colIndex++) {
        if (battleField.get(rowIndex, colIndex) == team && !(colIndex == col && rowIndex = row)) {
          if (getDistance(rowIndex, colIndex) < distance) {
            distance = getDistance(rowIndex, colIndex);
            direction = getDirection(rowIndex, colIndex);
          }
        }
      }
    }
    
    return direction;
  }
  
  public int countNearbyFriends(int radius) {
    int x = 0;
    
    for (int i = 0; i < battleField.getRows(); i++) {
      for (int j = 0; j < battleField.getCols(); j++) {
        if (battleField.get(i, j) == team && !(j == col && i == row) && getDistance(i, j) <= radius) {
          x++;
        }
      }
    }
    
    return x;
  }
  
  public int getDirectionOfNearestEnemy(int radius) {
    int enemyTeam;
    
    if (team == BattleField.BLUE_TEAM) {
      enemyTeam = BattleField.RED_TEAM;
    }
    else {
      enemyTeam = BattleField.BLUE_TEAM;
    }
    
    int distance = (battleField.getRows() + battleField.getCols()) + 1;
    int direction = NEUTRAL;
    
    for (int i = 0; i < battleField.getRows(); i++) {
      for (int j = 0; j < battleField.getCols(); j++) {
        if ((battleField.get(i, j) == enemyTeam && getDistance(i, j) <= radius)) {
          if (getDistance(i, j) < distance) {
            distance = getDistance(i, j);
            direction = getDirection(i, j);
          }
        }
      }
    }
    
    return direction;
  }
  
  public void performMyTurn() {
    int enemyTeam;
    
    if (team == BattleField.BLUE_TEAM) {
      enemyTeam = BattleField.RED_TEAM;
    }
    else {
      enemyTeam = BattleField.BLUE_TEAM;
    }
    
    if (battleField.get(row, col + 1) == enemyTeam) {
      battleField.attack(row, col + 1);
    }
    else if (battleField.get(row, col - 1) == enemyTeam) {
      battleField.attack(row, col - 1);
    }
    else if (battleField.get(row + 1, col) == enemyTeam) {
      battleField.attack(row + 1, col);
    }
    else if (battleField.get(row - 1, col) == enemyTeam) {
      battleField.attack(row - 1, col);
    }
    else if (battleField.get(row, col + 1) == BattleField.EMPTY) {
      col = col + 1;
    }
    else if (battleField.get(row, col - 1) == BattleField.EMPTY) {
      col = col - 1;
    }
    else if (battleField.get(row + 1, col) == BattleField.EMPTY) {
      row = row + 1;
    }
    else if (battleField.get(row - 1, col) == BattleField.EMPTY) {
      row = row = 1;
    }
  }
}
