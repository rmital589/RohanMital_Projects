restart -f
force clk 0 0ns, 1 5ns -repeat 10ns
force A 16#38c800B040b8004000
force B 16#30c030382000c84830
force start 0 0ns, 1 10ns, 0 20ns
log -r *
run 200ns