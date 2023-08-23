extends CharacterBody3D

@onready var playerBody = %Armature

const SPEED = 1.5
const JUMP_VELOCITY = 4.5

#this is the variable that blends the Idle and movement animations
var movement = 0.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		movement=lerp(movement,1.0,0.15)
#this is similar of doing movement = 1, but doing it this way makes the transition looks better
		playerBody.rotation.y=lerp_angle(playerBody.rotation.y,(-input_dir.angle())+PI/2,0.3)
#this is similar of doing playerBody.rotation.y = (-input_dir.angle())+PI/2, but doing it this way makes the transition looks better
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		movement=lerp(movement,0.0,0.15)
#this is similar of doing movement = 0, but doing it this way makes the transition looks better
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	$AnimationTree.set("parameters/BlendSpace1D/blend_position",movement)
#in here you set the BlendSpace between 0 and 1, 0 means closer to Idle, and 1 means closer to Walk
	move_and_slide()
