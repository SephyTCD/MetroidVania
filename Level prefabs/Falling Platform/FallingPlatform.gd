extends StaticBody2D

#how long the block falls before disappearing
@export var fallDuration = .75
var fallTimer = 0

#how long the fall should be
@export var fallDistance = 30
var initialPosition = Vector2()
var targetPosition = Vector2()

#how long it takes with the player standing on it to start falling
@export var timeToStartFall = 1
var fallStartTimer = 0

#how long it takes to reset after falling
@export var resetDelay = 5
var resetTimer = 0

#true if the player is standing on the block
var playerDetected = false

#marked true when platform should be falling
var shouldFall = false

#marked true when the platform should be gone
var platformInactive = false

#used for disabling and re enabling collision shapes
var oldCollisonShape

func _ready():
	fallStartTimer = timeToStartFall
	
	#set fall distances
	initialPosition = position
	targetPosition = position + Vector2(0, fallDistance)

func _process(delta):
	#if the player is on the platform, start the timer until the playform falls
	if playerDetected && fallStartTimer > 0 && !shouldFall && !platformInactive:
		fallStartTimer -= delta
		
		#start the fall when the timer hits zero
		if fallStartTimer <= 0:
			shouldFall = true
			fallTimer = fallDuration
	
	#process the fall
	if shouldFall && fallTimer > 0:
		position = position.move_toward(targetPosition, fallTimer/fallDuration)
		fallTimer -= delta
		
		#fall finished, stop falling and wait for reset
		if fallTimer <= 0 || position == targetPosition:
			shouldFall = false
			resetTimer = resetDelay
			platformInactive = true
			disablePlatform()
	
	#handle reset timer
	if resetTimer > 0:
		resetTimer -= delta
		
		if resetTimer <= 0:
			position = initialPosition
			fallStartTimer = timeToStartFall
			platformInactive = false
			enablePlatform()

func _on_player_detector_body_entered(body):
	playerDetected = true

func _on_player_detector_body_exited(body):
	playerDetected = false

func enablePlatform():
	for child in get_children():
		child.show()
		if child is CollisionShape2D:
			child.disabled = false

func disablePlatform():
	for child in get_children():
		child.hide()
		if child is CollisionShape2D:
			child.disabled = true
