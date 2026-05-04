import Cita from '../../models/Cita.js'
import Historial from '../../models/Historial.js'
import { Op } from 'sequelize'
import { calcularDuracionMinutos, crearStatsMedico } from '../controllers/clinicaController_GQL.js'

const resolvers = {
    Cita: {
        duracion: calcularDuracionMinutos
    },

    Historial: {
        id: (historial) => historial._id.toString()
    },

    Query: {
        statsMedico: async (_, { medicoID }) => {
            const citas = await Cita.findAll({
                where: {
                    medicoID,
                    estado: 'finalizada'
                }
            })

            return crearStatsMedico(medicoID, citas)
        },

        statsMedicos: async () => {
            const citas = await Cita.findAll({
                where: {
                    estado: 'finalizada'
                }
            })

            const citasPorMedico = citas.reduce((grupo, cita) => {
                const medicoID = cita.medicoID

                if (!grupo[medicoID]) {
                    grupo[medicoID] = []
                }

                grupo[medicoID].push(cita)
                return grupo
            }, {})

            return Object.entries(citasPorMedico).map(([medicoID, citasMedico]) =>
                crearStatsMedico(medicoID, citasMedico)
            )
        },

        citasPendientesHoy: async () => {
            const inicioDia = new Date()
            inicioDia.setHours(0, 0, 0, 0)

            const finDia = new Date()
            finDia.setHours(23, 59, 59, 999)

            return await Cita.findAll({
                where: {
                    estado: 'pendiente',
                    fecha: {
                        [Op.between]: [inicioDia, finDia]
                    }
                }
            })
        },

        historialPaciente: async (_, { pacienteID }) => {
            return await Historial.find({ pacienteID: Number(pacienteID) }).sort({ fecha: -1 })
        }
    }
}

export default resolvers
