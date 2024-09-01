<%@ Page Title="" Language="C#" MasterPageFile="~/Site4.Master" AutoEventWireup="true" CodeBehind="Client-Ticket.aspx.cs" Inherits="goGst.Ticket" %>

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
            right: 100px;
        }
        .fixed-button1 {
            position: fixed;
            top: 20%;
            right: 50px;
        }
    </style>
    <script type="text/javascript">
        // JavaScript function to validate the form before submission
        function validateForm() {
            var clientusername = document.getElementById('<%= txtusername.ClientID %>');
            var productName = document.getElementById('<%= txtproductname.ClientID %>');
            var issues = document.getElementById('<%= Txtissues.ClientID %>');
            //var fileUpload = document.getElementById('fuUpload1');

            // Check if product name is selected
            if (clientusername.value == "") {
                alert("Please select a client username.");
                return false;
            }
            if (productName.value == "") {
                alert("Please select a product name.");
                return false;
            }

            // Check if issues are provided
            if (issues.value.trim() == "") {
                alert("Please provide the issues.");
                return false;
            }

            // Check if a file is selected
            //if (fileUpload.value.trim() == "") {
            //    alert("Please select an image.");
            //    return false;
            //}

            return true; // Form is valid
        }
    </script>


    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
        crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <%-- .ticket {
            width: 100%;
            max-width: 780px;
            height: 117%;
            background: #fff;
            margin: 70px auto;
            padding: 15px;
            /*box-shadow: 1px 1px 16px rgba(0, 0, 0, 0.3);*/
            height: 500px;
            font-weight: 600;
            border: 1px solid black;
        }

        #topbar {
            background: #106eea;
            height: 40px;
            font-size: 14px;
            transition: all 0.5s;
            color: #fff;
            padding: 0;
        }

            #topbar .contact-info i {
                font-style: normal;
                color: #fff;
            }

                #topbar .contact-info i a,
                #topbar .contact-info i span {
                    padding-left: 5px;
                    color: #fff;
                }

                #topbar .contact-info i a {
                    line-height: 0;
                    transition: 0.3s;
                    transition: 0.3s;
                }

                    #topbar .contact-info i a:hover {
                        color: #fff;
                        text-decoration: underline;
                    }

            #topbar .social-links a {
                color: rgba(255, 255, 255, 0.7);
                line-height: 0;
                transition: 0.3s;
                margin-left: 20px;
            }

                #topbar .social-links a:hover {
                    color: white;
                }

        #topbar {
            background: black;
            height: 40px;
            font-size: 14px;
            transition: all 0.5s;
            color: #fff;
            padding: 0;
            margin: -30px -27px 0px -30px;
        }

        }--%>
    <%--</style>--%>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <hr />
    
            <asp:GridView ID="GridView1" OnRowDeleting="GridView1_RowDeleting" CssClass="maintable table table-bordered table-striped" runat="server" Width="100%" AutoGenerateColumns="False" DataKeyNames="ticket_id" DataSourceID="SqlDataSource1" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" OnRowDataBound="GridView1_RowDataBound" AllowPaging="True">

                <Columns>
                    <asp:TemplateField HeaderText="Sr. No.">
                        <ItemTemplate>
                            <asp:Label ID="lblSerialNumber" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ticket_id" HeaderText="ticket_id" SortExpression="ticket_id" InsertVisible="False" ReadOnly="True" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="product_id" HeaderText="product_id" SortExpression="product_id" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="client_id" HeaderText="client_id" SortExpression="client_id" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="product_name" HeaderText="Product Name" SortExpression="product_name"></asp:BoundField>
                    <asp:BoundField DataField="issue" HeaderText="Issue" SortExpression="issue"></asp:BoundField>
                    <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description"></asp:BoundField>
                    <asp:BoundField DataField="created_date" HeaderText="created_date" SortExpression="created_date" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="clientname" HeaderText="clientname" SortExpression="clientname" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="contact1" HeaderText="contact1" SortExpression="contact1" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status"></asp:BoundField>
                    <asp:BoundField DataField="support_desc" HeaderText="Support Desc" SortExpression="support_desc" NullDisplayText="NULL"></asp:BoundField>
                    <asp:BoundField DataField="user_time" HeaderText="Date" SortExpression="user_time"></asp:BoundField>
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkDelete" class="table-link text-danger" CommandName="delete" Text="Delete" ToolTip="Employee Deleting" runat="server" OnClientClick="return confirm('Do you want to delete this row?');">
                                    <span class="fa-stack">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class="fa fa-trash fa-stack-1x fa-inverse"></i>
                                    </span>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
       
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:crm_con %>' SelectCommand="GetTicketGridViewData" SelectCommandType="StoredProcedure" DeleteCommand="UPDATE ticket SET is_delete = 1 WHERE ticket_id = @ticket_id AND client_id = @client_id">
            <SelectParameters>
                <asp:SessionParameter SessionField="ClientID" DefaultValue="" Name="client_id" Type="Int64"></asp:SessionParameter>


            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="ticket_id" Type="Int32" />
                <asp:SessionParameter SessionField="ClientID" Name="client_id" Type="Int64"></asp:SessionParameter>
            </DeleteParameters>
        </asp:SqlDataSource>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-4"></div>
            <div class="col-lg-4 text-center">
                <!-- Button trigger modal -->
                <button type="button" class="btn fixed-button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" style="background-color: rgb(178,216,228); color: black; border: none; font-weight: 530">
              <i class="fa-solid fa-circle-plus"></i>   Raise Ticket
  
                 <asp:Literal runat="server" ID="Literal1" Text="<button class='btn  fixed-button1' style='background-color:RGB(178,216,228); color:black;'><i class='fa-solid fa-hand'></i></button>" />
                </button>
            </div>
        </div>
    </div>


    <div class="modal left fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" style="height:500px;">
        <div class="modal-dialog modal-dialog-scrollable h-100">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center" id="staticBackdropLabel">Ticket Form</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel runat="server" CssClass="row g-3 m-auto rounded">
                         <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtusername" CssClass="form-label">Client Username <span class="text-danger"></span></asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="txtusername" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:Label runat="server" AssociatedControlID="txtproductname" CssClass="form-label">Product Name <span class="text-danger"></span></asp:Label>
                        </div>
                        <div class="col-md-8">
                <asp:DropDownList ID="txtproductname" runat="server" Style="width: 360px; height: 38px; border-radius: 6px;" AutoPostBack="true" OnSelectedIndexChanged="txtproductname_SelectedIndexChanged"></asp:DropDownList>
                        </div>     

                        <div class="col-md-4">
                            <label for="validationServer03" class="form-label">Issues<span class="text-danger"></span></label>
                        </div>

                        <div class="col-md-8">

                          <asp:TextBox runat="server" ID="Txtissues" CssClass="form-control"></asp:TextBox>
                        </div>


                       <%-- <div class="col-md-4">
                            <asp:Label runat="server" CssClass="form-label">Image</asp:Label>
                        </div>

                        <div class="col-md-8">


                            <input name="fuUpload1" id="fuUpload1" type="file"  class="form-control" style="width: 345px;" />

                            <div id="dvPreview"></div>
                        </div>--%>


                        <div class="col-md-4">
                            <label for="validationServer03" class="form-label">Description</label>
                        </div>

                        <div class="col-md-8">
                              <asp:TextBox runat="server" TextMode="MultiLine" Rows="4" ID="Txtdescription" CssClass="form-control"></asp:TextBox>              
                        </div>





                    </asp:Panel>


                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                   
                        <asp:Button ID="Button1" runat="server" OnClick="ticketraise_Click" Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 66px; height: 33px;" Text="Submit" OnClientClick="return validateForm();" />
                   


                    <asp:Button ID="Button2" runat="server" Style="background-color: rgb(110,117,124); color: white; border-radius: 6px; border: none; text-align: center; width: 66px; height: 33px;" Text="Cancel" />


                </div>
            </div>
        </div>
    </div>


    <%--       <section id="topbar" class="d-flex align-items-center">
  <div class="container-fuild d-flex justify-content-center justify-content-md-between">
    <div class="contact-info d-flex align-items-center ps-2">
      <i class="bi bi-envelope d-flex align-items-center"><a href="support@vnjindia.com">support@vnjindia.com</a></i>
      <i class="bi bi-phone d-flex align-items-center ms-4"><span>+8208021197</span></i>
    </div>
    <div class="social-links d-none d-md-flex align-items-center " style="margin-left:505px;">
      <a href="#" class="twitter"><i class="fa-brands fa-x-twitter"></i></a>
      <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
      <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
      <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
    </div>
  </div>
</section>
    <nav aria-label="breadcrumb mt-5" style="margin-top:30px;">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="#">Home</a></li>
        <li class="breadcrumb-item"><a href="#">Manage</a></li>
        <li class="breadcrumb-item active" aria-current="page">Add Support</li>
    </ol>
</nav>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
       <div class="container " >
    <div class="row ">
        <div class="col-lg-4"></div>    
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
              <div class="col-lg-4">
    <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight" style="margin-top: -4px; border: none; border-radius: 3px; background-color: rgb(178, 216, 228); color: rgb(58, 65, 70); font-weight: 530; width: 160px; margin-left: 75px;">Raise Ticket</button>
    <asp:Literal runat="server" ID="Literal1" Text="<button class='btn ' style='background-color:RGB(178,216,228); color:black;margin-top: -65px; margin-left: 240px;'><i class='fa-solid fa-hand'></i></button>" />
</div>
    </div>
</div>

<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" style="width:1800px;">
  <div class="offcanvas-header">
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" style="margin-left:1300px;"></button>
  </div>
  <div class="offcanvas-body">
        
            <div class="container">
     <div class="ticket">
      <div class="col-lg-12">
<h4 style="font-weight:bold; text-align:center;"> Ticket Form</h4>
    </div>

    <div class="row">
  <div class="col-lg-6">
  <div class="form-group ">
    <asp:Label ID="Label1" runat="server" Text="Label">
        Product Name<span style="color:red;">*</span>
    </asp:Label>
      <asp:DropDownList ID="txtproductname" runat="server" style="width:360px; height:38px; border-radius: 6px;"></asp:DropDownList>
   </div>
</div>

  <div class="col-lg-6 mb-4">
  <div class="form-group">
    <asp:Label ID="Label2" runat="server" Text="Label">
        Product Code<span style="color:red;">*</span>
    </asp:Label>
   <asp:TextBox ID="txtproductcode" runat="server" Class="form-control" ></asp:TextBox>
  </div>
</div>

          <div class="col-lg-6 mb-4">
  <div class="form-group">
    <asp:Label ID="Label3" runat="server" Text="Label">
        Issues
    </asp:Label>
   <asp:TextBox ID="Txtissues" runat="server" Class="form-control" ></asp:TextBox>
  </div>
</div>

                             <div class="col-lg-6 mb-4">
  <div class="form-group">
    <asp:Label ID="Label4" runat="server" Text="Label">
        Choose Image 
    </asp:Label> 
       <asp:FileUpload ID="txtchooseimage" runat="server" Class="form-control" Style="width:363px;" />
  </div>
</div>

                    <div class="col-lg-12 mb-5">
  <div class="form-group">
    <asp:Label ID="Label6" runat="server" Text="Label">
        Description
    </asp:Label>
   <textarea id="Txtdescription" cols="37" rows="5" placeholder="" style="width:750px; border-radius: 6px;"></textarea>
  </div>
</div>

  <div class="col-lg-9"> 
     <asp:Button id="txtbutton1" runat="server" Text="Submit" Class="btn offset-6" Style="background-color:RGB(178,216,228); color:black;"/>
     <asp:Button id="txtbutton2" runat="server" Text="Cancel" Class="btn offset-1" Style="background-color:RGB(178,216,228); color:black;" />
</div>

     </div>
     </div>
        </div>
                
          </div>
              </div>
    
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"> </script>


</body>
    </html>--%>
    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('[id*=fuUpload1]').change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $("[id*=dvPreview]");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.mp4|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "max-height:250px;width: 150px");
                                img.attr("src", e.target.result);
                                var div = $("<div style='float:left;' />");
                                $(div).html("<span style='float:right;' class='closeDiv'>X<span>");
                                div.append(img);

                                dvPreview.append(div);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });

            $('body').on('click', '.closeDiv', function () {
                $(this).closest('div').remove();
            });
        });
            </script>


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
