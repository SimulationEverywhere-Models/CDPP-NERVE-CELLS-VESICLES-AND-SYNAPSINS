#include(VS_Test.inc)


[top]
components : presynaptic axon 
link : out@axon in@presynaptic


[presynaptic]
type : cell
dim : (33,33)  % length must be 2*radius + 1
in : in
link : in in@presynaptic(0,0)
delay : inertial
defaultDelayTime : 1
border : wrapped
neighbors :       (-1,0)
neighbors : (0,-1) (0,0) (0,1)
neighbors :        (1,0)
localtransition : presynaptic-rule
portInTransition : in@presynaptic(0,0) action-rule
initialvalue : -1


[action-rule]

% Start action potential or normal conditions according to input
rule : { #Macro(start_act) } 0 { portValue(in) = 1 } 
rule : { #Macro(start_rest) } 0 { portValue(in) = 0 } 


[presynaptic-rule]

% Initialize cell-space
rule : { #Macro(zone)     } 1 { ((0,0) = -1) and (sqrt((cellpos(0) - #Macro(radius))*(cellpos(0) - #Macro(radius)) + (cellpos(1) - #Macro(radius))*(cellpos(1) - #Macro(radius))) >= #Macro(radius)) and ((#Macro(theta) = 360) or  ((cellpos(0) - #Macro(radius)) > sqrt((cellpos(0) - #Macro(radius))*(cellpos(0) - #Macro(radius)) + (cellpos(1) - #Macro(radius))*(cellpos(1) - #Macro(radius)))*cos(#Macro(theta)*pi/360))) }
rule : { #Macro(membrane) } 1 { ((0,0) = -1) and (sqrt((cellpos(0) - #Macro(radius))*(cellpos(0) - #Macro(radius)) + (cellpos(1) - #Macro(radius))*(cellpos(1) - #Macro(radius))) >= #Macro(radius)) }
rule : { #Macro(vesicle)  } 1 { ((0,0) = -1) and (uniform(0, 1) < #Macro(p_vesicle)) }
rule : { #Macro(synapsin) } 1 { ((0,0) = -1) and (uniform(0, 1) < #Macro(p_synapsin)/(1 - #Macro(p_vesicle))) }
rule : { #Macro(empty)    } 1 { ((0,0) = -1) }

% If an adjacent is "holding", transition immediately from "starting" to "holding"
rule : { #Macro(holding) } 0 { #Macro(is_starting) and #Macro(adjacent_is_holding) }

% Start action potential or normal conditions according to adjacent cells
rule : { #Macro(start_act)  } 0 { #Macro(is_starting) and #Macro(is_holding_rest) and #Macro(adjacent_is_starting_act)  } 
rule : { #Macro(start_rest) } 0 { #Macro(is_starting) and #Macro(is_holding_act)  and #Macro(adjacent_is_starting_rest) } 

% In 1 time unit, transition from "starting" to "holding"
rule : { #Macro(holding) } 1 { #Macro(is_starting) }

% If an adjacent is "selecting", transition immediately from "holding" to "selecting"
rule : { #Macro(selecting) } 0 { #Macro(is_holding) and #Macro(adjacent_is_selecting) }

% Hold action potential or normal conditions
rule : { #Macro(hold_act)  } 0 { #Macro(is_holding) and #Macro(is_starting_act)  } 
rule : { #Macro(hold_rest) } 0 { #Macro(is_holding) and #Macro(is_starting_rest) } 

% In 1 time unit, transition from "holding" to "selecting"
rule : { #Macro(selecting) } 1 { #Macro(is_holding) }

% In 1 time unit, transition from "selecting" to "binding"
rule : { #Macro(binding_s) } 1 { #Macro(is_selecting) }

% If an adjacent is "binding_v", transition immediately from "binding_s" to "binding_v"
rule : { #Macro(binding_v) } 0 { #Macro(is_binding_s) and #Macro(adjacent_is_binding_v) }

% Synapsins attempt to bind to adjacent vesicles
rule : { #Macro(bind_south)   } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_south) and (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(p_rest), #Macro(p_act))) }
rule : { #Macro(unbind_south) } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_south) }
rule : { #Macro(bind_east)    } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_east)  and (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(p_rest), #Macro(p_act))) }
rule : { #Macro(unbind_east)  } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_east)  }
rule : { #Macro(bind_north)   } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_north) and (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(p_rest), #Macro(p_act))) }
rule : { #Macro(unbind_north) } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_north) }
rule : { #Macro(bind_west)    } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_west)  and (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(p_rest), #Macro(p_act))) }
rule : { #Macro(unbind_west)  } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_seeking_west)  }

% Synapsins attempt to unbind from adjacent vesicles
rule : { #Macro(bind_south)   } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_south) and not (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(q_rest), #Macro(q_act))) }
rule : { #Macro(unbind_south) } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_south) }
rule : { #Macro(bind_east)    } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_east)  and not (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(q_rest), #Macro(q_act))) }
rule : { #Macro(unbind_east)  } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_east)  }
rule : { #Macro(bind_north)   } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_north) and not (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(q_rest), #Macro(q_act))) }
rule : { #Macro(unbind_north) } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_north) }
rule : { #Macro(bind_west)    } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_west)  and not (uniform(0, 1) < if(#Macro(is_holding_rest), #Macro(q_rest), #Macro(q_act))) }
rule : { #Macro(unbind_west)  } 0 { #Macro(is_binding_s) and #Macro(is_synapsin) and #Macro(is_unseeking_west)  }

% In 1 time unit, transition from "binding_s" to "binding_v"
rule : { #Macro(binding_v) } 1 { #Macro(is_binding_s) }

% If an adjacent is "aiming", transition immediately from "binding_v" to "aiming"
rule : { #Macro(aiming) } 0 { #Macro(is_binding_v) and #Macro(adjacent_is_aiming) }

% Vesicles bind in response to synapsins
rule : { #Macro(bind_south)   } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_south) and #Macro(south_is_binding_north) }
rule : { #Macro(unbind_south) } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_south) }
rule : { #Macro(bind_east)    } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_east)  and #Macro(east_is_binding_west)   }
rule : { #Macro(unbind_east)  } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_east)  }
rule : { #Macro(bind_north)   } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_north) and #Macro(north_is_binding_south) }
rule : { #Macro(unbind_north) } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_north) }
rule : { #Macro(bind_west)    } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_west)  and #Macro(west_is_binding_east)   }
rule : { #Macro(unbind_west)  } 0 { #Macro(is_binding_v) and #Macro(is_vesicle) and #Macro(is_looking_west)  }

% In 1 time unit, transition from "binding_v" to "aiming"
rule : { #Macro(aiming) } 1 { #Macro(is_binding_v) }

% If an adjacent is "steering", transition immediately from "aiming" to "steering"
rule : { #Macro(steering) } 0 { #Macro(is_aiming) and #Macro(adjacent_is_steering) }

% Freeze if priority is conflicting
rule : { #Macro(obey_none) } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(south_is_conflicting) and #Macro(is_binding_south) }
rule : { #Macro(obey_none) } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(east_is_conflicting)  and #Macro(is_binding_east)  }
rule : { #Macro(obey_none) } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(north_is_conflicting) and #Macro(is_binding_north) }
rule : { #Macro(obey_none) } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(west_is_conflicting)  and #Macro(is_binding_west)  }

% Copy priority and direction from an adjacent if necessary
rule : { #Macro(obey_south) } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(south_is_priority) and #Macro(is_binding_south) }
rule : { #Macro(obey_east)  } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(east_is_priority)  and #Macro(is_binding_east)  }
rule : { #Macro(obey_north) } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(north_is_priority) and #Macro(is_binding_north) }
rule : { #Macro(obey_west)  } 0 { #Macro(is_aiming) and not #Macro(adjacent_is_binding_v) and #Macro(west_is_priority)  and #Macro(is_binding_west)  }

% In 1 time unit, transition from "aiming" to "steering"
rule : { #Macro(steering) } 1 { #Macro(is_aiming) }

% If an adjacent is "moving", transition immediately from "steering" to "moving"
rule : { #Macro(moving) } 0 { #Macro(is_steering) and #Macro(adjacent_is_moving) }

% Freeze if priority is conflicting
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(south_is_conflicting) }
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(east_is_conflicting)  }
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(north_is_conflicting) }
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(west_is_conflicting)  }

% Remove priority and direction if necessary
rule : { #Macro(obey_all) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_empty) and #Macro(is_moving_south) and not #Macro(north_is_moving_south) }
rule : { #Macro(obey_all) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_empty) and #Macro(is_moving_east)  and not #Macro(west_is_moving_east)   }
rule : { #Macro(obey_all) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_empty) and #Macro(is_moving_north) and not #Macro(south_is_moving_north) }
rule : { #Macro(obey_all) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_empty) and #Macro(is_moving_west)  and not #Macro(east_is_moving_west)   }

% Freeze if heading into the membrane (shouldn't be necessary, but otherwise bugs seem to occur)
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_moving_south) and #Macro(is_particle) and #Macro(south_is_membrane) }
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_moving_east)  and #Macro(is_particle) and #Macro(east_is_membrane)  }
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_moving_north) and #Macro(is_particle) and #Macro(north_is_membrane) }
rule : { #Macro(obey_none) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(is_moving_west)  and #Macro(is_particle) and #Macro(west_is_membrane)  }

% Copy priority and direction from an adjacent if necessary
rule : { #Macro(obey_south) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(south_is_priority) and (#Macro(is_binding_south) or (#Macro(is_moving_south) and #Macro(is_particle)) or (#Macro(south_is_moving_north) and #Macro(south_is_particle))) }
rule : { #Macro(obey_east)  } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(east_is_priority)  and (#Macro(is_binding_east)  or (#Macro(is_moving_east)  and #Macro(is_particle)) or (#Macro(east_is_moving_west)   and #Macro(east_is_particle) )) }
rule : { #Macro(obey_north) } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(north_is_priority) and (#Macro(is_binding_north) or (#Macro(is_moving_north) and #Macro(is_particle)) or (#Macro(north_is_moving_south) and #Macro(north_is_particle))) }
rule : { #Macro(obey_west)  } 0 { #Macro(is_steering) and not #Macro(adjacent_is_aiming) and #Macro(west_is_priority)  and (#Macro(is_binding_west)  or (#Macro(is_moving_west)  and #Macro(is_particle)) or (#Macro(west_is_moving_east)   and #Macro(west_is_particle) )) }

% In 1 time unit, transition from "steering" to "moving"
rule : { #Macro(moving) } 1 { #Macro(is_steering) }

% In 1 time unit, translate particles, transitioning from "moving" to "starting"
rule : { #Macro(from_south) } 1 { #Macro(is_moving) and #Macro(south_is_particle) and #Macro(south_is_moving_north) }
rule : { #Macro(from_east)  } 1 { #Macro(is_moving) and #Macro(east_is_particle)  and #Macro(east_is_moving_west)   }
rule : { #Macro(from_north) } 1 { #Macro(is_moving) and #Macro(north_is_particle) and #Macro(north_is_moving_south) }
rule : { #Macro(from_west)  } 1 { #Macro(is_moving) and #Macro(west_is_particle)  and #Macro(west_is_moving_east)   }
rule : { #Macro(from_none)  } 1 { #Macro(is_moving) and #Macro(is_particle)       and #Macro(is_vacating) }
rule : { #Macro(starting)   } 1 { #Macro(is_moving) }


[axon]

type : cell
dim : (1,1)
out : out
link : out@axon(0,0) out
delay : inertial
defaultDelayTime : 1
border : wrapped
neighbors : (0,0)
localtransition : axon-rule
initialvalue : 0


[axon-rule]

rule : 1 { (#Macro(n_act) - #Macro(m_act)) * #Macro(t_cycle) } { (0,0) = 0 }
rule : 0 { #Macro(m_act) * #Macro(t_cycle) } { (0,0) = 1 }

