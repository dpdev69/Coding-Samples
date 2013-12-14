package poker;

public class Deck {
  private Card[] cards;
  
  // Constructor that initializes a deck with 52 cards.
  public Deck() {
    cards = new Card[52];
    for (int i = 0; i < cards.length; i++) {
      int x = (i + 1) % 13;
      if (x == 0) {
        x = 13;
      }
      cards[i] = new Card(x, i/13);
    }
  }
  
  // Copy constructor for the immutable card class.
  public Deck(Deck other) {
    cards = new Card[other.getNumCards()];
    for (int i = 0; i < cards.length; i++) {
      cards[i] = other.getCardAt(1);
    }
  }
  
  // Returns the card in the specified area of the array.
  public Card getCardAt(int position) {
    int val = cards[position].getValue();
    int suit = cards[position].getSuit();
    Card x = new Card(val, suit);
    
    return x;
  }
  
  // Returns the size of the number of cards.
  public int getNumCards() {
    return Cards.length;
  }
  
  //This methid is used to randomize the cards between the first and last.
  public void shuffle() {
    Card[] top;
    if (cards.length % 2 == 0 {
      top = new Card[cards.length/2];
    }
    else {
      top = new Card[(cards.length/2) + 1];
    }
    
    for (int i = 0; i < top.length; i++) {
      top[i] = cards[i];
    }
    
    Card[] bottom = new Card[cards.length/2];
    int cout = top.length;
    
    for (int i = 0; i < bottom.length; i++) {
      bottom[i] = cards[count];
      count++;
    }
    
    int x = 0;
    int y = 0;
    
    for (int i = 0; i < cards.length; i++) {
      if (i % 2 == 0) {
        cards[i] = top[x];
        x++;
      }
      else {
        cards[i] = bottom[y];
        y++
      }
    }
  }
  
  // Divides the deck into two packets.
  public void cut(int position) {
    Card[] top = new Card[position];
    for (int i = 0; i < top.length; i++) {
      top[i] = cards[i];
    }
    
    Card[] bottom = new Card[cards.length - top.length];
    int count = position;
    for (int i = 0; i < bottom.length; i++) {
      bottom[i] = cards[count];
      count++;
    }
    
    int x = 0;
    for (int i = 0; i < cards.length; i++) {
      if (i < bottom.length) {
        cards[i] = bottom[i];
      }
      else {
        cards[i] = top[x];
        x++;
      }
    }
  }
  
  // Remove cards from the top of the deck and returns as an array.
  public Card[] deal(int numCards) {
    Card[] dealt = new Card[numCards];
    for (int i = 0; i < dealt.length; i++) {
      dealt[i] = cards[i];
    }
    
    Card[] shorter = new Card[cards.length - numCards];
    for (int i = 0; i < shorter.length; i++) {
      shorter[i] = cards[numCards];
      numCards++;
    }
    
    cards = new Card[shorter.length];
    for (int i = 0; i < cards.length; i++) {
      cards[i] = shorter[i];
    }
    
    return dealt;
  }
}
