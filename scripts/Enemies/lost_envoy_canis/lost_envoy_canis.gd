extends CharacterBody2D
class_name Canis

var speed = 300.0
var jumpSpeed = -500
var direction = 1
var damage = 2
var boxTime = 0
var blinkTime = 0
var knockForce = 200
var knockUp = -200

var damageAble = 0
var health = 60
var maxHealth = 60
var healthShow = 0
var dying = 0

var target = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var explosion = preload("res://scenes/misc/boss_explosion.tscn")

@onready var marker = $Marker2D

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	
	target = get_tree().get_first_node_in_group("Player")
	
	$RichTextLabel.set_text("Health\n"+str(health)+"/"+str(maxHealth))
	
	$RichTextLabel.global_position = target.global_position + Vector2(170, 70)
	
	if healthShow == 0:
		$RichTextLabel.modulate.a = 0
	if healthShow == 1:
		$RichTextLabel.modulate.a = 1
	
	if health < 0:
		health = 0
	
	if blinkTime > 0:
		damageAble = 0
		blinkTime -= _delta
		modulate.a = 0.5
	else:
		damageAble = 1
		modulate.a = 1
	
	if health <= 0:
		modulate.a = 0.5

	if dying == 1:
		var inst = explosion.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = global_position
		queue_free()

	velocity.y += gravity * _delta

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionPolygon2D.disabled = true
	else:
		$Area2D/CollisionPolygon2D.disabled = false

		if direction < 0:
			$Marker2D.position.x = abs($Marker2D.position.x) * -1

		if direction > 0:
			$Marker2D.position.x = abs($Marker2D.position.x) * 1

	move_and_slide()

func _damaged(dam):
	if damageAble == 1:
		health -= dam
		blinkTime = .1

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction, knockForce, knockUp)
		boxTime = .01
