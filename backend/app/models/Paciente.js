import { DataTypes, Model } from "sequelize";
import { sequelize as db } from "../config/db.js";

class Paciente extends Model{}

Paciente.init(
    {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        dni: {
            type: DataTypes.STRING,
            unique: true,
            allowNull: false,
            validate: {
                notEmpty: { msg: "El DNI es obligatorio" }
            }
        },
        nombre: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: { notEmpty: { msg: "El nombre es obligatorio" } }
        },
        apellido1: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: { notEmpty: { msg: "El primer apellido es obligatorio" } }
        },
        apellido2: {
            type: DataTypes.STRING,
            allowNull: true
        },
        telefono: {
            type: DataTypes.STRING,
            validate: {
                isNumeric: { msg: "El teléfono solo debe contener números" }
            }
        },
        fecha_nacimiento: {
            type: DataTypes.DATEONLY, // Solo fecha, sin hora
            allowNull: true
        }
    },
    {
        sequelize: db,
        tableName: 'pacientes',
        modelName: 'Paciente',
        timestamps: true
    }
)

export default Paciente