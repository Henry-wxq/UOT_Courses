import org.junit.Before;
import org.junit.Test;

import java.util.Iterator;

import static org.junit.Assert.*;


public class WeekTest {

    private Week week;
    private Iterator<String> days;

    @Before
    public void init() {
        week = new Week();
        days = week.iterator();
    }

    @Test
    public void testMainRuns() {
        Week.main(new String[]{});
    }

    @Test
    public void testForEachLoop() {
        int iterations = 0;
        for (String s :
                week) {
            iterations += 1;
        }
        assertEquals(7, iterations);
    }

    @Test
    public void getDay() {
        assertEquals("Sunday", week.getDay(0));
        assertEquals("Saturday", week.getDay(6));
    }

    @Test
    public void testFirst() {
        assertTrue(days.hasNext());
        assertEquals("Sunday", days.next());
    }

    @Test
    public void testHasNextTwice() {
        assertTrue(days.hasNext());
        assertTrue(days.hasNext());
        assertEquals("Sunday", days.next());
    }

    @Test
    public void testNextAndGetDay() {
        for (int i = 0; i != 7; i++) {
            assertEquals(week.getDay(i), days.next());
        }
    }

    @Test
    public void testHasNextWhenFalse() {
        for (int i = 0; i != 7; i++) {
            days.next();
        }
        assertFalse(days.hasNext());
    }

    // TODO: Task 2 Add a test as outlined in the readme

}