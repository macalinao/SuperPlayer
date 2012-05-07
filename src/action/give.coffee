sdk = require("sdk")

Action = sdk.Action

give = exports.give = Action.define
    name: "give"
    aliases: ["g"]
    flags: [
        ["d", "drop", "", "Drops the item instead of adding it to the inventory."]
    ]
    sender: "Player"

    executor: (context) ->
        flags = context.flags
        itemName = context.getString 0
        item = game.items.match itemName

        unless item?
            context.exit "The item '#{itemName}' could not be found.", 1

        targetName = context.getString 1
        target = game.players.match targetName

        unless target?
            context.exit "The player '#{targetName}' could not be found.", 1


        if flags.has "d"
            position = target.entity.position
            position.world.spawnItem item
            context.exit "An item of type #{item.name} was dropped by the player #{target.name}.", 0

        else
            inventory = target.entity.inventory
            if inventory.isFull()
                context.exit "The inventory of the player '#{target}' is full."

            inventory.add item
            context.exit "An item of type #{item.name} was added to the inventory of the player #{target.name}.", 0