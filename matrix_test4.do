restart -f
force clk 0 0ns, 1 5ns -repeat 10ns
force A 16#300000003000000030
force B 16#123456123456123456
force start 0 0ns, 1 10ns, 0 20ns
log -r *
run 200ns
#72'he0e2e86058c06c6a50
#A = [-1/4, -3/2, -2; 3/4, -2, 3/4; 1/2, -1/2, 3/4];
#B = [3/4, 1/2, 1; 1, 1/2, 5/4; -9/4, 2, 1/2];
#ans =
#
#    2.8125   -4.8750   -3.1250
#   -3.1250    0.8750   -1.3750
#   -1.8125    1.5000    0.2500