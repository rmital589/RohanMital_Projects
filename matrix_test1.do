restart -f
force clk 0 0ns, 1 5ns -repeat 10ns
force A 16#304048484030304048
force B 16#484030304048484030
force start 0 0ns, 1 10ns, 0 20ns
log -r *
run 200ns
#72'h6C68646C68646C6864
#A = [1, 2, 3; 3, 2, 1; 1, 2, 3];
#B = [3, 2, 1; 1, 2, 3; 3, 2, 1];
#C = [14, 12, 10; 14, 12, 10; 14, 12, 10];