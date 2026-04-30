import { Router } from 'express'
import { crearCita, getCitas, buscarCita, actualizarCita, eliminarCita } from '../controllers/citaController.js'
import { validarJWT } from '../middlewares/validarJWT.js'
import { esAdmin } from '../middlewares/validarRol.js'

const router = Router()

router.use(validarJWT)
router.use(esAdmin)

router.get('/', getCitas)
router.get('/:id', buscarCita)
router.post('/', crearCita)
router.put('/:id', actualizarCita)
router.delete('/:id', eliminarCita)

export default router;