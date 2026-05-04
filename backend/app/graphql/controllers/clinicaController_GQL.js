export const calcularDuracionMinutos = (cita) => {
    const inicio = new Date(cita.createdAt)
    const fin = new Date(cita.updatedAt)

    if (Number.isNaN(inicio.getTime()) || Number.isNaN(fin.getTime())) {
        return null
    }

    return Math.round((fin - inicio) / 60000)
}

export const crearStatsMedico = (medicoID, citas) => {
    const duraciones = citas
        .map(calcularDuracionMinutos)
        .filter((duracion) => duracion !== null)

    const totalDuracion = duraciones.reduce((total, duracion) => total + duracion, 0)

    return {
        medicoID,
        totalCitasFinalizadas: citas.length,
        promedioDuracion: duraciones.length > 0 ? totalDuracion / duraciones.length : 0
    }
}
