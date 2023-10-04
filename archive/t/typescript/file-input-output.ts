import { Readable } from "stream";
import * as fs from 'fs'

const filepath = './output.txt'; //create tempfile.txt in this directory
const write$ = fs.createWriteStream(filepath);
write$.on('finish', () => fs.createReadStream(filepath).on('error', console.error).pipe(process.stdout));
write$.on('error', console.error);

const readableStream = new Readable();
const texts = [
  'The quick brown fox jumped over the lazy pupper\n',
  'The quick brown fox jumped over the lazy dog\n',
  'The quick brown fox jumped over the lazy doggo\n',
  'The quick brown fox jumped over the lazy floof'
];

for (const text of texts) {
    readableStream.push(text);
}
readableStream.push(null);

readableStream.pipe(write$)
