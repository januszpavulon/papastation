/mob/living/silicon/pai/say(msg)
	if(silence_time)
		src << "<span class='warning'>Obwody komunikacyjne nadal nie dzialaja.</span>"
	else
		..(msg)

/mob/living/silicon/pai/binarycheck()
	return 0
