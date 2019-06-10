<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
Iniciar Sesion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <div class="ui grid">
            <div class="ten wide column" style="border-right:1px solid rgba(34,36,38,.15);">
                <img src="Content/img/condor.jpg" />
            </div>
            <div class="six wide column">
                <div class="top "></div>
                <form class="ui form" method="post" action="">
                    <div class="ui centered header">Iniciar Sesion</div>
                    <div class="field">
                        <input type="text" placeholder="Nombre de Usuario" required name="user"/>
                    </div>
                    <div class="field">
                        <input type="password" placeholder="Contraseña" required  name="pass"/>
                    </div>
                    <input type="submit" value="Ingresar" class="ui fluid button"/>
                </form>
            </div>
        </div>
    </section>
</asp:Content>
