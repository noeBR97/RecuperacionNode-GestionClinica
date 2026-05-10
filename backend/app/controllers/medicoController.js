import Cita from '../models/Cita.js';
import Paciente from '../models/Paciente.js';
import Historial from '../models/Historial.js';

export const obtenerMisCitas = async (req, res) => {
    try {
        const citas = await Cita.findAll({
            where: {medicoID: req.idToken},
            include: [{
                model: Paciente,
                as: 'paciente',
                attributes: ['nombre', 'apellido1', 'apellido2', 'dni']
            }]
        })

        res.json(citas)
    } catch(error) {
        res.status(500).json({msg: 'Error al obtener la agenda'})
    }
}

export const actualizarEstadoCita = async (req, res) => {
    const {id} = req.params
    const {estado} = req.body

    try {
        const cita = await Cita.findByPk(id)

        if(!cita) {
            return res.status(404).json({msg: 'Cita no encontrada'})
        }

        if(cita.medicoID !== req.idToken) {
            return res.status(403).json({msg: 'No tienes permiso para gestionar esta cita'})
        }

        cita.estado = estado
        await cita.save()

        const io = req.app.get('socketio')

        io.emit('cambio-en-agenda', {
            msg: `La cita ${id} ha cambiado su estado a ${estado}`,
            citaID: id,
            nuevoEstado: estado
        })

        res.json({msg: 'Cita actualizada correctamente', cita})
    } catch(error) {
        res.status(500).json({msg: 'Error al actualizar el estado'})
    }
}