using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.HtmlControls;


namespace goGst
{
    public partial class Ticket : System.Web.UI.Page
    {
         SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        long clientIDValue;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Session["username"] != null && Session["ClientID"] != null)
                    {
                        string username = Session["username"].ToString();
                        string clientId = Session["ClientID"].ToString();
                        txtusername.Text = username;

                        if (long.TryParse(clientId, out clientIDValue))
                        {
                            PopulateProductDropdown1();
                            BindGridView();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }

        }
        private void BindGridView()
        {
            try
            {
                SqlDataSource1.DataBind();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        //For  Serial Number of Grid View
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {


                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    int rowIndex = e.Row.RowIndex + 1;

                    Label lblSerialNumber = e.Row.FindControl("lblSerialNumber") as Label;

                    if (lblSerialNumber != null)
                    {

                        lblSerialNumber.Text = rowIndex.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void PopulateProductDropdown1()
        {
            try
            {
                txtproductname.Items.Add(new ListItem("Select", ""));

                string clientId = Session["ClientID"].ToString();

                using (SqlCommand cmd = new SqlCommand("SELECT product.product_id, product.product_name FROM product INNER JOIN multi_product ON product.product_id = multi_product.product_id WHERE multi_product.client_id = @clientId and multi_product.is_delete=0", con))
                {
                    // Add the clientId parameter to the SqlCommand
                    cmd.Parameters.AddWithValue("@clientId", clientId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ListItem item = new ListItem();
                            item.Text = reader["product_name"].ToString();
                            item.Value = reader["product_id"].ToString();
                            txtproductname.Items.Add(item);
                            txtproductname.AppendDataBoundItems = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
            finally
            {
                con.Close();
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


       
        protected HtmlInputFile fileUpload;
        protected void ticketraise_Click(object sender, EventArgs e)
        {
            try
            {

                string latitude = Request.Form["latitude"];
                string longitude = Request.Form["longitude"];

               
                string product_name = txtproductname.SelectedValue;
                string issue = Txtissues.Text;
                string description = Txtdescription.Text;
                string selectedProductId = txtproductname.SelectedValue;
                string clientId = Session["ClientID"].ToString();

                //using (SqlCommand cmd = new SqlCommand("INSERT INTO ticket (image) VALUES (@image)", con))
                //{
                //    cmd.Parameters.AddWithValue("@image", fileUpload);

                //    try
                //    {
                //        con.Open();
                //        cmd.ExecuteNonQuery();
                //    }
                //    catch (Exception ex)
                //    {
                //    }
                //    finally
                //    {
                //        con.Close();
                //    }
                //}


                SqlCommand co = new SqlCommand("ManageTicket", con);
                co.CommandType = CommandType.StoredProcedure;
                con.Open();

                co.Parameters.AddWithValue("@operation", "INSERT");
                // co.Parameters.AddWithValue("@product_name", product_name);
                co.Parameters.AddWithValue("@issue", issue);
                co.Parameters.AddWithValue("@description", description);
                co.Parameters.AddWithValue("@product_id", selectedProductId);
                co.Parameters.AddWithValue("@client_id", clientId);
                co.Parameters.AddWithValue("@status", "Pending");
                // co.Parameters.Add("@image", SqlDbType.VarBinary, -1).Value = (object)image ?? DBNull.Value;
                //Script
                co.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                co.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                co.Parameters.AddWithValue("@latitude", latitude);
                co.Parameters.AddWithValue("@longitude", longitude);
                co.Parameters.AddWithValue("@is_delete", 0);
                co.Parameters.AddWithValue("@created_by", Session["username"]);
                co.Parameters.AddWithValue("@user_time", DateTime.Now);
                co.Parameters.AddWithValue("@updated_by", DBNull.Value);

                co.ExecuteNonQuery();

                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Issue Send Succefully...'); setTimeout(function(){ window.location.href = 'Client-Ticket.aspx'; });", true);
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }


        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {

                int rowIndex = e.RowIndex;
                int ticket_id = Convert.ToInt32(GridView1.DataKeys[rowIndex].Values["ticket_id"]);
                string clientId = Session["ClientID"].ToString();

                con.Open();

                // Perform your update or soft delete operation here
                string querySoftDelete = "UPDATE ticket SET is_delete = 1 WHERE ticket_id = @ticket_id AND client_id = @client_id";
                SqlCommand cmdSoftDelete = new SqlCommand(querySoftDelete, con);

                cmdSoftDelete.Parameters.AddWithValue("@ticket_id", ticket_id);
                cmdSoftDelete.Parameters.AddWithValue("@client_id", clientId);

                int rowsAffected = cmdSoftDelete.ExecuteNonQuery();

                con.Close();

                // Refresh the GridView or perform any other necessary actions
                BindGridView();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        protected void txtproductname_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Session["SelectedProductID"] = txtproductname.SelectedValue;
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }
    }
}