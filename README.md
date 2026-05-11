# 🏥 **Proyecto de Gestión de Clínica Médica**

Aplicación completa para la gestión integral de una clínica médica, desarrollada con Node.js + Express en el backend, Vite Vanilla en el frontend, MySQL/PostgreSQL como base de datos relacional y MongoDB para historiales clínicos. Incluye autenticación con tokens, sistema de roles, WebSockets y consultas GraphQL.

## **🧱 Arquitectura General**

La aplicación se divide en tres capas principales:

### **Backend (Node.js + Express)**

* API REST para la gestión de pacientes, citas, usuarios y roles.
* GraphQL para consultas avanzadas.
* WebSockets para actualizaciones en tiempo real.
* JWT para autenticación.
* MySQL/PostgreSQL para datos estructurados.
* MongoDB para historiales clínicos.

### **Frontend (Vite + JavaScript Vanilla)**

* Pantalla de login.
* Panel principal adaptado al rol.
* Gestión de pacientes y citas.
* Visualización de historiales clínicos.

### **Bases de Datos**

* SQL: usuarios, roles, pacientes, citas.
* MongoDB: historiales clínicos.

## **Rutas de la API**

### Autenticación

| Método  | Ruta                   | Acceso   | Descripción                                                                     |
| -------- | ---------------------- | -------- | -------------------------------------------------------------------------------- |
| `POST` | `/api/auth/login`    | Público | Inicia sesión y devuelve el usuario junto con el token JWT.                     |
| `POST` | `/api/auth/register` | Público | Registra un usuario. En la práctica, en la aplicación lo usa el administrador. |

### Administración

| Método  | Ruta                              | Acceso    | Descripción                             |
| -------- | --------------------------------- | --------- | ---------------------------------------- |
| `GET`  | `/api/admin/metricas`           | `admin` | Obtiene métricas generales del sistema. |
| `POST` | `/api/admin/generar-aleatorios` | `admin` | Genera pacientes aleatorios.             |
| `POST` | `/api/admin/usuarios`           | `admin` | Crea un nuevo usuario.                   |

### Usuarios

| Método    | Ruta                  | Acceso    | Descripción                    |
| ---------- | --------------------- | --------- | ------------------------------- |
| `GET`    | `/api/usuarios`     | `admin` | Lista todos los usuarios.       |
| `GET`    | `/api/usuarios/:id` | `admin` | Busca un usuario por ID.        |
| `PUT`    | `/api/usuarios/:id` | `admin` | Actualiza un usuario existente. |
| `DELETE` | `/api/usuarios/:id` | `admin` | Elimina un usuario.             |

### Pacientes

| Método    | Ruta                   | Acceso    | Descripción               |
| ---------- | ---------------------- | --------- | -------------------------- |
| `GET`    | `/api/pacientes`     | `admin` | Lista todos los pacientes. |
| `GET`    | `/api/pacientes/:id` | `admin` | Busca un paciente por ID.  |
| `POST`   | `/api/pacientes`     | `admin` | Crea un paciente.          |
| `PUT`    | `/api/pacientes/:id` | `admin` | Actualiza un paciente.     |
| `DELETE` | `/api/pacientes/:id` | `admin` | Elimina un paciente.       |

### Citas

| Método    | Ruta               | Acceso    | Descripción           |
| ---------- | ------------------ | --------- | ---------------------- |
| `GET`    | `/api/citas`     | `admin` | Lista todas las citas. |
| `GET`    | `/api/citas/:id` | `admin` | Busca una cita por ID. |
| `POST`   | `/api/citas`     | `admin` | Crea una cita.         |
| `PUT`    | `/api/citas/:id` | `admin` | Actualiza una cita.    |
| `DELETE` | `/api/citas/:id` | `admin` | Elimina una cita.      |

### Médico

| Método  | Ruta                                  | Acceso     | Descripción                                              |
| -------- | ------------------------------------- | ---------- | --------------------------------------------------------- |
| `GET`  | `/api/medico/mis-citas`             | `medico` | Obtiene las citas asignadas al médico autenticado.       |
| `PUT`  | `/api/medico/cita/:id/estado`       | `medico` | Actualiza el estado de una cita propia.                   |
| `POST` | `/api/medico/historial`             | `medico` | Crea una entrada en el historial clínico de un paciente. |
| `GET`  | `/api/medico/historial/:pacienteID` | `medico` | Consulta el historial clínico de un paciente.            |

### Recepcionista

| Método  | Ruta                                     | Acceso            | Descripción                                       |
| -------- | ---------------------------------------- | ----------------- | -------------------------------------------------- |
| `POST` | `/api/recepcionista/paciente`          | `recepcionista` | Crea un paciente.                                  |
| `POST` | `/api/recepcionista/cita`              | `recepcionista` | Crea una cita.                                     |
| `GET`  | `/api/recepcionista/agenda`            | `recepcionista` | Consulta la agenda general de citas.               |
| `GET`  | `/api/recepcionista/pacientes`         | `recepcionista` | Lista los pacientes disponibles para recepción.   |
| `GET`  | `/api/recepcionista/medicos`           | `recepcionista` | Lista los médicos disponibles para asignar citas. |
| `PUT`  | `/api/recepcionista/cancelar-cita/:id` | `recepcionista` | Cancela una cita.                                  |

### Historial clínico

| Método    | Ruta                                    | Acceso    | Descripción                                    |
| ---------- | --------------------------------------- | --------- | ----------------------------------------------- |
| `POST`   | `/api/historial`                      | `admin` | Crea una entrada en el historial clínico.      |
| `GET`    | `/api/historial`                      | `admin` | Lista todos los historiales.                    |
| `GET`    | `/api/historial/paciente/:pacienteID` | `admin` | Consulta el historial de un paciente.           |
| `GET`    | `/api/historial/entrada/:id`          | `admin` | Busca una entrada concreta del historial.       |
| `PUT`    | `/api/historial/entrada/:id`          | `admin` | Actualiza una entrada del historial.            |
| `DELETE` | `/api/historial/entrada/:id`          | `admin` | Elimina una entrada del historial.              |
| `DELETE` | `/api/historial/paciente/:pacienteID` | `admin` | Elimina todo el historial de un paciente.       |
| `DELETE` | `/api/historial/danger/reset-all`     | `admin` | Elimina todos los historiales de la colección. |

### GraphQL

| Método  | Ruta         | Acceso          | Descripción                   |
| -------- | ------------ | --------------- | ------------------------------ |
| `POST` | `/graphql` | Según consulta | Endpoint GraphQL del proyecto. |

## Autenticación

Las rutas protegidas requieren enviar el token JWT en la cabecera:

```http
access-token: TU_TOKEN_JWT
```

## **⚙️ Instalación y Puesta en Marcha**

### **Requisitos Previos**

* Node.js 18+
* PostgreSQL
* MongoDB
* npm

### **1. Clonar el repositorio**

```bash
git clone https://github.com/noeBR97/RecuperacionNode-GestionClinica.git

cd RecuperacionNode-GestionClinica
```

### **2. Configurar variables de entorno**

Crear archivo ``.env`` en la carpeta del backend, a partir del ``.env.example``:

```bash
PORT=3000
DB_NAME=GestionClinica
DB_PORT=27017
DB_URL=mongodb://localhost:27017/
DB_SEQ_USER=postgres
DB_SEQ_PASS=tu_password
DB_HOST=localhost
SECRETORPRIVATEKEY=una_clave_segura
```

### **3. Instalar dependencias**

Backend:

```bash
cd backend
npm install
```

Frontend:

```bash
cd frontend
npm install
```

### **4. Crear la base de datos PostgreSQL**

``createdb -U postgres GestionClinica ``

### **4.1. Ejecutar seeders (usuarios)**

``npx sequelize-cli db:seed:all``

### **5. Restaurar PostgreSQL**

``psql -U postgres -d GestionClinica -f bbdd/GestionClinica_postgres.sql ``

### **6. Restaurar MongoDB(si se usa Compass)**

* Conectarse a ``mongodb://localhost:27017``
* Crear o abrir la base **GestionClinica**
* Crear la colección **historiales**
* Importar ``bbdd/GestionClinica.historiales.json``

### **7. Arrancar backend**

```bash
cd backend
npm run dev
```

### **8. Arrancar frontend**

```bash
cd frontend
npm run dev
```

## **🗂️ Modelado de Datos**

### **Base de Datos Relacional (SQL)**

Tablas principales:

* usuarios (id, nombre, email, contraseña, rol)
* pacientes (id, nombre, dirección, teléfono)
* citas (id, paciente_id, medico_id, fecha, estado)
* roles (admin, recepcionista, medico)

### **Base de Datos NoSQL (MongoDB)**

Colección: historiales

```bash
{
  "id_paciente": 12,
  "entradas": [
    {
      "fecha": "2026-03-17",
      "id_medico": 4,
      "observaciones": "Dolor abdominal persistente",
      "diagnostico": "Gastritis",
      "tratamiento": "Omeprazol 20mg"
    }
  ]
}
```

## **🔐 Sistema de Roles y Permisos**

### **Administrador**

* Crear médicos y recepcionistas.
* Generar pacientes aleatorios.
* Eliminar citas o pacientes.
* Consultar métricas.

### **Médico**

* Ver citas asignadas.
* Cambiar estado de cita.
* Añadir entradas al historial.
* Consultar historial completo.

### **Recepcionista**

* Crear pacientes.
* Crear y cancelar citas.
* Consultar agenda general.

## **🛡️ Autenticación y Seguridad**

### **Flujo de autenticación**

1. Registro de usuario.
2. Login → generación de JWT.
3. Middleware de verificación.
4. Middleware de permisos según rol.

## **🔌 WebSockets**

Se utiliza para:

* Actualizar número de citas pendientes.
* Actualizar agenda en tiempo real.

## **📊 Consultas GraphQL**

### **1. Total de citas finalizadas por médico**

```bash
query {
  citasFinalizadasPorMedico {
    medico
    total
  }
}
```

### **2. Citas pendientes del día**

```bash
query {
  citasPendientesHoy {
    id
    paciente
    hora
  }
}
```

### **3. Duración promedio por médico**

```bash
query {
  duracionPromedioPorMedico {
    medico
    promedio
  }
}
```

### **4. Historial completo de un paciente**

```bash
query {
  historialPaciente(id: 12) {
    entradas {
      fecha
      diagnostico
      tratamiento
    }
  }
}
```

## **🖥️ Cliente (Frontend)**

### **Pantallas incluidas**

* Login
* Panel principal según rol
* Gestión de pacientes
* Gestión de citas
* Historial clínico

### **Tecnologías**

* HTML + CSS + JS
* Vite para desarrollo rápido
* Fetch API para consumir backend
* Socket.io para tiempo real

## **📦 Exportación de Datos**

* Archivo .sql con la base de datos relacional.
* Exportación de colecciones MongoDB (.json).
* Cliente funcional.

## **📁 Estructura del Proyecto**

```bash
RecuperacionNode-GestionClinica/
├── backend/
│   └── app/
│       ├── config/
│       ├── controllers/
│       ├── graphql/
│       │   ├── controllers/
│       │   ├── resolvers/
│       │   └── typeDefs/
│       ├── helpers/
│       ├── middlewares/
│       ├── models/
│       ├── routes/
│       └── sockets/
└── frontend/
    ├── public/
    └── src/
        ├── app/
        └── html/
├── bbdd/
├── coleccion postman/
```

## **🔄 Ejemplo de Flujo Completo**

1. Recepcionista crea paciente.
2. Recepcionista crea cita.
3. Médico inicia la cita → estado "en curso".
4. Médico finaliza la cita → añade entrada al historial.
5. WebSocket actualiza panel de todos los usuarios.
6. Admin consulta métricas.

## **📝 Notas Finales**

Este proyecto integra múltiples tecnologías modernas para simular un sistema real de gestión clínica, con seguridad, tiempo real, consultas avanzadas y separación clara entre datos estructurados y no estructurados.

