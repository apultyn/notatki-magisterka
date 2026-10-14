# Test VM usage

<https://learn.fabric-testbed.net/knowledge-base/generating-ssh-configuration-and-ssh-keys/>
<https://learn.fabric-testbed.net/knowledge-base/logging-into-fabric-vms/>
- bastion keys are revoked often, have to generate often
- start with generating your keys (remember to change key name xD)
```bash
ssh-keygen -t rsa -b 3072 -f ~/.ssh/fabric_silver_key  -C "pultyn-sliver"
ssh-keygen -t rsa -b 3072 -f ~/.ssh/fabric_bastion_key -C "pultyn-bastion"
```
- add them on experiments -> manage ssh keys
- create file `~/.ssh/fabric_config` (bastion username should be seen at the top of the manage ssh keys page):
```text
UserKnownHostsFile /dev/null
StrictHostKeyChecking no
ServerAliveInterval 120

Host bastion.fabric-testbed.net
     User <bastion-username>
     ForwardAgent yes
     IdentityFile ~/.ssh/fabric_bastion_key
     IdentitiesOnly yes

Host * !bastion.fabric-testbed.net
     ProxyJump <bastion-username>@bastion.fabric-testbed.net:22

Host fabvm
    HostName 2001:18e8:fff0:3:f816:3eff:feb9:469a
    User ubuntu
    ProxyJump bastion.fabric-testbed.net
    IdentityFile ~/.ssh/fabric_silver_key
    IdentitiesOnly yes
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ServerAliveInterval 120
```
- add this to `~/.ssh/config` file: 
```text
Include ~/.ssh/fabric_config
```
- then you need to have the public key on the vm. Either contact me or login with ephermal key and append the `~/.ssh/authorized_keys` file
- useful commands:
	- `ssh fabvm`
	- `scp fabvm:~/test.md .` - from VM to localhost
	- `scp README.md fabvm:~/` - from localhost to VM

