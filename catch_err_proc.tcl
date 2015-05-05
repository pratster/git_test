#This is a trigger script example so inputs to the script is gotten from the action invoking trigger.
#Write a proc and call it in a script to ci files using soscmd (catch {exec} msg to catch error msgs) 

proc ci_files {handle fname} {
global env
puts $handle "Test message"    
set err [ catch {exec $env(CLIOSOFT_DIR)/bin/soscmd ci $fname -aLog="dummy_msg" -F} msg ]
if {$err} {
puts $handle $msg
} else {
puts $handle "Clean Run"
}

}


#Call proc as follows:
global env
set fp [open /tmp/junk.out w]
puts $fp "This is a test"
set root [file dirname $env(SOS_OBJ_PATH)]
puts $fp $root
set extensions [list file1 file2]
puts $fp $extensions
foreach exten $extensions {
puts $fp $exten
set fname [file join $root $exten]
puts $fp $fname
ci_files $fp $fname
}

