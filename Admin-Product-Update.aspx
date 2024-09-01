<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin-Product-Update.aspx.cs" Inherits="goGst.Admin_Product_Update" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-center" id="staticBackdropLabel">Update Product</h5>

            </div>
            <div class="modal-body">
                <asp:Panel runat="server" CssClass="row g-3 m-auto rounded">
                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="txtName" CssClass="form-label">Product Name <span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="txtCode" CssClass="form-label">Product Code <span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtCode" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server" CssClass="form-label">Image <span class="text-danger">*</span></asp:Label>
                    </div>

                    <div class="col-md-5">
                        <asp:FileUpload runat="server" ID="fuUpload1" CssClass="form-control mb-2 ms-4" AllowMultiple="false" Width="108px" />
                        <div class="d-flex justify-content-center mb-4">
                            <asp:Image ID="selectedAvatar1" runat="server" Style="width: 170px; height: 170px; object-fit: cover;" alt="" />
                        </div>
                    </div>

                    <div class="col-md-5">
                        <asp:FileUpload runat="server" ID="fuUpload2" CssClass="form-control mb-2 ms-4" AllowMultiple="false" Width="108px" />
                        <div class="d-flex justify-content-center mb-4">
                            <asp:Image ID="selectedAvatar2" runat="server" Style="width: 170px; height: 170px; object-fit: cover;" alt="" />
                        </div>
                    </div>
                    <div class="col-md-2">
                    </div>

                    <div class="col-md-5">
                        <asp:FileUpload runat="server" ID="fuUpload3" CssClass="form-control mb-2 ms-4" AllowMultiple="false" Width="108px" />
                        <div class="d-flex justify-content-center mb-4">
                            <asp:Image ID="selectedAvatar3" runat="server" Style="width: 170px; height: 170px; object-fit: cover;" alt="" />
                        </div>
                    </div>

                   <div class="col-md-5">
                        <asp:FileUpload runat="server" ID="fuUpload4" CssClass="form-control mb-2 ms-4" AllowMultiple="false" Width="108px" />
                        <div class="d-flex justify-content-center mb-4">
                            <asp:Image ID="selectedAvatar4" runat="server" Style="width: 170px; height: 170px; object-fit: cover;" alt="" />
                        </div>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" AssociatedControlID="txtDescription" CssClass="form-label">Description<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>


                </asp:Panel>
            </div>


            <div class="modal-footer justify-content-evenly">

                <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" runat="server" Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" Text="Update" />
                <asp:Button ID="Button2" PostBackUrl="~/Manage-Product.aspx" runat="server" Style="background-color: rgb(110,117,124); color: white; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" Text="Cancel" />

            </div>
        </div>
    </div>


    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $('[id*=fuUpload1]').change(function () {
                if (typeof (FileReader) != "undefined") {
                    var selectedAvatar = $('[id*=selectedAvatar1]');
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
    <script type="text/javascript">
        $(function () {
            $('[id*=fuUpload2]').change(function () {
                if (typeof (FileReader) != "undefined") {
                    var selectedAvatar = $('[id*=selectedAvatar2]');
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

    <script type="text/javascript">
        $(function () {
            $('[id*=fuUpload3]').change(function () {
                if (typeof (FileReader) != "undefined") {
                    var selectedAvatar = $('[id*=selectedAvatar3]');
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

    <script type="text/javascript">
        $(function () {
            $('[id*=fuUpload4]').change(function () {
                if (typeof (FileReader) != "undefined") {
                    var selectedAvatar = $('[id*=selectedAvatar4]');
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
