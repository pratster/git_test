#!/usr/bin/tclsh
if { [info exists env(SOS_CheckedOutByInWA)] && $env(SOS_CheckedOutByInWA) != "" } {
  exec $env(CLIOSOFT_DIR)/bin/soscmd discardco &
  puts "** Error: The file $env(SOS_OBJ_PATH) cannot be checked out without lock. The checkout has been discarded."
  exit -1
} else {
  exit 0
}
