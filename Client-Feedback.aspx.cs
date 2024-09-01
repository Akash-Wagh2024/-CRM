using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Feedback1 : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());



        //string client_id = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    if (Session["username"] != null)
                    {
                        string username = Session["username"].ToString();
                        long client_id = GetClientIDByUsername(username);
                        Session["client_id"] = client_id;
                        BindFeedbackGrid(client_id);

                    }

                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }



        }

        private void BindFeedbackGrid(long client_id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                try
                {


                    con.Open();
                    string query = "SELECT rating, comment, description, admin_reply FROM feedback WHERE client_id = @client_id AND is_delete=0";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@client_id", client_id);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
                }
            }
        }

        private long GetClientIDByUsername(string username)
        {
          
                long client_id = 0; // Default value if no match is found
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
                {
                    con.Open();
                    string query = "SELECT client_id FROM client WHERE client_username = @username";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            client_id = Convert.ToInt64(result);
                        }
                    }
                }
                return client_id;
            
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
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

            return localIpAddress;
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            try
            {


                long client_id = Convert.ToInt64(Session["client_id"]);

                {
                    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
                    using (SqlCommand cmd = new SqlCommand("ManageFeedback", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@operation", "INSERT");
                        cmd.Parameters.AddWithValue("@rating", Request.Form["rating_id"]);
                        cmd.Parameters.AddWithValue("@comment", text1.Text.Trim());
                        cmd.Parameters.AddWithValue("@description", TextArea1.Text.Trim());
                        cmd.Parameters.AddWithValue("@client_id", client_id);

                        //script
                        cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                        cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                        cmd.Parameters.AddWithValue("@created_by", Session["username"]);
                        cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                        
                        cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]);
                        cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]);
                        cmd.Parameters.AddWithValue("@is_delete", 0);
                        
                        cmd.Parameters.AddWithValue("@user_time",DateTime.Now);
                        cmd.Parameters.AddWithValue("@updated_by", DBNull.Value);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected < 0)
                        {
                            Response.Write("<script>alert('Feedback sent successfully.');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Failed to send feedback.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }
    }
}