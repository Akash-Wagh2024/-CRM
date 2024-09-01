<%@ Page Title="" Language="C#" MasterPageFile="~/Site4.Master" AutoEventWireup="true" CodeBehind="Client-MyProduct.aspx.cs" Inherits="goGst.Client_MyProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .carousel-item {
            height: 300px;
        }
       
        .carousel-image {
            height: 80%;
            width: 100%;
            object-fit: cover;
        }

        .carousel-inner:before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
        }

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

        .blog .carousel-indicators {
            left: 0;
            top: auto;
            bottom: -40px;
        }

            /* The colour of the indicators */
            .blog .carousel-indicators li {
                background: #a3a3a3;
                border-radius: 50%;
                width: 8px;
                height: 8px;
            }

            .blog .carousel-indicators .active {
                background: #707070;
            }



        .modal.right.fade .modal-dialog {
            left: -320px;
            -webkit-transition: opacity 0.3s linear, left 0.3s ease-out;
            -moz-transition: opacity 0.3s linear, left 0.3s ease-out;
            -o-transition: opacity 0.3s linear, left 0.3s ease-out;
            transition: opacity 0.3s linear, left 0.3s ease-out;
        }

        /*fixed-button {
            position: fixed;
            top: 20%;
            right: 25px;
        }*/
        cardcanvas {
            position: fixed;
        }
    </style>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
        crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <nav aria-label="breadcrumb mt-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Product</a></li>
            <li class="breadcrumb-item active" aria-current="page">My Product</li>
        </ol>
    </nav>


    <div class=" container-fluid">
        <div class="row bg-white">
            <asp:Repeater ID="CarouselRepeater" runat="server" OnItemDataBound="CarouselRepeater_ItemDataBound">
                <ItemTemplate>
                    <div class="col-md-4">
                        <div class="card mt-3">
                            <asp:Panel ID="Panel1" runat="server">
                                <div id='<%# "carouselExampleIndicators" + Container.ItemIndex %>' class="carousel slide" data-bs-ride="carousel">
                                    <div class="carousel-indicators">
                                        <asp:Button runat="server" CssClass="active" data-bs-target='<%# "#" + "carouselExampleIndicators" + Container.ItemIndex %>' data-bs-slide-to="0" aria-current="true" aria-label="Slide 1"></asp:Button>
                                        <asp:Button ID="Button3" runat="server" Text="Button" data-bs-target='<%# "#" + "carouselExampleIndicators" + Container.ItemIndex %>' data-bs-slide-to="1" aria-label="Slide 2"></asp:Button>
                                        <asp:Button ID="Button4" runat="server" Text="Button" data-bs-target='<%# "#" + "carouselExampleIndicators" + Container.ItemIndex %>' data-bs-slide-to="2" aria-label="Slide 3"></asp:Button>
                                        <asp:Button ID="Button5" runat="server" Text="Button" data-bs-target='<%# "#" + "carouselExampleIndicators" + Container.ItemIndex %>' data-bs-slide-to="3" aria-label="Slide 4"></asp:Button>
                                        <!-- Add more buttons for additional images if needed -->
                                    </div>
                                    <div class="carousel-inner">
                                        <div class="carousel-item active lazyload" id='<%# "first" + Container.ItemIndex %>' data-bs-interval="1500">
                                            <asp:Image ID="image1" runat="server" CssClass="d-block carousel-image" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("image1")) %>' />
                                        </div>

                                        <div class="carousel-item  active lazyload" id='<%# "second" + Container.ItemIndex %>' data-bs-interval="1500">
                                            <asp:Image ID="image2" runat="server" CssClass="d-block carousel-image" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("image2")) %>' />
                                        </div>
                                        <div class="carousel-item active lazyload" id='<%# "third" + Container.ItemIndex %>' data-bs-interval="1500">
                                            <asp:Image ID="image3" runat="server" CssClass="d-block  carousel-image" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("image3")) %>' />
                                        </div>
                                        <div class="carousel-item  active lazyload" id='<%# "fourth" + Container.ItemIndex %>' data-bs-interval="1500">
                                            <asp:Image ID="image4" runat="server" CssClass="d-block  carousel-image" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("image4")) %>' />
                                        </div>
                                        <!-- Add more carousel items for additional images if needed -->
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target='<%# "#" + "carouselExampleIndicators" + Container.ItemIndex %>' data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target='<%# "#" + "carouselExampleIndicators" + Container.ItemIndex %>' data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>

                                <div class="card-body">
                                    
                                    <h3 class="product-title fw-bold " style="margin-top: -41px";><%# Eval("product_name") %></h3>
                                    <h6 class="fw-bold ">Description</h6>
                                    <p class="card-text"><%# Eval("description") %></p>
                                     <div class="modal-footer justify-content-between">
                                      <h6 class=" bi-calendar2-date"> Issue Date</h6>
                                       <p class="card-text"><%# Eval("issue_date", "{0:d}") %></p>
                                     <h6 class=" bi-calendar2-date"> Expiry Date</h6>
                                       <p class="card-text"><%# Eval("expiry_date", "{0:d}") %></p>
                                         </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
     
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

     <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

     <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vanilla-lazyload/12.1.0/lazyload.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var lazyLoadInstance = new LazyLoad({
                elements_selector: ".lazyload"
            });
        });
    </script>

</asp:Content>
