extends StaticBody2D

# Propiedades del bloque
@export var max_life: int = 4
@export var hardness: int = 2
@export var material_to_add: Array[String] = []
@export var sprites: Array[Texture2D] = [] # Asume 4 sprites para los niveles de vida

var current_life: int

func _ready():
	current_life = max_life
	update_sprite()

func take_damage(damage: int):
	current_life -= damage
	if current_life <= 0:
		on_destroy()
	else:
		update_sprite()

func update_sprite():
	if sprites.size() == 4 and current_life > 0:
		# Calcular el porcentaje de vida restante
		var percentage = float(current_life) / float(max_life) * 100.0

		# Seleccionar sprite basado en el porcentaje
		if percentage > 75:
			$Sprite2D.texture = sprites[0]  # 100% - 75%
		elif percentage > 50:
			$Sprite2D.texture = sprites[1]  # 75% - 50%
		elif percentage > 25:
			$Sprite2D.texture = sprites[2]  # 50% - 25%
		else:
			$Sprite2D.texture = sprites[3]  # 25% - 0%

func on_destroy():
	# Agregar el material al inventario del jugador
	emit_signal("block_destroyed", material_to_add)
	queue_free()

# Señales
signal block_destroyed(material: String)
