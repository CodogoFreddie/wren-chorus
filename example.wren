import "os" for Process
import "./main" for Flag, Chorus

/*System.print(Process.arguments)*/
/*System.print("*/
/*example.wren package */
/*example.wren package publish --as-user freddie --version 1.2.3*/
/*example.wren package test --max-errors 5 */
/*example.wren run example -v --time*/
/*example.wren run main --time*/
/*example.wren run --script main.wren*/
/*")*/

var chorus = Chorus.new("example.wren")

//example.wren package
//====================

//example.wren package 
chorus.addCommand("package") { |flags| System.print("[print package info] (%(flags))") }
//example.wren package publish
chorus.addCommand("package publish") { |flags| System.print("[publish the package] (%(flags))") }
//example.wren package test
chorus.addCommand("package test") { |flags| System.print("[test the package] (%(flags))") }


//example.wren run
//================

//example.wren run example
chorus.addCommand("run example") { |flags| System.print("[run the example script] (%(flags))") }
//example.wren run main
chorus.addCommand("run main") { |flags| System.print("[run the main script] (%(flags))") }
//example.wren run
chorus.addCommand("run") { |flags| System.print("[prints info about the run command] (%(flags))") }


chorus.run([])
chorus.run()
chorus.run(["package", "publish", "help"])
