import "os" for Process
import "wren-tree/main" for Node, Tree

import "./flag" for Flag

class Command {
	name { _name }
	description { _description }
	label { "[%(name)]: %(description)" }

	description=(val) { _description = val }
	callable=(val) { _callable = val }

	[subPath] { _subCommands[subPath] }
	[subPath]=(subcommand) { _subCommands[subPath] = subcommand }

	toString { "%(treeify)" }

	treeify { 
		var childNodes = []
		for(c in _subCommands.keys){
			childNodes.add( _subCommands[c].treeify )
		}

		return Node.new(
			label,
			childNodes
		)
	}

	construct new(name, description, flags, callable){
		_name = name
		_description = description
		_flags = flags 
		_callable = callable
		_subCommands = {}
	}

	addFlag(flag){
		_flags.add(flag)
	}
}

class Chorus {
	construct new(name){
		_hierarchy = Command.new(name, "", [], null)
	}

	findCommandAtPath(pathString){
		//split pathString:
		var pathList = []
		var buffer = ""
		for(c in pathString){
			if(c == " "){
				pathList.add(buffer)
				buffer = ""
			} else {
				buffer = buffer + c
			}
		}
		pathList.add(buffer)

		var writeHead = _hierarchy
		for(command in pathList){
			if(!writeHead[command]){
				writeHead[command] = Command.new(command, "No Description", [], null)
			}

			writeHead = writeHead[command]
		}

		return writeHead
	}

	addCommand(pathString, callable){
		var command = findCommandAtPath(pathString)
		command.callable = callable
	}

	addDescription(pathString, description){
		var command = findCommandAtPath(pathString)
		command.description = description
	}

	addFlag(pathString, flag){
	}

	addFlag(pathString, name, type){
		addFlag(pathString, Flag.new(name, type) )
	}

	addFlag(pathString, name, type, description){
		addFlag(pathString, Flag.new( name, type, description) )
	}

	addFlag(pathString, name, type, description, shortName){
		addFlag(pathString, Flag.new(name, type, description, shortName) )
	}


	run(){ run(Process.arguments) }

	run(args){
		System.print("%(_hierarchy)")

		if(args.count == 0){
			return System.print("PRINT COMMANDS INFO")
		}
		var path = args
		var rawFlags = []

		for(i in 0...args.count){
			if(args[i][0] == "-"){
				path = args[0...i]
				rawFlags = args[(i)..-1]
				break
			}
		}

		path = path.join(" ")
	}
}
