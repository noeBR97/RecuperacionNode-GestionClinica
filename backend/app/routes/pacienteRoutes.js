import { Router } from 'express'
import { 
    getPacientes, 
    crearPaciente, 
    actualizarPaciente, 
    eliminarPaciente, 
    buscarPaciente, 
    generarPacientesAleatorios 
} from '../controllers/pacienteController.js'
import { validarJWT } from '../middlewares/validarJWT.js'
import { esAdmin } from '../middlewares/validarRol.js'

const router = Router()

router.use(validarJWT)
router.use(esAdmin)

router.get('/', getPacientes)
router.get('/:id', buscarPaciente)
router.post('/', crearPaciente)
router.put('/:id', actualizarPaciente)
router.delete('/:id', eliminarPaciente)
router.post('/generar-aleatorios', generarPacientesAleatorios)

export default router