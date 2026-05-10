import Cita from "../models/Cita.js";
import Paciente from "../models/Paciente.js";
import Usuario from "../models/Usuario.js";

export const getPacientesRecepcion = async (req, res) => {
    try {
        const pacientes = await Paciente.findAll()

        res.json(pacientes)
    } catch(error) {
        res.status(500).json({msg: 'Error al obtener pacientes'})
    }
}

export const getMedicosRecepcion = async (req, res) => {
    try {
        const medicos = await Usuario.findAll({
            where: {rol: 'medico'},
            attributes: { exclude: ['clave'] }
        })

        res.json(medicos)
    } catch(error) {
        res.status(500).json({msg: 'Error al obtener médicos'})
    }
}

export const cancelarCita = async (req, res) => {
    const {id} = req.params

    try{
        const cita = await Cita.findByPk(id)

        if(!cita) {
            return res.status(404).json({msg: 'Cita no encontrada'})
        }

        await cita.update({estado: 'cancelada'})

        const io = req.app.get('socketio')
        io.emit('cambio-en-agenda', {
            msg: `La cita ${id} ha cambiado su estado a cancelada`,
            citaID: id,
            nuevoEstado: 'cancelada',
            tipo: 'cancelada'
        })

        res.json({msg: 'Cita cancelada correctamente', cita})
    } catch(error) {
        // ESTO TE DIRÁ EL ERROR REAL EN TU TERMINAL
        console.error("Error al cancelar cita:", error);
        
        res.status(500).json({ 
            msg: 'Error al cancelar la cita', 
            detalle: error.message 
        });
    }
}
