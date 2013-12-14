package tree;

import java.util.List;

public interface Tree<K extends Comparable<K>, V> extends Cloneable {

	public NonEmptyTree<K, V> add(K key, V value);
	public V lookup(K key);
	public int size();
	public K max() throws EmptyTreeException;
	public K min() throws EmptyTreeException;
	public Tree<K, V> delete(K key);
	public boolean haveSameKeys(Tree<K, V> otherTree);
	public Tree<K, V> removeSubTree(K key);
	public void pathFromRoot(K key, List<K> list);
	public void pathToRoot(K key, List<K> list);
	public Tree<K, V> clone();

}
