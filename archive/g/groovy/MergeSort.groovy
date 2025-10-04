class MergeSort {

    static sort(int[] data) { sort(data, 0, data.length - 1) }

    /**
     * Sorts the range data[start..end] in O(nlgn) time and O(n) space.
     */
    static sort(int[] data, int start, int end) {

        if (end > start) {

            int middle = (int) ((start + end) / 2)

            // Sort the left and right sides separately.
            sort(data, start, middle)
            sort(data, middle + 1, end)

            // Intertwine the data into one sorted list.
            mergeLists(data, start, middle, end)
        }

    }

    /**
     * Merges the two sorted sublists of data[start..middle] and data[middle+1..end].
     * O(n) time and memory.
     */
    static mergeLists(int[] data, int start, int middle, int end) {

        // Copy the left and right arrays because we'll be overwriting them.
        int[] left = Arrays.copyOfRange(data, start, middle+1)
        int[] right = Arrays.copyOfRange(data, middle+1, end+1)

        // Now, merge the lists by repeatedly adding the biggest value, from whichever list has it.
        int i = start, l = 0, r = 0 // l and r are indexes in left and right
        while (l < left.length && r < right.length)
            data[i++] = (left[l] <= right[r]) ? left[l++] : right[r++]

        // Add any leftovers on one side.
        while (l < left.length)
            data[i++] = left[l++]
        while (r < right.length)
            data[i++] = right[r++]
    }

    static int[] convert_to_ints(def args) {
        int[] argsint = []
        if (args?.size() >= 1) {
            try {
                argsint = args[0].split(",").collect { it.trim().toInteger() }
            }
            catch (NumberFormatException _) {
            }
        }

        argsint
    }

    public static void main(def args) {
        int[] argsint = convert_to_ints(args)
        if (argsint.size() < 2) {
            println 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        } else {
            sort(argsint) 
            println argsint
        }
    }

}