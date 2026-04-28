import jwt from 'jsonwebtoken';

export const validarJWT = (req , res , next) => {  
    const token = req.header('access-token')

    if (!token){
        return res.status(401).json({'msg':'No hay token en la petición.'})
    }

    try {
        const {id, rol} = jwt.verify(token, process.env.SECRETORPRIVATEKEY)

        req.idToken = id
        req.rolToken = rol

        console.log('Token verificado para el ID: ', id)
        console.log('Rol: ', rol)
        console.log('Token: ', token)

        next()
        
    }catch(error){
        console.log('Error al verificar JWT: ', error);
        res.status(401).json({'msg': 'Token no válido.'})
    }
}