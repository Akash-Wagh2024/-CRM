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
    public partial class Client_MyProduct : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string clientID = Session["ClientID"].ToString();
                BindProductDetails();
            }
        }
        //to show products image
        protected void BindProductDetails()
        {
            string clientID = Session["ClientID"].ToString();
            string query = @"
                        SELECT p.[product_name], p.[description], p.[specification], p.[image1], p.[image2], p.[image3], p.[image4], mp.issue_date, mp.expiry_date
                        FROM [product] p
                        INNER JOIN [multi_product] mp ON p.[product_id] = mp.[product_id]
                        WHERE p.[is_deleted] = 0 AND mp.[client_id] = @clientID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@clientID", clientID);
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
    }
}