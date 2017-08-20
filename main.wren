import "os" for Process
import "wren-deleggate/main" for Dispatcher, DispatchPolices
import "wren-tree/main" for Node, Tree

import "./flag" for Flag

class Chorus {
	construct new(name){
		_commandDispatcher = Dispatcher.root(name)
		_commandDispatcher.flags = DispatchPolices.callOne

		_flagParser = Dispatcher.root()
		_flagParser = DispatchPolices.callShallower
	}

	addCommand(pathString, callable){ 
		addCommand(pathString, "No Description Given", callable)
	}
	addCommand(pathString, description, callable){
		//chunk pathString
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

		_commandDispatcher.addListener(pathList, callable)
		
		pathList.add("help")
		_commandDispatcher.addListener(pathList) {
			System.print("
Help for [%(pathList.join(" "))]
%(description)
")
		}
	}

	run(){ run(Process.arguments) }

	run(args){
		if(args.count == 0){
			return System.print("
Command Structure:
==================
%(_commandDispatcher)
")
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

		System.print("%(path) : %(rawFlags)")
		_commandDispatcher.dispatch(path, "DEFAULT INPUT")
	}
}
