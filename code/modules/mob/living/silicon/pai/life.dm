/mob/living/silicon/pai/Life()
	if (src.stat == DEAD)
		return
	if(src.cable)
		if(get_dist(src, src.cable) > 1)
			var/turf/T = get_turf(src.loc)
			T.visible_message("<span class='warning'>[src.cable] nagle wraca do swojego poczatkowego polozenia.</span>", "<span class='italics'>Slyszysz klikniecie i dzwiek zwijanego szybko kabla.</span>")
			qdel(src.cable)
			cable = null
	if(silence_time)
		if(world.timeofday >= silence_time)
			silence_time = null
			src << "<font color=green>Systemy komunikacji dzialaja ponownie.</font>"

/mob/living/silicon/pai/updatehealth()
	if(status_flags & GODMODE)
		return
	health = maxHealth - getBruteLoss() - getFireLoss()
	update_stat()
