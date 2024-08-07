# bcx-rhel-automation
Automate HPOSS daily tasks 
# 
# Procedures - Jenkins Pipelines
- In the Jenkins folder (create a directory called scripts) e.g C:\ProgramData\Jenkins\.scripts - It will be used to store scripts to run remotely
1. RHEL Security Patching
- Check BCX-RHEL-Pipelines/rhel-security-patching - It is self explained.
- You need to use this to create a pipeline that will be used to execute patching on your behalf remotely
- Do not forget to create parameter if jenkins does not create them for you

        - string(name: 'CLIENT_NAME', defaultValue: 'tcenhvbssprd', description: 'Client name prefix for server names')
        - string(name: 'START_INDEX', defaultValue: '1', description: 'Start index for server names')
        - string(name: 'END_INDEX', defaultValue: '12', description: 'End index for server names')

        This tells jenkins to loop your job from server tcenhvbssprd1 to tcenhvbssprd12

# You can use this pipeline to cater for anything, the only thing you need to change is the script name.

- Scripts are located in BCX-RHEL-Scripts
- For this documentation I used BCX-RHEL-Scripts/yum-update.sh because the above pipeline is created specifically for it.

# Thats all for now folks!!!
