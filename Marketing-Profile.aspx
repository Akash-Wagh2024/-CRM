<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing.Master" AutoEventWireup="true" CodeBehind="Marketing-Profile.aspx.cs" Inherits="goGst.Marketing_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Modal -->
    <div class="container">
    <div class="main-body">
        <div class="row gutters-sm">
            <h2 class="mt-5 ms-3 font-weight-bold">My Profile</h2>
            <div class="col-md-4 mb-3" style="margin-top: 2px;">
                <div class="card" style="height: 280px;">
                    <div class="card-body" style="margin-top: 10px;">
                        <div class="d-flex flex-column align-items-center text-center">
                             <div>
                                        <div class="d-flex justify-content-center mb-4">
                                            <asp:Image ID="selectedAvatar" runat="server" class="rounded-circle" Style="width: 170px; height: 170px; object-fit: cover;" alt="example placeholder" />
                                        </div>


                                        <div class="d-flex justify-content-center">
                                            <div class="btn " style="margin-left: 110px; margin-top: -70px;">
                                                <asp:FileUpload ID="fuUpload1" CssClass="form-control" runat="server" Style="width: 20px;" />           

                                                <%--<label class="form-label text-dark m-1 " for="customFile2"><i class="fa-solid fa-pen-to-square border-white"></i></label>--%>
                                            </div>
                                        </div>
                                    </div>
                             <div class="mt-3">
                                <h4>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </h4>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-center">
                                    <asp:Button ID="update1" runat="server" Text="Update Profile Photo" class="btn" Style="background-color: RGB(178,216,228); font-weight: 600"  OnClick="update1_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 " style="margin-top: 2px;">
                <div class="card mb-3">
                    <h4 class="mt-3 ms-4">Profile Details</h4>
                    <hr>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-4">
                                <label for="validationServer01" class="form-label">Name <span class="text-danger">*</span></label>
                              
                            </div>
                            <br>
                            <div class="col-sm-12 text-secondary">
                                <asp:TextBox ID="validationServer01" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-4">
                           <label for="validationServer02" class="form-label">Email <span class="text-danger">*</span></label>

                            </div>
                            <br>
                            <div class="col-sm-12 text-secondary">
                                <asp:TextBox ID="validationServer02" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-4">
                                <label for="validationServer03" class="form-label">What'sApp Number<span class="text-danger">*</span></label>
                            </div>
                            <br>
                            <div class="col-sm-12 text-secondary">
                                <asp:TextBox ID="validationServer03" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-4">
                                <label for="validationServer04" class="form-label">Employee ID <span class="text-danger">*</span></label>
                            </div>
                            <br>
                            <div class="col-sm-12 text-secondary">
                                <asp:TextBox ID="validationServer04" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-4">
                                <label for="validationServer05" class="form-label">Gender </label>
                            </div>
                            <br>
                            <div class="col-sm-12 text-secondary">
                                <asp:TextBox ID="validationServer05" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                        </div>
                        <br>
                    </div>
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

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

       <script type="text/javascript">
           $(function () {
               $('[id*=fuUpload1]').change(function () {
                   if (typeof (FileReader) != "undefined") {
                       var selectedAvatar = $('[id*=selectedAvatar]');
                       var file = this.files[0];
                       if (file) {
                           var reader = new FileReader();
                           reader.onload = function (e) {
                               selectedAvatar.attr("src", e.target.result);
                           }
                           reader.readAsDataURL(file);
                       }
                   } else {
                       alert("This browser does not support HTML5 FileReader.");
                   }
               });
           });
       </script>
</asp:Content>
