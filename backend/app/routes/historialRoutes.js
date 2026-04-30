import { Router } from 'express'
import { getHistoriales, crearEntrada, buscarHistorial, eliminarEntrada, buscarEntrada, eliminarHistorialPaciente, eliminarTodosLosHistoriales } from '../controllers/historialController.js'
import { validarJWT } from '../middlewares/validarJWT.js';
import { esAdmin } from '../middlewares/validarRol.js';

const router = Router();

router.use(validarJWT);
router.use(esAdmin);

router.post('/', crearEntrada);
router.get('/', getHistoriales);
router.get('/paciente/:pacienteID', buscarHistorial);
router.get('/entrada/:id', buscarEntrada);
router.delete('/entrada/:id', eliminarEntrada);
router.delete('/paciente/:pacienteID', eliminarHistorialPaciente);

//rutal especial y peligrosa
router.delete('/danger/reset-all', eliminarTodosLosHistoriales);

export default router;