(define (problem roverprob1234) (:domain Rover)
(:objects
	general - Lander
	colour high_res low_res - Mode
	rover0 - Rover
	rover0store - Store
	waypoint0 waypoint1 waypoint2 waypoint3 - Waypoint
	camera0 - Camera
	objective0 objective1 objective2 - Objective ;se incluye el objetivo2 en la lista de objetos 
	)
(:init
	; como indica el enunciado la base lander que se encuentra en waypoint0 no debe ser visible por los waypoint 2 y 3
	; por ello se comentaran las lineas de codigo donde se indica que waypoint0 es visible desde el 2 y el 3
	; por logica se entiende que si desde el 2 y el 3 no se puede ver el 0 tampoco hay visibilidad en sentido contrario 
	; por lo que se cortaran las visibilidades de manera bidireccional
	(visible waypoint1 waypoint0)
	(visible waypoint0 waypoint1)
	; (visible waypoint2 waypoint0)
	; (visible waypoint0 waypoint2)
	(visible waypoint2 waypoint1)
	(visible waypoint1 waypoint2)
	; (visible waypoint3 waypoint0)
	; (visible waypoint0 waypoint3)
	(visible waypoint3 waypoint1)
	(visible waypoint1 waypoint3)
	(visible waypoint3 waypoint2)
	(visible waypoint2 waypoint3)
	(at_soil_sample waypoint0)
	(at_rock_sample waypoint1)
	(at_soil_sample waypoint2)
	(at_rock_sample waypoint2)
	(at_soil_sample waypoint3)
	(at_rock_sample waypoint3)
	(at_lander general waypoint0)
	(channel_free general)
	(at rover0 waypoint3)
	(available rover0)
	(store_of rover0store rover0)
	(empty rover0store)
	(equipped_for_soil_analysis rover0)
	(equipped_for_rock_analysis rover0)
	(equipped_for_imaging rover0)
	(can_traverse rover0 waypoint3 waypoint0)
	(can_traverse rover0 waypoint0 waypoint3)
	(can_traverse rover0 waypoint3 waypoint1) 
	(can_traverse rover0 waypoint1 waypoint3) ; esta linea y la siguiente indican los puntos accesibles por el rover desde waypoint1
	(can_traverse rover0 waypoint1 waypoint2)
	(can_traverse rover0 waypoint2 waypoint1)
	(on_board camera0 rover0)
	(calibration_target camera0 objective1)
	(calibration_target camera0 objective2) ; se le da a objetivo2 la posibilidad de calibrarse dedsde camera0
	(supports camera0 colour)
	(supports camera0 high_res)
	(visible_from objective0 waypoint0)
	(visible_from objective0 waypoint1)
	(visible_from objective0 waypoint2)
	(visible_from objective0 waypoint3)
	(visible_from objective1 waypoint0)
	(visible_from objective1 waypoint1)
	(visible_from objective1 waypoint2)
	(visible_from objective1 waypoint3)
	; El objetivo2 es visible desde una ubicacion accesible por rover0 desde waypoint1
	; desde waypoint1 el rover0 tiene accesibles waypoint2 y waypoint3
	(visible_from objective2 waypoint2)
	(visible_from objective2 waypoint3)
)

(:goal (and
(communicated_soil_data waypoint2)
(communicated_rock_data waypoint3)
(communicated_image_data objective1 high_res)
(communicated_image_data objective2 high_res) ; se comunica la imagen de objetivo2 en alta resolucion
(communicated_image_data objective2 colour) ; se comunica la imagen de objetivo2 en color
	)
)
)
