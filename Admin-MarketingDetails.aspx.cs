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
    public partial class Admin_MarketingDetails : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        SqlCommand cmd = new SqlCommand();
        long admin_id = 0;
        long marketing_id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Session["username"] != null)
                    {
                        string username = Session["username"].ToString();
                        long admin_id = GetAdminIdByUsername(username);

                        Session["admin_id"] = admin_id;
                    }
                    if (Request.QueryString["employee_id"] != null &&
                        Request.QueryString["name"] != null &&
                        Request.QueryString["email"] != null &&
                        Request.QueryString["contact1"] != null)
                    {
                        string employee_id = Server.UrlDecode(Request.QueryString["employee_id"]);
                        string name = Server.UrlDecode(Request.QueryString["name"]);
                        string email = Server.UrlDecode(Request.QueryString["email"]);
                        string contact1 = Server.UrlDecode(Request.QueryString["contact1"]);

                        txtempid.Text = employee_id;
                        txtName.Text = name;
                        txtemail.Text = email;
                        txtWhatsappNo.Text = contact1;
                        string connectionString = ConfigurationManager.ConnectionStrings["crm_con"].ToString();
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();
                            SqlCommand cmd = new SqlCommand("SELECT email,contact1,address, DOB, contact2, designation, date_of_joining, gender, marketing_username, marketing_password FROM marketing WHERE employee_id = @employee_id", conn);
                            cmd.Parameters.AddWithValue("@employee_id", employee_id);

                            SqlDataReader reader = cmd.ExecuteReader();

                            if (reader.Read())
                            {
                                txtemail.Text = reader["email"].ToString();
                                txtWhatsappNo.Text = reader["contact1"].ToString();

                                txtaddress.Text = reader["address"].ToString();
                                txtContactNo.Text = reader["contact2"].ToString();
                                txtDesignation.Text = reader["designation"].ToString();
                                txtDOJ.Text = Convert.ToDateTime(reader["date_of_joining"]).ToShortDateString();
                                Txtdob.Text = Convert.ToDateTime(reader["DOB"]).ToShortDateString();
                                txtgender.Text = reader["gender"].ToString();
                                Txtusername.Text = reader["marketing_username"].ToString();
                                Txtpassword.Text = reader["marketing_password"].ToString();

                                marketing_id = GetMarketingIdByEmployeeId(employee_id);
                                Session["MarketingId"] = marketing_id;
                            }

                            reader.Close();
                            conn.Close();
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }

        }
        private long GetMarketingIdByEmployeeId(string employee_id)
        {
            // long marketing_id = 0;
            
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                string query = "SELECT marketing_id FROM marketing WHERE employee_id = @employee_id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@employee_id", employee_id);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            marketing_id = reader.GetInt64(0);
                        }
                    }
                }

                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }

                return marketing_id;
            
           
        }

        private long GetAdminIdByUsername(string username)
        {
           
                long admin_id = 0; // Default value if no match is found

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                string query = "SELECT admin_id FROM Admin_login WHERE admin_username = @username";

                using (SqlCommand cmd = new SqlCommand(query, conn))
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
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }

                return admin_id;

            
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

        protected void btnupdate_Click1(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
                {
                    string selectedText = myDropDownList.SelectedItem.Text.ToString();
                    long marketing_id = GetMarketingIdByEmployeeId(txtempid.Text);
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("ManageMarketing", conn))
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Operation", "UPDATE");
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                        cmd.Parameters.AddWithValue("@temp_active", selectedText);
                        cmd.Parameters.AddWithValue("@Email", txtemail.Text);
                        cmd.Parameters.AddWithValue("@Contact1", txtWhatsappNo.Text);

                        cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text);

                        cmd.Parameters.AddWithValue("@marketing_username", Txtusername.Text);




                        // Script parameters
                        cmd.Parameters.AddWithValue("@IpAddress", GetLocalIpAddress());
                        cmd.Parameters.AddWithValue("@PcName", Environment.MachineName);
                        cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]);
                        cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]);
                        cmd.Parameters.AddWithValue("@is_active", 0);
                        cmd.Parameters.AddWithValue("@UpdatedBy", Session["username"]);
                        cmd.Parameters.AddWithValue("@updated_date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@UserTime", DBNull.Value);

                        long admin_id = Convert.ToInt64(Session["admin_id"]);
                        cmd.Parameters.AddWithValue("@admin_id", admin_id);

                        cmd.Parameters.AddWithValue("@employee_id", txtempid.Text);

                        // Add marketing_id parameter
                        cmd.Parameters.AddWithValue("@marketing_id", marketing_id);


                        int i = cmd.ExecuteNonQuery();

                        if (i != 1)
                        {
                            //Response.Write("<script>alert('Marketing Employee Update successful');</script>");

                            ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Marketing Employee Update Succefully...'); setTimeout(function(){ window.location.href = 'Manage-Marketing.aspx'; });", true);
                            DataBind();
                            //Response.Redirect("Manage-Marketing.aspx");

                        }
                        else
                        {
                            Response.Write("<script>alert('Marketing Employee Update Failed..');</script>");
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