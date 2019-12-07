restart -f
force clk 0 0ns, 1 5ns -repeat 10ns
force A 16#383838383838383838
force B 16#383838383838383838
force start 0 0ns, 1 10ns, 0 20ns
log -r *
run 200ns