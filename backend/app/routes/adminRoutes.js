import { Router } from 'express';
import { validarJWT } from '../middlewares/validarJWT.js'
import { esAdmin } from '../middlewares/validarRol.js'
import { metricasGenerales } from '../controllers/adminController.js'
import { generarPacientesAleatorios } from '../controllers/pacienteController.js'
import { registrar } from '../controllers/authController.js'

const router = Router();

router.use(validarJWT)
router.use(esAdmin)

router.get('/metricas', metricasGenerales)
router.post('/generar-aleatorios', generarPacientesAleatorios)
router.post('/usuarios', registrar);

export default router