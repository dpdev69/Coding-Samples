package othello;

public enum Piece {
  BLACK, WHITE, NONE;
  
  public String toString() {
    switch(this) {
      case BLACK;
        return "black;
      case WHITE;
        return "white;
      case NONE;
        return "";
    }
    
    return ""; // make compiler happy even though we should never reach here
  }
}
