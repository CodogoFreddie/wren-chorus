class Flag {
	description { _description }
	name { _name }
	shortName { _shortName }
	type { _type }

	description=(x){ _description = x }
	name=(x){ _name = x }
	type=(x){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		} else {
			return _type = x
		}
	}


	toString {
		var acc = ""
		if ( shortName ) {
			acc = acc + "-%(shortName) / "
		}

		acc = acc + "--%(name) (%(type))"

		if( description ) {
			acc = acc + ": %(description)"
		}

		return acc
	}

	construct new(name, type){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_name = name
		_type = type
	}

	construct new(name, type, description){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_description = description
		_name = name
		_type = type
	}

	construct new(name, type, description, shortName){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_description = description
		_name = name
		_shortName = shortName
		_type = type
	}

	==(stringFlag){
		Fiber.abort("wew")
	}
}

