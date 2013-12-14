package names;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class List<T> implements Iterable<T>{
	Node<T> head;
	protected class Node<E>{
		T data;
		Node<T> next;
	}
	public List(){
		head = null;
	}
	//Adds a node with the information passed in to the end of the list.
	public List<T> add(T element){
		Node<T> addNode = new Node<T>();
		addNode.data = element;	
		addNode.next = null;
		if(!(contains(element))){	//Checks if the node already exists
			Node<T> current = head;
			if(head == null){
				head = addNode;
			} else
				if(head != null){	//if not goes to the end of the list.
					while(current.next != null){
						current = current.next;
					}
					current.next = addNode;	//adds the node to the end.
				}
		}
		return this;
	}
	//Checks if the vertex exists in the list.
	public boolean contains(T element) {
		Node<T> current = head;
		while(current != null && element != current.data){
			current = current.next;	//Goes through the list until the first 
			//node matches the parameters reference.
		}
		if(current != null){	//If found returns true.
			return true;
		}else
			return false;	//If not found false will be returned.
	}
	//Returns the size of the list.
	public int size() {
		int count = 0;
		Node<T> current = new Node<T>();
		current = head;
		while(current != null){ //Goes through the list and adds to the counter
			count++;	 //until it reaches null.
			current = current.next;
		}
		return count;	//Returns the count.
	}
	//Returns the reference of a node at the index thats passed in.
	public T get(int index) throws IndexOutOfBoundsException {
		int pos = 0;
		Node<T> current = head;
		if(index > size() - 1 || index < 0){	//Checks if the index is valid.
			throw new IndexOutOfBoundsException();	//Throws an exception if so.
		} 
		while(pos != index){	//Goes through until the counter equals the
			current = current.next;	//index.
			pos++;
		}
		return current.data;	//Returns the reference of the node at the
	}	 //index.
	@Override
	public Iterator<T> iterator() {
		return new ListIterator<T>(this);
	}
	//Iterates the list.
	public class ListIterator<E> implements Iterator<T> {
		protected Node<T> current;
		T info;
		public ListIterator(List<T> list){
			current = list.head;
		}
		//Checks if their is node to go through.
		public boolean hasNext() {
			if(current == null){
				return false;
			}
			else
				return true;
		}
		//Retrieves the next node in the list.
		public T next() throws NoSuchElementException {
			//Throws an exception if at the end of the list.
			if(hasNext() == false){	
				throw new NoSuchElementException();
			}
			//Goes through the list until it reaches the position.
			info = current.data;
			current = current.next;
			return info;
		}
		public void remove() {
			throw new UnsupportedOperationException();
		}
	}
}
