<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing.Master" AutoEventWireup="true" CodeBehind="Lead-marketing.aspx.cs" Inherits="goGst.Lead_form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modal.left .modal-dialog {
            position: fixed;
            right: 0;
            margin: auto;
            width: 750px;
            height: 100%;
            -webkit-transform: translate3d(0%, 0, 0);
            -ms-transform: translate3d(0%, 0, 0);
            -o-transform: translate3d(0%, 0, 0);
            transform: translate3d(0%, 0, 0);
            --bs-modal-width: 580px;
    </style>

    <script type="text/javascript">
        function validateForm() {
        var clientName = document.getElementById('<%= txtName.ClientID %>').value.trim();
        var companyName = document.getElementById('<%= txtCompany.ClientID %>').value.trim();
        var productName = document.getElementById('<%= Ddlproductname.ClientID %>').value.trim();
        var whatsappNo = document.getElementById('<%= txtwhatsappno.ClientID %>').value.trim();
        var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();

        // Validate Client Name
        if (clientName === "") {
            alert("Please enter Client Name.");
            return false;
        }

        // Validate Company/Enterprises
        if (companyName === "") {
            alert("Please enter Company/Enterprises.");
            return false;
        }

        // Validate Product Name
        if (productName === "") {
            alert("Please select Product Name.");
            return false;
        }

        // Validate Whatsapp No
            if (whatsappNo === "") {
                alert("Please enter Whatsapp No.");
                return false;
            }
            var regex = /^\d{10}$/;

            // Check if the input matches the regular expression
            if (!regex.test(whatsappNo)) {
                alert("number should contain only 10 numbers and have a maximum length of 10 digits.");
                return false;
            }

        // Validate Email
        if (email === "") {
            alert("Please enter Email.");
            return false;
        } else if (!isValidEmail(email)) {
            alert("Please enter a valid Email address.");
            return false;
        }

        return true; // Form is valid
        }
        function isValidEmail(email) {
            // Regular expression for email validation
            var emailRegex = /\S+@\S+\.\S+/;
            return emailRegex.test(email);
        }
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


  <%--  <div class="container h-100 mb-3">
        <div class="row bg-white" style="height: 49px;">
            <div class="col-md-6">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb " style="justify-content: start; font-size: large; align-self: center; margin-top: 11px;">
                        <li><i class="fa-solid fa-table-list text-dark fs-2 me-2 shadow-sm "></i></li>
                        <li class="breadcrumb-item text-dark fs-5">Leads</li>
                    </ol>
                </nav>
            </div>





            <div class="col-md-6">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb text-end" style="justify-content: end; font-size: large; align-self: center; margin-top: 11px;">
                        <li class="breadcrumb-item"><a href="Marketing-Dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="#">Lead</a></li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>--%>

       <div class="container bg-light ">
       <div class="row bg-white" style="height: 48px;">
           <div class="col-md-6">
               <h3 class=" d-flex align-items-center ">
                   <span class="text-white  me-2 mt-1 rounded" style="background-color: rgb(34, 84, 67);">
                       <i class="fa-solid fa-book fs-6 m-2" style="padding: 3px"></i>
                   </span>
                   <span class="fs-5 text-black mt-2 fw-bold">Lead</span>
               </h3>
           </div>
           <div class="col-md-6 text-end">
               <ul class="breadcrumb bg-white"style="justify-content: end; font-size: large; align-self: center; margin-top: 11px;" >
                   <li class="breadcrumb-item"><a href="Marketing-Dashboard.aspx" class="text-gray" style="text-decoration: none;">Dashboard</a></li>
                   <li class="breadcrumb-item text-gray">Lead</li>
               </ul>
           </div>

       </div>
   </div>






    <div class=" container-fluid mt-3">
        <div class="row">

            <div class="col-lg-4 " style="border: none; background-color: rgb(246 249 255); justify-content: start; margin-left: -14px;">
                <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="true"  Style="border: none; background-color: rgb(246 249 255);">
                    <asp:ListItem Text="All Leads" Value="all"></asp:ListItem>
                    <asp:ListItem Text="Today" Value="today"></asp:ListItem>
                    <asp:ListItem Text="Week" Value="week"></asp:ListItem>
                    <asp:ListItem Text="Month" Value="month"></asp:ListItem>
                    <asp:ListItem Text="Year" Value="year"></asp:ListItem>
                </asp:DropDownList>
            </div>

       


            <div class="col-lg-4"></div>
            <div class="col-lg-4 text-end">
                <ul class="list-inline-item">
                    <li class="list-inline-item">
                        <button type="button" class="btn " data-bs-toggle="modal" data-bs-target="#exampleModal" style="background-color: rgb(178,216,228); color: black; border: none; font-weight: 530; margin-left: 46px;">
                            <i class="fa-solid fa-circle-plus"></i>
                            Add New 
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <hr style="margin-top: -4px;" />

    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" CssClass="maintable table table-bordered table-striped " BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" Width="100%">
        <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
        <Columns>
            <asp:BoundField DataField="@lead_id" HeaderText="lead ID" Visible="false"></asp:BoundField>
            <asp:TemplateField HeaderText="full Name">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkProfile" runat="server" Text='<%# Eval("full_name") %>' NavigateUrl='<%# "lead-profile.aspx?id=" + Eval("lead_id") %>'></asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtitemcode" runat="server" Text='<%# Bind("full_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="company_name" HeaderText="Company Name" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="Whatsapp_no" HeaderText="Whatsapp No" />
            <asp:BoundField DataField="description" HeaderText="Description" />
            <asp:BoundField DataField="status" HeaderText="Status" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC"></FooterStyle>

        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

        <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>

        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

        <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

        <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

        <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

        <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
    </asp:GridView>


    <!-- Modal -->
    <div class="modal left fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Marketing Form</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel runat="server" CssClass="row g-3 m-auto rounded">
                        <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtName" CssClass="form-label">Client Name <span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="txtName" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtCompany" CssClass="form-label"> Company/Enterprices<span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="txtCompany" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-md-4">

                            <asp:Label ID="Label17" runat="server" Text="Label">Product Name<span style="color:red;">*</span>
                            </asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList ID="Ddlproductname" Style="width: 314px; height: 39px; border-radius: 6px;" runat="server"  AutoPostBack="true"></asp:DropDownList>


                        </div>
                        <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtwhatsappno" CssClass="form-label">Whatsapp No <span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="txtwhatsappno" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="form-label">Email <span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtdescription" CssClass="form-label">Description</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="txtdescription" CssClass="form-control" TextMode="MultiLine" Rows="8"></asp:TextBox>
                        </div>
                    </asp:Panel>
                </div>
                <div class="modal-footer justify-content-between">
                    <asp:Button ID="btnSaveChanges" runat="server" OnClick="btnSaveChanges_Click1" Text="Save" CssClass="btn btn-primary" Style="background-color: RGB(178,216,228); color: black; border: none" />
                    <asp:Button ID="btnClose" runat="server" Text="Cancel" CssClass="btn btn-secondary" data-dismiss="modal" />



                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"> </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"> </script>
    <input type="hidden" id="latitude" name="latitude" />
    <input type="hidden" id="longitude" name="longitude" />

    <script>
        // Check if the browser supports geolocation
        if ("geolocation" in navigator) {
            // Get the geolocation coordinates
            navigator.geolocation.getCurrentPosition(function (position) {
                var latitude = position.coords.latitude;
                var longitude = position.coords.longitude;

                // Set the latitude and longitude values in the hidden input fields
                document.getElementById("latitude").value = latitude;
                document.getElementById("longitude").value = longitude;
            });
        } else {
            console.log("Geolocation is not available in this browser.");
        }
    </script>

</asp:Content>
