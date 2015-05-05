#!/usr/bin/tclsh
if { [info exist env(SOS_CheckedOutBy)] && $env(SOS_CheckedOutBy) != "" } {
  puts "The file $env(SOS_OBJ_PATH) is already checked out by $env(SOS_CheckedOutBy)."
  exit 1
} else {
  exit 0
}
