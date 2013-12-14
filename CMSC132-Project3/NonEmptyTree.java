/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to represent a Binary Search Tree that isn't 
 * empty. The methods used in this class are used to manipulate the tree and 
 * the contents of the tree such as removing subtrees with certain values or 
 * checking the paths from two different keys. This class contains references
 * to a root key with a value, and references to right and left trees that 
 * contain keys/values.
 */
package tree;

import java.util.List;

public class NonEmptyTree<K extends Comparable<K>, V> implements Tree<K, V> {

	/*
	 * Instance variables for the constructor
	 */
	private K root;
	private V value;
	private Tree<K, V> leftTree;
	private Tree<K, V> rightTree;

	/*
	 * NonEmptyTree constructor that calls the Tree's getInstance() methods
	 * in order to set each variable.
	 */
	public NonEmptyTree(K root, V value, Tree<K, V> leftTree2, 
			Tree<K, V> rightTree2) {
		this.root = root;
		this.value = value;
		leftTree = EmptyTree.getInstance();
		rightTree = EmptyTree.getInstance();
	}

	/*
	 * Second constructor used to create trees without other trees inside of 
	 * them.
	 */
	public NonEmptyTree(K root, V value){
		this.root = root;
		this.value = value;
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#add(java.lang.Comparable, java.lang.Object)
	 * This method adds keys to the current tree object that corresponds to 
	 * value. If they key already exists, it will be replaced by the new value
	 * without affecting the rest of the tree. 
	 */
	public NonEmptyTree<K, V> add(K key, V value) {
		if(key.compareTo(root) == 0){
			this.value = value;
		}else if(key.compareTo(root) < 0){
			leftTree = leftTree.add(key, value);
		}else{
			rightTree = rightTree.add(key, value);
		}
		return this;	
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#lookup(java.lang.Comparable)
	 * This methods finds the value that the key is corresponding to. Returns 
	 * null if they key isn't associated with any value.
	 */
	public V lookup(K key) {
		if(key.compareTo(root) == 0) {
			return this.value;
		}else if(key.compareTo(root) < 0) {
			return leftTree.lookup(key);
		}else {
			return rightTree.lookup(key);
		} 
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#size()
	 * This method returns the number of keys and value pairs that are present
	 * and will return 0 for the EmptyTree class.
	 */
	public int size() {
		return 1 + leftTree.size() + rightTree.size();
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#max()
	 * This method returns the largest key in a tree. If the tree is empty,
	 * an EmptyTreeException will be thrown stating that the tree has no
	 * contents.
	 */
	public K max() throws EmptyTreeException {
		try{
			return rightTree.max();
		} 

		catch (EmptyTreeException e){
			return root;
		}	
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#min()
	 * This method returns the smallest tree in a tree. If the tree is empty,
	 * an EmptyTreeException will be thrown stating that the tree has no
	 * contents.
	 */
	public K min() throws EmptyTreeException {
		try{
			return leftTree.min();
		} 

		catch (EmptyTreeException e){
			return root;
		}
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#delete(java.lang.Comparable)
	 * This method removes the key and value associated with that key which is
	 * called upon. Since there are never any duplicate keys, there will only
	 * be one matching key at most.
	 */
	public Tree<K, V> delete(K key) {
		int compare = key.compareTo(this.root);
		if (compare < 0) {
			leftTree = leftTree.delete(key);
			return this;
		} else if (compare > 0) {
			rightTree = rightTree.delete(key);
			return this;
		} else {
			try {
				K min = rightTree.min();
				this.root = min;
				value = rightTree.lookup(min);
				rightTree = rightTree.delete(min);
			} catch (EmptyTreeException e) {
				try {
					K max = leftTree.max();
					this.root = max;
					value = leftTree.lookup(max);
					leftTree = leftTree.delete(max);
				} catch (EmptyTreeException f) {
					return EmptyTree.getInstance();
				}
			}
		}
		return this;
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#removeSubTree(java.lang.Comparable)
	 * This method should remove the key/value pair that is called upon, and
	 * the entire subtree of that pair if they contain one. If the called key/
	 * value pair is the root, the tree will transform into an EmptyTree.
	 */
	public Tree<K, V> removeSubTree(K key) {
		if(key == null){
			throw new NullPointerException();
		}
		else if(key.compareTo(this.root) < 0){
			leftTree =this.leftTree.removeSubTree(key);
		}
		else if(key.compareTo(this.root) > 0){
			rightTree =this.rightTree.removeSubTree(key);
		}
		else{
			return EmptyTree.getInstance();
		}
		return this;
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#haveSameKeys(tree.Tree)
	 * This method returns true if the tree object and otherTree have the same
	 * exact keys, and false if they do not. Values do not matter, but each
	 * tree should have only the exact same keys.
	 */
	public boolean haveSameKeys(Tree<K, V> otherTree) {
		if (this.size() == otherTree.size()) {
			if (this.toString().contains(otherTree.toString()))
				return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#pathFromRoot(java.lang.Comparable, java.util.List)
	 * If they key exists in the current object tree, this method will remove
	 * current contents of the parameter list and make it contain a list of all
	 * the keys between root and key. If the root is the key, the list will 
	 * contain only that single key.
	 */
	public void pathFromRoot(K key, List<K> list) {
		int c = key.compareTo(this.root);
		if(c == 0){
			list.add(this.root);
		}
		else if(c < 0){
			list.add(this.root);
			leftTree.pathFromRoot(key, list);
		}
		else if(c > 0){
			list.add(this.root);
			rightTree.pathFromRoot(key, list);
		}
	}

	/*
	 * (non-Javadoc)
	 * @see tree.Tree#pathToRoot(java.lang.Comparable, java.util.List)
	 * This method will return the exact reverse of what the pathFromRoot()
	 * method will return.
	 */
	public void pathToRoot(K key, List<K> list) {
		int c = key.compareTo(this.root);
		if(c == 0){
			list.add(this.root);
		}
		else if(c < 0){
			leftTree.pathToRoot(key, list);
			list.add(this.root);
		}
		else if(c > 0){
			rightTree.pathToRoot(key, list);
			list.add(this.root);
		}	
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return (leftTree.toString().equals("") ? "": leftTree.toString() + " ")
				+ root.toString() + "=>" + value.toString() 
				+ (rightTree.toString().equals("") ? "": " "
						+ rightTree.toString());
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Object#clone()
	 * Because the Tree interface implements the cloneable interface, the
	 * clone() method must create a reference the the new Tree's object and 
	 * whose contents and shape are exactly the same and return it.
	 */
	public NonEmptyTree<K, V> clone() {
		NonEmptyTree<K, V> clonedTree = 
				new NonEmptyTree(root, value, leftTree, rightTree);
		clonedTree.leftTree = leftTree.clone();
		clonedTree.rightTree = rightTree.clone();
		return clonedTree;
	}
}
