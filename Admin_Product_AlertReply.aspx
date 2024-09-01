<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Product_AlertReply.aspx.cs" Inherits="goGst.Admin_Product_AlertReply" %>

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
                                        <asp:TextBox ID="txtProdName" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>

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
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add Product" Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" />
                            <asp:Button ID="Button3" runat="server" PostBackUrl="~/Admin_Product_Alert.aspx" Text="Cancel" Style="background-color: rgb(110,117,124); color: white; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" />
                        </div>
                    </div>
                </div>
            </div>



            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Label">
       Client Name<span style="color:red;"></span>
                        </asp:Label>
                        <asp:TextBox ID="txtclientname" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>
                    </div>
                </div>


                <div class="col-lg-6">
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Label">
    Email<span style="color:red;"></span>
                        </asp:Label>
                        <asp:TextBox ID="txtemail" ReadOnly="true" runat="server" Class="form-control" ControlToValidate="Txtemail"></asp:TextBox>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" Text="Label">
    Contact Number
                        </asp:Label>
                        <asp:TextBox ID="Txtcontact1" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" Text="Label">
    Whatsapp Number<span style="color:red;"></span>
                        </asp:Label>
                        <asp:TextBox ID="Txtcontact2" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>
                    </div>
                </div>



                <div class="col-lg-6">
                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" Text="Label">
    Product Name<span style="color:red;"></span>
                        </asp:Label>
                        <asp:TextBox ID="txtproductname" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>

                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="form-group">
                        <asp:Label ID="Label6" runat="server" Text="Label">
    Product Code<span style="color:red;"></span>
                        </asp:Label>
                        <asp:TextBox ID="txtproductcode" ReadOnly="true" runat="server" Class="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6 text-center">
                    <div class="form-group">
                        <asp:Label ID="Label8" runat="server" Text="Label">
    Status<span style="color:red;"></span>
                        </asp:Label>
                        <asp:DropDownList ID="DropDownList2" runat="server">
                            <asp:ListItem>[SELECT]</asp:ListItem>
                            <asp:ListItem>Completed</asp:ListItem>
                            <asp:ListItem>In Progress</asp:ListItem>
                            <asp:ListItem>Pending</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6">
                    <a  id="addNewProductButton" class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button" style="background-color: rgb(178,216,228); color: black; border: none; font-weight: 530;"><i class="fa-solid fa-circle-plus"></i>Add New Product</a>
                </div>

                <div class="col-6 mx-auto" style="width: 200px;">
                    <asp:Button ID="btnupdate" OnClick="btnupdate_Click" runat="server" Text="Update" Class="btn" Style="background-color: #ce8f28; color: white; margin-left: -39px;" />
                    <asp:Button ID="btncancel" runat="server" PostBackUrl="~/Admin_Product_Alert.aspx" Text="Cancel" Class="btn offset-5" Style="background-color: #ce8f28; color: white; margin-left: 46px;" />
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

    <script type="text/javascript">
        // Function to show or hide the "Add New Product" button based on the selected value
        function toggleAddNewProductButton() {
            var ddl = document.getElementById('<%= DropDownList2.ClientID %>');
            var addButton = document.getElementById('addNewProductButton');

            // Check if the dropdown has the selected value "Completed"
            if (ddl.value === "Completed") {
                // Show the "Add New Product" button
                addButton.style.display = "inline-block";
            } else {
                // Hide the "Add New Product" button
                addButton.style.display = "none";
            }
        }

        // Attach onchange event listener to the dropdown
        var ddl = document.getElementById('<%= DropDownList2.ClientID %>');
        ddl.onchange = toggleAddNewProductButton;

        // Call the function initially to set the initial visibility state
        toggleAddNewProductButton();
    </script>


  



</asp:Content>
