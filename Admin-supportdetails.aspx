<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin-supportdetails.aspx.cs" Inherits="goGst.Admin_supportdetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .support {
            width: 100%;
            max-width: 780px;
            height: 117%;
            background: #fff;
            margin: 10px auto;
            padding: 15px;
            box-shadow: 1px 1px 16px rgba(0, 0, 0, 0.3);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <nav aria-label="breadcrumb mt-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Manage</a></li>
            <li class="breadcrumb-item active" aria-current="page">Marketing Form</li>
        </ol>
    </nav>

       <div class="offcanvas-body">
            <div class="container">
                <div class="support">
                    <div class="col-lg-12">
                        <h4 style="font-weight: bold; text-align: center;">Support Employee Profile</h4>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                    </div>

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label12" runat="server" Text="Label">
           Name<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtName" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label14" runat="server" Text="Label">
          Address<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtaddress" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label15" runat="server" Text="Label">
        Date Of Birth<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="Txtdob" runat="server" Class="form-control" DataFormatString="{0:d}" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label16" runat="server" Text="Label">
        Email<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtemail" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label17" runat="server" Text="Label">
      Whatsapp Number<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtWhatsappNo" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>


                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label18" runat="server" Text="Label">
        Contact Number
                                </asp:Label>
                                <asp:TextBox ID="txtContactNo" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label19" runat="server" Text="Label">
        Designation<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtDesignation" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6 mb-3">
                            <div class="form-group">
                                <asp:Label ID="Label20" runat="server" Text="Label">
        Date Of Joinig<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtDOJ" runat="server" Class="form-control" DataFormatString="{0:d}" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-lg-6 mb-3">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Label">
       Employee ID<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="txtempid" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label22" runat="server" Text="Label">
        Gender<span style="color:red;">*</span>
                                </asp:Label>
                               
                             <asp:TextBox ID="txtgender" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>

                            </div>
                        </div>

                        <div>
                            <h4 class="bg-light" style="text-align: center;">Login Detail </h4>
                        </div>


                        <div class="col-lg-6">
                            <div class="form-group">
                                <asp:Label ID="Label23" runat="server" Text="Label">
        Username<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="Txtusername" runat="server" Class="form-control"></asp:TextBox>
                            </div>
                        </div>


                        <div class="col-lg-6 mb-5">
                            <div class="form-group">
                                <asp:Label ID="Label24" runat="server" Text="Label">
        Password<span style="color:red;">*</span>
                                </asp:Label>
                                <asp:TextBox ID="Txtpassword" ReadOnly="true" runat="server" Class="form-control" Type="password"></asp:TextBox>
                            </div>
                        </div>
                                        <div class="col-lg-6 mb-5">
                    <div class="form-group">
                        <asp:Label ID="Lblstatus" runat="server" Text="Label">
Status<span style="color:red;">*</span>
                        </asp:Label>
                        <asp:DropDownList ID="myDropDownList" runat="server">
                            <asp:ListItem Text="*Status*"></asp:ListItem>
                            <asp:ListItem Text="Active" ></asp:ListItem>
                            <asp:ListItem Text="Inactive" ></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                        <div class="col-lg-9">
                            <asp:Button ID="btnupdate"  runat="server" Text="Update" OnClick="btnupdate_Click"  Class="btn offset-6" Style="background-color: #ce8f28; color: white;" />
                            <asp:Button ID="btnCancle" runat="server" PostBackUrl="~/Manage-Support.aspx" Text="Cancle" Class="btn offset-1" Style="background-color: #ce8f28; color: white;" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
   





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
    

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</asp:Content>
