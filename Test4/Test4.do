vlib work

vlog Test4.v

vsim -L altera_mf_ver Test4

add wave {/*}
log {/*}

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 1
force {KEY[1]} 0
run 10ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 1
run 10ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 0
run 768000ns
