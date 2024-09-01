using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
namespace goGst
{
    public partial class MarketingEnquiryForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string GetLocalIpAddress()
        {
            string localIpAddress = "";

            System.Net.NetworkInformation.NetworkInterface[] networkInterfaces = System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces();

            foreach (System.Net.NetworkInformation.NetworkInterface networkInterface in networkInterfaces)
            {
                if (networkInterface.OperationalStatus == System.Net.NetworkInformation.OperationalStatus.Up &&
                    networkInterface.NetworkInterfaceType != System.Net.NetworkInformation.NetworkInterfaceType.Loopback)
                {
                    System.Net.NetworkInformation.IPInterfaceProperties ipProperties = networkInterface.GetIPProperties();
                    foreach (System.Net.NetworkInformation.UnicastIPAddressInformation ip in ipProperties.UnicastAddresses)
                    {
                        if (ip.Address.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                        {
                            localIpAddress = ip.Address.ToString();
                            break;
                        }
                    }
                    if (!string.IsNullOrEmpty(localIpAddress))
                    {
                        break;
                    }
                }
            }

            return localIpAddress; // Return the localIpAddress
        }



        private void SaveFormData(string fullName, string email, string whatsappNumber, string contactNo, string productName, string organizationName, string source, string city, string description, string latitude, string longitude, string createdBy)
        {
            try
            {
                // Define your connection string
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());

                // using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Define the name of your stored procedure
                    string storedProcedureName = "InsertEnquiry";
                    string status = "Pending";

                    using (SqlCommand cmd = new SqlCommand(storedProcedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add parameters to your stored procedure
                        cmd.Parameters.AddWithValue("@full_name", fullName);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@whatsapp_no", whatsappNumber);
                        cmd.Parameters.AddWithValue("@contact", contactNo);
                        cmd.Parameters.AddWithValue("@product_name", productName);
                        cmd.Parameters.AddWithValue("@company_name", organizationName);
                        cmd.Parameters.AddWithValue("@source", source);
                        cmd.Parameters.AddWithValue("@city", city);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@status", status);

                        // Additional parameters
                        cmd.Parameters.AddWithValue("@operation", "Insert");
                        cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                        cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                        cmd.Parameters.AddWithValue("@latitude", latitude);
                        cmd.Parameters.AddWithValue("@longitude", longitude);
                        cmd.Parameters.AddWithValue("@created_by", createdBy);
                        cmd.Parameters.AddWithValue("@user_time", DateTime.Now);
                        cmd.Parameters.AddWithValue("@is_delete", 0);
                        // Change the string literals to integer values


                        // Open the connection
                        conn.Open();

                        // Execute the command
                        int i = cmd.ExecuteNonQuery();

                        if (i != 0)
                        {
                            Response.Write("<script>alert('Enquiry Added successfully');</script>");

                            
                        }
                        else
                        {
                            Response.Write("<script>alert('Enquiry operation failed');</script>");
                        }

                        conn.Close();

                    }
                }

                // Display success message or perform any other action after successful insertion
                Response.Write("Data saved successfully!");
            }
            catch (Exception ex)
            {
                // Handle the exception appropriately (log it, display error message, etc.)
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        protected void txtsave_Click1(object sender, EventArgs e)
        {
            // Retrieve values from the form
            string fullName = txtUserName.Text;
            string email = txtEmail.Text;
            string whatsappNumber = txtWhatsapp.Text;
            string contactNo = txtContact.Text;
            string productName =Ddlproductname.SelectedValue; // Assuming you want to save the selected product name
            string organizationName = txtOrganizationName.Text;
            string source = ddlSource.SelectedItem.Text; // Assuming you want to save the selected source
            string city = txtCity.Text;
            string description = txtDescription.Text;


            // Ensure latitude and longitude are not null
            string latitude = Request.Form["latitude"] ?? "";
            string longitude = Request.Form["longitude"] ?? "";

            // Check if Session["username"] is not null
            string createdBy = Session["username"] != null ? Session["username"].ToString() : "";

            // Call the method to save the data to the database
            SaveFormData(fullName, email, whatsappNumber, contactNo, productName, organizationName, source, city, description, latitude, longitude, createdBy);

        }
    }
}