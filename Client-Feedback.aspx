<%@ Page Title="" Language="C#" MasterPageFile="~/Site4.Master" AutoEventWireup="true" CodeBehind="Client-Feedback.aspx.cs" Inherits="goGst.Feedback1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        /* Add your custom CSS styles here */
        .feedback-modal-body {
            width: 100%;
            max-width: 780px;
            background: #fff;
            padding: 15px;
         /*   box-shadow: 1px 1px 16px rgba(0, 0, 0, 0.3);*/
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
          
            .fixed-button {
    position: fixed;
    top: 20%; 
    right: 25px; 
}
    </style>
    </head>

    <body>
         
        <br />
        <br />
        <hr />
        
     <asp:GridView ID="GridView1" runat="server" CssClass="maintable table table-bordered table-striped"  OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="100%" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
        
  <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
 </asp:GridView>

        <!-- Feedback Button -->




        <div class="container-fuild mt-3">
            <div class="row">
                <div class="col-4"></div>
                <div class="col-4"></div>
                <div class="col-lg-4 d-flex">
                    <button class="btn fixed-button " type="button" data-bs-toggle="modal" data-bs-target="#feedbackModal"style="background-color: rgb(178,216,228); color: black; border: none; font-weight: 530;"><i class="fa-solid fa-circle-plus"></i> Feedback</button>
                </div>
            </div>
        </div>

        <!-- Feedback Modal -->
        <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="feedbackModalLabel">Add Feedback</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body feedback-modal-body text-center">
                        <form method="post" action="#action-url">
                            <label class="fs-6 ">Rating</label><br>
                            <div class="star-">
                                <span class="star-rating">
                                    <input type="hidden" id="rating_id" name="rating_id">
                                    <input type="radio" name="rating1" value="1"><i></i>
                                    <input type="radio" name="rating1" value="2"><i></i>
                                    <input type="radio" name="rating1" value="3"><i></i>
                                    <input type="radio" name="rating1" value="4"><i></i>
                                    <input type="radio" name="rating1" value="5"><i></i>
                                </span>
                            </div>
                            <br>
                            <br>

                          <asp:TextBox ID="text1" runat="server" Columns="37" Rows="2" TextMode="MultiLine" placeholder="Complaints and Issue" Style="text-align: center;"></asp:TextBox>
                            <br>
                          <asp:TextBox ID="TextArea1" runat="server" Columns="37" Rows="5" TextMode="MultiLine" placeholder="Description" Style="text-align: center;"></asp:TextBox>
                            <br>
                            <br>
                            <asp:Button ID="Button1" OnClick="Button1_Click1" runat="server" Text="Submit your Feedback"
                                Style="background-color: rgb(168,216,228); color: black; border-radius: 6px; border: none; text-align: center; width: 201px; height: 33px;" />

                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>

    </html>










    <script>
 document.addEventListener("DOMContentLoaded", function() {
     const ratingInputs = document.querySelectorAll('input[name="rating1"]');
     const ratingIdInput = document.getElementById('rating_id');

     ratingInputs.forEach(function(input) {
         input.addEventListener('change', function() {
             if (this.checked) {
                 ratingIdInput.value = this.value;
             }
         });
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
