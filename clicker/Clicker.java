import java.awt.Robot;
import java.awt.event.InputEvent;

public class Clicker {
    
    public static void main(String[] args) {
        (new Clicker()).click();
    }
    
    public void click() {
        Robot r;
        try {
            r = new Robot();
        } catch (java.awt.AWTException e) {
            System.out.println("Could not create robot.");
            return;
        }
        while (true) {
            r.delay(5000); // Sleep for 5 seconds
            r.mousePress(InputEvent.BUTTON1_MASK); // Press mouse
            r.delay(100); // Sleep for 1/10 second
            r.mouseRelease(InputEvent.BUTTON1_MASK); // Release mouse
        }
    }
}

