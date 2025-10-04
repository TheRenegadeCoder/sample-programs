import log from 'mojiscript/console/log'
import pipe from 'mojiscript/core/pipe'
import run from 'mojiscript/core/run'
import map from 'mojiscript/list/map'
import range from 'mojiscript/list/range'

const numSpaces = n => Math.abs(n)
const numStars = n => 21 - 2 * numSpaces (n)
const baklavaLine = n => ' '.repeat(numSpaces (n)) + '*'.repeat(numStars (n))

const main = pipe([
    range (-10) (11),
    map (baklavaLine),
    map (log)
])

run({main})
