#Centrify Tools#
Tools for listing permissions and getting information from Centrify on the command line

##AD Group##

###Description###
Will list an AD Security Group using a tree structure

###Usage###
ad_group [-h|--help] <ad group>

###Example###
<pre>
$ ad_group admins

Group: admins
`-- User: jdoe (John Doe)
`-- User: anobel (Alfred Nobel)
|-- Group: devs
|   `-- User: bsimon (Burt Simon)
|   `-- User: landerss (Lars Andersson)
`-- User: cbaker (Carl Baker)
</pre>

##AD Host Roles##

###Description###
Will list users assigned to role's on a host

###Usage###
ad_host_roles [-h|--help] <hostname>

###Example###
<pre>
$ ad_host_roles myserver

Role: ts_admins
|-- Group: devs
|   `-- User: bsimon (Burt Simon)
|   `-- User: landerss (Lars Andersson)
</pre>

##AD Host Zone##

###Description###
Will print host's zone

###Usage###
ad_host_roles [-h|--help] <hostname>

###Example###
<pre>
$ ad_host_roles myserver

myzone
</pre>

##AD Hosts##

###Description###
List hosts in a zone

###Usage###
ad_hosts [-h|--help] <zone>

###Example###
<pre>
$ ad_hosts myzone

webserver.mydomain
smtpserver.mydomain
imapserver.mydomain
</pre>

##AD Zone Roles##

###Description###
Will list users assigned to role's in a zone

###Usage###
ad_zone_roles [-h|--help] <hostname>

###Example###
<pre>
$ ad_zone_roles infrastructure

Role: login
|-- Group: login
|   `-- User: jdoe (John Doe)
|   `-- User: bsimpson (Bart Simpsons)

Role: admins
|-- Group: admins
|   `-- User: lsimpsons (Lisa Simpsons)
</pre>

##AD Zones##

###Description###
Will list all Centrify zones

###Usage###
ad_zones [-h|--help]

###Example###
<pre>
$ ad_zones 

dev
qa
prod
</pre>
