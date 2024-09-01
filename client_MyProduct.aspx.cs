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
    public partial class client_MyProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Filldata();
            }

            if (Session["username"] != null)
            {
                string username = Session["username"].ToString();
                long client_id = GetClientdIDByUsername(username);
                Session["client_id"] = client_id;
            }
        }

        private void Filldata()
        {
            int client_id = Convert.ToInt32(Session["client_id"]);
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
            SqlDataAdapter da = new SqlDataAdapter("select product_name, issue_date, expiry_date from multi_product where client_id = @client_id", con);
            da.SelectCommand.Parameters.AddWithValue("@client_id", client_id); // Add this line
            DataSet ds = new DataSet();
            da.Fill(ds, "client");
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        private long GetClientdIDByUsername(string username)
        {
            int client_id = Convert.ToInt32(Session["client_id"]);
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string query = "SELECT client_id FROM client WHERE client_username = @username";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        client_id = Convert.ToInt32(result);
                    }
                }
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
            }
            return client_id;

        }

    }
}