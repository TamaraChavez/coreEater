extends Node2D

@export var gravity_strength: float = 200.0  # Fuerza gravitatoria
@export var gravity_radius: float = 150.0   # Radio de efecto gravitatorio

func _ready():
	# Configura el área gravitacional
	var area = $Area2D
	var collision_shape = area.get_node("CollisionShape2D")
	collision_shape.shape.radius = gravity_radius
	generate_planet()

# Parámetros personalizables
@export var layers: int = 3                     # Número de capas
@export var blocks_per_layer: Array[int]= []        # Número de bloques por capa (una entrada por capa)
@export var radii: Array[int] = []                   # Radio de cada capa (una entrada por capa)
@export var block_scenes: Array[PackedScene] = []
@export var randomize_blocks: bool = true
var rng = RandomNumberGenerator.new()

func generate_planet():
	# Verifica la configuración
	if layers != blocks_per_layer.size() or layers != radii.size():
		print("El número de capas, bloques por capa y radios deben coincidir.")
		return

	# Limpia los bloques existentes
	for child in get_children():
		child.queue_free()

	# Genera las capas
	for layer_index in range(layers):
		generate_layer(layer_index)

func generate_layer(layer_index: int):
	var layer_radius = radii[layer_index]  # Radio de la capa actual
	var block_count = blocks_per_layer[layer_index]  # Número de bloques en esta capa

	for i in range(block_count):
		var angle = i * TAU / block_count  # Divide los bloques uniformemente
		var block_scene = select_block_scene()
		var block = block_scene.instantiate()  # Instancia el bloque
		var position = Vector2(layer_radius * cos(angle), layer_radius * sin(angle))
		block.position = position
		block.rotation = angle  # Alinea el bloque hacia el centro
		add_child(block)

func select_block_scene() -> PackedScene:
	# Selecciona un bloque aleatoriamente o en orden
	if randomize_blocks:
		return block_scenes[rng.randi_range(0, block_scenes.size() - 1)]
	return block_scenes[0]
