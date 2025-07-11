﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrar_Medicos.aspx.cs" Inherits="Vistas.admin.Administrar_Medicos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Panel Administrador</title>
    <link rel="stylesheet" href="style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <table class="tablaDiv">
            <tr>
                <td class="columnaIndex">
                    <table class="auto-style3">
                        <tr>
                            <td class="td-btn-index">
                                <asp:Button ID="btnAdmin" runat="server" Text="Panel Admin" CssClass="btn-index" CommandArgument="Admin" OnCommand="navigateButton_Click" /></td>
                        </tr>
                        <tr>
                            <td class="td-btn-index">
                                <asp:Button ID="btnAdministrarMedico" runat="server" Text="Administrar Médicos" CssClass="btn-index" CommandArgument="Medicos" OnCommand="navigateButton_Click" /></td>
                        </tr>
                        <tr>
                            <td class="td-btn-index">
                                <asp:Button ID="btnAdministrarPacientes" runat="server" Text=" Administrar Pacientes" CssClass="btn-index" CommandArgument="Pacientes" OnCommand="navigateButton_Click" /></td>
                        </tr>
                        <tr>
                            <td class="td-btn-index">
                                <asp:Button ID="btnAdministrarTurnos" runat="server" Text="Administrar Turnos" CssClass="btn-index" CommandArgument="Turnos" OnCommand="navigateButton_Click" /></td>
                        </tr>
                        <tr>
                            <td class="auto-style4"></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="hl-CerrarSesion">
                                <asp:HyperLink ID="hlCerrarSesion" runat="server" NavigateUrl="~/Login/Login.aspx">Cerrar Sesión</asp:HyperLink></td>
                        </tr>
                    </table>
                </td>
                <td class="columnaBody">
                    <table class="auto-style10">
                        <tr>
                            <td class="auto-style22" colspan="3">
                                <div class="titulo-con-nombre">
                                    <h2><span class="clinica">Clínica</span> <span class="frgp">FRGP</span></h2>
                                    <div class="sidebarUser">
                                        <asp:Label ID="lblUser" runat="server" Font-Bold="True" Font-Names="Calibri" Text="Administrador"></asp:Label>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style34" colspan="2">
                                <h2>Administrar Médico</h2>
                            </td>
                            <td class="auto-style35"></td>
                        </tr>
                        <tr>
                            <td class="botonera" colspan="2">
                                <asp:Button ID="btnAlta" runat="server" Text="Registrar" CssClass="btn-td" OnClick="btnAlta_Click" />
                                <asp:Button ID="btnBaja" runat="server" Text="Dar de baja" CssClass="btn-td" OnClick="btnBaja_Click" OnClientClick="return confirm('¿Está seguro que desea dar de baja el medico?');" />
                                <asp:Button ID="btnMod" runat="server" Text="Modificar" CssClass="btn-td" OnClick="btnMod_Click" />
                                <asp:Button ID="btnLectura" runat="server" Text="Listar" CssClass="btn-td" OnClick="btnLectura_Click" />
                                <asp:Button ID="btnJornadas" runat="server" Text="Jornadas" CssClass="btn-td" OnClick="btnJornadas_Click" Visible="False" />
                            </td>
                            <td class="auto-style41"></td>
                        </tr>
                        <tr>
                            <td class="auto-style43" colspan="2">
                                <asp:MultiView ID="mvFormularios" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="vwAlta" runat="server">
                                        <h3>Registrar Médico</h3>
                                        <div>
                                            <table class="auto-style44">
                                                <tr>
                                                    <td class="auto-style32">Legajo:</td>
                                                    <td class="auto-style52">
                                                        <asp:TextBox ID="txbLegajo" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvLegajo" runat="server" ControlToValidate="txbLegajo" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revLegajo" runat="server" ControlToValidate="txbLegajo" Display="Dynamic" ErrorMessage="* El legajo debe iniciar con 'M' y tener tres números (ej. M123). " ForeColor="Red" ValidationExpression="^M\d{3}$$" ValidationGroup="AltaMedico" />
                                                        <asp:CustomValidator ID="cvLegajo" runat="server" ControlToValidate="txbLegajo" Display="Dynamic" ErrorMessage="El legajo ya existe" ForeColor="Red" OnServerValidate="cvLegajo_ServerValidate" ValidateEmptyText="true" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">DNI:</td>
                                                    <td class="auto-style52">
                                                        <asp:TextBox ID="txbDni" runat="server"> </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txbDni" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txbDni" ValidationExpression="^\d{8}$" ErrorMessage="* 8 digitos" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Nombre:</td>
                                                    <td class="auto-style52">
                                                        <asp:TextBox ID="txbNombre" runat="server"> </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvnombre" runat="server" ControlToValidate="txbNombre" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revnombre" runat="server" ControlToValidate="txbNombre" ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$" ErrorMessage="* Solo letras" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Apellido:</td>
                                                    <td class="auto-style52">
                                                        <asp:TextBox ID="txbApellido" runat="server"> </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvapellido" runat="server" ControlToValidate="txbApellido" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revapellido" runat="server" ControlToValidate="txbApellido" ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$" ErrorMessage="* Solo letras" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Especialidad:</td>
                                                    <td class="auto-style52">
                                                        <asp:DropDownList ID="ddlEspecialidad" runat="server" DataSourceID="dbEspecialidades" DataTextField="descripcion" DataValueField="idEspecialidad"></asp:DropDownList>
                                                        <asp:SqlDataSource ID="dbEspecialidades" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT * FROM [Especialidades]"></asp:SqlDataSource>
                                                    </td>
                                                    <td class="auto-style31">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Sexo:</td>
                                                    <td class="auto-style52">
                                                        <asp:DropDownList ID="ddlGenero" runat="server" DataSourceID="dbGenero" DataTextField="descripcion" DataValueField="idSexo"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvgenero" runat="server" ControlToValidate="ddlGenero" InitialValue="" ErrorMessage="* Seleccione un genero" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <br />
                                                        <asp:SqlDataSource ID="dbGenero" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT * FROM [Sexos]"></asp:SqlDataSource>
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Fecha de nacimiento:</td>
                                                    <td class="auto-style52">
                                                        <asp:TextBox ID="txbfechanacimiento" runat="server" TextMode="Date" Height="22px"></asp:TextBox>&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="rfvfechanac" runat="server" ControlToValidate="txbfechanacimiento" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <br />
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Nacionalidad:</td>
                                                    <td class="auto-style52">
                                                        <br />
                                                        <asp:DropDownList ID="ddlNacionalidad" runat="server" DataSourceID="dbNacionalidades" DataTextField="nombrePais" DataValueField="gentilicio"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvpais" runat="server" ControlToValidate="ddlNacionalidad" InitialValue="" ErrorMessage="* Seleccione un país" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <asp:SqlDataSource ID="dbNacionalidades" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT * FROM [Paises]"></asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Provincia:</td>
                                                    <td class="auto-style52">
                                                        <asp:DropDownList ID="ddlProvincia" runat="server" AutoPostBack="True" DataSourceID="dbProvincias" DataTextField="nombreProvincia" DataValueField="idProvincia" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvprovincia" runat="server" ControlToValidate="ddlProvincia" InitialValue="" ErrorMessage="* Seleccione una provincia" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <asp:SqlDataSource ID="dbProvincias" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT idProvincia, nombreProvincia FROM Provincias"></asp:SqlDataSource>
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>

                                                <tr>
                                                    <td class="auto-style32">Localidad:</td>
                                                    <td class="auto-style52">
                                                        <asp:DropDownList ID="ddlLocalidades" runat="server" DataSourceID="dbLocalidades" DataTextField="nombreLocalidad" DataValueField="idLocalidad"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvlocalidades" runat="server" ControlToValidate="ddlLocalidades" InitialValue="" ErrorMessage="* Seleccione una localidad" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <asp:SqlDataSource ID="dbLocalidades" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT idLocalidad, nombreLocalidad FROM Localidades WHERE idProvincia = @idProvincia">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="ddlProvincia" Name="idProvincia" PropertyName="SelectedValue" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                    <td class="auto-style31">&nbsp;</td>
                                                </tr>

                                                <tr>
                                                    <td class="auto-style68">Dirección:</td>
                                                    <td class="auto-style69">
                                                        <asp:TextBox ID="txbDireccion" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvdireccion" runat="server" ControlToValidate="txbDireccion" ErrorMessage="* Campo obligatorio" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revdireccion" runat="server" ControlToValidate="txbDireccion" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ0-9 ]+$" ErrorMessage="* Formato inválido" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style70"></td>
                                                    <td class="auto-style70"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style56">Correo:</td>
                                                    <td class="auto-style57">
                                                        <asp:TextBox ID="txbCorreo" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvcorreo" runat="server" ControlToValidate="txbCorreo" ErrorMessage="* Campo obligatorio" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revcorreo" runat="server" ControlToValidate="txbCorreo" ValidationExpression="^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="* Formato inválido" Display="Dynamic" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style58"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">Teléfono</td>
                                                    <td class="auto-style52">
                                                        <asp:TextBox ID="txbTelefono" runat="server"></asp:TextBox>
                                                        <asp:Label ID="lblCondicioness" runat="server" Font-Bold="True" Font-Size="Smaller" Font-Underline="True" Text="Formato: 11-1234-5678 // 11 1234 5678"></asp:Label>
                                                        <asp:RequiredFieldValidator ID="rfvtelefono" runat="server" ControlToValidate="txbTelefono" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        &nbsp;<asp:RegularExpressionValidator ID="revtelefono" runat="server" ControlToValidate="txbTelefono" Display="Dynamic" ErrorMessage="Invalido" ForeColor="Red" ValidationExpression="^^\d{2}[-\s]\d{4}[-\s]\d{4}$" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style31"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style62">Usuario</td>
                                                    <td class="auto-style63">
                                                        <asp:TextBox ID="txbUsuario" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvusuario" runat="server" ControlToValidate="txbUsuario" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revusuario" runat="server" ControlToValidate="txbUsuario" ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$" ErrorMessage="* Solo letras" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        &nbsp;
                                                        <asp:CustomValidator ID="cvNombreUsuario" runat="server" ControlToValidate="txbUsuario" OnServerValidate="cvNombreUsuario_ServerValidate" ErrorMessage="El nombre de usuario ya existe" ForeColor="Red" Display="Dynamic" ValidateEmptyText="true" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style64"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style56">Contraseña</td>
                                                    <td class="auto-style57">
                                                        <asp:TextBox ID="txbContrasenia" runat="server" TextMode="Password"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvcontrasenia" runat="server" ControlToValidate="txbContrasenia" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style58"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style56">Repetir Contraseña</td>
                                                    <td class="auto-style57">
                                                        <asp:TextBox ID="txbRepContrasenia" runat="server" TextMode="Password"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvrepcontrasenia" runat="server" ControlToValidate="txbRepContrasenia" ErrorMessage="* Campo obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                        <asp:CompareValidator ID="cvContrasenias" runat="server" ControlToCompare="txbContrasenia" ControlToValidate="txbRepContrasenia" ErrorMessage="Las contraseñas no coinciden" ForeColor="Red" Operator="Equal" Type="String" Display="Dynamic" ValidationGroup="AltaMedico" />
                                                    </td>
                                                    <td class="auto-style58"></td>

                                                </tr>
                                                <tr>
                                                    <td class="auto-style32">
                                                        <asp:Button ID="btnRegistrarMedico" runat="server" Text="Registrar medico" Width="188px" OnClick="btnRegistrarMedico_Click" ValidationGroup="AltaMedico" CausesValidation="True" /></td>
                                                    <td class="auto-style52">&nbsp;</td>
                                                    <td class="auto-style31">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="vwJornadas" runat="server">
                                        Gestionar Jornadas<table class="auto-style44">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txbHorarioEntrada" runat="server" TextMode="Time"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBoxList ID="cblDias" runat="server" RepeatDirection="Horizontal" Width="387px">
                                                        <asp:ListItem>Lunes</asp:ListItem>
                                                        <asp:ListItem>Martes</asp:ListItem>
                                                        <asp:ListItem Value="Miercoles">Miercoles</asp:ListItem>
                                                        <asp:ListItem>Jueves</asp:ListItem>
                                                        <asp:ListItem>Viernes</asp:ListItem>
                                                        <asp:ListItem>Sabado</asp:ListItem>
                                                        <asp:ListItem>Domingo</asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <br />
                                                    <asp:Label ID="lblAddJornada" runat="server" Font-Size="X-Large" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnRegistrarJornada" runat="server" OnClick="btnRegistrarJornada_Click" Text="Registrar Jornada" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="vwModificacion" runat="server">
                                        <h3>Modificar Medico</h3>
                                        <div>
                                            <table class="auto-style44">
                                                <tr>
                                                    <td class="auto-style51">Legajo:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoLegajo" Enabled="false" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModLegajo" runat="server" ControlToValidate="txtbModMedicoLegajo" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">DNI:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoDNI" Enabled="false" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModDni" runat="server" ControlToValidate="txtbModMedicoDNI" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Nombre:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoNombre" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModNombre" runat="server" ControlToValidate="txtbModMedicoNombre" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Apellido:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoApellido" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModApellido" runat="server" ControlToValidate="txtbModMedicoApellido" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style49">Especialidad:</td>
                                                    <td class="auto-style50">
                                                        <asp:DropDownList ID="ddlModEspecialidad" runat="server" DataSourceID="dbEspecialidades" DataTextField="descripcion" DataValueField="idEspecialidad"></asp:DropDownList>
                                                        <asp:SqlDataSource ID="dbespecialidad" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT * FROM [Especialidades]"></asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Fecha de nacimiento:</td>
                                                    <td>
                                                        <asp:TextBox ID="txtbModFechaNac" runat="server" TextMode="Date"></asp:TextBox>&nbsp;&nbsp;&nbsp;<asp:Label ID="lblCondiciones0" runat="server" Font-Bold="True" Font-Size="Smaller" Font-Underline="True" Text="Formato: YYYY-MM-DD"></asp:Label>
                                                        <asp:RequiredFieldValidator ID="rfvModFechaNac" runat="server" ControlToValidate="txtbModFechaNac" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                        <asp:RegularExpressionValidator ID="revModFechaNac" runat="server" ControlToValidate="txtbModFechaNac" Display="Dynamic" ErrorMessage="* Formato inválido (YYYY-MM-DD)" ForeColor="Red" ValidationExpression="^\d{4}-\d{2}-\d{2}$" ValidationGroup="ModMedico" />
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Sexo:</td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlModGenero" runat="server" DataSourceID="dbGenero" DataTextField="descripcion" DataValueField="idSexo"></asp:DropDownList>
                                                        <asp:SqlDataSource ID="dbModGenero" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT * FROM [Correos]"></asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Nacionalidad:</td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlModNacionalidad" runat="server" DataSourceID="dbNacionalidades" DataTextField="nombrePais" DataValueField="gentilicio">
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="dbModNacionalidades" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT * FROM [Correos]"></asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Provincia:</td>
                                                    <td class="auto-style46">
                                                        <asp:DropDownList ID="ddlModProvincia" runat="server" AutoPostBack="True" DataSourceID="dbModProvincia" DataTextField="nombreProvincia" DataValueField="idProvincia" OnSelectedIndexChanged="ddlModProvincia_SelectedIndexChanged"></asp:DropDownList>
                                                        <asp:SqlDataSource ID="dbModProvincia" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT idProvincia, nombreProvincia FROM Provincias"></asp:SqlDataSource>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>

                                                <tr>
                                                    <td class="auto-style51">Localidad:</td>
                                                    <td class="auto-style46">
                                                        <asp:DropDownList ID="ddlModLocalidad" runat="server" DataSourceID="dbModLocalidad" DataTextField="nombreLocalidad" DataValueField="idLocalidad"></asp:DropDownList>
                                                        <asp:SqlDataSource ID="dbModLocalidad" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicaDBConnectionGlobal %>" SelectCommand="SELECT idLocalidad, nombreLocalidad FROM Localidades WHERE idProvincia = @idProvincia">
                                                            <SelectParameters>
                                                                <asp:ControlParameter Name="idProvincia" ControlID="ddlModProvincia" PropertyName="SelectedValue" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>

                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Direccion:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoDireccion" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModDireccion" runat="server" ControlToValidate="txtbModMedicoDireccion" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="AltaMedico" />
                                                        <asp:RegularExpressionValidator ID="revModDireccion" runat="server" ControlToValidate="txtbModMedicoDireccion" Display="Dynamic" ErrorMessage="* Formato inválido" ForeColor="Red" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ0-9 ]+$" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Telefono:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoTelefono" runat="server"></asp:TextBox>
                                                        <asp:Label ID="lblCondicioness0" runat="server" Font-Bold="True" Font-Size="Smaller" Font-Underline="True" Text="Formato: 11-1234-5678 // 11 1234 5678"></asp:Label>
                                                        <asp:RequiredFieldValidator ID="rfvModTelefono" runat="server" ControlToValidate="txtbModMedicoTelefono" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                        <asp:RegularExpressionValidator ID="revModTelefono" runat="server" ControlToValidate="txtbModMedicoTelefono" Display="Dynamic" ErrorMessage="Invalido" ForeColor="Red" ValidationExpression="^^\d{2}[-\s]\d{4}[-\s]\d{4}$" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Correo:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoCorreo" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModCorreo" runat="server" ControlToValidate="txtbModMedicoCorreo" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                        <asp:RegularExpressionValidator ID="revModCorreo" runat="server" ControlToValidate="txtbModMedicoCorreo" Display="Dynamic" ErrorMessage="* Formato inválido" ForeColor="Red" ValidationExpression="^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Usuario:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoUsuario" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModContrasenia" runat="server" ControlToValidate="txtbModMedicoUsuario" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">Contrasenia:</td>
                                                    <td class="auto-style46">
                                                        <asp:TextBox ID="txtbModMedicoContrasenia" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvModRContrasenia" runat="server" ControlToValidate="txtbModMedicoContrasenia" Display="Dynamic" ErrorMessage="* Campo obligatorio" ForeColor="Red" ValidationGroup="ModMedico" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style51">
                                                        <asp:Button ID="btnModificarMedico" runat="server" OnClick="btnModificarMedico_Click" Text="Modificar Medico" Width="188px" ValidationGroup="ModMedico" /></td>
                                                    <td class="auto-style46">
                                                        <asp:Label ID="lblModificarMedico" runat="server" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </table>
                                            <br />
                                        </div>
                                    </asp:View>
                                    <asp:View ID="vwLectura" runat="server">
                                        <h3>Listar Médico</h3>
                                        <div class="div-ddl">
                                            <h3 class="auto-style71" style="margin: 0;">Seleccione una búsqueda o filtro:</h3>
                                            <asp:DropDownList ID="ddlBusqueda_Medicos" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBusqueda_Medicos_SelectedIndexChanged">
                                                <asp:ListItem Text="--Seleccione una búsqueda o filtro--" Value="-1" Selected="True" />
                                                <asp:ListItem>Búsqueda por Apellido</asp:ListItem>
                                                <asp:ListItem>Búsqueda por DNI</asp:ListItem>
                                                <asp:ListItem>Búsqueda por Legajo</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div>
                                            <asp:MultiView ID="mwBusqueda" runat="server">
                                                <asp:View ID="vwPorApellido" runat="server">
                                                    <div>
                                                        <table class="auto-style32">
                                                            <tr>
                                                                <td class="auto-style72">Ingrese apellido:</td>
                                                                <td class="auto-style73">
                                                                    <asp:TextBox ID="txbPorApellido" runat="server" AutoPostBack="True" OnTextChanged="txbPorApellido_TextChanged"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="vwPorDNI" runat="server">
                                                    <div>
                                                        <table class="auto-style32">
                                                            <tr>
                                                                <td class="auto-style36">Ingrese DNI:</td>
                                                                <td>
                                                                    <asp:TextBox ID="txbPorDNI" runat="server" OnTextChanged="txbPorDNI_TextChanged" AutoPostBack="True"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="vwPorLegajo" runat="server">
                                                    <div>
                                                        <table class="auto-style32">
                                                            <tr>
                                                                <td class="auto-style36">Ingrese legajo:</td>
                                                                <td>
                                                                    <asp:TextBox ID="txbPorLegajo" runat="server" OnTextChanged="txbPorLegajo_TextChanged" AutoPostBack="True"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </asp:View>
                                            </asp:MultiView>
                                            <asp:GridView ID="gvLecturaMedico" runat="server" AllowPaging="True" AutoGenerateColumns="False" 
    CssClass="modern-grid" 
    OnPageIndexChanging="gvLecturaMedico_PageIndexChanging" 
    Style="margin-right: 0px">
    
    <AlternatingRowStyle CssClass="alt-row" />
    
    <Columns>
        <asp:TemplateField HeaderText="Seleccionar">
            <ItemTemplate>
                <asp:CheckBox ID="chkSeleccionar" runat="server" AutoPostBack="true" OnCheckedChanged="chkSeleccionar_CheckedChanged" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Legajo" HeaderText="Legajo" />
        <asp:BoundField DataField="DNI" HeaderText="DNI" />
        <asp:BoundField DataField="nombre" HeaderText="Nombre" />
        <asp:BoundField DataField="apellido" HeaderText="Apellido" />
        <asp:BoundField DataField="Usuario.nombreUsuario" HeaderText="Usuario" />
        <asp:BoundField DataField="Usuario.contrasenia" HeaderText="Contraseña" />
        <asp:BoundField DataField="Sexos.descripcion" HeaderText="Genero" />
        <asp:BoundField DataField="Especialidad.descripcion" HeaderText="Especialidad" />
        <asp:BoundField DataField="nacionalidad" HeaderText="Nacionalidad" />
        <asp:BoundField DataField="Provincias.nombreProvincia" HeaderText="Provincia" />
        <asp:BoundField DataField="Localidades.nombreLocalidad" HeaderText="Localidad" />
        <asp:BoundField DataField="correo" HeaderText="Correo" />
        <asp:BoundField DataField="telefono" HeaderText="Telefono" />
        <asp:BoundField DataField="SiglasDiasHabiles" HeaderText="Dias Habiles" />
        <asp:BoundField DataField="entrada" HeaderText="Hora" />
    </Columns>

    <PagerStyle CssClass="grid-pager" />
</asp:GridView>
                                        </div>
                                    </asp:View>
                                </asp:MultiView>
                            </td>
                            <td class="auto-style41"></td>
                        </tr>
                        <tr>
                            <td class="auto-style43" colspan="2">&nbsp;</td>
                            <td class="auto-style41">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style43" colspan="2">&nbsp;</td>
                            <td class="auto-style41">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style33">
                                <h3>
                                    &nbsp;</h3>
                            </td>
                            <td class="auto-style38"></td>
                            <td class="auto-style39"></td>
                        </tr>
                        <tr>
                            <td class="auto-style37">
                                    <asp:Label ID="lblAddUserState" runat="server" Visible="False"></asp:Label></td>
                            <td class="no-select"></td>
                            <td class="auto-style28"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
