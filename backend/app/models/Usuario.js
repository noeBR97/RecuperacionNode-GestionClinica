import { DataTypes, Model } from "sequelize";
import { sequelize as db } from "../config/db.js";
import bcrypt from "bcrypt";

class Usuario extends Model {
    async validarClave(clavePlana) {
        return await bcrypt.compare(clavePlana, this.clave)
    }
}

Usuario.init(
    {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        nombre: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: {
                notEmpty: { msg: "El nombre es obligatorio" },
                len: { args: [2, 50], msg: "El nombre debe tener entre 2 y 50 caracteres" },
            },
        },
        apellido1: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: {
                notEmpty: { msg: "El apellido es obligatorio" },
                len: { args: [2, 50], msg: "El apellido debe tener entre 2 y 50 caracteres" },
            },
        },
        apellido2: {
            type: DataTypes.STRING,
            allowNull: true,
            validate: {
                len: { args: [2, 50], msg: "El apellido debe tener entre 2 y 50 caracteres" },
            },
        },
        email: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
            validate: {
                isEmail: {msg: 'Debe ser un correo electrónico válido'}
            },
        },
        clave: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: {
                notEmpty: { msg: "La clave no puede estar vacía." },
            },
        },
        rol: {
            type: DataTypes.ENUM('admin', 'medico', 'recepcionista'),
            allowNull: false,
            defaultValue: 'recepcionista',
            validate: {
                isIn: {
                    args: [['admin', 'medico', 'recepcionista']],
                    msg: 'El rol debe ser admin, médico o recepcionista.'
                }
            },
        },
        tfno: {
            type: DataTypes.STRING
        }
    },
    {
        sequelize: db,
        tableName: 'usuarios',
        modelName: 'Usuario',
        timestamps: true,
        hooks: {
            beforeCreate: async (usuario) => {
                usuario.clave = await bcrypt.hash(usuario.clave, 10)
            },
            beforeUpdate: async (usuario) => {
                if (usuario.changed('clave')) {
                    usuario.clave = await bcrypt.hash(usuario.clave, 10)
                }
            },
        }
    }
)

export default Usuario