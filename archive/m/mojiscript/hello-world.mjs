import log from 'mojiscript/console/log'
import pipe from 'mojiscript/core/pipe'
import run from 'mojiscript/core/run'

const state = 'Hello, World!'

const main = pipe ([
  log
])

run ({ state, main })