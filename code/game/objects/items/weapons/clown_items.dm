/* Clown Items
 * Contains:
 *		Soap
 *		Bike Horns
 *		Air Horns
 */

/*
 * Soap
 */

/obj/item/weapon/soap
	name = "soap"
	desc = "A cheap bar of soap. Doesn't smell."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "soap"
	w_class = 1
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	var/cleanspeed = 50 //slower than mop

/obj/item/weapon/soap/nanotrasen
	desc = "A Nanotrasen brand bar of soap. Smells of plasma."
	icon_state = "soapnt"

/obj/item/weapon/soap/homemade
	desc = "A homemade bar of soap. Smells of... well...."
	icon_state = "soapgibs"
	cleanspeed = 45 // a little faster to reward chemists for going to the effort

/obj/item/weapon/soap/deluxe
	desc = "A deluxe Waffle Co. brand bar of soap. Smells of high-class luxury."
	icon_state = "soapdeluxe"
	cleanspeed = 40 //same speed as mop because deluxe -- captain gets one of these

/obj/item/weapon/soap/syndie
	desc = "An untrustworthy bar of soap made of strong chemical agents that dissolve blood faster."
	icon_state = "soapsyndie"
	cleanspeed = 10 //much faster than mop so it is useful for traitors who want to clean crime scenes

/obj/item/weapon/soap/suicide_act(mob/user)
	user.say(";FFFFFFFFFFFFFFFFUUUUUUUDGE!!")
	user.visible_message("<span class='suicide'>[user] lifts the [src.name] to their mouth and gnaws on it furiously, producing a thick froth! They'll never get that BB gun now!")
	PoolOrNew(/obj/effect/particle_effect/foam, loc)
	return (TOXLOSS)

/obj/item/weapon/soap/Crossed(AM as mob|obj)
	if (istype(AM, /mob/living/carbon))
		var/mob/living/carbon/M = AM
		M.slip(4, 2, src)

/obj/item/weapon/soap/afterattack(atom/target, mob/user, proximity)
	if(!proximity || !check_allowed_items(target))
		return
	//I couldn't feasibly  fix the overlay bugs caused by cleaning items we are wearing.
	//So this is a workaround. This also makes more sense from an IC standpoint. ~Carn
	if(user.client && (target in user.client.screen))
		user << "<span class='warning'>You need to take that [target.name] off before cleaning it!</span>"
	else if(istype(target,/obj/effect/decal/cleanable))
		user.visible_message("[user] begins to scrub \the [target.name] out with [src].", "<span class='warning'>You begin to scrub \the [target.name] out with [src]...</span>")
		if(do_after(user, src.cleanspeed, target = target))
			user << "<span class='notice'>You scrub \the [target.name] out.</span>"
			qdel(target)
	else if(ishuman(target) && user.zone_selected == "mouth")
		user.visible_message("<span class='warning'>\the [user] washes \the [target]'s mouth out with [src.name]!</span>", "<span class='notice'>You wash \the [target]'s mouth out with [src.name]!</span>") //washes mouth out with soap sounds better than 'the soap' here
		return
	else if(istype(target, /obj/structure/window))
		user.visible_message("[user] begins to clean \the [target.name] with [src]...", "<span class='notice'>You begin to clean \the [target.name] with [src]...</span>")
		if(do_after(user, src.cleanspeed, target = target))
			user << "<span class='notice'>You clean \the [target.name].</span>"
			target.color = initial(target.color)
			target.SetOpacity(initial(target.opacity))
	else
		user.visible_message("[user] begins to clean \the [target.name] with [src]...", "<span class='notice'>You begin to clean \the [target.name] with [src]...</span>")
		if(do_after(user, src.cleanspeed, target = target))
			user << "<span class='notice'>You clean \the [target.name].</span>"
			var/obj/effect/decal/cleanable/C = locate() in target
			qdel(C)
			target.clean_blood()
	return


/*
 * Bike Horns
 */


/obj/item/weapon/bikehorn
	name = "bike horn"
	desc = "A horn off of a bicycle."
	icon = 'icons/obj/items.dmi'
	icon_state = "bike_horn"
	item_state = "bike_horn"
	throwforce = 0
	hitsound = null //To prevent tap.ogg playing, as the item lacks of force
	w_class = 1
	throw_speed = 3
	throw_range = 7
	attack_verb = list("HONKED")
	var/spam_flag = 0
	var/honksound = 'sound/items/bikehorn.ogg'
	var/cooldowntime = 20

/obj/item/weapon/bikehorn/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] solemnly points the horn at \his temple! It looks like \he's trying to commit suicide..</span>")
	playsound(src.loc, honksound, 50, 1)
	return (BRUTELOSS)

/obj/item/weapon/bikehorn/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!spam_flag)
		playsound(loc, honksound, 50, 1, -1) //plays instead of tap.ogg!
	return ..()

/obj/item/weapon/bikehorn/attack_self(mob/user)
	if(!spam_flag)
		spam_flag = 1
		playsound(src.loc, honksound, 50, 1)
		src.add_fingerprint(user)
		spawn(cooldowntime)
			spam_flag = 0
	return

/obj/item/weapon/bikehorn/Crossed(mob/living/L)
	if(isliving(L))
		playsound(loc, honksound, 50, 1, -1)
	..()

/obj/item/weapon/bikehorn/airhorn
	name = "air horn"
	desc = "Damn son, where'd you find this?"
	icon_state = "air_horn"
	honksound = 'sound/items/AirHorn2.ogg'
	cooldowntime = 50

/obj/item/vuvuzela
	name = "vuvuzela"
	desc = "A loud horn made popular at soccer games-BZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
	icon = 'icons/obj/instruments.dmi'
	icon_state = "vuvuzela"
	throwforce = 3
	var/spam_flag = 0
	var/sound_vuvuzela = 'sound/items/vuvuzela.ogg'
	var/cooldowntime = 70

/obj/item/vuvuzela/attack_self(mob/user as mob)
	if (spam_flag == 0)
		spam_flag = 1
		user.visible_message("<b><span style=\"color:red\">BZZZZZZZZZZZZZZZZZZZ!.</span></b>")
		playsound(get_turf(src), pick(src.sound_vuvuzela), 100, 1)
		src.add_fingerprint(user)
		spawn(cooldowntime)
			spam_flag = 0
	return


/obj/item/saxophone
	name = "saxophone"
	desc = "NEVER GONNA DANCE AGAIN, GUILTY FEET HAVE GOT NO RHYTHM"
	icon = 'icons/obj/instruments.dmi'
	icon_state = "sax" // temp
	item_state = "sax"
	force = 1
	throwforce = 5
	var/spam_flag = 0
	var/list/sounds_sax = list('sound/items/sax.ogg', 'sound/items/sax2.ogg','sound/items/sax3.ogg','sound/items/sax4.ogg','sound/items/sax5.ogg')
	var/cooldowntime = 100

/obj/item/saxophone/attack_self(mob/user as mob)
	if (spam_flag == 0)
		spam_flag = 1
		user.visible_message("<B>[user]</B> lays down a [pick("sexy", "sensuous", "libidinous","spicy","flirtatious","salacious","sizzling","carnal","hedonistic")] riff on \his saxophone!")
		playsound(get_turf(src), pick(src.sounds_sax), 100, 1)
		src.add_fingerprint(user)
		spawn(cooldowntime)
			spam_flag = 0
	return

/obj/item/bagpipe
	name = "bagpipe"
	desc = "Almost as much of a windbag as the Captain."
	icon = 'icons/obj/instruments.dmi'
	icon_state = "bagpipe" // temp
	item_state = "bagpipe"
	force = 1
	throwforce = 5
	var/spam_flag = 0
	var/list/sounds_bagpipe = list('sound/items/bagpipe.ogg', 'sound/items/bagpipe2.ogg','sound/items/bagpipe3.ogg')
	var/cooldowntime = 100

/obj/item/bagpipe/attack_self(mob/user as mob)
	if (spam_flag == 0)
		spam_flag = 1
		user.visible_message("<B>[user]</B> plays a [pick("patriotic", "rowdy", "wee","grand","free","Glaswegian","sizzling","carnal","hedonistic")] tune on \his bagpipe!")
		playsound(get_turf(src), pick(src.sounds_bagpipe), 50, 1)
		src.add_fingerprint(user)
		spawn(cooldowntime)
			spam_flag = 0
	return