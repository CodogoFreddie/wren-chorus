import "wren-tree/main" for Node

class Command {
	callable { _callable }
	description { _description }
	flags { _flags }
	label { "\u001b[1m%(name)\u001b[0m: %(description)" }
	name { _name }
	subcommands { _subCommands.values }

	description=(val) { _description = val }
	callable=(val) { _callable = val }

	[subPath] { _subCommands[subPath] }
	[subPath]=(subcommand) { _subCommands[subPath] = subcommand }

	toString { "%(treeify)" }

	treeify { 
		var childNodes = []
		for(c in _subCommands.keys){
			if(c != ""){
				childNodes.add( _subCommands[c].treeify )
			}
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
