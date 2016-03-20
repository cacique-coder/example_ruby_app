module StatusableDecorator
  def status
    object.active? ? 'Activo' : 'Inactivo'
  end

  def change_status
    object.active? ? 'Inactivar' : 'Activar'
  end
end
