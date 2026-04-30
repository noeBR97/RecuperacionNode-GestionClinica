import Cita from '../models/Cita.js';
import Paciente from '../models/Paciente.js';
import Usuario from '../models/Usuario.js';
import Historial from '../models/Historial.js';

export const metricasGenerales = async (req, res) => {
    try {
        const totalPacientes = await Paciente.count()
        const totalMedicos = await Usuario.count({where: {rol: 'medico'}})
        const totalRecepcionistas = await Usuario.count({where: {rol: 'recepcionista'}})
        const totalCitas = await Cita.count()
        const totalCitasPendientes = await Cita.count({where: {estado: 'pendiente'}})
        const totalHistoriales = await Historial.countDocuments()

        res.json({
            resumen: {
                pacientes: totalPacientes,
                personal: {
                    medicos: totalMedicos,
                    recepcionistas: totalRecepcionistas
                },
                actividad: {
                    citasTotales: totalCitas,
                    citasPendientes: totalCitasPendientes,
                    historialesClinicos: totalHistoriales
                }
            },
            msg: 'Métricas actualizadas a tiempo real'
        })
    } catch(error) {
        res.status(500).json({ msg: 'Error al obtener las métricas' })
    }
}