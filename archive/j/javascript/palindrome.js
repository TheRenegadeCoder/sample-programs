function palindrome(str) {
    return (
        str.replace(/[\W_]/g, "").toLowerCase() ===
        str
            .replace(/[\W_]/g, "")
            .toLowerCase()
            .split("")
            .reverse()
            .join("")
    );
}

console.log(palindrome("A man, a plan, a canal. Panama"));
