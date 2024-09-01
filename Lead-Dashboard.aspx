<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Lead-Dashboard.aspx.cs" Inherits="goGst.Lead_Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*.chart-container {
            text-align: center;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;*/
            /*            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
*/ /*background-color: #fff;
        }*/
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-4">
                 <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
     <asp:ListItem Text="All" Value="all"></asp:ListItem>
     <asp:ListItem Text="Today" Value="today"></asp:ListItem>
     <asp:ListItem Text="Week" Value="week"></asp:ListItem>
     <asp:ListItem Text="Month" Value="month"></asp:ListItem>
     <asp:ListItem Text="Year" Value="year"></asp:ListItem>
 </asp:DropDownList>
            </div>
            <div class="col-4"></div>
              <div class="col-4"></div>
        </div>
    </div>
   


    <div class="chart-container">
        <div class="row text-center">
            <div class="col-md-6 ">
                <div class="card">
                    <div class="card-header">
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Lead Status Deatils" CssClass="text-center"></asp:Label>
                    </div>
                    <div>
                        <div class="card-body">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:CRMConnectionString2 %>' ProviderName='<%$ ConnectionStrings:CRMConnectionString2.ProviderName %>' SelectCommand="SELECT * FROM [lead]"></asp:SqlDataSource>
                            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1">
                                <Series>
                                    <asp:Series Name="Series1" ChartType="Pie"></asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Text="Ticket Status Deatils" CssClass="text-center"></asp:Label>
                    </div>
                    <div class="card-body">
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:CRMConnectionString2 %>' SelectCommand="SELECT * FROM [ticket]"></asp:SqlDataSource>
                        <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource2">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Doughnut"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
            </div>


            <div class="row">
                
                <div class="col-4 text-start">
                    <asp:DropDownList ID="YearDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="YearDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="select year" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="col-4"></div>
                  <div class="col-4"></div>
            </div>

            <div class="row text-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <asp:Label ID="Label3" runat="server" Font-Bold="true" Text="Total Lead Deatils" CssClass="text-center"></asp:Label>
                        </div>
                        <div class="card-body">
                            <asp:Chart ID="Chart3" runat="server" Style="z-index: 4;" DataSourceID="SqlDataSource1">
                                <Series>
                                    <asp:Series Name="Series1" Color="Red">
                                    </asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1">
                                    </asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                        </div>
                    </div>
                </div>



                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Total Sales Deatils" CssClass="text-center"></asp:Label>

                        </div>
                        <div class="card-body">
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString='<%$ ConnectionStrings:CRMConnectionString3 %>' ProviderName='<%$ ConnectionStrings:CRMConnectionString3.ProviderName %>' SelectCommand="SELECT * FROM [client]"></asp:SqlDataSource>

                            <asp:Chart ID="Chart4" runat="server" DataSourceID="SqlDataSource3">
                                <Series>
                                    <asp:Series Name="Series2" YValuesPerPoint="2" ChartType="Spline" Color="Blue">
                                    </asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea2">
                                    </asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                        </div>
                </div>
            </div>
        </div>
            </div>
        </div>
</asp:Content>
