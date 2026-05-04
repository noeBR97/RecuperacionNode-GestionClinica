import { Router } from 'express'
import { validarJWT } from '../middlewares/validarJWT.js';
import { esMedico } from '../middlewares/validarRol.js';
import { obtenerMisCitas, actualizarEstadoCita } from '../controllers/medicoController.js';
import { crearEntrada, buscarHistorial } from '../controllers/historialController.js';
const router = Router();

router.use(validarJWT)
router.use(esMedico)

router.get('/mis-citas', obtenerMisCitas)
router.put('/cita/:id/estado', actualizarEstadoCita)
router.post('/historial', crearEntrada)
router.get('/historial/:pacienteID', buscarHistorial)

export default router