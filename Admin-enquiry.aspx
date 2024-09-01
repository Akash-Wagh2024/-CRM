<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin-enquiry.aspx.cs" Inherits="goGst.enquiry" %>
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

      <asp:GridView ID="GridView1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="maintable table table-bordered table-striped  "  OnRowDataBound="GridView1_RowDataBound1" runat="server" AutoGenerateColumns="False" Width="100%" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
        <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
        <Columns>
            <asp:TemplateField Visible="false">
            <ItemTemplate>
                <asp:HiddenField ID="hfenquiry_id" runat="server" Value='<%# Eval("enquiry_id") %>' />
                <asp:HiddenField ID="hfproduct_id" runat="server" Value='<%# Eval("product_id") %>' />
            </ItemTemplate>
        </asp:TemplateField>
                             <asp:TemplateField HeaderText="Sr. No.">
    <ItemTemplate>
        <asp:Label ID="lblSerialNumber" runat="server"></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
            <asp:BoundField DataField="full_name" HeaderText="Full name"></asp:BoundField>
            <asp:BoundField DataField="product_name" HeaderText="Product Name"></asp:BoundField>
            <asp:BoundField DataField="email" HeaderText="Email"></asp:BoundField>
            <asp:BoundField DataField="company_name" HeaderText="Company name"></asp:BoundField>
            <asp:BoundField DataField="source" HeaderText="Source"></asp:BoundField>
            <asp:BoundField DataField="whatsapp_no" HeaderText="Whatsapp No"></asp:BoundField>
            <asp:BoundField DataField="description" HeaderText="Description"></asp:BoundField>
            <asp:BoundField DataField="status" HeaderText="status"></asp:BoundField>

            <%-- <asp:HyperLinkField DataTextField="status" HeaderText="Status" SortExpression="status" DataNavigateUrlFields="status" DataNavigateUrlFormatString="Manage-Marketing.aspx?status={0}" Text="Click to Manage Marketing" />
  --%>
            
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
   


</asp:Content>
