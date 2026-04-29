import { Router } from 'express'
import { getPacientes, crearPaciente, actualizarPaciente, eliminarPaciente, buscarPaciente } from '../controllers/pacienteController.js'
import { validarJWT } from '../middlewares/validarJWT.js'
import { esAdmin } from '../middlewares/validarRol.js'

const router = Router()

router.use(validarJWT)

router.get('/', esAdmin, getPacientes)
router.get('/:id', esAdmin, buscarPaciente)
router.post('/', esAdmin, crearPaciente)
router.put('/:id', esAdmin, actualizarPaciente)
router.delete('/:id', esAdmin, eliminarPaciente)

export default router