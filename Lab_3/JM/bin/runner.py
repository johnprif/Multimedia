import os

k = open("dataDec.txt", "r+")
k.truncate(0)
k.close()
for i in range(0,100):
    os.system("./rtp_loss.exe akiyo_test.264 akiyo_test_loss.264 1 0")
    os.system("./ldecod.exe -f decoder.cfg")

f = open("dataDec.txt", "r")
sum_Y = 0
sum_U = 0
sum_V = 0

x = f.readline()
while x:
    SNR_Y = float(x.split()[11])
    SNR_U = float(x.split()[12])
    SNR_V = float(x.split()[13])
    sum_Y = sum_Y+SNR_Y
    sum_U = sum_U+SNR_U
    sum_V = sum_V+SNR_V
    x = f.readline()

f.close()

print("-------------------------------------------------------------------------")
print("For bitstream akiyo and packet loss rate = 1%")
print("Average SNR_Y = %.2f"%(sum_Y/100))
print("Average SNR_U = %.2f"%(sum_U/100))
print("Average SNR_V = %.2f"%(sum_V/100))
    
