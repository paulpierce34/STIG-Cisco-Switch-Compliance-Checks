## Most recent STIG: 
###            Cisco IOS Switch NDM STIG - V2R3 - Released: 23 Jul 2021



## PURPOSE: The purpose of this script is to keep track of STIG items for Cisco IOS Switch NDM to ensure compliance



## HOW SCRIPT WORKS: Script searches through switch configuration files, one at a time, and cross-references the config to the most recent NDM STIG checklist for Cisco IOS Devices. Script then outputs results to .txt file and optionally creates checklists.

##                   Files Output:
##                   1.) Quick Glance .txt file which summarizes the compliance for each switch.
##                   2.) (Optional) - Checklists for each switch configuration


## HOW TO USE: 

### Step 1: Run script, follow prompts
### Step 2: If you answer YES to checklist creation, a different checklist will be created for each switch configuration
### Step 3: Script will also generate a "Quick Glance" file which is a .txt file that gives you a quick way to view how compliant each switch configuration is. 








$ScriptSummary = write-host -ForegroundColor Cyan "`n`nThis script makes ZERO changes to any switch configurations, and is used solely for tracking compliance. This script searches through switch configuration files, one at a time, and cross-references the config to the most recent NDM STIG checklist for Cisco IOS Devices. Script then outputs results to .txt file and optionally creates checklists.`n`n"
Pause




## ASK QUESTIONS FOR INPUT/OUTPUT DIRECTORY #####################
$Configdirectory = read-host "Please provide the directory path for where each Cisco IOS Switch configuration file is located"

if (test-path $Configdirectory){

$BlankFilePath = read-host "Please provide the FULL filepath for where the blank STIG is found (must include filename i.e. C:\temp\blank.ckl)"


}
else {


write-host -foregroundcolor Red "Unable to validate the following directory path provided exists: $Configdirectory. Terminating script...."
break

}

## Test to make sure the blank file path is BOTH a file, and a valid path
if (test-path $BlankFilePath -PathType Leaf){

$OutputDirPath = read-host "Please provide the directory path for file output"

$CreateCKL = read-host "Would you like for this script to create checklists for each switch configuration? Type yes (or y)  or no (or n)"

}
else {

write-host -foregroundcolor Red "The path provided: $BlankFilePath either doesn't include the FULL filepath (including filename) or is an invalid path. Terminating script..."
break
}
## END ASK QUESTIONS FOR INPUT/OUTPUT DIRECTORY #####################
if (test-path $OutputDirPath){

##continue


}
else {

write-host -foregroundcolor Red "It looks like the output directory path provided does not exist. $OutputDirPath   Terminating script..."
break
}

## GLOBAL VARIABLES #####

$TodayDate = Get-Date -Format yyyyMMdd
$Date = Get-date

$Nonessential = @(

"boot network",
"ip boot server",
"ip bootp server",
"ip dns server",
"ip identd",
"ip finger",
"ip http server",
"ip rcmd rcp-enable",
"ip rcmd rsh-enable",
"service config",
"service finger",
"service tcp-small-servers",
"service udp-small-servers"

)

## Adding the wildcard character to the config directory, so the $AllSwitchConfigs variable can use the -include switch for get-childitem. In order to use this switch, you need a wildcard at the end of the path, or the -recurse switch.
$AllConfigsPlusWildcard = $Configdirectory + "\" + "*"

$AllSwitchConfigs = Get-childitem -Path $AllConfigsPlusWildcard -include *.txt, *.config ## Gets all of the .txt configuration files for each switch





## XML Settings to replicate those of STIGViewer #######################################################################################################################
$XMLSettings = New-Object -TypeName System.XML.XMLWriterSettings
$XMLSettings.Indent = $true;
$XMLSettings.IndentChars = "`t"
$XMLSettings.NewLineChars="`n"
$XMLSettings.Encoding = New-Object -TypeName System.Text.UTF8Encoding -ArgumentList @($false)
$XMLSettings.ConformanceLevel = [System.Xml.ConformanceLevel]::Document
### End of STIGViewer settings ########################################################################################################################################



## END GLOBAL VARIABLES SECTION #####





## For each switch configuration file
foreach ($SingleSwitch in $AllSwitchConfigs){

## The below in this format:  Vuln_ID, Status, Comments
$Vuln220570 = “V-220570”, “Not_Reviewed”, “null“
$Vuln220571 = “V-220571”, “Not_Reviewed”, “null“
$Vuln220572 = “V-220572”, “Not_Reviewed”, “null“
$Vuln220573 = “V-220573”, “Not_Reviewed”, “null“
$Vuln220574 = “V-220574”, “Not_Reviewed”, “null“
$Vuln220575 = “V-220575”, “Not_Reviewed”, “null“
$Vuln220576 = “V-220576”, “NotAFinding”, “Configured in Cisco ISE” ## Configured in Cisco ISE, hence why it's hardcoded as notafinding
$Vuln220577 = “V-220577”, “Not_Reviewed”, “null“
$Vuln220578 = “V-220578”, “Not_Reviewed”, “null“
$Vuln220579 = “V-220579”, “Not_Reviewed”, “null“
$Vuln220580 = “V-220580”, “Not_Reviewed”, “null“
$Vuln220581 = “V-220581”, “Not_Reviewed”, “null“
$Vuln220582 = “V-220582”, “Not_Reviewed”, “null“
$Vuln220583 = “V-220583”, “Not_Applicable”, “null“ ## Not Applicable (persistent logging not enabled)
$Vuln220584 = “V-220584”, “Not_Applicable”, “null“ ## Not Applicable (persistent logging not enabled)
$Vuln220585 = “V-220585”, “Not_Applicable”, “null“ ## Not Applicable (persistent logging not enabled)
$Vuln220586 = “V-220586”, “Not_Reviewed”, “null“
$Vuln220587 = “V-220587”, “Not_Reviewed”, “null“
$Vuln220588 = “V-220588”, “Not_Reviewed”, “null“
$Vuln220589 = “V-220589”, “NotAFinding”, “Handled in Cisco ISE" ## Handled in ISE
$Vuln220590 = “V-220590”, “NotAFinding”, “Handled in Cisco ISE“ ## Handled in ISE
$Vuln220591 = “V-220591”, “NotAFinding”, “Handled in Cisco ISE“ ## Handled in ISE
$Vuln220592 = “V-220592”, “NotAFinding”, “Handled in Cisco ISE“ ## Handled in ISE
$Vuln220593 = “V-220593”, “NotAFinding”, “Handled in Cisco ISE“ ## Handled in ISE
$Vuln220594 = “V-220594”, “Open”, “Unable to configure in ISE“ 
$Vuln220595 = “V-220595”, “Not_Reviewed”, “null“ 
$Vuln220596 = “V-220596”, “Not_Reviewed”, “null“ 
$Vuln220597 = “V-220597”, “Not_Reviewed”, “null“
$Vuln220598 = “V-220598”, “Not_Reviewed”, “null“
$Vuln220599 = “V-220599”, “Not_Reviewed”, “null“
$Vuln220600 = “V-220600”, “Not_Reviewed”, “null“
$Vuln220601 = “V-220601”, “Not_Reviewed”, “null“
$Vuln220602 = “V-220602”, “Not_Reviewed”, “null“
$Vuln220603 = “V-220603”, “Not_Reviewed”, “null“
$Vuln220604 = “V-220604”, “Not_Reviewed”, “null“
$Vuln220605 = “V-220605”, “Not_Reviewed”, “null“
$Vuln220606 = “V-220606”, “Not_Reviewed”, “null“
$Vuln220607 = “V-220607”, “Not_Reviewed”, “null“
$Vuln220608 = “V-220608”, “Not_Reviewed”, “null“
$Vuln220609 = “V-220609”, “Not_Reviewed”, “null“
$Vuln220610 = “V-220610”, “Not_Reviewed”, “null“
$Vuln220611 = “V-220611”, “Not_Reviewed”, “null“
$Vuln220612 = “V-220612”, “Not_Reviewed”, “null“
$Vuln220613 = “V-220613”, “Not_Reviewed”, “null“
$Vuln220615 = “V-220615”, “Not_Reviewed”, “null“
$Vuln220616 = “V-220616”, “Not_Reviewed”, “null“
$Vuln220617 = “V-220617”, “Not_Reviewed”, “null“
$Vuln220618 = “V-220618”, “NotAFinding”, “Switch Configs are backed up to Solarwinds“ ## Probably handled in ISE. Has to do with backing up configs. Either ISE or Orion does this
$Vuln220619 = “V-220619”, “Not_Reviewed”, “null“
$Vuln220620 = “V-220620”, “Not_Reviewed”, “null“
$Vuln220621 = “V-220621”, “NotAFinding”, “null" ## Supported version of Cisco IOS, managed by Networking Team




[XML]$BlankConfig = Get-content $BlankFilePath ## Save blank checklist to xml object

$SwitchConfig = Get-content $SingleSwitch ## Gets the content of the switch congiguration

$Hostname = $SingleSwitch.BaseName ## Gets the basename of the switch config file, so we have a proper way to name the output file

## Formatting the final directory + filepath for output
if ($OutputDirPath[-1] -eq "\"){
$OutputDestination = $OutputDirPath + $Hostname + ".ckl"
$ShortDestination = $OutputDirPath + $TodayDate + "-NDM-Switch_Compliance-Quick-Results" + ".txt"
}
else {
$OutputDestination = $OutputDirPath + "\" + $Hostname + ".ckl"
$ShortDestination = $OutputDirPath + "\" + $TodayDate + "-NDM-Switch_Compliance-Quick-Results" + ".txt"
}

## REMINDERS -------------------------------------------
# Switchconfig = Content of switch config              |
# OutputDestination = FULL filepath for output file    |
# BlankConfig = Blank checklist full filepath [XML]    |

## -----------------------------------------------------

write-output "Quick Glance at Hostname $Hostname on $Date" >> $ShortDestination ## Write this to a quick-results file, which is a quick overview/glance of how each switch stands per configuration.


## BEGIN STIG CHECK                     ---------------------                      ################################################################
$EachVty = $Switchconfig | Select-String "line vty" -Context 0,7

$ConPort = $Switchconfig | Select-String "line con 0" -Context 0,8

$BothNTP = $Switchconfig | Select-string -Pattern "NTP server"

$Accesslists = $Switchconfig | Select-string "ip access-list" -Context 0,12



## V-220570
if ($Eachvty -like "*session-limit*"){

$Vuln220570[1] = "NotAFinding"
$Vuln220570[2] = "Max-Connections was found in Switch Configuration as well as Session limit was found in both vty occurences"

}

else {

$Vuln220570[1] = "Open"
$Vuln220570[2] = "Missing session-limit parameter in line vty"

write-output "Missing session-limit parameter in line vty for V-220570" >> $ShortDestination

}




## V-220571-220574
if ($Switchconfig -like "*logging enable*"){

$Vuln220571[1] = "NotAFinding"
$Vuln220572[1] = "NotAFinding"
$Vuln220573[1] = "NotAFinding"
$Vuln220574[1] = "NotAFinding"
$Vuln220582[1] = "NotAFinding"
$Vuln220597[1] = "NotAFinding"
$Vuln220611[1] = "NotAFinding"
$Vuln220613[1] = "NotAFinding"



$Vuln220571[2] = "logging enable configured"
$Vuln220572[2] = "logging enable configured"
$Vuln220573[2] = "logging enable configured"
$Vuln220574[2] = "logging enable configured"
$Vuln220582[2] = "logging enable configured"
$Vuln220597[2] = "logging enable configured"
$Vuln220611[2] = "logging enable configured"
$Vuln220613[2] = "logging enable configured"


}
else {

$Vuln220571[1] = "Open"
$Vuln220572[1] = "Open"
$Vuln220573[1] = "Open"
$Vuln220574[1] = "Open"
$Vuln220582[1] = "Open"
$Vuln220597[1] = "Open"
$Vuln220611[1] = "Open"
$Vuln220613[1] = "Open"

$Vuln220571[2] = "logging enable not configured"
$Vuln220572[2] = "logging enable not configured"
$Vuln220573[2] = "logging enable not configured"
$Vuln220574[2] = "logging enable not configured"
$Vuln220582[2] = "logging enable not configured"
$Vuln220597[2] = "logging enable not configured"
$Vuln220611[2] = "logging enable not configured"
$Vuln220613[2] = "logging enable not configured"

write-output "Missing logging enable in Switch configuration for V-220571-74, V-220585, V-220597, V-220611, V-220613" >> $ShortDestination


}




## V-220575
$PlaceholderFour = $True

foreach ($Singlevty in $Eachvty){

if ($Singlevty -like "*access-class*"){

$PlaceholderFour = $True

}
else {

$PlaceholderFour = $False
break


}


} ## end of foreach


if ($PlaceholderFour -eq $False){

$Vuln220575[1] = "Open"
$Vuln220575[2] = "Access-class must be configured on BOTH line VTYs"
write-output "Missing access-class assignment for each VTY in Switch configuration for V-220575" >> $ShortDestination

}
else {

$Vuln220575[1] = "NotAFinding"
$Vuln220575[2] = "ACL configured for each line vty"
}








## V-220577
if ($Switchconfig -like "*You are accessing a U.S. Government (USG) Information System (IS)*"){

$Vuln220577[1] = "NotAFinding"
$Vuln220577[2] = "Banner configured"

}
else {

$Vuln220577[1] = "Open"
write-output "Missing the standard DoD Banner in Switch Configuration for V-220577" >> $ShortDestination
$Vuln220577[2] = "Banner not configured"


}



## V-220578
if ($Switchconfig -like "*logging userinfo*"){

$Vuln220578[1] = "NotAFinding"
$Vuln220578[2] = "Logging userinfo found in switch config"

}
else {

$Vuln220578[1] = "Open"
$Vuln220578[2] = "Logging userinfo not found in switch configuration"

write-output "Missing Logging Userinfo from Switch Configuration for V-220578" >> $ShortDestination

}


## V-220579

if ($Switchconfig -like "*login on-failure log*" -and $Switchconfig -like "*login on-success log*"){

$Vuln220579[1] = "NotAFinding"
$Vuln220612[1] = "NotAFinding"


$Vuln220579[2] = "login on-failure log and login on-success log both configured"
$Vuln220612[2] = "login on-failure log and login on-success log both configured"


}
else {

$Vuln220579[1] = "Open"
$Vuln220579[2] = "Login on-failure log and login on-success log both need to be configured"

$Vuln220612[1] = "Open"
$Vuln220612[2] = "Login on-failure log and login on-success log both need to be configured"

write-output "Missing Login on-failure log and login on-success log for V-220579, V-220612" >> $ShortDestination


}


## V-220580
if ($Switchconfig -like "*service timestamps log datetime localtime*" -or $Switchconfig -like "*service timestamps debug datetime localtime*" -or $Switchconfig -like "*service timestamps log datetime*" -or $Switchconfig -like "*service timestamps log datetime msec localtime*"){

$Vuln220580[1] = "NotAFinding"
$Vuln220580[2] = "service timestamps log datetime localtime configured"

}
else {

$Vuln220580[1] = "Open"
$Vuln220580[2] = "Service timestamps datetime localtime missing from switch configuration."
write-output "Missing Service Timestamps Datetime Localtime from switch configuration for V-220580" >> $ShortDestination

}


## V-220581

$PlaceholderFive = $True

Foreach ($List in $Accesslists){


if ($List -like "*deny * log*"){

$PlaceholderFive = $True 

}
else {

$PlaceholderFive = $False
break

}

} ## end of foreach

if ($PlaceholderFive -eq $True){

$Vuln220581[1] = "NotAFinding"
$Vuln220581[2] = "Each access list is configured to produce audit records"

}
else {

$Vuln220581[1] = "Open"
$Vuln220581[2] = "Each access list is not configured to produce audit records."

write-output "Each access list is not configured to produce audit records for V-220581" >> $ShortDestination

}




<#  COMMENTED OUT
if ($Switchconfig -like "*deny * log*"){

$Vuln220581[1] = "NotAFinding"

}
else {

$Vuln220581[1] = "Open"
$Vuln220581[2] = "Missing log parameter after deny statement"
write-output "Missing log parameter after deny statement for V-220581" >> $ShortDestination

}

#>  #END COMMENT






## V-220582 - Logging enable, logic built above in 220571

## V-220583 - 5   all Not_Applicable


## V-220586

$Notessential = $False

foreach ($LineItem in $Nonessential){

if ($Lineitem -in $SwitchConfig){

$Vuln220586[1] = "Open"
$Vuln220586[2] = "$LineItem found in Switch configuration"
write-output "Nonessential items are included in switch configuration. Should be removed for V-220586" >> $ShortDestination
break


}
else {

$Notessential = "NotAFinding"
## 

}
if ($Notessential -match "NotAFinding"){

$Vuln220586[1] = "NotAFinding"
$Vuln220586[2] = "Non-essential items are missing from config"

}


} ## End of foreach-LineItem



## V-220587


if ($SwitchConfig -like "*username * privilege*"){


$Vuln220587[1] = "NotAFinding"



}
else {

$Vuln220587[1] = "Open"
$Vuln220587[2] = "Missing username configuration"
write-output "Missing local account configuration, indicated by the strings username and privilege for V-220587" >> $ShortDestination

}


## V-220588

if ($Switchconfig -like "*ip ssh version 2*" -and $Switchconfig -like "*ip ssh server algorithm encryption *256* *192* *128*"){

$Vuln220588[1] = "NotAFinding"
$Vuln220588[2] = "Found ip ssh version 2 and FIPS 140-2 compliant encryption algorithms in switch configuration"

}
else {

$Vuln220588[1] = "Open"
$Vuln220588[2] = "Unable to find ip ssh server algorithm encryption aes256-ctr aes192-ctr aes128-ctr or ip ssh version 2 in Switch Configuration."
write-output "Missing ip ssh version 2 or ip ssh server algirthm encryption standards are not FIPS 140-2 compliant for V-220588" >> $ShortDestination


}

## V-220589 - 94 are all handled in ISE




## V-220595

if ($SwitchConfig -like "*enable secret*"){

$Vuln220595[1] = "NotAFinding"
$Vuln220595[2] = "Enable Secret is in switch configuration"

}
else {

$Vuln220595[1] = "Open"
$Vuln220595[2] = "Missing Enable Secret in switch config"
write-output "Missing enable secret for V-220595" >> $ShortDestination


}



## V-220596
if ($Conport -like "*exec-timeout*"){
$Placeholder = $True

foreach ($Singlevty in $Eachvty){

if ($Singlevty -like "*exec-timeout*"){

$Placeholder = $True

}
else {

$Placeholder = $False
break


}


} ## end of foreach
}

if ($Placeholder -eq $False){

$Vuln220596[1] = "Open"
$Vuln220596[2] = "Missing exec-timeout on either line vtys or line con 0"
write-output "Missing exec-timeout on either line vtys or line con 0 for V-220596" >> $ShortDestination

}
else {

$Vuln220596[1] = "NotAFinding"
$Vuln220596[2] = "Exec-timeout is configured"
}



## V-220597 -- Another logging enable one. Handled at beginning of script

## V-220598

if ($SwitchConfig -like "*logging enable*" -and $SwitchConfig -like "*logging userinfo*"){

$Vuln220598[1] = "NotAFinding"

}
else {

$Vuln220598[1] = "Open"
$Vuln220598[2] = "Missing logging userinfo or logging enable in config"
write-output "Missing logging userinfo or logging enable in config for V-220598" >> $ShortDestination


}


## V-220599

if ($Switchconfig -like "*logging buffered*"){

$Vuln220599[1] = "NotAFinding"
$Vuln220599[2] = "Logging buffer size configured"

}
else {

$Vuln220599[1] = "Open"
$Vuln220599[2] = "Missing Logging Buffered"
write-output "Missing logging buffered from switch config for V-220599" >> $ShortDestination
}

## V-220600

if ($Switchconfig -like "*logging *trap* critical*"){

$Vuln220600[1] = "NotAFinding"
$Vuln220600[2] = "logging trap critical is configured"

}
else {

$Vuln220600[1] = "Open"
$Vuln220600[2] = "Missing logging trap critical"
write-output "Missing logging trap critical in switch config for V-220600" >> $ShortDestination

}


## V-220601
if ($BothNTP.Length -ge 2){

$Vuln220601[1] = "NotAFinding"
$Vuln220601[2] = "Redundant NTP servers configured"

}
else {

$Vuln220601[1] = "Open"
$Vuln220601[2] = "Missing redundant NTP sources"
write-output "Missing redundant NTP servers for V-220601" >> $ShortDestination

}


## V-220602

if ($SwitchConfig -like "*service timestamps * localtime*"){

$Vuln220602[1] = "NotAFinding"
$Vuln220602[2] = "service timestamps datetime localtime found in switch config"

}
else {

$Vuln220602[1] = "Open"
$Vuln220602[2] = "service timestamps datetime localtime not found in switch config"
write-output "Missing service timestamps datetime localtime from switch config for V-220602" >> $ShortDestination


}

## V-220603


if ($Switchconfig -like "*clock timezone GMT*" -or $Switchconfig -like "*clock timezone EST*" -or $SwitchConfig -like "*service timestamps log datetime * localtime*"){

$Vuln220603[1] = "NotAFinding"
$Vuln220603[2] = "Switch configured to record time stamps that can be mapped to UTC or GMT"

}
else {

$Vuln220603[1] = "Open"
$Vuln220603[2] = "Missing clock timezone GMT or clock timezone EST from config"
write-output "Missing clock timezone GMT or clock timezone EST from config for V-220603" >> $ShortDestination

}

## V-220604, V-220605

if ($Switchconfig -like "*snmp-server group * v3*" -and $SwitchConfig -like "*snmp-server view *V3*" -and $Switchconfig -like "*snmp-server host * 3*"){

$Vuln220604[1] = "NotAFinding"
$Vuln220605[1] = "NotAFinding"

$Vuln220604[2] = "Configured to authenticate SNMP messages using FIPS validated HMAC"
$Vuln220605[2] = "Configured to authenticate SNMP messages using FIPS validated HMAC"

}
else {
$Vuln220604[1] = "Open"
$Vuln220605[1] = "Open"

$Vuln220604[2] = "Missing snmp-server group, view, or host"
$Vuln220605[2] = "Missing snmp-server group, view, or host"

write-output "Missing snmp-server group, view, or host for V-220604 and V-220605" >> $ShortDestination


}

## V-220606

if ($Switchconfig -like "*ntp authentication*"){

$Vuln220606[1] = "NotAFinding"
$Vuln220606[2] = "NTP authentication configured"

}
else {

$Vuln220606[1] = "Open"
$Vuln220606[2] = "Missing ntp authentication"

write-output "Missing ntp authentication in switch config for V-220606" >> $ShortDestination

}


## V-220607

if ($Switchconfig -like "*ip ssh server algorithm mac *hmac* *256*"){

$Vuln220607[1] = "NotAFinding"
$Vuln220607[2] = "ip ssh server algorithm mac hmac FIPS 140-2 compliant"

}
else {
$Vuln220607[1] = "Open"
$Vuln220607[2] = "ip ssh server algorithm neeeds to be FIPS-validated HMAC"
write-output "Missing ip ssh server algorithm hmac from switch configuration, therefore not FIPS 140-2 compliant for V-220607" >> $ShortDestination

}


## V-220608

if ($Switchconfig -like "*ip ssh server algorithm encryption *256* *192* *128*"){


$Vuln220608[1] = "NotAFinding"

}
else {

$Vuln220608[1] = "Open"
$Vuln220608[2] = "Not seeing ip ssh server algorithm encryption aes256-ctr aes192-ctr aes128-ctr"
write-output "Missing ip ssh server algorithm encryption aes256-ctr aes192-ctr aes128-ctr for V-220608" >> $ShortDestination

}

## V-220609

if ($SwitchConfig -like "*class-map*" -and $SwitchConfig -like "*match access*"){

$Vuln220609[1] = "NotAFinding"

}
else {

$Vuln220609[1] = "Open"
$Vuln220609[2] = "Missing class-map and match access-group"
write-output "Missing class-map and match access-group from config for V-220609" >> $ShortDestination

}


## V-220610 - 

if ($Switchconfig -like "*logging enable*" -and $SwitchConfig -like "*logging userinfo*"){

$Vuln220610[1] = "NotAFinding"
$Vuln220610[2] = "Logging userinfo and Logging enable both configured"

}
else {

$Vuln220610[1] = "Open"
$Vuln220610[2] = "Logging userinfo and Logging enable are both not configured"

write-output "Logging userinfo and Logging enable are both not configured for V-220610" >> $ShortDestination

}


## V-220612 - handled above

## V-220613 - logging enable, handled above

## V-220615

if ($Switchconfig -like "*login on-success log*"){

$Vuln220615[1] = "NotAFinding"
$Vuln220615[2] = "Login on-success log configured"

}
else {

$Vuln220615[1] = "Open"
$Vuln220615[2] = "Missing login on-success log"
write-output "Missing login on-success log for V-220615" >> $ShortDestination

}


## V-220616

if ($SwitchConfig -like "*logging host*" -and ($SwitchConfig -like "*logging * notifications*" -or $SwitchConfig -like "*logging * informational*" -or $SwitchConfig -like "*logging * critical*")){

$Vuln220616[1] = "NotAFinding"
$Vuln220620[1] = "NotAFinding"

$Vuln220616[2] = "Logging trap configured"
$Vuln220620[2] = ""

}
else {

$Vuln220616[1] = "Open"
$Vuln220620[1] = "Open"
$Vuln220616[2] = "Missing Logging host or logging trap notifications"
$Vuln220620[2] = "Missing Logging host or logging trap notifications"

write-output "Missing Logging host or logging trap notifications for V-220616 and V-220620" >> $ShortDestination

}



## V-220617
if ($Conport -like "*login authentication*"){
$PlaceholderThree = $True

foreach ($Singlevty in $Eachvty){

if ($Singlevty -like "*login authentication*"){

$PlaceholderThree = $True

}
else {

$PlaceholderThree = $False
break


}


} ## end of foreach
}

if ($PlaceholderThree -eq $False){

$Vuln220617[1] = "Open"
$Vuln220617[2] = "Missing login authentication on either line vtys or line con 0"
write-output "Missing login authentication on either line vtys or line con 0 for V-220617" >> $ShortDestination

}
else {

$Vuln220617[1] = "NotAFinding"
$Vuln220617[2] = "Login authentication configured"
}


## V-220618 - Not sure yet


## V-220619
if ($Switchconfig -like "*crypto pki trustpoint*"){

$Vuln220619[1] = "NotAFinding"
$Vuln220619[2] = "Crypto PKI Trustpoint from Switch config"

}
else {

$Vuln220619[1] = "Open"
$Vuln220619[2] = "Missing Crypto PKI Trustpoint"
write-output "Missing Crypto PKI Trustpoint from Switch Config" >> $ShortDestination


}





write-output "`n" >> $ShortDestination ## Indent a new line on the output .txt file 


## END STIG CHECK  ##############################################################################################                        ---------------------                      ################################################################


$AllVulnArray = @(
$Vuln220570,
$Vuln220571,
$Vuln220572,
$Vuln220573,
$Vuln220574,
$Vuln220575,
$Vuln220576,
$Vuln220577,
$Vuln220578,
$Vuln220579,
$Vuln220580,
$Vuln220581,
$Vuln220582,
$Vuln220583,
$Vuln220584,
$Vuln220585,
$Vuln220586,
$Vuln220587,
$Vuln220588,
$Vuln220589,
$Vuln220590,
$Vuln220591,
$Vuln220592,
$Vuln220593,
$Vuln220594,
$Vuln220595,
$Vuln220596,
$Vuln220597,
$Vuln220598,
$Vuln220599,
$Vuln220600,
$Vuln220601,
$Vuln220602,
$Vuln220603,
$Vuln220604,
$Vuln220605,
$Vuln220606,
$Vuln220607,
$Vuln220608,
$Vuln220609,
$Vuln220610,
$Vuln220611,
$Vuln220612,
$Vuln220613,
$Vuln220615,
$Vuln220616,
$Vuln220617,
$Vuln220618,
$Vuln220619,
$Vuln220620,
$Vuln220621


)


## This is the section where we will write our findings to each different Vuln ID in the XML file 

### XML Extraction ###

## Pulls all Vulnerability Numbers
$PreVulns = $BlankConfig.selectNodes("//STIG_DATA[VULN_ATTRIBUTE='Vuln_Num']")
$AfterVulns = $Prevulns.Attribute_data ## All of the vulnerability IDs

## Pulls all of the Statuses
$Allstatus = $BlankConfig.GetElementsByTagName('STATUS')

## Pulls all of the comments
$Allcomments = $BlankConfig.GetElementsByTagName('FINDING_DETAILS')





## IF YOU'RE GETTING A CHECKLIST VALIDATION ERROR, CHANCES ARE YOU ARE SAVING THE VARIABLE IMPROPERLY
### I WAS GETTING AN ERROR BECAUSE I HAD A BUNCH OF EMPTY OBJECTS BEING WRITTEN TO THE CHECKLIST

for ($x = 0; $x -lt $AfterVulns.Count; $x++){

if ($AllVulnArray[$x][0] -contains $Aftervulns[$x]){


# write-host $AllVulnArray[$x][0] "matches with " $Aftervulns[$x] Un-Comment if you want to visually see the V- ID's being matched up

$AllStatus[$x].InnerXml = $AllVulnArray[$x][1] # $AllVulnArray[$x][1]  ## Sets the STATUS of the vulnerability to that which is in the above array.
$Allcomments[$x].innerText = $AllVulnArray[$x][2]


} ## end of if-statement



} ## end of for x loop



## If user indicates they want checklists created
if ($CreateCKL -eq "yes" -or $CreateCKL -eq "y"){

## Creates the XML doc
$XMLWriter = [System.XML.XmlWriter]::Create($OutputDestination, $XMLSettings)  ## creates file at $Destination location with $XMLSettings -- (blank)
$BlankConfig.Save($XMLWriter) ## Saves the extract document changes above to the xml writer object (which follows the validation scheme for STIG viewer)
$XMLWriter.Flush()
$XMLWriter.Dispose()

}


$BlankConfig = $null

} ## end of for-loop

if (Test-Path $ShortDestination){

write-host -ForegroundColor Green "Successfully created output file: $ShortDestination"

}
else {

## Continue

}