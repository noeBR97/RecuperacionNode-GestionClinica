import jwt from 'jsonwebtoken'
import dotenv from 'dotenv';
dotenv.config();

export const generarJWT = (id = '', rol = '') => {
    console.log("Generando token para id: " + id)
    console.log("Rol asignado: ", rol);

    const payload = { id, rol }

    let token = jwt.sign( payload, process.env.SECRETORPRIVATEKEY, {
        expiresIn: '4h' 
    });

    return token;
}