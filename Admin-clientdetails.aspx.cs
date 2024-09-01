using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using static System.Net.Mime.MediaTypeNames;
using System.Collections;

namespace goGst
{
    public partial class Admin_clientdetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());    
        long admin_id = 0;
        long client_id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                binddata();
                bindProductdropdown();
                if (Session["username"] != null)
                {
                    string username = Session["username"].ToString();
                    long admin_id = GetAdminIdByUsername(username);

                    Session["admin_id"] = admin_id;
                }
            }                
        }

        private void binddata()
        {
            try
            {
                if (Request.QueryString["clientname"] != null &&
                           Request.QueryString["company_name"] != null &&
                           Request.QueryString["email"] != null &&
                           Request.QueryString["product_name"] != null)
                {
                    string clientname = Server.UrlDecode(Request.QueryString["clientname"]);
                    string company_name = Server.UrlDecode(Request.QueryString["company_name"]);
                    string email = Server.UrlDecode(Request.QueryString["email"]);
                    string product_name = Server.UrlDecode(Request.QueryString["product_name"]);
                    txtname.Text = clientname;
                    txtclientname.Text = clientname;
                    txtcomapnyname.Text = company_name;
                    Txtemail.Text = email;
                    txtproductname.Text = product_name;
                    string connectionString = ConfigurationManager.ConnectionStrings["crm_con"].ToString();
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Use the stored procedure instead of a direct SQL query
                        SqlCommand cmd = new SqlCommand("getClientDetails", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        long clientId = GetClientIdByEmail(email);
                        Session["client_id"] = client_id;
                        // Pass the email parameter to the stored procedure
                        cmd.Parameters.AddWithValue("@client_id", client_id);

                        // Use a SqlDataReader to read the results from the stored procedure
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Txtcontact1.Text = reader["contact1"].ToString();
                                Txtcontact2.Text = reader["contact2"].ToString();
                                Txtcity.Text = reader["city"].ToString();
                                Txtstate.Text = reader["state"].ToString();
                                Txtcountry.Text = reader["country"].ToString();
                                Txtexpirydate.Text = Convert.ToDateTime(reader["expiry_date"]).ToShortDateString();
                                Txtissuedate.Text = Convert.ToDateTime(reader["issue_date"]).ToShortDateString();
                                Txtproductcode.Text = reader["product_code"].ToString();
                                Txtwebsite.Text = reader["website"].ToString();
                                Txtzip.Text = reader["zip_code"].ToString();
                                Txtusername.Text = reader["client_username"].ToString();
                                Txtpassword.Text = reader["client_password"].ToString();

                            }
                        }
                        conn.Close();
                    }

                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void bindProductdropdown()
        {
            string query = "SELECT product_name FROM product WHERE is_deleted = 0";
            SqlCommand command = new SqlCommand(query, con);
            Ddlproductname.Items.Clear();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            Ddlproductname.Items.Add(new ListItem("Select", ""));

            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    string productName = reader["product_name"].ToString();
                    Ddlproductname.Items.Add(new ListItem(productName, productName));
                    Ddlproductname.AppendDataBoundItems = true;
                }
            }
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        private long GetAdminIdByUsername(string username)
        {
            long admin_id = 0; // Default value if no match is found

            con.Open();

            string query = "SELECT admin_id FROM Admin_login WHERE admin_username = @username";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@username", username);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Use GetInt64 for bigint type
                        admin_id = reader.GetInt64(0);
                    }
                }
            }

            return admin_id;

        }

        private long GetClientIdByEmail(string email)
        {

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }



            string query = "SELECT client_id FROM client WHERE email = @email";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@email", email);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        client_id = reader.GetInt64(0);
                    }
                }
            }

            return client_id;

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

        //in following code 
        protected void btnupdate_Click(object sender, EventArgs e)
        {

            try
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("updateClientDetails", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (int.TryParse(Txtproductcode.Text, out int productCode))
                    {
                        cmd.Parameters.AddWithValue("@product_code", productCode);
                    }
                    else
                    {
                        Console.WriteLine("Invalid product code entered");
                        return;
                    }
                    if (long.TryParse(Txtcontact1.Text, out long contact1))
                    {
                        cmd.Parameters.AddWithValue("@contact1", contact1);
                    }
                    else
                    {
                        Console.WriteLine("Invalid contact1 entered");
                        return;
                    }
                    if (long.TryParse(Txtcontact2.Text, out long contact2))
                    {
                        cmd.Parameters.AddWithValue("@contact2", contact2);
                    }
                    else
                    {
                        Console.WriteLine("Invalid contact2 entered");
                        return;
                    }
                    if (DateTime.TryParse(Txtissuedate.Text, out DateTime issueDate))
                    {
                        cmd.Parameters.AddWithValue("@issue_date", issueDate);
                    }
                    else
                    {
                        Console.WriteLine("Invalid issue date entered");
                        return;
                    }
                    if (DateTime.TryParse(Txtexpirydate.Text, out DateTime expiryDate))
                    {
                        cmd.Parameters.AddWithValue("@expiry_date", expiryDate);
                    }
                    else
                    {
                        Console.WriteLine("Invalid expiry date entered");
                        return;
                    }

                    cmd.Parameters.AddWithValue("@client_id", Session["client_id"]);
                    cmd.Parameters.AddWithValue("@client_username", Txtusername.Text);
                    cmd.Parameters.AddWithValue("@company_name", txtcomapnyname.Text);
                    cmd.Parameters.AddWithValue("@clientname", txtclientname.Text);
                    cmd.Parameters.AddWithValue("@email", Txtemail.Text);
                    cmd.Parameters.AddWithValue("@city", Txtcity.Text);
                    cmd.Parameters.AddWithValue("@state", Txtstate.Text);
                    cmd.Parameters.AddWithValue("@zip_code", Txtzip.Text);
                    cmd.Parameters.AddWithValue("@website", Txtwebsite.Text);
                    cmd.Parameters.AddWithValue("@country", Txtcountry.Text);
                    cmd.Parameters.AddWithValue("@product_name", txtproductname.Text);
                    cmd.Parameters.AddWithValue("@updated_date", DateTime.Now);
                    cmd.Parameters.AddWithValue("@updated_by", Session["username"]);

                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Client update successfull...'); setTimeout(function(){ window.location.href = 'manage-client.aspx'; });", true);

                }
                con.Close();
            }

            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }

        }


        //Cancel button of add new product
        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("manage-client.aspx");
        }

        //Submit button of add new product
        protected void Button1_Click(object sender, EventArgs e)
        {

            int productId = 0;
            string query = "SELECT [product_id] FROM [product] WHERE [product_name] = @productName";
            using (SqlCommand command = new SqlCommand(query, con))
            {
                command.Parameters.AddWithValue("@productName", Ddlproductname.SelectedValue);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                object result = command.ExecuteScalar();
                if (result != null)
                {
                    productId = Convert.ToInt32(result);
                }
            }

            string query1 = "INSERT INTO [multi_product] ([client_id], [product_id],product_name, [issue_date], [expiry_date],is_delete) VALUES (@client_id, @productId,@product_name, @issueDate, @expiryDate,@is_delete)";
            using (SqlCommand command = new SqlCommand(query1, con))
            {
                command.Parameters.AddWithValue("@client_id",Session["client_id"]);
                command.Parameters.AddWithValue("@productId", productId);
                command.Parameters.AddWithValue("@product_name", Ddlproductname.SelectedValue);
                command.Parameters.AddWithValue("@issueDate", txtissue.Text);
                command.Parameters.AddWithValue("@expiryDate", txtexpiry.Text);
                command.Parameters.AddWithValue("@is_delete", 0);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
              int i=  command.ExecuteNonQuery();
                if( i > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Product Added successfully...'); setTimeout(function(){ window.location.href = 'manage-client.aspx'; });", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Product Added Failed...');", true);

                }
            }

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
}

