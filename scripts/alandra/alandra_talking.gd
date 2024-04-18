extends AlandraState
class_name alandra_talking

var next = 0
var target = null

var text = preload("res://scripts/misc/textbox.tscn")
var inst = text.instantiate()


func _enter():
	Globals.inCutscene = true
	next = 0
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	
	if alandra.direction == 1:
		alandra.animations.play("alandra_idle")
		alandra.sprite.flip_h = false
	if alandra.direction == -1:
		alandra.animations.play("alandra_idle")
		alandra.sprite.flip_h = true
	

	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("shoot"):
		next += 1

	get_tree().current_scene.add_child(inst)
	inst.global_position = target.global_position + Vector2(0, 60)
	inst.text = ("Ah that's who was running around...")

	if alandra.dialogue == 1:
		if next == 0:
			inst.text = ("I'm not gonna ask how you got here. Probably not for a good reason...")

		if next == 1:
			inst.text = ("So welcome I guess. You probably exist here how this place presumes you now...\n I usually tell people to check their pockets...")

		if next == 2:
			inst.text = ("But don't take too long. We have to go, it's not safe here.")

		if next == 3:
			state_transition.emit(self, "alandra_leaving")


	if alandra.dialogue == 2:
		if next == 0:
			inst.text = ("So notice anything different?")

		if next == 1:
			inst.text = ("Oh wait I haven't even gotten your name... Eh... Let's just get somewhere safe.")

		if next == 2:
			state_transition.emit(self, "alandra_leaving")

	if alandra.dialogue == 3:
		if next == 0:
			inst.text = ("Almost there, just a bit farther")

		if next == 1:
			state_transition.emit(self, "alandra_leaving")

	if alandra.dialogue == 4:
		if next == 0:
			inst.text = ("Alright... just past this bridge... I have a place to show you.")

		if next == 1:
			state_transition.emit(self, "alandra_leaving")

	if alandra.dialogue == 5:
		if next == 0:
			inst.text = ("There you are! Hwah... I am... so sorry! Haah... I am indeed Alandra. Oh yeah that's my name.")

		if next == 1:
			inst.text = ("There's a path back to our little shelter... Don't worry, theres no rickety bridges.")

		if next == 2:
			inst.text = ("But...If you can navigate this place I think you'll be fine whether I'm here or not.")

		if next == 3:
			state_transition.emit(self, "alandra_demoend")

	
func _exit():
	inst.cycle = 0


