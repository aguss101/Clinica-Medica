﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidades;
using Negocio;

namespace Vistas.admin
{
    public partial class Administrar_Medicos : System.Web.UI.Page
    {
        private GestorMedico gestorMedico = new GestorMedico();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblUser.Text = Session["User"] as string + "🛠️";
                btnMod.Visible = false;
                btnBaja.Visible = false;

                txbLegajo.Text = string.Empty;
                setPlaceHolders();
            }
        }
        protected void setPlaceHolders()
        {
            txbLegajo.Attributes["placeholder"] = "Legajo";
            txbDni.Attributes["placeholder"] = "DNI";
            txbNombre.Attributes["placeholder"] = "Nombre";
            txbApellido.Attributes["placeholder"] = "Apellido";
            txbfechanacimiento.Attributes["placeholder"] = "Fecha de nacimiento";
            txbDireccion.Attributes["placeholder"] = "Dirección";
            txbTelefono.Attributes["placeholder"] = "Teléfono";
            txbCorreo.Attributes["placeholder"] = "Correo electrónico ";
            txbUsuario.Attributes["placeholder"] = "Nombre de usuario";
            txbContrasenia.Attributes["placeholder"] = "Contraseña";
            txbRepContrasenia.Attributes["placeholder"] = "Repetir contraseña";
            txbPorApellido.Attributes["placeholder"] = "Apellido";
            txbPorDNI.Attributes["placeholder"] = "DNI";
            txbPorLegajo.Attributes["placeholder"] = "Legajo";
        }
        protected void LimpiarFormularioAltaMedico()
        {
            txbNombre.Text = "";
            txbApellido.Text = "";
            txbDni.Text = "";
            txbLegajo.Text = "";
            txbCorreo.Text = "";
            txbTelefono.Text = "";
            txbDireccion.Text = "";
            txbUsuario.Text = "";
            txbfechanacimiento.Text = "";
            txbContrasenia.Text = "";
            txbRepContrasenia.Text = "";

            ddlEspecialidad.ClearSelection();
            ddlGenero.ClearSelection();
            ddlNacionalidad.ClearSelection();
            ddlProvincia.ClearSelection();
            ddlLocalidades.ClearSelection();

           
        }

        protected void btnAlta_Click(object sender, EventArgs e)
        {
            mvFormularios.SetActiveView(vwAlta);
            LimpiarFormularioAltaMedico();
        }
        protected void btnBaja_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (GridViewRow row in gvLecturaMedico.Rows)
                {
                    if (row.FindControl("chkSeleccionar") is CheckBox chk && chk.Checked)
                    {
                        string DNI = row.Cells[2].Text;
                        gestorMedico.EliminarMedico(DNI);
                    }
                }
                loadGridMedicos();
                lblAddUserState.Visible = true;
                lblAddUserState.Text = "Médico dado de baja correctamente.";
                lblAddUserState.ForeColor = System.Drawing.Color.Red;
            }
            catch (Exception ex)
            {
                lblAddUserState.Text = "❌ Error: " + ex.Message;
                lblAddUserState.ForeColor = System.Drawing.Color.Red;
            }
            btnMod.Visible = false;
            btnBaja.Visible = false;
        }
        protected void btnMod_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvLecturaMedico.Rows)
            {
                if (row.FindControl("chkSeleccionar") is CheckBox chk && chk.Checked)
                {
                    string DNI = row.Cells[2].Text;
                    Medico medico = new Medico() { Usuario = new Usuario() };
                    medico = gestorMedico.getMedicoPorID(DNI);
                    lblAddUserState.Visible = false;
                    Session["DNI_VIEJO"] = medico.DNI;
                    Session["LEGAJO_VIEJO"] = medico.Legajo;
                    mvFormularios.SetActiveView(vwModificacion);
                    txtbModMedicoDNI.Text = medico.DNI;
                    txtbModMedicoLegajo.Text = medico.Legajo.ToString();
                    txtbModMedicoNombre.Text = medico.nombre;
                    txtbModMedicoApellido.Text = medico.apellido;
                    DateTime fechaNac = medico.fechaNacimiento.Date;
                    txtbModFechaNac.Text = fechaNac.ToString("yyyy-MM-dd");
                    ddlModNacionalidad.SelectedValue = medico.nacionalidad;
                    if (ddlModEspecialidad.Items.FindByValue(medico.Especialidad.idEspecialidad.ToString()) != null)
                    {
                        ddlModEspecialidad.SelectedValue = medico.Especialidad.idEspecialidad.ToString();
                        break;
                    }
                    ddlModGenero.SelectedValue = medico.sexos.idSexo.ToString();
                    txtbModMedicoDireccion.Text = medico.Direccion;
                    txtbModMedicoTelefono.Text = medico.Telefono.ToString();
                    txtbModMedicoCorreo.Text = medico.Correo;
                    txtbModMedicoUsuario.Text = medico.Usuario.NombreUsuario;
                    txtbModMedicoContrasenia.Text = medico.Usuario.contrasenia;
                }
                btnMod.Visible = false;
                btnBaja.Visible = false;
            }
        }
        protected void btnLectura_Click(object sender, EventArgs e)
        {
            lblAddUserState.Visible = false;
            mvFormularios.SetActiveView(vwLectura);
            loadGridMedicos();
        }
        protected void InsertarMedicos()
        {
            lblAddUserState.Visible = false;
            try
            {
                Medico medico = new Medico()
                {
                    Usuario = new Usuario()
                    {
                        NombreUsuario = txbUsuario.Text.Trim(),
                        contrasenia = txbContrasenia.Text.Trim(),
                        alta = Convert.ToDateTime(DateTime.Now),
                        ultimoIngreso = Convert.ToDateTime(DateTime.Now),
                        idRol = 2
                    },
                    Legajo = txbLegajo.Text.Trim(),
                    DNI = txbDni.Text.Trim(),
                    nombre = txbNombre.Text.Trim(),
                    apellido = txbApellido.Text.Trim(),
                    Especialidad = new Especialidad { idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue), descripcion = ddlEspecialidad.SelectedItem.Text.Trim() },
                    sexos = new Sexos { idSexo = int.Parse(ddlGenero.SelectedValue), descripcion = ddlGenero.SelectedItem.Text },
                    nacionalidad = ddlNacionalidad.SelectedValue.ToString(),
                    fechaNacimiento = Convert.ToDateTime(txbfechanacimiento.Text.Trim()),
                    Direccion = txbDireccion.Text.Trim(),
                    Localidad = int.Parse(ddlLocalidades.SelectedValue),
                    Correo = txbCorreo.Text.Trim(),
                    Telefono = txbTelefono.Text.Trim()
                };

                int filas = gestorMedico.InsertarMedico(medico, medico.Usuario);

                if (filas > 0)
                {
                    lblAddUserState.Text = "Se agregó correctamente el médico";
                    lblAddUserState.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblAddUserState.Text = "Hubo un error durante la carga (no se insertó ninguna fila)";
                    lblAddUserState.ForeColor = System.Drawing.Color.Red;
                }
                lblAddUserState.Visible = true;
            }
            catch (Exception ex)
            {
                lblAddUserState.Text = "❌ Error: " + ex.Message;
                lblAddUserState.ForeColor = System.Drawing.Color.Red;
                lblAddUserState.Visible = true;
            }
        }
        protected void ModificarMedico()
        {
            try
            {
                lblModificarMedico.Visible = false;
                Medico medico = new Medico()
                {
                    Usuario = new Usuario() { NombreUsuario = txtbModMedicoUsuario.Text.Trim(), contrasenia = txtbModMedicoContrasenia.Text.Trim() },
                    DNI = txtbModMedicoDNI.Text.Trim(),
                    Legajo = txtbModMedicoLegajo.Text.Trim(),
                    nombre = txtbModMedicoNombre.Text.Trim(),
                    apellido = txtbModMedicoApellido.Text.Trim(),
                    fechaNacimiento = Convert.ToDateTime(txtbModFechaNac.Text.Trim()),
                    Especialidad = new Especialidad { idEspecialidad = int.Parse(ddlModEspecialidad.SelectedValue), descripcion = ddlModEspecialidad.SelectedItem.Text.Trim() },
                    sexos = new Sexos { idSexo = int.Parse(ddlModGenero.SelectedValue), descripcion = ddlModGenero.SelectedItem.Text.Trim() },
                    nacionalidad = ddlModNacionalidad.SelectedValue,
                    Localidad = int.Parse(ddlModLocalidad.SelectedValue),
                    Direccion = txtbModMedicoDireccion.Text,
                    Telefono = txtbModMedicoTelefono.Text.Trim(),
                    Correo = txtbModMedicoCorreo.Text
                };
                string DNI_VIEJO = (Session["DNI_VIEJO"] as string).Trim();
                string LEGAJO_VIEJO = (Session["LEGAJO_VIEJO"] as string).Trim();

                int filas = gestorMedico.ModificarMedico(medico, medico.Usuario);

                lblModificarMedico.Visible = true;
                if (filas > 0)
                {
                    lblModificarMedico.Text = "Se modifico correctamente el Medico.";
                    lblModificarMedico.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblModificarMedico.Text = "❌ Error: no se modificó ninguna fila.";
                    lblModificarMedico.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblAddUserState.Text = "❌ Error: " + ex.Message;
                lblAddUserState.ForeColor = System.Drawing.Color.Red;
                lblAddUserState.Visible = true;
            }
        }
        protected void loadGridMedicos()
        {
            List<Medico> listaMedicos = new GestorMedico().GetMedicos();
            gvLecturaMedico.DataSource = listaMedicos;
            gvLecturaMedico.DataBind();

            btnMod.Visible = false;
            btnBaja.Visible = false;
            btnJornadas.Visible = false;
        }

        protected void btnRegistrarMedico_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) { InsertarMedicos(); LimpiarFormularioAltaMedico(); }
            else
            {
                lblAddUserState.Text = "⚠️ Por favor corrija los errores del formulario para el Alta.";
                lblAddUserState.ForeColor = System.Drawing.Color.OrangeRed;
                lblAddUserState.Visible = true;
            }
        }
        protected void btnModificarMedico_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) { ModificarMedico(); }
            else
            {
                lblAddUserState.Text = "⚠️ Por favor corrija los errores del formulario para Modificar.";
                lblAddUserState.ForeColor = System.Drawing.Color.OrangeRed;
                lblAddUserState.Visible = true;
            }
        }
        protected void navigateButton_Click(object sender, CommandEventArgs e)
        {
            switch (e.CommandArgument.ToString())
            {
                case "Admin": Response.Redirect("~/admin/Admin.aspx"); break;  
                case "Medicos": Response.Redirect("~/admin/Administrar_Medicos/Administrar_Medicos.aspx"); break;
                case "Pacientes": Response.Redirect("~/admin/Administrar_Pacientes/Administrar_Pacientes.aspx"); break;
                case "Turnos": Response.Redirect("~/admin/Administrar_Turnos/Administrar_Turnos.aspx"); break;
                default: break;
            }
        }
        protected void chkSeleccionar_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkActual = sender as CheckBox;

            GridViewRow fila = (GridViewRow)chkActual.NamingContainer;

            foreach (GridViewRow row in gvLecturaMedico.Rows)
            {
                if (row.FindControl("chkSeleccionar") is CheckBox chk && chk != sender)
                {
                    chk.Checked = false;
                }
                if (chkActual.Checked)
                    Session["LegajoMedico"] = fila.Cells[1].Text.Trim();
                else
                    Session.Remove("LegajoMedico");
            }
            btnMod.Visible = btnBaja.Visible = btnJornadas.Visible = (sender as CheckBox)?.Checked == true;
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e) { ddlLocalidades.DataBind(); }
        protected void ddlModProvincia_SelectedIndexChanged(object sender, EventArgs e) { ddlModLocalidad.DataBind(); }
        protected void gvLecturaMedico_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLecturaMedico.PageIndex = e.NewPageIndex;
            if (Session["DNI"] != null)
            {
                cargarMedicosxDNI();
            }
            if (Session["Apellido"] != null)
            {
                cargarMedicosxApellido();
            }
            if (Session["Legajo"] != null)
            {
                cargarMedicosxLegajo();
            }
            if (Session["Legajo"] == null && Session["Apellido"] == null && Session["DNI"] == null)
            {
                loadGridMedicos();
            }
        }
        protected void ddlBusqueda_Medicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["DNI"] = null;
            Session["Apellido"] = null;
            Session["Legajo"] = null;
            gvLecturaMedico.PageIndex = 0;

            loadGridMedicos();

            switch (ddlBusqueda_Medicos.SelectedIndex)
            {
                case 1:
                    mwBusqueda.ActiveViewIndex = 0;
                    break;
                case 2:
                    mwBusqueda.ActiveViewIndex = 1;
                    break;
                case 3:
                    mwBusqueda.ActiveViewIndex = 2;
                    break;
                default:
                    mwBusqueda.ActiveViewIndex = -1;
                    break;
            }
        }
        protected void cargarMedicosxApellido()
        {
            string apellido = Session["Apellido"].ToString();

            gvLecturaMedico.DataSource = gestorMedico.FiltrarMedicoxApellido(apellido);
            gvLecturaMedico.DataBind();
        }
        protected void cargarMedicosxDNI()
        {
            string dniMedico = Session["DNI"].ToString();

            gvLecturaMedico.DataSource = gestorMedico.FiltrarMedicoxDNI(dniMedico);
            gvLecturaMedico.DataBind();
        }
        protected void cargarMedicosxLegajo()
        {
            string Legajo = Session["Legajo"].ToString();

            gvLecturaMedico.DataSource = gestorMedico.FiltrarMedicoxLegajo(Legajo);
            gvLecturaMedico.DataBind();
        }
        protected void txbPorApellido_TextChanged(object sender, EventArgs e)
        {
            Session["Apellido"] = txbPorApellido.Text.Trim();
            Session["DNI"] = null;
            Session["Legajo"] = null;
            gvLecturaMedico.PageIndex = 0;

            txbPorApellido.Text = "";
            cargarMedicosxApellido();
        }

        protected void txbPorDNI_TextChanged(object sender, EventArgs e)
        {
            Session["DNI"] = txbPorDNI.Text.Trim();
            Session["Apellido"] = null;
            Session["Legajo"] = null;
            gvLecturaMedico.PageIndex = 0;

            txbPorDNI.Text = "";
            cargarMedicosxDNI();
        }
        protected void txbPorLegajo_TextChanged(object sender, EventArgs e)
        {
            Session["Legajo"] = txbPorLegajo.Text.Trim();
            Session["Apellido"] = null;
            Session["DNI"] = null;
            gvLecturaMedico.PageIndex = 0;

            txbPorLegajo.Text = "";
            cargarMedicosxLegajo();
        }

        protected void btnRegistrarJornada_Click(object sender, EventArgs e)
        {
            List<string> diasSeleccionados = new List<string>();
            string legajo = Session["LegajoMedico"] as string;
            TimeSpan hora;
            TimeSpan.TryParse(txbHorarioEntrada.Text, out hora);

            foreach (ListItem item in cblDias.Items)
            {
                if (item.Selected)
                {

                    diasSeleccionados.Add(item.Text);
                }
            }
            if (diasSeleccionados != null)
            {
                gestorMedico.InsertarJornadasMedico(legajo, diasSeleccionados, hora);
            }
            lblAddJornada.ForeColor = System.Drawing.Color.Green;
            lblAddJornada.Text = "Jornada Actualizada";
            lblAddJornada.Visible = true;

            loadGridMedicos();
            lblAddJornada.Visible = false;
            mvFormularios.SetActiveView(vwLectura);
        }

        protected void btnJornadas_Click(object sender, EventArgs e)
        {
            mvFormularios.SetActiveView(vwJornadas);
            btnJornadas.Visible = false;
        }
        protected void cvNombreUsuario_ServerValidate(object source, ServerValidateEventArgs args)
        {
            GestorUsuario gestorUsuario = new GestorUsuario();
            args.IsValid = !gestorUsuario.ValidarNombreUsuario(args.Value);
        }
        protected void cvLegajo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            GestorMedico gestorMedico = new GestorMedico();
            args.IsValid = !gestorMedico.ValidarLegajo(args.Value);
        }
    }
}

