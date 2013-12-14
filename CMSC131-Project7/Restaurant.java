package foodManagement;

/**
 * This Restaurant has a name (String), a menu (list of Entrees), an inventory
 * (list of Food), and an amout of cash on hand, measured in pennies (int)
 *
 * This class facilitates orders being placed, deliveries being made to the
 * inventory, and entrees being added to the menu.
 */
public class Restaurant {

  /*
   * STUDENTS: YOU MAY NOT ADD ANY OTHER INSTANCE VARIABLES TO THIS CLASS!
   */
  private String name;
  private SortedListOfImmutables menu;      // A list of Entree objects
  private SortedListOfImmutables inventory; // A list of Food objects
  private int cash;
  
  /**
   * Standard constructor. The menu and the inventory are both initialized as
   * empty lists. The name and cash amount are set to match the parameters.
   *
   * @param nameIn name of the restaurant
   * @param startingCash cash amount that the restaurant will have, measured
   * in pennies
   */
  public Restaurant(String nameIn, int startingCash) {
    menu = new SortedListOfImmutables();
    inventory = new SortedListOfImmutables();
    name = nameIn;
    cash = startingCash;
  }
  
  /**
   * Getter for the name of the restaurant.
   *
   * @return reference to the name of the restaurant
   */
  public String getName() {
    return this.name;
  }
  
  /**
   * Getter for the menu
   *
   * @return reference to a copy of the menu
   */
  public SortedListOfImmutables getMenu() {
    SortedListOfImmutables menu1 = new SortedListOfImmutables(menu);
    return menu;
  }
  
  /**
   * Adds an entree to the menu.
   *
   * @param entreeToAdd referencec to the entree to be added to menu
   */
  public void addEntree(Entree entreeToAdd) {
    menu.add(entreeToAdd);
  }
  
  /**
   * Get for the inventory.
   *
   * @return a reference to a copy of the inventory
   */
  public SortedListOfMutables getInventory() 
    SortedListOfImmutables inventory1 = new SortedListOfMutables(inventory);
    return inventory1;
  }
  
  /**
   * Getter for the current amou of cash on hand
   *
   * @return the current amount of cash, measured in pennies
   */
  public int getCash() 
    return this.cash;
  }
  
  /**
   * Check if the Food items contained in the specified Entree are
   * actually contained in the restaurant's inventory.
   *
   * @param entree Entree that we are checking against the inventory
   * @return true if the list of Food items contained in the Entree are
   * all present in the inventory, false otherwise.
   */
  public boolean CheckIfInventory(Entree entree) {
    SortedListOfImmutables foodItem = new SortedListOfImmutables(entree.getFoodList());
    return inventory.checkAvailability(foodItem);
  }
  
  /**
   * Adds the specified list of food items to the inventory. If the 
   * total wholesale cost of all of the food items combined exceeds
   * the amount of cash on hand, then NONE of the food items are added
   * to the inventory. If the amount of cash on hand is sufficient to
   * pay for the shipment, then the amount of cash on hand is reduced by
   * the wholesale cost of the shipment
   *
   * @param list food items to be added to the inventory
   * @return true if the food items to be added to the inventory are
   * not added because their wholesale cost exceeds their current cash
   * on hand
   */
  public boolean addShipmentToInventory(SortedListOfImmutables list) {
    if (list.getWholesaleCost() > this.cash) {
      return false;
    }
    inventory.add(list);
    this.cash = this.cash - list.getWholesaleCost();
    return true;
  }
  
  /**
   * Removes the food items contained in the specified Entree from the inventory.
   * If the inventory foes not contain all of the items required for this 
   * Entree, then NOTHING is removed from the inventory. If the inventory contains
   * all of the required items, then the amount of cash on hand is INCREASED by
   * the retail value of Entree.
   *
   * @param entree Etree that has been ordered
   * @return true if the food items are removed from the inventory; false
   * if the food items were not removed because one or more required items
   * were not contained in the inventory
   */
  public boolean placeOrder(Entree entree) {
    if (inventory.checkAvailability(entree.getFoodList())) {
      cash += entree.getRetailValue();
      inventory.remove(entree.getFoodList());
      return true;
    }
    else {
      return false;
    }
  }
}
