﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

using Entidades;

namespace Datos
{
    public class ConsultasPacientes
    {
        private DataAccess conexion = new DataAccess();
        public List<Paciente> GetPacientes()
        {
            List<Paciente> pacientes = new List<Paciente>();
            string query = @"SELECT * FROM vw_PacienteConDatos
            WHERE activo = 1";
            try
            {
                using (SqlConnection con = conexion.AbrirConexion())
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        { pacientes.Add(MapearPaciente(reader)); }
                    }
                }
            }
            catch (Exception ex) { throw new Exception("Error al cargar pacientes: " + ex.Message); }
            return pacientes;
        }
        public int InsertarPaciente(Paciente paciente)
        {
            string queryPersona = @"INSERT INTO Persona (DNI, nombre, apellido, sexo, direccion, idLocalidad, fechaNacimiento, nacionalidad) 
                                    VALUES(@DNI, @Nombre, @Apellido, @Sexo, @Direccion, @IdLocalidad, @FechaNacimiento, @Nacionalidad)";

            string queryPaciente = @"INSERT INTO Paciente (DNI, ObraSocial, ultimaAtencion, alta)
                                     VALUES (@DNI, @ObraSocial, @UltimaAtencion, @Alta)";

            string queryTelefono = @"INSERT INTO Telefonos (idPersona, telefono) VALUES (@DNI, @Telefono)";

            string queryCorreo = @"INSERT INTO Correos (idPersona, correo) VALUES (@DNI, @Correo)";
            try
            {
                using (SqlConnection con = conexion.AbrirConexion())
                using (SqlTransaction transaction = con.BeginTransaction())
                    try
                    {
                        using (SqlCommand cmd = new SqlCommand(queryPersona, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI", paciente.DNI);
                            cmd.Parameters.AddWithValue("@Nombre", paciente.nombre);
                            cmd.Parameters.AddWithValue("@Apellido", paciente.apellido);
                            cmd.Parameters.AddWithValue("@Sexo", paciente.sexos.idSexo);
                            cmd.Parameters.AddWithValue("@FechaNacimiento", paciente.fechaNacimiento);
                            cmd.Parameters.AddWithValue("@Nacionalidad", paciente.nacionalidad);
                            cmd.Parameters.AddWithValue("@IdLocalidad", paciente.Localidad);
                            cmd.Parameters.AddWithValue("@Direccion", paciente.Direccion);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryPaciente, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI", paciente.DNI);
                            cmd.Parameters.AddWithValue("@ObraSocial", paciente.ObraSocial.idObraSocial);
                            cmd.Parameters.AddWithValue("@UltimaAtencion", paciente.ultimaAtencion);
                            cmd.Parameters.AddWithValue("@Alta", paciente.Alta);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryTelefono, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI", paciente.DNI);
                            cmd.Parameters.AddWithValue("@Telefono", paciente.Telefono);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryCorreo, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI", paciente.DNI);
                            cmd.Parameters.AddWithValue("@Correo", paciente.Correo);
                            cmd.ExecuteNonQuery();
                        }
                        transaction.Commit();
                        return 1;
                    }
                    catch (Exception ex) { transaction.Rollback(); throw new Exception("Error durante la transacción: " + ex.Message); }
            }
            catch (Exception ex) { throw new Exception("Error al insertar paciente: " + ex.Message); }
        }

        public int EliminarPaciente(string dni)
        {
            string query = "UPDATE Persona SET activo = 0 WHERE DNI = @DNI";
            SqlParameter[] parametros = new SqlParameter[]
            { new SqlParameter("@DNI", dni) };
            return conexion.EjecutarComandoConParametros(query, parametros);
        }
        public int ModificarPaciente(Paciente paciente, string DNI_VIEJO)
        {
            string queryPersona = @"UPDATE Persona SET DNI = @DNI_NUEVO, nombre = @Nombre, apellido = @Apellido, sexo = @Sexo, direccion = @Direccion, idLocalidad = @IdLocalidad, 
                                   fechaNacimiento = @FechaNacimiento, nacionalidad = @Nacionalidad WHERE DNI = @DNI_VIEJO";

            string queryPaciente = @"UPDATE Paciente SET DNI = @DNI_NUEVO, ObraSocial = @ObraSocial WHERE DNI = @DNI_VIEJO";

            string queryTelefono = @"UPDATE Telefonos SET idPersona = @DNI_NUEVO, telefono = @Telefono WHERE idPersona = @DNI_VIEJO";

            string queryCorreo = @"UPDATE Correos SET idPersona = @DNI_NUEVO, correo = @Correo WHERE idPersona = @DNI_VIEJO";

            string queryTurnos = @"UPDATE Turnos SET DNIPaciente = @DNI_NUEVO WHERE DNIPaciente = @DNI_VIEJO";
            try
            {
                using (SqlConnection con = conexion.AbrirConexion())
                using (SqlTransaction transaction = con.BeginTransaction())
                    try
                    {
                        using (SqlCommand cmd = new SqlCommand(queryPersona, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI_NUEVO", paciente.DNI);
                            cmd.Parameters.AddWithValue("@DNI_VIEJO", DNI_VIEJO);
                            cmd.Parameters.AddWithValue("@Nombre", paciente.nombre);
                            cmd.Parameters.AddWithValue("@Apellido", paciente.apellido);
                            cmd.Parameters.AddWithValue("@Sexo", paciente.sexos.idSexo);
                            cmd.Parameters.AddWithValue("@FechaNacimiento", paciente.fechaNacimiento);
                            cmd.Parameters.AddWithValue("@Nacionalidad", paciente.nacionalidad);
                            cmd.Parameters.AddWithValue("@IdLocalidad", paciente.Localidad);
                            cmd.Parameters.AddWithValue("@Direccion", paciente.Direccion);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryPaciente, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI_NUEVO", paciente.DNI);
                            cmd.Parameters.AddWithValue("@ObraSocial", paciente.ObraSocial.idObraSocial);
                            cmd.Parameters.AddWithValue("@DNI_VIEJO", DNI_VIEJO);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryTelefono, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI_NUEVO", paciente.DNI);
                            cmd.Parameters.AddWithValue("@Telefono", paciente.Telefono);
                            cmd.Parameters.AddWithValue("@DNI_VIEJO", DNI_VIEJO);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryCorreo, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI_NUEVO", paciente.DNI);
                            cmd.Parameters.AddWithValue("@Correo", paciente.Correo);
                            cmd.Parameters.AddWithValue("@DNI_VIEJO", DNI_VIEJO);
                            cmd.ExecuteNonQuery();
                        }
                        using (SqlCommand cmd = new SqlCommand(queryTurnos, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DNI_NUEVO", paciente.DNI);
                            cmd.Parameters.AddWithValue("@DNI_VIEJO", DNI_VIEJO);
                            cmd.ExecuteNonQuery();
                        }
                        transaction.Commit();
                        return 1;
                    }
                    catch (Exception ex) { transaction.Rollback(); throw new Exception("Error durante la transacción: " + ex.Message); }
            }
            catch (Exception ex) { throw new Exception("Error al modificar paciente: " + ex.Message); }
        }
        public Paciente getPacientePorID(string idPaciente)
        {
            Paciente paciente = null;
            string query = @"SELECT * FROM vw_PacienteConDatos
            WHERE activo = 1 AND dniPaciente = @id ";
            try
            {
                using (SqlConnection con = conexion.AbrirConexion())
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", idPaciente);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read()) { paciente = MapearPaciente(reader); }
                    }
                }
            }
            catch (Exception ex) { throw new Exception("Error al buscar paciente por ID: " + ex.Message); }
            return paciente;
        }
        public Paciente MapearPaciente(SqlDataReader reader)
        {
            return new Paciente
            {
                DNI = reader["DNI"].ToString(),
                nombre = reader["nombre"].ToString(),
                apellido = reader["apellido"].ToString(),
                ObraSocial = new ObraSocial { idObraSocial = Convert.ToInt32(reader["idObraSocial"]), Onombre = reader["nombreObraSocial"].ToString() },
                ultimaAtencion = Convert.ToDateTime(reader["ultimaAtencion"]),
                Alta = Convert.ToDateTime(reader["alta"]),
                sexos = new Sexos { idSexo = Convert.ToInt32(reader["idSexo"]), descripcion = reader["genero"].ToString() },
                fechaNacimiento = Convert.ToDateTime(reader["fechaNacimiento"]),
                nacionalidad = reader["nacionalidad"].ToString(),
                Provincia = Convert.ToInt32(reader["idProvincia"]),
                Provincias = new Provincias
                {
                    idProvincia = Convert.ToInt32(reader["idProvincia"]),
                    nombreProvincia = reader["nombreProvincia"].ToString()
                },
                Localidad = Convert.ToInt32(reader["idLocalidad"]),
                Localidades = new Localidades
                {
                    idLocalidad = Convert.ToInt32(reader["idLocalidad"]),
                    nombreLocalidad = reader["nombreLocalidad"].ToString()
                },
                Direccion = reader["Direccion"].ToString(),
                Correo = reader["Correo"].ToString(),
                Telefono = reader["telefono"].ToString()
            };
        }
        public List<Paciente> FiltrarPacientexApellido(string apellido)
        {
            List<Paciente> paciente = new List<Paciente>();
            string query = @"SELECT * FROM vw_PacienteConDatos
                WHERE activo = 1
                AND (@Apellido IS NULL OR apellido COLLATE Latin1_General_CI_AI LIKE '%' + @Apellido + '%')
                ORDER BY apellido";

            try
            {
                using (SqlConnection con = conexion.AbrirConexion())
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(new SqlParameter("@Apellido", SqlDbType.VarChar, 25) { Value = apellido });
                    using (SqlDataReader reader = cmd.ExecuteReader()) { while (reader.Read()) { paciente.Add(MapearPaciente(reader)); } }
                }
            }
            catch (Exception ex) { throw new Exception("Error al cargar pacientes por apellido: " + ex.Message); }
            return paciente;
        }
        public List<Paciente> FiltrarPacientexDNI(string dniPaciente)
        {
            List<Paciente> paciente = new List<Paciente>();
            string query = @"SELECT * FROM vw_PacienteConDatos
                WHERE activo = 1
                AND (@DNI IS NULL OR CAST(dniPaciente AS VARCHAR) LIKE '%' + @DNI + '%')
                ORDER BY dniPaciente";
            try
            {
                using (SqlConnection con = conexion.AbrirConexion())
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(new SqlParameter("@DNI", SqlDbType.VarChar, 20) { Value = dniPaciente });
                    using (SqlDataReader reader = cmd.ExecuteReader()) { while (reader.Read()) { paciente.Add(MapearPaciente(reader)); } }
                }
            }
            catch (Exception ex) { throw new Exception("Error al cargar pacientes por DNI: " + ex.Message); }
            return paciente;
        }
    }
}