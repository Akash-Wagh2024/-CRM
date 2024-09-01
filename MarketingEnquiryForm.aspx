<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing.Master" AutoEventWireup="true" CodeBehind="MarketingEnquiryForm.aspx.cs" Inherits="goGst.MarketingEnquiryForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
              <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Enquiry Form</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server">Full Name<span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div><br />

                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server">E-mail<span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div><br />

                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server">WhatsApp Number<span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox runat="server" ID="txtWhatsapp" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div><br />

                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server">Contact No</asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox runat="server" ID="txtContact" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div><br />

                    <!-- Add more rows for the first column if needed -->
                </div>

                <div class="col-md-6">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server">Product Name<span class="text-danger">*</span></asp:Label>
                        </div>
                        <div class="col-sm-6">
                             <asp:DropDownList ID="Ddlproductname" Style="width: 314px; height: 39px; border-radius: 6px;" runat="server" DataSourceID="SqlDataSource1" DataTextField="product_name" DataValueField="product_name" AutoPostBack="true"></asp:DropDownList>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:crm_con %>' SelectCommand="SELECT [product_name] FROM [product]"></asp:SqlDataSource>

                               </div>
                    </div><br />

                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server" Text="Organization Name"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox runat="server" ID="txtOrganizationName" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div><br />

                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server" Text="Source"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:DropDownList runat="server" ID="ddlSource" CssClass="form-control">
                                <asp:ListItem Text="Select Source" Value=""></asp:ListItem>
                                <asp:ListItem Text="Instagram" Value="Instagram"></asp:ListItem>
                                <asp:ListItem Text="LinkedIn" Value="LinkedIn"></asp:ListItem>
                                <asp:ListItem Text="FaceBook" Value="FaceBook"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div><br />

                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server" Text="City"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <asp:TextBox runat="server" ID="txtCity" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div><br />
                    </div>
                              <div class="row">
                <div class="col-sm-4">
                    <asp:Label runat="server" Text="Description"></asp:Label>
                </div>
                <div class="col-sm-8">
                    <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

             <br>

                
            </div>
        </div>

        <div class="modal-footer justify-content-between">
            <asp:Button runat="server" ID="txtsave" OnClick="txtsave_Click1" Text="Save" CssClass="btn " Style="background-color: rgb(168,216,228); color: black; border: none; text-align: center; width: 130px; height: 37px;"></asp:Button>
            <asp:Button runat="server" ID="txtcancel" PostBackUrl="~/marketing-enquiry.aspx" Text="Cancel" CssClass="btn " Style="background-color: rgb(168,216,228); color: black; border: none; text-align: center; width: 130px; height: 37px;"></asp:Button>
        </div>
    </div>
</div>
  

  
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="bootstrap-5.0.2-dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

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
