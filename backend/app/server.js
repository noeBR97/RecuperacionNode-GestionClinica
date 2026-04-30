import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { sequelize } from './config/db.js'
import mongoose from "mongoose";
import { conectarMongo } from './config/mongo.js';
import Usuario from './models/Usuario.js';
import authRoutes from './routes/authRoutes.js'
import usuarioRoutes from './routes/usuarioRoutes.js'
import pacienteRoutes from './routes/pacienteRoutes.js'
import citaRoutes from './routes/citaRoutes.js'
import historialRoutes from './routes/historialRoutes.js'
import adminRoutes from './routes/adminRoutes.js'

dotenv.config()
mongoose.set('strictQuery', false);


class Server {

    constructor() {
        this.app = express();
        this.port = process.env.PORT || 3000

        this.paths = {
            auth: '/api/auth',
            usuarios: '/api/usuarios',
            citas: '/api/citas',
            historial: '/api/historial',
            pacientes: '/api/pacientes',
            admin: '/api/admin'
        }

        this.middlewares();

        this.conectarDbs()

        this.routes();
        
    }

    async conectarDbs() {
        //Conexión con Mongo 
        try {
            await conectarMongo()
            console.log('🔵 MongoDB: Conexión establecida correctamente.')
        } catch (error) {
            console.error('❌ Error en MongoDB: ', error)
        }

        //Conexión Postgres
        try {
            await sequelize.authenticate()
            await sequelize.sync({alter: true})
            console.log('🔵 Postgres: Conexión exitosa. Tablas sincronizadas correctamente.')
        } catch (error) {
            console.error('❌ Error en Postgres:', error)
        }
    }

    middlewares() {
        this.app.use(cors());
        this.app.use(express.json());
    }

    routes(){
        this.app.use(this.paths.auth, authRoutes)
        this.app.use(this.paths.usuarios, usuarioRoutes)
        this.app.use(this.paths.pacientes, pacienteRoutes)
        this.app.use(this.paths.citas, citaRoutes)
        this.app.use(this.paths.historial, historialRoutes)
        this.app.use(this.paths.admin, adminRoutes)
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log(`🟢 Servidor API escuchando en: ${this.port}`);
        })
    }
}

export {Server};