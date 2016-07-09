/datum/round_event_control/communications_blackout
	name = "Communications Blackout"
	typepath = /datum/round_event/communications_blackout
	weight = 30

/datum/round_event/communications_blackout
	announceWhen	= 1

/datum/round_event/communications_blackout/announce()
	var/alert = pick(	"Potezna fala wiatru slonecznego wykryta. Tymczasowa awaria systemu telekomunikacji nieuchronna. Prosze skontaktowac*%fj00)`5vc-BZZT", \
						"Potezna fala wiatru slonecznego wykryta. Tymczasowa awaria systemu telekomunik*3mga;b4;'1v¬-BZZZT", \
						"Potezna fala wiatru slonecznego wykryta. Tymczasowa awa#MCi46:5.;@63-BZZZZT", \
						"Potezna fala wiatru slonecz'fZ\\kg5_0-BZZZZZT", \
						"Potezna fa:%£ MCayj^j<.3-BZZZZZZT", \
						"#4nd%;f4y6,>£%-BZZZZZZZT")

	for(var/mob/living/silicon/ai/A in ai_list)	//AIs are always aware of communication blackouts.
		A << "<br><span class='warning'><b>[alert]</b></span><br>"

	if(prob(30))	//most of the time, we don't want an announcement, so as to allow AIs to fake blackouts.
		priority_announce(alert)


/datum/round_event/communications_blackout/start()
	for(var/obj/machinery/telecomms/T in telecomms_list)
		T.emp_act(1)
