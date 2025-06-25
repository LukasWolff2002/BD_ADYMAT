# Limpiar tablas
User.delete_all
Customer.delete_all
Machinery.delete_all

# === Usuarios ===
User.create!(
  nombre: "Lukas",
  apellido: "Wolff",
  rut: "12.345.678-9",
  email: "lukas@example.com",
  cargo: "admin",
  password: "12345678",
  password_confirmation: "12345678"
)

User.create!(
  nombre: "Ana",
  apellido: "Pérez",
  rut: "98.765.432-1",
  email: "ana@example.com",
  cargo: "cargo1",
  password: "segura456",
  password_confirmation: "segura456"
)

User.create!(
  nombre: "Carlos",
  apellido: "Díaz",
  rut: "11.222.333-4",
  email: "carlos@example.com",
  cargo: "cargo2",
  password: "clave789",
  password_confirmation: "clave789"
)

# === Clientes ===
Customer.create!([
  { nombre: "Constructora El Roble", rut: "76.543.210-9" },
  { nombre: "Inversiones Andes", rut: "65.432.109-8" },
  { nombre: "Servicios Forestales Sur", rut: "54.321.098-7" }
])

Machinery.create!([
  {
    nombre: "Excavadora Komatsu PC210",
    formato: "Estándar",
    horas_por_mantencion: 250,
    horas_totales: 3000,
    horas_disponibles: 1500,
    valor_dia: 180000,
    valor_semana: 950000,
    valor_mes: 3500000
  },
  {
    nombre: "Retroexcavadora Caterpillar 420F2",
    formato: "Compacta",
    horas_por_mantencion: 200,
    horas_totales: 2500,
    horas_disponibles: 1200,
    valor_dia: 140000,
    valor_semana: 800000,
    valor_mes: 2900000
  },
  {
    nombre: "Plataforma Elevadora Genie GS-1930",
    formato: "Eléctrica",
    horas_por_mantencion: 150,
    horas_totales: 2000,
    horas_disponibles: 500,
    valor_dia: 90000,
    valor_semana: 480000,
    valor_mes: 1600000
  }
])


puts "✅ Datos de prueba creados correctamente"
