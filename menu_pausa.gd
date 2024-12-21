extends Control


# Función para el botón "Reanudar"
func _on_Button_pressed():
	get_tree().paused = false  # Reanuda el juego
	queue_free()  # Cierra el menú de pausa

# Función para el botón "Salir"
func _on_Button3_pressed():
	get_tree().paused = false  # Asegúrate de despausar el juego
	get_tree().change_scene_to_file("res://menu_principal.tscn")  # Regresa al menú principal
