import { Sequelize, sequelize } from 'sequelize'
import dotenv from 'dotenv'
dotenv.config()

export const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_SEQ_USER,
    {
        host: process.env.DB_HOST,
        dialect: 'postgres',
        logging: false
    }
)