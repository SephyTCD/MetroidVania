extends CharacterBody2D
class_name Tutorial

var hide = 0
var active = 0

@export var slide = 1

@onready var animations : AnimationPlayer = $AnimationPlayer


func _physics_process(_delta):
	
	if slide == 1:
		animations.play("wall_jump")
		$RichTextLabel.set_text("\n \n \n                                          Press jump while on a\n                                             wall to wall jump")
	if slide == 2:
		animations.play("wall_run")
		$RichTextLabel.set_text("\n \n \n                                         Hold shift or ctrl while \n                                         on a levels unique \n                                         back wall to run across it")
	if slide == 3:
		animations.play("controls")
		$RichTextLabel.set_text("Key Board controls:\nMove - Arrow Keys\nJump - Z\nAttack - X\nWall Run - Shift or Ctrl\n \nPS Controller controls\nMove - Dpad\nJump = X\nAttack - Square or Triangle\nWall Run - Circle or R1")
	
	if hide == 0:
		modulate.a = 0
	else:
		modulate.a = 1
