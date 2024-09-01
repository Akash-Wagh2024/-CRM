<%@ Page Title="" Language="C#" MasterPageFile="~/Site4.Master" AutoEventWireup="true" CodeBehind="Client-profile.aspx.cs" Inherits="goGst.User_Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        .btn {
            --bs-btn-border-width: 0px !important;
        }

        .client {
            width: 100%;
            max-width: 700px;
            height: 200%;
            background: #fff;
            margin: 10px auto;
            padding: 15px;
            /*box-shadow: 1px 1px 16px rgba(0, 0, 0, 0.3);*/
            height: 660px;
            font-weight: 600;
            border: 1px solid black;
        }

        h6 {
            font-weight: 600;
        }
        .file-upload {
            position: absolute;
            z-index: -1;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>     

        <div class="container">
            <div class="main-body">
                <div class="row gutters-sm">
                    <h2 class="mt-5 ms-2 font-weight-bold">My Profile</h2>
                    <div class="col-md-4 mb-3" style="margin-top: 2px;">
                        <div class="card border" style="height: 607px;">
                            <div class="card-body" style="margin-top: 150px;">
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
                                    <!-- <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin" class="rounded-circle" width="150"> -->
                                    <div class="mt-3">
                                        <h4>
                                            <asp:Label ID="Label1" runat="server"></asp:Label>
                                        </h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8 " style="margin-top: 2px;">
                        <div class="card mb-3">
                            <div class="card-body ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <br />
                                        <h6 class="" style="font-weight: 600">Name <span class="text-danger"></span></h6>
                                    </div>
                                    <div class="col-sm-12 text-secondary mb-4">
                                        <asp:TextBox ID="Txtname" runat="server" ReadOnly="true" type="text" class="form-control" placeholder="" aria-label="name" value=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <h7 class="" style="font-weight: 600">Company Name <span class="text-danger"></span></h7>
                                    </div>
                                    <div class="col-sm-12 text-secondary mb-4">
                                        <asp:TextBox ID="Txtcompanyenterprisesname" ReadOnly="true" runat="server" type="text" class="form-control" placeholder="" aria-label="comapny/enterprisesname" value=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <h6 class="" style="font-weight: 600">Whatsapp Number <span class="text-danger"></span></h6>
                                    </div>
                                    <div class="col-sm-12 text-secondary mb-4">
                                        <asp:TextBox ID="Txtcontact2" ReadOnly="true" runat="server" type="text" class="form-control" placeholder="" aria-label="whatsappnumber" value=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-4 ">
                                        <h6 class="" style="font-weight: 600">Contact Number <i class="fa-solid fa-pen-to-square"></i></h6>
                                    </div>
                                    <div class="col-sm-12 text-secondary mb-4">
                                        <asp:TextBox ID="Txtcontact1" runat="server" type="text" class="form-control" placeholder="" aria-label="number" value=""></asp:TextBox>

                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <h6 class="" style="font-weight: 600">Email <span class="text-danger"></span></h6>
                                    </div>
                                    <div class="col-sm-12 text-secondary mb-4">
                                        <asp:TextBox ID="Txtemail" ReadOnly="true" runat="server" type="text" class="form-control" placeholder="" aria-label="email" value=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <h6 class="" style="font-weight: 600">Website</h6>
                                    </div>
                                    <div class="col-sm-12 text-secondary mb-4">
                                        <asp:TextBox ID="Txtwebsite" runat="server" type="text" ReadOnly="true" class="form-control" placeholder="" aria-label="website" value=""></asp:TextBox>

                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12 text-center">
                                        <asp:Button ID="update1" runat="server" Text="Update" class="btn" Style="background-color: RGB(178,216,228); font-weight: 600" OnClick="update1_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    


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




    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"> </script>
    






</asp:Content>
