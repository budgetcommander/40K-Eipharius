/obj/item/gun/launcher/rcl_rifle
	name = "recoilless rifle"
	desc = "Auf wiedersein, untermensch."
	icon_state = "c20r" //until there is a normal sprite
	w_class = ITEM_SIZE_LARGE
	throw_speed = 2
	throw_range = 10
	force = 5.0
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = 0
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 5, TECH_ILLEGAL = 3)
	fire_sound = 'sound/weapons/gunshot/tank.ogg'
	combustion = 1
	release_force = 12.5
	throw_distance = 30
	var/max_shells = 1
	var/list/shells = new/list()
// a lot of shitcode. i will fix it someday
/*/obj/item/gun/launcher/rcl_rifle/update_icon()
	..()
	if(shells.len == max_shells)
		icon_state = "rcl_rifle"
	else
		icon_state = "rcl_rifle-e"
*/                                    //doesnt work
/obj/item/gun/launcher/rcl_rifle/examine(mob/user)
        if(!..(user, 2))
                return
        to_chat(user, "<span class='notice'>[shells.len] / [max_shells] shells.</span>")

/obj/item/gun/launcher/rcl_rifle/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/ammo_casing/heat_shell))
		if(shells.len < max_shells)
			user.drop_item()
			I.loc = src
			//flick("rcl_rifle-l",src)
			playsound(src.loc, 'sound/effects/cannon_load.ogg', 100, 1)
			shells += I
			to_chat(user, "<span class='notice'>You put the shell in [src].</span>")
			to_chat(user, "<span class='notice'>[shells.len] / [max_shells] shells.</span>")
		else
			to_chat(usr, "<span class='warning'>\The [src] cannot hold more shells.</span>")

/obj/item/gun/launcher/rcl_rifle/consume_next_projectile()
        if(shells.len)
                var/obj/item/ammo_casing/heat_shell/I = shells[1]
                var/obj/item/recoilless_shell/M = new (src)
                M.primed = 1
                shells -= I
                return M
        return null

/obj/item/gun/launcher/rcl_rifle/handle_post_fire(mob/user, atom/target)
        log_and_message_admins("fired a shell from a recoilless rifle ([src.name]) at [target].")
        ..()