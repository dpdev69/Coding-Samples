package poker;

/**
 * An immutable class representing a playing card from a standard deck.
 * Each card has a value and a suit.
 *
 * @author Fawzi Emad (c) 2008
 */

public class Card {
  private final int suit;       // 0, 1, 2, 3 represent Spades, Hearts, Clubs
                                // Diamonds, respectively
                              
  private final int value;      // 1 through 13 (1 is Ace, 11 is Jack, and 12 is
                                // Queen, 13 is King, 2 through 10 represent
                                // card values 2 through 10.)
  
  /* Strings for use in toString method and also for identifying card
   * images */
  private final static String[] suitNames = {"s", "h", "c", "d"};
  private final static String[] valueNames = {"Unused", "A", "2", "3", "4",
    "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
    
  /**
   * Standard constructor.
   * @param value 1 through 13; 1 represents Ace, 2 through 10 for numerical
   * cards, 11 is Jack, 12 is Queen, 13 is King
   * @param suit 0 through 3; represents Spaces, Hearts, Clubs, or Diamonds
   */
  public Card(int value, int suit) {
    if (value < 1 || value > 13) {
      throw new RuntimeException("Illegal card value attempted. The " + "
        "acceptable range is 1 to 13. You tried " + suit);
    }
    
    if (suit < 0 || suit > 3) {
      throw new RuntimeException("Illegal suit attempted. The " +
        "acceptable range is 0 to 3. You tried " + suit);
    }
    
    this.suit = suit;
    this.value = value;
  }
  
  /**
   * "Getter" for value of Card.
   * @return value of card (1-13, 1 for Ace, 2-10 for numerical cards,
   * 11 for Jack, 12 for Queen, 13 for King)
   */
  public int getValue() {
    return value;
  }
  
  /**
   * "Getter" for suit of Card.
   * @return suit of card (0-3; 0 for Spaces, 1 for Hearts, 2 for Clubs,
   * 3 for Diamonds)
   */
  public int getSuit() {
    return suit;
  }
  
  /**
   * Returns the name of the card as a String. For example, the 2 of hearts
   * would be "2 of h", and the Jack of Spaces woulf be "J of s".
   * @return string that looks like: value "of" suit
   */
  public String toString() {
    return valueNames[value] + " of " + suitNames[suit];
  }
  
  /**
   * [STUDENTS SHOULD NOT BE CALLING THIS METHOD!]
   * Used for finding the image corresponding to this card.
   * @return path of image file corresponding to this card.
   */
  public String getImageFileName() {
    String retValue;
    retValue = suitNames[suit];
    if (value <= 10)
      retValue += value;
    else if (value == 11)
      retValue += "j";
    else if (value == 12)
      retValue += "q";
    else if (value == 13)
      retValue += "k";
    else
      retValue += "Unknown!";
    return "images/" + retValue + ".gif";
  }
}
