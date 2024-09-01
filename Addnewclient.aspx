<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Addnewclient.aspx.cs" Inherits="goGst.Addnewclient" %>
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
        }

        .modal.right.fade .modal-dialog {
            left: -320px;
            -webkit-transition: opacity 0.3s linear, left 0.3s ease-out;
            -moz-transition: opacity 0.3s linear, left 0.3s ease-out;
            -o-transition: opacity 0.3s linear, left 0.3s ease-out;
            transition: opacity 0.3s linear, left 0.3s ease-out;
        }

        .fixed-button {
            position: fixed;
            top: 20%;
            right: 25px;
        }

        .fixed-button1 {
            position: fixed;
        }
        .modal-header {
            display: flex;
            flex-shrink: 0;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 1rem;
            border-bottom: 1px solid #dee2e6;
            border-top-left-radius: calc(0.3rem - 1px);
            border-top-right-radius: calc(0.3rem - 1px);
        }
        .modal-content {
            position: relative;
            display: flex;
            flex-direction: column;
            width: 100%;
            pointer-events: auto;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid rgba(0, 0, 0, .2);
            border-radius: 0.3rem;
            outline: 0;
        }

        .modal-footer {
            display: flex;
            flex-wrap: wrap;
            flex-shrink: 0;
            align-items: center;
            justify-content: flex-end;
            padding: 0.75rem;
            border-top: 1px solid #dee2e6;
            border-bottom-right-radius: calc(0.3rem - 1px);
            border-bottom-left-radius: calc(0.3rem - 1px);
                margin-top: 20px;
        }
        .modal-body {
    position: relative;
    flex: 1 1 auto;
    padding: 1rem;
}
    </style>
    <script>
        function validateForm() {
        var clientname = document.getElementById('<%= txtclientname.ClientID %>').value.trim();
        var comapnyname = document.getElementById('<%= txtcomapnyname.ClientID %>').value.trim();
        var contact2 = document.getElementById('<%= Txtcontact2.ClientID %>').value.trim();
        var email = document.getElementById('<%= Txtemail.ClientID %>').value.trim();
        var issuedate = document.getElementById('<%= Txtissuedate.ClientID %>').value.trim();
        var expirydate = document.getElementById('<%= Txtexpirydate.ClientID %>').value.trim();
        //var zip = document.getElementById('<%= Txtzip.ClientID %>').value.trim();
        //var city = document.getElementById('<%= Txtcity.ClientID %>').value.trim();
        //var state = document.getElementById('<%= Txtstate.ClientID %>').value.trim();
        //var country = document.getElementById('<%= Txtcountry.ClientID %>').value.trim();
        var username = document.getElementById('<%= Txtusername.ClientID %>').value.trim();
        var password = document.getElementById('<%= Txtpassword.ClientID %>').value.trim();

            if (clientname === "") {
                alert("Please enter the client name.");
                return false;
            }
            if (comapnyname === "") {
                alert("Please enter the company name.");
                return false;
            }
            if (contact2 === "") {
                alert("Please enter the Whatsapp number.");
                return false;
            }
            if (email === "") {
                alert("Please enter the email.");
                return false;
            }
            if (issuedate === "") {
                alert("Please select the issue date.");
                return false;
            }
            if (expirydate === "") {
                alert("Please select the expiry date.");
                return false;
            }
            if (username === "") {
                alert("Please enter the username.");
                return false;
            }
            if (password === "") {
                alert("Please enter the password.");
                return false;
            }
            var regex = /^\d{10}$/;

            // Check if the input matches the regular expression
            if (!regex.test(whatsappNo)) {
                alert("number should contain only 10 numbers and have a maximum length of 10 digits.");
                return false;
            }

            return true; // Form is valid
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <div class="modal left fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
    <div class="modal-dialog modal-dialog-scrollable ">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-center" id="staticBackdropLabel">Add New Client</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <asp:Panel runat="server" CssClass="row g-3 m-auto rounded">
                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="txtclientname" CssClass="form-label"> Client Name<span style="color:red;">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtclientname" CssClass="form-control hover-effect"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="txtcomapnyname" CssClass="form-label"> Company Name<span style="color:red;">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtcomapnyname" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtcontact2" CssClass="form-label">Whatsapp Number<span style="color:red;">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="Txtcontact2" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtcontact1" CssClass="form-label"> Contact Number</asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="Txtcontact1" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtemail" CssClass="form-label">Email <span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="Txtemail" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtwebsite" CssClass="form-label">Website </asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="Txtwebsite" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtwebsite" CssClass="form-label">Product Name </asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtproductcode" CssClass="form-label">Product Code</asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="Txtproductcode" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="Txtissuedate" CssClass="form-label">Issue Date<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="Txtissuedate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label ID="IssueDateLabel" runat="server" AssociatedControlID="Txtexpirydate" CssClass="form-label"> Expiry Date <span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtexpirydate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>


                    <div class="col-md-2">
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="Txtzip" CssClass="form-label"> Zip Code <span class="text-danger"></span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtzip" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>


                    <div class="col-md-2">
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="Txtcity" CssClass="form-label"> City <span class="text-danger"></span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtcity" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="Txtstate" CssClass="form-label"> State <span class="text-danger"></span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtstate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label ID="Label6" runat="server" AssociatedControlID="Txtcountry" CssClass="form-label">Country<span class="text-danger"></span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtcountry" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div>
                        <h4 class="bg-light" style="text-align: center;">Login Detail </h4>
                    </div>
                    <div class="col-md-2">
                        <asp:Label ID="Label4" runat="server" AssociatedControlID="Txtusername" CssClass="form-label"> UserName<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtusername" runat="server" CssClass="form-control"></asp:TextBox>

                    </div>
                    <div class="col-md-2">
                        <asp:Label ID="Label5" runat="server" AssociatedControlID="Txtpassword" CssClass="form-label"> Password <span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="Txtpassword" runat="server" CssClass="form-control"></asp:TextBox>

                    </div>
            </div>



            </asp:Panel>


                   <div class="modal-footer justify-content-evenly">

                       <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click1" Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" Text="Submit" OnClientClick="return validateForm();" />



                       <asp:Button ID="Button2" runat="server" OnClick="button2_Click" Style="background-color: rgb(110,117,124); color: white; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" Text="Cancel" />


                   </div>
        </div>
    </div>

  

    <!-- Bootstrap JavaScript Libraries -->
    
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>

    
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
