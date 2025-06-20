﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Entidades
{
    public class Persona
    {
        public int DNI { get; set; }
        public string nombre { get; set; }
        public string apellido { get; set; }
        public int genero { get; set; }
        public int Localidad { get; set; }
        public DateTime fechaNacimiento { get; set; }
        public string nacionalidad { get; set; }

        public string Direccion { get; set; }
        public int Telefono { get; set; }
        public string Correo { get; set; }



    }
}
