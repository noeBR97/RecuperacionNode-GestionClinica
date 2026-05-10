import { io } from 'socket.io-client';

const SOCKET_URL = import.meta.env.VITE_SOCKET_URL || import.meta.env.VITE_API_URL || 'http://localhost:3000';

const socket = io(SOCKET_URL, {
    autoConnect: false,
});

socket.on('connect', () => {
    console.log('Socket conectado:', socket.id);
});

socket.on('connect_error', (error) => {
    console.error('Error conectando socket:', error.message);
});

export const connectSocket = () => {
    if (!socket.connected) {
        socket.connect();
    }
};

export const onAgendaUpdate = (callback) => {
    socket.off('cambio-en-agenda');
    socket.on('cambio-en-agenda', (data) => {
        console.log('Notificacion de servidor:', data.msg);
        callback(data);
    });
};

export const disconnectSocket = () => {
    socket.disconnect();
};

export default socket;
