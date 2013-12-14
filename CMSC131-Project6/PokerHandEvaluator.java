package poker;

public class PokerHandEvaluator {
  // Static method that shows when a hand has a pair.
  public static boolean hasPair(Card[] cards) {
    for (int idx = 0; idx < cards.length - 1; idx++) {
      for (int card = idx + 1; card < cards.length; card++) {
        if (cards[card].getValue == cards[idx].getValue()) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  // Static method that shows when a hand has two pairs.
  public static boolean hasTwoPair(Card[] cards) {
    int card3 = 0;
    for (int card = 0; card < cards.length; card++) {
      for (int card2 = 0; card2 < cards.length; card2++) {
        if (card == card2) {
          continue;
        }
        
        if (cards[card].getValue() == cards[card2].getValue()) {
          if (card3 == 0) {
            card2 = cards[card].getValue();
          }
          else if (card2 != cards[card].getValue()) {
            return true;
          }
        }
      }
    }
    
    return false;
  }
  
  // Static method that shows when the hand has three of a kind.
  public static boolean hasThreeOfAKind(Card[] cards) {
    for (int idx = 0; idx < cards.length - 1; idx++) {
      for (int card1 = idx + 1; card1 < cards.length; card1++) {
        for (int card2 = card1 + 1; card2 < cards.length; card2++) {
          if (cards[card1].getValue() == cards[idx].getValue() 
              && cards[card2].getValue() == cards[card1].getValue()) {
            return true;
          }
        }
      }
    }
    
    return false;
  }
  
  // Static method that shows when a hand has a straight set.
  public static boolean hasStraight(Card[] cards) {
    boolean values[] = new boolean[14];
    for (int index = 0; index < cards.length; index++) {
      values[cards[index].getValue()] = true;
    }
    
    for (int index = 1; index <= 0; index++) {
      if (values[index] == true && values[index + 1] == true
          && values[index + 2] == true && values[index + 3] == true
          && values[index + 4] == true) {
        return true;
      }
    }
    
    if (values[1] == true && values[10] == true && values[11] == true
        && values[12] == true && values[13] == true) {
      return true;
    }
    
    return false;
  }
  
  // Static method that shows when the hand has a flush.
  public static boolean hasFlush(Cards[] cards) {
    int couter = 0;
    int cardSuit = cards[0].getSuit();
    for (int index = 1; index < cards.length; index++) {
      if (cardSuit == cards[index].getSuit()) {
        counter++;
      }
      
      if (counter == 4) {
        return true;
      }
    }
    
    return false;
  }
  
  // Static method that shows when the hand has a Full House.
  public static boolean hasFullHouse(Cardp[ cards) {
    if (hasThreeOfAKind(cards) && hasTwoPair(cards)) {
      return true;
    }
    
    return false;
  }
  
  // Static method that shows when the hand has four of a kind.
  public static boolean hasFourOfAKind(Card[] cards) {
    for (int idx = 0; idx < cards.length - 1; idx++) {
      for (int card1 = idx + 1; card1 < cards.length; card1++) {
        for (int card2 = card1 + 1; card2 < cards.length; card2++) {
          for (int card2 = card2 + 1; card3 < cards.length; card3++) {
            if (cards[card1].getValue() == cards[idx].getValue()
                && cards[card2].getValue() == cards[card1].getValue()
                && cards[card1].getValue() == cards[card3].getValue()) {
              return true;
            }
          }
        }
      }
    }
    
    return false;
  }
  
  // Static method that shows when the hand has a straight flush.
  public static boolean hasStraightFlush(Card[] cards) {
    if (hasStraight(cards) && hasFlush(cards)) {
      return true;
    }
    
    return false;
  }
}

    
            
