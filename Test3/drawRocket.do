vlib work

vlog drawRocket.v

vsim -L altera_mf_ver drawRocket

add wave {/*}

log {/*}
moveDown, moveLeft, moveUp, moveRight, rocketLocation,
force {clock} 0 0ns, 1 5ns, -r 10ns
force {resetn} 0
force {moveDown} 0
force {moveLeft} 0
force {moveUp} 0
force {moveRight} 0
force {rocketLocation[0]} 0
force {rocketLocation[1]} 0
force {rocketLocation[2]} 0
force {rocketLocation[3]} 0
force {rocketLocation[4]} 0
force {rocketLocation[5]} 0
force {rocketLocation[6]} 0
force {rocketLocation[7]} 0
force {rocketLocation[8]} 0
force {rocketLocation[9]} 0
force {rocketLocation[10]} 0
force {rocketLocation[11]} 0
force {rocketLocation[12]} 0
force {rocketLocation[13]} 0
force {rocketLocation[14]} 0
force {rocketLocation[15]} 0
force {rocketLocation[16]} 0