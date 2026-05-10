import './style.css';
import { connectSocket, disconnectSocket, onAgendaUpdate } from './api/socket.js';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';
const app = document.querySelector('#app');

const state = {
  token: localStorage.getItem('clinica_token') || '',
  usuario: JSON.parse(localStorage.getItem('clinica_usuario') || 'null'),
  view: 'resumen',
  metrics: null,
  usuarios: [],
  pacientes: [],
  citas: [],
  historiales: [],
  selectedPacienteId: null,
  editingUserId: null,
  status: { text: '', type: 'success' },
};

const adminSections = [
  { id: 'resumen', label: 'Resumen' },
  { id: 'usuarios', label: 'Usuarios' },
  { id: 'pacientes', label: 'Pacientes' },
  { id: 'citas', label: 'Citas' },
];

const receptionSections = [
  { id: 'agenda', label: 'Agenda' },
  { id: 'nuevo-paciente', label: 'Nuevo paciente' },
  { id: 'nueva-cita', label: 'Nueva cita' },
];

const doctorSections = [
  { id: 'mis-citas', label: 'Mis citas' },
  { id: 'historial', label: 'Historial' },
];

const roleLabel = {
  admin: 'Administrador',
  medico: 'Médico',
  recepcionista: 'Recepcionista',
};

const escapeHTML = (value = '') =>
  String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');

const formatDate = (value) => {
  if (!value) return 'Sin fecha';
  return new Intl.DateTimeFormat('es-ES', {
    dateStyle: 'medium',
    timeStyle: 'short',
  }).format(new Date(value));
};

const setStatus = (text, type = 'success') => {
  state.status = { text, type };
  render();
};

const readForm = (form) => Object.fromEntries(new FormData(form).entries());

const apiRequest = async (path, options = {}) => {
  const response = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(state.token ? { 'access-token': state.token } : {}),
      ...(options.headers || {}),
    },
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok || response.status === 203) {
    throw new Error(data.msg || 'No se pudo completar la petición.');
  }

  return data;
};

const login = async (credentials) => {
  const data = await apiRequest('/api/auth/login', {
    method: 'POST',
    body: JSON.stringify(credentials),
  });

  state.token = data.token;
  state.usuario = data.usuario;
  localStorage.setItem('clinica_token', data.token);
  localStorage.setItem('clinica_usuario', JSON.stringify(data.usuario));
  connectSocket();

  if (data.usuario.rol === 'admin') {
    state.view = 'resumen';
    await loadAdminData();
    return;
  }

  if (data.usuario.rol === 'recepcionista') {
    state.view = 'agenda';
    await loadReceptionData();
    return;
  }

  if (data.usuario.rol === 'medico') {
    state.view = 'mis-citas';
    await loadDoctorData();
    return;
  }

  renderDenied();
};

const logout = () => {
  localStorage.removeItem('clinica_token');
  localStorage.removeItem('clinica_usuario');
  state.token = '';
  state.usuario = null;
  state.metrics = null;
  state.usuarios = [];
  state.pacientes = [];
  state.citas = [];
  state.historiales = [];
  state.selectedPacienteId = null;
  state.status = { text: '', type: 'success' };
  disconnectSocket();
  renderLogin();
};

const loadAdminData = async () => {
  try {
    const [metrics, usuarios, pacientes, citas] = await Promise.all([
      apiRequest('/api/admin/metricas'),
      apiRequest('/api/usuarios'),
      apiRequest('/api/pacientes'),
      apiRequest('/api/citas'),
    ]);

    state.metrics = metrics.resumen;
    state.usuarios = usuarios;
    state.pacientes = pacientes;
    state.citas = citas;
    state.status = { text: metrics.msg || '', type: 'success' };
    renderAdmin();
  } catch (error) {
    if (error.message.toLowerCase().includes('token')) {
      logout();
      return;
    }
    setStatus(error.message, 'error');
  }
};

const loadReceptionData = async () => {
  try {
    const [citas, pacientes, medicos] = await Promise.all([
      apiRequest('/api/recepcionista/agenda'),
      apiRequest('/api/recepcionista/pacientes'),
      apiRequest('/api/recepcionista/medicos'),
    ]);

    state.citas = citas;
    state.pacientes = pacientes;
    state.usuarios = medicos;
    state.status = { text: '', type: 'success' };
    renderReception();
  } catch (error) {
    if (error.message.toLowerCase().includes('token')) {
      logout();
      return;
    }
    setStatus(error.message, 'error');
  }
};

const loadDoctorData = async () => {
  try {
    const citas = await apiRequest('/api/medico/mis-citas');

    state.citas = citas;
    state.pacientes = getPatientsFromAppointments(citas);
    state.status = { text: '', type: 'success' };

    if (!state.selectedPacienteId && state.pacientes.length > 0) {
      state.selectedPacienteId = state.pacientes[0].id;
    }

    if (state.view === 'historial' && state.selectedPacienteId) {
      await loadDoctorHistory(state.selectedPacienteId, false);
      return;
    }

    renderDoctor();
  } catch (error) {
    if (error.message.toLowerCase().includes('token')) {
      logout();
      return;
    }
    setStatus(error.message, 'error');
  }
};

const loadDoctorHistory = async (pacienteID = state.selectedPacienteId, shouldRender = true) => {
  if (!pacienteID) {
    state.historiales = [];
    if (shouldRender) renderDoctor();
    return;
  }

  try {
    state.historiales = await apiRequest(`/api/medico/historial/${pacienteID}`);
  } catch (error) {
    if (error.message.includes('No se han encontrado')) {
      state.historiales = [];
    } else {
      throw error;
    }
  }

  if (shouldRender) renderDoctor();
};

const getPatientsFromAppointments = (citas) => {
  const patients = new Map();

  citas.forEach((cita) => {
    if (!cita.pacienteID || !cita.paciente) return;
    patients.set(cita.pacienteID, {
      id: cita.pacienteID,
      ...cita.paciente,
    });
  });

  return Array.from(patients.values());
};

const renderLogin = () => {
  app.innerHTML = `
    <main class="auth-shell">
      <section class="auth-brand" aria-label="Clínica Médica">
        <div class="brand-mark" aria-hidden="true">CM</div>
        <div class="brand-copy">
          <p class="eyebrow">Gestión Clínica</p>
          <h1>Clínica Médica</h1>
          <p>Acceso privado para coordinar usuarios, pacientes, citas e historiales desde un mismo entorno.</p>
        </div>
        <div class="brand-stats" aria-label="Áreas del sistema">
          <div>
            <strong>24h</strong>
            <span>Agenda actualizada</span>
          </div>
          <div>
            <strong>3</strong>
            <span>Roles operativos</span>
          </div>
          <div>
            <strong>JWT</strong>
            <span>Sesiones seguras</span>
          </div>
        </div>
      </section>

      <section class="auth-main">
        <div class="auth-panel">
          <div class="auth-header">
            <div>
              <h2>Iniciar sesión</h2>
              <p>Entra con el email y la contraseña de tu usuario.</p>
            </div>
          </div>

          <div id="message" class="message" role="status" aria-live="polite"></div>

          <form id="login-form" class="auth-form">
            <div class="field">
              <label for="login-email">Email</label>
              <input id="login-email" name="email" type="email" autocomplete="email" required />
            </div>
            <div class="field">
              <label for="login-clave">Contraseña</label>
              <input id="login-clave" name="clave" type="password" autocomplete="current-password" required />
            </div>
            <div class="submit-row">
              <button class="primary-button" type="submit">Entrar</button>
            </div>
          </form>
        </div>
      </section>
    </main>
  `;

  const form = document.querySelector('#login-form');
  const message = document.querySelector('#message');
  const button = form.querySelector('button');

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    message.className = 'message';
    button.disabled = true;
    button.textContent = 'Procesando...';

    try {
      await login(readForm(form));
    } catch (error) {
      message.className = 'message show error';
      message.textContent = error.message;
    } finally {
      button.disabled = false;
      button.textContent = 'Entrar';
    }
  });
};

const renderDenied = () => {
  app.innerHTML = `
    <main class="denied-screen">
      <section class="denied-panel">
        <p class="eyebrow-dark">Acceso restringido</p>
        <h1>Panel de administración</h1>
        <p>Tu usuario ha iniciado sesión correctamente, pero este panel está reservado para administradores.</p>
        <button id="logout" class="primary-button" type="button">Cerrar sesión</button>
      </section>
    </main>
  `;

  document.querySelector('#logout').addEventListener('click', logout);
};

const renderAdmin = () => {
  app.innerHTML = `
    <main class="admin-layout">
      <aside class="admin-sidebar">
        <div class="admin-brand">
          <div class="brand-mark dark" aria-hidden="true">CM</div>
          <div>
            <strong>Clínica Médica</strong>
            <span>Panel admin</span>
          </div>
        </div>
        <nav class="admin-nav" aria-label="Panel de administración">
          ${adminSections
            .map(
              (section) => `
                <button class="nav-button" type="button" data-view="${section.id}" aria-current="${state.view === section.id ? 'page' : 'false'}">
                  ${section.label}
                </button>
              `,
            )
            .join('')}
        </nav>
        <div class="admin-user">
          <strong>${escapeHTML(state.usuario.nombre)} ${escapeHTML(state.usuario.apellido1)}</strong>
          <span>${escapeHTML(state.usuario.email)}</span>
          <button id="logout" class="secondary-button" type="button">Cerrar sesión</button>
        </div>
      </aside>

      <section class="admin-main">
        <header class="admin-topbar">
          <div>
            <p class="eyebrow-dark">Control del sistema</p>
            <h1>${adminSections.find((section) => section.id === state.view)?.label || 'Resumen'}</h1>
          </div>
          <button id="refresh" class="primary-button compact" type="button">Actualizar</button>
        </header>

        ${state.status.text ? `<div class="message show ${state.status.type}">${escapeHTML(state.status.text)}</div>` : ''}
        ${renderCurrentView()}
      </section>
    </main>
  `;

  bindAdminEvents();
};

const renderReception = () => {
  app.innerHTML = `
    <main class="admin-layout">
      <aside class="admin-sidebar reception-sidebar">
        <div class="admin-brand">
          <div class="brand-mark dark" aria-hidden="true">CM</div>
          <div>
            <strong>Clínica Médica</strong>
            <span>Recepción</span>
          </div>
        </div>
        <nav class="admin-nav" aria-label="Panel de recepción">
          ${receptionSections
            .map(
              (section) => `
                <button class="nav-button" type="button" data-view="${section.id}" aria-current="${state.view === section.id ? 'page' : 'false'}">
                  ${section.label}
                </button>
              `,
            )
            .join('')}
        </nav>
        <div class="admin-user">
          <strong>${escapeHTML(state.usuario.nombre)} ${escapeHTML(state.usuario.apellido1)}</strong>
          <span>${escapeHTML(state.usuario.email)}</span>
          <button id="logout" class="secondary-button" type="button">Cerrar sesión</button>
        </div>
      </aside>

      <section class="admin-main">
        <header class="admin-topbar">
          <div>
            <p class="eyebrow-dark">Gestión de recepción</p>
            <h1>${receptionSections.find((section) => section.id === state.view)?.label || 'Agenda'}</h1>
          </div>
          <button id="refresh" class="primary-button compact" type="button">Actualizar</button>
        </header>

        ${state.status.text ? `<div class="message show ${state.status.type}">${escapeHTML(state.status.text)}</div>` : ''}
        ${renderReceptionView()}
      </section>
    </main>
  `;

  bindReceptionEvents();
};

const renderReceptionView = () => {
  if (state.view === 'nuevo-paciente') return renderReceptionPatientView();
  if (state.view === 'nueva-cita') return renderReceptionAppointmentView();
  return renderReceptionAgendaView();
};

const renderReceptionAgendaView = () => {
  const citasPendientes = state.citas.filter((cita) => cita.estado === 'pendiente').length;
  const citasCanceladas = state.citas.filter((cita) => cita.estado === 'cancelada').length;

  return `
    <section class="metric-grid reception-metrics">
      <article class="metric-card">
        <span>Citas en agenda</span>
        <strong>${state.citas.length}</strong>
      </article>
      <article class="metric-card">
        <span>Pendientes</span>
        <strong>${citasPendientes}</strong>
      </article>
      <article class="metric-card">
        <span>Canceladas</span>
        <strong>${citasCanceladas}</strong>
      </article>
    </section>

    <section class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Agenda general</h2>
          <p>Consulta las citas y cancela cuando sea necesario.</p>
        </div>
      </div>
      ${renderReceptionAppointmentsTable()}
    </section>
  `;
};

const renderReceptionPatientView = () => `
  <section class="panel-grid reception-grid">
    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Registrar paciente</h2>
          <p>Alta rápida para poder asignar citas desde recepción.</p>
        </div>
      </div>
      <form id="create-patient-form" class="admin-form">
        <div class="form-grid">
          <label>DNI<input name="dni" required /></label>
          <label>Nombre<input name="nombre" required /></label>
          <label>Primer apellido<input name="apellido1" required /></label>
          <label>Segundo apellido<input name="apellido2" /></label>
          <label>Teléfono<input name="telefono" inputmode="numeric" /></label>
          <label>Fecha nacimiento<input name="fecha_nacimiento" type="date" /></label>
        </div>
        <button class="primary-button compact" type="submit">Crear paciente</button>
      </form>
    </article>

    <article class="panel-section wide">
      <div class="section-heading">
        <div>
          <h2>Pacientes disponibles</h2>
          <p>${state.pacientes.length} pacientes visibles para recepción.</p>
        </div>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>DNI</th>
              <th>Nombre</th>
              <th>Teléfono</th>
              <th>Nacimiento</th>
            </tr>
          </thead>
          <tbody>
            ${state.pacientes
              .map(
                (paciente) => `
                  <tr>
                    <td>${escapeHTML(paciente.dni)}</td>
                    <td>${escapeHTML(paciente.nombre)} ${escapeHTML(paciente.apellido1)} ${escapeHTML(paciente.apellido2 || '')}</td>
                    <td>${escapeHTML(paciente.telefono || 'Sin teléfono')}</td>
                    <td>${escapeHTML(paciente.fecha_nacimiento || 'Sin fecha')}</td>
                  </tr>
                `,
              )
              .join('')}
          </tbody>
        </table>
      </div>
    </article>
  </section>
`;

const renderReceptionAppointmentView = () => `
  <section class="panel-grid reception-grid">
    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Crear cita</h2>
          <p>Selecciona paciente, médico, fecha y motivo.</p>
        </div>
      </div>
      <form id="create-appointment-form" class="admin-form">
        <div class="form-grid">
          <label class="span-2">Paciente
            <select name="pacienteID" required>
              <option value="">Selecciona paciente</option>
              ${state.pacientes
                .map(
                  (paciente) =>
                    `<option value="${paciente.id}">${escapeHTML(paciente.nombre)} ${escapeHTML(paciente.apellido1)} · ${escapeHTML(paciente.dni)}</option>`,
                )
                .join('')}
            </select>
          </label>
          <label class="span-2">Médico
            <select name="medicoID" required>
              <option value="">Selecciona médico</option>
              ${state.usuarios
                .map(
                  (usuario) =>
                    `<option value="${usuario.id}">${escapeHTML(usuario.nombre)} ${escapeHTML(usuario.apellido1)}</option>`,
                )
                .join('')}
            </select>
          </label>
          <label class="span-2">Fecha y hora<input name="fecha" type="datetime-local" required /></label>
          <label class="span-2">Motivo<input name="motivo" required minlength="5" maxlength="255" /></label>
        </div>
        <button class="primary-button compact" type="submit">Crear cita</button>
      </form>
    </article>

    <article class="panel-section wide">
      <div class="section-heading">
        <div>
          <h2>Agenda</h2>
          <p>${state.citas.length} citas registradas.</p>
        </div>
      </div>
      ${renderReceptionAppointmentsTable()}
    </article>
  </section>
`;

const renderReceptionAppointmentsTable = () => `
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Fecha</th>
          <th>Paciente</th>
          <th>Médico</th>
          <th>Estado</th>
          <th>Motivo</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        ${
          state.citas.length
            ? state.citas
                .map(
                  (cita) => `
                    <tr>
                      <td>${formatDate(cita.fecha)}</td>
                      <td>${escapeHTML(cita.paciente?.nombre || 'Paciente')} ${escapeHTML(cita.paciente?.apellido1 || '')}</td>
                      <td>${escapeHTML(cita.medico?.nombre || 'Médico')} ${escapeHTML(cita.medico?.apellido1 || '')}</td>
                      <td><span class="badge status">${escapeHTML(cita.estado)}</span></td>
                      <td>${escapeHTML(cita.motivo)}</td>
                      <td class="actions">
                        ${
                          cita.estado === 'cancelada'
                            ? '<span class="muted-text">Cancelada</span>'
                            : `<button class="danger-button" type="button" data-cancel-appointment="${cita.id}">Cancelar</button>`
                        }
                      </td>
                    </tr>
                  `,
                )
                .join('')
            : '<tr><td colspan="6">No hay citas registradas.</td></tr>'
        }
      </tbody>
    </table>
  </div>
`;

const renderDoctor = () => {
  app.innerHTML = `
    <main class="admin-layout">
      <aside class="admin-sidebar doctor-sidebar">
        <div class="admin-brand">
          <div class="brand-mark dark" aria-hidden="true">CM</div>
          <div>
            <strong>Clínica Médica</strong>
            <span>Panel médico</span>
          </div>
        </div>
        <nav class="admin-nav" aria-label="Panel médico">
          ${doctorSections
            .map(
              (section) => `
                <button class="nav-button" type="button" data-view="${section.id}" aria-current="${state.view === section.id ? 'page' : 'false'}">
                  ${section.label}
                </button>
              `,
            )
            .join('')}
        </nav>
        <div class="admin-user">
          <strong>${escapeHTML(state.usuario.nombre)} ${escapeHTML(state.usuario.apellido1)}</strong>
          <span>${escapeHTML(state.usuario.email)}</span>
          <button id="logout" class="secondary-button" type="button">Cerrar sesión</button>
        </div>
      </aside>

      <section class="admin-main">
        <header class="admin-topbar">
          <div>
            <p class="eyebrow-dark">Consulta médica</p>
            <h1>${doctorSections.find((section) => section.id === state.view)?.label || 'Mis citas'}</h1>
          </div>
          <button id="refresh" class="primary-button compact" type="button">Actualizar</button>
        </header>

        ${state.status.text ? `<div class="message show ${state.status.type}">${escapeHTML(state.status.text)}</div>` : ''}
        ${renderDoctorView()}
      </section>
    </main>
  `;

  bindDoctorEvents();
};

const renderDoctorView = () => {
  if (state.view === 'historial') return renderDoctorHistoryView();
  return renderDoctorAppointmentsView();
};

const renderDoctorAppointmentsView = () => {
  const pendientes = state.citas.filter((cita) => cita.estado === 'pendiente').length;
  const enCurso = state.citas.filter((cita) => cita.estado === 'en curso').length;
  const finalizadas = state.citas.filter((cita) => cita.estado === 'finalizada').length;

  return `
    <section class="metric-grid doctor-metrics">
      <article class="metric-card">
        <span>Citas asignadas</span>
        <strong>${state.citas.length}</strong>
      </article>
      <article class="metric-card">
        <span>Pendientes</span>
        <strong>${pendientes}</strong>
      </article>
      <article class="metric-card">
        <span>En curso</span>
        <strong>${enCurso}</strong>
      </article>
      <article class="metric-card">
        <span>Finalizadas</span>
        <strong>${finalizadas}</strong>
      </article>
    </section>

    <section class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Agenda médica</h2>
          <p>Gestiona solo las citas que tienes asignadas.</p>
        </div>
      </div>
      ${renderDoctorAppointmentsTable()}
    </section>
  `;
};

const renderDoctorAppointmentsTable = () => `
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Fecha</th>
          <th>Paciente</th>
          <th>DNI</th>
          <th>Estado</th>
          <th>Motivo</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        ${
          state.citas.length
            ? state.citas
                .map(
                  (cita) => `
                    <tr>
                      <td>${formatDate(cita.fecha)}</td>
                      <td>${escapeHTML(cita.paciente?.nombre || 'Paciente')} ${escapeHTML(cita.paciente?.apellido1 || '')} ${escapeHTML(cita.paciente?.apellido2 || '')}</td>
                      <td>${escapeHTML(cita.paciente?.dni || 'Sin DNI')}</td>
                      <td><span class="badge status">${escapeHTML(cita.estado)}</span></td>
                      <td>${escapeHTML(cita.motivo)}</td>
                      <td class="actions">
                        <select class="status-select" data-doctor-appointment="${cita.id}">
                          ${['pendiente', 'en curso', 'finalizada', 'cancelada']
                            .map((estado) => `<option value="${estado}" ${estado === cita.estado ? 'selected' : ''}>${estado}</option>`)
                            .join('')}
                        </select>
                        <button class="text-button" type="button" data-open-history="${cita.pacienteID}">Historial</button>
                      </td>
                    </tr>
                  `,
                )
                .join('')
            : '<tr><td colspan="6">No tienes citas asignadas.</td></tr>'
        }
      </tbody>
    </table>
  </div>
`;

const renderDoctorHistoryView = () => {
  const selectedPatient = state.pacientes.find((paciente) => paciente.id === state.selectedPacienteId);

  return `
    <section class="panel-grid doctor-grid">
      <article class="panel-section">
        <div class="section-heading">
          <div>
            <h2>Paciente</h2>
            <p>Selecciona un paciente de tus citas asignadas.</p>
          </div>
        </div>
        <form id="select-history-patient-form" class="admin-form">
          <label>Paciente
            <select name="pacienteID" required>
              ${state.pacientes
                .map(
                  (paciente) =>
                    `<option value="${paciente.id}" ${paciente.id === state.selectedPacienteId ? 'selected' : ''}>${escapeHTML(paciente.nombre)} ${escapeHTML(paciente.apellido1)} · ${escapeHTML(paciente.dni)}</option>`,
                )
                .join('')}
            </select>
          </label>
        </form>
      </article>

      <article class="panel-section">
        <div class="section-heading">
          <div>
            <h2>Nueva entrada</h2>
            <p>${selectedPatient ? `${escapeHTML(selectedPatient.nombre)} ${escapeHTML(selectedPatient.apellido1)}` : 'Selecciona un paciente para continuar.'}</p>
          </div>
        </div>
        <form id="create-history-form" class="admin-form">
          <input name="pacienteID" type="hidden" value="${state.selectedPacienteId || ''}" />
          <label>Diagnóstico<textarea name="diagnostico" required rows="4"></textarea></label>
          <label>Tratamiento<textarea name="tratamiento" rows="3"></textarea></label>
          <label>Observaciones<textarea name="observaciones" rows="3"></textarea></label>
          <button class="primary-button compact" type="submit" ${state.selectedPacienteId ? '' : 'disabled'}>Guardar entrada</button>
        </form>
      </article>

      <article class="panel-section wide">
        <div class="section-heading">
          <div>
            <h2>Historial clínico</h2>
            <p>${state.historiales.length} entradas encontradas.</p>
          </div>
        </div>
        <div class="history-list">
          ${
            state.historiales.length
              ? state.historiales
                  .map(
                    (entrada) => `
                      <article class="history-entry">
                        <header>
                          <strong>${formatDate(entrada.fecha)}</strong>
                          <span>Médico #${escapeHTML(entrada.medicoID)}</span>
                        </header>
                        <div>
                          <h3>Diagnóstico</h3>
                          <p>${escapeHTML(entrada.diagnostico)}</p>
                        </div>
                        ${
                          entrada.tratamiento
                            ? `<div><h3>Tratamiento</h3><p>${escapeHTML(entrada.tratamiento)}</p></div>`
                            : ''
                        }
                        ${
                          entrada.observaciones
                            ? `<div><h3>Observaciones</h3><p>${escapeHTML(entrada.observaciones)}</p></div>`
                            : ''
                        }
                      </article>
                    `,
                  )
                  .join('')
              : '<p class="empty-state">No hay entradas de historial para este paciente.</p>'
          }
        </div>
      </article>
    </section>
  `;
};

const renderCurrentView = () => {
  if (state.view === 'usuarios') return renderUsersView();
  if (state.view === 'pacientes') return renderPatientsView();
  if (state.view === 'citas') return renderAppointmentsView();
  return renderSummaryView();
};

const renderSummaryView = () => {
  const metrics = state.metrics || {
    pacientes: 0,
    personal: { medicos: 0, recepcionistas: 0 },
    actividad: { citasTotales: 0, citasPendientes: 0, historialesClinicos: 0 },
  };

  return `
    <section class="metric-grid">
      <article class="metric-card">
        <span>Pacientes</span>
        <strong>${metrics.pacientes}</strong>
      </article>
      <article class="metric-card">
        <span>Médicos</span>
        <strong>${metrics.personal.medicos}</strong>
      </article>
      <article class="metric-card">
        <span>Recepcionistas</span>
        <strong>${metrics.personal.recepcionistas}</strong>
      </article>
      <article class="metric-card">
        <span>Citas pendientes</span>
        <strong>${metrics.actividad.citasPendientes}</strong>
      </article>
      <article class="metric-card">
        <span>Citas totales</span>
        <strong>${metrics.actividad.citasTotales}</strong>
      </article>
      <article class="metric-card">
        <span>Historiales</span>
        <strong>${metrics.actividad.historialesClinicos}</strong>
      </article>
    </section>

    <section class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Actividad reciente</h2>
          <p>Últimas citas registradas en el sistema.</p>
        </div>
      </div>
      ${renderAppointmentsTable(state.citas.slice(0, 5), false)}
    </section>
  `;
};

const renderUsersView = () => `
  <section class="panel-grid">
    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Crear usuario</h2>
          <p>Alta de médicos, recepcionistas o administradores.</p>
        </div>
      </div>
      <form id="create-user-form" class="admin-form">
        <div class="form-grid">
          <label>Nombre<input name="nombre" required minlength="2" maxlength="50" /></label>
          <label>Primer apellido<input name="apellido1" required minlength="2" maxlength="50" /></label>
          <label>Segundo apellido<input name="apellido2" minlength="2" maxlength="50" /></label>
          <label>Teléfono<input name="tfno" type="tel" /></label>
          <label class="span-2">Email<input name="email" type="email" required /></label>
          <label>Contraseña<input name="clave" type="password" required /></label>
          <label>Rol
            <select name="rol" required>
              <option value="recepcionista">Recepcionista</option>
              <option value="medico">Médico</option>
              <option value="admin">Administrador</option>
            </select>
          </label>
        </div>
        <button class="primary-button compact" type="submit">Crear usuario</button>
      </form>
    </article>

    ${renderEditUserForm()}

    <article class="panel-section wide">
      <div class="section-heading">
        <div>
          <h2>Usuarios</h2>
          <p>${state.usuarios.length} usuarios registrados.</p>
        </div>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Nombre</th>
              <th>Email</th>
              <th>Rol</th>
              <th>Teléfono</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            ${state.usuarios
              .map(
                (usuario) => `
                  <tr>
                    <td>${escapeHTML(usuario.nombre)} ${escapeHTML(usuario.apellido1)}</td>
                    <td>${escapeHTML(usuario.email)}</td>
                    <td><span class="badge">${roleLabel[usuario.rol] || usuario.rol}</span></td>
                    <td>${escapeHTML(usuario.tfno || 'Sin teléfono')}</td>
                    <td class="actions">
                      <button class="text-button" type="button" data-edit-user="${usuario.id}">Editar</button>
                      <button class="danger-button" type="button" data-delete-user="${usuario.id}">Eliminar</button>
                    </td>
                  </tr>
                `,
              )
              .join('')}
          </tbody>
        </table>
      </div>
    </article>
  </section>
`;

const renderEditUserForm = () => {
  if (!state.editingUserId) {
    return `
      <article class="panel-section muted-panel">
        <div class="section-heading">
          <div>
            <h2>Editar usuario</h2>
            <p>Selecciona un usuario de la tabla para modificar sus datos.</p>
          </div>
        </div>
      </article>
    `;
  }

  const usuario = state.usuarios.find((item) => item.id === state.editingUserId);

  if (!usuario) {
    state.editingUserId = null;
    return '';
  }

  return `
    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Editar usuario</h2>
          <p>${escapeHTML(usuario.email)} · el email se mantiene fijo.</p>
        </div>
      </div>
      <form id="edit-user-form" class="admin-form">
        <div class="form-grid">
          <label>Nombre
            <input name="nombre" required minlength="2" maxlength="50" value="${escapeHTML(usuario.nombre)}" />
          </label>
          <label>Primer apellido
            <input name="apellido1" required minlength="2" maxlength="50" value="${escapeHTML(usuario.apellido1)}" />
          </label>
          <label>Segundo apellido
            <input name="apellido2" minlength="2" maxlength="50" value="${escapeHTML(usuario.apellido2 || '')}" />
          </label>
          <label>Teléfono
            <input name="tfno" type="tel" value="${escapeHTML(usuario.tfno || '')}" />
          </label>
          <label>Rol
            <select name="rol" required>
              <option value="recepcionista" ${usuario.rol === 'recepcionista' ? 'selected' : ''}>Recepcionista</option>
              <option value="medico" ${usuario.rol === 'medico' ? 'selected' : ''}>Médico</option>
              <option value="admin" ${usuario.rol === 'admin' ? 'selected' : ''}>Administrador</option>
            </select>
          </label>
          <label>Nueva contraseña
            <input name="clave" type="password" autocomplete="new-password" placeholder="Dejar vacía para no cambiarla" />
          </label>
        </div>
        <div class="form-actions">
          <button class="primary-button compact" type="submit">Guardar cambios</button>
          <button id="cancel-edit-user" class="secondary-button" type="button">Cancelar</button>
        </div>
      </form>
    </article>
  `;
};

const renderPatientsView = () => `
  <section class="panel-grid">
    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Crear paciente</h2>
          <p>Registro manual de pacientes.</p>
        </div>
      </div>
      <form id="create-patient-form" class="admin-form">
        <div class="form-grid">
          <label>DNI<input name="dni" required /></label>
          <label>Nombre<input name="nombre" required /></label>
          <label>Primer apellido<input name="apellido1" required /></label>
          <label>Segundo apellido<input name="apellido2" /></label>
          <label>Teléfono<input name="telefono" inputmode="numeric" /></label>
          <label>Fecha nacimiento<input name="fecha_nacimiento" type="date" /></label>
        </div>
        <button class="primary-button compact" type="submit">Crear paciente</button>
      </form>
    </article>

    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Datos de prueba</h2>
          <p>Genera pacientes aleatorios para poblar la base.</p>
        </div>
      </div>
      <form id="generate-patients-form" class="admin-form compact-form">
        <label>Cantidad<input name="cantidad" type="number" min="1" max="100" value="10" required /></label>
        <button class="secondary-button" type="submit">Generar pacientes</button>
      </form>
    </article>

    <article class="panel-section wide">
      <div class="section-heading">
        <div>
          <h2>Pacientes</h2>
          <p>${state.pacientes.length} pacientes registrados.</p>
        </div>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>DNI</th>
              <th>Nombre</th>
              <th>Teléfono</th>
              <th>Nacimiento</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            ${state.pacientes
              .map(
                (paciente) => `
                  <tr>
                    <td>${escapeHTML(paciente.dni)}</td>
                    <td>${escapeHTML(paciente.nombre)} ${escapeHTML(paciente.apellido1)}</td>
                    <td>${escapeHTML(paciente.telefono || 'Sin teléfono')}</td>
                    <td>${escapeHTML(paciente.fecha_nacimiento || 'Sin fecha')}</td>
                    <td class="actions">
                      <button class="text-button" type="button" data-edit-patient="${paciente.id}">Editar</button>
                      <button class="danger-button" type="button" data-delete-patient="${paciente.id}">Eliminar</button>
                    </td>
                  </tr>
                `,
              )
              .join('')}
          </tbody>
        </table>
      </div>
    </article>
  </section>
`;

const renderAppointmentsView = () => `
  <section class="panel-grid">
    <article class="panel-section">
      <div class="section-heading">
        <div>
          <h2>Crear cita</h2>
          <p>Asigna paciente y médico a una nueva cita.</p>
        </div>
      </div>
      <form id="create-appointment-form" class="admin-form">
        <div class="form-grid">
          <label class="span-2">Paciente
            <select name="pacienteID" required>
              <option value="">Selecciona paciente</option>
              ${state.pacientes
                .map(
                  (paciente) =>
                    `<option value="${paciente.id}">${escapeHTML(paciente.nombre)} ${escapeHTML(paciente.apellido1)} · ${escapeHTML(paciente.dni)}</option>`,
                )
                .join('')}
            </select>
          </label>
          <label class="span-2">Médico
            <select name="medicoID" required>
              <option value="">Selecciona médico</option>
              ${state.usuarios
                .filter((usuario) => usuario.rol === 'medico')
                .map(
                  (usuario) =>
                    `<option value="${usuario.id}">${escapeHTML(usuario.nombre)} ${escapeHTML(usuario.apellido1)}</option>`,
                )
                .join('')}
            </select>
          </label>
          <label class="span-2">Fecha y hora<input name="fecha" type="datetime-local" required /></label>
          <label class="span-2">Motivo<input name="motivo" required minlength="5" maxlength="255" /></label>
        </div>
        <button class="primary-button compact" type="submit">Crear cita</button>
      </form>
    </article>

    <article class="panel-section wide">
      <div class="section-heading">
        <div>
          <h2>Citas</h2>
          <p>${state.citas.length} citas registradas.</p>
        </div>
      </div>
      ${renderAppointmentsTable(state.citas, true)}
    </article>
  </section>
`;

const renderAppointmentsTable = (citas, withActions) => `
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Fecha</th>
          <th>Paciente</th>
          <th>Médico</th>
          <th>Estado</th>
          <th>Motivo</th>
          ${withActions ? '<th></th>' : ''}
        </tr>
      </thead>
      <tbody>
        ${
          citas.length
            ? citas
                .map(
                  (cita) => `
                    <tr>
                      <td>${formatDate(cita.fecha)}</td>
                      <td>${escapeHTML(cita.paciente?.nombre || 'Paciente')} ${escapeHTML(cita.paciente?.apellido1 || '')}</td>
                      <td>${escapeHTML(cita.medico?.nombre || 'Médico')} ${escapeHTML(cita.medico?.apellido1 || '')}</td>
                      <td><span class="badge status">${escapeHTML(cita.estado)}</span></td>
                      <td>${escapeHTML(cita.motivo)}</td>
                      ${
                        withActions
                          ? `<td class="actions">
                              <select class="status-select" data-update-appointment="${cita.id}">
                                ${['pendiente', 'en curso', 'finalizada', 'cancelada']
                                  .map((estado) => `<option value="${estado}" ${estado === cita.estado ? 'selected' : ''}>${estado}</option>`)
                                  .join('')}
                              </select>
                              <button class="danger-button" type="button" data-delete-appointment="${cita.id}">Eliminar</button>
                            </td>`
                          : ''
                      }
                    </tr>
                  `,
                )
                .join('')
            : `<tr><td colspan="${withActions ? 6 : 5}">No hay citas registradas.</td></tr>`
        }
      </tbody>
    </table>
  </div>
`;

const cleanEmptyFields = (body) => {
  Object.keys(body).forEach((key) => {
    if (body[key] === '') delete body[key];
  });
  return body;
};

const bindAdminEvents = () => {
  document.querySelector('#logout').addEventListener('click', logout);
  document.querySelector('#refresh').addEventListener('click', loadAdminData);

  document.querySelectorAll('[data-view]').forEach((button) => {
    button.addEventListener('click', () => {
      state.view = button.dataset.view;
      state.status = { text: '', type: 'success' };
      renderAdmin();
    });
  });

  document.querySelector('#create-user-form')?.addEventListener('submit', handleCreateUser);
  document.querySelector('#edit-user-form')?.addEventListener('submit', handleUpdateUser);
  document.querySelector('#cancel-edit-user')?.addEventListener('click', () => {
    state.editingUserId = null;
    renderAdmin();
  });
  document.querySelector('#create-patient-form')?.addEventListener('submit', handleCreatePatient);
  document.querySelector('#generate-patients-form')?.addEventListener('submit', handleGeneratePatients);
  document.querySelector('#create-appointment-form')?.addEventListener('submit', handleCreateAppointment);

  document.querySelectorAll('[data-delete-user]').forEach((button) => {
    button.addEventListener('click', () => handleDelete(`/api/usuarios/${button.dataset.deleteUser}`, 'Usuario eliminado.'));
  });

  document.querySelectorAll('[data-delete-patient]').forEach((button) => {
    button.addEventListener('click', () => handleDelete(`/api/pacientes/${button.dataset.deletePatient}`, 'Paciente eliminado.'));
  });

  document.querySelectorAll('[data-delete-appointment]').forEach((button) => {
    button.addEventListener('click', () => handleDelete(`/api/citas/${button.dataset.deleteAppointment}`, 'Cita eliminada.'));
  });

  document.querySelectorAll('[data-edit-user]').forEach((button) => {
    button.addEventListener('click', () => {
      state.editingUserId = Number(button.dataset.editUser);
      state.status = { text: '', type: 'success' };
      renderAdmin();
    });
  });

  document.querySelectorAll('[data-edit-patient]').forEach((button) => {
    button.addEventListener('click', () => handleEditPatient(Number(button.dataset.editPatient)));
  });

  document.querySelectorAll('[data-update-appointment]').forEach((select) => {
    select.addEventListener('change', () => handleUpdateAppointment(Number(select.dataset.updateAppointment), select.value));
  });
};

const bindReceptionEvents = () => {
  document.querySelector('#logout').addEventListener('click', logout);
  document.querySelector('#refresh').addEventListener('click', loadReceptionData);

  document.querySelectorAll('[data-view]').forEach((button) => {
    button.addEventListener('click', () => {
      state.view = button.dataset.view;
      state.status = { text: '', type: 'success' };
      renderReception();
    });
  });

  document.querySelector('#create-patient-form')?.addEventListener('submit', handleCreatePatient);
  document.querySelector('#create-appointment-form')?.addEventListener('submit', handleCreateAppointment);

  document.querySelectorAll('[data-cancel-appointment]').forEach((button) => {
    button.addEventListener('click', () => handleCancelReceptionAppointment(Number(button.dataset.cancelAppointment)));
  });
};

const bindDoctorEvents = () => {
  document.querySelector('#logout').addEventListener('click', logout);
  document.querySelector('#refresh').addEventListener('click', loadDoctorData);

  document.querySelectorAll('[data-view]').forEach((button) => {
    button.addEventListener('click', async () => {
      state.view = button.dataset.view;
      state.status = { text: '', type: 'success' };

      if (state.view === 'historial' && state.selectedPacienteId) {
        await loadDoctorHistory(state.selectedPacienteId);
        return;
      }

      renderDoctor();
    });
  });

  document.querySelectorAll('[data-doctor-appointment]').forEach((select) => {
    select.addEventListener('change', () => handleDoctorAppointmentStatus(Number(select.dataset.doctorAppointment), select.value));
  });

  document.querySelectorAll('[data-open-history]').forEach((button) => {
    button.addEventListener('click', async () => {
      state.selectedPacienteId = Number(button.dataset.openHistory);
      state.view = 'historial';
      state.status = { text: '', type: 'success' };
      await loadDoctorHistory(state.selectedPacienteId);
    });
  });

  document.querySelector('#select-history-patient-form select')?.addEventListener('change', async (event) => {
    state.selectedPacienteId = Number(event.target.value);
    state.status = { text: '', type: 'success' };
    await loadDoctorHistory(state.selectedPacienteId);
  });

  document.querySelector('#create-history-form')?.addEventListener('submit', handleCreateHistoryEntry);
};

const handleCreateUser = async (event) => {
  event.preventDefault();
  try {
    await apiRequest('/api/admin/usuarios', {
      method: 'POST',
      body: JSON.stringify(cleanEmptyFields(readForm(event.currentTarget))),
    });
    await loadAdminData();
    setStatus('Usuario creado correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleUpdateUser = async (event) => {
  event.preventDefault();

  if (!state.editingUserId) return;

  try {
    await apiRequest(`/api/usuarios/${state.editingUserId}`, {
      method: 'PUT',
      body: JSON.stringify(cleanEmptyFields(readForm(event.currentTarget))),
    });
    state.editingUserId = null;
    await loadAdminData();
    setStatus('Usuario actualizado correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleCreatePatient = async (event) => {
  event.preventDefault();
  const path = state.usuario?.rol === 'recepcionista' ? '/api/recepcionista/paciente' : '/api/pacientes';

  try {
    await apiRequest(path, {
      method: 'POST',
      body: JSON.stringify(cleanEmptyFields(readForm(event.currentTarget))),
    });
    await loadCurrentRoleData();
    setStatus('Paciente creado correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleGeneratePatients = async (event) => {
  event.preventDefault();
  const body = readForm(event.currentTarget);
  try {
    await apiRequest('/api/admin/generar-aleatorios', {
      method: 'POST',
      body: JSON.stringify({ cantidad: Number(body.cantidad) }),
    });
    await loadAdminData();
    setStatus('Pacientes generados correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleCreateAppointment = async (event) => {
  event.preventDefault();
  const body = readForm(event.currentTarget);
  const path = state.usuario?.rol === 'recepcionista' ? '/api/recepcionista/cita' : '/api/citas';

  try {
    await apiRequest(path, {
      method: 'POST',
      body: JSON.stringify({
        ...body,
        pacienteID: Number(body.pacienteID),
        medicoID: Number(body.medicoID),
      }),
    });
    await loadCurrentRoleData();
    setStatus('Cita creada correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleCancelReceptionAppointment = async (id) => {
  if (!window.confirm('¿Seguro que quieres cancelar esta cita?')) return;

  try {
    await apiRequest(`/api/recepcionista/cancelar-cita/${id}`, { method: 'PUT' });
    await loadReceptionData();
    setStatus('Cita cancelada correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleDoctorAppointmentStatus = async (id, estado) => {
  try {
    await apiRequest(`/api/medico/cita/${id}/estado`, {
      method: 'PUT',
      body: JSON.stringify({ estado }),
    });
    await loadDoctorData();
    setStatus('Estado de la cita actualizado.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleCreateHistoryEntry = async (event) => {
  event.preventDefault();
  const body = readForm(event.currentTarget);

  try {
    await apiRequest('/api/medico/historial', {
      method: 'POST',
      body: JSON.stringify({
        ...cleanEmptyFields(body),
        pacienteID: Number(body.pacienteID),
      }),
    });
    await loadDoctorHistory(Number(body.pacienteID), false);
    setStatus('Entrada de historial guardada correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const loadCurrentRoleData = () => {
  if (state.usuario?.rol === 'medico') {
    return loadDoctorData();
  }

  if (state.usuario?.rol === 'recepcionista') {
    return loadReceptionData();
  }

  return loadAdminData();
};

const handleDelete = async (path, successMessage) => {
  if (!window.confirm('¿Seguro que quieres eliminar este registro?')) return;

  try {
    await apiRequest(path, { method: 'DELETE' });
    await loadAdminData();
    setStatus(successMessage);
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleEditPatient = async (id) => {
  const paciente = state.pacientes.find((item) => item.id === id);
  if (!paciente) return;

  const telefono = window.prompt('Teléfono', paciente.telefono || '');
  if (telefono === null) return;
  const fecha_nacimiento = window.prompt('Fecha nacimiento YYYY-MM-DD', paciente.fecha_nacimiento || '');
  if (fecha_nacimiento === null) return;

  try {
    await apiRequest(`/api/pacientes/${id}`, {
      method: 'PUT',
      body: JSON.stringify(cleanEmptyFields({ telefono, fecha_nacimiento })),
    });
    await loadAdminData();
    setStatus('Paciente actualizado correctamente.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const handleUpdateAppointment = async (id, estado) => {
  try {
    await apiRequest(`/api/citas/${id}`, {
      method: 'PUT',
      body: JSON.stringify({ estado }),
    });
    await loadAdminData();
    setStatus('Estado de la cita actualizado.');
  } catch (error) {
    setStatus(error.message, 'error');
  }
};

const render = () => {
  if (!state.token || !state.usuario) {
    renderLogin();
    return;
  }

  if (state.usuario.rol === 'recepcionista') {
    renderReception();
    return;
  }

  if (state.usuario.rol === 'medico') {
    renderDoctor();
    return;
  }

  if (state.usuario.rol !== 'admin') {
    renderDenied();
    return;
  }

  renderAdmin();
};

onAgendaUpdate(async (data) => {
  if (!state.token || !state.usuario) return;

  await loadCurrentRoleData();
  setStatus(data.msg || 'Agenda actualizada.');
});

if (state.token && state.usuario?.rol === 'admin') {
  connectSocket();
  loadAdminData();
} else if (state.token && state.usuario?.rol === 'recepcionista') {
  connectSocket();
  state.view = 'agenda';
  loadReceptionData();
} else if (state.token && state.usuario?.rol === 'medico') {
  connectSocket();
  state.view = 'mis-citas';
  loadDoctorData();
} else {
  render();
}
