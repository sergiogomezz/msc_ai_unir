(define (domain Rover4)
(:requirements :typing :strips :disjunctive-preconditions :conditional-effects)
(:types rover waypoint store camera mode lander objective)

(:predicates (at ?x - rover ?y - waypoint) 
             (at_lander ?x - lander ?y - waypoint)
             (can_traverse ?r - rover ?x - waypoint ?y - waypoint)
	     (equipped_for_soil_analysis ?r - rover)
             (equipped_for_rock_analysis ?r - rover)
             (equipped_for_imaging ?r - rover)
             (empty ?s - store)
             (have_rock_analysis ?r - rover ?w - waypoint)
             (have_soil_analysis ?r - rover ?w - waypoint)
             (full ?s - store)
	     (calibrated ?c - camera ?r - rover) 
	     (supports ?c - camera ?m - mode)
             (available ?r - rover)
             (visible ?w - waypoint ?p - waypoint)
             (have_image ?r - rover ?o - objective ?m - mode)
             (communicated_soil_data ?w - waypoint)
             (communicated_rock_data ?w - waypoint)
             (communicated_image_data ?o - objective ?m - mode)
	     (at_soil_sample ?w - waypoint)
	     (at_rock_sample ?w - waypoint)
             (visible_from ?o - objective ?w - waypoint)
	     (store_of ?s - store ?r - rover)
	     (calibration_target ?i - camera ?o - objective)
	     (on_board ?i - camera ?r - rover)
	     (channel_free ?l - lander)
            ; posibles estados de carga de los rover Son cuatro niveles
            (full_battery ?r - rover)
            (half_battery ?r - rover)
            (low_battery ?r - rover)
            (empty_battery ?r - rover)

)



; se modifica la accion navigate teniendo en cuenta la cuestion de la bateria
; las precondiciones se modifican para que la accion no se ejecute si la bateria esta vacia
; los efectos se modifican para que la bateria disminuya al nivel inmediatamente inferior del actual
(:action navigate
:parameters (?x - rover ?y - waypoint ?z - waypoint) 
:precondition (and (can_traverse ?x ?y ?z) (available ?x) (at ?x ?y) 
                (visible ?y ?z) (or (low_battery ?x) (full_battery ?x) (half_battery ?x)) ; solamente se podra inicializar la accion si la bateria esta llena, a medias o baja
	    )
:effect (and (not (at ?x ?y)) (at ?x ?z)
       (when (full_battery ?x)(and (not(full_battery ?x)) (half_battery ?x)))
       (when (half_battery ?x)(and (not(half_battery ?x)) (low_battery ?x)))
       (when (low_battery ?x)(and (not(low_battery ?x)) (empty_battery ?x)))
		)
)


; implementacion de la accion de recarga
; se establece como parametros un rover, el lander y un waypoint
; las precondiciones indican que el tanto el rover como el lander debe estar en el waypoint indicado y que la bateria no debe estar llena ya que no tendria sentido recargala
; los efectos indican que el estado de la bateria deja de ser cualquiera que sea y pasa a ser lleno
(:action charge
    :parameters (?x - rover ?l - lander ?p - waypoint)
    :precondition (and (at ?x ?p) (at_lander ?l ?p) 
                     (or (low_battery ?x) (empty_battery ?x) (half_battery ?x))) 
    :effect (and (when (low_battery ?x) (not (low_battery ?x)))
        (when (empty_battery ?x) (not (empty_battery ?x)))
        (when (half_battery ?x) (not (half_battery ?x)))
        (full_battery ?x)
    )
)


(:action sample_soil
:parameters (?x - rover ?s - store ?p - waypoint)
:precondition (and (at ?x ?p) (at_soil_sample ?p) (equipped_for_soil_analysis ?x) (store_of ?s ?x) (empty ?s)
		)
:effect (and (not (empty ?s)) (full ?s) (have_soil_analysis ?x ?p) (not (at_soil_sample ?p))
		)
)

(:action sample_rock
:parameters (?x - rover ?s - store ?p - waypoint)
:precondition (and (at ?x ?p) (at_rock_sample ?p) (equipped_for_rock_analysis ?x) (store_of ?s ?x)(empty ?s)
		)
:effect (and (not (empty ?s)) (full ?s) (have_rock_analysis ?x ?p) (not (at_rock_sample ?p))
		)
)

(:action drop
:parameters (?x - rover ?y - store)
:precondition (and (store_of ?y ?x) (full ?y)
		)
:effect (and (not (full ?y)) (empty ?y)
	)
)

(:action calibrate
 :parameters (?r - rover ?i - camera ?t - objective ?w - waypoint)
 :precondition (and (equipped_for_imaging ?r) (calibration_target ?i ?t) (at ?r ?w) (visible_from ?t ?w)(on_board ?i ?r)
		)
 :effect (calibrated ?i ?r) 
)




(:action take_image
 :parameters (?r - rover ?p - waypoint ?o - objective ?i - camera ?m - mode)
 :precondition (and (calibrated ?i ?r)
			 (on_board ?i ?r)
                      (equipped_for_imaging ?r)
                      (supports ?i ?m)
			  (visible_from ?o ?p)
                     (at ?r ?p)
               )
 :effect (and (have_image ?r ?o ?m)(not (calibrated ?i ?r))
		)
)


(:action communicate_soil_data
 :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
 :precondition (and (at ?r ?x)(at_lander ?l ?y)(have_soil_analysis ?r ?p) 
                   (visible ?x ?y)(available ?r)(channel_free ?l)
            )
 :effect (and (not (available ?r))(not (channel_free ?l))(channel_free ?l)
		(communicated_soil_data ?p)(available ?r)
	)
)

(:action communicate_rock_data
 :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
 :precondition (and (at ?r ?x)(at_lander ?l ?y)(have_rock_analysis ?r ?p)
                   (visible ?x ?y)(available ?r)(channel_free ?l)
            )
 :effect (and (not (available ?r))(not (channel_free ?l))(channel_free ?l)(communicated_rock_data ?p)(available ?r)
          )
)


(:action communicate_image_data
 :parameters (?r - rover ?l - lander ?o - objective ?m - mode ?x - waypoint ?y - waypoint)
 :precondition (and (at ?r ?x)(at_lander ?l ?y)(have_image ?r ?o ?m)(visible ?x ?y)(available ?r)(channel_free ?l)
            )
 :effect (and (not (available ?r))(not (channel_free ?l))(channel_free ?l)(communicated_image_data ?o ?m)(available ?r)
          )
)

)
