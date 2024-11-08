public class LongestPalindromicSubstring
{
    public string LongestPalindrome(string input)
    {
        if (string.IsNullOrEmpty(input)) return "";

        int start = 0;
        int end = 0;

        for (int i = 0; i < input.Length; i++)
        {
            int lengthOne = ExpandAroundCenter(input, i, i);
            int lengthTwo = ExpandAroundCenter(input, i, i + 1);
            int length = Math.Max(lengthOne, lengthTwo);

            if (length > end - start)
            {
                start = i - (length - 1) / 2;
                end = i + length / 2;
            }
        }
        return input.Substring(start, end - start + 1);
    }
}