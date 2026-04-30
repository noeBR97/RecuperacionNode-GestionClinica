import Historial from '../models/Historial.js'

//En una clínica real es necesario el control total del administrador para los historiales, igual que de todo lo demás, 
//pero bajo la supervision del médico, ya que estos datos no lo debería gestionar el admin sin conocimientos de medicina

export const getHistoriales = async (req, res) => {
    try {
        const historiales = await Historial.find()

        if(historiales.length > 0) {
            console.log('🔵Listado correcto!');
            res.status(200).json(historiales);
        }
    } catch(error) {
        res.status(500).json({msg: 'Error al recuperar los historiales'})
    }
}

export const buscarHistorial = async (req, res) => {
    const {pacienteID} = req.params

    try {
        //con sort -1 muestra desde las entradas más recientes
        const historial = await Historial.find({pacienteID}).sort({fecha: -1})

        if(historial.length === 0) {
            return res.status(404).json({msg: 'No se han encontrado entradas para este paciente'})
        }

        res.json(historial)
    } catch(error) {
        res.status(500).json({msg: 'Error al buscar el historial'})
    }
}

export const buscarEntrada = async (req, res) => {
    const {id} = req.params

    try {
        const entrada = await Historial.findById(id)

        if(!entrada) {
            return res.status(404).json({msg: 'Entrada no encontrada'})
        }

        res.json(entrada)
    } catch(error) {
        res.status(500).json({msg: 'Error al encontrar la entrada'})
    }
}

export const crearEntrada = async (req, res) => {
    try {
        const nuevaEntrada = new Historial(req.body)
        await nuevaEntrada.save()

        res.status(201).json({msg: 'Entrada guardada correctamente', nuevaEntrada})
    } catch(error) {
        res.status(500).json({msg: 'Error al guardar la entrada'})
    }
}

export const eliminarEntrada = async (req, res) => {
    const {id} = req.params

    try {
        const entrada = await Historial.findByIdAndDelete(id)

        if(!entrada) {
            return res.status(404).json({msg: 'Registro no encontrado'})
        }

        res.json({msg: 'Registro eliminado correctamente'})
    } catch(error) {
        res.status(500).json({msg: 'Error al eliminar el registro'})
    }
}

export const eliminarHistorialPaciente = async (req, res) => {
    const {pacienteID} = req.params

    try {
        const resultado = await Historial.deleteMany({pacienteID})

        if(resultado.deletedCount === 0) {
            return res.status(404).json({msg: 'No hay entradas para este paciente'})
        }

        res.json({msg: `Se han borrado ${resultado.deletedCount} entradas del paciente`})
    } catch(error) {
        res.status(500).json({msg: 'Error al eliminar el historail del paciente'})
    }
}

export const eliminarTodosLosHistoriales = async (req, res) => {
    try {
        const resultado = await Historial.deleteMany({}) //si se queda vacio no hay filtro y borra todo
        res.json({msg: 'Todos los historiales han sido eliminados'})
    } catch(error) {
        res.status(500).json({msg: 'Error al vaciar la colección'})
    }
}