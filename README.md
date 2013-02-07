Test your IDS/IPS with metasploit

Metasploit is great, so lets use it to test our ips.

how to run it:

copy this file to metasploit directory and run it like

´´´´
./meta-x-ids.rb RHOST=127.0.0.1 RPORT=80
´´´´

where the RHOST is a destiny host. I work together with the excelent inetsim http://www.inetsim.org.

Normally like |ATTACKER| ---> |IPS| --> |inetsim|

REQUIREMENTS:

* Metasploit from my repo https://github.com/vpereira/metasploit-framework
* Metasploit data models from my repo https://github.com/vpereira/metasploit_data_models
* JRUBY 1.7.2 (insanity, but works)

make sure that both are in the same repo, run bundle install at both


MY ~/.jrubyrc:
´´´´
compat.version=1.9
cext.enabled=true
´´´´



