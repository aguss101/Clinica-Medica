﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Datos;

namespace Negocio
{
    public class GestorMedico
    {
        ConsultasMedico consultas = new ConsultasMedico();
        public List<Medico> GetMedicos()
        {

            return consultas.GetMedicos();
        }
        public Medico getMedicoPorID(string idMedico)
        {
            return consultas.getMedicoPorID(idMedico);
        }
        public int InsertarMedico(string nombreprocedimiento, Medico medico)
        {
            return consultas.InsertarMedico(nombreprocedimiento, medico);
        }
        public int EliminarMedico(string nombreprocedimiento, string dni)
        {
            return consultas.EliminarMedico(nombreprocedimiento, dni);
        }
        public int ModificarMedico(string nombreprocedimiento, Medico medico)
        {
            return consultas.ModificarMedico(nombreprocedimiento, medico);
        }
    }
}