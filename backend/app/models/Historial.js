import mongoose from 'mongoose';

const historialSchema = new mongoose.Schema({
    pacienteID: {type: Number, required: true},
    medicoID: {type: Number, required: true},
    fecha: {type: Date, default: Date.now},
    diagnostico: {type: String, required: true},
    tratamiento: {type: String},
    observaciones: {type: String},
    pruebasRealizadas: [String]
}, {collection: 'historiales'})

const historialModel = mongoose.model('Historial', historialSchema)

export default historialModel