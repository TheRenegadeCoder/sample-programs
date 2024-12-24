<html>
    <head>
        <title>Baklava</title>
    </head>
    <body>
    <!--
    Algorithm:

        for i = -10 to 10:
            for j = 1 to abs(i):
                output ' '
            for j = 1 to 21-2*abs(i):
                output '*'
            output '\n'
    -->
        <pre><cfloop index="i" from="-10" to="10"><cfloop index="j" from="1" to="#abs(i)#"><cfoutput> </cfoutput></cfloop><cfloop index="j" from="1" to="#21-2*abs(i)#"><cfoutput>*</cfoutput></cfloop>
</cfloop></pre>
	</body>
</html>
