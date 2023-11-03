// TODO: Task 1 make Week iterable
public class Week {
    private final String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

    public String getDay(int i) {
        return days[i];
    }

    /**
     * Sample usage of the Week class. See WeekTest.java for the tests.
     */
    public static void main(String[] args) {
        Week week = new Week();

        for (int i = 0; i != 7; i++) {
            System.out.println(week.getDay(i));
        }
    }
}
