extends Node3D

@export var multimesh_instance: MultiMeshInstance3D # Link your MultiMeshInstance3D in the Inspector

func _ready():
	var multimesh = multimesh_instance.multimesh
	var instance_count = multimesh.instance_count
	
	for i in range(instance_count):
		# Get the transform of each instance
		var instance_transform = multimesh.get_instance_transform(i)
		
		# Create a StaticBody3D for each instance to handle collisions
		var static_body = StaticBody3D.new()
		static_body.transform = instance_transform  # Position the body at the instance's location
		
		# Add a CollisionShape3D to the StaticBody3D
		var collision_shape = CollisionShape3D.new()
		var shape = BoxShape3D.new()  # Adjust this shape based on your mesh type
		collision_shape.shape = shape
		
		# Add the collision shape to the StaticBody3D
		static_body.add_child(collision_shape)
		
		# Add the StaticBody3D to the scene (as a child of the current node)
		add_child(static_body)
