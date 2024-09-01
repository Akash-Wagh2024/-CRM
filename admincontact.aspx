<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="admincontact.aspx.cs" Inherits="goGst.admincontact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: medium;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <%--<asp:LinkButton ID="btnexport_Click" runat="server" OnClick="btnexport_Click_Click"  >Convert into Excel</asp:LinkButton>--%>

    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" placeholder="Enter search keyword" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
 <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"  />
    
    
 <br />
<hr />
      <asp:GridView ID="GridView1" runat="server" CssClass="maintable table table-bordered table-striped" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="False" CellPadding="3" ForeColor="Black" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Width="100%">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:TemplateField HeaderText="Sr. No.">
                <ItemTemplate>
                    <asp:Label ID="lblSerialNumber" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:BoundField DataField="ticket_id" HeaderText="ticket_id" ReadOnly="True" InsertVisible="False" SortExpression="ticket_id" Visible="False"></asp:BoundField>--%>
            <asp:BoundField DataField="full_name" HeaderText="Client Name" SortExpression="full_name"></asp:BoundField>
            <%--<asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" Visible="False"></asp:BoundField>--%>
            <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email"></asp:BoundField>
            <asp:BoundField DataField="Whatsapp_no" HeaderText="Whatsapp No" SortExpression="Whatsapp_no"></asp:BoundField>
            <asp:BoundField DataField="product_name" HeaderText="product Name" SortExpression="product_name"></asp:BoundField>
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

    <asp:LinkButton ID="btnexport_Click" runat="server" OnClick="btnexport_Click_Click"  >Convert into Excel</asp:LinkButton>
    <br />
    

</asp:Content>
