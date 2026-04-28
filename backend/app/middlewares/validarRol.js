import { response } from "express";

export const esAdmin = (req, res, next) => {
    if(!req.rolToken) {
        return res.status(500).json({msg: 'Se requiere una validación del token primero.'})
    }

    if (req.rolToken !== 'admin'){
        return res.status(500).json({'msg':'No es posible el acceso como administrador.'})
    }

    console.log('Accediendo como administrador...')
    next()
}


export const esMedico = (req, res, next) => {
    if(!req.rolToken) {
        return res.status(500).json({msg: 'Se requiere una validación del token primero.'})
    }

    if (req.rolToken !== 'medico'){
        return res.status(500).json({'msg':'No es posible el acceso como médico.'})
    }

    console.log('Accediendo como médico...')
    next()
}

export const esRecepcionista = (req, res, next) => {
    if(!req.rolToken) {
        return res.status(500).json({msg: 'Se requiere una validación del token primero.'})
    }

    if (req.rolToken !== 'recepcionista'){
        return res.status(500).json({'msg':'No es posible el acceso como recepcionista.'})
    }

    console.log('Accediendo como recepcionista...')
    next()
}
