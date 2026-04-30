import { fakerES as faker } from '@faker-js/faker';
import Paciente from '../models/Paciente.js'

export const getPacientes = async (req, res) => {
    try {
        const pacientes = await Paciente.findAll()

        res.json(pacientes)
    } catch (error){
        res.status(500).json({msg: 'Error al obtener pacientes'})
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

export const generarPacientesAleatorios = async (req, res) => {
    //enviamos la cantidad por el body
    const {cantidad} = req.body

    if(cantidad <= 0) {
        return res.status(400).json({msg: 'Esa cantidad no es válida'})
    }

    try {
        const pacientes = []

        for (let index = 0; index < cantidad; index++) {
            const nombre = faker.person.firstName()

            //faker nos da apellidos completos, por eso los cortamos para tener un apellido en cada campo
            const apellido1 = faker.person.lastName().split(' ')[0]
            const apellido2 = faker.person.lastName().split(' ')[0]

            //dni con 8 números y 1 letra
            const dni = faker.string.numeric(8) + faker.string.alpha(1).toUpperCase()
            
            pacientes.push({
                nombre,
                apellido1,
                apellido2,
                dni,
                fecha_nacimiento: faker.date.birthdate({min: 0, max: 99, mode: 'age'}),
                telefono: faker.phone.number('6#######')
            })
        }

        //esta funcion inserta todos los registros en una consulta
        await Paciente.bulkCreate(pacientes)

        res.status(201).json({msg: 'Se han generado los pacientes correctamente'})
    } catch(error) {
        res.status(500).json({msg: 'Error al generar los pacientes'})
    }
}