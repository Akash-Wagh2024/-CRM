using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Enquiy_form : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            bindProductdropdown();
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

        private void bindProductdropdown()
        {
            string query = "SELECT product_id, product_name FROM product WHERE is_deleted = 0";
            SqlCommand command = new SqlCommand(query, con);
            //Ddlproductname.Items.Clear();
            con.Open();

            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    string productId = reader["product_id"].ToString();
                    string productName = reader["product_name"].ToString();

                    Ddlproductname.Items.Add(new ListItem(productName, productId));
                }
            }
            con.Close();
        }



        protected void txtsave_Click(object sender, EventArgs e)
        {
            string productId = Ddlproductname.SelectedItem.Value;
            string productName = Ddlproductname.SelectedItem.Text;

            string fullName = txtUserName.Text;
            string email = txtEmail.Text;
            string whatsappNumber = txtWhatsapp.Text;
            string contactNo = txtContact.Text;
            string organizationName = txtOrganizationName.Text;
            string source = ddlSource.SelectedItem.Text;
            string status = "Pending";
            string city = txtCity.Text;
            string description = txtDescription.Text;
            string createdBy = Session["username"] != null ? Session["username"].ToString() : "";

            con.Open();

            using (SqlCommand cmd = new SqlCommand("InsertEnquiry", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@operation", "Insert");
                cmd.Parameters.AddWithValue("@full_name", fullName);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@whatsapp_no", whatsappNumber);
                cmd.Parameters.AddWithValue("@contact", contactNo);
                cmd.Parameters.AddWithValue("@product_id", productId);
                cmd.Parameters.AddWithValue("@product_name", productName);
                cmd.Parameters.AddWithValue("@company_name", organizationName);
                cmd.Parameters.AddWithValue("@source", source);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                //cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]); 
                //cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]); 
                cmd.Parameters.AddWithValue("@created_by", createdBy);
                cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                cmd.Parameters.AddWithValue("@user_time", DateTime.Now);
                cmd.Parameters.AddWithValue("@is_delete", 0);
                cmd.ExecuteNonQuery();
                Response.Write("Data saved successfully!");
                con.Close();
            }
        }









    }

}