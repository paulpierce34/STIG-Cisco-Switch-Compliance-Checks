# STIG-Cisco-Switch-Compliance-Checks

This script should be ran against a directory of switch or router configurations to determine their STIG compliance.

The switch/router configuration will be cross-referenced by a blank STIG .ckl file supplied by the user (user will be prompted upon running script).

The output will be a 'Quick Glance' text file where you can quickly look for what each individual switch is missing in terms of STIG items.
You can optionally also create STIG checklists for each of the individual switches.

This is a great way of tracking switch STIG compliance for all of the most recent DISA STIGs.


Supported STIG checklists:
CISCO IOS L2S Switch STIG V2R2 - Release Date: 23 Jul 2021
CISCO IOS NDM Switch STIG V2R3 - Release Date: 23 Jul 2021
CISCO IOS-XE Switch L2S STIG V2R2 - Release Date: 23 Jul 2021
Cisco IOS-XE Switch NDM STIG V2R3 - Release Date: 23 Jul 2021
Cisco IOS-XE Router NDM STIG V2R3 - Release Date: 23 Jul 2021
Cisco IOS-XE Router RTR STIG V2R2 - Release Date: 23 Apr 2021
CISCO IOS-XE Switch RTR STIG V2R2 - Release Date: 23 Jul 2021
