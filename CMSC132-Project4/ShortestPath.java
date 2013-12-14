package graph;

public class ShortestPath<V> {

  private Iterable<V> path= null;
  private int shortestPathCost= 0;

  public void setPath(Iterable<V> path) {
    this.path= path;
  }

  public void setCost(int shortestPathCost) {
    this.shortestPathCost= shortestPathCost;
  }

  public Iterable<V> getPath() {
    return path;
  }

  public int getCost() {
    return shortestPathCost;
  }

}
