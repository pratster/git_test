#!/usr/bin/tclsh

global env

set extensions [list .oalib eesof_lib.cfg]
   set fp [open /tmp/junk.out w]
   puts $fp "This is a test"
   if { [info exist env(SOS_OBJ_PATH)] && $env(SOS_OBJ_PATH) != "" } {
     puts $fp $env(SOS_OBJ_PATH)
     set root [file dirname $env(SOS_OBJ_PATH)]
     foreach exten $extensions {
       set fname [file join $root $exten]
       set objstat [list exec $env(CLIOSOFT_DIR)/bin/soscmd objstatus $fname]
       puts $fp $objstat
       puts $fp [eval $objstat]
       set status [lindex [eval $objstat] 0]
       puts $fp $status
       switch $status {
         0 { puts $fp "Path does not belong in the specified workarea" }
         1 { puts $fp "Object does not exist in the workarea" }
         2 { puts $fp "Object exists in the workarea, but is not managed by sos"
             exec $env(CLIOSOFT_DIR)/bin/soscmd create $fname -aLog="create by LibConfig trigger" -F}
         3 { puts $fp "Object is currently checked out in the workarea"
             exec $env(CLIOSOFT_DIR)/bin/soscmd ci $fname -aLog="ci by LibConfig trigger" -F}
         4 { puts $fp "Object is currently checked out in a different workarea" }
         5 { puts $fp "Object is currently checkedin at the server" }
         6 { puts $fp "Object is currently checked out in the workarea but not locked in the server" }
         default { puts $fp "Invalid objstatus" }
       }
     }
   }
close $fp
