restart
force clk 0 0ns, 1 5ns -repeat 10ns
force A 16#303030303030303030
force B 16#303030303030303030
force start 0 0ns, 1 10ns, 0 20ns
log -r *; run 200ns