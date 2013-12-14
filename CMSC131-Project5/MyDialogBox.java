import java.awt.Component;
import java.awt.Dialog;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.JLabel;

public class MyDialogBox extends JFrame {
  private static final long serialVersionUID = 1L;
  private Dialog dialogBox;
  private JRadioButton[] colorChoices = new JRadioButton[3];
  private JLabel limitPrompt = new JLabel("Max number of iterations to check for divergence:");
  // private JLabel boundaryPrompt = new JLabel("Assume divergence if norm exceeds:");
  private JTextField limit = new JTextField(" 255");
  // private JTextField boundary = new JTextField(" 4.0");
  private JButton goButton = new JButton("GO");
  private JLabel colorHeading = new JLabel("Choose color scheme: ");
  // private JLabel blank = new JLabel(" ");
  
  public MyDialogBox() {
    colorChoices[0] = new JRadioButton("Red and White Bands");
    colorChoices[1] = new JRadioButton("Crazy Colors");
    colorChoices[2] = new JRadioButton("Student Defined Colors");
    
    ButtonGroup group = new ButtonGroup();
    for (int i = 0; i < 3; i++)
      groud.add(colorChoices[i]);
    colorChoices[0].setSelected(true);
    
    final int NUM_PANELS = 3;
    JPanel panel[] = new JPanel[NUM_PANELS];
    for (int i = 0; i < NUM_PANELS; i++) {
      panel[i] = new JPanel();
      // panel[i].setLayout(new java.awt.BorderLayout());
      // panel[i].setAlignmentY(java.awt.Component.LEFT_ALIGNMENT);
    }
    
    panel[0].add(colorHeading);
    // panel[1].setLayout(new FlowLayout());
    for (int i = 0; i < 3; i++)
      panel[0].add(colorChoices[i]);
    //panel[2].add(blank);
    //panel[3].add(boundaryPrompt);
    //panel[3].add(boundary);
    panel[1].add(limitPrompt);
    panel[1].add(limit);
    goButton.setAlignmentX(Component.LEFT_ALIGNMENT);
    panel[2].add(goButton);
    
    dialogBox = new Dialog("this, "Choose Options", true);
    dialogBox.setLayout(new GridLayout(NUM_PANELS, 1));
    for (int i = 0; i < NUM_PANELS; i++)
      dialogBox.add(panel[i]);
    
    goButton.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        if (colorChoices[0].isSelected())
          Controller.colorScheme = 0;
        else if (colorChoices[1].isSelected())
          Controller.colorScheme = 1;
        else
          Controller.colorScheme = 2;
        
        // Controller.DIVERGENCE_BOUNDARY = new MyDouble(Double.parseDouble(boundary.getText().trim()));
        Controller.LIMIT = Integer.parseInt(limit.getText().trim());
        
        // Hide dialog
        MyDialogBox.this.dialogBox.setVisible(false);
      }
    });
    
    dialogBox.pack();
    dialogBox.setVisible(true);
  }
}
