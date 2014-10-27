bashCommand = "sudo xm dmesg &> out.txt"
import subprocess
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output = process.communicate()[0]

for x in range(0, 3):
	subprocess.Popen("sudo xm dmesg")
