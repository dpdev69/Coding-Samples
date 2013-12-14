/*
 * Name: Emmanuel Taylor 
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to implement an unsorted and unordered 
 * list in which values will be input without considering the order of the
 * values in the list. This class is the superclass of the sorted class. This 
 * class will contain values in any order of any value.
 */
package list;

import java.util.Comparator; 
import java.lang.Iterable;
import java.util.Iterator;
import java.lang.IndexOutOfBoundsException;
import java.util.NoSuchElementException;
import list.List.Node;

public class List<T> implements Iterable<T>, Comparable<List<T>> {

	/*
	 * Two field variables created for the Node of type T and a Comparator of
	 * type T for used throughout the entire program.
	 */
	protected Node<T> head;
	Comparator<T> comp;

	// you may not change this inner class!
	protected class Node<D> {
		D data;
		Node<D> next;
	}

	/*
	 * This is the list constructor that is used to set the node that was
	 * created to null and setting the comparator that was created equal to
	 * comparator
	 */
	public List(Comparator<T> comparator) {
		head = null;
		comp = comparator;
	}

	/*
	 * This methods creates a new Node of type T and sets the data of that node
	 * equal to the node created in the field variable, it then sets the 
	 * positions after that node equal to null and calls the getLast() helper
	 * method and sets the next position equal to the new Node.
	 */
	public void adderNode(Node<T> node){
		Node<T> adder = new Node<T>();
		adder.data = node.data;
		adder.next = null;
		this.getLast().next = adder;
	}

	/*
	 * This method is the copy constructor that sets the both field variables
	 * equal to the otherList. Next, a new Node of type T is created and is set
	 * equal to the position after the otherList's head. While the curr Node is
	 * not equal to null, adderNode is called and curr is set to the next
	 * position.
	 */
	public List(List<T> otherList) {
		this.comp = otherList.comp;
		this.head = otherList.head;
		Node<T> curr = otherList.head.next;
		while(curr != null){
			this.adderNode(curr);
			curr = curr.next;
		}
	}

	/*
	 * This private method creates a node and sets it equal to the head field
	 * variable. While the next position after the head is not equal to null,
	 * the created node is set equal to the next position and at the and node
	 * is returned.
	 */
	private Node<T> getLast(){
		Node<T> node = head;
		while(node.next != null){
			node = node.next;
		}
		return node;
	}

	/*
	 * This method creates a new node and sets the data equal to the newElt
	 * parameter. If the head is equal to null, it is set to the new Node and 
	 * the next positions are set to null. If the head is not null, getLast()
	 * is called and is set to node and the positions after that node are null.
	 * This is returned.
	 */
	public List<T> add(T newElt) {
		Node<T> node = new Node<T>();
		node.data = newElt;
		if(this.head == null){
			this.head = node;
			head.next = null;
		}else{
			this.getLast().next = node;
			node.next = null;
		}
		return this;
	}

	/*
	 * For this method, a new node is created once again, and a variable named
	 * counter is initialized at 0. If indez is greater than the size of the 
	 * node - 1 or if this is null, an IndexOutOfBounds exception will be
	 * thrown. Other wise, node will be set equal to head. While the counter is
	 * less than the index, node will be iterated until counter is no longer
	 * less than index. Node's data will be returned.
	 */
	public T get(int index) throws IndexOutOfBoundsException {
		Node<T> node = new Node<T>();
		int counter = 0;
		if(index > this.size() - 1 || this.isEmpty()){
			throw new IndexOutOfBoundsException();
		}
		else{
			node = this.head;
			while(counter < index){
				node = node.next;
				counter++;
			}
		}
		return node.data;
	}

	/*
	 * This method checks to see if the head is empty. If it is, we will return
	 * null. A new node is created, and a variable found is set to 0. Node is 
	 * set equal to head. While node is not null and found is equal to zero,
	 * we will compare our node data with element and check to see if it is 
	 * equal to zero. If this is true, found will equal 1. If not, node is set
	 * equal to the next position and the data is returned.
	 */
	public T lookup(T element) {
		if(this.isEmpty()){
			return null;
		}
		Node<T> node = new Node<T>();
		int found = 0;
		node = this.head;
		while(node != null && found == 0){
			if(comp.compare(node.data, element) == 0){
				found = 1;
			}
			else{
				node = node.next;
			}
		}
		return node.data;
	}

	/*
	 * This method creates a variable, size, and sets it equal to zero. If the
	 * head is empty, size will be returned. If not, a new node is created and
	 * set equal to head. While that node is not null, node is set equal to the
	 * next position and size increments by 1. Size is returned after the
	 * conditional statement is tested.
	 */
	public int size() {
		int size = 0;
		if(this.isEmpty()){
			return size;
		}else{
			Node<T> node = head;
			while(node != null){
				node = node.next;
				size++;
			}
		}
		return size;
	}

	/*
	 * This method is used to check if head is empty. True will be returned if
	 * it is empty, and if it is not empty, false will be returned.
	 */
	public boolean isEmpty() {
		if(this.head == null){
			return true;
		}
		else{
			return false;
		}
	}

	/*
	 * This method will return null if the head is empty. Two new nodes are 
	 * created and new variable is initialized at 0. One node is set to null 
	 * and the other is set equal to the head. While the curr node is not null
	 * and found is 0, we will compare the data with the element and if this 
	 * equals 0, found will be changed to one. If not, prev node will be set
	 * equal to curr and curr will be set equal to curr.next. When found is 
	 * equal to zero, a NoSuchElementException is thrown. 
	 */
	public List<T> delete(T element) throws NoSuchElementException {
		if(this.isEmpty())
			return null;
		Node<T> curr = new Node<T>();
		Node<T> prev = new Node<T>();
		int found = 0;
		prev = null;
		curr = this.head;
		while(curr != null && found == 0){
			if(comp.compare(curr.data, element) == 0){
				found = 1;
			}else{
				prev = curr;
				curr = curr.next;
			}
		}
		if( found == 0){
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
	 * This method checks to see if the head is empty. If so, the program will
	 * throw a NoSuchElementException. A new node is created and a new variable
	 * found is set to 0. Node is set equal to head. While node is not equal to
	 * null and found is equal to 0, we compare the data and oldElt and if
	 * it is equal to zero, found changes to 1. If not, node equals the next 
	 * position. If found equals zero, a NoSuchElementException is thrown, if 
	 * not, the data equals newElt.
	 */
	public void replace(T oldElt, T newElt) throws NoSuchElementException {
		if(this.isEmpty())
			throw new NoSuchElementException();
		Node<T> node = new Node<T>();
		int found = 0;
		node = this.head;
		while(node != null && found ==0){
			if(comp.compare(node.data, oldElt) == 0){
				found = 1;
			}else{
				node = node.next;
			}
		}
		if(found == 0){
			throw new NoSuchElementException();
		}else{
			node.data = newElt;
		}
	}

	/*
	 * This method checks to see if head is empty. If it is empty, a
	 * NoSuchElementException is thrown. If not, two nodes, node and largest 
	 * are created and are both set equal to head. While the next positions in 
	 * node are not equal to null, node is set equal to the next position.
	 * Next we compare the data from node and largest. If the variable is 
	 * greater than zero, largest is set equal to node. largest.data is
	 * returned.
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
	 * This method checks to see if head is empty. If so, the program will 
	 * throw a NoSuchElementException. If not, two new nodes, node and smallest,
	 * are created and both set equal to head. While node isn't empty, node is
	 * set equal to the next position. Next we compare the data for node and 
	 * smallest. If the variable is less than zero, smallest is set equal to 
	 * the node. Smallest.data is returned.
	 */
	public T getSmallest() throws NoSuchElementException {
		if(this.isEmpty()){
			throw new NoSuchElementException();
		}else{
			Node<T> node = new Node<T>();
			Node<T> smallest = new Node<T>();
			node = head;
			smallest = head;
			while(node.next != null){
				node = node.next;
				int cp = comp.compare((T) node.data, (T) smallest.data);
				if(cp < 0){
					smallest = node;
				}
			}
			return smallest.data;
		}
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
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

	/*
	 * This method makes head empty or "clears" it.
	 */
	public void clear() {
		this.head = null;
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	public int compareTo(List<T> otherList) {
		return this.toString().compareTo(otherList.toString());
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Iterable#iterator()
	 */
	public ListIterator<T> iterator() {
		return new ListIterator<T>();
	}

	/*
	 * Uses the three methods hasNext, next, and remove to iterate through the
	 * lists.
	 */
	public class ListIterator<E> implements Iterator<E> {
		Node<E> head;

		/*
		 * (non-Javadoc)
		 * @see java.util.Iterator#hasNext()
		 */
		public boolean hasNext() {
			Node<E> curr = new Node<E>();
			curr = head;
			if(curr.next != null){
				return true;
			}
			else{
				return false;
			}
		}

		/*
		 * (non-Javadoc)
		 * @see java.util.Iterator#next()
		 */
		public E next() throws NoSuchElementException {
			Node<E> curr = new Node<E>();
			curr = head;
			if(hasNext() == true){
				return curr.data;
			}
			else{
				throw new NoSuchElementException();
			}
		}

		/*
		 * (non-Javadoc)
		 * @see java.util.Iterator#remove()
		 */
		public void remove() {

		}
	}
}
