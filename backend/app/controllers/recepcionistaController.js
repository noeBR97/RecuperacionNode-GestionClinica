import Cita from "../models/Cita.js";

export const cancelarCita = async (req, res) => {
    const {id} = req.params

    try{
        const cita = await Cita.findByPk(id)

        if(!cita) {
            return res.status(404).json({msg: 'Cita no encontrada'})
        }

        await cita.update({estado: 'cancelada'})

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