using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Xml.Linq;
using System.Drawing;
using System.Drawing.Imaging;

namespace goGst
{
    public partial class Client_NewProduct : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductDetails();
            }
        }

        //to show products image
        protected void BindProductDetails()
        {
            string query = "SELECT [product_id], [product_name],[description],[specification], [image1],[image2],[image3],[image4] FROM [product] where is_deleted=0";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        CarouselRepeater.DataSource = reader;
                        CarouselRepeater.DataBind();
                    }
                }
            }
        }
        protected void CarouselRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                if (drv != null)
                {
                    System.Web.UI.WebControls.Image image1 = e.Item.FindControl("image1") as System.Web.UI.WebControls.Image;
                    System.Web.UI.WebControls.Image image2 = e.Item.FindControl("image2") as System.Web.UI.WebControls.Image;
                    System.Web.UI.WebControls.Image image3 = e.Item.FindControl("image3") as System.Web.UI.WebControls.Image;
                    System.Web.UI.WebControls.Image image4 = e.Item.FindControl("image4") as System.Web.UI.WebControls.Image;

                    if (drv["image1"] != DBNull.Value)
                    {
                        byte[] image1Data = (byte[])drv["image1"];
                        image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(image1Data);
                    }
                    if (drv["image2"] != DBNull.Value)
                    {
                        byte[] image2Data = (byte[])drv["image2"];
                        image2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(image2Data);
                    }
                    if (drv["image3"] != DBNull.Value)
                    {
                        byte[] image3Data = (byte[])drv["image3"];
                        image3.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(image3Data);
                    }
                    if (drv["image4"] != DBNull.Value)
                    {
                        byte[] image4Data = (byte[])drv["image4"];
                        image4.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(image4Data);
                    }
                }
            }
        }

        private string GetLocalIpAddress()
        {
            string localIpAddress = "";

            try
            {
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
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return localIpAddress;
        }

        //Request Product and save product and client info to product_alert table
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int clientId = Convert.ToInt32(Session["ClientID"]);
            LinkButton btnUpdate = (LinkButton)sender;
            int productId = Convert.ToInt32(btnUpdate.CommandArgument);
            string clientQuery = "SELECT clientname, contact1, contact2, email FROM client WHERE client_id = @ClientId";
            string productQuery = "SELECT product_name, product_code FROM product WHERE product_id = @ProductId";

            string clientName = "";
            string contact1 = "";
            string contact2 = "";
            string email = "";
            string productName = "";
            string productCode = "";
            string status = "Pending";
            string latitude = Request.Form["latitude"];
            string longitude = Request.Form["longitude"];

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            //client details
            using (SqlCommand cmd = new SqlCommand(clientQuery, con))
            {
                cmd.Parameters.AddWithValue("@ClientId", clientId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    clientName = reader["clientname"].ToString();
                    contact1 = reader["contact1"].ToString();
                    contact2 = reader["contact2"].ToString();
                    email = reader["email"].ToString();
                }
                reader.Close();
            }

            // product details
            using (SqlCommand cmd = new SqlCommand(productQuery, con))
            {
                cmd.Parameters.AddWithValue("@ProductId", productId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    productName = reader["product_name"].ToString();
                    productCode = reader["product_code"].ToString();
                }
                reader.Close();
            }
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            string insertQuery = "INSERT INTO product_alert (client_id, product_id, product_name, product_code, clientname, contact1, contact2, email,created_date, created_by, user_time, ip_address, pc_name,latitude,longitude,status) " +
                                 "VALUES (@ClientId, @ProductId, @ProductName, @ProductCode, @ClientName, @Contact1, @Contact2, @Email, @created_date, @created_by, @user_time, @ip_address, @pc_name,@latitude,@longitude,@status)";

            using (SqlCommand cmd = new SqlCommand(insertQuery, con))
            {
                cmd.Parameters.AddWithValue("@ClientId", clientId);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@ProductCode", productCode);
                cmd.Parameters.AddWithValue("@ClientName", clientName);
                cmd.Parameters.AddWithValue("@Contact1", contact1);
                cmd.Parameters.AddWithValue("@Contact2", contact2);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@status", status);

                //Script
                cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                cmd.Parameters.AddWithValue("@latitude", latitude);
                cmd.Parameters.AddWithValue("@longitude", longitude);
                cmd.Parameters.AddWithValue("@created_by", Session["username"]);
                cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                cmd.Parameters.AddWithValue("@user_time", DateTime.Now);
              

                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int i = cmd.ExecuteNonQuery();

                if (i > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Product Request Sent!')", true);
                    btnUpdate.Visible = false;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Error')", true);
                }
            }
        }
    }
}