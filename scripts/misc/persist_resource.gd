extends Node

var resources = {}

func _load(resource_path : String):
	print(resource_path)
	if resources.has(resource_path) == false:
		resources[resource_path] = load(resource_path)
	return resources[resource_path]
