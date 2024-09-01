using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Admin_Product_AlertReply : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        int clientId = 0;
        int productId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            if (Request.QueryString["alert_id"] != null)
            {
                string alert_id = Server.UrlDecode(Request.QueryString["alert_id"]);
                conn.Open();
                SqlCommand cmd = new SqlCommand("select * from product_alert where alert_id = @alert_id", conn);
                cmd.Parameters.AddWithValue("@alert_id", alert_id);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    clientId = Convert.ToInt32(reader["client_id"]);
                    productId = Convert.ToInt32(reader["product_id"]);
                    txtclientname.Text = reader["clientname"].ToString();
                    txtemail.Text = reader["email"].ToString();
                    Txtcontact1.Text = reader["contact1"].ToString();
                    Txtcontact2.Text = reader["contact2"].ToString();
                    txtproductname.Text = reader["product_name"].ToString();
                    txtproductcode.Text = reader["product_code"].ToString();
                    txtname.Text = reader["clientname"].ToString();
                    txtProdName.Text = reader["product_name"].ToString();
                }
                conn.Close();
            }
        }


        //UPDATE CLIENT PRODUCT ALERT STATUS
        protected void btnupdate_Click(object sender, EventArgs e)
        {
            updateproductstatus();
        }
        private void updateproductstatus()
        {
            string alert_id = Server.UrlDecode(Request.QueryString["alert_id"]);
            string status = DropDownList2.SelectedValue;
            conn.Open();
            SqlCommand cmd = new SqlCommand("update product_alert set status = @status where alert_id = @alert_id", conn);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@alert_id", alert_id);
            int i = cmd.ExecuteNonQuery();
            conn.Close();
            if (i > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Status Updated...'); setTimeout(function(){ window.location.href = 'Admin_Product_ALert.aspx'; }); ", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error...');", true);
            }
        }

        //ADD CLIENT a PRODUCT
        protected void Button1_Click(object sender, EventArgs e)
        {
            updateproductstatus();
            BindData();
            string query = "INSERT INTO [multi_product] ([client_id], [product_id], product_name, [issue_date], [expiry_date], is_delete) VALUES (@client_id, @product_id, @product_name, @issueDate, @expiryDate, @is_delete)";
            using (SqlCommand command = new SqlCommand(query, conn))
            {
                command.Parameters.AddWithValue("@client_id", clientId);
                command.Parameters.AddWithValue("@product_id", productId);
                command.Parameters.AddWithValue("@product_name", txtProdName.Text);
                command.Parameters.AddWithValue("@issueDate", txtissue.Text);
                command.Parameters.AddWithValue("@expiryDate", txtexpiry.Text);
                command.Parameters.AddWithValue("@is_delete", 0);
                conn.Open();
                int i = command.ExecuteNonQuery();
                conn.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessScript", "alert('Product Added successfully...'); setTimeout(function(){ window.location.href = 'manage-client.aspx'; });", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessScript", "alert('Product Added Failed...');", true);
                }
            }
        }

    }
}