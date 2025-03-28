(define (problem roverprob1234) (:domain Rover)
(:objects
	general - Lander
	colour high_res low_res - Mode
	rover0 rover1 - Rover ; se agrega a la lista de objetos el rover1
	rover0store - Store ; como el rover1 no tiene capacidad para tomar muestras de suelo ni rocas no es necesario dotarle de almacenamiento
	waypoint0 waypoint1 waypoint2 waypoint3 - Waypoint
	camera0 camera1 - Camera ; como camera0 ya esta a bordo del rover0 se crea una camera1 para el rover1
	objective0 objective1 - Objective
	)
(:init 
	(visible waypoint1 waypoint0)
	(visible waypoint0 waypoint1)
	(visible waypoint2 waypoint0)
	(visible waypoint0 waypoint2)
	(visible waypoint2 waypoint1)
	(visible waypoint1 waypoint2)
	(visible waypoint3 waypoint0)
	(visible waypoint0 waypoint3)
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
	(at rover1 waypoint2) ; como se indica el rover1 se situa inicialmente en waypoint2
	(available rover0)
	(available rover1)
	(store_of rover0store rover0)
	(empty rover0store)
	(equipped_for_soil_analysis rover0)
	(equipped_for_rock_analysis rover0)
	(equipped_for_imaging rover0)
	(equipped_for_imaging rover1) ; se indica que rover1 tiene capacidad para tomar imagenes
	; en el enunciado no se especifica nada acerca de los movimientos de rover1 por lo que no se agregaran
	(can_traverse rover0 waypoint3 waypoint0)
	(can_traverse rover0 waypoint0 waypoint3)
	(can_traverse rover0 waypoint3 waypoint1)
	(can_traverse rover0 waypoint1 waypoint3)
	(can_traverse rover0 waypoint1 waypoint2)
	(can_traverse rover0 waypoint2 waypoint1)
	(on_board camera0 rover0)
	(on_board camera1 rover1) ; se indica que camera1 va a bordo del rover1
	(calibration_target camera0 objective1)
	(calibration_target camera1 objective1) ; el objetivo1 se agrega como objetivo de calibracion de la nueva camara
	(supports camera0 colour)
	(supports camera0 high_res)
	(supports camera1 high_res) ; es necesario atendiendo a las precondiciones de take_image del dominio darle al menos un modo a la camara
	(visible_from objective0 waypoint0)
	(visible_from objective0 waypoint1)
	(visible_from objective0 waypoint2)
	(visible_from objective0 waypoint3)
	(visible_from objective1 waypoint0)
	(visible_from objective1 waypoint1)
	(visible_from objective1 waypoint2)
	; (visible_from objective1 waypoint3) ; modificacion del problema para el apartado 3.2 - el obj1 ya no es visible desde el punto base del rover0
)

; no se solicita modificacion en el estado meta
(:goal (and
(communicated_soil_data waypoint2)
(communicated_rock_data waypoint3)
(communicated_image_data objective1 high_res)
	)
)
)
