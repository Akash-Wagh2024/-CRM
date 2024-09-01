<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin-clientdetails.aspx.cs" Inherits="goGst.Admin_clientdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .client {
            width: 100%;
            max-width: 780px;
            height: 117%;
            background: #fff;
            margin: 10px auto;
            padding: 15px;
            box-shadow: 1px 1px 16px rgba(0, 0, 0, 0.3);
        }
    </style>
    <script>
        function validateForm() {
        var clientname = document.getElementById('<%= txtname.ClientID %>').value;
        var productName = document.getElementById('<%= Ddlproductname.ClientID %>').value;
        var issueDate = document.getElementById('<%= txtissue.ClientID %>').value;
        var expiryDate = document.getElementById('<%= txtexpiry.ClientID %>').value;

            if (clientname.trim() === "") {
                alert("Please select a client name.");
                return false;
            }

            if (productName.trim() === "") {
                alert("Please select a product name.");
                return false;
            }

            // Check if issue date is filled out
            if (issueDate.trim() === "") {
                alert("Please enter the issue date.");
                return false;
            }

            // Check if expiry date is filled out
            if (expiryDate.trim() === "") {
                alert("Please enter the expiry date.");
                return false;
            }

            // Additional validation logic can be added here if needed

            return true; // Form is valid, allow submission
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container">
        <div class="client">

            <div class="col-lg-12">
                <h4 style="font-weight: bold; text-align: center;">Client Profile </h4>
            </div>

                 <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalToggleLabel">Add Product</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="row">
                                        
                                        <div class="col-md-4">
                                            <asp:Label ID="Label7" runat="server">Client Name<span style="color:red;"></span></asp:Label>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtname" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                        </div>
                                         <br />
                                        <br />
                                        <div class="col-md-4">
                                            <asp:Label ID="Label18" runat="server" Text="Label">Product Name<span style="color:red;">*</span></asp:Label>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList ID="Ddlproductname" runat="server" CssClass="form-control"></asp:DropDownList>
                                            
                                        </div>
                                        <br />
                                        <br />

                                        <div class="col-md-4">
                                            <asp:Label ID="Label19" runat="server" Text="Label">Issue Date<span style="color:red;">*</span></asp:Label>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtissue" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <br />
                                        <br />

                                        <div class="col-md-4">
                                            <asp:Label ID="Label20" runat="server" Text="Label">Expiry Date<span style="color:red;">*</span></asp:Label>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtexpiry" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="modal-footer justify-content-evenly">
                                <asp:Button ID="Button1" runat="server" Text="Add Product"  OnClick="Button1_Click" OnClientClick="return validateForm();" Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" />
                                <asp:Button ID="Button3" runat="server" Text="Cancel" OnClick="Button3_Click" Style="background-color: rgb(110,117,124); color: white; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" />
                            </div>
                        </div>
                    </div>
                </div>
                <a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button" style="background-color: rgb(178,216,228); color: black; border: none; font-weight: 530;"><i class="fa-solid fa-circle-plus"></i>Add New Product</a>

           
           
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" Text="Label">
       Client Name<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="txtclientname" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" Text="Label">
      Company/Enterprises Name<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="txtcomapnyname" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" Text="Label">
    Whatsapp Number<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtcontact1" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="Label">
    Contact Number
                            </asp:Label>
                            <asp:TextBox ID="Txtcontact2" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label5" runat="server" Text="Label">
    Email<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtemail" runat="server" Class="form-control" ControlToValidate="Txtemail"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email is Required" BackColor="Red" ValidateRequestMode="Inherit" ControlToValidate="Txtemail"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label6" runat="server" Text="Label">
  Website<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtwebsite" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>



                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label17" runat="server" Text="Label">
    Product Name<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="txtproductname" runat="server" class="form-control"></asp:TextBox>

                        </div>
                    </div>



                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label8" runat="server" Text="Label">
    Product Code<span style="color:red;">*</span>
                            </asp:Label>

                            <asp:TextBox ID="Txtproductcode" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label15" runat="server" Text="Label">
    Issue Date<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtissuedate" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label16" runat="server" Text="Label">
    Expiry Date<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtexpirydate" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label11" runat="server" Text="Label">
    Zip Code<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtzip" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label12" runat="server" Text="Label">
    City<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtcity" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label13" runat="server" Text="Label">
    State<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtstate" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>


                    <div class="col-lg-6 mb-4">
                        <div class="form-group">
                            <asp:Label ID="Label14" runat="server" Text="Label">
    Country<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtcountry" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>



                    <div>
                        <h4 class="bg-light " style="text-align: center;">Login Detail </h4>
                    </div>


                    <div class="col-lg-6">
                        <div class="form-group">
                            <asp:Label ID="Label9" runat="server" Text="Label">
    Username<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtusername" runat="server" Class="form-control"></asp:TextBox>
                        </div>
                    </div>


                    <div class="col-lg-6 mb-5">
                        <div class="form-group">
                            <asp:Label ID="Label10" runat="server" Text="Label">
    Password<span style="color:red;">*</span>
                            </asp:Label>
                            <asp:TextBox ID="Txtpassword" ReadOnly="true" runat="server" Class="form-control" Type="password"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-6 mx-auto" style="width: 200px;">
                        <asp:Button ID="btnupdate" runat="server" Text="Update" OnClick="btnupdate_Click" Class="btn" Style="background-color: #ce8f28; color: white; margin-left: -39px;" />
                        <asp:Button ID="btncancel" runat="server" PostBackUrl="~/manage-client.aspx" Text="Cancel" Class="btn offset-5" Style="background-color: #ce8f28; color: white; margin-left: 46px;" />
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

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


</asp:Content>
