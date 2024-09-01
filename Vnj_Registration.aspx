<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vnj_Registration.aspx.cs" Inherits="goGst.WebForm4" %>

<%--<!DOCTYPE html>--%>


<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YourProfile.aspx.cs" Inherits="YourNamespace.YourProfile" %>--%>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Title</title>
    <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-md-center mt-5">
                <div class="col-md-9">
                    <div class="p-3 border">
                        <h2 class="text-center" style="letter-spacing: 2px;">My Profile</h2>
                        <hr />
                        <div class="row g-3">
                            <div class="col-md-4 text-center">
                                <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="avatar img-circle img-thumbnail" style="height: 170px;" alt="avatar" />
                            </div>
                            <div class="col-md-8">
                                <label for="validationServer01" class="form-label">Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="validationServer01" runat="server" CssClass="form-control"></asp:TextBox>
                                <br />
                                <label for="validationServer02" class="form-label">Email <span class="text-danger">*</span></label>
                                <asp:TextBox ID="validationServer02" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <br />
                                <label for="validationServer03" class="form-label">What'sApp number</label>
                                <asp:TextBox ID="validationServer03" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <br />
                                <label for="validationDefault04" class="form-label">Employee ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="validationDefault04" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <br />
                                <label for="validationServer05" class="form-label">Product Name</label>
                                <asp:TextBox ID="validationServer05" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <br />
                                <label for="validationDefault06" class="form-label">Product Code</label>
                                <asp:TextBox ID="validationDefault06" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
</body>
</html>

















            
<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />


    <style>

        body{
            background-color:#f2f2f2;
        }
            .textboxes {
                padding: 8px;
                border-radius: 6PX;
            }
        .btn-submit {
            padding: 9px 40px 14px 40px;
            border: none;
            border-radius: 3px;
            background-color: #ce8f28;
            color: white;
        }

         /* For Laptop And Desktop Screen */
        @media only screen and (min-width:1024px){
            .logoimg{
                margin-top: -80px !important;
            }
            .header-row{
                margin-bottom: -40px;
            }
        }

        /*For Mobile View*/
        @media only screen and (max-width:1023px) {
            .logoimg {
                margin-top: -58px !important;
            }
        }

    </style>



</head>
<body>
    <form id="form2" runat="server">
        <div class="container mt-5">
            <div class="row">
                <div class="col-lg-7">
                     <div class="card p-4 shadow-sm">
                         <%-- Header Section --%>
            <%--        <div class="row header-row">
                            <div class="col-lg-9 col-md-9 col-sm-9">
                                <h3>Create Your Jewellary Acount</h3>
                                <p>VNJ Technology India Pvt. Ltd</p>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-3">
                                <img src="img/ico.jpg-removebg-preview-removebg-preview-removebg-preview.png"  class="img-fluid logoimg" />
                                 <img src="img/vnj%20logo.png" class="img-fluid" style="height:57px"/>
                            </div>
                        </div>
                         <%-- Form Section --%>
                      <%--   <div class="row">
                             <div class="col-lg-12">
                                 <asp:TextBox ID="txtshopname" placeholder="Shop Name" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                             <div class="col-lg-6 mt-2">
                                  <asp:TextBox ID="txtmobileno" placeholder="Mobile No" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                             <div class="col-lg-6 mt-2">
                                  <asp:TextBox ID="txtwhatsappno" placeholder="Whatsapp No" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                             <div class="col-lg-6 mt-2">
                                  <asp:TextBox ID="txtemail" placeholder="Email" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                             <div class="col-lg-6 mt-2">
                                 <asp:TextBox ID="txtaddress" placeholder="Address" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                             <div class="col-lg-6 mt-2">
                                 <asp:TextBox ID="txtusername" placeholder="Username" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                             <div class="col-lg-6 mt-2">
                                 <asp:TextBox ID="txtpassword" placeholder="Password" class="w-100 textboxes" runat="server"></asp:TextBox>
                             </div>
                         </div>
                         <div class="row mt-5">
                             <div class="col-lg-4">
                                 <a href="#">Sign In</a>
                             </div>
                             <div class="col-lg-4 text-center">
                                 <asp:Button ID="btnsave" class="btn-submit" runat="server" Text="Save" />
                             </div>
                         </div>
                    </div>
                </div>--%>

          <%--      <div class="col-lg-5">
                   <div class="card shadow-sm p-3">
                                                           <div class="row">
                    <div class="col-lg-12">
                        <asp:TextBox ID="TextBox1" placeholder="Shop Name" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-6 mt-2">
                         <asp:TextBox ID="TextBox2" placeholder="Mobile No" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-6 mt-2">
                         <asp:TextBox ID="TextBox3" placeholder="Whatsapp No" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-6 mt-2">
                         <asp:TextBox ID="TextBox4" placeholder="Email" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-6 mt-2">
                        <asp:TextBox ID="TextBox5" placeholder="Address" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-6 mt-2">
                        <asp:TextBox ID="TextBox6" placeholder="Username" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-6 mt-2">
                        <asp:TextBox ID="TextBox7" placeholder="Password" class="w-100 textboxes" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row mt-5">
                    <div class="col-lg-4">
                        <a href="#">Sign In</a>
                    </div>
                    <div class="col-lg-4 text-center">
                        <asp:Button ID="Button1" class="btn-submit" runat="server" Text="Save" />
                    </div>
                </div>
                   </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>--%>

    <%--    </div>
    </form>
</body>
</html>--%>
