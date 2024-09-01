<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="FeedbackReply.aspx.cs" Inherits="goGst.FeedbackReply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .carousel-item {
            height: 300px;
        }

        .carousel-inner:before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
        }
    </style>

    <%-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
     Replay
 </button>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>--%>

    <!-- Modal -->
    <%-- <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>

    <!-- Button trigger modal -->
    <%--    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Feedback Reply</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label runat="server" Text="User Name"></asp:Label>
                    </div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <br>
                <!-- Add other controls here -->
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label runat="server" Text="Rating"></asp:Label>
                    </div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="txtRating" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label runat="server" Text="Issue"></asp:Label>
                    </div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="txtIssue" TextMode="MultiLine" Rows="1" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label runat="server" Text="Description"></asp:Label>
                    </div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:TextBox runat="server" ID="txtReplay" TextMode="MultiLine" Rows="5" CssClass="form-control text-center" placeholder="Reply"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-center">
                <asp:Button runat="server" ID="btnReplay" Text="Reply" CssClass="btn btn-primary" Style="background-color: rgb(168,216,228); color: black; border: none; text-align: center; width: 130px; height: 37px;" OnClick="btnReplay_Click1"></asp:Button>
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

</asp:Content>
