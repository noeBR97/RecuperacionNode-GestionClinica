import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { sequelize } from '../config/db.js'
import mongoose from "mongoose";
import { conectarMongo } from './config/mongo.js';

dotenv.config()
mongoose.set('strictQuery', false);


class Server {

    constructor() {
        this.app = express();
        this.port = process.env.PORT || 3000

        this.paths = {
            usuarios: '/api/usuarios',
            citas: '/api/citas',
            historial: '/api/historial'
        }

        this.middlewares();

        this.conectarMongoose();

        this.routes();
        
    }

    conectarDbs() {
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
            console.log('🔵 Postgres: Conexión exitosa')
        } catch (error) {
            console.error('❌ Error en Postgres:', error)
        }
    }

    middlewares() {
        this.app.use(cors());
        this.app.use(express.json());
    }

    routes(){
        
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log(`🟢 Servidor API escuchando en: ${this.port}`);
        })
    }
}

export {Server};