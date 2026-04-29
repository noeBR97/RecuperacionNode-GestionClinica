import Paciente from '../models/Paciente.js'

export const getPacientes = async (req, res) => {
    try {
        const pacientes = await Usuario.findAll()

        res.json(pacientes)
    } catch (error){
        res.status(500).son({msg: 'Error al obtener pacientes'})
    }
}

export const crearPaciente = async (req, res) => {
    try {
        const paciente = await Paciente.create(req.body)
        res.status(201).json({msg: 'Paciente registrado correctamente', paciente})
    } catch(error) {
        res.status(500).son({msg: 'Error al crear paciente'})
    }
}

export const buscarPaciente = async (req, res) => {
    const {id} = req.params

    try {
        const paciente = await Paciente.findByPk(id)

        if(!paciente) {
            return res.status(404).json({msg: 'Paciente no encontrado'})
        }

        res.json(paciente)
    } catch(error) {
        res.status(500).json({msg: 'Error en el servidor'})
    }
}

export const actualizarPaciente = async (req, res) => {
    const {id} = req.params

    try {
        const paciente = await Paciente.findByPk(id)

        if(!paciente) {
            return res.status(404).json({msg: 'Paciente no encontrado'})
        }

        await paciente.update(req.body)
        res.json({msg: 'Paciente actualizado correctamente.', paciente})
    } catch(error) {
        res.status(500).json({msg: 'Error al actualizar'})
    }
}

export const eliminarPaciente = async (req, res) => {
    const {id} = req.params

    try {
        const paciente = await Paciente.findByPk(id)

        if(!paciente) {
            return res.status(404).json({msg: 'Paciente no encontrado'})
        }

        await paciente.destroy()
        res.json({msg: 'Paciente eliminado correctamente.', paciente})
    } catch(error) {
        res.status(500).json({msg: 'Error en el servidor'})
    }
}