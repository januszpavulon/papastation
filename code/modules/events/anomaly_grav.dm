/datum/round_event_control/anomaly/anomaly_grav
	name = "Anomaly: Gravitational"
	typepath = /datum/round_event/anomaly/anomaly_grav
	max_occurrences = 5
	weight = 20

/datum/round_event/anomaly/anomaly_grav
	startWhen = 3
	announceWhen = 20
	endWhen = 120


/datum/round_event/anomaly/anomaly_grav/announce()
	priority_announce("Anomalia grawitacyjna wykryta na skanerach. Prawdopodobna lokalizacja: [impact_area.name].", "Anomalia")

/datum/round_event/anomaly/anomaly_grav/start()
	var/turf/T = safepick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/grav(T)