<html>
    <head>
        <title>Baklava</title>
    </head>
    <body>
        <pre><cfscript>
for (n = -10; n <= 10; n++) {
    numSpaces = abs(n);
    numStars = 21 - 2 * numSpaces;
    spaces = repeatString(" ", numSpaces);
    stars = repeatString("*", numStars);
    writeOutput(spaces & stars & "<br>");
}
        </cfscript></pre>
	</body>
</html>
