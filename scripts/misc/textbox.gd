extends CharacterBody2D

var text = null
var cycle = 1

func _physics_process(delta):

	$RichTextLabel.set_text(text)

	if cycle == 0:
		queue_free()

	move_and_slide()
