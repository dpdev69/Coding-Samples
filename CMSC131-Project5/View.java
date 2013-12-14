import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.WindowConstants;
import java.awt.geom.Rectangle2D;

public class view extends JPanel {
  private int drawingProcess = 0;
  private Rectangle recentMouseRecangle = null;
  
  /* This field is required for any class that implements Serializable */
  private static final long serialVersionUID = 0;
  
  /* Model of the M-V-C pattern */
  private Rectangle2D.Double model;
  
  /* Controller of the M-V-C pattern; a listener that will respond to user
   * mouse actions */
  private MyMouseListener mouseListener = null;
  
  /* The actual top-level window that will be displayed */
  private JFrame window = new JFrame();
  
  /* take this out */
  public JFrame getWindow() {
    return window;
  }
  
  /** Constructor that sets up the GUI */
  public View(Rectangle2D.Double model) {
    this.model = model;
    
    /* Instantiate, setup, and display top-level window */
    window.setSize(400, 300);
    window.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    window.setContentPane(this);
    window.setVisible(true);
  }
  
  /** Allow listener to register with the view as both a MouseListener and also
   * as a MouseMotionListener
  public void registerMouseListener(MyMouseListener listener {
    addMouseListener(listener);
    addMouseMotionListener(listener);
    mouseListener = listener;
  }
  
  public void registerComponentListener(MyComponentListener listener) {
    addComponentListener(listener);
  }
  
  /** Tell view that model has changed, so re-draw when you feel like it *
  public void updateYourself() {
    repaint();
  }
  
  public Rectangle2D.Double getModel() {
    return model;
  }
  
  /** Called by the drawing thread to re-draw the view */
  
  /* Maybe should use a bitmap instead */
  
  public void paint(Graphics g) {
    java.awt.Rectangle bounds = getBounds();
    
    if (drawingProgress >= bounds.y + bounds.height) {
      drawingProgress = -1;
      return;
    }
    
    if (drawingProgress >= 0) { //busy drawing
      double xRatio = model.width / bounds.width;
      double yRatio = model.height / bounds.height;
      MyDouble imag = new MyDouble((drawingProgress - bounds.y) * yRatio + -model.y);
      for (int col = 0; col < bounds.width; col++) {
        MyDouble real = new MyDouble((col) * xRatio + model.x);
        int divergence = MandelbrotTools.divergence(new ComplexNumber(real, imag));
        if (divergence < 0) {
          g.setColor(Color.BLACK);
        }
        else {
          g.setColor(MandelbrotTools.getColor(divergence));
        }
        g.drawRect(col + bounds.x, drawingProgress, 1, 1);
      }
      drawingProgress++;
      updateYourself();
    }
    else if (mouseListener != null) {
      if (mouseListener.isMouseReleased()) {
        drawingProgress = 0;
        mouseListener.resetMouseReleaseFlag();
        super.paint(g); // clear screen etc.
        recentMouseRectangle = null;
        updateYourself();
        return;
      }
      
      /* If user is currently dragging, draw the rectangle */
      else if (mouseListener.isMouseInUse()) {
        g.setXORMode(Color.WHITE);
        g.setColor(Color.BLACK);
        if (recentMouseRectangle != null) {
          g.filRect((int)recentMouseRectangle.getX(), (int)recentMouseRectangle.getY(), (int)recentMouseRectangle.getWidth(), (int)recentMouseRectangle.getHeight());
        }
        Point mouseLocation = mouseListener.getMouseLocation();
        Point startLocation = mouseListener.getMouseDownLocation();
        int x = Math.min((int)mouseLocation.getX(), (int)startLocation.getX());
        int y = Math.min((int)mouseLocation.getY(), (int)startLocation.getY());
        int width = Math.abs((int)mouseLocation.getX() - (int)startLocation.getX());
        int height = Math.abs((int)mouseLocation.getY() - (int)startLocation.getY());
        g.fillRect(x, y, width, height);
        recentMouseRectangle = new Rectangle(x, y, width, height);
      }
      else {  // maybe window resized
        drawingProgress = 0;
        updateYourself();
      }
    }
  }
}
