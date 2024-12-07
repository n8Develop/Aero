extends Node3D



func start_node_following_path():
	var tween = create_tween()
	tween.tween_property(self, "progress_ratio", 1, 5)
	tween.play()
	$RemoteTransform3D.update_position = true
	$RemoteTransform3D.update_rotation = true

	#This keeps the player attatched until the tween finishes
	await tween.finished
	$RemoteTransform3D.update_position = false
	$RemoteTransform3D.update_rotation = false   
