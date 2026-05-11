'use strict';
const { faker } = require('@faker-js/faker')
const bcrypt = require('bcrypt');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    const usuarios = []
    const hashedClave = await bcrypt.hash('password123', 10)

    for (let index = 0; index <= 30; index++) {
      const sexo = faker.person.sexType() //pequeño control para que coincida el genero con los nombres

      usuarios.push({
        nombre: faker.person.firstName(sexo),
        apellido1: faker.person.lastName(),
        apellido2: faker.person.lastName(),
        email: faker.internet.email().toLowerCase(),
        clave: hashedClave,
        rol: faker.helpers.arrayElement(['admin', 'medico', 'recepcionista']),
        tfno: faker.phone.number(),
        createdAt: new Date(),
        updatedAt: new Date()
      })
    }

    await queryInterface.bulkInsert('usuarios', usuarios, {})
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('usuarios', null, {})
  }
};
