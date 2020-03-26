function page() {
	<h1>Hello, World!</h1>
}

Server.start(
	Server.http,
	{~page, title: "SPEPL"}
)
