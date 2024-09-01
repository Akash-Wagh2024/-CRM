using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Addnewclient : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        long admin_id = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    string username = Session["username"].ToString();
                    admin_id = GetAdminIdByUsername(username); // Update the class-level variable

                    Session["admin_id"] = admin_id;
                }

                // Check if the request is for an Enquiry or a Lead
                string enquiryId = Request.QueryString["enquiry_id"];
                string leadId = Request.QueryString["lead_id"];

                if (!string.IsNullOrEmpty(enquiryId))
                {
                    FetchEnquiryDetails(enquiryId);
                }
                else if (!string.IsNullOrEmpty(leadId))
                {
                    FetchLeadDetails(leadId);
                }
            }
        }

        private int GetAdminIdByUsername(string username)
        {
            long admin_id = 0;

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            string query = "SELECT admin_id FROM Admin_login WHERE admin_username = @username";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@username", username);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        admin_id = reader.GetInt64(0);
                    }
                }
            }

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            return (int)admin_id;
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

        // Fetch details for Enquiry
        private void FetchEnquiryDetails(string enquiryId)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT full_name, product_name, email, company_name, whatsapp_no FROM [enquiry] WHERE enquiry_id = @enquiry_id AND is_delete=0", conn);
                cmd.Parameters.AddWithValue("@enquiry_id", enquiryId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtclientname.Text = reader["full_name"].ToString();
                        TextBox1.Text = reader["product_name"].ToString();
                        Txtemail.Text = reader["email"].ToString();
                        txtcomapnyname.Text = reader["company_name"].ToString();
                        Txtcontact2.Text = reader["whatsapp_no"].ToString();

                    }
                }
                //SqlCommand cmd2 = new SqlCommand("select product_code from product where product_name='" + TextBox1.Text + "'");
                //SqlDataReader reader1 = cmd2.ExecuteReader();
                //if (reader1.Read()) 
                //{
                //    Txtproductcode.Text = reader1["product_code"].ToString();
                //}

            }
        }

        // Fetch details for Lead
        private void FetchLeadDetails(string leadId)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT full_name, product_name, email, company_name, whatsapp_no FROM [lead] WHERE lead_id = @lead_id AND is_delete=0", conn);
                cmd.Parameters.AddWithValue("@lead_id", leadId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtclientname.Text = reader["full_name"].ToString();
                        TextBox1.Text = reader["product_name"].ToString();
                        Txtemail.Text = reader["email"].ToString();
                        txtcomapnyname.Text = reader["company_name"].ToString();
                        Txtcontact2.Text = reader["whatsapp_no"].ToString();
                    }
                }
            }
        }


        protected void btnsubmit_Click1(object sender, EventArgs e)
        {
            try
            {
                bool emailExists = CheckEmailExists(Txtemail.Text);

                if (emailExists)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Email already exists.');", true);
                }
                else
                {
                    string enquiry_id = Request.QueryString["enquiry_id"];
                    string lead_id = Request.QueryString["lead_id"];

                    if (!string.IsNullOrEmpty(enquiry_id))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Client Added Succefully...')", true);


                        // Handle Enquiry data
                        string clientname = txtclientname.Text;
                        string company_name = txtcomapnyname.Text;
                        string contact1 = Txtcontact1.Text;
                        string contact2 = Txtcontact2.Text;
                        string email = Txtemail.Text;
                        string website = Txtwebsite.Text;
                        string product_name = TextBox1.Text;
                        string issue_date = Txtissuedate.Text;
                        string expiry_date = Txtexpirydate.Text;
                        string zip_code = Txtzip.Text;
                        string city = Txtcity.Text;
                        string state = Txtstate.Text;
                        string country = Txtcountry.Text;
                        string client_username = Txtusername.Text;
                        string client_password = Txtpassword.Text;

                        int admin_id = Convert.ToInt32(Session["admin_id"]);

                        if (admin_id <= 0)
                        {
                            Response.Write("<script>alert('Invalid admin_id');</script>");
                            return;
                        }

                        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("SP_AddNewClient", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            // Add Enquiry parameters
                            cmd.Parameters.AddWithValue("@operation", "INSERT");
                            cmd.Parameters.AddWithValue("@clientname", clientname);
                            cmd.Parameters.AddWithValue("@company_name", company_name);
                            cmd.Parameters.AddWithValue("@contact1", contact1);
                            cmd.Parameters.AddWithValue("@contact2", contact2);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@website", website);
                            cmd.Parameters.AddWithValue("@product_name", product_name);
                            cmd.Parameters.AddWithValue("@issue_date", issue_date);
                            cmd.Parameters.AddWithValue("@expiry_date", expiry_date);
                            cmd.Parameters.AddWithValue("@city", city);
                            cmd.Parameters.AddWithValue("@state", state);
                            cmd.Parameters.AddWithValue("@zip_code", zip_code);
                            cmd.Parameters.AddWithValue("@country", country);
                            cmd.Parameters.AddWithValue("@client_username", client_username);
                            bool userExists = CheckUsernameExists(client_username);

                            if (userExists)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Username already exists.');", true);
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@client_password", client_password);
                                cmd.Parameters.AddWithValue("@admin_id", admin_id);
                                cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                                cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                                cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]);
                                cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]);
                                cmd.Parameters.AddWithValue("@is_delete", 0);
                                cmd.Parameters.AddWithValue("@created_by", Session["username"]);
                                cmd.Parameters.AddWithValue("@user_time", DateTime.Now);
                                cmd.Parameters.AddWithValue("@updated_by", DBNull.Value);
                                cmd.Parameters.AddWithValue("@deleted_by", DBNull.Value);
                                cmd.Parameters.AddWithValue("@client_id", DBNull.Value);
                                cmd.Parameters.AddWithValue("@created_date", DateTime.Now);

                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Data inserted successfully
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Client added successfully'); setTimeout(function(){ window.location.href = 'manage-client.aspx'; });", true);
                                }
                                else
                                {
                                    // Data insertion failed
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Client insert Faield...'); setTimeout(function(){ window.location.href = 'Admin-enquiry.aspx'; });", true);
                                }


                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error...'); setTimeout(function(){ window.location.href = 'Admin-enquiry.aspx'; });", true);

                            }
                        }
                    }
                    else if (!string.IsNullOrEmpty(lead_id))
                    {
                        // Handle Enquiry data
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Client Added Succefully...')", true);

                        string clientname = txtclientname.Text;
                        string company_name = txtcomapnyname.Text;
                        string contact1 = Txtcontact1.Text;
                        string contact2 = Txtcontact2.Text;
                        string email = Txtemail.Text;
                        string website = Txtwebsite.Text;
                        string product_name = TextBox1.Text;
                        string issue_date = Txtissuedate.Text;
                        string expiry_date = Txtexpirydate.Text;
                        string zip_code = Txtzip.Text;
                        string city = Txtcity.Text;
                        string state = Txtstate.Text;
                        string country = Txtcountry.Text;
                        string client_username = Txtusername.Text;
                        string client_password = Txtpassword.Text;

                        int admin_id = Convert.ToInt32(Session["admin_id"]);

                        if (admin_id <= 0)
                        {
                            Response.Write("<script>alert('Invalid admin_id');</script>");
                            return;
                        }

                        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("SP_AddNewClient", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            // Add Enquiry parameters
                            cmd.Parameters.AddWithValue("@operation", "INSERT");
                            cmd.Parameters.AddWithValue("@clientname", clientname);
                            cmd.Parameters.AddWithValue("@company_name", company_name);
                            cmd.Parameters.AddWithValue("@contact1", contact1);
                            cmd.Parameters.AddWithValue("@contact2", contact2);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@website", website);
                            cmd.Parameters.AddWithValue("@product_name", product_name);
                            cmd.Parameters.AddWithValue("@issue_date", issue_date);
                            cmd.Parameters.AddWithValue("@expiry_date", expiry_date);
                            cmd.Parameters.AddWithValue("@city", city);
                            cmd.Parameters.AddWithValue("@state", state);
                            cmd.Parameters.AddWithValue("@zip_code", zip_code);
                            cmd.Parameters.AddWithValue("@country", country);
                            cmd.Parameters.AddWithValue("@client_username", client_username);
                            bool userExists = CheckUsernameExists(client_username);

                            if (userExists)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Username already exists.');", true);
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@client_password", client_password);
                                cmd.Parameters.AddWithValue("@admin_id", admin_id);
                                cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                                cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                                cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]);
                                cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]);
                                cmd.Parameters.AddWithValue("@is_delete", 0);
                                cmd.Parameters.AddWithValue("@created_by", Session["username"]);
                                cmd.Parameters.AddWithValue("@user_time", DateTime.Now);
                                cmd.Parameters.AddWithValue("@updated_by", DBNull.Value);
                                cmd.Parameters.AddWithValue("@deleted_by", DBNull.Value);
                                cmd.Parameters.AddWithValue("@client_id", DBNull.Value);
                                cmd.Parameters.AddWithValue("@created_date", DateTime.Now);

                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Data inserted successfully
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Client added successfully'); setTimeout(function(){ window.location.href = 'manage-client.aspx'; });", true);
                                }
                                else
                                {
                                    // Data insertion failed
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Client insert Faield...'); setTimeout(function(){ window.location.href = 'Admin-Lead.aspx'; });", true);
                                }
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error...'); setTimeout(function(){ window.location.href = 'Admin-Lead.aspx'; });", true);

                            }
                        }
                    }
                    else
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error...'); setTimeout(function(){ window.location.href = 'manage-client.aspx'; });", true);
                    }
                }
               
            }
            catch (Exception ex)
            {
                // Handle other exceptions
                Response.Write($"Error: {ex.Message}");
            }

        }
        private bool CheckEmailExists(string email)
        {
            bool exists = false;
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM client WHERE email = @email", con);
        
                cmd.Parameters.AddWithValue("@email", email);

                try
                {
                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    exists = count > 0;
                }
                catch (Exception ex)
                {
                    // Handle exceptions, such as logging or displaying an error message
                    // For example:
                    // Response.Write($"Error: {ex.Message}");
                    exists = false; // Indicate that the existence check failed due to an error
                }
            return exists;
        }
        private bool CheckUsernameExists(object username)
        {
            var command = new SqlCommand("spCheckUsernameExists", con);

            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.Add(new SqlParameter("@Username", username));

            var existsParam = new SqlParameter("@Exists", SqlDbType.Bit)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(existsParam);


            command.ExecuteNonQuery();

            return (bool)existsParam.Value;

        }


       
        protected void button2_Click(object sender, EventArgs e)
        {
            string enquiry_id = Request.QueryString["enquiry_id"];
            string lead_id = Request.QueryString["lead_id"];

            if (!string.IsNullOrEmpty(enquiry_id))
            {
                // If it was an Enquiry, redirect to the Enquiry page
                Response.Redirect("Admin-enquiry.aspx");
            }
            else if (!string.IsNullOrEmpty(lead_id))
            {
                // If it was a Lead, redirect to the Lead page
                Response.Redirect("Admin-Lead.aspx");
            }
            else
            {
                // Handle the case when neither enquiry_id nor lead_id is provided
                // You can add appropriate handling or display an error message here
            }
        }

    }
}