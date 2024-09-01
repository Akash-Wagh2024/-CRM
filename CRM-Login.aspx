<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM-Login.aspx.cs" Inherits="goGst.CRM_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
        crossorigin="anonymous" />
    <style>
        body {
            background-color: rgb(226, 241, 244);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-md-9 col-lg-6 col-xl-5">
                        <img src="img/vnj%20logo.png"
                            class="img-fluid" style="height: 250px; width: 250px; margin-top: 125px; margin-left: 100px;" alt="Sample image"><br>
                        <h2 style="font-family: 'Times New Roman', Times, serif; font-size: 50px; font-weight: bold; padding-top: 10px;">VNJ TECHNOLOGY</h2>
                        <h2 style="font-family: 'Times New Roman', Times, serif; font-size: 35px; font-weight: bold; margin-left: 138px;">India Pvt Ltd.</h2>
                    </div>
                    <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                        <form>
                            <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start" style="margin-left: 117px; margin-top: 120px">
                                <p class="lead fw-normal mb-0 me-3 fs-1" style="font-family: 'Times New Roman'">SIGN IN</p>

                            </div>
                            <br>

                            <!-- Email input -->
                            <div class="form-outline mb-4">
                                <asp:TextBox ID="txtUsername" class="form-control form-control-lg"
                                    placeholder="Enter a valid Username" runat="server"></asp:TextBox>

                            </div>

                            <!-- Password input -->

                            <div class="form-outline mb-3">
                                <asp:TextBox ID="txtPassword" class="form-control form-control-lg"
                                    placeholder="Enter password" runat="server" TextMode="Password"></asp:TextBox>

                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <!-- Checkbox -->
                                <div class="form-check mb-0">
                                    <asp:CheckBox ID="CBRememberme" class="form-check-input me-2" runat="server" />
                                    <%--<input class="form-check-input me-2" type="checkbox" id="chkRememberMe" />--%>
                                    <label class="form-check-label" for="CBRememberme">
                                        Remember me
                                    </label>
                                </div>

                                <a href="forgetpass.aspx" class="text-body">Forgot password?</a>
                            </div>

                            <div class="text-center text-lg-start mt-4 pt-2">
                                <asp:Button ID="Button1" class="btn btn-lg"
                                    Style="padding-left: 2.5rem; padding-right: 2.5rem; width: 398px; background-color: rgb(168,216,228); color: black;" runat="server" Text="Login" OnClick="Button1_Click1" />
                                <%--    <button type="button"Login</button>--%>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

            <!-- Right -->
        </div>
        <!-- Bootstrap JavaScript Libraries -->
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>

        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"></script>

        
    </form>
</body>
</html>
