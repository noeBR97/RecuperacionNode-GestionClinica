import { Router } from 'express'
import { getUsuarios, buscarUsuario, actualizarUsuario, eliminarUsuario } from '../controllers/usuarioController.js'
import { validarJWT } from '../middlewares/validarJWT.js'
import { esAdmin } from '../middlewares/validarRol.js'

const router = Router()

router.use(validarJWT)
router.use(esAdmin)

router.get('/', getUsuarios)
router.get('/:id', buscarUsuario)
router.put('/:id', actualizarUsuario)
router.delete('/:id', eliminarUsuario)

export default router