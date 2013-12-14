/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to successfully manipulate a graph object such
 * as adding/removing vertices or adding/removing edges. This class also 
 * implements Dijsktra's Algorithm which will be able to tell the shortest path
 * to get from one vertex to the end vertex.
 */
package graph;

import java.lang.Iterable;
import java.util.Iterator;
import java.util.Comparator;
import java.util.NoSuchElementException;
import graph.edgeList.Node;

public class Graph<V extends Comparable<V>> implements Iterable<V> {
	
	//Instance variables and the protected comparator methods to compare
	//the source to the destination.
	private vertexList<V> graph;
	protected Comparator<V> comparator(){
		return new Comparator<V>(){
			public int compare(V source, V dest){
				return source.compareTo(dest);
			}
		};
	}
	
	/*
	 * Creates and returns a new graph object.
	 */
	public Graph() {
		graph = new vertexList<V>(comparator());
	}

	/*
	 * This method creates a vertex from methods listed in the vertexList
	 * class. The method also adds new vertexes with data vertex.
	 */
	public void addVertex(V vertex) throws IllegalArgumentException {
		if(graph.contains(vertex)){	
			throw new IllegalArgumentException();
		} else
			graph.add(vertex);
	}

	/*
	 * This method adds edges between two vertices. The method adds a new edge
	 * to its current object graph that goes from it's vertex source to it's 
	 * vertex destination.
	 */
	public void addEdge(V source, V dest, int cost)
			throws IllegalArgumentException {
		//Throws an IllegalArgumentException if the cost is a negative number.
		if(cost < 0){
			throw new IllegalArgumentException();
		}
		
		//This if statements checks for vertices existing in the graph.
		if(!(graph.contains(source))){
			addVertex(source);
		}
		if(!(graph.contains(dest))){
			addVertex(dest);
		} 
		
		//Replaces vertices existing in the graph if there's an edge between
		//them.
		if(graph.getEdges(source).contains(dest)){
			graph.getEdges(source).delete(dest);
			graph.getEdges(source).add(dest, cost);
		} else
			graph.getEdges(source).add(dest, cost);
	}

	/*
	 * This method returns the cost of any edges that are between two vertices.
	 */
	public int getEdge(V source, V dest) {
		//This if statement returns -1 if the edges doesn't exist, if it DOES 
		//exist, it will be returned instead of -1.
		if(!(graph.contains(source)) || !(graph.contains(dest))){
			return -1;
		} else
			return graph.getEdges(source).getCost(dest);
	}

	/*
	 * By implementing Java's Interable interface, this method returns
	 * vertices in the edgeList class that was written.
	 */
	public Iterable<V> getNeighbors(V vertex) throws IllegalArgumentException {
		//Checks to see if the vertices exist.
		if(!(graph.contains(vertex))){	
			throw new IllegalArgumentException();
		} else
			return graph.getEdges(vertex);
	}

	/*
	 * This method will remove an edge between a vertex's source and
	 * destination, if the edge doesn't exist, a NoSuchElementException will be
	 * thrown.
	 */
	public void removeEdge(V source, V dest) throws NoSuchElementException {
		//Checks if the edge exists and throws a NoSuchElementException if
		//they do not. If they do exist, the edge gets deleted between them.
		if(!(graph.contains(source)) || !(graph.contains(dest)) || 
				!(graph.getEdges(source).contains(dest))){
			throw new NoSuchElementException();
		} else
			graph.getEdges(source).delete(dest);
	}

	/*
	 * This method will remove a vertex and all edges associated with it. If 
	 * a vertex doesn't exist, a NoSuchElementException will be thrown.
	 */
	public void removeVertex(V vertex) throws NoSuchElementException {
		//Checks if the vertices exist and throws a NoSuchElementException if
		//it does not exist. If if DOES exist, the vertex and it's edges will
		//be deleted.
		if(!(graph.contains(vertex))){
			throw new NoSuchElementException();
		} else {
			graph.deleteVertexes(vertex);
			graph.delete(vertex);
		}	
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Iterable#iterator()
	 * This method returns the iterator from the vertexList class that was 
	 * written.
	 */
	public Iterator<V> iterator() {
		return graph.iterator();
	}

	/*
	 * This method returns true if a vertex is a part of the current object
	 * graph that contains a cycle and returns false otherwise.
	 */
	public boolean isInCycle(V vertex) throws IllegalArgumentException {
		if(!(graph.contains(vertex))){
			throw new IllegalArgumentException();
		}
		graph = graph.graphReset();
		return graph.cycleSearch(vertex);
	}

	/*
	 * This method will perform Dijkstra's Algorithm on the current graph
	 * object which means this method will determine the shortest path from the
	 * starting vertex to any other vertex.
	 */
	public ShortestPath<V> Dijkstra(V source, V dest)
			throws IllegalArgumentException {
		ShortestPath<V> newPath = new ShortestPath<V>();
		if(!(graph.contains(source)) && !(graph.contains(dest))){
			throw new IllegalArgumentException();
		}
		graph.graphReset();
		graph.getNode(source).cost = 0;
		graph.processVertex(source);
		newPath.setCost(graph.getNode(dest).cost);
		newPath.setPath(graph.findPath(source, dest));

		return newPath;
	}
}
