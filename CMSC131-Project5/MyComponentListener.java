import java.awt.event.ComponentListener;
import java.awt.event.*;
import java.awt.Rectangle;
import java.awt.geom.Rectangle2D;

public class MyComponentListener implements ComponentListener {
  View view;
  
  public MyComponentListener(View view) {
    this.view = view;
  }
  
  public void componentMoved(ComponentEvent e) {
  
  }
  
  public void componentHidden(ComponentEvent e) {
  
  }
  
  public void componentShown(ComponentEvent e) {
  
  }
  
  public void componentResized(ComponentEvent e) {
    Rectangle2D.Double m = view.getModel();
    double modelAspectRatio = m.height / m.width;
    Rectangle bounds = view.getBounds();
    double viewAspectRatio = (double)bounds.height / bounds.width;
    System.out.println("adjusting model...");
    if (modelAspectRatio < viewAspectRatio) {   // good for shrinking -- not good for growing
      m.width = m.height / viewAspectRatio;
    }
    else {
      m.height = m.width * viewAspectRatio;
    }
    
    view.updateYourself();
    // redraw the view
  }
}
