main = require "./main"
sdk = require "sdk"

# Should this auto-populate?
actionList = [
    "teleport"
]

for exclude in main.config.excludes
    check = actionList.indexOf exclude
    if check > -1
        actionList.splice check, 1

for action in actionList
    require "./actions/" + action