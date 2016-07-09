/mob/living/carbon/human/examine(mob/user)

	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))

	// crappy hacks because you can't do \his[src] etc. I'm sorry this proc is so unreadable, blame the text macros :<
	var/t_He = "It" //capitalised for use at the start of each line.
	var/t_his = "its"
	var/t_him = "it"
	var/t_has = "has"
	var/t_is = "is"
	var/t_is2 = "jest"
	var/t_p = "popelnil"
	var/t_p2 = "pokryte"
	var/t_p3 = "pijane"

	var/msg = "<span class='info'>*---------*\nTo jest "

	if( (slot_w_uniform in obscured) && skipface ) //big suits/masks/helmets make it hard to tell their gender
		t_He = "Ono"
		t_his = "jego"
		t_him = "them"
		t_has = "have"
		t_is = "are"
		t_is2 = "jest"
		t_p = "popelnil"
		t_p2 = "pokryte"
		t_p3 = "pijane"
	else
		switch(gender)
			if(MALE)
				t_He = "On"
				t_his = "jego"
				t_him = "niego"
				t_p = "popelnil"
				t_p2 = "pokryty"
				t_p3 = "pijany"
			if(FEMALE)
				t_He = "Ona"
				t_his = "jej"
				t_him = "niej"
				t_p = "popelnila"
				t_p2 = "pokryta"
				t_p3 = "pijana"

	msg += "<EM>[src.name]</EM>!\n"

	//uniform
	if(w_uniform && !(slot_w_uniform in obscured))
		//Ties
		var/tie_msg
		if(istype(w_uniform,/obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.hastie)
				tie_msg += " with \icon[U.hastie]  [U.hastie]"

		if(w_uniform.blood_DNA)
			msg += "<span class='warning'>[t_He] ma na sobie \icon[w_uniform] zakrwawiony [w_uniform.name][tie_msg]!</span>\n"
		else
			msg += "[t_He] ma na sobie \icon[w_uniform] [w_uniform][tie_msg].\n"

	//head
	if(head)
		if(head.blood_DNA)
			msg += "<span class='warning'>[t_He] ma na glowie \icon[head] zakrwawiony [head.name]!</span>\n"
		else
			msg += "[t_He] ma na glowie \icon[head] [head].\n"

	//suit/armor
	if(wear_suit)
		if(wear_suit.blood_DNA)
			msg += "<span class='warning'>[t_He] ma na sobie \icon[wear_suit] zakrwawiony [wear_suit.name]!</span>\n"
		else
			msg += "[t_He] ma na sobie \icon[wear_suit] [wear_suit].\n"

		//suit/armor storage
		if(s_store)
			if(s_store.blood_DNA)
				msg += "<span class='warning'>[t_He] trzyma \icon[s_store] zakrwawiony [s_store.name] na [t_his] [wear_suit.name]!</span>\n"
			else
				msg += "[t_He] trzyma \icon[s_store] [s_store] na [t_his] [wear_suit.name].\n"

	//back
	if(back)
		if(back.blood_DNA)
			msg += "<span class='warning'>[t_He] nosi na plecach \icon[back] zakrwawiony [back].</span>\n"
		else
			msg += "[t_He] nosi na plecach \icon[back] [back].\n"

	//left hand
	if(l_hand && !(l_hand.flags&ABSTRACT))
		if(l_hand.blood_DNA)
			msg += "<span class='warning'>[t_He] trzyma w lewej rece \icon[l_hand] zakrwawiony [l_hand.name]!</span>\n"
		else
			msg += "[t_He] trzyma w lewej rece \icon[l_hand] [l_hand].\n"

	//right hand
	if(r_hand && !(r_hand.flags&ABSTRACT))
		if(r_hand.blood_DNA)
			msg += "<span class='warning'>[t_He] trzyma w prawej rece \icon[r_hand] zakrwawiony [r_hand.name]!</span>\n"
		else
			msg += "[t_He] trzyma w prawej rece \icon[r_hand] [r_hand].\n"

	//gloves
	if(gloves && !(slot_gloves in obscured))
		if(gloves.blood_DNA)
			msg += "<span class='warning'>[t_He] nosi na rekach \icon[gloves] zakrwawiony [gloves.name]!</span>\n"
		else
			msg += "[t_He] nosi na rekach \icon[gloves] [gloves].\n"
	else if(blood_DNA)
		msg += "<span class='warning'>[t_He] ma zakrwawione rece!</span>\n"

	//handcuffed?

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/weapon/restraints/handcuffs/cable))
			msg += "<span class='warning'>[t_He] ma \icon[handcuffed] rece skrepowane kablem!</span>\n"
		else
			msg += "<span class='warning'>[t_He] ma \icon[handcuffed] rece zakute kajdankami!</span>\n"

	//belt
	if(belt)
		if(belt.blood_DNA)
			msg += "<span class='warning'>[t_He] ma na pasie \icon[belt] zakrwawiony [belt.name]!</span>\n"
		else
			msg += "[t_He] ma na pasie \icon[belt] [belt].\n"

	//shoes
	if(shoes && !(slot_shoes in obscured))
		if(shoes.blood_DNA)
			msg += "<span class='warning'>[t_He] nosi na nogach \icon[shoes] zakrwawione [shoes.name]!</span>\n"
		else
			msg += "[t_He] nosi na nogach \icon[shoes] [shoes].\n"

	//mask
	if(wear_mask && !(slot_wear_mask in obscured))
		if(wear_mask.blood_DNA)
			msg += "<span class='warning'>[t_He] ma na twarzy \icon[wear_mask] zakrwawiona [wear_mask.name]!</span>\n"
		else
			msg += "[t_He] ma na twarzy \icon[wear_mask] [wear_mask].\n"

	//eyes
	if(glasses && !(slot_glasses in obscured))
		if(glasses.blood_DNA)
			msg += "<span class='warning'>[t_He] ma na oczach \icon[glasses] zakrwawione [glasses]!</span>\n"
		else
			msg += "[t_He] ma na oczach \icon[glasses] [glasses].\n"

	//ears
	if(ears && !(slot_ears in obscured))
		msg += "[t_He] ma na uszach \icon[ears] [ears].\n"

	//ID
	if(wear_id)
		/*var/id
		if(istype(wear_id, /obj/item/device/pda))
			var/obj/item/device/pda/pda = wear_id
			id = pda.owner
		else if(istype(wear_id, /obj/item/weapon/card/id)) //just in case something other than a PDA/ID card somehow gets in the ID slot :[
			var/obj/item/weapon/card/id/idcard = wear_id
			id = idcard.registered_name
		if(id && (id != real_name) && (get_dist(src, user) <= 1) && prob(10))
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[wear_id]  [wear_id] yet something doesn't seem right...</span>\n"
		else*/
		msg += "[t_He] nosi \icon[wear_id] [wear_id].\n"

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			msg += "<span class='warning'><B>[t_He] ma straszne konwulsje!</B></span>\n"
		if(200 to 300)
			msg += "<span class='warning'>[t_He] ma drgawki.</span>\n"
		if(100 to 200)
			msg += "<span class='warning'>[t_He] ma lekkie drgawki.</span>\n"

	if(gender_ambiguous) //someone fucked up a gender reassignment surgery
		if (gender == MALE)
			msg += "[t_He] nie przypomina mezczyzny.\n"
		else
			msg += "[t_He] nie przypomina kobiety.\n"

	var/appears_dead = 0
	if(stat == DEAD || (status_flags & FAKEDEATH))
		appears_dead = 1
		if(getorgan(/obj/item/organ/internal/brain))//Only perform these checks if there is no brain
			if(suiciding)
				msg += "<span class='warning'>Wyglada na to ze [t_p] samobojstwo. Nie ma zadnych szans na ratunek.</span>\n"
			msg += "<span class='deadsay'>[t_his] cialo jest blade i zimne, brak jakichkowiek oznak zycia..."
			if(!key)
				var/foundghost = 0
				if(mind)
					for(var/mob/dead/observer/G in player_list)
						if(G.mind == mind)
							foundghost = 1
							if (G.can_reenter_corpse == 0)
								foundghost = 0
							break
				if(!foundghost)
					msg += " a [t_his] dusza opuscila cialo"
			msg += "...</span>\n"
		else//Brain is gone, doesn't matter if they are AFK or present
			msg += "<span class='deadsay'>Wyglada na to ze [t_his] mozg zniknal...</span>\n"

	var/temp = getBruteLoss() //no need to calculate each of these twice

	msg += "<span class='warning'>"

	if(temp)
		if(temp < 30)
			msg += "[t_He] ma kilka siniakow.\n"
		else
			msg += "<B>[t_He] ma duzo siniakow!</B>\n"

	temp = getFireLoss()
	if(temp)
		if(temp < 30)
			msg += "[t_He] ma lekkie oparzenia.\n"
		else
			msg += "<B>[t_He] ma powazne oparzenia!</B>\n"

	temp = getCloneLoss()
	if(temp)
		if(temp < 30)
			msg += "[t_He] ma lekkie obrazenia genetyczne.\n"
		else
			msg += "<B>[t_He] ma powazne obrazenia genetyczne!</B>\n"


	for(var/obj/item/organ/limb/L in organs)
		for(var/obj/item/I in L.embedded_objects)
			msg += "<B>[t_He] ma \icon[I] [I] w jej [t_his] [L.getDisplayName()]!</B>\n"


	if(fire_stacks > 0)
		msg += "[t_He] jest [t_p2] czyms latwopalnym.\n"
	if(fire_stacks < 0)
		msg += "[t_He] jest [t_p2] jakas ciecza.\n"


	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] jest niedozywiona.\n"
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy.\n"
		else
			msg += "[t_He] jest calkiem gruby.\n"

	if(pale)
		msg += "[t_He] ma blada skore.\n"

	if(bleedsuppress)
		msg += "[t_He] ma na sobie jakis bandaz.\n"
	if(blood_max)
		if(reagents.has_reagent("heparin"))
			msg += "<b>[t_He] ma powazny krwotok!</b>\n"
		else
			msg += "<B>[t_He] krwawi!</B>\n"

	if(reagents.has_reagent("teslium"))
		msg += "[t_He] swieci na niebiesko!\n"

	if(drunkenness && !skipface && stat != DEAD) //Drunkenness
		switch(drunkenness)
			if(11 to 21)
				msg += "[t_He] jest lekko [t_p3].\n"
			if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
				msg += "[t_He] jest [t_p3].\n"
			if(41.01 to 51)
				msg += "[t_He] jest calkiem [t_p3] a [t_his] oddech ma zapach alkoholu.\n"
			if(51.01 to 61)
				msg += "[t_He] jest bardzo [t_p3] a [t_his] ruchy sa ograniczone.\n"
			if(61.01 to 91)
				msg += "[t_He] jest strasznie [t_p3].\n"
			if(91.01 to INFINITY)
				msg += "[t_He] ma obrzygane ubranie, smierdzi i jest strasznie [t_p3].\n"

	msg += "</span>"

	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			msg += "[t_He] nie reaguje na nic co sie dzieje dookola [t_him] i wyglada jakby spal.\n"
		else if(getBrainLoss() >= 60)
			msg += "[t_He] ma glupi wyraz twarzy.\n"

		if(getorgan(/obj/item/organ/internal/brain))
			if(istype(src,/mob/living/carbon/human/interactive))
				msg += "<span class='deadsay'>[t_He] [t_is] appears to be some sort of sick automaton, [t_his] eyes are glazed over and [t_his] mouth is slightly agape.</span>\n"
			else if(!key)
				msg += "<span class='deadsay'>[t_He] wyglada na osobe katatoniczna. Wszelki ratunek jest niemozliwy.</span>\n"
			else if(!client)
				msg += "[t_He] wyglada na osobe wylaczona, patrzy sie ciagle przed siebie...\n"

		if(digitalcamo)
			msg += "[t_He] [t_is] moving [t_his] body in an unnatural and blatantly inhuman manner.\n"

	if(!skipface && is_thrall(src) && in_range(user,src))
		msg += "Their features seem unnaturally tight and drawn.\n"

	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/internal/cyberimp/eyes/hud/CIH = H.getorgan(/obj/item/organ/internal/cyberimp/eyes/hud)
		if(istype(H.glasses, /obj/item/clothing/glasses/hud) || CIH)
			var/perpname = get_face_name(get_id_name(""))
			if(perpname)
				var/datum/data/record/R = find_record("name", perpname, data_core.general)
				if(R)
					msg += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]<br>"
					msg += "<a href='?src=\ref[src];hud=1;photo_front=1'>\[Front photo\]</a> "
					msg += "<a href='?src=\ref[src];hud=1;photo_side=1'>\[Side photo\]</a><br>"
				if(istype(H.glasses, /obj/item/clothing/glasses/hud/health) || istype(CIH,/obj/item/organ/internal/cyberimp/eyes/hud/medical))
					var/implant_detect
					for(var/obj/item/organ/internal/cyberimp/CI in internal_organs)
						if(CI.status == ORGAN_ROBOTIC)
							implant_detect += "[name] is modified with a [CI.name].<br>"
					if(implant_detect)
						msg += "Detected cybernetic modifications:<br>"
						msg += implant_detect
					if(R)
						var/health = R.fields["p_stat"]
						msg += "<a href='?src=\ref[src];hud=m;p_stat=1'>\[[health]\]</a>"
						health = R.fields["m_stat"]
						msg += "<a href='?src=\ref[src];hud=m;m_stat=1'>\[[health]\]</a><br>"
					R = find_record("name", perpname, data_core.medical)
					if(R)
						msg += "<a href='?src=\ref[src];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"


				if(istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(CIH,/obj/item/organ/internal/cyberimp/eyes/hud/security))
					if(!user.stat && user != src)
					//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
						var/criminal = "None"

						R = find_record("name", perpname, data_core.security)
						if(R)
							criminal = R.fields["criminal"]

						msg += "<span class='deptradio'>Criminal status:</span> <a href='?src=\ref[src];hud=s;status=1'>\[[criminal]\]</a>\n"
						msg += "<span class='deptradio'>Security record:</span> <a href='?src=\ref[src];hud=s;view=1'>\[View\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;add_crime=1'>\[Add crime\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;view_comment=1'>\[View comment log\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;add_comment=1'>\[Add comment\]</a>\n"

	msg += "*---------*</span>"

	user << msg
