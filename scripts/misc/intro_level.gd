extends Node2D


func _enter_tree():
	if CheckPoint.lastPose:
		$bokan.global_position = CheckPoint.lastPose
