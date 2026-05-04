import { Router } from 'express'
import { validarJWT } from '../middlewares/validarJWT.js'
import { esRecepcionista } from '../middlewares/validarRol.js'
import { crearPaciente } from '../controllers/pacienteController.js'
import { crearCita, getCitas } from '../controllers/citaController.js'
import { cancelarCita } from '../controllers/recepcionistaController.js'

const router = Router()

router.use(validarJWT)
router.use(esRecepcionista)

router.post('/paciente', crearPaciente)
router.post('/cita', crearCita)
router.get('/agenda', getCitas)
router.put('/cancelar-cita/:id', cancelarCita)

export default router