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

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.NoSuchElementException;
import graph.List.ListIterator;
import graph.List.Node;

public class vertexList<V> implements Iterable<V>{
	protected Comparator<V> comp;
	Node<V> head;
	protected class Node<E>{
		V data;
		Node<V> next;
		edgeList<V> edges;
		int status;
		int cost;
		V pred;
	}

	public vertexList(Comparator<V> comparator) {
		comp = comparator;
		head = null;
	}

	public vertexList(vertexList<V> otherList) {
		Node<V> newList = new Node<V>();
		newList = otherList.head;
		while(newList.next != null){
			add(newList.data);
			newList.edges = otherList.getEdges(newList.data);
			newList = newList.next;
		}
	}

	/*
	 * This method creates a new node and checks to see if it contains vertices
	 * If so head = the node if it is null. If it is not null, we will move to
	 * the next node in the list.
	 */
	public vertexList<V> add(V vert){
		Node<V> addNode = new Node<V>();
		addNode.data = vert;	
		addNode.next = null;
		addNode.edges = new edgeList<V>(comp);
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
	 * This method goes through the list and increments the counter until null
	 * is reached and returns count at the end.
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
	 * This method goes through the entire list and increments the counter 
	 * until null is reached.
	 */
	public vertexList<V> graphReset(){
		Node<V> current = head;
		while(current != null){ 
			current.status = -1;	 
			current.cost = 9999999;
			current = current.next;
		}
		return this;
	}

	/*
	 * This method checks if an index is valid. If invalid, the method will
	 * throw an IndexOutOfBoundsException and iterate until the counter equals
	 * the index.
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
	 * This method goes through the entire list until the first node matches
	 * the parameter source. If found, a reference will be returned. If not,
	 * null will be returned instead.
	 */
	public edgeList<V> getEdges(V source){
		Node<V> current = head;
		while(current != null && comp.compare(source, current.data) != 0){
			current = current.next;	
		}
		if(current != null){	
			return current.edges;
		}else
			return null;	
	}

	/*
	 * This method goes through the entire list until the first node matches
	 * the reference of element. If found, the reference will be returned. If 
	 * not, null will be returned instead.
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
	 * This method goes through the entire list until the first node matches 
	 * the parameter element. If found, the reference will be returned. If not,
	 * null will be returned.
	 */
	public Node<V> getNode(V element) {
		Node<V> current = head;
		while(current != null && comp.compare(element, current.data) != 0){
			current = current.next;	
		}
		if(current != null){	
			return current;
		}else
			return null;	
	}

	/*
	 * This method goes through the entire list until the first node matches 
	 * the parameter element. If found, the reference will be returned. If not,
	 * null will be returned.
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
	 * This method goes through the entire list until current matches the
	 * reference of the first node. A reference to the current node is then
	 * made and it will become the next node. If the next node isn't able to be
	 * found, a NoSuchElementException will be thrown.
	 */
	public vertexList<V> delete(V element) throws NoSuchElementException {
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
	 * This method goes through the list until current matches the reference of
	 * the node. This method will them make current into the next node and 
	 * return it.
	 */
	public vertexList<V> deleteVertexes(V element){
		Node<V> current = head;
		while(current != null){
			if(current.edges.contains(element)){
				current.edges.delete(element);
			}
			current = current.next;	
		}
		return this;
	}

	/*
	 * This method sets status to 0, uses an enhanced for loop which will
	 * return true if the status = 0.
	 */
	public boolean cycleSearch(V vertex) throws IllegalArgumentException {
		getNode(vertex).status = 0;
		for(V character: getEdges(vertex)){
			if(getNode(character).status == 0){
				return true;
			} else {
				if(getNode(character).status != 1 
						&& cycleSearch(lookup(character)) == true){
					return true;
				}
			}
		}
		getNode(vertex).status = 1;
		return false;	
	}

	/*
	 * This method uses an enhanced for loop and sets the Node status to 0. 
	 * The method will call itself recursively and call getSmallest.
	 */
	public void processVertex(V vertex){
		for(V v: getEdges(vertex)){
			int total = getNode(vertex).cost + getEdges(vertex).getCost(v);
			if(total < getNode(v).cost){
				getNode(v).cost = total;
				getNode(v).pred = vertex;
				getNode(v).status = 0;
			}
		}
		getNode(vertex).status = 1;
		if(getSmallest() != null){
			processVertex(getSmallest());
		}
	}

	/*
	 * This method goes through the list and adds to the counter until null is
	 * reached. Returns the smallest value of type V.
	 */
	public V getSmallest(){
		Node<V> current = head;
		V smallest = null;
		while(current != null){ 
			if(smallest == null && current.status == 0 || 
					current.status == 0 && getNode(current.data).cost < 
					getNode(smallest).cost){
				smallest = current.data;
			}
			current = current.next;
		}
		return smallest;
	}

	/*
	 * This method creates a path variable and checks to see if source equals
	 * destination. If so, path will be added to the destination. If not, the
	 * method will call itself recursively.
	 */
	public vertexList<V> findPath(V source, V dest){
		vertexList<V> path = new vertexList<V>(comp);
		if(dest == source){
			path.add(dest);
		} else {
			path = findPath(source, getNode(dest).pred);
			path.add(dest);
		}
		return path;
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Iterable#iterator()
	 * This method returns a new Iterator named VertexIterator of type T.
	 */
	public VertexIterator<V> iterator() {
		return new VertexIterator<V>(this); 
	}

	/*
	 * This method is used to iterate through the list.
	 */
	public class VertexIterator<E> implements Iterator<V> {
		protected Node<V> current;
		V info;
		public VertexIterator(vertexList<V> list){
			current = list.head;
		}

		/*
		 * (non-Javadoc)
		 * @see java.util.Iterator#hasNext()
		 * This method checks to see if it is possible to go through another 
		 * node.
		 */
		public boolean hasNext() {
			if(current == null){
				return false;
			}
			else
				return true;
		}

		/*
		 * (non-Javadoc)
		 * @see java.util.Iterator#next()
		 * This method gets the next node in the list.
		 */
		public V next() throws NoSuchElementException {
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
