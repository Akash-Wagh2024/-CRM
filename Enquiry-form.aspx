<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enquiry-form.aspx.cs" Inherits="goGst.Enquiy_form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
    <style>
        * {
            font-family: Poppins;
        }

        body {
            background-color: #f3f5fa;
        }

        .maindiv {
            background-color: #ffffff !important;
            padding: 10px 27px 30px 27px !important;
            border-radius: 8px;
        }
    </style>
 <script>
     function validateForm() {
         var fullName = document.getElementById("txtUserName").value;
         var email = document.getElementById("txtEmail").value;
         var whatsapp = document.getElementById("txtWhatsapp").value;
         var productName = document.getElementById("Ddlproductname").value;
         var source = document.getElementById("ddlSource").value;

         if (fullName.trim() == "") {
             alert("Please enter your full name.");
             return false;
         }
         if (email.trim() == "") {
             alert("Please enter your email.");
             return false;
         }
         if (whatsapp.trim() == "") {
             alert("Please enter your WhatsApp number.");
             return false;
         }
         if (productName.trim() == "") {
             alert("Please select a product.");
             return false;
         }
         if (source.trim() == "") {
             alert("please enter Source.");
         }
         var regex = /^\d{10}$/;

         // Check if the input matches the regular expression
         if (!regex.test(whatsapp)) {
             alert("number should contain only 10 numbers and have a maximum length of 10 digits.");
             return false;
         }

         return true; // Form is valid
     }
 </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <div style="margin-top: 8vh;" class="container">
                    <div class="row ">
                        <div class="col-lg-6 align-items-center mx-auto ">
                            <div class="shadow-md maindiv p-2">
                                <!--form-->
                                <div class="row mt-3">
                                    <div class="col-lg-12 col-sm-12">
                                        <h3>Enquiry Form</h3>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-lg-12 mt-3">
                                        Full Name :
                              <asp:TextBox ID="txtUserName" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 textboxs" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-lg-6">
                                        E-Mail  :
                              <asp:TextBox ID="txtEmail" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 " runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6">
                                        What'sApp Number:
                              <asp:TextBox ID="txtWhatsapp" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 " runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-3">

                                    <div class="col-lg-6">
                                        Contact Number :
                              <asp:TextBox ID="txtContact" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 " runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6 labels ">
                                        <asp:Label ID="Label16" class="" runat="server" Text="Product_code">Product Name </asp:Label><span class="customerstar" style="color: red;"></span>
                                       <%-- <select class="dropdown w-100 border-1 border-start-0 border-top-0 border-end-0 " style="width: 297px; height: 30px;" id="Ddlproductname">
                                            <option value=""></option>
                                            <option value="option1">Option 1</option>
                                            <option value="option2">Option 2</option>
                                            <option value="option3">Option 3</option>
                                        </select>--%>
                                        <asp:DropDownList ID="Ddlproductname" CssClass="dropdown w-100 border-1 border-start-0 border-top-0 border-end-0" style="width: 297px; height: 30px;"  EnableViewState="true"  runat="server"></asp:DropDownList>
                                        <asp:HiddenField ID="SelectedProductIdHiddenField" runat="server" />
                                    </div>
                                </div>

                                <div class="row mt-3">
                                    <div class="col-lg-6">
                                        Organization Name :
                              <asp:TextBox ID="txtOrganizationName" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 " runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6 labels ">
                                        <asp:Label ID="TextSource" class="" runat="server" Text="Product_code"> Source : </asp:Label><span class="customerstar" style="color: red;"></span>
                                       <%-- <select class="dropdown w-100 border-1 border-start-0 border-top-0 border-end-0 " style="width: 297px; height: 30px;" id="ddlSource">
                                            <option value=""></option>
                                            <option value="option1">Instagram</option>
                                            <option value="option2">LinkedIn</option>
                                            <option value="option3">Facebook</option>
                                            <option value="option3">What'sApp</option>
                                        </select>--%>
                                        <asp:DropDownList ID="ddlSource" CssClass="dropdown w-100 border-1 border-start-0 border-top-0 border-end-0"  style="width: 297px; height: 30px;" runat="server">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem>Instagram</asp:ListItem>
                                            <asp:ListItem>Linkedin</asp:ListItem>
                                            <asp:ListItem>Facebook</asp:ListItem>
                                            <asp:ListItem>What&#39;s App</asp:ListItem>
                                        </asp:DropDownList>

                                    </div>

                                </div>



                                <div class="row mt-3">
                                    <div class="col-lg-6">
                                        City :
                              <asp:TextBox ID="txtCity" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 " runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6">
                                        Description :
                              <asp:TextBox ID="txtDescription" Class="w-100 border-1 border-start-0 border-top-0 border-end-0 " runat="server"></asp:TextBox>
                                    </div>
                                </div>



                                <!--form end-->
                                <!--button-->
                                <div class="row mt-4">
                                    <div class="col-lg-6 mx-auto text-center">
<!-- Your existing HTML code with corrections -->

                                        <asp:Button ID="txtsave" OnClick="txtsave_Click" Class="btn fw-bold" Style="background-color: #8CB9BD; color: black;" runat="server" Text="Submit" OnClientClick="return validateForm();" />
                                    </div>
                                    <div class="col-lg-6 mx-auto text-center">
                                        <asp:Button ID="txtcancel"  Class="btn fw-bold " PostBackUrl="~/Marketing-Dashboard.aspx" Style="background-color: #8CB9BD; color: black;" runat="server" Text="Cancel" />
                                    </div>
                                </div>
                                <!--button end-->
                            </div>
        </div>
                    </div>

                </div>

            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


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
</body>
</html>


