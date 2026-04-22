import mongoose from "mongoose";
import dotenv from 'dotenv'

dotenv.config()

export const conectarMongo = async () => {
    try {
        await mongoose.connect(process.env.DB_URL, {
            dbName: process.env.DB_NAME,
        });
        return true
    } catch (error) {
        throw new Error('❌ Error al conectar a MongoDB:', error)
    }
}