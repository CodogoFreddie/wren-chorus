class Flag {
	defaultValue { _defaultValue }
	description { _description }
	name { _name }
	shortName { _shortName }
	type { _type }

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

	construct optional(name, type){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_name = name
		_type = type
	}

	construct optional(name, type, description){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_description = description
		_name = name
		_type = type
	}

	construct optional(name, type, shortName, description){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_description = description
		_name = name
		_shortName = shortName
		_type = type
	}

	construct optional(name, type, shortName, defaultValue, description){
		if(type != Bool && type != Num && type != String){
			Fiber.abort("Flag type must be either a Bool, a Num, or a String")
		}

		_defaultValue = defaultValue
		_description = description
		_name = name
		_shortName = shortName
		_type = type
	}

	parse(allRawFlags){
		var longFlagMatcher = "--" + name
		var shortFlagMatcher = shortName ? ("-" + shortName) : null

		var value = defaultValue || (type == Bool ? false : null)
		for(i in 0...allRawFlags.count){
			if(allRawFlags[i] == longFlagMatcher || allRawFlags[i] == shortFlagMatcher){
				if(type == Bool){
					value = true
					break
				}

				if(type == String){
					value = allRawFlags[i + 1]
					break
				}

				if(type == Num){
					value = Num.fromString(allRawFlags[i + 1])
					break
				}
			}
		}

		return value
	}

	==(stringFlag){
		Fiber.abort("wew")
	}
}

