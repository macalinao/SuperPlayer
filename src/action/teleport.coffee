sdk = require("sdk")

Action = sdk.Action
Color = sdk.Color
Position = sdk.Position

# Actions are based on this: https://gist.github.com/2623987


getPosFromString = (posString, sender) ->
    ###
    Gets a position from a string.

    The formats are as follows:
    * world,x,y,z
    * x,y,z
    ###
    splits = posString.split ","

    # Initialize the variables
    world = x = y = z = null

    # Check for x,y,z
    if splits.length == 3
        unless sender?
            return false

        world = sender.entity.world
        x = parseFloat splits[0]
        y = parseFloat splits[1]
        z = parseFloat splits[2]

    # Check for world,x,y,z
    else if splits.length == 4
        world = game.getWorldByName splits[0]
        unless world?
            return false

        x = parseFloat splits[1]
        y = parseFloat splits[2]
        z = parseFloat splits[3]

    else
        return false

    return new Position world, x, y, z

teleport = exports.teleport = Action.define
    name: "teleport"
    aliases: ["tp"]
    flags: [
        ["p", "pos", "", "The position to teleport to."]
    ]
    sender: "Player"

    executor: (context) ->
        position;

        flags = context.flags
        unless flags.has "p"
            player = game.matchPlayer context.args.getString 0
            if player?
                position = player.entity.position
            else
                context.exit "The player you specified is not online or does not exist."

        else
            posString = flags.get "p"
            position = getPosFromString posString, context.sender
            
            # Check if pos is not undefined or false
            unless position
                context.exit "The position you specified is not a valid position.\n"\
                    + "Valid formats: #{Color.BLUE}world,x,y,z#{Color.NORMAL} or #{Color.BLUE}x,y,z#{Color.NORMAL}."

        # Teleport to the position.
        player.entity.teleportTo pos

# Register the teleport action.
game.registerAction teleport