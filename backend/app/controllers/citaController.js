import Cita from '../models/Cita.js'
import Paciente from '../models/Paciente.js'
import Usuario from '../models/Usuario.js'

export const crearCita = async (req, res) => {
    try {
        const {fecha, motivo, pacienteID, medicoID} = req.body

        const paciente = await Paciente.findByPk(pacienteID)

        if(!paciente) {
            return res.status(404).json({msg: 'Paciente no encontrado'})
        }

        const medicoAsignado = await Usuario.findByPk(medicoID)

        if(!medicoAsignado || medicoAsignado.rol !== 'medico') {
            return res.status(400).json({msg: 'El usuario asignado para atender la cita debe ser médico'})
        }

        const cita = await Cita.create({
            fecha,
            motivo,
            pacienteID,
            medicoID,
            estado: 'pendiente'
        })

        res.status(201).json({msg: 'Cita creada correctamente'})
    } catch(error) {
        res.status(500).json({msg: 'Error al crear la cita'})
    }
}

export const getCitas = async (req, res) => {
    try {
        const citas = await Cita.findAll({
            include: [
                {model: Paciente, as: 'paciente', attributes: ['nombre', 'apellido1', 'dni']}, //filtramos lo campos que queremos
                {model: Usuario, as: 'medico', attributes: ['nombre', 'apellido1']}
            ]
        })

        res.json(citas)
    } catch (error){
        res.status(500).json({msg: 'Error al obtener citas'})
    }
}

export const buscarCita = async (req, res) => {
    const {id} = req.params

    try {
        const cita = await Cita.findByPk(id, {
            include: [
                {model: Paciente, as: 'paciente', attributes: ['nombre', 'apellido1', 'dni']}, //filtramos lo campos que queremos
                {model: Usuario, as: 'medico', attributes: ['nombre', 'apellido1']}
            ]
        })

        if(!cita) {
            return res.status(404).json({msg: 'Cita no encontrada'})
        }

        res.json(cita)
    } catch(error) {
        res.status(500).json({msg: 'Error en el servidor'})
    }
}

export const actualizarCita = async (req, res) => {
    const {id} = req.params

    try {
        const cita = await Cita.findByPk(id)

        if(!cita) {
            return res.status(404).json({msg: 'Cita no encontrada'})
        }

        await cita.update(req.body)
        res.json({msg: 'Cita actualizada correctamente.', cita})
    } catch(error) {
        res.status(500).json({msg: 'Error al actualizar'})
    }
}

export const eliminarCita = async (req, res) => {
    const {id} = req.params

    try {
        const cita = await Cita.findByPk(id)

        if(!cita) {
            return res.status(404).json({msg: 'Cita no encontrada'})
        }

        await cita.destroy()
        res.json({msg: 'Cita eliminada correctamente.', cita})
    } catch(error) {
        res.status(500).json({msg: 'Error en el servidor'})
    }
}