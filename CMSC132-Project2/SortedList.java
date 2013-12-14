/*
 * Name: Emmanuel Taylor 
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to implement an sorted and ordered 
 * list in which values will be stored in order of the values from lowest to 
 * highest values in the list. This class is the subclass of the unsorted class. 
 * This class can override certain methods from the List class such as the add
 * method which will sort the values in order.
 */
package list;

import java.util.Comparator;
import java.lang.IndexOutOfBoundsException;
import java.util.NoSuchElementException;
import list.List.Node;

public class SortedList<T> extends List<T> {

	/*
	 * SortedList constructor uses super(comparator)
	 */
	public SortedList(Comparator<T> comparator) {
		super(comparator);
	}

	/*
	 * (non-Javadoc)
	 * @see list.List#add(java.lang.Object)
	 */
	public List<T> add(T newElt) {
		Node<T> node = new Node<T>();
		Node<T> curr = head;
		Node<T> prev = null; 
		if(head == null){
			node.data = newElt;
			head = node;
			node.next = null;
		}else{
			while(curr != null){
				if(comp.compare(curr.data, newElt) < 0){
					prev = curr;
					curr = curr.next;
				}else if(comp.compare(curr.data, newElt) >= 0){
					if(prev == null){
						head = node;
					}else{
						prev.next = node;
					}
					node.data = newElt;
					node.next = curr;
					return this;
				}
			}
			node.data = newElt;
			node.next = null;
			prev.next = node;
		}
		return this;
	}

	/*
	 * (non-Javadoc)
	 * @see list.List#delete(java.lang.Object)
	 */
	public List<T> delete(T element) throws NoSuchElementException {
		if(this.isEmpty())
			return null;
		Node<T> curr = new Node<T>();
		Node<T> prev = new Node<T>();
		int found = 0;
		prev = null;
		curr = this.head;
		while(curr != null && found ==0){
			if(comp.compare(curr.data, element) == 0){
				found = 1;
			}else{
				prev = curr;
				curr = curr.next;
			}
		}
		if(found == 0){
			throw new NoSuchElementException();
		}else{
			if(curr!= null){
				if(curr == head){
					head = head.next;
				}else{
					prev.next = curr.next;
				}
			}
		}
		return this;
	}

	/*
	 * (non-Javadoc)
	 * @see list.List#getLargest()
	 */
	public T getLargest() throws NoSuchElementException {
		if(this.isEmpty()){
			throw new NoSuchElementException();
		}else{
			Node<T> node = new Node<T>();
			Node<T> largest = new Node<T>();
			node = head;
			largest = head;
			while(node.next != null){
				node = node.next;
				int cp = comp.compare((T) node.data, (T) largest.data);
				if(cp > 0){
					largest = node;
				}
			}
			return largest.data;
		}
	}

	/*
	 * (non-Javadoc)
	 * @see list.List#getSmallest()
	 */
	public T getSmallest() throws NoSuchElementException {
		if(this.isEmpty()){
			throw new NoSuchElementException();
		}else{
			Node<T> n = new Node<T>();
			Node<T> smallest = new Node<T>();
			n = head;
			smallest = head;
			while(n.next != null){
				n = n.next;
				int cp = comp.compare((T) n.data, (T) smallest.data);
				if(cp < 0){
					smallest = n;
				}
			}
			return smallest.data;
		}
	}

	/*
	 * (non-Javadoc)
	 * @see list.List#toString()
	 */
	public String toString() {
		String retVal = new String("");
		if(this.head == null){
			return retVal;
		}else{
			Node<T> node = head;
			retVal += node.data.toString();
			while(node.next != null){
				node = node.next;
				retVal += (" " + node.data.toString());
			}
		}
		return retVal;
	}
}
