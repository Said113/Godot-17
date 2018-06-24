extends Area2D

export (int) var speed
var player = Vector2() #track the movment of the player
var screen #scren reslotions

func _ready():
	#hide()
	screen = get_viewport_rect().size
	
func _process(delta):
	#check the player movement
	player = Vector2()
	if(Input.is_action_pressed("ui_right")):
		player.x += 1
	if(Input.is_action_pressed("ui_left")):
		player.x -= 1
	if(Input.is_action_pressed("ui_up")):
		player.y -= 1
	if(Input.is_action_pressed("ui_down")):
		player.y += 1
	if(player.length() >0):
		player = player.normalized() * speed
		$AnimatedSprite.play() # play the animaition
	else:
		$AnimatedSprite.stop() # stop the animaiton
	#move the player
	position += player * delta
	#check the player they must not move out the screen
	position.x = clamp(position.x, 0, screen.x)
	position.y = clamp(position.y, 0, screen.y)

	#move the animaition like the same dirationn of the player
	if(player.x !=0):
		$AnimatedSprite.animation = "righte"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = player.x < 0 #this means true
	elif(player.y !=0):
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = player.y > 0

func _on_player_body_entered(body):
	hide() # hide the player when the game start
	emit_signal("hit")
	call_deferred("set_monitoring", false)
func start(pos):
	position = pos
	show()
	monitoring = true