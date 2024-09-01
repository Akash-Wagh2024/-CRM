<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin-Feedback.aspx.cs" Inherits="goGst.Admin_Feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <style>
        .feedback {
            width: 100%;
            max-width: 780px;
            height: 117%;
            background: #fff;
            margin: -10px auto;
            padding: 15px;
            box-shadow: 1px 1px 16px rgba(0, 0, 0, 0.3);
        }

        .bt {
            border: none;
            border-radius: 3px;
            background-color: #ce8f28;
            color: white;
        }

        }

        .survey-hr {
            margin: 10px 0;
            border: .5px solid #ddd;
        }

        .star-rating {
            margin: 25px 0 0px;
            font-size: 0;
            white-space: nowrap;
            display: inline-block;
            width: 175px;
            height: 35px;
            overflow: hidden;
            position: relative;
            background: url('data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IiB3aWR0aD0iMjBweCIgaGVpZ2h0PSIyMHB4IiB2aWV3Qm94PSIwIDAgMjAgMjAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDIwIDIwIiB4bWw6c3BhY2U9InByZXNlcnZlIj48cG9seWdvbiBmaWxsPSIjREREREREIiBwb2ludHM9IjEwLDAgMTMuMDksNi41ODMgMjAsNy42MzkgMTUsMTIuNzY0IDE2LjE4LDIwIDEwLDE2LjU4MyAzLjgyLDIwIDUsMTIuNzY0IDAsNy42MzkgNi45MSw2LjU4MyAiLz48L3N2Zz4=');
            background-size: contain;
        }

            .star-rating i {
                opacity: 0;
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 20%;
                z-index: 1;
                background: url('data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IiB3aWR0aD0iMjBweCIgaGVpZ2h0PSIyMHB4IiB2aWV3Qm94PSIwIDAgMjAgMjAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDIwIDIwIiB4bWw6c3BhY2U9InByZXNlcnZlIj48cG9seWdvbiBmaWxsPSIjRkZERjg4IiBwb2ludHM9IjEwLDAgMTMuMDksNi41ODMgMjAsNy42MzkgMTUsMTIuNzY0IDE2LjE4LDIwIDEwLDE2LjU4MyAzLjgyLDIwIDUsMTIuNzY0IDAsNy42MzkgNi45MSw2LjU4MyAiLz48L3N2Zz4=');
                background-size: contain;
            }

            .star-rating input {
                -moz-appearance: none;
                -webkit-appearance: none;
                opacity: 0;
                display: inline-block;
                width: 20%;
                height: 100%;
                margin: 0;
                padding: 0;
                z-index: 2;
                position: relative;
            }

                .star-rating input:hover + i,
                .star-rating input:checked + i {
                    opacity: 1;
                }

            .star-rating i ~ i {
                width: 40%;
            }

                .star-rating i ~ i ~ i {
                    width: 60%;
                }

                    .star-rating i ~ i ~ i ~ i {
                        width: 80%;
                    }

                        .star-rating i ~ i ~ i ~ i ~ i {
                            width: 100%;
                        }

        #offcanvasRightLabel {
            align-items: center;
            justify-content: center;
            font-size: 33px;
            margin-left: 45px;
            margin-top: 8px;
            font-weight: bold;
        }

        .input1 {
            margin-left: 75px;
        }

        .btn {
            margin-top: 50px;
            margin-left: 50px;
            border: none;
            border-radius: 3px;
            background-color: #ce8f28;
            color: white;
        }

    

    </style>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
        crossorigin="anonymous"/>
    </head>

    
    
    <body>

        <nav aria-label="breadcrumb mt-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Manage</a></li>
                <li class="breadcrumb-item active" aria-current="page">Feedback</li>
            </ol>
        </nav>

        

    <div class="container">
     <div class="row">
         <div class="col-lg-4"></div>
         <div class="col-lg-4"></div>
       
     </div>
 </div> <br />

  

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound"  CssClass="maintable table table-bordered table-striped  " OnRowCommand="GridView1_RowCommand" Width="100%" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" AllowPaging="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1">
    <Columns>
<%--        <asp:BoundField DataField="feedback_id" HeaderText="feedback_id"></asp:BoundField>--%>
                         <asp:TemplateField HeaderText="Sr. No.">
    <ItemTemplate>
        <asp:Label ID="lblSerialNumber" runat="server"></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
        <asp:BoundField DataField="client_username" HeaderText="Client Name"></asp:BoundField>
        <asp:BoundField DataField="rating" HeaderText="Rating"></asp:BoundField>
        <asp:BoundField DataField="comment" HeaderText="Comment"></asp:BoundField>
        

        <asp:BoundField DataField="description" HeaderText="Description"></asp:BoundField>
        <asp:BoundField DataField="admin_reply" HeaderText="Reply"></asp:BoundField>
        <asp:TemplateField HeaderText="">
            <ItemTemplate>
           <asp:HiddenField ID="hfticket_id" runat="server" Value='<%# Eval("feedback_id") %>' />

                <asp:LinkButton ID="btnEdit" runat="server" Text="Reply" OnClick="btnEdit_Click" CommandName="EditRow" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
     <FooterStyle BackColor="#CCCCCC"></FooterStyle>

                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

                    <PagerStyle HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black"></PagerStyle>

                    <RowStyle BackColor="White"></RowStyle>

                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                    <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                    <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

                    <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                    <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
</asp:GridView>



<%--     <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12  offset-9" style="margin-top:-50px">
                    <button class="btn btn-primary " type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">Add New Feedback</button>
                </div>
            </div>
        </div--%>




        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
            <div class="offcanvas-header">
                <h5 id="offcanvasRightLabel">Add Feedback</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>


            <div class="offcanvas-body">
                <div class="feedback">
                    <form method="post" action="#action-url">
                        <label class="fs-6">Rating</label><br>
                        <span class="star-rating">
                            <input type="radio" name="rating1" value="1"><i></i>
                            <input type="radio" name="rating1" value="2"><i></i>
                            <input type="radio" name="rating1" value="3"><i></i>
                            <input type="radio" name="rating1" value="4"><i></i>
                            <input type="radio" name="rating1" value="5"><i></i>
                        </span>
                        <br>
                        <br>


                        <!-- <div class="clear"></div>  -->
                        <textarea cols="37" name="commentText" rows="2" style="100%" placeholder="Complaints and Issue"></textarea><br>
                        <br>


                        <!-- <div class="clear"></div>  -->
                        <textarea id="TextArea1" cols="37" rows="5" placeholder="Description"></textarea>

                        
                        <br>

                      



           
                        <br>
                        <asp:Button ID="Button1" runat="server" Text="Submit your Feedback" Style="background: #43a7d5; margin-left: 50px; color: #fff; padding: 12px; border: 0" />
                        
                    </form>
                </div>
            </div>
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
    </body>


    </html>
    

   


</asp:Content>
