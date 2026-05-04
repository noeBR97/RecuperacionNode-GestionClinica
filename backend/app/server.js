import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import { ApolloServer } from '@apollo/server'
import { expressMiddleware } from '@as-integrations/express5'
import { sequelize } from './config/db.js'
import { conectarMongo } from './config/mongo.js'
import authRoutes from './routes/authRoutes.js'
import usuarioRoutes from './routes/usuarioRoutes.js'
import pacienteRoutes from './routes/pacienteRoutes.js'
import citaRoutes from './routes/citaRoutes.js'
import historialRoutes from './routes/historialRoutes.js'
import adminRoutes from './routes/adminRoutes.js'
import medicoRoutes from './routes/medicoRoutes.js'
import recepcionistaRoutes from './routes/recepcionistaRoutes.js'
import typeDefs from './graphql/typeDefs/typeDefs.js'
import resolvers from './graphql/resolvers/resolvers.js'

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
            admin: '/api/admin',
            medico: '/api/medico',
            recepcionista: '/api/recepcionista',
            graphql: '/graphql'
        }

        this.middlewares()
        this.routes()

        this.serverGraphQL = new ApolloServer({
            typeDefs,
            resolvers,
            plugins: [
                {
                    async requestDidStart() {
                        return {
                            async willSendResponse({ response, errors }) {
                                if (errors && response.body.kind === 'single') {
                                    response.body.singleResult.errors = errors.map((error) => ({
                                        message: error.message
                                    }))
                                }
                            }
                        }
                    }
                }
            ]
        })
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
        this.app.use(this.paths.medico, medicoRoutes)
        this.app.use(this.paths.recepcionista, recepcionistaRoutes)
    }

    applyGraphQLMiddleware() {
        this.app.use(
            this.paths.graphql,
            express.json(),
            expressMiddleware(this.serverGraphQL, {
                context: async ({ req, res }) => ({ req, res })
            })
        )
    }

    async start() {
        await this.conectarDbs()
        await this.serverGraphQL.start()
        console.log('Iniciando servidor Apollo Server GraphQL...')
        this.applyGraphQLMiddleware()
        this.listen()
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log(`🟢 Servidor API escuchando en: ${this.port}`);
            console.log(`🟢 Servidor GraphQL escuchando en: http://localhost:${this.port}${this.paths.graphql}`)
        })
    }
}

export {Server};