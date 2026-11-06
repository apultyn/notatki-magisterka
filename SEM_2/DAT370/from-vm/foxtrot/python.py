import subprocess
command = "/bin/bash"
proc = subprocess.Popen(command, stdin = subprocess.PIPE, stdout = subprocess.PIPE)
proc.stdin.write("apt-get install sudo -y")