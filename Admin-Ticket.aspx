<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin-Ticket.aspx.cs" Inherits="goGst.Admin_Ticket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:TextBox ID="txtsearch" runat="server" AutoPostBack="true" OnTextChanged="txtsearch_TextChanged1" placeholder="Enter search keyword"></asp:TextBox>
 <asp:Button ID="Button3" runat="server" Text="Search" />
       <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
          <asp:ListItem Text="All" Value="all"></asp:ListItem>
          <asp:ListItem Text="Today" Value="today"></asp:ListItem>
          <asp:ListItem Text="Week" Value="week"></asp:ListItem>
          <asp:ListItem Text="Month" Value="month"></asp:ListItem>
          <asp:ListItem Text="Year" Value="year"></asp:ListItem>
  </asp:DropDownList>
 <br />
   <hr />
    <asp:GridView ID="GridView1" runat="server" AutoPostBack="true"  AutoGenerateColumns="False"  CssClass="maintable table table-bordered table-striped"  BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" Width="100%" OnRowDataBound="GridView1_RowDataBound" >

        <Columns>
             <asp:TemplateField HeaderText="Sr. No.">
            <ItemTemplate>
                <asp:Label ID="lblSerialNumber" runat="server"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
            <asp:BoundField DataField="ticket_id" HeaderText="ticket_id" InsertVisible="False" ReadOnly="True" SortExpression="ticket_id" Visible="False"></asp:BoundField>
            <asp:BoundField DataField="client_id" HeaderText="client_id" InsertVisible="False" ReadOnly="True" SortExpression="client_id" Visible="False"></asp:BoundField>
            <asp:BoundField DataField="clientname" HeaderText="Client Name" SortExpression="clientname"></asp:BoundField>
            <asp:BoundField DataField="product_name" HeaderText="Product Name" SortExpression="product_name"></asp:BoundField>
            <asp:BoundField DataField="issue" HeaderText="Issue" SortExpression="issue"></asp:BoundField>
            <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" Visible="False"></asp:BoundField>
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status"></asp:BoundField>

        </Columns>

        <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />    
    </asp:GridView>


    
</asp:Content>
