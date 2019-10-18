/** Invalid input exception to handle errors. */
class InvalidInputException extends Exception {}


public class JobSequencing {

    public class Job {

        public Job(int profit, int deadline) {
            this.profit = profit;
            this.deadline = deadline;
        }

        int profit;
        int deadline;
    }


    public int getMostProfit(List<Integer> deadlines, List<Integer> profits) {
        List<Job> jobs = createJobList(deadlines, profits);
        int largestDeadline = Collections.max(deadlines);
        for (int i = 0; i < largestDeadline ; i ++) {
//            jobs.streams().filters(job-> job.deadline == i)
        }

    }

    private List<Job> createJobList(List<Integer> deadlines, List<Integer> profits) {
        List<Job> jobs = new ArrayList<>();
        for (int i = 0; i < deadlines.size() ; i++ ) {
            jobs.add(new Job(deadlines[i], profits[i]))
        }

        return jobs
    }


    public static void main(String[] args) {
        try {
            // null, empty or too many input
            if (args.length != 2 ) {
                throw new InvalidInputException();
            }

            //Get profit and deadline
            List<String> profits = Integer. valueOf(args[0].split(", "))
            List<String> deadlines = Integer. valueOf(args[1].split(", "))

            //Check of lists have lifferent Lengths
            if (!profit.size().equals(deadline.size())) {
                throw new InvalidInputException();
            }

            getMostProfit(deadlines, profits);

        } catch (NumberFormatException | PrimeNumberException e) {
            System.err.println("Usage: please provide a list of profits and a list of deadlines");
        }
        }
    }
}
