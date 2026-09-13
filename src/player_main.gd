extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var speed: float = 300
var gravity: float = 480
var jump: float = -500
var dash: float = 500
var direction: float = 0
var wall_slide_speed: float = 30
var facing_direction: float = 0
var player_meter: int = 0
var current_char: String = ""
var dashed: bool = false
var double_jumped: bool = false
var arrow_shot = false

var default_state := State2.new()
var fall_state := State2.new()
var jump_state := State2.new()
var walk_state := State2.new()
var dash_state := State2.new()
var glide_state := State2.new()
var shoot_state := State2.new()
var bunny_state := State2.new()
var dude_state := State2.new()
var owlet_state := State2.new()

var current_state: State2 = State2.new():
	set(value):
		current_state.exit.call()
		current_state = value
		current_state.enter.call()

func _ready() -> void:
	default_state.enter = default_enter
	default_state.process = default_process
	default_state.input = default_input
	
	fall_state.process = in_air_process
	fall_state.input = in_air_input
	
	jump_state.enter = jump_enter
	jump_state.process = in_air_process
	jump_state.input = in_air_input
	
	
	walk_state.enter = walk_enter
	walk_state.process = walk_process
	walk_state.input = walk_input
	
	dash_state.enter = dash_enter
	dash_state.process = in_air_process
	
	glide_state.enter = glide_enter
	glide_state.process = glide_process
	
	shoot_state.enter = shoot_enter
	shoot_state.process = shoot_process
	
	dude_state.enter = dude_enter
	bunny_state.enter = bunny_enter
	owlet_state.enter = owlet_enter
	
	current_state = bunny_state

## Main Functions ##
func _input(event: InputEvent) -> void:
	current_state.input.call(event)

func _physics_process(delta: float) -> void:
	current_state.process.call(delta)
	if not is_on_floor():
		velocity.y += gravity * delta
	if %SwitchTimer.is_stopped() and player_meter > 0:
		if Input.is_action_pressed("switch_dude")and current_char != "Dude":
				current_state = dude_state
		if Input.is_action_pressed("switch_bunny") and current_char != "Bunny":
				current_state = bunny_state
		if Input.is_action_pressed("switch_owlet") and current_char != "Owlet":
				current_state = owlet_state
	
	if Input.is_action_just_pressed("ability") and current_char == "Dude":
		current_state = shoot_state
	if current_state != shoot_state:
		%BowSprite.visible = false
	if current_state != glide_state:
		%GliderSprite.visible = false
		
	if %RegenTimer.is_stopped() and is_on_floor() and player_meter < 4:
		player_meter += 1
		%RegenTimer.start()
		
	update_bar()
	move_and_slide()

func shoot_arrow():
	const PROJECTILE = preload("uid://fwmjs1p7lqpl")
	var new_arrow = PROJECTILE.instantiate()
	
	if facing_direction:
		new_arrow.direction = Vector2.LEFT
	else:
		new_arrow.direction = Vector2.RIGHT
	
	get_tree().current_scene.add_child(new_arrow)
	new_arrow.global_position = %ArrowStart.global_position

func add_meter(amount):
	if player_meter < 4:
		player_meter += amount

func update_bar():
	if player_meter > 3:
		%MeterBar.play("4")
	elif player_meter > 2:
		%MeterBar.play("3")
	elif player_meter > 1:
		%MeterBar.play("2")
	elif player_meter > 0:
		%MeterBar.play("1")
	else:
		%MeterBar.play("0")

## Triggers when state is entered ##
func default_enter():
	if current_char == "Dude":
		animated_sprite_2d.play("dude_idle")
	if current_char == "Owlet":
		animated_sprite_2d.play("owlet_idle")
	if current_char == "Bunny":
		animated_sprite_2d.play("bunny_idle")
	double_jumped = false
	dashed = false

func jump_enter():
	velocity.y = jump
	animated_sprite_2d.play()
	if current_char == "Dude":
		animated_sprite_2d.play("dude_jump")
	if current_char == "Owlet":
		animated_sprite_2d.play("owlet_jump")
	if current_char == "Bunny":
		animated_sprite_2d.play("bunny_jump")
	%JumpSFX.play()

func walk_enter():
	if current_char == "Dude":
		animated_sprite_2d.play("dude_run")
	if current_char == "Owlet":
		animated_sprite_2d.play("owlet_run")
	if current_char == "Bunny":
		animated_sprite_2d.play("bunny_run")
	double_jumped = false
	dashed = false

func dash_enter():
	velocity.x += dash * int(Input.get_axis("left","right"))
	%JumpSFX.play()
	dashed = true
	current_state = fall_state

func glide_enter():
	%GliderSprite.play("glider")
	%GliderSprite.flip_h = not facing_direction
	%GliderSprite.visible = true
	%GlideSFX.play()

func shoot_enter():
	%BowSprite.flip_h = facing_direction
	%BowSprite.visible = true
	%BowSprite.play("bow_shoot")
	%JumpSFX.play()
	%AttackTimer.start()
	shoot_arrow()

func dude_enter():
	current_char = "Dude"
	%SwitchSFX.play()
	%SwitchParticles.emitting =  true
	%SwitchTimer.start()
	player_meter -= 1
	current_state = default_state

func bunny_enter():
	current_char = "Bunny"
	%SwitchSFX.play()
	%SwitchParticles.emitting =  true
	%SwitchTimer.start()
	player_meter -= 1
	current_state = default_state

func owlet_enter():
	current_char = "Owlet"
	%SwitchSFX.play()
	%SwitchParticles.emitting =  true
	%SwitchTimer.start()
	player_meter -= 1
	current_state = default_state

## Physics Processes for each state ##
func default_process(_delta: float):
	if is_on_floor() and velocity.x != 0:
		current_state = walk_state
		return
	if not is_on_floor() and velocity.y != 0:
		current_state = fall_state
		return
	if current_char == "Dude":
		pass
	if current_char == "Owlet":
		pass
	if current_char == "Bunny":
		pass

func in_air_process(delta: float):
	if is_on_floor() and velocity.y > jump:
		current_state = default_state
		return
	
	direction = Input.get_axis("left","right")
	velocity.x += direction * (speed/50)
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		facing_direction = direction < 0
		animated_sprite_2d.flip_h = facing_direction
	
	if not is_on_wall():
		velocity.y += gravity * delta
	if is_on_wall():
		dashed = false
		double_jumped = false
		velocity.y = 0
		velocity.y = min(velocity.y, wall_slide_speed)
		
	if current_char == "Dude":
		pass
	if current_char == "Owlet":
		pass
	if current_char == "Bunny":
		pass

func walk_process(_delta: float):
	direction = Input.get_axis("left","right")
	velocity.x = direction * speed
	
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		facing_direction = direction < 0
		animated_sprite_2d.flip_h = facing_direction
		
	if %FootstepTimer.is_stopped():
		if is_on_floor() and velocity.x != 0:
			%WalkSFX.play()
			%FootstepTimer.start()
	
	if is_on_floor() and velocity.x == 0:
		current_state = default_state
		return
	if not is_on_floor() and velocity.y != 0:
		current_state = fall_state
		return
	
	if current_char == "Dude":
		pass
	if current_char == "Owlet":
		pass
	if current_char == "Bunny":
		pass

func glide_process(_delta: float):
	if Input.is_action_just_released("ability") and not is_on_floor() or is_on_wall():
		%GliderSprite.visible = false
		%GlideSFX.stop()
		current_state = fall_state
	if is_on_floor():
		%GliderSprite.visible = false
		%GlideSFX.stop()
		current_state = default_state
	velocity.y = 80

func shoot_process(_delta: float):
	if %AttackTimer.is_stopped():
		current_state = fall_state

## Allows inputs to switch states between eachother ##
func default_input(_event: InputEvent):
		if Input.is_action_pressed("jump") and is_on_floor():
			current_state = jump_state
		if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor():
			current_state = walk_state

func in_air_input(_event: InputEvent):
	if current_char == "Bunny":
		if dashed == false and Input.is_action_pressed("ability"):
			dashed = true
			%DoubleJumpParticles.emitting = true
			current_state = dash_state

	if current_char == "Owlet":
		if Input.is_action_pressed("ability") and not is_on_wall():
			current_state = glide_state

	if double_jumped == false and Input.is_action_pressed("jump") and %DoubleJumpTimer.is_stopped() and not is_on_wall():
		double_jumped = true
		%DoubleJumpTimer.start()
		%DoubleJumpParticles.emitting = true
		current_state = jump_state

func walk_input(_event: InputEvent):
	if Input.is_action_pressed("jump") and is_on_floor():
			current_state = jump_state
