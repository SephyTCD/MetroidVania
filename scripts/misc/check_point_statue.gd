extends CharacterBody2D

var anim = "unchecked"
var textTime = 0
var target = null

@onready var animations : AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):

	target = get_tree().get_first_node_in_group("Player")

	animations.play(anim)

	

	if textTime > 0:
		textTime -= _delta
		$RichTextLabel.modulate.a = 1
	else:
		$RichTextLabel.modulate.a = 0

func _on_area_2d_body_entered(body):
	if body == target:
		textTime = 3
		anim = "checking"

func _finish():
	anim = "checked"
