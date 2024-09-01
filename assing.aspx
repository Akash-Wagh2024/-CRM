<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="assing.aspx.cs" Inherits="goGst.assing"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="maintable table table-bordered table-striped" DataKeyNames="support_id" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" Width="100%">
        <Columns>
            <asp:BoundField DataField="ticket_id" HeaderText="Ticket ID" Visible="false" />
            <asp:BoundField DataField="support_id" HeaderText="Support ID" Visible="false" />
            <asp:BoundField DataField="name" HeaderText="Support Name"></asp:BoundField>
            <asp:BoundField DataField="contact1" HeaderText="Contact"></asp:BoundField>
            <asp:BoundField DataField="product_name" HeaderText="Product Name"></asp:BoundField>
<%--            <asp:BoundField DataField="available" HeaderText="Availability"></asp:BoundField>--%>
             <asp:TemplateField HeaderText="Assign To">
            <ItemTemplate>
                <asp:Button ID="btnAction" runat="server" Text="Action" CommandName="DoSomething" CommandArgument='<%# Eval("name") %>' OnClick="btnAction_Click"/>
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC"></FooterStyle>

    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

    <PagerStyle HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black"></PagerStyle>

    <RowStyle BackColor="White"></RowStyle>

    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

    <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

    <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

    <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

    <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
</asp:GridView>
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
</asp:Content>
