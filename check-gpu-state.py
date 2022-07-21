import os
import sys
import time

num_pings = int(sys.argv[1])
wait_time = int(sys.argv[2])

for i in range(num_pings):
    print(os.system("nvidia-smi"), flush=True)
    time.sleep(wait_time)
