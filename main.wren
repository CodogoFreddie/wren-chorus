import "os" for Process
import "wren-tree/main" for Node

import "./command" for Command
import "./flag" for Flag

class Chorus {
	documentation { "
CLI Commands:
=============
%(_hierarchy)

Append any command with 'help' to view more complete documentation.
" }

	construct new(name){
		_hierarchy = Command.new(name, "", [], null)
	}

	findCommandsAlongPath(path){
		var pathList = []
		if(path is List){
			pathList = path
		} else {
			//split pathString:
			var buffer = ""
			for(c in path){
				if(c == " "){
					pathList.add(buffer)
					buffer = ""
				} else {
					buffer = buffer + c
				}
			}
			pathList.add(buffer)
		}

		var writeHead = _hierarchy
		var traversedCommands = [writeHead]
		for(command in pathList){
			if(!writeHead[command]){
				writeHead[command] = Command.new(command, "No Description", [], null)
			}

			writeHead = writeHead[command]
			traversedCommands.add(writeHead)
		}

		return traversedCommands
	}

	findCommandAtPath(path){ findCommandsAlongPath(path)[-1] }

	addCommand(pathString, callable){
		var command = findCommandAtPath(pathString)
		command.callable = callable
	}

	addDescription(pathString, description){
		var command = findCommandAtPath(pathString)
		command.description = description
	}

	addFlag(flag){
		//root flag: applies to all subcommands
		_rootFlags = _rootFlags || []
		_rootFlags.add(flag)
	}

	addFlag(pathString, flag){
		var command = findCommandAtPath(pathString)
		command.addFlag(flag)
	}

	run(){ run(Process.arguments) }

	run(args){
		if(args.count == 0){
			return System.print("%(documentation)")
		}

		var path = []
		path.addAll(args)
		var rawFlags = []

		for(i in 0...args.count){
			if(args[i][0] == "-"){
				path = args[0...i]
				rawFlags = args[(i)..-1]
				break
			}
		}

		if(path[-1] == "help"){
			return printHelpForPath(path[0...-1])
		}

		var parsedFlags = {}
		var activeFlags = getActiveFlags(path)

		for(flag in activeFlags){
			parsedFlags[flag.name] = flag.parse(rawFlags)
		}

		var command = findCommandAtPath(path)
		var commandCallable = command.callable
		if(commandCallable){
			commandCallable.call(parsedFlags)
		} else {
			Fiber.abort("Can not call %(path.join(" ")), must call one of its sub commands:\n\n%(command)\n")
		}
	}

	getActiveFlags(path){
		var activeFlags = findCommandsAlongPath(path)
		activeFlags = activeFlags.map { |command| command.flags }
		activeFlags = activeFlags.reduce([]) { |acc, val| 
			var newAcc = acc
			newAcc.addAll(val)
			return newAcc
		}
		activeFlags.addAll(_rootFlags)

		return activeFlags
	}

	printHelpForPath(path){
		var command = findCommandAtPath(path)
		var activeFlags = getActiveFlags(path)

		var description = "
Description:
------------
%(command.description)
"

		var subcommands = ""
		if(!command.subcommands.isEmpty){
			subcommands = "
Subcommands:
------------
%(command.subcommands.join("\n"))
"
		}

		var validFlags = "
Valid Flags:
------------
%(activeFlags.join("\n"))
"

		System.print("[%(path.join(" ")) help] %(description) %(subcommands) %(validFlags) ")

	}
}
