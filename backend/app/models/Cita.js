import { DataTypes, Model } from "sequelize";
import { sequelize as db } from "../config/db.js";
import Usuario from "./Usuario.js";
import Paciente from "./Paciente.js";

class Cita extends Model{}

Cita.init(
    {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        fecha: {
            type: DataTypes.DATE,
            allowNull: false,
            validate: {
                notEmpty: {msg: 'La fecha es obligatoria'},
                isDate: {msg: 'Debe ser una fecha válida'},
                isAfter: {
                    args: new Date().toISOString(),
                    msg: 'La cita no puede ser en pasado'
                }
            }
        },
        motivo: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: {
                notEmpty: {msg: 'El motivo de la cita es obligatorio'},
                len: {args: [5, 255], msg: 'El motivo debe tener entre 5 y 255 caracteres'}
            }
        },
        estado: {
            type: DataTypes.ENUM('pendiente', 'en curso', 'finalizada', 'cancelada'),
            allowNull: false,
            defaultValue: 'pendiente',
            isIn: {
                args: [['pendiente', 'en curso', 'finalizada']],
                msg: 'El estado debe ser pendiente, en curso o finalizada'
            }
        }
    },
    {
        sequelize: db,
        tableName: 'citas',
        modelName: 'Cita',
        timestamps: true,
    }
)

//RELACIONES
Cita.belongsTo(Paciente, {as: 'paciente', foreignKey: 'pacienteID'})

Cita.belongsTo(Usuario, {as: 'medico', foreignKey: 'medicoID'})

export default Cita