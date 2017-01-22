vlib work

vlog SpeedAndAccelerationTest.v

vsim SpeedAndAccelerationTest

log {/*}

add wave {/*}

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 0
run 120ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
run 240ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 120ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1
run 240ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
run 240ns

force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 240ns