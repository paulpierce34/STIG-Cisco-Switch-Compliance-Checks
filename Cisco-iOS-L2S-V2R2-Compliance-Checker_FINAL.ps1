## CISCO IOS L2S STIG V2R2 Released 23 Jul 2021



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
"service udp-small-servers",
"service pad"

)








## END GLOBAL VARIABLES SECTION #####




Foreach ($SingleSwitch in $AllSwitchConfigs){


write-host -Foregroundcolor Cyan "Working on $SingleSwitch"

## The below in this format:  Vuln_ID, Status, Comments
$Vuln220622 = “V-220622”, “Not_Reviewed”, “null“
$Vuln220623 = “V-220623”, “Not_Reviewed”, “null“
$Vuln220624 = “V-220624”, “Not_Applicable”, “NotApplicable“
$Vuln220625 = “V-220625”, “Not_Reviewed”, “null“
$Vuln220626 = “V-220626”, “NotAFinding”, “Switch is SPAN capable“
$Vuln220627 = “V-220627”, “NotAFinding”, “Switch is SPAN capable“
$Vuln220628 = “V-220628”, “Not_Reviewed”, “null“
$Vuln220629 = “V-220629”, “Not_Reviewed”, “null“
$Vuln220630 = “V-220630”, “Not_Reviewed”, “null“
$Vuln220631 = “V-220631”, “Not_Reviewed”, “null“
$Vuln220632 = “V-220632”, “Not_Reviewed”, “null“
$Vuln220633 = “V-220633”, “Not_Reviewed”, “null“
$Vuln220634 = “V-220634”, “Not_Reviewed”, “null“
$Vuln220635 = “V-220635”, “Not_Reviewed”, “null“
$Vuln220636 = “V-220636”, “Not_Reviewed”, “null“
$Vuln220637 = “V-220637”, “Not_Reviewed”, “null“
$Vuln220638 = “V-220638”, “Not_Reviewed”, “null“
$Vuln220639 = “V-220639”, “Not_Reviewed”, “null“
$Vuln220640 = “V-220640”, “Not_Reviewed”, “null“
$Vuln220641 = “V-220641”, “Not_Reviewed”, “null“
$Vuln220642 = “V-220642”, “Not_Reviewed”, “null“
$Vuln220643 = “V-220643”, “Not_Reviewed”, “null“
$Vuln220644 = “V-220644”, “Not_Reviewed”, “null“
$Vuln220645 = “V-220645”, “Not_Reviewed”, “null“
$Vuln220646 = “V-220646”, “Not_Reviewed”, “null“
$Vuln220647 = “V-220647”, “Not_Reviewed”, “null“


[XML]$BlankConfig = Get-content $BlankFilePath ## Save blank checklist to xml object

$SwitchConfig = Get-content $SingleSwitch ## Gets the content of the switch congiguration

$Hostname = $SingleSwitch.BaseName ## Gets the basename of the switch config file, so we have a proper way to name the output file



## Formatting the final directory + filepath for output
if ($OutputDirPath[-1] -eq "\"){
$OutputDestination = $OutputDirPath + $Hostname + ".ckl"
$ShortDestination = $OutputDirPath + $TodayDate + "-L2S-Switch_Compliance-Quick-Results" + ".txt"
}
else {
$OutputDestination = $OutputDirPath + "\" + $Hostname + ".ckl"
$ShortDestination = $OutputDirPath + "\" + $TodayDate + "-L2S-Switch_Compliance-Quick-Results" + ".txt"
}

## REMINDERS -------------------------------------------
# Switchconfig = Content of switch config              |
# OutputDestination = FULL filepath for output file    |
# BlankConfig = Blank checklist full filepath [XML]    |

## -----------------------------------------------------



write-output "Quick Glance at Hostname $Hostname on $Date" >> $ShortDestination ## Write this to a quick-results file, which is a quick overview/glance of how each switch stands per configuration.



## BEGIN STIG CHECK 



$Eachinterface = $SwitchConfig | Select-String "GigabitEthernet" -Context 0,25 ## Saves each interface to this variable. Going to iterate through each one and check for specific configs.









##V-220622 - The Cisco switch must be configured to disable non-essential capabilities.


foreach ($LineItem in $Nonessential){

if ($Lineitem -in $Switchconfig){

$Vuln220622[1] = "Open"
$Vuln220622[2] = "$LineItem found in Switch configuration"
write-output "Nonessential items are included in switch configuration: $LineItem Should be removed for V-220622" >> $ShortDestination
break

}
else {

$Notessential = "NotAFinding"
## 

}
if ($Notessential -match "NotAFinding"){

$Vuln220622[1] = "NotAFinding"
$Vuln220622[2] = "Non-essential items are missing from config"

}



} ## End of foreach-LineItem




##V-220623

foreach ($Interface in $Eachinterface){


if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*"){

if ($Interface -like "*dot1x pae authenticator*" -and $Interface -like "*switchport mode access*"){

$Vuln220623[1] = "NotAFinding"
$Vuln220623[2] = "dot1x pae authenticator is configured properly for each switchport."


} ## end if

else {
$Vuln220623[1] = "Open"
$Vuln220623[2] = "Missing dot1x pae authenticator in switchport that should have this configured."
write-output "Missing dot1x pae authenticator for V-220623 here: `n 
$Interface `n" >> $ShortDestination
break

} ## end else


} ## end of if interface isnt a trunk port and not disabled



} ## end of foreach interface











## V-220645 --- Will need to be run manually on switch.

## V-220625 - The Cisco switch must manage excess bandwidth to limit the effects of packet-flooding types of denial-of-service (DoS) attacks.

if ($Switchconfig -like "*mls qos*"){


$Vuln220625[1] = "NotAFinding"
$Vuln220625[2] = "mls qos configured"

}
else {

$Vuln220625[1] = "Open"
$Vuln220625[2] = "Missing mls qos from config"
write-output "Missing mls qos from config for V-220625" >> $ShortDestination

}


## V-220628 - The Cisco switch must authenticate all endpoint devices before establishing any connection

if ($Switchconfig -like "*aaa group server radius*" -and $Switchconfig -like "*aaa * dot1x*"){

if ($Vuln220623[1] -match "NotAFinding"){

$Vuln220628[1] = "NotAFinding"
$Vuln220628[2] = "dot1x configured on each switchport and radius server setup properly."

}
else {

$Vuln220628[1] = "Open"
$Vuln220628[2] = "dot1x not configured on each access switchport, or missing aaa group server radios and aaa dot1x authentication on global config"

write-output "Missing dot1x pae authenticator on an interface OR missing aaa group server radius globally configured for V-220628" >> $ShortDestination


}


}
else {

$Vuln220628[1] = "Open"
$Vuln220628[2] = "dot1x not configured on each access switchport, or missing aaa group server radios and aaa dot1x authentication on global config"

write-output "Missing dot1x pae authenticator on an interface OR missing aaa group server radius globally configured" >> $ShortDestination

}



## V-220629 - The Cisco switch must have Root Guard enabled on all switch ports connecting to access layer switches.

foreach ($Interface in $Eachinterface){


if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*spanning-tree guard root*" -and $Interface -like "*switchport mode access*"){

$Vuln220629[1] = "NotAFinding"
$Vuln220629[2] = "Root guard is enabled on all switch ports connecting to access layer switches"

} ## end if

else {
$Vuln220629[1] = "Open"
$Vuln220629[2] = "Root guard is NOT enabled on all switch ports connecting to access layer switches"
write-output "Missing spanning-tree guard root for V-220629 here: `n
 $Interface `n" >> $ShortDestination
break

} ## end else


} ## end of if interface isnt a trunk port and not disabled






} ## end of foreach interface



## V-220630 - The Cisco switch must have Bridge Protocol Data Unit (BPDU) Guard enabled on all user-facing or untrusted access switch ports.

foreach ($Interface in $Eachinterface){


if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*bpduguard enable*"){

$Vuln220630[1] = "NotAFinding"
$Vuln220630[2] = "Each access switchport has bpdugard enabled."


} ## end if

else {
$Vuln220630[1] = "Open"
$Vuln220630[2] = "Missing spanning-tree bdpugard enable in access mode switchports."
write-output "Missing spanning-tree bdpugard enable for V-220630 here: `n
 $Interface `n" >> $ShortDestination
break

} ## end else


} ## end of if interface isnt a trunk port and not disabled



} ## end of foreach interface



## V-220631

if ($Switchconfig -like "*spanning-tree loopguard default*"){

$Vuln220631[1] = "NotAFinding"
$Vuln220631[2] = "spanning-tree loopguard default is globally configured"

}

else {

$Vuln220631[1] = "Open"
$Vuln220631[2] = "Missing spanning-tree loopguard default from config"

write-output "Missing spanning-tree loopguard default from config for V-220631" >> $ShortDestination

}




## V-220632 - The Cisco switch must have Unknown Unicast Flood Blocking (UUFB) enabled.


foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*switchport block unicast*"){

$Vuln220632[1] = "NotAFinding"
$Vuln220632[2] = "Each access switchport has switchport block unicast enabled."

} ## end if

else {
$Vuln220632[1] = "Open"
$Vuln220632[2] = "Missing switchport block unicast in access mode switchports."
write-output "Missing switchport block unicast for V-220632 here: `n
 $Interface `n" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface




## V-220633
if ($Switchconfig -like "*ip dhcp snooping vlan 89*" -or $Switchconfig -like "*ip dhcp snooping vlan 1220*"){

$Vuln220633[1] = "NotAFinding"
$Vuln220633[2] = "DHCP snooping configured for user VLANs"

}
else {

$Vuln220633[1] = "Open"
$Vuln220633[2] = "Missing global config for ip dhcp snooping for user vlan"
write-output "Missing global config for ip dhcp snooping for user VLANs for V-220633" >> $ShortDestination

}


## V-220634

foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*ip verify source*"){

$Vuln220634[1] = "NotAFinding"
$Vuln220634[2] = "Each access switchport has ip verify source enabled."

} ## end if

else {
$Vuln220634[1] = "Open"
$Vuln220634[2] = "Missing ip verify source in access mode switchports."
write-output "Missing ip verify source for V-220634 here: `n
 $Interface `n" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface


## V-220635
if ($Switchconfig -like "*ip arp inspection vlan 89*" -or $Switchconfig -like "*ip arp inspection vlan 1220*" -or $Switchconfig -like "*ip arp inspection vlan 1152*"){

$Vuln220635[1] = "NotAFinding"
$Vuln220635[2] = "ip arp inspection configured for user vlans."


}
else {

$Vuln220635[1] = "Open"
$Vuln220635[2] = "ip arp inspection not configured for user vlans."
write-output "Missing ip arp inspection global config for user VLANs for V-220635" >> $ShortDestination

}




##V-220636

foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*storm-control unicast*" -and $Interface -like "*storm-control broadcast*"){

$Vuln220636[1] = "NotAFinding"
$Vuln220636[2] = "Storm-control configured for all access switchports"

} ## end if

else {
$Vuln220636[1] = "Open"
$Vuln220636[2] = "Missing Storm-control configuration on certain access switchports."
write-output "Missing Storm-control broadcast or unicast for V-220636 here: `n
 $Interface `n" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface


##V-220637

if ($Switchconfig -like "*no ip igmp snooping*"){

$Vuln220637[1] = "Open"
$Vuln220637[2] = "Missing ip igmp snooping configured on all VLANs"
write-output "Missing ip igmp snooping on all VLANs for V-220637" >> $ShortDestination

}
else {

$Vuln220637[1] = "NotAFinding"
$Vuln220637[2] = "ip igmp snooping configured on all VLANs"

}


## V-220638


if ($Switchconfig -like "*spanning-tree mode rapid-pvst*"){


$Vuln220638[1] = "NotAFinding"
$Vuln220638[2] = "Spanning-tree mode rapid-pvst configured on switch"

}
else {

$Vuln220638[1] = "Open"
$Vuln220638[2] = "Missing global configuration for spanning-tree mode rapid-pvst"
write-output "Missing spanning-tree mode rapid-pvst global config for V-220638" >> $ShortDestination

}


## V-220639
if ($Switchconfig -like "*udld enable*"){


$Vuln220639[1] = "NotAFinding"
$Vuln220639[2] = "udld enable is configured globally"

}
else {

$Vuln220639[1] = "Open"
$Vuln220639[2] = "udld enable is not configured on the switch"
write-output "Missing udld enable in global config for V-220639" >> $ShortDestination
}

## V-220640 - The Cisco switch must have all trunk links enabled statically.    TRUNK LOOP BBY


Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -like "*switchport nonegotiate*"){

$Vuln220640[1] = "NotAFinding"
$Vuln220640[2] = "Trunk ports are configured statically"

}
else {
$Vuln220640[1] = "Open"
$Vuln220640[2] = "All trunk ports are not configured statically"
write-output "Missing nonegotiate option on Trunk port for V-220640 here: `n
$Interface `n" >> $ShortDestination
break

}

}

} ## end of foreach interface




##V-220641

foreach ($Interface in $Eachinterface){

if (($Interface -like "*DISABLED*" -or $Interface -like " shutdown*")  -and $Interface -notlike "*vlan 999*"){

$Vuln220641[1] = "Open"
$Vuln220641[2] = "There is a shutdown interface not assigned to quarantine VLAN"
write-output "Missing quarantine VLAN for V-220641 here: `n
$Interface `n" >> $ShortDestination
break


} ## end of if interface isnt a trunk port and not disabled
else {

$Vuln220641[1] = "NotAFinding"
$Vuln220641[2] = "All disabled switchports are assigned to quarantine VLAN."

}


} ## end of foreach interface




## V-220642

foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -notlike "*switchport access vlan*"){

$Vuln220642[1] = "Open"
$Vuln220642[2] = "Access switchport in use is assigned the default vlan"
write-output "Switchport should not be assigned to default vlan for V-220642 here: `n
 $Interface `n" >> $ShortDestination
break
} ## end if

else {
$Vuln220642[1] = "NotAFinding"
$Vuln220642[2] = "Each access port is not assigned to default vlan."



} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface





## V-220643 - Rule Title: The Cisco switch must have the default VLAN pruned from all trunk ports that do not require it.


Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -like "*switchport trunk allowed vlan*" -and $Interface -notlike "*switchport trunk allowed vlan 1,*"){

$Vuln220643[1] = "NotAFinding"
$Vuln220643[2] = "Trunk ports are configured to prune default vlan properly"

}
else {
$Vuln220643[1] = "Open"
$Vuln220643[2] = "All trunk ports are not configured to prune default VLAN."
write-output "Default vlan not pruned from trunk for V-220643 here: `n
$Interface `n" >> $ShortDestination
break

}

}

} ## end of foreach interface




## V-220644 - Rule Title: The Cisco switch must not use the default VLAN for management traffic.

$DefaultVLAN = $SwitchConfig | Select-string "interface Vlan1" -Context 0,8



if ($DefaultVLAN -like "*mgmt*" -or $DefaultVLAN -like "*management*"){

$Vuln220644[1] = "Open"
$Vuln220644[2] = "Default VLAN not shut down. Could be used for management traffic."
write-output "Missing shutdown command for default VLAN for V-220644" >> $ShortDestination

}
else {

$Vuln220644[1] = "NotAFinding"
$Vuln220644[2] = "Default VLAN is not being used for management"
}



## V-220645 - The Cisco switch must have all user-facing or untrusted ports configured as access switch ports.


foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*switchport mode access*"){

$Vuln220645[1] = "NotAFinding"
$Vuln220645[2] = "Each access switchport is properly configured as such"

} ## end if

else {
$Vuln220645[1] = "Open"
$Vuln220645[2] = "Missing switchport mode access in access switchports"
write-output "Missing switchport mode access for V-220645 here: `n
 $Interface `n" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface







##V-220646 - The Cisco switch must have the native VLAN assigned to an ID other than the default VLAN for all 802.1q trunk links.


Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -notlike "*switchport trunk native vlan 1*" -and $Interface -like "*switchport trunk native vlan*"){

$Vuln220646[1] = "NotAFinding"
$Vuln220646[2] = "Trunk ports are configured to use a VLAN other than the default"

}
else {
$Vuln220646[1] = "Open"
$Vuln220646[2] = "Default VLAN used on Trunk port"
write-output "Default VLAN used on Trunk port for V-220646 here: `n
 $Interface `n" >> $ShortDestination
break

}

}

} ## end of foreach interface




## V-220647 - Rule Title: The Cisco switch must not have any switchports assigned to the native VLAN of the trunk native VLAN.

Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -notlike "*switchport access vlan 4000*"){

$Vuln220647[1] = "NotAFinding"
$Vuln220647[2] = "Access ports are not using trunk native vlan."

}
else {
$Vuln220647[1] = "Open"
$Vuln220647[2] = "Native Trunk VLAN used on Access switchport. This could lead to double encapsulation issues."
write-output "Default Trunk VLAN used on Access switchport for V-220647 here: `n
 $Interface `n" >> $ShortDestination
break

}

}

} ## end of foreach interface



### END STIG PROCESS #####



$AllVulnArray = @(
$Vuln220622,
$Vuln220623,
$Vuln220624,
$Vuln220625,
$Vuln220626,
$Vuln220627,
$Vuln220628,
$Vuln220629,
$Vuln220630,
$Vuln220631,
$Vuln220632,
$Vuln220633,
$Vuln220634,
$Vuln220635,
$Vuln220636,
$Vuln220637,
$Vuln220638,
$Vuln220639,
$Vuln220640,
$Vuln220641,
$Vuln220642,
$Vuln220643,
$Vuln220644,
$Vuln220645,
$Vuln220646,
$Vuln220647
) ## end of vulnerability item array















#### XML Extraction #####


## Pulls all Vulnerability Numbers
$PreVulns = $BlankConfig.selectNodes("//STIG_DATA[VULN_ATTRIBUTE='Vuln_Num']")
$AfterVulns = $Prevulns.Attribute_data ## All of the vulnerability IDs

## Pulls all of the Statuses
$Allstatus = $BlankConfig.GetElementsByTagName('STATUS')

## Pulls all of the comments
$Allcomments = $BlankConfig.GetElementsByTagName('FINDING_DETAILS')



for ($x = 0; $x -lt $AfterVulns.Count; $x++){

if ($AllVulnArray[$x][0] -contains $Aftervulns[$x]){


# write-host $AllVulnArray[$x][0] "matches with " $Aftervulns[$x] Un-Comment if you want to visually see the V- ID's being matched up

$AllStatus[$x].InnerXml = $AllVulnArray[$x][1] # $AllVulnArray[$x][1]  ## Sets the STATUS of the vulnerability to that which is in the above array.
$Allcomments[$x].innerText = $AllVulnArray[$x][2]


} ## end of if-statement



} ## end of for x loop

if ($CreateCKL -eq "yes" -or $CreateCKL -eq "y"){

## Creates the XML doc
$XMLWriter = [System.XML.XmlWriter]::Create($OutputDestination, $XMLSettings)  ## creates file at $Destination location with $XMLSettings -- (blank)
$BlankConfig.Save($XMLWriter) ## Saves the extract document changes above to the xml writer object (which follows the validation scheme for STIG viewer)
$XMLWriter.Flush()
$XMLWriter.Dispose()

}



$BlankConfig = $null


### END XML Extraction ###


} ## end of foreach


if (Test-Path $ShortDestination){

write-host -ForegroundColor Green "Successfully created output file: $ShortDestination"

}
else {

## Continue

}