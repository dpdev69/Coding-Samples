/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to represent a graph and implement two 
 * different graph algorithms such as Dijsktra's Algorithm and a variation of 
 * a depth-first search of the graph and tests whether vertices in the graphs
 * make a cycle.
 */
package graph;

import graph.List.ListIterator;
import graph.edgeList.Node;
import java.util.Comparator;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class edgeList<V> implements Iterable<V> {
	protected Comparator<V> comp;
	protected Node<V> head;
	protected class Node<E>{
		V data;
		Node<V> next;
		int cost;
	}

	/*
	 * Comparator method.
	 */
	public edgeList(Comparator<V> comparator) {
		comp = comparator;
		head = null;
	}

	/*
	 * Copy constructor.
	 */
	public edgeList(edgeList<V> otherList) {
		Node<V> newList = new Node<V>();
		newList = otherList.head;
		while(newList.next != null){
			add(newList.data, newList.cost);
			newList = newList.next;
		}
	}

	/*
	 * This method creates a new node and checks to see if it contains vertices
	 * If so head = the node if it is null. If it is not null, we will move to
	 * the next node in the list.
	 */
	public edgeList<V> add(V vert, int length){
		Node<V> addNode = new Node<V>();
		addNode.data = vert;	
		addNode.next = null;
		addNode.cost = length;
		if(!(contains(vert))){
			Node<V> current = head;
			if(head == null){
				head = addNode;
			} else
				if(head != null){
					while(current.next != null){
						current = current.next;
					}
					current.next = addNode;
				}
		}
		return this;
	}

	/*
	 * This method goes through the entire list and increments the counter 
	 * until null is reached. The count is returned at the end.
	 */
	public int size() {
		int counter = 0;
		Node<V> current = new Node<V>();
		current = head;
		while(current != null){ 
			counter++;	
			current = current.next;
		}
		return counter;	
	}

	/*
	 * Checks to see if we have a valid index, if the index is invalid, an
	 * IndexOutOfBoundsException is thrown. This will go through until the
	 * counter equals the index and will return a reference of the node.
	 */
	public V get(int index) throws IndexOutOfBoundsException {
		int pos = 0;
		Node<V> current = head;
		if(index > size() - 1 || index < 0){	
			throw new IndexOutOfBoundsException();	
		} 
		while(pos != index){	
			current = current.next;	
			pos++;
		}
		return current.data;
	}

	/*
	 * This method iterates through the entire until the first node matches 
	 * edges reference and it will be returned. If it is not found, null will
	 * be returned instead.
	 */
	public int getCost(V edge){
		Node<V> current = head;
		while(current != null && comp.compare(edge, current.data) != 0){
			current = current.next;
		}
		if(current != null){	
			return current.cost;
		}else
			return -1;
	}

	/*
	 * This method will iterate through the entire list until element matches
	 * the first node. If the next node is found, a reference to that node is 
	 * returned. If not, it will return null.
	 */
	public V lookup(V element) {
		Node<V> current = head;
		while(current != null && comp.compare(element, current.data) != 0){
			current = current.next;
		}
		if(current != null){	
			return current.data;
		}else
			return null;	
	}

	/*
	 * This method will iterate through the entire list until element matches
	 * the first node. If the next node is found, we will return true, if it is
	 * not found, it will return false.
	 */
	public boolean contains(V element) {
		Node<V> current = head;
		while(current != null && comp.compare(element, current.data) != 0){
			current = current.next;	
		}
		if(current != null){	
			return true;
		}else
			return false;	
	}

	/*
	 * This method will iterate through the entire list until the nodes
	 * reference matches current. The current node will be made into the next
	 * node. If the next node isn't found, a NoSuchElementException is thrown.
	 */
	public edgeList<V> delete(V element) throws NoSuchElementException {
		Node<V> prev = null, current = head;
		while(current != null && comp.compare(element, current.data) != 0){
			prev = current;	
			current = current.next;	
		}
		if(current == null){ 
			throw new NoSuchElementException();
		} else
			if(current != null){	
				if(current == head){
					head = head.next;	
				} else
					prev.next = current.next;
			}
		return this;
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Iterable#iterator()
	 * Returns a new EdgeIterator named EdgeIterator and of type T.
	 */
	public EdgeIterator<V> iterator() {
		return new EdgeIterator<V>(this); 
	}

	/*
	 * This method is used to iterate through the entire list.
	 */
	public class EdgeIterator<E> implements Iterator<V> {
		protected Node<V> current;
		V info;

		public EdgeIterator(edgeList<V> list){
			current = list.head;
		}

		public boolean hasNext() {
			if(current == null){
				return false;
			}
			else
				return true;
		}

		//Retrieves the next node in the list.
		/*
		 * (non-Javadoc)
		 * @see java.util.Iterator#next()
		 * This method will get the next node in the list.
		 */
		public V next() throws NoSuchElementException {
			//If the the end of the list is reached, a NoSuchElementException
			//will be thrown. Otherwise, iterate through the list until the
			//position is reached.
			if(hasNext() == false){	
				throw new NoSuchElementException();
			}
			info = current.data;
			current = current.next;
			return info;
		}

		public void remove() {
			//Didn't have to write this method for the code.
		}
	}
}
