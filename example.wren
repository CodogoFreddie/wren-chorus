import "os" for Process
import "./main" for Flag, Chorus

/*System.print(Process.arguments)*/
/*System.print("*/
/*example.wren package */
/*example.wren package publish --as-user freddie --version 1.2.3 --verbose */
/*example.wren package test --max-errors 5 */
/*example.wren run example -v --time*/
/*example.wren run main --time*/
/*example.wren run custom --script main.wren*/
/*")*/

var chorus = Chorus.new("example.wren")

//example.wren package
//====================

//example.wren package 
chorus.addCommand("package") { |flags| System.print("[print package info] (%(flags))") }
chorus.addDescription("package", "Commands for administering and controlling a wren package")
//example.wren package publish
chorus.addCommand("package publish") { |flags| System.print("[publish the package] (%(flags))") }
chorus.addDescription("package publish", "Publishes the current package to the wrengestry")
chorus.addFlag(
	"package publish",
	Flag.optional(
		"as-user",
		String,
		"Use the specified user to publish with"
	)
)
chorus.addFlag(
	"package publish",
	Flag.optional(
		"version",
		String,
		"Set the version before publishing"
	)
)

//example.wren package test
chorus.addCommand("package test") { |flags| System.print("[test the package] (%(flags))") }
chorus.addFlag(
	"package publish",
	Flag.optional(
		"max-errors",
		Num,
		"Set the version before publishing"
	)
)

//example.wren run
//================

//custom.wren run custom
chorus.addCommand("run custom") { |flags| System.print("[run a custom script] (%(flags))") }
chorus.addFlag(
	"run custom",
	Flag.optional(
		"script",
		String,
		"The path to a custom script to run"
	)
)

//example.wren run example
chorus.addCommand("run example") { |flags| System.print("[run the example script] (%(flags))") }

//example.wren run test
chorus.addCommand("run test") { |flags| System.print("[run the test script] (%(flags))") }

//example.wren run
chorus.addFlag(
	"run",
	Flag.optional(
		"time",
		Bool,
		"Times the execution of a script, and reports that time after termination"
	)
)

//a flag for all possible commands and subcommands:
chorus.addFlag(
	Flag.optional(
		"verbose",
		Bool,
		"Run program with verbose debugging"
	)
)

/*chorus.run([])*/
chorus.run()
/*chorus.run(["package", "publish", "help"])*/
