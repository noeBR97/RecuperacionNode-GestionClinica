import {response,request} from 'express';
import Usuario from '../models/Usuario.js';
import { generarJWT } from '../helpers/generate_jwt.js'

export const registrar = async (req = request, res = response) => {
    try {
        Usuario.create(req.body)
            .then(usuario => {
                console.log('Usuario registrado correctamente. ID: ' + usuario.id)
                res.status(201).json({msg: 'Registro exitoso', usuario})
            })
            .catch(err => {
                console.log('Fallo en el registro')
                res.status(203).json({msg: 'Error al registrar el usuario', error: err.msg})
            })
    } catch (error) {
        console.log(error)
        res.status(500).json({msg: 'Error en el servidor'})
    }
}

export const login =  (req, res = response) => {
    const {email, clave} = req.body;
    try {
        Usuario.findOne({where: { email }})
            .then(usuario => {
                if(!usuario) {
                    console.log('No existe el usuario.')
                    return res.status(500).json({'msg': 'Login incorrecto'})
                }

                //verificacion de contraseña en el metodo del modelo usuario
                usuario.validarClave(clave)
                    .then(valida => {
                        if(!valida) {
                            console.log('Clave incorrecta para el usuario ' + email)
                            return res.status(500).json({'msg': 'Login incorrecto'})
                        }

                        //se genera token
                        const token = generarJWT(usuario.id, usuario.rol)

                        console.log('Login correcto. ' + usuario.email)
                        console.log('Token generado: ', token)

                        res.status(200).json({usuario, token})
                    })
                    .catch(err => {
                        console.log('Error al validar la clave.')
                        res.status(500).json({'msg': 'Login incorrecto'})
                    })
            })
            .catch(err => {
                console.log('Error en la consulta a BBDD.')
                res.status(500).json({'msg': 'Login incorrecto'})
            })
    } catch (error) {
        console.log(error)
        res.status(500).json({msg: 'Error en el servidor'})
    }
}