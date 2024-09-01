<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing.Master" AutoEventWireup="true" CodeBehind="enquiry-profile.aspx.cs" Inherits="goGst.enquiry_profile" %>

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


   
    <div class="modal-dialog modal-dialog-scrollable ">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title " id="staticBackdropLabel">Enquiry</h4>
            </div>

            <div class="modal-body">
                <asp:Panel runat="server" CssClass="row g-3 m-auto rounded">
                    <div class="col-md-2">
                        <asp:Label runat="server">Full Name<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server">E-mail<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server">What'sApp Number<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtWhatsapp" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server">Contact No</asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtContact" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server">Product Name<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="TxtProductName" class="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Label runat="server">Organization Name<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtOrganizationName" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server">Source<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="TextBox1" class="form-control" runat="server"></asp:TextBox>

                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server">status<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:DropDownList runat="server" ID="DropDownList1" CssClass="form-control" AutoPostBack="true">
                            <asp:ListItem Text="Select status" Value=""></asp:ListItem>
                            <asp:ListItem Text="In-Progress" Value="In-Progress"></asp:ListItem>
                            <asp:ListItem Text="Convert to Customer" Value="Convert to Customer"></asp:ListItem>
                            <asp:ListItem Text="Not Interested" Value="Not Interested"></asp:ListItem>

                            
                        </asp:DropDownList>

                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server">City<span class="text-danger">*</span></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtCity" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <asp:Label runat="server" Text="Description"></asp:Label>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                    </div>
                </asp:Panel>
            </div>





            <div class="modal-footer justify-content-evenly">

                <asp:Button ID="btnsubmit" OnClick="txtsave_Click" runat="server" Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" Text="Save" />



                <asp:Button ID="Button2" PostBackUrl="~/marketing-enquiry.aspx" runat="server" Style="background-color: rgb(110,117,124); color: white; border-radius: 6px; border: none; text-align: center; width: 119px; height: 35px;" Text="Cancel" />


            </div>
        </div>
    </div>

  



    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="bootstrap-5.0.2-dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

</asp:Content>
