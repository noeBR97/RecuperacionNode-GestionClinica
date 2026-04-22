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

* Conexión WebSocket para tiempo real.

### **Bases de Datos**

* SQL: usuarios, roles, pacientes, citas.

* MongoDB: historiales clínicos.

## **⚙️ Instalación y Puesta en Marcha**

### **Requisitos Previos**

* Node.js 18+

* MySQL o PostgreSQL

* MongoDB

* npm o pnpm

### **1. Clonar el repositorio**

```bash
git clone https://github.com/noeBR97/RecuperacionNode-GestionClinica.git

cd clinica-app
```

### **2. Configurar variables de entorno**

Crear archivo ``.env`` en la carpeta del backend, a partir del ``.env.example``:

```bash
PORT=4000
SQL_HOST=localhost
SQL_USER=root
SQL_PASSWORD=1234
SQL_DATABASE=clinica
MONGO_URI=mongodb://localhost:27017/clinica
JWT_SECRET=supersecreto
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

### **4. Ejecutar migraciones SQL**

``npm run migrate``

### **5. Iniciar Backend**

``npm run dev``

### **6. Iniciar Frontend**

``npm run dev``

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
      "tratamiento": "Omeprazol 20mg",
      "archivos": []
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

1. Login → generación de JWT.

2. Middleware de verificación.

3. Middleware de permisos según rol.

## **🔌 WebSockets**

Se utiliza para:

* Actualizar número de citas pendientes.

* Actualizar agenda en tiempo real.

* Notificaciones visuales.

Eventos principales:

* cita_creada

* cita_cancelada

* cita_actualizada

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
clinica-app/
│
├── backend/
│   ├── src/
│   │   ├── controllers/
│   │   ├── routes/
│   │   ├── models/
│   │   ├── graphql/
│   │   ├── websockets/
│   │   └── middlewares/
│   └── index.js
│
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   ├── components/
│   │   └── services/
│   └── main.js
│
└── README.md
```

## **🔄 Ejemplo de Flujo Completo**

1. Recepcionista crea paciente.

1. Recepcionista crea cita.

2. Médico inicia la cita → estado "en curso".

3. Médico finaliza la cita → añade entrada al historial.

4. WebSocket actualiza panel de todos los usuarios.

5. Admin consulta métricas.

## **📝 Notas Finales**

Este proyecto integra múltiples tecnologías modernas para simular un sistema real de gestión clínica, con seguridad, tiempo real, consultas avanzadas y separación clara entre datos estructurados y no estructurados.
