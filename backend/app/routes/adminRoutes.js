import { Router } from 'express';
import { metricasGenerales } from '../controllers/adminController.js'
import { validarJWT } from '../middlewares/validarJWT.js'
import { esAdmin } from '../middlewares/validarRol.js'

const router = Router();

router.use(validarJWT)
router.use(esAdmin)

router.get('/metricas', metricasGenerales)

export default router