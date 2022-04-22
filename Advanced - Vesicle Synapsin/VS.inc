radius = <integer radius of the presynaptic nerve terminal>; don't forget to change dimensions accordingly
#BeginMacro (radius)
8
#EndMacro

theta = <angle in degrees encompassed by active zone>
#BeginMacro (theta)
90
#EndMacro

p_vesicle = <vesicle fraction>
#BeginMacro (p_vesicle)
0.12
#EndMacro

p_synapsin = <synapsin fraction>
#BeginMacro (p_synapsin)
0.12
#EndMacro

n_act = <number of cycles between action potentials>
#BeginMacro (n_act)
30
#EndMacro

m_act = <number of cycles of action-potential-induced reaction>
#BeginMacro (m_act)
3
#EndMacro

p_rest = <binding probability during rest>
#BeginMacro (p_rest)
1
#EndMacro

q_rest = <unbinding probability during rest>
#BeginMacro (q_rest)
0
#EndMacro

p_act = <binding probability during action-potential-induced reaction>
#BeginMacro (p_act)
0
#EndMacro

q_act = <unbinding probability during action-potential-induced reaction>
#BeginMacro (q_act)
1
#EndMacro

% ONLY DEVELOPERS SHOULD EDIT BELOW THIS LINE

#BeginMacro (t_cycle)
8
#EndMacro

#BeginMacro (is_starting)
(remainder(trunc((0,0)/10), 10) = 0)
#EndMacro

#BeginMacro (is_holding)
(remainder(trunc((0,0)/10), 10) = 1)
#EndMacro

#BeginMacro (adjacent_is_holding)
((remainder(trunc((1,0)/10), 10) = 1) or (remainder(trunc((0,1)/10), 10) = 1) or (remainder(trunc((-1,0)/10), 10) = 1) or (remainder(trunc((0,-1)/10), 10) = 1))
#EndMacro

#BeginMacro (is_selecting)
(remainder(trunc((0,0)/10), 10) = 2)
#EndMacro

#BeginMacro (adjacent_is_selecting)
((remainder(trunc((1,0)/10), 10) = 2) or (remainder(trunc((0,1)/10), 10) = 2) or (remainder(trunc((-1,0)/10), 10) = 2) or (remainder(trunc((0,-1)/10), 10) = 2))
#EndMacro

#BeginMacro (is_binding_s)
(remainder(trunc((0,0)/10), 10) = 3)
#EndMacro

#BeginMacro (is_binding_v)
(remainder(trunc((0,0)/10), 10) = 4)
#EndMacro

#BeginMacro (adjacent_is_binding_v)
((remainder(trunc((1,0)/10), 10) = 4) or (remainder(trunc((0,1)/10), 10) = 4) or (remainder(trunc((-1,0)/10), 10) = 4) or (remainder(trunc((0,-1)/10), 10) = 4))
#EndMacro

#BeginMacro (is_aiming)
(remainder(trunc((0,0)/10), 10) = 5)
#EndMacro

#BeginMacro (adjacent_is_aiming)
((remainder(trunc((1,0)/10), 10) = 5) or (remainder(trunc((0,1)/10), 10) = 5) or (remainder(trunc((-1,0)/10), 10) = 5) or (remainder(trunc((0,-1)/10), 10) = 5))
#EndMacro

#BeginMacro (is_steering)
(remainder(trunc((0,0)/10), 10) = 6)
#EndMacro

#BeginMacro (adjacent_is_steering)
((remainder(trunc((1,0)/10), 10) = 6) or (remainder(trunc((0,1)/10), 10) = 6) or (remainder(trunc((-1,0)/10), 10) = 6) or (remainder(trunc((0,-1)/10), 10) = 6))
#EndMacro

#BeginMacro (is_moving)
(remainder(trunc((0,0)/10), 10) = 7)
#EndMacro

#BeginMacro (adjacent_is_moving)
((remainder(trunc((1,0)/10), 10) = 7) or (remainder(trunc((0,1)/10), 10) = 7) or (remainder(trunc((-1,0)/10), 10) = 7) or (remainder(trunc((0,-1)/10), 10) = 7))
#EndMacro

#BeginMacro (is_vacating)
(remainder(trunc((0,0)), 10) > 0)
#EndMacro

#BeginMacro (starting)
(trunc((0,0)/100)*100)
#EndMacro

#BeginMacro (holding)
(trunc((0,0)/100)*100 + 10)
#EndMacro

#BeginMacro (selecting)
(trunc((0,0)/10000000)*10000000 + 
    if(trunc((0,0)/10000000) = 2, 
       if((remainder(trunc((0,0)/1000000), 10) = 4) and not (remainder(trunc((0,0)/10000), 10) = 4), 
          2000 + 10*if(trunc((-1,0)/10000000) = 1, 1, 0),
          if((remainder(trunc((0,0)/100000), 10) = 4) and not (remainder(trunc((0,0)/1000), 10) = 4), 
             200 + 1*if(trunc((0,-1)/10000000) = 1, 1, 0),
             if((remainder(trunc((0,0)/10000), 10) = 4) and not (remainder(trunc((0,0)/1000000), 10) = 4), 
                20 + 1000*if(trunc((1,0)/10000000) = 1, 1, 0),
                if((remainder(trunc((0,0)/1000), 10) = 4) and not (remainder(trunc((0,0)/100000), 10) = 4), 
                   2 + 100*if(trunc((0,1)/10000000) = 1, 1, 0),
                   if(remainder(trunc((0,0)/1000), 10000) = 0,
                      if(uniform(0, 1) < 0.5, 
                         1000*if(trunc((1,0)/10000000) = 1, 1, 0) + 10*if(trunc((-1,0)/10000000) = 1, 1, 0),
                         100*if(trunc((0,1)/10000000) = 1, 1, 0) + 1*if(trunc((0,-1)/10000000) = 1, 1, 0)
                      ),
                      2000*if(remainder(trunc((0,0)/1000000), 10) = 4, 1, 0) + 200*if(remainder(trunc((0,0)/100000), 10) = 4, 1, 0) + 20*if(remainder(trunc((0,0)/10000), 10) = 4, 1, 0) + 2*if(remainder(trunc((0,0)/1000), 10) = 4, 1, 0)
                   )
                )
             )
          )
       ),
       if(trunc((0,0)/10000000) = 1,
          3000*if(trunc((1,0)/10000000) = 2, 1, 0) + 300*if(trunc((0,1)/10000000) = 2, 1, 0) + 30*if(trunc((-1,0)/10000000) = 2, 1, 0) + 3*if(trunc((0,-1)/10000000) = 2, 1, 0),
          0
       )
    )*1000 +
    remainder(trunc((0,0)/100), 10)*100 +
    20
)
#EndMacro

#BeginMacro (binding_s)
(trunc((0,0)/100)*100 + 30)
#EndMacro

#BeginMacro (binding_v)
(trunc((0,0)/100)*100 + 40)
#EndMacro

#BeginMacro (aiming)
(trunc((0,0)/100)*100 +
    50 + 
    if((trunc((0,0)/10000000) = 0),
       0.875,
       if((trunc((0,0)/10000000) = 3) or 
          (trunc((0,0)/10000000) = 4) or 
          (trunc((1,0)/10000000) = 4) or 
          (trunc((0,1)/10000000) = 4) or 
          (trunc((-1,0)/10000000) = 4) or 
          (trunc((0,-1)/10000000) = 4), 
          0.125,                                 
          (1 + trunc(4*uniform(0, 1)) + 0.25 + 0.5*uniform(0, 1))
       )
    )
)
#EndMacro

#BeginMacro (steering)
(trunc((0,0)/100)*100 + 60 + remainder((0,0), 10))
#EndMacro

#BeginMacro (moving)
(trunc((0,0)/100)*100 + 70 + remainder((0,0), 10))
#EndMacro

#BeginMacro (empty)
0
#EndMacro

#BeginMacro (vesicle)
10000000
#EndMacro

#BeginMacro (synapsin)
20000000
#EndMacro

#BeginMacro (membrane)
30000000
#EndMacro

#BeginMacro (zone)
40000000
#EndMacro

#BeginMacro (is_empty)
(trunc((0,0)/10000000) = 0)
#EndMacro

#BeginMacro (is_particle)
((trunc((0,0)/10000000) = 1) or (trunc((0,0)/10000000) = 2))
#EndMacro

#BeginMacro (south_is_particle)
((trunc((1,0)/10000000) = 1) or (trunc((1,0)/10000000) = 2))
#EndMacro

#BeginMacro (east_is_particle)
((trunc((0,1)/10000000) = 1) or (trunc((0,1)/10000000) = 2))
#EndMacro

#BeginMacro (north_is_particle)
((trunc((-1,0)/10000000) = 1) or (trunc((-1,0)/10000000) = 2))
#EndMacro

#BeginMacro (west_is_particle)
((trunc((0,-1)/10000000) = 1) or (trunc((0,-1)/10000000) = 2))
#EndMacro

#BeginMacro (is_vesicle)
(trunc((0,0)/10000000) = 1)
#EndMacro

#BeginMacro (south_is_vesicle)
(trunc((1,0)/10000000) = 1)
#EndMacro

#BeginMacro (east_is_vesicle)
(trunc((0,1)/10000000) = 1)
#EndMacro

#BeginMacro (north_is_vesicle)
(trunc((-1,0)/10000000) = 1)
#EndMacro

#BeginMacro (west_is_vesicle)
(trunc((0,-1)/10000000) = 1)
#EndMacro

#BeginMacro (is_synapsin)
(trunc((0,0)/10000000) = 2)
#EndMacro

#BeginMacro (south_is_synapsin)
(trunc((1,0)/10000000) = 2)
#EndMacro

#BeginMacro (east_is_synapsin)
(trunc((0,1)/10000000) = 2)
#EndMacro

#BeginMacro (north_is_synapsin)
(trunc((-1,0)/10000000) = 2)
#EndMacro

#BeginMacro (west_is_synapsin)
(trunc((0,-1)/10000000) = 2)
#EndMacro

#BeginMacro (south_is_membrane)
(trunc((1,0)/10000000) = 3)
#EndMacro

#BeginMacro (east_is_membrane)
(trunc((0,1)/10000000) = 3)
#EndMacro

#BeginMacro (north_is_membrane)
(trunc((-1,0)/10000000) = 3)
#EndMacro

#BeginMacro (west_is_membrane)
(trunc((0,-1)/10000000) = 3)
#EndMacro

#BeginMacro (is_starting_act)
(remainder(trunc((0,0)/100), 10) = 3)
#EndMacro

#BeginMacro (adjacent_is_starting_act)
((remainder(trunc((1,0)/100), 10) = 3) or (remainder(trunc((0,1)/100), 10) = 3) or (remainder(trunc((-1,0)/100), 10) = 3) or (remainder(trunc((0,-1)/100), 10) = 3))
#EndMacro

#BeginMacro (is_starting_rest)
(remainder(trunc((0,0)/100), 10) = 1)
#EndMacro

#BeginMacro (adjacent_is_starting_rest)
((remainder(trunc((1,0)/100), 10) = 1) or (remainder(trunc((0,1)/100), 10) = 1) or (remainder(trunc((-1,0)/100), 10) = 1) or (remainder(trunc((0,-1)/100), 10) = 1))
#EndMacro

#BeginMacro (is_holding_act)
(remainder(trunc((0,0)/100), 10) = 2)
#EndMacro

#BeginMacro (is_holding_rest)
(remainder(trunc((0,0)/100), 10) = 0)
#EndMacro

#BeginMacro (start_act)
(trunc((0,0)/1000)*1000 + 300 + remainder((0,0), 100))
#EndMacro

#BeginMacro (hold_act)
(trunc((0,0)/1000)*1000 + 200 + remainder((0,0), 100))
#EndMacro

#BeginMacro (start_rest)
(trunc((0,0)/1000)*1000 + 100 + remainder((0,0), 100))
#EndMacro

#BeginMacro (hold_rest)
(trunc((0,0)/1000)*1000 + remainder((0,0), 100))
#EndMacro

#BeginMacro (is_seeking_south)
(remainder(trunc((0,0)/1000000), 10) = 1)
#EndMacro

#BeginMacro (is_seeking_east)
(remainder(trunc((0,0)/100000), 10) = 1)
#EndMacro

#BeginMacro (is_seeking_north)
(remainder(trunc((0,0)/10000), 10) = 1)
#EndMacro

#BeginMacro (is_seeking_west)
(remainder(trunc((0,0)/1000), 10) = 1)
#EndMacro

#BeginMacro (is_unseeking_south)
(remainder(trunc((0,0)/1000000), 10) = 2)
#EndMacro

#BeginMacro (is_unseeking_east)
(remainder(trunc((0,0)/100000), 10) = 2)
#EndMacro

#BeginMacro (is_unseeking_north)
(remainder(trunc((0,0)/10000), 10) = 2)
#EndMacro

#BeginMacro (is_unseeking_west)
(remainder(trunc((0,0)/1000), 10) = 2)
#EndMacro

#BeginMacro (is_looking_south)
(remainder(trunc((0,0)/1000000), 10) = 3)
#EndMacro

#BeginMacro (is_looking_east)
(remainder(trunc((0,0)/100000), 10) = 3)
#EndMacro

#BeginMacro (is_looking_north)
(remainder(trunc((0,0)/10000), 10) = 3)
#EndMacro

#BeginMacro (is_looking_west)
(remainder(trunc((0,0)/1000), 10) = 3)
#EndMacro

#BeginMacro (is_binding_south)
(remainder(trunc((0,0)/1000000), 10) = 4)
#EndMacro

#BeginMacro (is_binding_east)
(remainder(trunc((0,0)/100000), 10) = 4)
#EndMacro

#BeginMacro (is_binding_north)
(remainder(trunc((0,0)/10000), 10) = 4)
#EndMacro

#BeginMacro (is_binding_west)
(remainder(trunc((0,0)/1000), 10) = 4)
#EndMacro

#BeginMacro (north_is_binding_south)
(remainder(trunc((-1,0)/1000000), 10) = 4)
#EndMacro

#BeginMacro (west_is_binding_east)
(remainder(trunc((0,-1)/100000), 10) = 4)
#EndMacro

#BeginMacro (south_is_binding_north)
(remainder(trunc((1,0)/10000), 10) = 4)
#EndMacro

#BeginMacro (east_is_binding_west)
(remainder(trunc((0,1)/1000), 10) = 4)
#EndMacro

#BeginMacro (bind_south)
(trunc((0,0)/10000000)*10000000 + 4000000 + remainder((0,0), 1000000))
#EndMacro

#BeginMacro (bind_east)
(trunc((0,0)/1000000)*1000000 + 400000 + remainder((0,0), 100000))
#EndMacro

#BeginMacro (bind_north)
(trunc((0,0)/100000)*100000 + 40000 + remainder((0,0), 10000))
#EndMacro

#BeginMacro (bind_west)
(trunc((0,0)/10000)*10000 + 4000 + remainder((0,0), 1000))
#EndMacro

#BeginMacro (unbind_south)
(trunc((0,0)/10000000)*10000000 + remainder((0,0), 1000000))
#EndMacro

#BeginMacro (unbind_east)
(trunc((0,0)/1000000)*1000000 + remainder((0,0), 100000))
#EndMacro

#BeginMacro (unbind_north)
(trunc((0,0)/100000)*100000 + remainder((0,0), 10000))
#EndMacro

#BeginMacro (unbind_west)
(trunc((0,0)/10000)*10000 + remainder((0,0), 1000))
#EndMacro

#BeginMacro (is_moving_south)
(remainder(trunc((0,0)), 10) = 1)
#EndMacro

#BeginMacro (is_moving_east)
(remainder(trunc((0,0)), 10) = 2)
#EndMacro

#BeginMacro (is_moving_north)
(remainder(trunc((0,0)), 10) = 3)
#EndMacro

#BeginMacro (is_moving_west)
(remainder(trunc((0,0)), 10) = 4)
#EndMacro

#BeginMacro (south_is_moving_north)
(remainder(trunc((1,0)), 10) = 3)
#EndMacro

#BeginMacro (east_is_moving_west)
(remainder(trunc((0,1)), 10) = 4)
#EndMacro

#BeginMacro (north_is_moving_south)
(remainder(trunc((-1,0)), 10) = 1)
#EndMacro

#BeginMacro (west_is_moving_east)
(remainder(trunc((0,-1)), 10) = 2)
#EndMacro

#BeginMacro (south_is_conflicting)
((remainder((1,0), 1) = remainder((0,0), 1)) and not (remainder(trunc((1,0)), 10) = remainder(trunc((0,0)), 10)))
#EndMacro

#BeginMacro (east_is_conflicting)
((remainder((0,1), 1) = remainder((0,0), 1)) and not (remainder(trunc((0,1)), 10) = remainder(trunc((0,0)), 10)))
#EndMacro

#BeginMacro (north_is_conflicting)
((remainder((-1,0), 1) = remainder((0,0), 1)) and not (remainder(trunc((-1,0)), 10) = remainder(trunc((0,0)), 10)))
#EndMacro

#BeginMacro (west_is_conflicting)
((remainder((0,-1), 1) = remainder((0,0), 1)) and not (remainder(trunc((0,-1)), 10) = remainder(trunc((0,0)), 10)))
#EndMacro

#BeginMacro (south_is_priority)
(remainder((1,0), 1) < remainder((0,0), 1))
#EndMacro

#BeginMacro (east_is_priority)
(remainder((0,1), 1) < remainder((0,0), 1))
#EndMacro

#BeginMacro (north_is_priority)
(remainder((-1,0), 1) < remainder((0,0), 1))
#EndMacro

#BeginMacro (west_is_priority)
(remainder((0,-1), 1) < remainder((0,0), 1))
#EndMacro

#BeginMacro (obey_south)
(trunc((0,0)/10)*10 + remainder((1,0), 10))
#EndMacro

#BeginMacro (obey_east)
(trunc((0,0)/10)*10 + remainder((0,1), 10))
#EndMacro

#BeginMacro (obey_north)
(trunc((0,0)/10)*10 + remainder((-1,0), 10))
#EndMacro

#BeginMacro (obey_west)
(trunc((0,0)/10)*10 + remainder((0,-1), 10))
#EndMacro

#BeginMacro (obey_all)
(trunc((0,0)/10)*10 + 0.875)
#EndMacro

#BeginMacro (obey_none)
(trunc((0,0)/10)*10 + 0.125)
#EndMacro

#BeginMacro (from_south)
(trunc((1,0)/100)*100)
#EndMacro

#BeginMacro (from_east)
(trunc((0,1)/100)*100)
#EndMacro

#BeginMacro (from_north)
(trunc((-1,0)/100)*100)
#EndMacro

#BeginMacro (from_west)
(trunc((0,-1)/100)*100)
#EndMacro

#BeginMacro (from_none)
(remainder(trunc((0,0)/100), 10)*100)
#EndMacro


