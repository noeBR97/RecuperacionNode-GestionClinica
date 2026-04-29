import Usuario from '../models/Usuario.js'

export const getUsuarios = async (req, res) => {
    try {
        const usuarios = await Usuario.findAll({
            attributes: { exclude: ['clave'] } //excluimos la contraseña por seguridad
        })

        res.json(usuarios)
    } catch (error){
        res.status(500).son({msg: 'Error al obtener usuarios'})
    }
}

export const buscarUsuario = async (req, res) => {
    try {
        const usuario = await Usuario.findByPk(id, {
            attributes: { exclude: ['clave'] }
        })

        if(!usuario) {
            return res.status(404).json({msg: 'Usuario no encontrado'})
        }

        res.json(usuario)
    } catch(error) {
        res.status(500).json({msg: 'Error en el servidor'})
    }
}

export const actualizarUsuario = async(req, res) => {
    const {id} = req.params
    const {email, ...datos} = req.body //asi evitamos que pueda cambiar el email

    try {
        const usuario = await Usuario.findByPk(id)

        if(!usuario) {
            return res.status(404).json({msg: 'Usuario no encontrado'})
        }

        await usuario.update(datos)
        res.json({msg: 'Usuario actualizado correctamente.', usuario})
    } catch(error) {
        res.status(500).json({msg: 'Error al actualizar'})
    }
}

export const eliminarUsuario = async (req, res) => {
    const {id} = req.params

    try {
        const usuario = await Usuario.findByPk(id)

        if(!usuario) {
            return res.status(404).json({msg: 'Usuario no encontrado'})
        }

        await usuario.destroy()
        res.json({msg: 'Usuario eliminado correctamente.', usuario})
    } catch(error) {
        res.status(500).json({msg: 'Error al eliminar'})
    }
}