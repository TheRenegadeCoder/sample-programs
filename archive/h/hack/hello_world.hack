use namespace HH\Lib\IO;

<<__EntryPoint>>
async function main(): Awaitable<void> {
    await IO\request_output()->writeAllAsync("Hello World!\n");
}
