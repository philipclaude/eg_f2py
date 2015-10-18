import pysentropic

pysentropic.in_var.gamm = 1.4
pysentropic.in_var.mtol = 1e-6 # supersonic often stalls at 1e-7

areaR = 1.4 # area ratio

pysentropic.solvem( areaR , 0 ) # 0 = subsonic
print "A/A* = ", areaR , "M = ",pysentropic.out_var.m

pysentropic.solvem( areaR, 1 ) # 1 = supersonic
print "A/A* = ", areaR , "M = ",pysentropic.out_var.m
