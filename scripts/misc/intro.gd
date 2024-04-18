extends Node2D

@onready var animations : AnimationPlayer = $AnimationPlayer

func _ready():
	pass

func _process(delta):
	animations.play("read")

func _transition():
	get_tree().change_scene_to_file("res://scenes/Maps/intro_level.tscn")
