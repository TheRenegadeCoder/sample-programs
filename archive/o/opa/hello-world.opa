function page() {
	<pre>Hello, World!</pre>
}

Server.start(
	Server.http,
	{~page, title: "SPEPL"}
)
