/obj/structure/sign/barsign // All Signs are 64 by 32 pixels, they take two tiles
	name = "Bar Sign"
	desc = "A bar sign with no writing on it"
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "empty"
	req_access = list(access_bar)
	var/list/barsigns=list()
	var/list/hiddensigns
	var/broken = 0
	var/emagged = 0
	var/state = 0
	var/prev_sign = ""
	var/panel_open = 0




/obj/structure/sign/barsign/New()
	..()


//filling the barsigns list
	for(var/bartype in subtypesof(/datum/barsign))
		var/datum/barsign/signinfo = new bartype
		if(!signinfo.hidden)
			barsigns += signinfo


//randomly assigning a sign
	set_sign(pick(barsigns))



/obj/structure/sign/barsign/proc/set_sign(datum/barsign/sign)
	if(!istype(sign))
		return
	icon_state = sign.icon
	name = sign.name
	if(sign.desc)
		desc = sign.desc
	else
		desc = "It displays \"[name]\"."



/obj/structure/sign/barsign/attack_ai(mob/user)
	return src.attack_hand(user)



/obj/structure/sign/barsign/attack_hand(mob/user)
	if (!src.allowed(user))
		user << "<span class='info'>Access denied.</span>"
		return
	if (broken)
		user << "<span class ='danger'>The controls seem unresponsive.</span>"
		return
	pick_sign()




/obj/structure/sign/barsign/attackby(obj/item/I, mob/user)
	if(!allowed(user))
		user << "<span class='info'>Access denied.</span>"
		return
	if( istype(I, /obj/item/weapon/screwdriver))
		if(!panel_open)
			user << "<span class='notice'>You open the maintenance panel.</span>"
			set_sign(new /datum/barsign/hiddensigns/signoff)
			panel_open = 1
		else
			user << "<span class='notice'>You close the maintenance panel.</span>"
			if(!broken && !emagged)
				set_sign(pick(barsigns))
			else if(emagged)
				set_sign(new /datum/barsign/hiddensigns/syndibarsign)
			else
				set_sign(new /datum/barsign/hiddensigns/empbarsign)
			panel_open = 0

	if(istype(I, /obj/item/stack/cable_coil) && panel_open)
		var/obj/item/stack/cable_coil/C = I
		if(emagged) //Emagged, not broken by EMP
			user << "<span class='warning'>Sign has been damaged beyond repair!</span>"
			return
		else if(!broken)
			user << "<span class='warning'>This sign is functioning properly!</span>"
			return

		if(C.use(2))
			user << "<span class='notice'>You replace the burnt wiring.</span>"
			broken = 0
		else
			user << "<span class='warning'>You need at least two lengths of cable!</span>"



/obj/structure/sign/barsign/emp_act(severity)
    set_sign(new /datum/barsign/hiddensigns/empbarsign)
    broken = 1




/obj/structure/sign/barsign/emag_act(mob/user)
	if(broken || emagged)
		user << "<span class='warning'>Nothing interesting happens!</span>"
		return
	user << "<span class='notice'>You emag the barsign. Takeover in progress...</span>"
	sleep(100) //10 seconds
	set_sign(new /datum/barsign/hiddensigns/syndibarsign)
	emagged = 1
	req_access = list(access_syndicate)




/obj/structure/sign/barsign/proc/pick_sign()
	var/picked_name = input("Available Signage", "Bar Sign") as null|anything in barsigns
	if(!picked_name)
		return
	set_sign(picked_name)



//Code below is to define useless variables for datums. It errors without these



/datum/barsign
	var/name = "Name"
	var/icon = "Icon"
	var/desc = "desc"
	var/hidden = 0


//Anything below this is where all the specific signs are. If people want to add more signs, add them below.



/datum/barsign/cdork
	name = "Curacao'dOrk"
	icon = "cdork"
	desc = "Bar Kurakao"

/datum/barsign/karagen
	name = "Karachan Bar"
	icon = "karagen"
	desc = "Bar dla prawdziwych prawiczkow"

/datum/barsign/cccp
	name = "CP Bar"
	icon = "karagen"
	desc = "Dzieci przyszloscia narodu"

/datum/barsign/xkom
	name = "Karachan Bar"
	icon = "xkom"
	desc = "99% szans na trafienie"

/datum/barsign/chan
	name = "Karachan Bar"
	icon = "xkom"
	desc = "Kara:Chan"



/datum/barsign/hiddensigns
	hidden = 1


//Hidden signs list below this point



/datum/barsign/hiddensigns/empbarsign
	name = "Haywire Barsign"
	icon = "empbarsign"
	desc = "Something has gone very wrong."



/datum/barsign/hiddensigns/syndibarsign
	name = "Syndi Cat Takeover"
	icon = "syndibarsign"
	desc = "Syndicate or die."



/datum/barsign/hiddensigns/signoff
	name = "Bar Sign"
	icon = "empty"
	desc = "This sign doesn't seem to be on."

