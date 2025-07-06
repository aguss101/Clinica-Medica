﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services.Discovery;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using Negocio;

namespace Vistas
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = Session["User"] as string;
            //CargarGrafico();
        }

        protected void btnAdministrarMedicos_Click(object sender, EventArgs e)
        {
            Response.Redirect("/admin/Administrar_Medicos.aspx");
        }

        protected void Administrar_Pacientes_Click(object sender, EventArgs e)
        {
            Response.Redirect("/admin/Administrar_Pacientes.aspx");
        }

        protected void Administrar_Turnos_Click(object sender, EventArgs e)
        { Response.Redirect("/admin/Administrar_Turnos.aspx"); }



        protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            GestorReportes gestor = new GestorReportes();
            string tipo = ddlReportes.SelectedValue.ToString();
            string cat = ddlCategoria.SelectedValue.ToString();

            switch (tipo)
            {
                case "1":  // Médicos
                    if (cat == "Por Especialidad")
                        CargarGrafico("Especialidad", "CantMedicos", gestor.GetCantidadMedicosxEspecialidad());
                    else if (cat == "Cantidad de Turnos")
                        CargarGrafico("NombreCompleto", "CantidadTurnos", gestor.GetCantidadTurnosxMedico());
                    else if (cat == "Por Edad")
                        CargarGrafico("CategoriaEdad", "Cantidad", gestor.GetMedicosxEdad());
                    break;

                case "2":  // Pacientes
                    if (cat == "Por Edad")
                        CargarGrafico("CategoriaEdad", "Cantidad", gestor.GetPacientesxEdad());
                    else if (cat == "Por Obra Social")
                        CargarGrafico("ObraSocial", "CantPacientes", gestor.GetPacientesxObraSocial());
                    else if (cat == "Cantidad de Turnos")
                        CargarGrafico("Estado", "CantidadTurnos", gestor.GetTurnosxEstado());
                    else if (cat == "Cantidad de Ausentes")
                        CargarGrafico("Mes", "CantidadAusentes", gestor.GetPacientesxAusentesMes());
                    break;

                case "3":  // Turnos
                    if (cat == "Cantidad de Turnos")
                        CargarGrafico("Estado", "CantidadTurnos", gestor.GetTurnosxEstado());
                    else if (cat == "Promedio Turnos x Especialidad")
                        CargarGrafico("Especialidad", "PromediosTurnosxEspecialidad", gestor.GetPromedioTurnosxEspecialidad());
                    break;

                default:
                    graficoReportes.Series.Clear();
                    break;
            }
        }
        protected void CargarGrafico(string x, string y, DataTable data)
        {
           
            graficoReportes.Series.Clear();
           
            var serie = new Series
            {
                XValueMember = x,
                YValueMembers = y,
                ChartType = SeriesChartType.Bar,
                IsValueShownAsLabel = true
            };
            graficoReportes.Series.Add(serie);

         
            graficoReportes.ChartAreas[0].AxisX.Interval = 1;

            graficoReportes.DataSource = data;
            graficoReportes.DataBind();
        }

        protected void ddlReportes_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCategoria.Items.Clear();
            ddlCategoria.Items.Add(new ListItem("--Seleccione--"));
            ddlCategoria.SelectedIndex = 0;
            DropDownList ddl = (DropDownList)sender;

            int valor = int.Parse(ddl.SelectedValue);
           
            switch(valor){
                case 1:
                    ddlCategoria.Items.Add(new ListItem("Por Especialidad"));
                    ddlCategoria.Items.Add(new ListItem("Cantidad de Turnos"));
                    ddlCategoria.Items.Add(new ListItem("Por Edad"));
                    break;
                case 2:
                    ddlCategoria.Items.Add(new ListItem("Por Edad"));
                    ddlCategoria.Items.Add(new ListItem("Por Obra Social"));
                    ddlCategoria.Items.Add(new ListItem("Cantidad de Turnos"));
                    ddlCategoria.Items.Add(new ListItem("Cantidad de Ausentes"));
                    break;
                case 3:
                    ddlCategoria.Items.Add(new ListItem("Cantidad de Turnos"));
                    ddlCategoria.Items.Add(new ListItem("Promedio Turnos x Especialidad"));
                    break;
                default:
                    break;

            }
        }
        
    }
}