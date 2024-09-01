using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace goGst
{
    public partial class enquiry_profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {


                if (!IsPostBack)
                {
                    // Check if the enquiry_id is passed through query string
                    if (Request.QueryString["id"] != null)
                    {
                        int enquiry_id = Convert.ToInt32(Request.QueryString["id"]);
                        PopulateEnquiryDetails(enquiry_id);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void PopulateEnquiryDetails(int enquiry_id)
        {
            try
            {


                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("SELECT full_name, email, whatsapp_no, contact, product_name, company_name, source, status, city, description FROM [enquiry] WHERE enquiry_id = @enquiry_id AND is_delete=0", conn);
                    cmd.Parameters.AddWithValue("@enquiry_id", enquiry_id);
                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtUserName.Text = reader["full_name"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                        txtWhatsapp.Text = reader["whatsapp_no"].ToString();
                        txtContact.Text = reader["contact"].ToString();
                        TxtProductName.Text = reader["product_name"].ToString();
                        txtOrganizationName.Text = reader["company_name"].ToString();
                        TextBox1.Text = reader["source"].ToString();
                        // Assuming ddlStatus is the ID of your DropDownList for status
                        DropDownList1.SelectedValue = reader["status"].ToString();
                        txtCity.Text = reader["city"].ToString();
                        txtDescription.Text = reader["description"].ToString();
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        protected void txtsave_Click(object sender, EventArgs e)
        {
            try
            {


                // Update the database with the modified data
                UpdateEnquiryDetails();

                // Refresh both the marketing-enquiry gridview and admin-enquiry gridview

            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }

        }

        private void UpdateEnquiryDetails()
        {
            try
            {

                long enquiry_id = Convert.ToInt32(Request.QueryString["id"]);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE [enquiry] SET full_name = @full_name, email = @email, whatsapp_no = @whatsapp_no, contact = @contact, product_name = @product_name, company_name = @company_name, source = @source, status = @status, city = @city, description = @description WHERE enquiry_id = @enquiry_id", conn);

                    cmd.Parameters.AddWithValue("@enquiry_id", enquiry_id);
                    cmd.Parameters.AddWithValue("@full_name", txtUserName.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@whatsapp_no", txtWhatsapp.Text);
                    cmd.Parameters.AddWithValue("@contact", txtContact.Text);
                    cmd.Parameters.AddWithValue("@product_name", TxtProductName.Text);
                    cmd.Parameters.AddWithValue("@company_name", txtOrganizationName.Text);
                    cmd.Parameters.AddWithValue("@source", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@status", DropDownList1.SelectedValue);
                    cmd.Parameters.AddWithValue("@city", txtCity.Text);
                    cmd.Parameters.AddWithValue("@description", txtDescription.Text);
                    //cmd.Parameters.AddWithValue("@description", txtDescription.Text);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected != 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Enquiry Updated Successfully..'); setTimeout(function(){ window.location.href = 'marketing-enquiry.aspx'; });", true);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Enquiry Updated Failed..'); setTimeout(function(){ window.location.href = 'marketing-enquiry.aspx'; });", true);

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