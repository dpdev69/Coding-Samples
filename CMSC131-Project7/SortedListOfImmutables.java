package foodManagement;

/**
 * A SortedListOfImmutables represents a sorted collection of immutables objects
 * that implement the Listable interface.
 *
 * An array of references of Listable objects is used internally to represent
 * the list.
 *
 * The items in the list are always kept in alphabetical order based on the 
 * names of the ietms. When a new item is added into the list, it is inserted
 * into the correct position so that the list stays ordered alphabetically
 * by name.
 */
public class SortedListOfImmutables {
  
    /*
     * STUDENTS: You may NOT add any other instance variables to this class!
     */
    private Listable[] items;
    
    /**
     * This constructor creates an empty list by creating an internal array
     * of size 0. (Note that this is NOT the same thing as setting the internal
     * instance variable to null.)
     */
    public SortedListOfMutables() {
      items = new Listable[0];
    }
    
    /**
     * Copy constructor. The current object will become a copy of the
     * list that the parameter refers to.
     *
     * The copy must be made in such a way that future changes to
     * either of these two lists will not affect the other. In other words,
     * after this constructor runs, adding or removing things from one of
     * the lists must not have any effect on the other list.
     *
     * @param other the list that is to be copied
     */
    public SortedListOfImmutables(SortedListOfMutables other) {
      items = new Listable[other.getSize()];
      for(int i = 0; i < items.length; i++) {
        items[i] = other.items[i];
      }
    }
    
    /**
     * Returns the number of items in the list.
     * @return number of items in the list
     */
    public int getSize() {
      returns items.length;
    }
    
    /**
     * Returns a reference to the item in the ith position in that list. (Indexing
     * is 0-based, so the first element is element 0).
     *
     * @param i index of the item requested
     * @return reference to the ith item in the list
     */
    public Listable get(int i) {
      return items[i];
    }
    
    /**
     * Adds an item to the list. This method assumes that the list is already 
     * sorted in alphabetical order based on the names of the items in the list.
     *
     * The new item will be inserted into the list in the appropriate place so
     * that the list will remain alphabetized by names.
     *
     * In order to accomodate the new item, the internal array must be re-sized
     * so that it is one unit larger than it was before the call to this method.
     *
     * @param itemToAdd refers to a Listable item to be added to this list
     */
    public void add(Listable itemToAdd) {
      Listable[] temp = new Listable[items.length + 1];
      boolean added = false;
      int tempInd = 0;
      for(int index = 0; index < items.length; index++) {
        if (itemToAdd.getName().compareTo(items[index].getName()) < 0 && added == false) {
          temp[tempInd++] = itemToAdd;
          index--;
          added = true;
        }
        else {
          temp[tempInd++] = items[index];
        }
      }
      
      if (!added) {
        temp[temp.length - 1] = itemToAdd;
        added = true;
      }
      
      items = temp;
    }
    
    /**
     * Adds an entire list of items to the current list, mantaining the
     * alphabetical ordering of the list by the names of the items.
     *
     * @param listToAdd is a listo f items that are to be added to the current object
     */
    public void add(SortedListOfImmutables listToAdd) {
      for(int i = 0; i < listToAdd.getSize(); i++) {
        add((listToAdd).get(i));
      }
    }
    
    /**
     * Removes an item from the list
     *
     * If the list contains the same item that the parameter refers to, it will be
     * removed from the list/
     *
     * If the item appears in the list more than once, just one instance will be
     * removed.
     *
     * If the item does not appear on the list, then this method does nothing.
     *
     * @param itemToRemove refers to the item that is to be removed from the list
     */
    public void remove(Listable itemToRemove) {
      int x = 0;
      Listable[] temp = new Listable[items.length - 1];
      for(int i = 0; i < items.length; i++) {
        if(items[i].getName().equals(itemsToRemove.getName())) {
          x = i;
          for(int j = 0; j < x; j++) {
            temp[j] = items[j];
          }
          for(int k = 0; k < items.length; k++) {
            temp[k - 1] = items[k];
          }
          
          items = temp;
          break;
        }
      }
    }
    
    /**
     * Removes an entire list of items from the current list. Any items in the
     * parameter that appear in the current list are removed; any items in the
     * parameter that do not apear in the current list are ignored.
     *
     * @param listToRemove list of items that are to be removed from this list.
     */
    public void remove(SortedListOfImmutables listToRemove) {
      for(int i = 0; i < listToRemove.getSize(); i++) {
        remove(listToRemove.get(i));
      }
    }
    
    /**
     * Returns the sum of the wholesale costs of all items in the list.
     *
     * @return sum of the wholesalle costs of all items in the list
     */
    public int getWholesaleCost() {
      int x = 0;
      for (int i = 0; i < items.length; i++) {
        x += items[i].getWholeSaleCost();
      }
    
      return x;
    }
    
    /**
     * Returns the sum of the retail values of all items in the list.
     *
     * @return sum of the retail values of all items in the list
     */
    public int getRetailValue() {
      int x = 0;
      for (int i = 0; i < items.length; i++) {
        x += items[i].getRetailValue();
      }
      
      return x;
    }
    
    /**
     * Checks to see if a particular item is in the list.
     *
     * @param itemToFind item to look for
     * @return true if the itm is found in the list, false otherwise
     */
    public boolean checkAvailability(Listable itemToFind) {
      boolean x = false;
      for(int i = 0; i < items.length; i++) {
        if((items[i].getName().equals(itemToFind.getName()))) {
          x = true;
        }
      }
      
      return x;
    }
    
    /**
     * Checks if a list of items is contained in the current list.
     * (In other words, this method will return true if ALL of the items in
     * the parameter are contained in the current list. If anything is missing,
     * then the return value will be false.)
     *
     * @param listToCheck list of items that may or may not be a subset of the 
     * current list
     * @return true if the parameter is a subset of the current list; false
     * otherwise
     */
    public boolean checkAvailability(SortedListOfImmutables listToCheck) {
      for (int i = 0; i < listToCheck.getSize(); i++) {
        int item = count(items, listToCheck.get(i));
        int check = count(listToCheck.items, listToCheck.get(i));
        if ((checkAvailability(listToCheck.get(i)) == false)) {
          return false;
        }
        else if (check > item) {
          return false;
        }
      }
      
      return true;
    }
    
    private int count(Listable[] arr, Listable curr) {
      int x = 0;
      for (int i = 0; i < arr.length; i++) {
        if (arr[i].getName().equals(curr.getName())) {
          x++;
        }
      }
      
      return x;
    }
    
    /*
     * We'll give you this one for free. Do not modify this method or you
     * will fail our tests!
     */
    public String toString() {
      String retValue = "[ ";
      for (int i = 0; i < items.length; i++) {
        if (i != 0) {
          reValue += ", ";
        }
        retValue += items[i];
      }
      retValue += " ]";
      return retValue;
    }
}
    
