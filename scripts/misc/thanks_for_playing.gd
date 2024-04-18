extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("shoot"):
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
