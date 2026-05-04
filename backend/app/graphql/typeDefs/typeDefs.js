const typeDefs = `
    type Cita {
        id: ID
        fecha: String
        estado: String
        duracion: Int
        pacienteID: ID
        medicoID: ID
    }

    type Historial {
        id: ID
        pacienteID: ID
        medicoID: ID
        fecha: String
        diagnostico: String
        tratamiento: String
        observaciones: String
        pruebasRealizadas: [String]
    }

    type MedicoStats {
        medicoID: ID
        totalCitasFinalizadas: Int
        promedioDuracion: Float
    }

    type Query {
        statsMedico(medicoID: ID!): MedicoStats

        statsMedicos: [MedicoStats]

        citasPendientesHoy: [Cita]

        historialPaciente(pacienteID: ID!): [Historial]
    }
`

export default typeDefs
