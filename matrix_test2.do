restart -f
force clk 0 0ns, 1 5ns -repeat 10ns
force A 16#B0C8C048C03050B048
force B 16#484030303048304030
force start 0 0ns, 1 10ns, 0 20ns
log -r *
run 200ns
#72'he0e2e86058c06c6a50
#A = [-1, -3, -2; 3, -2, 1; 4, -1, 3];
#B = [3, 2, 1; 1, 1, 3; 1, 2, 1];
#ans =
#
#    -8    -9   -12
#     8     6    -2
#    14    13     4