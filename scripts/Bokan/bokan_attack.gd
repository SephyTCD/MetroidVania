extends Node
class_name bokan_attack

var anim = "paper_throw_1"
var animSwap = 1

var bullet = preload("res://scenes/Entities/bokan_projectile.tscn")

@export var player : Player
@export var stateMachine : StateMachine

func _ready():
	pass

func _process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return

	if Input.is_action_pressed("ui_left"):
		player.marker.position.x = abs(player.marker.position.x) * -1

	if Input.is_action_pressed("ui_right"):
		player.marker.position.x = abs(player.marker.position.x) * 1

	if stateMachine.current_state is bokan_wall_slide:
		player.marker.position.x *= -1
	
	if Input.is_action_just_pressed("shoot") and player.shootLock == 0:
		player.animLock = 1
		
		$"../sounds/paper".play()
		
		if player.is_on_floor() == false:
			if animSwap == 1:
				animSwap = 2
				anim = "air_paper_throw_2"
			elif animSwap == 2:
				animSwap = 1
				anim = "air_paper_throw_1"
		else:
			if animSwap == 1:
				animSwap = 2
				anim = "paper_throw_2"
			elif animSwap == 2:
				animSwap = 1
				anim = "paper_throw_1"
		
		if player.facing == 1:
			player.animations.play(anim)
			player.sprite.flip_h = false
		if player.facing == -1:
			player.animations.play(anim)
			player.sprite.flip_h = true
		
		
		var inst = bullet.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = player.marker.global_position
		if player.marker.position.x > 0:
			inst.speed *= 1
		if player.marker.position.x < 0:
			inst.speed *= -1

func _animUnlock():
	player.animLock = 0

