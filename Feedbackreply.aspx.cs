using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Reflection.Emit;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace goGst
{

    public partial class FeedbackReply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    if (!string.IsNullOrEmpty(Request.QueryString["feedback_id"]))
                    {
                        string feedbackId = Request.QueryString["feedback_id"];


                        FetchFeedbackDetails(feedbackId);
                    }


                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }


       
        private void FetchFeedbackDetails(string feedbackId)
        {
            try
            {


                string connectionString = ConfigurationManager.ConnectionStrings["crm_con"].ToString();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT f.feedback_id, f.rating, f.comment, f.description, c.client_username FROM feedback f INNER JOIN client c ON f.client_id = c.client_id WHERE f.feedback_id = @feedback_id AND f.is_delete=0", conn);
                    cmd.Parameters.AddWithValue("@feedback_id", feedbackId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Label1.Text = reader["feedback_id"].ToString();
                            txtUserName.Text = reader["client_username"].ToString();
                            txtRating.Text = reader["rating"].ToString();
                            txtIssue.Text = reader["comment"].ToString();
                            txtDescription.Text = reader["description"].ToString();

                        }
                    }

                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
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
        protected void btnReplay_Click1(object sender, EventArgs e)
        {
            try
            {


                if (Session["username"] != null && Session["AdminID"] != null)
                {
                    string username = Session["username"].ToString();
                    string admin_id = Session["AdminID"].ToString();

                    if (!string.IsNullOrEmpty(Request.QueryString["feedback_id"]))
                    {
                        string feedbackId = Request.QueryString["feedback_id"];
                        string admin_reply = txtReplay.Text;
                        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
                        SqlCommand cmd = new SqlCommand("ManageFeedback", conn);
                        conn.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@operation", "REPLY");
                        cmd.Parameters.AddWithValue("@admin_reply", admin_reply);
                        cmd.Parameters.AddWithValue("@feedback_id", feedbackId);
                        cmd.Parameters.AddWithValue("@admin_id", admin_id);

                        //script
                        cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                        cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                        
                        cmd.Parameters.AddWithValue("@updated_date", DateTime.Now);

                        cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]);
                        cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]);
                        cmd.Parameters.AddWithValue("@is_delete", 0);

                        cmd.Parameters.AddWithValue("@user_time", DateTime.Now);
                        cmd.Parameters.AddWithValue("@updated_by", Session["username"]);
                        int i = cmd.ExecuteNonQuery();

                        if (i < 0)
                        {
                            Response.Write("<script>alert('Admin reply added successfully.'); window.location='Admin-Feedback.aspx';</script>");
                            //Response.Redirect("Admin-Feedback.aspx");
                        }
                        else
                        {
                            Response.Write("<script>alert('Failed to add admin reply.');</script>");
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
