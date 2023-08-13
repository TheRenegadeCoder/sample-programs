MODULE hello_world;

FROM StrIO IMPORT WriteString, WriteLn;

BEGIN
	WriteString('Hello, World!');
	WriteLn;
END hello_world.
