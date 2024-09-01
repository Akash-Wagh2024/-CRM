<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Product_Alert.aspx.cs" Inherits="goGst.Admin_Product_Alert" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="maintable table table-bordered table-striped">
        <Columns>
            <asp:BoundField DataField="clientname" HeaderText="Client Name"></asp:BoundField>
            <asp:BoundField DataField="contact1" HeaderText="Contact"></asp:BoundField>
            <asp:BoundField DataField="product_name" HeaderText="Product Name"></asp:BoundField>
            <asp:BoundField DataField="created_date" HeaderText="Created Date"></asp:BoundField>
            <asp:BoundField DataField="status" HeaderText="Status"></asp:BoundField>
            <asp:TemplateField HeaderText="Reply Client">
                <ItemTemplate>
                    <asp:HiddenField ID="hfalert_id" runat="server" Value='<%# Eval("alert_id") %>' />
                    <asp:LinkButton ID="btnEdit" runat="server" Text="View Details" CommandName="EditRow" OnClick="btnEdit_Click" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
