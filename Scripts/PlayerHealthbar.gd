extends ProgressBar

@onready var player = get_node("Player")

func _on_player_player_damaged(amount):
	value -= amount

func _on_player_player_healed(amount):
	value += amount

func _on_player_update_player_health_bar(newValue):
	value = newValue
