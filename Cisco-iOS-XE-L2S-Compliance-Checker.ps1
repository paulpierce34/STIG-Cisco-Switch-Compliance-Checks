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
$Vuln220648 = “V-220648”, “Not_Reviewed”, “null“
$Vuln220649 = “V-220649”, “Not_Reviewed”, “null“
$Vuln220650 = “V-220650”, “Not_Applicable”, “NotApplicable“
$Vuln220651 = “V-220651”, “Not_Reviewed”, “null“
$Vuln220652 = “V-220652”, “NotAFinding”, “Switch is SPAN capable“
$Vuln220653 = “V-220653”, “NotAFinding”, “Switch is SPAN capable“
$Vuln220654 = “V-220654”, “Not_Reviewed”, “null“
$Vuln220655 = “V-220655”, “Not_Reviewed”, “null“
$Vuln220656 = “V-220656”, “Not_Reviewed”, “null“
$Vuln220657 = “V-220657”, “Not_Reviewed”, “null“
$Vuln220658 = “V-220658”, “Not_Reviewed”, “null“
$Vuln220659 = “V-220659”, “Not_Reviewed”, “null“
$Vuln220660 = “V-220660”, “Not_Reviewed”, “null“
$Vuln220661 = “V-220661”, “Not_Reviewed”, “null“
$Vuln220662 = “V-220662”, “Not_Reviewed”, “null“
$Vuln220663 = “V-220663”, “Not_Reviewed”, “null“
$Vuln220664 = “V-220664”, “Not_Reviewed”, “null“
$Vuln220665 = “V-220665”, “Not_Reviewed”, “null“
$Vuln220666 = “V-220666”, “Not_Reviewed”, “null“
$Vuln220667 = “V-220667”, “Not_Reviewed”, “null“
$Vuln220668 = “V-220668”, “Not_Reviewed”, “null“
$Vuln220669 = “V-220669”, “Not_Reviewed”, “null“
$Vuln220670 = “V-220670”, “Not_Reviewed”, “null“
$Vuln220671 = “V-220671”, “Not_Reviewed”, “null“
$Vuln220672 = “V-220672”, “Not_Reviewed”, “null“
$Vuln220673 = “V-220673”, “Not_Reviewed”, “null“


[XML]$BlankConfig = Get-content $BlankFilePath ## Save blank checklist to xml object

$SwitchConfig = Get-content $SingleSwitch ## Gets the content of the switch congiguration

$Hostname = $SingleSwitch.BaseName ## Gets the basename of the switch config file, so we have a proper way to name the output file



## Formatting the final directory + filepath for output
if ($OutputDirPath[-1] -eq "\"){
$OutputDestination = $OutputDirPath + $Hostname + ".ckl"
$ShortDestination = $OutputDirPath + $TodayDate + "-iOS-XE-L2S-Switch_Compliance-Quick-Results" + ".txt"
}
else {
$OutputDestination = $OutputDirPath + "\" + $Hostname + ".ckl"
$ShortDestination = $OutputDirPath + "\" + $TodayDate + "-iOS-XE-L2S-Switch_Compliance-Quick-Results" + ".txt"
}

## REMINDERS -------------------------------------------
# Switchconfig = Content of switch config              |
# OutputDestination = FULL filepath for output file    |
# BlankConfig = Blank checklist full filepath [XML]    |

## -----------------------------------------------------



write-output "Quick Glance at Hostname $Hostname on $Date" >> $ShortDestination ## Write this to a quick-results file, which is a quick overview/glance of how each switch stands per configuration.



## BEGIN STIG CHECK 



$Eachinterface = $SwitchConfig | Select-String "GigabitEthernet" -Context 0,25 ## Saves each interface to this variable. Going to iterate through each one and check for specific configs.









##V-220648 - The Cisco switch must be configured to disable non-essential capabilities.


foreach ($LineItem in $Nonessential){

if ($Lineitem -in $Switchconfig){

$Vuln220648[1] = "Open"
$Vuln220648[2] = "$LineItem found in Switch configuration"
write-output "Nonessential items are included in switch configuration: $LineItem Should be removed for V-220648" >> $ShortDestination
break

}
else {

$Notessential = "NotAFinding"
## 

}
if ($Notessential -match "NotAFinding"){

$Vuln220648[1] = "NotAFinding"
$Vuln220648[2] = "Non-essential items are missing from config"

}



} ## End of foreach-LineItem




##V-220649

foreach ($Interface in $Eachinterface){


if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*dot1x pae authenticator*" -and $Interface -like "*switchport mode access*"){

$Vuln220649[1] = "NotAFinding"
$Vuln220649[2] = "dot1x pae authenticator is configured properly for each switchport."


} ## end if

else {
$Vuln220649[1] = "Open"
$Vuln220649[2] = "Missing dot1x pae authenticator in switchport that should have this configured."
write-output "Missing dot1x pae authenticator for V-220649 here $Interface" >> $ShortDestination
break

} ## end else


} ## end of if interface isnt a trunk port and not disabled



} ## end of foreach interface










## V-220651 - The Cisco switch must manage excess bandwidth to limit the effects of packet flooding types of denial of service (DoS) attacks.


if ($SwitchConfig -like "*class-map*"){

$Vuln220651[1] = "NotAFinding"
$Vuln220651[2] = "Class-map is configured properly on the switch"

}
else {

$Vuln220651[1] = "Open"
$Vuln220651[2] = "Class-map is not configured on the switch"

write-output "Missing class-map global config for V-220651" >> $ShortDestination



}









## V-220654 - The Cisco switch must authenticate all endpoint devices before establishing any connection

if ($Switchconfig -like "*aaa group server radius*" -and $Switchconfig -like "*aaa * dot1x*"){

if ($Vuln220649[1] -match "NotAFinding"){

$Vuln220654[1] = "NotAFinding"
$Vuln220654[2] = "dot1x configured on each switchport and radius server setup properly."

}
else {

$Vuln220654[1] = "Open"
$Vuln220654[2] = "dot1x not configured on each access switchport, or missing aaa group server radios and aaa dot1x authentication on global config"

write-output "Missing dot1x pae authenticator on an interface OR missing aaa group server radius globally configured for V-220654" >> $ShortDestination


}


}
else {

$Vuln220654[1] = "Open"
$Vuln220654[2] = "dot1x not configured on each access switchport, or missing aaa group server radios and aaa dot1x authentication on global config"

write-output "Missing dot1x pae authenticator on an interface OR missing aaa group server radius globally configured" >> $ShortDestination

}



## V-220655 - The Cisco switch must have Root Guard enabled on all switch ports connecting to access layer switches.

foreach ($Interface in $Eachinterface){


if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*spanning-tree guard root*" -and $Interface -like "*switchport mode access*"){

$Vuln220655[1] = "NotAFinding"
$Vuln220655[2] = "Root guard is enabled on all switch ports connecting to access layer switches"

} ## end if

else {
$Vuln220655[1] = "Open"
$Vuln220655[2] = "Root guard is NOT enabled on all switch ports connecting to access layer switches"
write-output "Missing spanning-tree guard root for V-220655 here $Interface" >> $ShortDestination
break

} ## end else


} ## end of if interface isnt a trunk port and not disabled






} ## end of foreach interface



## V-220656 - The Cisco switch must have Bridge Protocol Data Unit (BPDU) Guard enabled on all user-facing or untrusted access switch ports.

foreach ($Interface in $Eachinterface){


if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*bpduguard enable*"){

$Vuln220656[1] = "NotAFinding"
$Vuln220656[2] = "Each access switchport has bpdugard enabled."


} ## end if

else {
$Vuln220656[1] = "Open"
$Vuln220656[2] = "Missing spanning-tree bdpugard enable in access mode switchports."
write-output "Missing spanning-tree bdpugard enable for V-220656 here $Interface" >> $ShortDestination
break

} ## end else


} ## end of if interface isnt a trunk port and not disabled



} ## end of foreach interface



## V-220657

if ($Switchconfig -like "*spanning-tree loopguard default*"){

$Vuln220657[1] = "NotAFinding"
$Vuln220657[2] = "spanning-tree loopguard default is globally configured"

}

else {

$Vuln220657[1] = "Open"
$Vuln220657[2] = "Missing spanning-tree loopguard default from config"

write-output "Missing spanning-tree loopguard default from config for V-220657" >> $ShortDestination

}




## V-220658 - The Cisco switch must have Unknown Unicast Flood Blocking (UUFB) enabled.


foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*switchport block unicast*"){

$Vuln220658[1] = "NotAFinding"
$Vuln220658[2] = "Each access switchport has switchport block unicast enabled."

} ## end if

else {
$Vuln220658[1] = "Open"
$Vuln220658[2] = "Missing switchport block unicast in access mode switchports."
write-output "Missing switchport block unicast for V-220658 here $Interface" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface




## V-220659
if ($Switchconfig -like "*ip dhcp snooping vlan 89*" -or $Switchconfig -like "*ip dhcp snooping vlan 1220*"){

$Vuln220659[1] = "NotAFinding"
$Vuln220659[2] = "DHCP snooping configured for user VLANs"

}
else {

$Vuln220659[1] = "Open"
$Vuln220659[2] = "Missing global config for ip dhcp snooping for user vlan"
write-output "Missing global config for ip dhcp snooping for user VLANs for V-220659" >> $ShortDestination

}


## V-220660

foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*ip verify source*"){

$Vuln220660[1] = "NotAFinding"
$Vuln220660[2] = "Each access switchport has ip verify source enabled."

} ## end if

else {
$Vuln220660[1] = "Open"
$Vuln220660[2] = "Missing ip verify source in access mode switchports."
write-output "Missing ip verify source for V-220660 here $Interface" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface


## V-220661
if ($Switchconfig -like "*ip arp inspection vlan 89*" -or $Switchconfig -like "*ip arp inspection vlan 1220*" -or $Switchconfig -like "*ip arp inspection vlan 1152*"){

$Vuln220661[1] = "NotAFinding"
$Vuln220661[2] = "ip arp inspection configured for user vlans."


}
else {

$Vuln220661[1] = "Open"
$Vuln220661[2] = "ip arp inspection not configured for user vlans."
write-output "Missing ip arp inspection global config for user VLANs for V-220661" >> $ShortDestination

}




##V-220662

foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*storm-control unicast*" -and $Interface -like "*storm-control broadcast*"){

$Vuln220662[1] = "NotAFinding"
$Vuln220662[2] = "Storm-control configured for all access switchports"

} ## end if

else {
$Vuln220662[1] = "Open"
$Vuln220662[2] = "Missing Storm-control configuration on certain access switchports."
write-output "Missing Storm-control broadcast or unicast for V-220662 here $Interface" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface


##V-220663

if ($Switchconfig -like "*no ip igmp snooping*"){

$Vuln220663[1] = "Open"
$Vuln220663[2] = "Missing ip igmp snooping configured on all VLANs"
write-output "Missing ip igmp snooping on all VLANs for V-220663" >> $ShortDestination

}
else {

$Vuln220663[1] = "NotAFinding"
$Vuln220663[2] = "ip igmp snooping configured on all VLANs"

}


## V-220664


if ($Switchconfig -like "*spanning-tree mode rapid-pvst*"){


$Vuln220664[1] = "NotAFinding"
$Vuln220664[2] = "Spanning-tree mode rapid-pvst configured on switch"

}
else {

$Vuln220664[1] = "Open"
$Vuln220664[2] = "Missing global configuration for spanning-tree mode rapid-pvst"
write-output "Missing spanning-tree mode rapid-pvst global config for V-220664" >> $ShortDestination

}


## V-220665
if ($Switchconfig -like "*udld enable*"){


$Vuln220665[1] = "NotAFinding"
$Vuln220665[2] = "udld enable is configured globally"

}
else {

$Vuln220665[1] = "Open"
$Vuln220665[2] = "udld enable is not configured on the switch"
write-output "Missing udld enable in global config for V-220665" >> $ShortDestination
}

## V-220666 - The Cisco switch must have all trunk links enabled statically.    TRUNK LOOP BBY


Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -like "*switchport nonegotiate*"){

$Vuln220666[1] = "NotAFinding"
$Vuln220666[2] = "Trunk ports are configured statically"

}
else {
$Vuln220666[1] = "Open"
$Vuln220666[2] = "All trunk ports are not configured statically"
write-output "Missing nonegotiate option on Trunk port for V-220666 here: $Interface" >> $ShortDestination
break

}

}

} ## end of foreach interface




##V-220667

foreach ($Interface in $Eachinterface){

if (($Interface -like "*DISABLED*" -or $Interface -like "*shutdown*")  -and $Interface -notlike "*vlan 999*"){

$Vuln220667[1] = "Open"
$Vuln220667[2] = "There is a shutdown interface not assigned to quarantine VLAN"
write-output "Missing quarantine VLAN assignment on shutdown interface for V-220667 here $Interface" >> $ShortDestination
break


} ## end of if interface isnt a trunk port and not disabled
else {

$Vuln220667[1] = "NotAFinding"
$Vuln220667[2] = "All disabled switchports are assigned to quarantine VLAN."

}


} ## end of foreach interface




## V-220668

foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -notlike "*switchport access vlan*"){

$Vuln220668[1] = "Open"
$Vuln220668[2] = "Access switchport in use is assigned the default vlan"
write-output "Switchport should not be assigned to default vlan for V-220668 here $Interface" >> $ShortDestination
break
} ## end if

else {
$Vuln220668[1] = "NotAFinding"
$Vuln220668[2] = "Each access port is not assigned to default vlan."



} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface





## V-220669 - Rule Title: The Cisco switch must have the default VLAN pruned from all trunk ports that do not require it.


Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -like "*switchport trunk allowed vlan*" -and $Interface -notlike "*switchport trunk allowed vlan 1,*"){

$Vuln220669[1] = "NotAFinding"
$Vuln220669[2] = "Trunk ports are configured to prune default vlan properly"

}
else {
$Vuln220669[1] = "Open"
$Vuln220669[2] = "All trunk ports are not configured to prune default VLAN."
write-output "Default vlan not pruned from trunk for V-220669" >> $ShortDestination
break

}

}

} ## end of foreach interface




## V-220670 - Rule Title: The Cisco switch must not use the default VLAN for management traffic.

$DefaultVLAN = $SwitchConfig | Select-string "interface Vlan1" -Context 0,8



if ($DefaultVLAN -like "*mgmt*" -or $DefaultVLAN -like "*management*"){

$Vuln220670[1] = "Open"
$Vuln220670[2] = "Default VLAN not shut down. Could be used for management traffic."
write-output "Missing shutdown command for default VLAN for V-220670" >> $ShortDestination

}
else {

$Vuln220670[1] = "NotAFinding"
$Vuln220670[2] = "Default VLAN is not being used for management"
}



## V-220671 - The Cisco switch must have all user-facing or untrusted ports configured as access switch ports.


foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -notlike "*switchport mode trunk*" -and $Interface -notlike "*vlan 999*" -and $Interface -notlike "*shutdown*"){

if ($Interface -like "*switchport mode access*"){

$Vuln220671[1] = "NotAFinding"
$Vuln220671[2] = "Each access switchport is properly configured as such"

} ## end if

else {
$Vuln220671[1] = "Open"
$Vuln220671[2] = "Missing switchport mode access in access switchports"
write-output "Missing switchport mode access for V-220671 here $Interface" >> $ShortDestination
break

} ## end else

} ## end of if interface isnt a trunk port and not disabled

} ## end of foreach interface







##V-220672 - The Cisco switch must have the native VLAN assigned to an ID other than the default VLAN for all 802.1q trunk links.


Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -notlike "*switchport trunk native vlan 1*" -and $Interface -like "*switchport trunk native vlan*"){

$Vuln220672[1] = "NotAFinding"
$Vuln220672[2] = "Trunk ports are configured to use a VLAN other than the default"

}
else {
$Vuln220672[1] = "Open"
$Vuln220672[2] = "Default VLAN used on Trunk port"
write-output "Default VLAN used on Trunk port for V-220672 here $Interface" >> $ShortDestination
break

}

}

} ## end of foreach interface




## V-220673 - Rule Title: The Cisco switch must not have any switchports assigned to the native VLAN of the trunk native VLAN.

Foreach ($Interface in $Eachinterface){

if ($Interface -notlike "*DISABLED*" -and $Interface -like "*switchport mode trunk*"){

if ($Interface -notlike "*switchport access vlan 4000*"){

$Vuln220673[1] = "NotAFinding"
$Vuln220673[2] = "Access ports are not using trunk native vlan."

}
else {
$Vuln220673[1] = "Open"
$Vuln220673[2] = "Native Trunk VLAN used on Access switchport. This could lead to double encapsulation issues."
write-output "Default Trunk VLAN used on Access switchport for V-220673 here $Interface" >> $ShortDestination
break

}

}

} ## end of foreach interface



### END STIG PROCESS #####



$AllVulnArray = @(
$Vuln220648,
$Vuln220649,
$Vuln220650,
$Vuln220651,
$Vuln220652,
$Vuln220653,
$Vuln220654,
$Vuln220655,
$Vuln220656,
$Vuln220657,
$Vuln220658,
$Vuln220659,
$Vuln220660,
$Vuln220661,
$Vuln220662,
$Vuln220663,
$Vuln220664,
$Vuln220665,
$Vuln220666,
$Vuln220667,
$Vuln220668,
$Vuln220669,
$Vuln220670,
$Vuln220671,
$Vuln220672,
$Vuln220673
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